Return-Path: <netdev+bounces-128636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7288F97AA27
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970F51C26F11
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F3139597;
	Tue, 17 Sep 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dkmnd4CI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8A12FB34
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535303; cv=none; b=B3VA0PaMH6FAJYaWUKQRgwlaiRtXHKnT4y3+ouu9Y1GYlpgXcc44E6q4YRXYcaEDbuGujq5cVBAYWr1Rz8sE+F10DmQ1Pv4kvtx87V6ZhUsj5aZ1ZRlY4vVBIVz9NjRARZBhI/ZqXcmMVZPBqN1LejQ974x8UWVDEkpU34xonhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535303; c=relaxed/simple;
	bh=7tpvSgRpOsAYhj5NbooZXf3Unw+fQ23HUZi0Rffu/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd/4zJS4A3p38KiTBo7kLrrfSw4bZ+YoHYyn3OALGJGR7nsZuBrcVpfUWqGZHX8zzAvPzO0AEbtXn9R92zgsIE08ZS5pRPcaJ2ggOm4sW7MtY6Bq/VgXnSlah2XdGPZtUYehvz6RBW8yxfPI22IE+DGuwIEVbFAcXdYWPmNltiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dkmnd4CI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-378f90ad32dso893970f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535299; x=1727140099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5NRfCWpCWBnRcIxR8uUbYY5HFHW4abm66fgUmlrpKE=;
        b=dkmnd4CIgrNpQSLU72bwSSQq/wY7sVQlxlt2YO/FygBGJotgKIPSn9wO5U9QwCOQcL
         O1Al0RrRTZ92/DqNgUsypjLxl+AbzDy+wDDpWDJlwHyBnYuSudxDTl05GHs/yxIH75lG
         lQsL5D//5tSesSY0ScZ/7NdQiE1RDfkkLd7n8XIttn2M5AVuHAU6XvaJgX8MX8jmYj5C
         6bhbGYn3hX/4T3vuJzvDJdHHEDx0jwMYoIIwZ22ToVE/PiXzj4gXvyCs0ab3he40lBtf
         sK2VtY4Ybw7SlJOe2B83c9y6mshzDec3h6pyfSvyn3gjoIByVHX4PmDxyELRcRbYDV0s
         pa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535299; x=1727140099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5NRfCWpCWBnRcIxR8uUbYY5HFHW4abm66fgUmlrpKE=;
        b=SVMeGboIZ5eSBksJkghK0Z3LZtV/jEPsBl3i+fk7/DMgn7RBOmjLm914QQYxApwjKy
         MhoNK+K5leU1gQj6OYYvjVAAwbR/jfwVQ6cI6H7b/odgB3T6x9Y1TL1GoaqDOuigxSmb
         NIob3ynqlIQcpFnDfGheDH5v0+qbKRXi2jKNGzuYdcHpcLTVloFT7+zWBShIX3BVnUfI
         ryGUbk8e6fMjDdAMhF6xeHY6C+IzAlp/cpWUXxLxeTz+ao5yt1YyH3V7URWxiZ0qi+h7
         /A1dzCcWakQwfP1I6kk7+SIM4VDCqym+c6bcYPnAmD9gRbAdUTa3lYmK+94iJjlSKBz0
         AZxg==
X-Gm-Message-State: AOJu0Yx/4ZoBkcFnohj1OXHqylZpUFQveRAfokTOSysQV6yQqks5wjaN
	vpeB/gzBKkjRyX6Qn6hdc76jUoLJ3s4pGXd0arGd4TVqnbzmM3UREGb+BNQ4bxQo0bB814I0yDF
	M
X-Google-Smtp-Source: AGHT+IGEPAWOhSrzlsnSDbEVmyE4rNaj6VaQmtQRIqmV09KiPi59CpuyleqKUznCfzP3kYL6qf7XMg==
X-Received: by 2002:adf:e552:0:b0:374:ba7a:7d46 with SMTP id ffacd0b85a97d-378c2d4d79bmr10674875f8f.43.1726535298816;
        Mon, 16 Sep 2024 18:08:18 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:18 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 19/25] ovpn: add support for peer floating
Date: Tue, 17 Sep 2024 03:07:28 +0200
Message-ID: <20240917010734.1905-20-antonio@openvpn.net>
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

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c |  10 +---
 drivers/net/ovpn/io.c   |   9 +++
 drivers/net/ovpn/peer.c | 128 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h |   2 +
 4 files changed, 138 insertions(+), 11 deletions(-)

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
index 4e69f31382d2..8f2b4a85d20f 100644
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
index 2a32bf4c286f..8dbe6ac46dd1 100644
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


