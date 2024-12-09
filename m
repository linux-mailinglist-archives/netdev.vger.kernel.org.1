Return-Path: <netdev+bounces-150095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB449E8E1F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5184A281CFA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BC21B8F9;
	Mon,  9 Dec 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UQ6cDUW0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FA219EB3
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734408; cv=none; b=n0D/SIxySbtiJbhIwF/oR6HvV6EvUlfkxECAVqw1yGnav/LMLOZq1lnSKex5j5RsMGZlgLZMy7BCwsJZWAYqE/e/yanI1JPPlzrvgfzHVt2eHAOj0eZazJRmctYtLwvyH8Qhc7iw65GqcPZpPWdjRIqtX3g+id3l6NY0S7LF+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734408; c=relaxed/simple;
	bh=BmSG4nFIoJPZgNxaXPPXP4Eer5fmr9CpUdYsd+yrONM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Szi25Uvml+tmfXDYLDfTDgYhbe4RCvgxDixO0Ehs9odUL393v8GUgzofJ9pWtWdgcNBlKdOCBfrxYAPBYrZ7TzSX4PTUqg2tyA96YNnMtOnXthcx6FT3kVzkLbKM/bDHzt5dTMDL963qGdp+JTqeQKVp2Dl3nvspIsV6mUpU120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UQ6cDUW0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1521449f8f.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734402; x=1734339202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3R+GOh0/iF3PCRFibdLtPFpfofOS1kQjR2DAtfS4tU=;
        b=UQ6cDUW0TqXf9EoM+EPoCl4BZlxepGoDXkFe1vH5ADKISEpLif75VZ0e8/jRgExXqY
         mqeOqn/uqp23EJhY5lbTuVGv79teK30lHF5cehV5lohetE6dHqKpxuNeIvTde7nnLKFx
         nGNhliiDJUCkE2oGpUHr9eY3NeVtrFAN8UqZf9nDVS6ILgwavjtRhgRLcZuJBRlITVEt
         Y0eNMWQndP1zm0PenOi4jtTIEwtaUr6iZAK0YQoDMXkrWRRJm2StPu65xHiO0bS4VzL7
         /ruQRC5fB1xnIXmuHTIbFEO7ejIsQxHP9Z25NXJIxILrNnRaxrv5exMLAkjw1kxKN1U4
         kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734402; x=1734339202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3R+GOh0/iF3PCRFibdLtPFpfofOS1kQjR2DAtfS4tU=;
        b=TbviPb49Hh628owIHx0ISSpZIU+6CquI+bGlZxxHUwua2fFHAU7iH6zMlr5ujgMN1K
         wS6stvNohr8wvZmIcd+uRZHP4L8Is57941iT8rBGRjaWiqiG8YDbzL2pi2+kvtThDY2t
         IRnYO3VYaQxfb45XLXDqbYww9sAYBAivUEta8PQbrQ06derh2q7sJvk1qvSRH5shdSV0
         3wjxQZsi8N+WDpXhVeuLiDegKBxAXszUO9oONGh/v2JZsSRdAzFPwRs91HbyRauZmmBL
         pAP0VpuD9rk622x82tJpkjVMEbC1WNpVIa2XYyFqwqMjpxRauaGAU8kGd6eMmEw99Uxx
         lq4Q==
X-Gm-Message-State: AOJu0YxY6FhcP48LbF1yBEqLwj+2f0wRj8gp6xyeF6SA5dLyY2ffG8M2
	kIUkeL5X7pyEZCzEgkNGeOFL8oKoIn61P9dsMIrDRnGFcsO7MQHafR1dn+uFHsA=
X-Gm-Gg: ASbGncv5Qpgr9sv7ntxx3jCTYOHPlA8zjp9azDXOdaU9LU/rHIHCSD/bAdasnUe6pI5
	+SPLRR+u+sWotIHRjGuzT8jEibev78amf2pFY8wCGLOuusuXgl7wMEvIQOdwzhkgB5n0W4Wsrpc
	+bbhsGmSfpr68irsLL8BHBpDHum2aDjnyjsPQH701fmuu8ut62CC0FEPoOjh37AhQO4dl2VvZT/
	qm6xtJwGcQkSZooDTnwpkl3MDueTiCiGzKYEr0/Wo0PUJcN21zL26ATVU/i
X-Google-Smtp-Source: AGHT+IFy29w/5+GdLob9+01U+3P1uXuqg95mWvw7kJ+P0yOMVmlwAgsaVJF2kuqRktI8/yakwmsO5g==
X-Received: by 2002:a05:6000:402b:b0:382:30a5:c38e with SMTP id ffacd0b85a97d-3862b36c393mr7797173f8f.31.1733734401630;
        Mon, 09 Dec 2024 00:53:21 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:21 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:28 +0100
Subject: [PATCH net-next v14 19/22] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-19-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5711; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=BmSG4nFIoJPZgNxaXPPXP4Eer5fmr9CpUdYsd+yrONM=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOlhG0S+sns5GfA98HlseyaYrUdb4LX0hBsi+/IXqCyN3
 ebvet6sk9GYhYGRg0FWTJFl5uo7OT+uCD25F3/gD8wgViaQKQxcnAIwkadBHAzNpXerPF+uCl2Z
 4izOHctixWE/ex1DuG7TF/5dKzIuvONcwjJFdWa17LE7970t1aMi2OzjnW+7/8x48zqD+aPJH0f
 9zEWa8opuXdL7Pv5l3pwZGfhSur78LrfaIxfrAwrM18q2nN/woODcxIjVn+Y+LmEXXavGHD6vQ5
 O/xlwmRPjnWcMf3ydePOQfbi1gk3DMMeXAgcW+fqptUwsE1jHk90q7pB1Zm7Px0Q0B5Tb3zz1bY
 lfGP3BNl4+62mmSdpGT9Y/zgoXxrgnSb0vnTi9sW3w7JGeDjY1y4P17aU6C5WWJkZtuWrVk8mQH
 hjD9uuF81NHP7E2HAt/cB3b1syzmumcxSnzOvs8oNoUNAA==
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
index b1e2f976b4cfdf1a6f8a644eb5406f21830026e6..04a57685a546f0eeac4e9a68910adeff246f5284 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -243,6 +243,19 @@ void ovpn_encrypt_post(void *data, int ret)
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
index f4dfcaafdb9501999d25464a4ec9f096a16826c2..355cd3aa4849b518bc794152e6d9d0bce7ed0f6b 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1044,6 +1044,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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


