Return-Path: <netdev+bounces-131166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66398CFAB
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14711C22A8B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550E1CC883;
	Wed,  2 Oct 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dP7Ll++m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19C1C2DCB
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859824; cv=none; b=SyuwtBks6a6kMfCHe1U+OVro9FdE704lOx+H2B+rYCBe+toiKXMVH6XN757aD9szZjGb4SmMWalf9tW74rplRI4QaIgmA9SYO/Ft1lO9YS6WprC1YLZg2bJQPG7s99/uUhb6SP2IIGFDLMTJoSHZPg6ry9IN1FQKTxQBgOAyqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859824; c=relaxed/simple;
	bh=FuAy5kHlJKnyzlxHVywHgmUSOgYpPg1bhUmvEOmeEd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlX4+WW999GaT1udy7FWSGfjE+QA/+0kR1VQS+NrWVR52FCtT8JKJJ2yTjKAbMxR19Zars5CgY7g7YPtmhA+QoI9YVHfGc1jZPKAyV5jsJTMAlUWpMufsTMDqm2T1It9j6WBmoUZtFfe7OGhN7UJIVApUe1OqunXUw4BRxMMlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dP7Ll++m; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso2415024f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859818; x=1728464618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1ge8RFj87ePe1fJxGxvLo18nD2mofhoIzDaa4Vgsqw=;
        b=dP7Ll++mDjcwMyC+JxZY+ij98f6pRw7GCckOnZ5y29LXIg4phw0Dy7G0mEsRQtv2ZP
         AOTqsAJBBWXEExYkwYy0BCvkwykBe6r73feyffedURKh3gHor2PSlk+qzoY+4fikHK2p
         yFPVvlYfSIbhmMVXtA6OU4bndeRadJrPedoZ51m8ovx5vBxsXBBuFt4k7ZNZqSJgDRVa
         j0yqU5DVkwtr6SBh6QCZGsYOo5ksXLu0kfFa4A0c/ErCkANcdDRa/eYUkFoQbJyib4Ec
         EFCuxYdq17g2oRMIUk0RNMvqSWtndWboenDS/RKSlPHUCrBKq4YtVXad4MCUF15VN8ax
         D6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859818; x=1728464618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1ge8RFj87ePe1fJxGxvLo18nD2mofhoIzDaa4Vgsqw=;
        b=J4uUmZZaFEyFoJvPCMdZPLGVzel10JvDfa0lT3SllRiUJf+ylkbr3GtEaOUDUYKVWq
         tehkpB07Ez9bSBvrxdGtrSLws2cGfO0AbFnmC0lfeqI4vmr8n4R8iMAw+b1SKjsmMJMA
         Y84Zudl4bhUibm2Jzrafm8xrhRD0d8nt2dcndBjH+awbPb3vqpfFnLHdOgC2IH0CLZw5
         Vl+MqjEcTYpR1V3eEXgmXRuR/HGNQkkp/iOSQA1bIf+d2dL3eWWJZgeOZA0Fcw3OpJuE
         8e3wgekvMUiV9NozvVrOF2EbJM6BIYi75j+2M4YhTLzBVsBmxmDtm2CjbU4OTevIoA4W
         yZUA==
X-Gm-Message-State: AOJu0YyxFfo3eHSc6lwJmbEC1bArJhtPAQVJUA7MF85wsqMzk9ZAKcNV
	xXgeAJSpHu8jMqUz4FzcNNcQM1qowFbHdPLm860qQ5qLTOZeIva8JAJNu6qcdck=
X-Google-Smtp-Source: AGHT+IHQn6w8+6VgStUg9D6XQXu4qtWE/udO+C0cwI9N0zr24eLEbJvdFaTMXnX0HhixUEZ3f/RLVg==
X-Received: by 2002:adf:e447:0:b0:374:d1dd:1cc1 with SMTP id ffacd0b85a97d-37cfb8a490bmr1491379f8f.2.1727859818484;
        Wed, 02 Oct 2024 02:03:38 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:38 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:32 +0200
Subject: [PATCH net-next v8 18/24] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-18-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7156; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=FuAy5kHlJKnyzlxHVywHgmUSOgYpPg1bhUmvEOmeEd4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxTJyusJDPH1TX6vPHfibBEg6qpzzlVxoqZk
 DD2rnZlWW+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUwAKCRALcOU6oDjV
 h5Y3CACeRnHDDiwuBv8VvGSUkKhhSvCMthRqDSk7Jy5/7OxZata9a94PhS40HFwBr23e722OhuV
 YnbhrUwQ9JTN3Tt4xbfSYyigYnwFpZQvnBqaoiP8wj5Wup/EM0PGcF+vRrb98XPsGXdvE4Becuw
 O5i1QZ4PQ2YwrFC9ZGO1Xr6ejH6EZuo2J5ahuO1Tnj9SCy6MY2t3oRNZkQ21KS7LhOW1wg4JYOV
 PRIQ9s1Vk0a6sXDQVLwp97mfFJCwo0XoKl6iuzSn4vLwr05Y2D4ziPQamj+jE/ffs7pxKpBU49t
 h5TmWrg5PvXV4i6ZQ/iLA4oBGEco7uJiedkNqTPEizBA6Lfs
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c |  10 ++--
 drivers/net/ovpn/io.c   |   9 ++++
 drivers/net/ovpn/peer.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h |   2 +
 4 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index b4d2ccec2ceddf43bc445b489cc62a578ef0ad0a..d17d078c5730bf4336dc87f45cdba3f6b8cad770 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -47,12 +47,8 @@ struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
  * @new: the new bind to assign
  */
 void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
+	__must_hold(&peer->lock)
 {
-	struct ovpn_bind *old;
-
-	spin_lock_bh(&peer->lock);
-	old = rcu_replace_pointer(peer->bind, new, true);
-	spin_unlock_bh(&peer->lock);
-
-	kfree_rcu(old, rcu);
+	kfree_rcu(rcu_replace_pointer(peer->bind, new,
+				      lockdep_is_held(&peer->lock)), rcu);
 }
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 4e69f31382d2cb9ce4bc40f06cfbae47add5b5ba..8f2b4a85d20fbdb512de7ec312d391985e96b906 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -133,6 +133,15 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	peer->last_recv = ktime_get_real_seconds();
 
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		/* check if this peer changed it's IP address and update
+		 * state
+		 */
+		ovpn_peer_float(peer, skb);
+		/* update source endpoint for this peer */
+		ovpn_peer_update_local_endpoint(peer, skb);
+	}
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index f9d8f1d1827fe67dc4b4e0bba41a5b110bb90819..891cf2fa6a81b46ac764ad4fd50d4456fa7ce5bd 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -94,6 +94,128 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_reset_sockaddr - recreate binding for peer
+ * @peer: peer to recreate the binding for
+ * @ss: sockaddr to use as remote endpoint for the binding
+ * @local_ip: local IP for the binding
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+				    const struct sockaddr_storage *ss,
+				    const u8 *local_ip)
+	__must_hold(&peer->lock)
+{
+	struct ovpn_bind *bind;
+	size_t ip_len;
+
+	/* create new ovpn_bind object */
+	bind = ovpn_bind_from_sockaddr(ss);
+	if (IS_ERR(bind))
+		return PTR_ERR(bind);
+
+	if (local_ip) {
+		if (ss->ss_family == AF_INET) {
+			ip_len = sizeof(struct in_addr);
+		} else if (ss->ss_family == AF_INET6) {
+			ip_len = sizeof(struct in6_addr);
+		} else {
+			netdev_dbg(peer->ovpn->dev, "%s: invalid family for remote endpoint\n",
+				   __func__);
+			kfree(bind);
+			return -EINVAL;
+		}
+
+		memcpy(&bind->local, local_ip, ip_len);
+	}
+
+	/* set binding */
+	ovpn_bind_reset(peer, bind);
+
+	return 0;
+}
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
+
+/**
+ * ovpn_peer_float - update remote endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source address (remote) from
+ */
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_storage ss;
+	const u8 *local_ip = NULL;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	sa_family_t family;
+	size_t salen;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	spin_lock_bh(&peer->lock);
+	if (likely(ovpn_bind_skb_src_match(bind, skb)))
+		goto unlock;
+
+	family = skb_protocol_to_family(skb);
+
+	if (bind->remote.in4.sin_family == family)
+		local_ip = (u8 *)&bind->local;
+
+	switch (family) {
+	case AF_INET:
+		sa = (struct sockaddr_in *)&ss;
+		sa->sin_family = AF_INET;
+		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa->sin_port = udp_hdr(skb)->source;
+		salen = sizeof(*sa);
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)&ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+							 skb->skb_iif);
+		salen = sizeof(*sa6);
+		break;
+	default:
+		goto unlock;
+	}
+
+	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
+		   peer->id, &ss);
+	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
+				 local_ip);
+
+	/* rehashing is required only in MP mode as P2P has one peer
+	 * only and thus there is no hashtable
+	 */
+	if (peer->ovpn->mode == OVPN_MODE_MP) {
+		spin_lock_bh(&peer->ovpn->peers->lock);
+		/* remove old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		/* re-add with new transport address */
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+					   &ss, salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+		spin_unlock_bh(&peer->ovpn->peers->lock);
+	}
+unlock:
+	spin_unlock_bh(&peer->lock);
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_release_rcu - release peer private members
  * @head: RCU head belonging to peer being released
@@ -103,7 +225,9 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
 
 	ovpn_crypto_state_release(&peer->crypto);
+	spin_lock_bh(&peer->lock);
 	ovpn_bind_reset(peer, NULL);
+	spin_unlock_bh(&peer->lock);
 
 	dst_cache_destroy(&peer->dst_cache);
 }
@@ -188,10 +312,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl = &(_tbl);				\
-	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 6b66e169b33510a794f8f43dff757f0357e3e5de..ea1a014568c64d796bb18447ceb70e801bfaf3f2 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -162,4 +162,6 @@ void ovpn_peer_keepalive_work(struct work_struct *work);
 void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


