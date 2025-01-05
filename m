Return-Path: <netdev+bounces-155235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CCA017C0
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE723A2F99
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB9481B6;
	Sun,  5 Jan 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyAJzz9J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31735950
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040330; cv=none; b=P9EtokB2P+DuwvyI2kuMnZmUpZilkYOB5Iw9y7utvaPOd/cuzVqeUOwEv8LJxIDqeiS254spYsJygvkZ2quVBUGQOdf1ua7R+GCkMIijIV6Aw/qzvjDe/LLvNckeyyyIzyhI099G4hKfc8OaLYkyUwW6xL43GkfzKl7DUg22BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040330; c=relaxed/simple;
	bh=fjkyiRAYREsBZoj2Q/oEApeDcuDbyoF5o5EZR5bWWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rigu4+EHlhlg1NvtLyGCpYpvMFHK9cYAkwfqsOwJAMgUM4Q37pJoeVId4HI2e+Y352MQeGPJ+9m0eD5giuYICOtQXRMSQUIdTyvxajui9VwrW4pPs3TY/BtOcHxrX9FjbHKTDbEQrbKhaWgtYBSTosNtWJPmrvzS22CZQob3ybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyAJzz9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15018C4CEE3;
	Sun,  5 Jan 2025 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736040330;
	bh=fjkyiRAYREsBZoj2Q/oEApeDcuDbyoF5o5EZR5bWWhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyAJzz9J882BIJQaInX9xkdIKjlNsPFDVcKky7fSQhzYy9c8Lf3xEfT3KXiryZrLb
	 dHInJGr3p8TY4isS4LCQavi2nBOvW9bW1IoXs/AD2CUrGQShu8qkkPMT9HLM/a4VF9
	 8N97SWXbtBvShuZ4Y05M25DnmgyVU13TSohBMdy8PeI/aK9a8AGkDh1Bj5Q3OrvpVi
	 3SSYr6ZKoQThg/9YEisDfJESahl1fcllTKQfO2yjuq6fbQA50l5Jd+ZjpIk5r36e0R
	 MhnrpFnGjKRuFi/k4daNOXne5vSAjLbYtHgdS2ZVysotRIHhJ/U/uCo86rOjue0buX
	 rZUu9fy5Eb8bg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs
Date: Sat,  4 Jan 2025 17:25:23 -0800
Message-ID: <20250105012523.1722231-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105012523.1722231-1-kuba@kernel.org>
References: <20250105012523.1722231-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of our tests load vti and ip6tnl so not being able to decode
the link attrs gets in the way of using Python YNL for testing.

Decode link attributes for ip6tnl, vti and vti6.

ip6tnl uses IFLA_IPTUN_FLAGS as u32, while ipv4 and sit expect
a u16 attribute, so we have a (first?) subset type override...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt_link.yaml | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 96465376d6fe..363c4d4f0779 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1825,6 +1825,48 @@ protonum: 0
       -
         name: erspan-hwid
         type: u16
+  -
+    name: linkinfo-vti-attrs
+    name-prefix: ifla-vti-
+    attributes:
+      -
+        name: link
+        type: u32
+      -
+        name: ikey
+        type: u32
+      -
+        name: okey
+        type: u32
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: fwmark
+        type: u32
+  -
+    name: linkinfo-vti6-attrs
+    subset-of: linkinfo-vti-attrs
+    attributes:
+      -
+        name: link
+      -
+        name: ikey
+      -
+        name: okey
+      -
+        name: local
+        display-hint: ipv6
+      -
+        name: remote
+        display-hint: ipv6
+      -
+        name: fwmark
   -
     name: linkinfo-geneve-attrs
     name-prefix: ifla-geneve-
@@ -1941,6 +1983,42 @@ protonum: 0
       -
         name: fwmark
         type: u32
+  -
+    name: linkinfo-ip6tnl-attrs
+    subset-of: linkinfo-iptun-attrs
+    attributes:
+      -
+        name: link
+      -
+        name: local
+        display-hint: ipv6
+      -
+        name: remote
+        display-hint: ipv6
+      -
+        name: ttl
+      -
+        name: encap-limit
+      -
+        name: flowinfo
+      -
+        name: flags
+        # ip6tnl unlike ipip and sit has 32b flags
+        type: u32
+      -
+        name: proto
+      -
+        name: encap-type
+      -
+        name: encap-flags
+      -
+        name: encap-sport
+      -
+        name: encap-dport
+      -
+        name: collect-metadata
+      -
+        name: fwmark
   -
     name: linkinfo-tun-attrs
     name-prefix: ifla-tun-
@@ -2195,6 +2273,9 @@ protonum: 0
       -
         value: ipip
         attribute-set: linkinfo-iptun-attrs
+      -
+        value: ip6tnl
+        attribute-set: linkinfo-ip6tnl-attrs
       -
         value: sit
         attribute-set: linkinfo-iptun-attrs
@@ -2207,6 +2288,12 @@ protonum: 0
       -
         value: vrf
         attribute-set: linkinfo-vrf-attrs
+      -
+        value: vti
+        attribute-set: linkinfo-vti-attrs
+      -
+        value: vti6
+        attribute-set: linkinfo-vti6-attrs
       -
         value: netkit
         attribute-set: linkinfo-netkit-attrs
-- 
2.47.1


