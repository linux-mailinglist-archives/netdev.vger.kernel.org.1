Return-Path: <netdev+bounces-178715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E12A78602
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 03:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E53A1892D63
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0221B7F4;
	Wed,  2 Apr 2025 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsGQIvNd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E019BBA
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555785; cv=none; b=KfGaNCq0je5ezxmMOXeedtRdrCGU2mjV4L6OxFqJD8uDQ3xjqMDSoxQ30Q1mmvnQZvGeesRk4wEW7yYv98nCjHKT0BuHXSJIaJQS0/ZWcC/gvz61ZmxXhLwbUVjDtH5TbJl2iHNbWsOeUlIR0qEfc3iRFWqpxl9D+k/HM9Tmr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555785; c=relaxed/simple;
	bh=AVvuLyhr6OWilSvDp2DBRVh8lVQOmLr6PAHBBPrDV/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lafQlWHHL6CqExW/cirZOZvfu8iZsYKxMllQIcGUJHRthucgQ4SlTd1+ZLGOB77ys/IlyzMTN/DLpWgZv8Y4GrJZ0WGpAtgI3pdh6SF1iAlAAnJtdekiSQHD+uTaZULFNN/7D5VIUK7+u2O8IPwIoagOi1+iDqiacfz01FeGjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsGQIvNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BCCC4CEEE;
	Wed,  2 Apr 2025 01:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555785;
	bh=AVvuLyhr6OWilSvDp2DBRVh8lVQOmLr6PAHBBPrDV/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsGQIvNdeEJZEpv2XqqZRIuVHHDIbJvx71U6gRQjDaNNssY4Teo7jqbtcBJl/PxpK
	 Dzy3zlL9p3/9mAXF6uk6CX+/y9SfktB70SmieQR6SiZa8EzEvLMDDkPjMMLQWrSUy0
	 35HTjaCQmc9iabksb5lT77tdUiwBjTLgjiiDIVAUpkGRK/CQIBr7lom2Nuxy2NKRSH
	 iTohY8mOb8zTKBXEmhIE4Zw3KRnijltEZHRkBIw06vVEKWDaUb7vHIW8TMzKXZvLM+
	 1wniLkTYRM2JbbQ9/V/PaEYn5UvhJjYL63plTJtCQCgCEsQtiXrGn5Lv8Tkxndy6me
	 029HE75DnZ+QQ==
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
Subject: [PATCH net v2 3/3] netlink: specs: rt_addr: pull the ifa- prefix out of the names
Date: Tue,  1 Apr 2025 18:03:00 -0700
Message-ID: <20250402010300.2399363-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402010300.2399363-1-kuba@kernel.org>
References: <20250402010300.2399363-1-kuba@kernel.org>
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
 Documentation/netlink/specs/rt_addr.yaml | 41 ++++++++++++------------
 tools/testing/selftests/net/rtnetlink.py |  2 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
index 1650dc3f091a..d032562d1240 100644
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
-        struct: ifa-cacheinfo
+        struct: cacheinfo
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
index 80950888800b..cadd7bc69241 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -15,7 +15,7 @@ IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
     addresses = rtnl.getmaddrs({"ifa-family": socket.AF_INET}, dump=True)
 
     all_host_multicasts = [
-        addr for addr in addresses if addr['ifa-multicast'] == IPV4_ALL_HOSTS_MULTICAST
+        addr for addr in addresses if addr['multicast'] == IPV4_ALL_HOSTS_MULTICAST
     ]
 
     ksft_ge(len(all_host_multicasts), 1,
-- 
2.49.0


