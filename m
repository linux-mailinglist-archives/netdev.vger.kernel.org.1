Return-Path: <netdev+bounces-128639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757F97AA2B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD113B2A4C1
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20B1384BF;
	Tue, 17 Sep 2024 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DjO3/REb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673B20322
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535306; cv=none; b=BOZpw1snWHGnEPnMXpiXd+JULxnf6YGOfgOBovwwgCax/VRM5x8FWOVDNJx/Dj4kt1q+1lH4VtmJ9f5tag17ZO5UTfo4F8vr7fvnF2/4oCLc2pY7zPd+0QO6G9Nzvcw9i/Uf+MUGL6eqZQFzCKJj2Ia0mtPi00KYP9na7yASHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535306; c=relaxed/simple;
	bh=ei6VfcdQUYLbUT0it4sLEDf6qzeSFAzLgqMcaRIGFWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu8mj/hmezwtDLMeHrmn7noIGH8km575G1Fd3Eub+F3t/+E6c1TdU9Xi0XiZ4Ob0lkHG0eWBxWb+n2SLXPevvgUk+lksQ4KZIxtzFh9+tm2feoHxbHfz+hH7G7AyWsirZ8PZAwJwqPWebnyzspE1CViQbif+tusR9UZO+pnzqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DjO3/REb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so3344855f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535302; x=1727140102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P39PZsCPGMWMm3CMUBS/1lD5PBMRDJK9w3Z1otFA6vs=;
        b=DjO3/REbp4bGQKBoy8C0HRVnEFqrM6wDFw7lBw3iyUlEJu/JUpXJwwv+9X50P9odzQ
         WmANm6LSuCDeXpvuUd6vgnv3wXrUX9/SPmYRxBS8MQ3D8yc+nUiqDnqWOlUylr07Kjsi
         5sT1rcGwEtM5+uoJxOPeDmj1HzAhb3x5/1raGL0L3JW38UiC8DlP80N6BfRG+Tza9Xpy
         UBDkslqRy5wJnoDs29hytKNvOxIwvNozeCtSMvIHCOkTDpXj6ISsgHdr8zJ7Tr5LYhZU
         dLTN9topFMMK7Lt4dH1/56SOCLYlYScB1YDpyNw8ycQ2A4iXPezzlbQ0moVDwEtXjnl8
         7fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535302; x=1727140102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P39PZsCPGMWMm3CMUBS/1lD5PBMRDJK9w3Z1otFA6vs=;
        b=ac/wXhG/Am4V1Byfo7umog/RwIQGHYw7anEIUspMlHP9EmFYOh+THnghAOvtaIvQGF
         BLLBV3IbZOFAwyOcyNvRSdLNzSBoAUYYYLnBEb4diV+au7bB7MudO16dpdAfUpgnO6EJ
         aIACgEfIqk4Yhhv8HWnIwAERtU3CuaIUdsqI68VS6pb+IzJdJ5xfh9Qv4ROsNf1z5uK7
         V6nMOaAY/qbY1CII+4Og2oe4K39XqJBua8nJMLsW253Q/FqoEByPbTq6TalkYPGVpAvr
         c/qWBH23mb9QtOque6f31kxWMdI+Zb382sebD803dqggv22HsQAlR+AU4rz6iHjR/97L
         /+gg==
X-Gm-Message-State: AOJu0YxOfJUpghxcJXPASk0OX3K2RZESdnYqcqvhwrlpTbjBiH/mU8R6
	bqVpoLUAE/+S70xBoDVShGYpBgPCZ8oyohkqSfQGn7PTzK/MhoIT/1w8GEOWE7Z+rBywesBMcd3
	J
X-Google-Smtp-Source: AGHT+IEkZNE25RuYmR7onL8CyC9RybXGKMHePk4iQDtsobC6CYNnsJoL3ankwZVaTN48xVr//EQPKQ==
X-Received: by 2002:adf:a345:0:b0:378:8dea:4bee with SMTP id ffacd0b85a97d-378c2d04d14mr8794899f8f.33.1726535302182;
        Mon, 16 Sep 2024 18:08:22 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 22/25] ovpn: kill key and notify userspace in case of IV exhaustion
Date: Tue, 17 Sep 2024 03:07:31 +0200
Message-ID: <20240917010734.1905-23-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IV wrap-around is cryptographically dangerous for a number of ciphers,
therefore kill the key and inform userspace (via netlink) should the
IV space go exhausted.

Userspace has two ways of deciding when the key has to be renewed before
exhausting the IV space:
1) time based approach:
   after X seconds/minutes userspace generates a new key and sends it
   to the kernel. This is based on guestimate and normally default
   timer value works well.

2) packet count based approach:
   after X packets/bytes userspace generates a new key and sends it to
   the kernel. Userspace keeps track of the amount of traffic by
   periodically polling GET_PEER and fetching the VPN/LINK stats.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c  | 19 ++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 18 +++++++++++-
 drivers/net/ovpn/netlink.c | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index f1f7510e2f73..56ae2f5e5c33 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -55,6 +55,25 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 	}
 }
 
+/* removes the key matching the specified id from the crypto context */
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+
+	spin_lock_bh(&cs->lock);
+	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->slots[0], NULL,
+					 lockdep_is_held(&cs->lock));
+	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->slots[1], NULL,
+					 lockdep_is_held(&cs->lock));
+	}
+	spin_unlock_bh(&cs->lock);
+
+	if (ks)
+		ovpn_crypto_key_slot_put(ks);
+}
+
 /* Reset the ovpn_crypto_state object in a way that is atomic
  * to RCU readers.
  */
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 61de855d2364..48ea6ae9f521 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -133,4 +133,6 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8f2b4a85d20f..239ce39edde6 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -223,6 +223,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 
 void ovpn_encrypt_post(void *data, int ret)
 {
+	struct ovpn_crypto_key_slot *ks = NULL;
 	struct ovpn_peer *peer = NULL;
 	struct sk_buff *skb = data;
 	unsigned int orig_len = 0;
@@ -235,15 +236,28 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	/* crypto is done, cleanup skb CB and its members */
 	if (likely(ovpn_skb_cb(skb)->ctx)) {
+		ks = ovpn_skb_cb(skb)->ctx->ks;
 		peer = ovpn_skb_cb(skb)->ctx->peer;
 		orig_len = ovpn_skb_cb(skb)->ctx->orig_len;
 
-		ovpn_crypto_key_slot_put(ovpn_skb_cb(skb)->ctx->ks);
 		aead_request_free(ovpn_skb_cb(skb)->ctx->req);
 		kfree(ovpn_skb_cb(skb)->ctx);
 		ovpn_skb_cb(skb)->ctx = NULL;
 	}
 
+	if (unlikely(ret == -ERANGE)) {
+		/* we ran out of IVs and we must kill the key as it can't be
+		 * use anymore
+		 */
+		netdev_warn(peer->ovpn->dev,
+			    "killing key %u for peer %u\n", ks->key_id,
+			    peer->id);
+		ovpn_crypto_kill_key(&peer->crypto, ks->key_id);
+		/* let userspace know so that a new key can be negotiated */
+		ovpn_nl_notify_swap_keys(peer, ks->key_id);
+		goto err;
+	}
+
 	if (unlikely(ret < 0))
 		goto err;
 
@@ -273,6 +287,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
 	if (likely(peer))
 		ovpn_peer_put(peer);
+	if (likely(ks))
+		ovpn_crypto_key_slot_put(ks);
 	kfree_skb(skb);
 }
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 5d1797accb20..e1b3cee4db77 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -911,6 +911,66 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_notify_swap_keys - notify userspace peer's key must be renewed
+ * @peer: the peer whose key needs to be renewed
+ * @key_id: the ID of the key that needs to be renewed
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer, u8 key_id)
+{
+	struct nlattr *p_attr, *k_attr;
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(100, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_SWAP_KEYS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	p_attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!p_attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	k_attr = nla_nest_start(msg, OVPN_A_PEER_KEYCONF);
+	if (!k_attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, k_attr);
+	nla_nest_end(msg, p_attr);
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_register - perform any needed registration in the NL subsustem
  *
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 9e87cf11d1e9..972d12fc8f93 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,4 +12,6 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer, u8 key_id);
+
 #endif /* _NET_OVPN_NETLINK_H_ */
-- 
2.44.2


