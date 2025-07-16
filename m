Return-Path: <netdev+bounces-207455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C48B07528
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E391507195
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0832F50AB;
	Wed, 16 Jul 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y/tBD+QP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B32F433B
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666908; cv=none; b=Hrw3uuR5Xl74zdmI+CntIBbaa2KCyR9DfuT6HKj9LLu78bFaSMnfD58/RMg0OSlnvm4SrYhML8xp5YV517kxYOf/pbvB/YI+8oBEoiq03iIdSr/gj9h/wg6W1IfHzWiqsR40CPGblf9p/oSq5bqrdpcOsQGKK1oMbDmZeuSVanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666908; c=relaxed/simple;
	bh=4uM8h2zDxTifUVwL4yXA0Y/Xe9t7qQtUmvw4ZrsrXtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQWoWAEfCp4didzosT9lfsJRkWrjHr8IfUkoFCpxUndlDrMxVJ6LKBcuZ1HFpZrsfRTgINzyra4nX343AVTUXZiGGbRKj/lVd01gTDaOsBB0q05jqw0dQqGsHS0Ozp6FdWSO+Own1Ao9YY2M8nTtGmwUAm9RBy7tdb+LGrUj/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y/tBD+QP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1210094166b.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752666904; x=1753271704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rqoVGFO4BuBauPe/9qrFvajGd6GPidXg1smqflXIbQ=;
        b=Y/tBD+QPkXwwxWNBXGaT4iApApVPiPxbw7MyzkkxkRmOe8csJY33S5zigsNHsy3BoT
         SH50EtHOp9UFLJuBCNsAjlrT2JELSMyNT3+fH+h98zTgN/P1YGkpZia2fRbQY/mdMQ05
         2MBa+bGAiBlzThUU4/pbO3fP8Ab7bD1EuQqHFETdTGAG+gTnnfSvS3HdMvsCD3rRn83k
         hVSuobfhhCpbjoJA4DqQpomgdfuZ3NJENrfxIDlq06JViIcozi4WWbtEKHCVMnQKs7uB
         ejei/h4+A6IzLN9h/H1GWzPJ3K+3eISvjuw+WF6q2auh/bDURH8Jc4DDs0JK8aQUl4Ii
         WzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666904; x=1753271704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rqoVGFO4BuBauPe/9qrFvajGd6GPidXg1smqflXIbQ=;
        b=jPecaB+0COeTJCbbgXah39EfV2ujsTzLOB64SI8Kiw73L26bkziVAzT3B+nSxCXoIt
         5lVduxvO/o5WAy8G3MxipngNIkjBmBFOi5Wp4rbpiFM8K4kkiFUgsQtCGR6EGNXRTc1E
         oH/q61qj9D/2+DWkZy2D0F9WTKsxfqoq4uHzsL0xC0Ni43ddJBdSCvYHd0MOHrR//bIO
         8ZIF8PP8MzL1CD/ABPdGVsZlw61fKUTrPA9chhzHvBt9n+tDIZJN8bOVSjFlLrQXIxbF
         hWkwPhe5RzXapezJ45xFDNFbGALNpxI1ylJ8VTzrXJgW5AGxjKRvtMMJtujaQDtZUZpQ
         etWQ==
X-Gm-Message-State: AOJu0YyNvr0so1yDgrHjUGt1VmnBQ0FQzKmMKfqExVyW1T2DyNEs5Qc/
	56yAf4CbFJc7/exrlSP6x4JAknu6i3eWxqx2ry/DEGM0a+LQwD/Ux+cEdVCK7tUEihBYt6g+zmP
	v9yFxA37WiLXNxdAK1AZuzcH4HR4rRudBq/J+pA3YLjO73zMp64uBHDflmqZfaGaK
X-Gm-Gg: ASbGnct7eOT4naJ3pxACIV2OM4PpjOAF3HRIonRR3P/xtQN7Ebygmz2EAOPy856rpft
	2ehQLQ8DtiG7gUZ/TQ2khiCU6Kn+nMplzyGM4bIxmCHjEfGW2HMonnwsJ/ASFscJbpbm7eyFhPP
	5PrxHybwDH1oQK22H90xu71GkZThUkjpb7sYy0pyMX/TpEtnnY939qkoBcndNYjSb7k+9lPM9m6
	fwgucOGSBOrE2X6tjDf8KHt9kMraQJJ5JHpI+J9kLZoAGtKlyLP9x6mHOUan03mRoFBmt26VfOJ
	ATXcpklY14yy+T0zFsVpF0lBiSG9e0Mpl42KGw7uvv3YwLza/ORr9FaPe9NYCS5LgqCxDXa4TY8
	9lQt9epYCrGFDj7wJk/IcnKsGkPOQIRtxCegNX2hdr70pJQ==
X-Google-Smtp-Source: AGHT+IEFNW5JZ482DTH8mFHC2HnD+XcZpwAkYGZ4dRGj/VLD+ZmycYOHR4VBtr9JHIKw5+V42dImXw==
X-Received: by 2002:a17:907:7e99:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-ae9c9b3f3c5mr290416266b.40.1752666903971;
        Wed, 16 Jul 2025 04:55:03 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:96ff:526e:2192:5194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264636sm1169169666b.86.2025.07.16.04.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:55:03 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: [PATCH net 2/3] ovpn: reject unexpected netlink attributes
Date: Wed, 16 Jul 2025 13:54:42 +0200
Message-ID: <20250716115443.16763-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250716115443.16763-1-antonio@openvpn.net>
References: <20250716115443.16763-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink ops do not expect all attributes to be always set, however
this condition is not explicitly coded any where, leading the user
to believe that all sent attributes are somewhat processed.

Fix this behaviour by introducing explicit checks.

For CMD_OVPN_PEER_GET and CMD_OVPN_KEY_GET directly open-code the
needed condition in the related ops handlers.
While for all other ops use attribute subsets in the ovpn.yaml spec file.

Fixes: b7a63391aa98 ("ovpn: add basic netlink support")
Reported-by: Ralf Lici <ralf@mandelbit.com>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/19
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml | 153 +++++++++++++++++++++++++-
 drivers/net/ovpn/netlink-gen.c        |  61 +++++++++-
 drivers/net/ovpn/netlink-gen.h        |   6 +
 drivers/net/ovpn/netlink.c            |  51 +++++++--
 4 files changed, 251 insertions(+), 20 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 096c51f0c69a..ba76426a542d 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -160,6 +160,66 @@ attribute-sets:
         name: link-tx-packets
         type: uint
         doc: Number of packets transmitted at the transport level
+  -
+    name: peer-new-input
+    subset-of: peer
+    attributes:
+      -
+        name: id
+      -
+        name: remote-ipv4
+      -
+        name: remote-ipv6
+      -
+        name: remote-ipv6-scope-id
+      -
+        name: remote-port
+      -
+        name: socket
+      -
+        name: vpn-ipv4
+      -
+        name: vpn-ipv6
+      -
+        name: local-ipv4
+      -
+        name: local-ipv6
+      -
+        name: keepalive-interval
+      -
+        name: keepalive-timeout
+  -
+    name: peer-set-input
+    subset-of: peer
+    attributes:
+      -
+        name: id
+      -
+        name: remote-ipv4
+      -
+        name: remote-ipv6
+      -
+        name: remote-ipv6-scope-id
+      -
+        name: remote-port
+      -
+        name: vpn-ipv4
+      -
+        name: vpn-ipv6
+      -
+        name: local-ipv4
+      -
+        name: local-ipv6
+      -
+        name: keepalive-interval
+      -
+        name: keepalive-timeout
+  -
+    name: peer-del-input
+    subset-of: peer
+    attributes:
+      -
+        name: id
   -
     name: keyconf
     attributes:
@@ -216,6 +276,33 @@ attribute-sets:
           obtain the actual cipher IV
         checks:
           exact-len: nonce-tail-size
+
+  -
+    name: keyconf-get
+    subset-of: keyconf
+    attributes:
+      -
+        name: peer-id
+      -
+        name: slot
+      -
+        name: key-id
+      -
+        name: cipher-alg
+  -
+    name: keyconf-swap-input
+    subset-of: keyconf
+    attributes:
+      -
+        name: peer-id
+  -
+    name: keyconf-del-input
+    subset-of: keyconf
+    attributes:
+      -
+        name: peer-id
+      -
+        name: slot
   -
     name: ovpn
     attributes:
@@ -235,12 +322,66 @@ attribute-sets:
         type: nest
         doc: Peer specific cipher configuration
         nested-attributes: keyconf
+  -
+    name: ovpn-peer-new-input
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: peer
+        nested-attributes: peer-new-input
+  -
+    name: ovpn-peer-set-input
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: peer
+        nested-attributes: peer-set-input
+  -
+    name: ovpn-peer-del-input
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: peer
+        nested-attributes: peer-del-input
+  -
+    name: ovpn-keyconf-get
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: keyconf
+        nested-attributes: keyconf-get
+  -
+    name: ovpn-keyconf-swap-input
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: keyconf
+        nested-attributes: keyconf-swap-input
+  -
+    name: ovpn-keyconf-del-input
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: keyconf
+        nested-attributes: keyconf-del-input
 
 operations:
   list:
     -
       name: peer-new
-      attribute-set: ovpn
+      attribute-set: ovpn-peer-new-input
       flags: [ admin-perm ]
       doc: Add a remote peer
       do:
@@ -252,7 +393,7 @@ operations:
             - peer
     -
       name: peer-set
-      attribute-set: ovpn
+      attribute-set: ovpn-peer-set-input
       flags: [ admin-perm ]
       doc: modify a remote peer
       do:
@@ -286,7 +427,7 @@ operations:
             - peer
     -
       name: peer-del
-      attribute-set: ovpn
+      attribute-set: ovpn-peer-del-input
       flags: [ admin-perm ]
       doc: Delete existing remote peer
       do:
@@ -316,7 +457,7 @@ operations:
             - keyconf
     -
       name: key-get
-      attribute-set: ovpn
+      attribute-set: ovpn-keyconf-get
       flags: [ admin-perm ]
       doc: Retrieve non-sensitive data about peer key and cipher
       do:
@@ -331,7 +472,7 @@ operations:
             - keyconf
     -
       name: key-swap
-      attribute-set: ovpn
+      attribute-set: ovpn-keyconf-swap-input
       flags: [ admin-perm ]
       doc: Swap primary and secondary session keys for a specific peer
       do:
@@ -350,7 +491,7 @@ operations:
       mcgrp: peers
     -
       name: key-del
-      attribute-set: ovpn
+      attribute-set: ovpn-keyconf-del-input
       flags: [ admin-perm ]
       doc: Delete cipher key for a specific peer
       do:
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 58e1a4342378..14298188c5f1 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -29,6 +29,22 @@ const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] =
 	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
 };
 
+const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_SLOT + 1] = {
+	[OVPN_A_KEYCONF_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_keyconf_peer_id_range),
+	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
+};
+
+const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1] = {
+	[OVPN_A_KEYCONF_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_keyconf_peer_id_range),
+	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
+	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 7),
+	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
+};
+
+const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1] = {
+	[OVPN_A_KEYCONF_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_keyconf_peer_id_range),
+};
+
 const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
 	[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(256),
 	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
@@ -60,16 +76,49 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
 	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_UINT, },
 };
 
+const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1] = {
+	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
+};
+
+const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1] = {
+	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
+	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID] = { .type = NLA_U32, },
+	[OVPN_A_PEER_REMOTE_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
+	[OVPN_A_PEER_SOCKET] = { .type = NLA_U32, },
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+};
+
+const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1] = {
+	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
+	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID] = { .type = NLA_U32, },
+	[OVPN_A_PEER_REMOTE_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
+	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+};
+
 /* OVPN_CMD_PEER_NEW - do */
 static const struct nla_policy ovpn_peer_new_nl_policy[OVPN_A_PEER + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
-	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_new_input_nl_policy),
 };
 
 /* OVPN_CMD_PEER_SET - do */
 static const struct nla_policy ovpn_peer_set_nl_policy[OVPN_A_PEER + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
-	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_set_input_nl_policy),
 };
 
 /* OVPN_CMD_PEER_GET - do */
@@ -86,7 +135,7 @@ static const struct nla_policy ovpn_peer_get_dump_nl_policy[OVPN_A_IFINDEX + 1]
 /* OVPN_CMD_PEER_DEL - do */
 static const struct nla_policy ovpn_peer_del_nl_policy[OVPN_A_PEER + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
-	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_del_input_nl_policy),
 };
 
 /* OVPN_CMD_KEY_NEW - do */
@@ -98,19 +147,19 @@ static const struct nla_policy ovpn_key_new_nl_policy[OVPN_A_KEYCONF + 1] = {
 /* OVPN_CMD_KEY_GET - do */
 static const struct nla_policy ovpn_key_get_nl_policy[OVPN_A_KEYCONF + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
-	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_get_nl_policy),
 };
 
 /* OVPN_CMD_KEY_SWAP - do */
 static const struct nla_policy ovpn_key_swap_nl_policy[OVPN_A_KEYCONF + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
-	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_swap_input_nl_policy),
 };
 
 /* OVPN_CMD_KEY_DEL - do */
 static const struct nla_policy ovpn_key_del_nl_policy[OVPN_A_KEYCONF + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
-	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_del_input_nl_policy),
 };
 
 /* Ops table for ovpn */
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 66a4e4a0a055..220b5b2fdd4f 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -13,8 +13,14 @@
 
 /* Common nested types */
 extern const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1];
+extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_SLOT + 1];
+extern const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1];
+extern const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1];
 extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
 extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1];
+extern const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1];
+extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1];
+extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1];
 
 int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index a4ec53def46e..c7f382437630 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -352,7 +352,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
-			       ovpn_peer_nl_policy, info->extack);
+			       ovpn_peer_new_input_nl_policy, info->extack);
 	if (ret)
 		return ret;
 
@@ -476,7 +476,7 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
-			       ovpn_peer_nl_policy, info->extack);
+			       ovpn_peer_set_input_nl_policy, info->extack);
 	if (ret)
 		return ret;
 
@@ -654,7 +654,7 @@ int ovpn_nl_peer_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct ovpn_peer *peer;
 	struct sk_buff *msg;
 	u32 peer_id;
-	int ret;
+	int ret, i;
 
 	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
 		return -EINVAL;
@@ -668,6 +668,23 @@ int ovpn_nl_peer_get_doit(struct sk_buff *skb, struct genl_info *info)
 			      OVPN_A_PEER_ID))
 		return -EINVAL;
 
+	/* OVPN_CMD_PEER_GET expects only the PEER_ID, therefore
+	 * ensure that the user hasn't specified any other attribute.
+	 *
+	 * Unfortunately this check cannot be performed via netlink
+	 * spec/policy and must be open-coded.
+	 */
+	for (i = 0; i < OVPN_A_PEER_MAX + 1; i++) {
+		if (i == OVPN_A_PEER_ID)
+			continue;
+
+		if (attrs[i]) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "unexpected attribute %u", i);
+			return -EINVAL;
+		}
+	}
+
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
 	peer = ovpn_peer_get_by_id(ovpn, peer_id);
 	if (!peer) {
@@ -768,7 +785,7 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
-			       ovpn_peer_nl_policy, info->extack);
+			       ovpn_peer_del_input_nl_policy, info->extack);
 	if (ret)
 		return ret;
 
@@ -969,14 +986,14 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct ovpn_peer *peer;
 	struct sk_buff *msg;
 	u32 peer_id;
-	int ret;
+	int ret, i;
 
 	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
 		return -EINVAL;
 
 	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
 			       info->attrs[OVPN_A_KEYCONF],
-			       ovpn_keyconf_nl_policy, info->extack);
+			       ovpn_keyconf_get_nl_policy, info->extack);
 	if (ret)
 		return ret;
 
@@ -988,6 +1005,24 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 			      OVPN_A_KEYCONF_SLOT))
 		return -EINVAL;
 
+	/* OVPN_CMD_KEY_GET expects only the PEER_ID and the SLOT, therefore
+	 * ensure that the user hasn't specified any other attribute.
+	 *
+	 * Unfortunately this check cannot be performed via netlink
+	 * spec/policy and must be open-coded.
+	 */
+	for (i = 0; i < OVPN_A_KEYCONF_MAX + 1; i++) {
+		if (i == OVPN_A_KEYCONF_PEER_ID ||
+		    i == OVPN_A_KEYCONF_SLOT)
+			continue;
+
+		if (attrs[i]) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "unexpected attribute %u", i);
+			return -EINVAL;
+		}
+	}
+
 	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
 	peer = ovpn_peer_get_by_id(ovpn, peer_id);
 	if (!peer) {
@@ -1037,7 +1072,7 @@ int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 
 	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
 			       info->attrs[OVPN_A_KEYCONF],
-			       ovpn_keyconf_nl_policy, info->extack);
+			       ovpn_keyconf_swap_input_nl_policy, info->extack);
 	if (ret)
 		return ret;
 
@@ -1074,7 +1109,7 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 
 	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
 			       info->attrs[OVPN_A_KEYCONF],
-			       ovpn_keyconf_nl_policy, info->extack);
+			       ovpn_keyconf_del_input_nl_policy, info->extack);
 	if (ret)
 		return ret;
 
-- 
2.49.1


