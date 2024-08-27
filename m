Return-Path: <netdev+bounces-122295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B419609A8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120061F2424D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27171A4F09;
	Tue, 27 Aug 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dS+QILF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B101A3BB4
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760422; cv=none; b=PzsKNcpkXygMWB9aQGcLh9dRr9MEWJbmBoDPOZl63g0fLdbS7bImyk6cWKofQxTNgf9XQ+xfgVaVTCKt5rrsYW9hgih561n0JVJOS/Uqk62qz0Bay23gLnrCzKv5MFVynYiCH4qyuTjOYTw91BRoT8N/1CoDGVISILTh3x4Fqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760422; c=relaxed/simple;
	bh=fP0OsJ2HZuj6POLL3/paW914v3FSdbKa6WDLovu2PhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVLczsvpArVlQqQGn3ZLrSILb8sPUouVGiPnhmHU9bqzC/rccBjq8uyQf1beEky8jwu2c4uYb+iFIaOF9cIz3od1B+MfeVdzrTUiuRiVTJW2LRjNWOAElgtREry6+IMkG8HSRPdo79SG7Ug0jPTjiZTXk//Kbz8oK+og4rFjIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dS+QILF1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42819654737so46255075e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760419; x=1725365219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rjtAxTYVVnso6IuG/tXplcS3Pf9S3L2HFDHtz7YO7o=;
        b=dS+QILF1twpj42Tsfj/wonJGVs/bBeMzXQZvyrkx7iy6Xx+q4usPh4M+8ldOeopkYj
         qi94WgUS2MY2DfPz2kYLshZ4XlpIhQdDmdYPOQvai4FJnjX4ofnfO/HI2mYo4pQbb4X6
         lkitPZI6+dPexMwC1UX58LOllQFaK1WZBPUo2SesUpblRalMFw2SP+BJh57/JWcssBEQ
         tAU3Gk602+0eREQ0DBt1Fvd1yIh45R4k3+oEaGlt2iGNSKOuF1/4va2uOgjbtPt/Jdye
         vCDswCti0aC9XlApaztANnkaDOqjQuMpjqHp+HYeDj7O1XbD++TIKx3B6fCI3tQV658J
         +v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760419; x=1725365219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rjtAxTYVVnso6IuG/tXplcS3Pf9S3L2HFDHtz7YO7o=;
        b=ZOGk57RbBAURxhn7xsBsHIXhQdmib87HgFVTBMeIoSefSo0u3xurUYdFLf1LaYt0vQ
         Iw778wvPfi3+2EhFc+V7uSiHtNKMUDFj7kLwYh0+p+qo1yU4Qd0cJxVo4QMVWDO5d6fo
         GJlbqjtgOYeUevqH42qhel1dAqmI0Te6KvXCS1wRyvZWranlbnVcjhkFl6V7mBNmr8OK
         fy3E1YrUGcctuHptTO7nUwoIkKjTxf70bcuLCwsXhZ69drzhQcK66U8OWbxKL1jl4Deo
         gSaWTWJcLEhhot36u99JondO/+vTltnF2WLtkwEZsHz4aG6xzxIrL5ngFopi3eLF7Wqk
         JgnQ==
X-Gm-Message-State: AOJu0YzcO5KcYK7ZC16s9pxEbLLXRrCaE2qpI1ZqKQ6bik9xFN0pzRA/
	VhhjqURyYrZYqpZwWjI1P9xRcTDF22+/i23pVlSK9bno2hFWbjyeqr2HasMDC4CmSNYse8vneOV
	0
X-Google-Smtp-Source: AGHT+IEp+zAeLksPapIDodvmDQuJr9Ih/fZVMSIcqPmwv65Kr2oJUIFWBm/wWXFGYracIJ3yLRWcuw==
X-Received: by 2002:a05:600c:35c6:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42acd55c3ebmr82591205e9.13.1724760418581;
        Tue, 27 Aug 2024 05:06:58 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 19/25] ovpn: add support for peer floating
Date: Tue, 27 Aug 2024 14:07:59 +0200
Message-ID: <20240827120805.13681-20-antonio@openvpn.net>
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

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c |  10 +---
 drivers/net/ovpn/io.c   |   9 +++
 drivers/net/ovpn/peer.c | 123 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h |   2 +
 4 files changed, 133 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index b4d2ccec2ced..d17d078c5730 100644
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
index 60b47350d841..28dab793de63 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -118,6 +118,15 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
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
 	__skb_pull(skb, ovpn_skb_cb(skb)->ctx->payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 63e3e83b4fa5..452fb9e521e4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -94,6 +94,123 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
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
+	spin_lock_bh(&peer->ovpn->peers->lock_by_transp_addr);
+	/* remove old hashing */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with new transport address */
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr, &ss,
+				   salen);
+	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+	spin_unlock_bh(&peer->ovpn->peers->lock_by_transp_addr);
+unlock:
+	spin_unlock_bh(&peer->lock);
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
@@ -104,7 +221,9 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 		ovpn_socket_put(peer->sock);
 
 	ovpn_crypto_state_release(&peer->crypto);
+	spin_lock_bh(&peer->lock);
 	ovpn_bind_reset(peer, NULL);
+	spin_unlock_bh(&peer->lock);
 
 	dst_cache_destroy(&peer->dst_cache);
 }
@@ -188,10 +307,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
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
index 2b1b0ad3d309..187e7d840705 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -162,4 +162,6 @@ void ovpn_peer_keepalive_work(struct work_struct *work);
 void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


