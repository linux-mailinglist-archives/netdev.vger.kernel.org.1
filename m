Return-Path: <netdev+bounces-171455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742F9A4D033
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12F73ADAE6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C01B1F873F;
	Tue,  4 Mar 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ez9AoeIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BE78F33
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048499; cv=none; b=FaP5rF3gKqZAxQYSqvbdB+qPNRF4JhWg1PZmeEgMtIUfciysNmaXYcTD1OsWci61MVXta8sC8a45Mcwxr7tru1LQM50c6yas5EH+bhEekGlYT/SYhqWIyu1hv2UH80q05pvpKnHm0vMfsoVl3bDmac7RmnPr8PmLaTOs9IXiqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048499; c=relaxed/simple;
	bh=w2mAU8sGAIXDXCRecoih274+ry9HjQbfV+iNcTW6FJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4Ilq8hfCGzJaAEaLFhZfe1yHXTqRyXn0guR0xVJ+Me1/7GNkDa2ELOkl0nfoCMSk0ADfyUIAqBK2WOk/sINarU4vOVkk3EYkNig8G5MD4vQq6oUVCWk0tmyb5+6RP30Khg+BYAN99moMrJOcHdH7IyiDEO3me1erXgDArCVSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ez9AoeIY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390e702d481so2197248f8f.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048495; x=1741653295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7PlX7QFxeB93JMoZt1uzj8wazy2KalvtOTszyd6uXs=;
        b=Ez9AoeIYpctn0hVPJi1dX0Nh1rUFsvbmj4SNGwQKcqdDGVZpLhx4ZGvpyQhb/PtjzV
         xPhd8gwrQnT5s89v2NFQZBC6eV2iJq2yG3JFbdrh8o222wjHuzRRJIofSEnhvHlMNBah
         CNGOPDGGO6+QWQwcv+AaD0dTsnV/0dlQI70OAgXix+x5giAsII5MpId1a+CXs1lAOspU
         i3panhpHyZ5Y+kP+zfCUxsPFnz/iBlcuRNdomrgwhnnVoBpxPypfIvFaUOsAiWecZU4T
         z/dJDdM6xLgJlHp5GoQmjeliLKyZ24eRFPgQhnnOOVIa/oJO+gEokObXrg66O+T8Qrom
         Ux/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048495; x=1741653295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7PlX7QFxeB93JMoZt1uzj8wazy2KalvtOTszyd6uXs=;
        b=iQPrDSXgeWAtlbeXeKl6rOSvA4FxH0jkvujtcf1dSa/CsWnub+V7X/hokD5eqnbzAU
         ZkDsd4P3RgurBYhVvnujZ0VjiQMWO/IpmnmtvwosiMZGaXkOgoRrwB7ChHT4vX1tbqpG
         2TOx1qBB02efjX9+kHgP84GzlnHstkw1GjLqUt3tl2+Q+W52HRgs0Ck3CcUSqNWYFEV3
         KJJDK7YSnKVC3b9sck44je9Fb9xZ5+ugcLJuzQjb2ZdlZItVp1/gFNWyPG7rKO+/LWKC
         uDsiZkbds0hQGVbMKZ1F8OQlvUbOMbgzuU9R8B10Hj9RFfLUsWN7x9prrpGWny3G89ks
         3lUg==
X-Gm-Message-State: AOJu0Yx4D/NG6qReCqbZC5W8rdrxOjr71sDuEavMa+L641Ex6NQeyCev
	brrK7TX6WAnAiRCdYk1OUcn/0mX4AQ/YlQ9pcXpN9MiGHHWEUsjsYoqaF9nZm5I=
X-Gm-Gg: ASbGncttKiW2VbaXGU5eb4RIBNFIuV8D1/FXyVNzHccEHu9RBZCpxLhuB8W189o+k6T
	N8XAQ7RGGioEQ4okjQASnLlPataNpLPgYe/OXRNofhGeMOP+sHUCkuFM9Pc6LDkycF1RqRQUaQq
	b+XtYtCAJkqDt3Yz4SjOOX2gFrnmtUbjhzIRp1LRJELx0jwpo8ceSrlU30pDdwxdjctpk1AVT4T
	LtwVt2nfsVqRg4GXBpMRL9KpZtfGQ6Qc5qf6ByHAL3yp2jS139NkZ8aRXYizgn3VkpAgADURPsT
	YWJ4+mMoZCaRsxNz6BcOM5yNjhsy0ous6uTuysO11Q==
X-Google-Smtp-Source: AGHT+IGr/iREDy2jFWdr3lXzaop82IKg9px4lsfDgtIGjR6Ul3awVUD0KxW3OrjpE1PsSghyKStx6A==
X-Received: by 2002:a5d:6d0f:0:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-390eca34b3bmr17021830f8f.43.1741048495023;
        Mon, 03 Mar 2025 16:34:55 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:54 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:51 +0100
Subject: [PATCH v21 21/24] ovpn: kill key and notify userspace in case of
 IV exhaustion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-21-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=w2mAU8sGAIXDXCRecoih274+ry9HjQbfV+iNcTW6FJI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqQUiHMMTcMGofGfEXBIgj/5xebz80qvz4il
 /z58uGavSiJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKkAAKCRALcOU6oDjV
 h7+lB/4gicXKYVoeRu48eqMDGZ1I0/QGvjWRplMo4Xr5s4mEI9xR/lwJhjtVyHMmV9zJsqzpRZg
 /lTzbpbihXhJASk2IeDtO/7QQDz7IVWhg0g9pO35/pxu8Uzypx4bUb6bddH5EbtqXZwRQiI1ktL
 LqKxvVSXHCEc4lPFssYJctYi9fCtyHpiPbbTes+8IroC0NArfd47lbNXCo1mOwbo6McAYAg2Hwg
 24atbM8QQvR+bhHvIlf4FbzEKYf0+AofkQQbYUfFDF9wMxJk7kHAx1dgbcz5FNV0ZdAn4u+ytg9
 WllqDvBXujOaksOX571k67cVLQLPzxrQ/Oo4q4sPVPH8j7El
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
 drivers/net/ovpn/crypto.c  | 19 ++++++++++++++
 drivers/net/ovpn/crypto.h  |  2 ++
 drivers/net/ovpn/io.c      | 13 ++++++++++
 drivers/net/ovpn/netlink.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 100 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index f30c59c1193a167d7f420d89b665e2e61c57d81c..b86340e51e0cafe2931221ce91a0f7a977e5a047 100644
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
index d6e888381c82d208c7ff619381858302ea6fbbc7..7c88927830020482ca4d357ac44d3b4916db0891 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 5b673eae255033b9d7d6e7890a46686403d7c222..d81c1a2a958c73e22e548d8e63fc78821b5eb881 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -255,6 +255,19 @@ void ovpn_encrypt_post(void *data, int ret)
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
index 3d8b5e02e103e4177f3abacecfc4b52eb7226b87..d1845c1b446c82111ae349092e779fd46824c83a 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1094,6 +1094,70 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	struct ovpn_socket *sock;
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
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+err_unlock:
+	rcu_read_unlock();
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
index 0d6c34e17082cc7c52dd9c5d5ed1e964925b3f4b..5dc84c8e5e803014053faa0d892fc3a7259d40e5 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,4 +12,6 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
+
 #endif /* _NET_OVPN_NETLINK_H_ */

-- 
2.45.3


