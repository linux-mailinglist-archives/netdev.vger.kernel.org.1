Return-Path: <netdev+bounces-155670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CCA03523
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F123A3A0A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461C157E99;
	Tue,  7 Jan 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0oc4Pv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091D156F3F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216903; cv=none; b=SXd7wWWYmBaKrxMOYxWdWu/2pPo2NbwYMbH72e/E6r6NZHFHpQQiiEOu+xawloQuSPxdcZ1cp4sAfU2PUGzyXdv9NDe26U1U7w/O1a40GhkgqViSvSEwda9DTzsiaxV189GamXN+QQCsUgbTW/hEnFEMA94Z3NsITeLkJedCl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216903; c=relaxed/simple;
	bh=cp1xN3TFv2gpxfCP6uiAuxbeWkwjlVJU7DMIamiKSUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twoBXb5xjD6fIo9pQDVBikOXCu0rXZugjsm9GwwIoN3Mf48a+Kgw7l0+kxog1DMjNdBOvenWsxSO13Ry1E8S498k3jDuq0LSDcLjYsG7e1O5OiuJBQUIjA30KyjocN0Ij/dqvOY1tA6rMYaD6RQOVAyspbU2EQEZVPTvdMfhAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0oc4Pv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DA7C4CEE1;
	Tue,  7 Jan 2025 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736216903;
	bh=cp1xN3TFv2gpxfCP6uiAuxbeWkwjlVJU7DMIamiKSUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0oc4Pv8e9W0VKSxmeMcWugXfSKuGUTcJA4PxMlxqHbZiQA1gqedKwY/+fFxU7f9n
	 oYg7Zn2XrfKndCkpnsbhQqcsf9/3ANLEmEaqxQcWgAhBOiSC12m6Lasx0xocr7ORCi
	 sKxBuEP+tf8siP53ciDYqnsw+q8bQMvCQoUlY8igFqtE5mPGxI/BSpm/jXKWoN92QZ
	 0NP90Pk/kDU7eAGbDZC4s+U2GEdrzTkO9K8I8AdbEY9H22i73bg/Njb6DdvVT4wNL9
	 jgAwbQoYLbIB7VWSF2xS4yz5bhl0HQkTGjza/sXt4HyYCr0syRL1lneW/zAzx/qNFV
	 gbVvMFQosqaIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 3/3] netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs
Date: Mon,  6 Jan 2025 18:28:20 -0800
Message-ID: <20250107022820.2087101-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107022820.2087101-1-kuba@kernel.org>
References: <20250107022820.2087101-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


