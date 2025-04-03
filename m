Return-Path: <netdev+bounces-178952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E7A799C4
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9013A38B8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2B155A21;
	Thu,  3 Apr 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPDxvq8k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B1151985
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644243; cv=none; b=bE73S3PJJYNAaAiIw84I0cthwZNfk+aEF5+UA57Gvh1yaL4Ne8MkmNvLb0l43+CKIWNsHXRTmTglCQ6E56Xlkd39cxao5KkuZSzQ4ZOimxJDwDPuYGwKqh1QcEhV5bak0WRahddFsmtjmdjRl1gUsdrzS1cOjtGISu+8gqGqCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644243; c=relaxed/simple;
	bh=8GdXf5XH0I39LS9C7Dyuouew7AXYrcHfJ8Y9efUw3HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQaOuiNk3xpoqbZqpDlSDROYSc5J+q/87Ko0DZQVxVQT13c4sBe+l1iYCXVOwHrPn5+D/mqhYBJV91yaO4ok2vs+OOBJ4Qs/EtaOxiIZk9Krnv6skErsgCEU8WtZ4ZwyAFNy81gB4tyEN76kuiKcT+yQj8cx9/yT5Q7MOAZbhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPDxvq8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AAFC4CEED;
	Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644243;
	bh=8GdXf5XH0I39LS9C7Dyuouew7AXYrcHfJ8Y9efUw3HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPDxvq8k5UlqjkR/WOrD+B7YVf+EstkF0WDIstsjbaJ94CXnugm8GsGTUZSowSLNI
	 mhpqMcU9WP6bQ3wJs8NdaAXcb55Imhj04Qlpy6UpqYuzO8MRalb/T8scNUH0djd/Xm
	 e46e0weVvmNFum7IDG3blrTBNkyd6rcJYYdzRBGEPd3kkf130SVD9sFBh5otHfcV2W
	 F8Gtr6wDuNp0ZDOocZsQ6ZIKqEfqKtL7GquZ4oDclZ8Kkb6P5VsOLls8k8s62APyni
	 /ZdpkORl2Yl+gnPvkwSbZSgKhdNAGRz/QRf+DdlfD3A+5f0mKSDDHYVejweOweMCl5
	 +SOV+TJuZKrCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 3/4] netlink: specs: rt_addr: pull the ifa- prefix out of the names
Date: Wed,  2 Apr 2025 18:37:05 -0700
Message-ID: <20250403013706.2828322-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403013706.2828322-1-kuba@kernel.org>
References: <20250403013706.2828322-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YAML specs don't normally include the C prefix name in the name
of the YAML attr. Remove the ifa- prefix from all attributes
in addr-attrs and specify name-prefix instead.

This is a bit risky, hopefully there aren't many users out there.

Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - don't remove prefix from the struct name
v2: https://lore.kernel.org/20250402010300.2399363-4-kuba@kernel.org
---
 Documentation/netlink/specs/rt_addr.yaml | 39 ++++++++++++------------
 tools/testing/selftests/net/rtnetlink.py |  2 +-
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
index 1650dc3f091a..df6b23f06a22 100644
--- a/Documentation/netlink/specs/rt_addr.yaml
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -78,45 +78,46 @@ protonum: 0
 attribute-sets:
   -
     name: addr-attrs
+    name-prefix: ifa-
     attributes:
       -
-        name: ifa-address
+        name: address
         type: binary
         display-hint: ipv4
       -
-        name: ifa-local
+        name: local
         type: binary
         display-hint: ipv4
       -
-        name: ifa-label
+        name: label
         type: string
       -
-        name: ifa-broadcast
+        name: broadcast
         type: binary
         display-hint: ipv4
       -
-        name: ifa-anycast
+        name: anycast
         type: binary
       -
-        name: ifa-cacheinfo
+        name: cacheinfo
         type: binary
         struct: ifa-cacheinfo
       -
-        name: ifa-multicast
+        name: multicast
         type: binary
       -
-        name: ifa-flags
+        name: flags
         type: u32
         enum: ifa-flags
         enum-as-flags: true
       -
-        name: ifa-rt-priority
+        name: rt-priority
         type: u32
       -
-        name: ifa-target-netnsid
+        name: target-netnsid
         type: binary
       -
-        name: ifa-proto
+        name: proto
         type: u8
 
 
@@ -137,10 +138,10 @@ protonum: 0
             - ifa-prefixlen
             - ifa-scope
             - ifa-index
-            - ifa-address
-            - ifa-label
-            - ifa-local
-            - ifa-cacheinfo
+            - address
+            - label
+            - local
+            - cacheinfo
     -
       name: deladdr
       doc: Remove address
@@ -154,8 +155,8 @@ protonum: 0
             - ifa-prefixlen
             - ifa-scope
             - ifa-index
-            - ifa-address
-            - ifa-local
+            - address
+            - local
     -
       name: getaddr
       doc: Dump address information.
@@ -182,8 +183,8 @@ protonum: 0
         reply:
           value: 58
           attributes: &mcaddr-attrs
-            - ifa-multicast
-            - ifa-cacheinfo
+            - multicast
+            - cacheinfo
       dump:
         request:
           value: 58
diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 69436415d56e..e9ad5e88da97 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -15,7 +15,7 @@ IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
     addresses = rtnl.getmulticast({"ifa-family": socket.AF_INET}, dump=True)
 
     all_host_multicasts = [
-        addr for addr in addresses if addr['ifa-multicast'] == IPV4_ALL_HOSTS_MULTICAST
+        addr for addr in addresses if addr['multicast'] == IPV4_ALL_HOSTS_MULTICAST
     ]
 
     ksft_ge(len(all_host_multicasts), 1,
-- 
2.49.0


