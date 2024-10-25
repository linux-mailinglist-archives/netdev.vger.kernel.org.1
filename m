Return-Path: <netdev+bounces-139048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E219AFDFE
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0E52857CB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920B206076;
	Fri, 25 Oct 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VXtZGgoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CC205AD7
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847727; cv=none; b=dIhLCAD71NfF3Yn26DZPNfiu1pBe8xB7/NZKXhfVGO5HFz/Xb3XRlrdrA2mpb1kms/XU0BN6+VlFTG8B43XjRK2WVcmHV/4YHzrh2EKCkaTO2Bz8pDNNYMFlnHcmgZ1Es7B+k88qSwDGdEfi3/WeUiESUdgq5Fav77uxgMoIMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847727; c=relaxed/simple;
	bh=TNdCndX2JUubPrBeGJqTvcGDcf/1aKtTZu6vFRBIIic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZGfr2qiLeW/MPQ/XxJmEBg/nwn5eNqmbCt7cKf5XrVWpOxW1kk/PyYNPgt7wSAKR4SYpfXyBjX3wWEpCGNGxA6n+JLgvLv9KPGvf+uShzgaefakBdrWRqEg4qq/9bLWkK/d1tbP0QWSimCt+m7qzRE9lwRsWVJ2b+GIhtHiVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VXtZGgoy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso18721025e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847723; x=1730452523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVdokSM+dDl/K4vWbVpcM2wInjsbKQVBO11TnSzdj9o=;
        b=VXtZGgoysSXHR+iNcvkUZYK7siK0aj+EQyAiZgyX8t5Eu6xpvA4EHAZZitMl9n8Q7d
         WyfcqpKJwY9KYO6qLKXdoUhVHxvTs+Tj0jaRsdtWCe8/HTzIEIvOm+eNdYlx+OIMoyzv
         GFeXh2TBEuvi4PnTyEwQSP0tL48cG9BrUjPBbeKFCS43/5YadKpFRq9ai13ZWNFPqAXk
         0VmHSTOPwAJYK3LSpbJStGjC5zxSZ7UaerG452UbPDsM3pJ4sJM3CIdsZWB0b5wVl5qA
         GBZFSSReZj+qqAdVuENcoSqVgdpbS+XZPCYRJ5pQJg1oaj2ScU5rXpsD3f+q5IA7M2AW
         /LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847723; x=1730452523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVdokSM+dDl/K4vWbVpcM2wInjsbKQVBO11TnSzdj9o=;
        b=DgOmX2ZeK/0znRzYo5DADcNYmXXmNZSv4h/nQejYrYPzDG7P3ImKdE9mqAHKtfuial
         QlQfRd1mUaImzYNYLoFZs7iUbk2b4rCFsUNvgQxyE87vzeDX8QlDfXl0SusrMITKP2Ls
         5XqzUbk4wmG0OX0BgeWdMSMYSKPn5xT5+UmawrS99K+pO7izG6Q1Q6/EansdRLlYUaLj
         D3KlbrNrU6bq59w015oXhwcPWqCijRoGFrt0D5pyy44UzpB0FT3hj1LbnQJAfxh9E2yS
         ScLX0lqL7j/m6LFgXT9bPy6hwt860hny/zz1hYCSY+zFCajimLqCZbbUpolfXP6hCSEW
         U42g==
X-Gm-Message-State: AOJu0YxmwGgURdHi0/W8d4D6z/J/anEPbB8lcQEQUaZLlNkXUWGmZ/C8
	GB9qdb5DxI5yOlXZ6Hi8EJmCjglzuxGgtYYkTCTM9pr92BqyranRE1BRkeIkyUg=
X-Google-Smtp-Source: AGHT+IHqrDlLpXvJ8rDvpLl96/81zz4/7VvAp4kuHZTmRBhjd2JbKh46jdFI94N+KiWEk+W3f1SBLQ==
X-Received: by 2002:a05:600c:3b93:b0:431:52f5:f497 with SMTP id 5b1f17b1804b1-4318a9182e1mr43550295e9.9.1729847722906;
        Fri, 25 Oct 2024 02:15:22 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:22 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:19 +0200
Subject: [PATCH net-next v10 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-20-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5688; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=TNdCndX2JUubPrBeGJqTvcGDcf/1aKtTZu6vFRBIIic=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GbaoUY0HmFsJMgBDTk80WgyGvVaNg3IR/CQ
 Id8ZhE1qQ2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmwAKCRALcOU6oDjV
 hwHICACHgvyu0b7/aXQn+QXMGJHDE5aNMY47qND9ZlXPth8J8orj2zh53IAICWd5aujMMDfVeOC
 TLukzL6jWh3bxrI7eEKlRwua4r5c/wLzWQue3clTuTqpxY5RbubntTgSLydsL1TPaS2OnsalZtt
 Wjw2lX9xq08WD/Y4YxEbQNzl6olk/rKEgI0674C6JTMcN6jeri+Mfp0EE3ewM49BQda0reaMZJZ
 I5k85AqNYShYjlDkndSQ0G8hUI50HIaR2E51w7roMPQMsRsw9GbgV8uJUEYJbE7H04kNKD0nypn
 S8HfUJLkHYpmuZipJmRRt2kYoXjWbVQtb7D8uNfEwtRD56lK
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
index cfb014c947b968752ba3dab84ec42dc8ec086379..a2346bc630be9b60604282d20a33321c277bc56f 100644
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
index 96fd41f4b81b74f8a3ecfe33ee24ba0122d222fe..b7a7be752d54f1f8bcd548e0a714511efcaf68a8 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -140,4 +140,6 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 			   enum ovpn_key_slot slot,
 			   struct ovpn_key_config *keyconf);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261..c04791a508e5c0ae292b7b5d8098096c676b2f99 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -248,6 +248,19 @@ void ovpn_encrypt_post(void *data, int ret)
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
index fe9377b9b8145784917460cd5f222bc7fae4d8db..2b2ba1a810a0e87fb9ffb43b988fa52725a9589b 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -999,6 +999,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	msg = nlmsg_new(100, GFP_ATOMIC);
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


