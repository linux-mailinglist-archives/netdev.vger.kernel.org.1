Return-Path: <netdev+bounces-178953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7BA799C3
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60051188C43D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E4B16F0FE;
	Thu,  3 Apr 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSjgYTfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9001624F4
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644244; cv=none; b=P+Tvg648NlpVzBctKnawiRyCEtETHjGkeEs/1hFqIOzhT7hLSZdiQ1gYIkjtKdR4e2LGMrM+t6Glm3oicA5BcGMJw5JffNxA6ok6F60cZN4S40RBCWNb4GPI9M7OLJteKdsz2kV3QIOKBj7Q5uD/OGkMDBP7UxNUaKBvSq3Mh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644244; c=relaxed/simple;
	bh=4lkbtWQCafKDqoBGuszddW3O5DhmIG1mKt40EKTaqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfnBhD0KCCWfVBrP+i1HIP2Wia9ptbmJCCkb7jCL00sS1+5Xb+TnOspJstMFS4CfOgiCXNH2ojAd6MqF2vGJn7+SIuAdXeYzO9QWc+YJq/2SUxxBFcIRIGPm/0QtEtBFH1YVf9Y6yV1vqA6RHBR19cBynNML4YWpCldQFKinTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSjgYTfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A23C4CEDD;
	Thu,  3 Apr 2025 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644243;
	bh=4lkbtWQCafKDqoBGuszddW3O5DhmIG1mKt40EKTaqRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSjgYTfnNULMYrX5bfoCU9IuT9gq0njNrewN35kFacUVrRsUz3JJkdt98WOHXQJSN
	 i93i1FMkBASCOBgm61myKiFTMoJzMcq9UsIEPra2gpwjubSmnv9jNbsIFjrw1JcppH
	 yQf97Ym+WukqtuA64Ex/e2jK2wKV8k0qOIq9eWeCfh41k3mc2tw6l/yEICu88QvO5L
	 aEGnHsiMWwh8GlWQejBEe6wsTCgwL5W2m+jqkfMf0BIuJw99REhpvBztsbJeaz0UQT
	 fWWyYLt8bWyR1PDebZxJH5pRPn+MiPlXfvc1vEWm30wHj3ZAwj+Gu3OtVox+ASBYKe
	 rmGlcZ2VvABMg==
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
Subject: [PATCH net v3 4/4] netlink: specs: rt_route: pull the ifa- prefix out of the names
Date: Wed,  2 Apr 2025 18:37:06 -0700
Message-ID: <20250403013706.2828322-5-kuba@kernel.org>
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
in route-attrs and metrics and specify name-prefix instead.

This is a bit risky, hopefully there aren't many users out there.

Fixes: 023289b4f582 ("doc/netlink: Add spec for rt route messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - new
---
 Documentation/netlink/specs/rt_route.yaml | 180 +++++++++++-----------
 1 file changed, 91 insertions(+), 89 deletions(-)

diff --git a/Documentation/netlink/specs/rt_route.yaml b/Documentation/netlink/specs/rt_route.yaml
index a674103e5bc4..292469c7d4b9 100644
--- a/Documentation/netlink/specs/rt_route.yaml
+++ b/Documentation/netlink/specs/rt_route.yaml
@@ -80,165 +80,167 @@ protonum: 0
 attribute-sets:
   -
     name: route-attrs
+    name-prefix: rta-
     attributes:
       -
-        name: rta-dst
+        name: dst
         type: binary
         display-hint: ipv4
       -
-        name: rta-src
+        name: src
         type: binary
         display-hint: ipv4
       -
-        name: rta-iif
+        name: iif
         type: u32
       -
-        name: rta-oif
+        name: oif
         type: u32
       -
-        name: rta-gateway
+        name: gateway
         type: binary
         display-hint: ipv4
       -
-        name: rta-priority
+        name: priority
         type: u32
       -
-        name: rta-prefsrc
+        name: prefsrc
         type: binary
         display-hint: ipv4
       -
-        name: rta-metrics
+        name: metrics
         type: nest
-        nested-attributes: rta-metrics
+        nested-attributes: metrics
       -
-        name: rta-multipath
+        name: multipath
         type: binary
       -
-        name: rta-protoinfo # not used
+        name: protoinfo # not used
         type: binary
       -
-        name: rta-flow
+        name: flow
         type: u32
       -
-        name: rta-cacheinfo
+        name: cacheinfo
         type: binary
         struct: rta-cacheinfo
       -
-        name: rta-session # not used
+        name: session # not used
         type: binary
       -
-        name: rta-mp-algo # not used
+        name: mp-algo # not used
         type: binary
       -
-        name: rta-table
+        name: table
         type: u32
       -
-        name: rta-mark
+        name: mark
         type: u32
       -
-        name: rta-mfc-stats
+        name: mfc-stats
         type: binary
       -
-        name: rta-via
+        name: via
         type: binary
       -
-        name: rta-newdst
+        name: newdst
         type: binary
       -
-        name: rta-pref
+        name: pref
         type: u8
       -
-        name: rta-encap-type
+        name: encap-type
         type: u16
       -
-        name: rta-encap
+        name: encap
         type: binary # tunnel specific nest
       -
-        name: rta-expires
+        name: expires
         type: u32
       -
-        name: rta-pad
+        name: pad
         type: binary
       -
-        name: rta-uid
+        name: uid
         type: u32
       -
-        name: rta-ttl-propagate
+        name: ttl-propagate
         type: u8
       -
-        name: rta-ip-proto
+        name: ip-proto
         type: u8
       -
-        name: rta-sport
+        name: sport
         type: u16
       -
-        name: rta-dport
+        name: dport
         type: u16
       -
-        name: rta-nh-id
+        name: nh-id
         type: u32
       -
-        name: rta-flowlabel
+        name: flowlabel
         type: u32
         byte-order: big-endian
         display-hint: hex
   -
-    name: rta-metrics
+    name: metrics
+    name-prefix: rtax-
     attributes:
       -
-        name: rtax-unspec
+        name: unspec
         type: unused
         value: 0
       -
-        name: rtax-lock
+        name: lock
         type: u32
       -
-        name: rtax-mtu
+        name: mtu
         type: u32
       -
-        name: rtax-window
+        name: window
         type: u32
       -
-        name: rtax-rtt
+        name: rtt
         type: u32
       -
-        name: rtax-rttvar
+        name: rttvar
         type: u32
       -
-        name: rtax-ssthresh
+        name: ssthresh
         type: u32
       -
-        name: rtax-cwnd
+        name: cwnd
         type: u32
       -
-        name: rtax-advmss
+        name: advmss
         type: u32
       -
-        name: rtax-reordering
+        name: reordering
         type: u32
       -
-        name: rtax-hoplimit
+        name: hoplimit
         type: u32
       -
-        name: rtax-initcwnd
+        name: initcwnd
         type: u32
       -
-        name: rtax-features
+        name: features
         type: u32
       -
-        name: rtax-rto-min
+        name: rto-min
         type: u32
       -
-        name: rtax-initrwnd
+        name: initrwnd
         type: u32
       -
-        name: rtax-quickack
+        name: quickack
         type: u32
       -
-        name: rtax-cc-algo
+        name: cc-algo
         type: string
       -
-        name: rtax-fastopen-no-cookie
+        name: fastopen-no-cookie
         type: u32
 
 operations:
@@ -254,18 +256,18 @@ protonum: 0
           value: 26
           attributes:
             - rtm-family
-            - rta-src
+            - src
             - rtm-src-len
-            - rta-dst
+            - dst
             - rtm-dst-len
-            - rta-iif
-            - rta-oif
-            - rta-ip-proto
-            - rta-sport
-            - rta-dport
-            - rta-mark
-            - rta-uid
-            - rta-flowlabel
+            - iif
+            - oif
+            - ip-proto
+            - sport
+            - dport
+            - mark
+            - uid
+            - flowlabel
         reply:
           value: 24
           attributes: &all-route-attrs
@@ -278,34 +280,34 @@ protonum: 0
             - rtm-scope
             - rtm-type
             - rtm-flags
-            - rta-dst
-            - rta-src
-            - rta-iif
-            - rta-oif
-            - rta-gateway
-            - rta-priority
-            - rta-prefsrc
-            - rta-metrics
-            - rta-multipath
-            - rta-flow
-            - rta-cacheinfo
-            - rta-table
-            - rta-mark
-            - rta-mfc-stats
-            - rta-via
-            - rta-newdst
-            - rta-pref
-            - rta-encap-type
-            - rta-encap
-            - rta-expires
-            - rta-pad
-            - rta-uid
-            - rta-ttl-propagate
-            - rta-ip-proto
-            - rta-sport
-            - rta-dport
-            - rta-nh-id
-            - rta-flowlabel
+            - dst
+            - src
+            - iif
+            - oif
+            - gateway
+            - priority
+            - prefsrc
+            - metrics
+            - multipath
+            - flow
+            - cacheinfo
+            - table
+            - mark
+            - mfc-stats
+            - via
+            - newdst
+            - pref
+            - encap-type
+            - encap
+            - expires
+            - pad
+            - uid
+            - ttl-propagate
+            - ip-proto
+            - sport
+            - dport
+            - nh-id
+            - flowlabel
       dump:
         request:
           value: 26
-- 
2.49.0


