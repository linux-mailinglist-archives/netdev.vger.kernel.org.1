Return-Path: <netdev+bounces-151236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407F9ED8BB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B90C283237
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323D1F0E55;
	Wed, 11 Dec 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ry+A9//5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B721FF1D5
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952796; cv=none; b=W7naUXBiAnOP+ZTu37QrY4YWWYkaEHommygTRf6E7WPcGeF6wmsUVPexaj5/sNVBNNwBA4xHbdvc+NdvLOUVBOngiDSbFVhbVVzm+4ds3/7IVsPdJ2t9CBWsYgpXGVfH3gUm/mYSnAUGtQQDxJNgEwxj3QSRdiyfmB8jISo2ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952796; c=relaxed/simple;
	bh=xuzMZ+3q5CpnTHygRbWIssdBxFLHALCicSz1LI45LRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbmFt8vLSd/9es6Cdys/tpLflNoI7D3vVxF3m4LuE+Ask52d9ZTN7Z0f6ZWMNVgTg0F1GLOHEBxrGXMwBbgqDtWstHhRoZZkAnMGT4MJq3QJGDpsTLoQ7adVQ3ndcyzsYXEiRg5jeVQIzMyAMFYKBlbcbbVoPcKHgHJgZjFI/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ry+A9//5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38637614567so2282277f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952790; x=1734557590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPhDAT007TmwsGA+NA5JSAETDcj/VOb73F0yjGdMwaU=;
        b=Ry+A9//5WG5yT6LSjQWMG9ZYaEA5JpdTQwJCUN54U6IrI88x4h5v3jAVW688dwOTmj
         N2rwadGvXR2ejssdPJQZJgRqGmEgGoNEEvnhl6eIuwcvNw7cCfl0Vxfw8oBYTzESlcCv
         YeXynxhxGfgjXCASNtoOODZN/KSYIaZUVwR666o+idd2+sEACJ89JXe/FjxbA05cETHK
         lxkPS30KnImlMdZxx9UzbYsjl4vkPhWdSaeGdOjzLVmnmgeJMfHevOlsftAdCGPG8v4n
         OiVLFNDvafCph3P6LKyyTYmIjchaxvajMBUW0eOVL2d0ES5fqwiPY5iio3gx7GfJX3Ii
         GaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952790; x=1734557590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPhDAT007TmwsGA+NA5JSAETDcj/VOb73F0yjGdMwaU=;
        b=gXUBjBXrAbYpHPpMHx1Zu3Oe8WwXV9BFFKtLl4U2DRHu88niGcfJ8HrXLA5EFl6kH9
         gvw1b9wFmObdP2NgoxnrW7lG9ASRysVDAW3N9yq/psHOEqn3XG3wtMasH3+BM/8639AU
         tsOuO8rijFvs5/4mplO6qDuJ8xfevhM/8oKhCtCwhIYcoqmDssHcffE2D66EqW2XRgiB
         0QW0IjdpeUw8v/vaC+RCxYiBENtfgJ17jJ2Da/YdUVbElVQdcwVo7eS+cIXguDwXtqz4
         RrRM4/82Z1oQt8F0k4bVGmOcz2quBtjbUOK/sV/CeTqm3Td96dF5NbqYTJENb7uRxxMo
         jP4A==
X-Gm-Message-State: AOJu0Yz9ZJ3qb5ULowvvMnpz7alXrxTyPfoesuH/ZoelHGCz2BsEbqtj
	jEYk1pshGVFPnd4dWJVGZH/taRKb+ACI1yGha7gZcbttC9dpUN+xhlXEMs1gbxA=
X-Gm-Gg: ASbGnctejBye7fP+ZUBOy4AyjvaXgekvM7VM43u8v6EM2pu/E1K0eg9arTrUwLdTGtK
	lmSea8uaP1bUAxQVCrEaRxOmPjKBLpWl6QaIQNhcwkg162/olNiR4tuFBgwm96Xx6PaYaQlYRGa
	m4KdnWAIN5CDG2NxRKGJpiZJlZ+1VEK4vcpDC0KTzKedLBOZZ6HMgW63OrnQqcEYpak1EgiXU5h
	Wk9oBDwvehDq9GNEcXBao5jSpyDHhWQQnSTZ+Zj64tcWpEszw2cmGtOSG/rIJyBzA==
X-Google-Smtp-Source: AGHT+IE0YhsovgPBxXFEdPd+xgGpR+UgNeLyRzhYR+zbhtC3hJV0FgKCWvd/NhtidJ3LYUCuVgleEg==
X-Received: by 2002:a05:6000:1ac7:b0:385:fc70:832 with SMTP id ffacd0b85a97d-3864ce9727cmr3114423f8f.16.1733952790142;
        Wed, 11 Dec 2024 13:33:10 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:09 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:23 +0100
Subject: [PATCH net-next v15 19/22] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-19-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=xuzMZ+3q5CpnTHygRbWIssdBxFLHALCicSz1LI45LRI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUm58USR0wwgQMTx2EwnhBmvmqaFiUwSOpBg
 Wp5sHDXBquJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h5FkB/9XQVZE+/pPRwLb1KnOhC+n8peTnEh1i5D+LmXZFlyaHSvpQEZZxjTevb2ZAG9f1je25dH
 8ffxgnaVPetc/uMH4cKE0k2e4DHYvpIn0A+hJeRD3HxjrJ53h5vXnsvGfCi7fNmcDfKMCpFvpsO
 y26f/JSUq0SpwWgyQbSlH1k6zE49fpV10qGxe8ZzGzkSpC6iNwZPJKJj6XZ+LTQ9KN+lF9T2qYj
 uVcZLxp5Ahdj2iFdz4ySBLAGvHjSu02FofPXiKuxH5Sy+S/j+e7jIbL0nG4pkDCLYQjJqW0sYgF
 ObfKqCYD1mKS2xVxc0/kdj1enp8afX0C7gt+r3lknF/mb2sa
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

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
 drivers/net/ovpn/crypto.c  | 19 ++++++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 13 +++++++++++
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 91 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 6fccd73c6cf7d2566d1b819cb6d5d7b2ea98e81d..47a627822e95e3a1079a710c66037ec74173e653 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -54,6 +54,25 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
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
index 05ca312765a4551b3493dc6a27228e8ad48e99f6..2e338ea3b9542a067c1c53cb18bd12648d832cd9 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8162b12f7a36b897d685c70f1befd87d774826a1..8b9b98f9e962f17464e9d436b23c130d9ca0d764 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -244,6 +244,19 @@ void ovpn_encrypt_post(void *data, int ret)
 	if (likely(ovpn_skb_cb(skb)->req))
 		aead_request_free(ovpn_skb_cb(skb)->req);
 
+	if (unlikely(ret == -ERANGE)) {
+		/* we ran out of IVs and we must kill the key as it can't be
+		 * use anymore
+		 */
+		netdev_warn(peer->ovpn->dev,
+			    "killing key %u for peer %u\n", ks->key_id,
+			    peer->id);
+		ovpn_crypto_kill_key(&peer->crypto, ks->key_id);
+		/* let userspace know so that a new key must be negotiated */
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
+		goto err;
+	}
+
 	if (unlikely(ret < 0))
 		goto err;
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index f82057a4d1a9e6fd698698a4652d50c59d901bfa..0e68f023e95e6dcb41d07f960ea032292b28d0af 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1053,6 +1053,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
+ * @peer: the peer whose key needs to be renewed
+ * @key_id: the ID of the key that needs to be renewed
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
+{
+	struct nlattr *k_attr;
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
+		    peer->id);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_KEY_SWAP_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	k_attr = nla_nest_start(msg, OVPN_A_KEYCONF);
+	if (!k_attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_KEYCONF_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, k_attr);
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(peer->sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
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
index 9e87cf11d1e9813b7a75ddf3705ab7d5fabe899f..33390b13c8904d40b629662005a9eb92ff617c3b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,4 +12,6 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
+
 #endif /* _NET_OVPN_NETLINK_H_ */

-- 
2.45.2


