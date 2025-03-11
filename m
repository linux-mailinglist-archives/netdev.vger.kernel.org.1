Return-Path: <netdev+bounces-173856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE044A5C04B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B8117715E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D633C25A625;
	Tue, 11 Mar 2025 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OrZqsMW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3C25D544
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694616; cv=none; b=kZZOa8Q5YIJvngp0CXaMN9Clw9byRyCia7Gj7TER45mWLyTh6qvHWwYiZD2PhDQUvYevaoKLWNaiFj4bOuy6W4UKEVTmYUdloefVdrlaa8KeYkbu9RXkdGdQsThdzOk11woeekuW2ELl6MLYfUyb1V6GKp0oNY7aNfKjlpqLFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694616; c=relaxed/simple;
	bh=JSwqVjxBeHU4RACyPp9B4KuNViAULCMe3no65khXe0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoYZv/NTp15ujmQVs1JpYqQdm9cmy6B6Ut8NKaN9WY2NCy3bogm2HuHYbm+TNr/88jtJLMOPz1Gsub3dmb5o25rio8lbM1DdcaLtpjHrxq9/oWy7ODalcX/IPemXmARsVxjOKuPmPVgCIbg/jQ9mCu4TriNrfl/9CPfqE0fBDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OrZqsMW7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so45620325e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694611; x=1742299411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVuW3EWeVsK9JR3HnkSCXUo7RY6n+BdBr5woCe0mSnk=;
        b=OrZqsMW7QWBZKqsr5+OencUS3VrmHAUzHqCQcO5Ynibcgka10FaSd7Mlm/OkjDOdyI
         dzGWxL2jWeiK8ISQsWCqSCeR4UIvCPP0OCEYifKrf64djPN/qRXD5Os1eq4WKeu41HF/
         cQJgVUfXmR5JojJ+AYhrOlySgopjN87HkeYSFmShY4sjfvca7E5Z8C+wogsY9dCs2p/Z
         nF4n4jUf3F02Q4BqS8UiL3EupRQZOIJMIg5vdAsixImcMMQO0VDLxnPzCAU5/oqW1/Sj
         psshvDSh5VhYL+mimlrUtFNCG7+R7AhFwX7hsxB4RVXehWZcN8Efa7wphas6c7Qd5m2S
         mTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694611; x=1742299411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVuW3EWeVsK9JR3HnkSCXUo7RY6n+BdBr5woCe0mSnk=;
        b=QVjlVD28pF3qBTWPoB0/Tiz89IqCsHUOsYgTJH6LHwNiVG9ndrOCIkxEpoxwvBIyt7
         uHM/tkfIPffpeiQEuU4peUFrb0rj/07QOdjE7/JfT3RvG94XX42AjMdvP6l10zXrwKr3
         i7loMxKLcDz2Aua5jRf31DTCeMW3CXOt8aPMgodL/ES++ZthKp8wdmwxhK/1Xapl4fJ9
         Tb/oeMLoLM3n9OQBK0ALBRJ8MaIkT+/6QAarf1b48Ikv/0Xk4I6jPSZ8wlHZwUziQFPX
         YII4yboitfLhBOxemA7FIivr4Lx0skGYCpVbjObBvljuYfTIV1LOXGv2IRbVPPRL2tKB
         267g==
X-Gm-Message-State: AOJu0YydKKdLji5tgADk1KxHV/m3OFWx4kIqPddZvhlattwHKkqOE4PI
	L7ZuzL4de6PkAVBGhDzWiy/JlkfKoiJrGpy5uxQX9/lgxFdw2rP2s7RrO9ac4Ck=
X-Gm-Gg: ASbGncs8W5pnbmqAGjtQZoeTbAUmZIY5v7ak/nDl6IVbEIaA5Eufb+Y+CJCNGyA803y
	8zj+OD5Rn1iUcIV0r9s4bRAXI+6euE63gpfunJahH/wI1D6ODv62a5JUtIhP5Yhbjqmpj4dIRyd
	VKHoTr4B4ZfIO/MIYU9qakyfOnLnbjP161V4cDjGoTIPfqRSyKhakFC+GdvQnyflo9Dev596sOj
	8kO63iDb2PAXp1GuBe1Ouxu/XhjOyVnj5PYOgv1zIwWLOOyNkorUFixuwx7PbbRFxFRdhkxcfTn
	DspBUBeVPV3Lsvmx9wOeSIaZSmujJlc4cEgVFnQOgw==
X-Google-Smtp-Source: AGHT+IF7feaj7gfUMNW1JaD7De6BBDcb5CYoindegjiRedYIC18M7OyoZXCAGK4CIMKyQrC7xwvsWg==
X-Received: by 2002:a05:600c:198e:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43d01b875dfmr53243935e9.0.1741694611167;
        Tue, 11 Mar 2025 05:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:21 +0100
Subject: [PATCH net-next v22 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-20-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 h=from:subject:message-id; bh=JSwqVjxBeHU4RACyPp9B4KuNViAULCMe3no65khXe0Y=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZxSSJjAj0krRht15tiw9gxJsv9CwobB0XyJ
 8dSA0Cr9hOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcQAKCRALcOU6oDjV
 h1lkB/0f9zurgrBnhHQY/wq2m/f6JymZ34LaZXl2UFICCDlhkWeJdTujPcif2e6FvBwTl8RttG1
 pHb0ZkPf06RQHpwCQEFGXCja5INjPv4VEasTsOEHhV+hrH4/gy2+x9MfuoaoK1fBVyuILXb8R3+
 n5sFuNqXis7bTMU8D/sgvuVCo3Y96dS7Fa4LI/abVRLx7QyAE562+SaAWAHNFZWidynVp5wl3gR
 TwfL6UQh/oMI+TYEwr5Mm6zGC3knMLY+nd0PsNccQam1OlARbo9xeRZrkOLVMuMt3v7rfOdDalv
 9z6sEjEjJbSLVRouaw5G+bB4aqF807x5OBoLomoPg+aY+zp8
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
index 3c15d6d78f0f5ceeeb5ee39bfaaa7005d01a87fc..f6cb14c9ec4a8f12a99fe449f011bd0d633bf904 100644
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
index 487d24a7d26635c9ca0fd66c75717502f60e7a0c..4397253893ff2638b86b9d55bd21e11d0aeacf80 100644
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
index 0dedafea01858bddd457af0c95614e61c113682e..46500e4223d7619a342f803c67aa760166fa6f2b 100644
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
2.48.1


