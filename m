Return-Path: <netdev+bounces-122298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D689E9609AB
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5114F1C22C9F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DE1A3BDB;
	Tue, 27 Aug 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Pb/Kn9PT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736361A4B83
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760425; cv=none; b=H7qragJcdNE1f0sd0w2IF5VeYePjELHwH4pwDYrWgWXBCABMQ2N4v4dpd3iKTZc3JnOHTf6pgkxAX2XazqVt4boK1ELkwS1/pNZX8zm6H+2kXxsPLoVg6u9XyXTSAWMDp5KdVcQFrAAoTGU6WQSlsDvg4By17Ks8icwhr1kwzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760425; c=relaxed/simple;
	bh=Q9hIsEKx04HzGSTNpciL+4LhD1fVSitzswOdLKkg/vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzZ6tEw5d4DTiNXmJk2J0VKb/RxDN25uYdVqwaRQHrHocV76qIVN9nyXB57oRg9vqBxlO3D56GnsBrlSg+6Q6Ho3rO9z6iLM0zOINkW9jKlmm8RYa634N8QreTGqkVKrwlWzC+nTftNYkWrEkudzBE+/fcVE4K9Hfn+UsR+C7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Pb/Kn9PT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso48484985e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760421; x=1725365221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAFHPtuRgkni9Yjg9aQ8wWflxGodG0re09HQ/oQs4xo=;
        b=Pb/Kn9PT82cM3GJDp/GbXHZthdK6L7EgBdXK9xqJj7vUBO53ULPlJWHWPFqDl+vK2W
         FmeOAGToGfL/oBwdpQtC0cTm8LWmL7sCP6fv8OJSVcLG8b+s4MOUuCcpqStrbYqyWMhQ
         3q/yQmqzCBeXnDmNau8Hgwe5Kxuk+Cv/RfFHlBmkTzZiVTrR9fvDt4oYHYu8h7PD33kJ
         k5F011gLrt+HCLPBla73ARW7MKoDiFt+9ytxFd0FLw31ymfmcPWkLYkkObjYk5bZgwd/
         dzvvWKg1BXM/Ab4vD3kNbcv+g8KCIQiMIk5c5f6UrGmMec+p1XUnLUdCr2GB7pkkHUdT
         JPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760421; x=1725365221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAFHPtuRgkni9Yjg9aQ8wWflxGodG0re09HQ/oQs4xo=;
        b=lhkoK9RsKqp2rpvaAiiOLtLQK2neCDbcHQ9gx/IT5GCr1+y3q9aOu50f5165iRgSt9
         t3gykL3Z+/z9K1kC6VYla8aIrH+pTFA29srpEThtqht1PtW3vzgNdwgT6Wbe2u5Gge+j
         CeFSMGjtJI1NnBw3XTIDAaZcO0mGdmhlApz+3BdFrt+qAatNQb66FsXrpciXyVr6pZlO
         eyHEVcPtQ14UCIgkMBE7IKLGb2rhcvYJyNwrtjg8jIaOdqfzT+dLgwLu2jFhF7cAnaM0
         Zo850SAU49fvW1HmEEta1Mnuq6e8fecSCBt+EupThulMu2M1qpBCxxmAGUafrRjRRh69
         UBEg==
X-Gm-Message-State: AOJu0YzxYYiI9z10DB0mXUs3W93HRzWtsPVbPxzcM/InKRdwgwMwvDj6
	RJ5p3i9zmEJ1Abk7OKX5AMUeHfjzsN69sLD0dFv/jAhB52r6J4FKuMXUEPYS2UmcM1mKWbwUZh2
	e
X-Google-Smtp-Source: AGHT+IGSAR8gRGLfyjB6LKZnLuPMMN8vBNC6xuwrDiOkcR5YiCb9h08Tv3o4vthm43KyddvliAp8iw==
X-Received: by 2002:a05:600c:3501:b0:426:6320:7ddf with SMTP id 5b1f17b1804b1-42b9ae3f38emr15209495e9.35.1724760421437;
        Tue, 27 Aug 2024 05:07:01 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:07:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 22/25] ovpn: kill key and notify userspace in case of IV exhaustion
Date: Tue, 27 Aug 2024 14:08:02 +0200
Message-ID: <20240827120805.13681-23-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
 drivers/net/ovpn/io.c      | 13 +++++++++
 drivers/net/ovpn/netlink.c | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  2 ++
 5 files changed, 96 insertions(+)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 0bceaef32f5b..3a576254b346 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -57,6 +57,25 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 	mutex_destroy(&cs->mutex);
 }
 
+/* removes the key matching the specified id from the crypto context */
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
+{
+	struct ovpn_crypto_key_slot *ks = NULL;
+
+	mutex_lock(&cs->mutex);
+	if (rcu_access_pointer(cs->primary)->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->primary, NULL,
+					 lockdep_is_held(&cs->mutex));
+	} else if (rcu_access_pointer(cs->secondary)->key_id == key_id) {
+		ks = rcu_replace_pointer(cs->secondary, NULL,
+					 lockdep_is_held(&cs->mutex));
+	}
+	mutex_unlock(&cs->mutex);
+
+	if (ks)
+		ovpn_crypto_key_slot_put(ks);
+}
+
 /* Reset the ovpn_crypto_state object in a way that is atomic
  * to RCU readers.
  */
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 228833db51a1..a620c3a3a43c 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -133,4 +133,6 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+void ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 28dab793de63..b6739fc2bf33 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -218,6 +218,19 @@ void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 	if (unlikely(ret == -EINPROGRESS))
 		return;
 
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
 
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index f106599821eb..7cbad5a92b25 100644
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


