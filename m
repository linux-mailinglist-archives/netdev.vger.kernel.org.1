Return-Path: <netdev+bounces-237751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C51C4FEAB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AE7034CFC6
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35312326938;
	Tue, 11 Nov 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PeFb65xO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74533D6E2
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897744; cv=none; b=C6IW54HBpTUmF23Yj2R1zP2MaXbNgn6ejy+D6yShbVbWbpsM1Ey7Jw9+feOg+BI9BZn9EcZgKdnrP+oiQn7wafWVPVMa0me87AQt57kRGQVnUti/jTD5piWVNrpNebuM0j26MlMcxK0pQlRCuQhECttp01bkHJsHA1j/5gU0Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897744; c=relaxed/simple;
	bh=2hcOjwdDneqPSFnaXBOy4EUF3+aBydbt32D/ilQLfrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAY5ylFogoTPFpCeiiOqxDDtyRKVxmgB4mE6i2qimnoOf4d0M+W38OHAEVnnqhzhsKoE8vs7NWvwVXCMGhT5mmA4EVXRFjUHLOLBhzqruHi7GidefE7ZaRt1qlLjvmGmSHcuYmmmP3uPbWKpZHAXXwa/BkZ0tbXPjPyzpq4Dj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PeFb65xO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso104162f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897739; x=1763502539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnsteCLSjRjnCvzguHRPBO6LpVWhuHF7UFJvY/8hHZE=;
        b=PeFb65xOyqKIX5Dui+I4vhxuZIzlG1u8rMpn0yf6Z4X5cq1dfBpX8V0zDynFHsX4Sz
         qZ2moAOkb/M+215ppLMvitEROthwvaLoJRlzZ3zEqNjfubzqfF8SUxQAmQ5WiSMzGcEu
         jgHsFWrag8ulhXiXug2BcF4fmrNaxjdJ5SE6MwEpi4jiUkYkswAbpwQ7z6CYPVcoFr1R
         dhRDdPEudnAilH3TsH0PncKhzTNiiMqJNOcEiI/lCoKHMWGrj3MfEL0Q9xrwzH0Pk5Hw
         UXuVB9J4+E6kRjjivO1V9k4d4e9P00P8aAoFwaEXalIQkfVtagIlTkz6qtCIYgv+xu1/
         OXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897739; x=1763502539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnsteCLSjRjnCvzguHRPBO6LpVWhuHF7UFJvY/8hHZE=;
        b=rFKQmgE8tTk/gXjDWANNrGaTTA2XchV8qzLa/5KLP0cIgaSbKc+FKYiRq8yDZnAsoM
         TvVhfrmx+99hcj7gnUydX7+a+gv1ZqELHqzGZCZRgI+uD9I9kKVRE/97ZhsM/EFaKwqt
         3yiYIWROOnCVYNfLAClZpBxf4smNfhYXsIqLDzPvF6Jcc1yCiJM4JgPnoQ6rzekEsqWx
         vJJAabh9LSeDPNqPxiJO410hqXp49DhpPA5dbEfJ14PkOtt074oX5w0Roy+GVDfhGn/9
         M/Ws0qCcIyM8gHLDGc/NiybUIah8Dmnqfdui7TD7dRgmoXHitUseCT9/TQuTOIU9ANGa
         lYEQ==
X-Gm-Message-State: AOJu0Yws5Ah9Hsd0OhjKKAdnIfr9N76pZTe96cwC3jB3P5Ly9HaQV7n/
	2yD2Meiyw+o4V1gJOWF+f5+gxpWmi+7aCsUPOMc1oqc/EhfT2c1VJXVxo9MZ32eR/D7CAXPzTLB
	Ye71Mb7BKJB6m4oUGDQHmOFDm66AqtffQBQDJmeuxvDDVjiRB4swsPcNG8EgMYa54dO8=
X-Gm-Gg: ASbGncv6KwNIh3NiVfqelrtgcBMH4R4a6WKc2+KWf20ET3wRUqdxieKGQ+EDs9pjp3O
	jQ6V7UHEYVhsUYf/iXlOqLV6fqleG2bBao0j1AQjbpnK8sCs163r4qOxZ7u8WkhpA6VI95WqAA8
	Ri6g0U3I2sirJfaSikqt7i8hKFEnT1rbJ9s4by6R7Ei8z5U/sLmp9FaSv29LHllgRo/hzZILpA+
	Zq6XwgMyG2oFa1JyXGuTF40LczeuCFRYFrSHeDhoNbBchJy5USh56E8JTtqpm5UqK8lEcK+h1N1
	SA3yG7jcrQOs3heUTz9WB6Gm6b4EHNxRQIpK5NXbi9PmOX0LDcY1pS8lYGgD275qdC9D3DJ+jYN
	ouLDqAd7S2BwDBpGMzt2+PvBA7QaQCVK9ub3SKAxcV3SAZEw8lbiLkhtO4k3Yd3Ekzhx/PFyan/
	YKR7C92z+XrS7OGg==
X-Google-Smtp-Source: AGHT+IFECUOJh/kQCZXkfjceoPkayINbc0PlakbHSK8mrhi5Vhr9ixmzAihZt8D3nVOZvTVomeEdcQ==
X-Received: by 2002:a05:6000:615:b0:42b:3d7c:c7ae with SMTP id ffacd0b85a97d-42b4bdd5999mr439440f8f.59.1762897739440;
        Tue, 11 Nov 2025 13:48:59 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:48:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 5/8] ovpn: add support for asymmetric peer IDs
Date: Tue, 11 Nov 2025 22:47:38 +0100
Message-ID: <20251111214744.12479-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 2cca759feffa..cb6cdf8ec317 100644
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
index 14298188c5f1..81b2dd946f33 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -15,6 +15,10 @@ static const struct netlink_range_validation ovpn_a_peer_id_range = {
 	.max	= 16777215ULL,
 };
 
+static const struct netlink_range_validation ovpn_a_peer_tx_id_range = {
+	.max	= 16777215ULL,
+};
+
 static const struct netlink_range_validation ovpn_a_keyconf_peer_id_range = {
 	.max	= 16777215ULL,
 };
@@ -50,7 +54,7 @@ const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
 	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
 };
 
-const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -74,13 +78,14 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
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
@@ -93,9 +98,10 @@ const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIME
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
@@ -107,6 +113,7 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIME
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
 /* OVPN_CMD_PEER_NEW - do */
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 220b5b2fdd4f..a66cc1268a43 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -17,10 +17,10 @@ extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_S
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
index c68f09a8c385..d9b332758f55 100644
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
index 8fb6e43ecff7..0657b1a6835c 100644
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
index b3c9ff0a6849..28cf97a86a18 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -54,6 +54,7 @@ enum {
 	OVPN_A_PEER_LINK_TX_BYTES,
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_TX_PACKETS,
+	OVPN_A_PEER_TX_ID,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
-- 
2.51.0


