Return-Path: <netdev+bounces-262011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJPMDh4womke0wQAu9opvQ
	(envelope-from <netdev+bounces-262011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:00:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DA1BF4A9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17C1F303873D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A9271448;
	Sat, 28 Feb 2026 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Yd8tVhRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A42D738A
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236827; cv=none; b=bAmk80MYTiLxmpq8Iy7KGNWeJpmsV6VbRYa9n1Eybfvqid+n8WW4iaCpmC5eK00SLZayOPJTHxwjZVoV6xtlXpl941e9bufnGGjnMJrjtZRQBzSH3XjjJDhD9hZKpOawbkQMa+HxhLhKEF2i//uBOFB7Xzu0kd3YJL5yUwFAXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236827; c=relaxed/simple;
	bh=fPUd8BnK2oTvm2f4iEIhlBHqEhKMlX7Y7ESXP1U1zfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3XFgy26I1nebsG3HsuT6PM+mCxRZqmgtp4mfroegWwzw5x4Tz0UaBTISJVdCug3M/Ge0WZO0oVmtJPPNpoAsL2uADnq+jPJhTlKXHO9mxOlkkI0XS+5BjLEThCKqv/pQIgHZn315cpMXxUBO+4c0SpPhYiTVWxlJUl7kP7/zZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Yd8tVhRu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4833115090dso25808305e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236823; x=1772841623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTog4NKy/1nE67uUmd/XotZuin27hHXYpfRSdZ1MFtc=;
        b=Yd8tVhRuxS8Xo46c4qAPTpJ5RhCmgu9YYeTCOWzqEQuzRmGwAf/iwkqi/DRodFqP5c
         DHy5M7Mu38j8ja0hybTUn5WXDztMYLQEpcr267ogY6KBN6AwT29Nc3XycXbj53xnrt24
         2aziOPVZWkCz4cruU3pPYfTU0vJkRGN3k81ubCGONXoPL2ES7iDLhMR8cuxt1g/sMdN9
         Oav+7F8VR22u0LCbpOpfaToULAkqdS92LiEKa1bNtcrKASWXSNMirbxQy96/cKp7QXTS
         NEgqSda1z73i1NwQNUsET+DhLktlK0wOzw2NAk82UATZiz+hem6ijiM6RBkrHCOjp/w8
         4AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236823; x=1772841623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTog4NKy/1nE67uUmd/XotZuin27hHXYpfRSdZ1MFtc=;
        b=Gy8cDQAkuys7IvjKO3z/4/7kqPinLiZ7tk1JMzf4p3L1MPVNz9JNWro3IB7+uWH4PN
         R8DCGYbLhJRxz/r3pFDNR70I85oXrMCFBiqAVGEHvNPE4JL2af16L1FJnVlVMj5Engcp
         xxKNgzHi5KbBaB7HPwKYTwqBuoRVtcyCkBzRn5p+Eyb+r5iBH3p8m0Z1MG4YQXOMoCJm
         3rtKgX7iQGBkVa6d7FsZX5SY9bHWqdiQWj/aFG1onOOmwDKhqkatFEoy04Tlw73EOvQt
         m/r399mHd0Lf30Nh/EvX+NuBo+per8Z6dUTvK/b5spkMAqcGeZvl3T5G0ZVdRG0UVU6V
         3EkQ==
X-Gm-Message-State: AOJu0YyheFUqnu8zGkwCqawTmVM2/viM4tj9ukcz80Y6PhKKz8tJ8lUa
	3AEDj9tQ8maK0syHNfWptzrWKRGUjnTvNGK3uz+1WHQ8y3PeJoDjD0vowe4mYMZjAfGsPqJnqfF
	RhGncRlu4D4+bTAmvJmi1gdssyeZthP+f1zWoK+bE1zxfp8PK5G6uWbwRomHMs/0o
X-Gm-Gg: ATEYQzygVGnyoFF1e/S74EDw3TwVusR9Mz8zxhUYdHjoEHNj9tZsYAFB3moCyEpfj8m
	bXKiWGoG8MKPYAqsnbWqto1XZpFJ84YLO46KK6RYqpnrterzLXcRcj2nV5UM0dI7x4DpV8qJbmy
	WxtTQ+yvRKSiunXn+y/nrWLw3eYQXT0MoaswdNt1b9dK4w0MYHRGaJ6rQnv7GoaTWAlpJih7Nld
	ebKAlw0ot3oqpiSTZ4i/bKzaf+q0LZHG1wXHrtmsgQa5ShkIQYS0K0y71cXTW90JX6+nQjtej0M
	hWHXsU9r5VJxH15X+jrNNuoHjurUfk154UiOBXxdypXIEFBexWK31D7qv6o3PLzvBtRXnrlSByL
	00oQ5HJRn0Q1IInHRNhJLlmcBRA2CFwmm0wmRQO3IVkhCyWzpfVbBHpHFWwpcIaYcJspFaGl8II
	XKzQrhOBHX5XZUmlRehXDmYOAR22rTqtBTNYKy
X-Received: by 2002:a05:600c:8b8a:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-483c9b6cfccmr82712405e9.0.1772236822872;
        Fri, 27 Feb 2026 16:00:22 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:21 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 6/9] ovpn: add support for asymmetric peer IDs
Date: Sat, 28 Feb 2026 00:59:52 +0100
Message-ID: <20260227235955.660-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262011-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF7DA1BF4A9
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

In order to support the multipeer architecture, upon connection setup
each side of a tunnel advertises a unique ID that the other side must
include in packets sent to them. Therefore when transmitting a packet, a
peer inserts the recipient's advertised ID for that specific tunnel into
the peer ID field. When receiving a packet, a peer expects to find its
own unique receive ID for that specific tunnel in the peer ID field.

Add support for the TX peer ID and embed it into transmitting packets.
If no TX peer ID is specified, fallback to using the same peer ID both
for RX and TX in order to be compatible with the non-multipeer compliant
peers.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 Documentation/netlink/specs/ovpn.yaml | 17 ++++++++++++++++-
 drivers/net/ovpn/crypto_aead.c        |  2 +-
 drivers/net/ovpn/netlink-gen.c        | 13 ++++++++++---
 drivers/net/ovpn/netlink-gen.h        |  6 +++---
 drivers/net/ovpn/netlink.c            | 14 ++++++++++++--
 drivers/net/ovpn/peer.c               |  4 ++++
 drivers/net/ovpn/peer.h               |  4 +++-
 include/uapi/linux/ovpn.h             |  1 +
 8 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 0d0c028bf96f..b0c782e59a32 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -43,7 +43,8 @@ attribute-sets:
         type: u32
         doc: >-
           The unique ID of the peer in the device context. To be used to
-          identify peers during operations for a specific device
+          identify peers during operations for a specific device.
+          Also used to match packets received from this peer.
         checks:
           max: 0xFFFFFF
       -
@@ -160,6 +161,16 @@ attribute-sets:
         name: link-tx-packets
         type: uint
         doc: Number of packets transmitted at the transport level
+      -
+        name: tx-id
+        type: u32
+        doc: >-
+          The ID value used when transmitting packets to this peer. This
+          way outgoing packets can have a different ID than incoming ones.
+          Useful in multipeer-to-multipeer connections, where each peer
+          will advertise the tx-id to be used on the link.
+        checks:
+          max: 0xFFFFFF
   -
     name: peer-new-input
     subset-of: peer
@@ -188,6 +199,8 @@ attribute-sets:
         name: keepalive-interval
       -
         name: keepalive-timeout
+      -
+        name: tx-id
   -
     name: peer-set-input
     subset-of: peer
@@ -214,6 +227,8 @@ attribute-sets:
         name: keepalive-interval
       -
         name: keepalive-timeout
+      -
+        name: tx-id
   -
     name: peer-del-input
     subset-of: peer
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 77be0942a269..59848c41b7b2 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -122,7 +122,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	memcpy(skb->data, iv, OVPN_NONCE_WIRE_SIZE);
 
 	/* add packet op as head of additional data */
-	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
+	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
 	__skb_push(skb, OVPN_OPCODE_SIZE);
 	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
 	*((__force __be32 *)skb->data) = htonl(op);
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index ecbe9dcf4f7d..2147cec7c2c5 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -16,6 +16,10 @@ static const struct netlink_range_validation ovpn_a_peer_id_range = {
 	.max	= 16777215ULL,
 };
 
+static const struct netlink_range_validation ovpn_a_peer_tx_id_range = {
+	.max	= 16777215ULL,
+};
+
 static const struct netlink_range_validation ovpn_a_keyconf_peer_id_range = {
 	.max	= 16777215ULL,
 };
@@ -51,7 +55,7 @@ const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
 	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
 };
 
-const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -75,13 +79,14 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
 	[OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
 const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 };
 
-const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1] = {
+const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -94,9 +99,10 @@ const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIME
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
-const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1] = {
+const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -108,6 +114,7 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIME
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
 /* OVPN_CMD_PEER_NEW - do */
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index b2301580770f..67cd85f86173 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -18,10 +18,10 @@ extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_S
 extern const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1];
 extern const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1];
 extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
-extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1];
+extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1];
 extern const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1];
-extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1];
-extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1];
+extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
+extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
 
 int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index e10d7f9a28f5..291e2e5bb450 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -305,6 +305,12 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 		dst_cache_reset(&peer->dst_cache);
 	}
 
+	/* In a multipeer-to-multipeer setup we may have asymmetric peer IDs,
+	 * that is peer->id might be different from peer->tx_id.
+	 */
+	if (attrs[OVPN_A_PEER_TX_ID])
+		peer->tx_id = nla_get_u32(attrs[OVPN_A_PEER_TX_ID]);
+
 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
 		rehash = true;
 		peer->vpn_addrs.ipv4.s_addr =
@@ -326,8 +332,8 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	}
 
 	netdev_dbg(peer->ovpn->dev,
-		   "modify peer id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
-		   peer->id, &ss,
+		   "modify peer id=%u tx_id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   peer->id, peer->tx_id, &ss,
 		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
 
 	spin_unlock_bh(&peer->lock);
@@ -373,6 +379,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
 	peer = ovpn_peer_new(ovpn, peer_id);
 	if (IS_ERR(peer)) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
@@ -572,6 +579,9 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
 		goto err;
 
+	if (nla_put_u32(skb, OVPN_A_PEER_TX_ID, peer->tx_id))
+		goto err;
+
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
 		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
 				    peer->vpn_addrs.ipv4.s_addr))
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4e145b4497e6..26b55d813f0e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -99,7 +99,11 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	if (!peer)
 		return ERR_PTR(-ENOMEM);
 
+	/* in the default case TX and RX IDs are the same.
+	 * the user may set a different TX ID via netlink
+	 */
 	peer->id = id;
+	peer->tx_id = id;
 	peer->ovpn = ovpn;
 
 	peer->vpn_addrs.ipv4.s_addr = htonl(INADDR_ANY);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index a1423f2b09e0..328401570cba 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -21,7 +21,8 @@
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
  * @dev_tracker: reference tracker for associated dev
- * @id: unique identifier
+ * @id: unique identifier, used to match incoming packets
+ * @tx_id: identifier to be used in TX packets
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
@@ -64,6 +65,7 @@ struct ovpn_peer {
 	struct ovpn_priv *ovpn;
 	netdevice_tracker dev_tracker;
 	u32 id;
+	u32 tx_id;
 	struct {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 0cce0d58b830..06690090a1a9 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -55,6 +55,7 @@ enum {
 	OVPN_A_PEER_LINK_TX_BYTES,
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_TX_PACKETS,
+	OVPN_A_PEER_TX_ID,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
-- 
2.52.0


