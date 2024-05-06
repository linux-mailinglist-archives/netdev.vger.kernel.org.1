Return-Path: <netdev+bounces-93570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2E8BC551
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA691F21EC3
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C345C18;
	Mon,  6 May 2024 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BbL3ZATE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0845037
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958153; cv=none; b=IeKpeT2s0Zo5IAJxqZ6XBbrcuzGPLAs7oguccXLl2VKYv0eUOaGaO7Hx0lJ1Nj3tKQlc7RdH4cPBkweHevEj5d+2B57zq7LlUGc8Hnx1ROGBGggtp1QgjX1eRQKWJpBSZ+qOzn6grJ52XWF7DJadxGXnJZucrs50KvRrfUMt9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958153; c=relaxed/simple;
	bh=A+XshI0QPeMHcy8V9cB4RgoDDDYRSxFonZIHx1VoV8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLW1SF4Ci4cqv2/gaa8AFMkPTgRf+AskECBMgCqrbWXJCKjxViqkZmf9dlICkgauI/waHN7FLPHCo3s6GONlGHToFkWvkASVwl/cMgcGG/29fiNp0bJ/tt7t1e8UNJUqqGtdsiw7BlWORjsIAgalCp6SLuYPjpqIt7uSQ71rOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BbL3ZATE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346359c8785so1210350f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958149; x=1715562949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMfyhiQmvBx16FSgtF/Bgm7DQptdUjst7oKEykvXw3A=;
        b=BbL3ZATEL2sPTaWIx0bytzYcaXccySMW1rVpICXPeVxbaIInuYmIa/vXHh+4HPD6eF
         LwfTqDSWQf0RvmSU7RB1bTKJLgeXPdO8gNmyq2HF+/g5pS/oZbj7lDbsvzDk1ESwyAnY
         cPJXTV0yCDeN9KCkkPV1b+A/5ustrcsQ4+yB9AKSKoH+jQlqOBH1qRQf1SnD1hL5g5Op
         CKRTnvBoD9on0+MVFct5lXt6tH3aFvGwNX+6UTPL4IEtXTA7qaKtOP1oQ5cSZM12sJvP
         GVxxHpJLIC/55Qx/Vlpsn7e97RX9Jmmso7XaVG/dsCUCFNH2vRkejuZA70TN7+PdmZo8
         yWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958149; x=1715562949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMfyhiQmvBx16FSgtF/Bgm7DQptdUjst7oKEykvXw3A=;
        b=LN7QHHeV8fW1rN0a5s81dCJXcFSfFDFhDaYIfEgbkdOdaMmJVZ7zIeLVWXRFUL8npu
         pxIxKYdmE/zOjzn+zHP+KQp5uhVOmMWkIUWz0kIX6u9VRQNfYQVnfSp8Cu23B8byWTxW
         NVXuXAV9/jGRDGhTylRVdlYW/gu/tCLCUClyG6yNGT7wooUCbX1W/KfYw5/qZDLXHg4R
         gS4OSnTbVEDSm9Nvp99HDw7nr+4ao6fKNORiBmlP9zD+jwsGerF8DjeEg3aisu/L6DQI
         1iePzym4A4G+KyOTimtwZTfIl3GfaC5aogE63KQCVN/KwbkAsN9FW/ozbWnK9p7d6BTI
         9K1w==
X-Gm-Message-State: AOJu0Yw2jSrhAUHMgpYoa5i/yyiqfhD6HbpZgYd40tNv/XA3zwZ7M+69
	4x5TDZJh99RcnSGWtGf2+8M0z6Y1gZJJ5x5OMz0/gm2WgVnemNtvpjjv6jb0lV43CyrJ57w+MX+
	L
X-Google-Smtp-Source: AGHT+IHoV2lYH7XBze3xLfOUm4zGR6diCNFSeg4aeF5LhnYpguVcLoov9rigZiAkOVVywBcrI8rsVQ==
X-Received: by 2002:a5d:4444:0:b0:34e:3357:37d2 with SMTP id x4-20020a5d4444000000b0034e335737d2mr6085709wrr.11.1714958149275;
        Sun, 05 May 2024 18:15:49 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:48 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 14/24] ovpn: implement multi-peer support
Date: Mon,  6 May 2024 03:16:27 +0200
Message-ID: <20240506011637.27272-15-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |   1 +
 drivers/net/ovpn/main.c       |   8 +-
 drivers/net/ovpn/ovpnstruct.h |  10 +++
 drivers/net/ovpn/peer.c       | 149 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  14 ++++
 5 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 49efcfff963c..8ccf2700a370 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -36,6 +36,7 @@ int ovpn_struct_init(struct net_device *dev)
 		return err;
 
 	spin_lock_init(&ovpn->lock);
+	spin_lock_init(&ovpn->peers.lock);
 
 	ovpn->crypto_wq = alloc_workqueue("ovpn-crypto-wq-%s",
 					  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0,
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index a04d6e55a473..d6ba91c6571f 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -176,8 +176,14 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
 	ovpn->registered = false;
 
-	if (ovpn->mode == OVPN_MODE_P2P)
+	switch (ovpn->mode) {
+	case OVPN_MODE_P2P:
 		ovpn_peer_release_p2p(ovpn);
+		break;
+	default:
+		ovpn_peers_free(ovpn);
+		break;
+	}
 
 	unregister_netdevice(ovpn->dev);
 	synchronize_net();
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 7414c2459fb9..58166fdeac63 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -21,6 +21,10 @@
  * @crypto_wq: used to schedule crypto work that may sleep during TX/RX
  * @event_wq: used to schedule generic events that may sleep and that need to be
  *            performed outside of softirq context
+ * @peers.by_id: table of peers index by ID
+ * @peers.by_transp_addr: table of peers indexed by transport address
+ * @peers.by_vpn_addr: table of peers indexed by VPN IP address
+ * @peers.lock: protects writes to peers tables
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  */
@@ -31,6 +35,12 @@ struct ovpn_struct {
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
 	struct workqueue_struct *crypto_wq;
 	struct workqueue_struct *events_wq;
+	struct {
+		DECLARE_HASHTABLE(by_id, 12);
+		DECLARE_HASHTABLE(by_transp_addr, 12);
+		DECLARE_HASHTABLE(by_vpn_addr, 12);
+		spinlock_t lock; /* protects writes to peers tables */
+	} peers;
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 };
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 99a2ae42a332..38a89595dade 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 #include <linux/workqueue.h>
 
 #include "ovpnstruct.h"
@@ -361,6 +362,91 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
 	return peer;
 }
 
+/**
+ * ovpn_peer_add_mp - add per to related tables in a MP instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
+{
+	struct sockaddr_storage sa = { 0 };
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+	struct ovpn_bind *bind;
+	struct ovpn_peer *tmp;
+	size_t salen;
+	int ret = 0;
+	u32 index;
+
+	spin_lock_bh(&ovpn->peers.lock);
+	/* do not add duplicates */
+	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
+	if (tmp) {
+		ovpn_peer_put(tmp);
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	hlist_del_init_rcu(&peer->hash_entry_transp_addr);
+	bind = rcu_dereference_protected(peer->bind, true);
+	/* peers connected via TCP have bind == NULL */
+	if (bind) {
+		switch (bind->sa.in4.sin_family) {
+		case AF_INET:
+			sa4 = (struct sockaddr_in *)&sa;
+
+			sa4->sin_family = AF_INET;
+			sa4->sin_addr.s_addr = bind->sa.in4.sin_addr.s_addr;
+			sa4->sin_port = bind->sa.in4.sin_port;
+			salen = sizeof(*sa4);
+			break;
+		case AF_INET6:
+			sa6 = (struct sockaddr_in6 *)&sa;
+
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = bind->sa.in6.sin6_addr;
+			sa6->sin6_port = bind->sa.in6.sin6_port;
+			salen = sizeof(*sa6);
+			break;
+		default:
+			ret = -EPROTONOSUPPORT;
+			goto unlock;
+		}
+
+		index = ovpn_peer_index(ovpn->peers.by_transp_addr, &sa, salen);
+		hlist_add_head_rcu(&peer->hash_entry_transp_addr,
+				   &ovpn->peers.by_transp_addr[index]);
+	}
+
+	index = ovpn_peer_index(ovpn->peers.by_id, &peer->id, sizeof(peer->id));
+	hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers.by_id[index]);
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr,
+					&peer->vpn_addrs.ipv4,
+					sizeof(peer->vpn_addrs.ipv4));
+		hlist_add_head_rcu(&peer->hash_entry_addr4,
+				   &ovpn->peers.by_vpn_addr[index]);
+	}
+
+	hlist_del_init_rcu(&peer->hash_entry_addr6);
+	if (memcmp(&peer->vpn_addrs.ipv6, &in6addr_any,
+		   sizeof(peer->vpn_addrs.ipv6))) {
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr,
+					&peer->vpn_addrs.ipv6,
+					sizeof(peer->vpn_addrs.ipv6));
+		hlist_add_head_rcu(&peer->hash_entry_addr6,
+				   &ovpn->peers.by_vpn_addr[index]);
+	}
+
+unlock:
+	spin_unlock_bh(&ovpn->peers.lock);
+
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add per to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -391,6 +477,8 @@ static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
 	default:
@@ -398,6 +486,53 @@ int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 	}
 }
 
+/**
+ * ovpn_peer_unhash - remove peer reference from all hashtables
+ * @peer: the peer to remove
+ * @reason: the delete reason to attach to the peer
+ */
+static void ovpn_peer_unhash(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
+{
+	hlist_del_init_rcu(&peer->hash_entry_id);
+	hlist_del_init_rcu(&peer->hash_entry_addr4);
+	hlist_del_init_rcu(&peer->hash_entry_addr6);
+	hlist_del_init_rcu(&peer->hash_entry_transp_addr);
+
+	ovpn_peer_put(peer);
+	peer->delete_reason = reason;
+}
+
+/**
+ * ovpn_peer_del_mp - delete peer from related tables in a MP instance
+ * @peer: the peer to delete
+ * @reason: reason why the peer was deleted (sent to userspace)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_mp(struct ovpn_peer *peer,
+			    enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_peer *tmp;
+	int ret = 0;
+
+	spin_lock_bh(&peer->ovpn->peers.lock);
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp != peer) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+	ovpn_peer_unhash(peer, reason);
+
+unlock:
+	spin_unlock_bh(&peer->ovpn->peers.lock);
+
+	if (tmp)
+		ovpn_peer_put(tmp);
+
+	return ret;
+}
+
 /**
  * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
  * @peer: the peer to delete
@@ -444,9 +579,23 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 {
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_del_mp(peer, reason);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_del_p2p(peer, reason);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
+
+void ovpn_peers_free(struct ovpn_struct *ovpn)
+{
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->peers.lock);
+	hash_for_each_safe(ovpn->peers.by_id, bkt, tmp, peer, hash_entry_id)
+		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
+	spin_unlock_bh(&ovpn->peers.lock);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index ac4907705d98..10f4153f7c8f 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -26,6 +26,10 @@
  * @id: unique identifier
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @hash_entry_id: entry in the peer ID hashtable
+ * @hash_entry_addr4: entry in the peer IPv4 hashtable
+ * @hash_entry_addr6: entry in the peer IPv6 hashtable
+ * @hash_entry_transp_addr: entry in the peer transport address hashtable
  * @encrypt_work: work used to process outgoing packets
  * @decrypt_work: work used to process incoming packets
  * @tx_ring: queue of outgoing poackets to this peer
@@ -62,6 +66,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_node hash_entry_addr4;
+	struct hlist_node hash_entry_addr6;
+	struct hlist_node hash_entry_transp_addr;
 	struct work_struct encrypt_work;
 	struct work_struct decrypt_work;
 	struct ptr_ring tx_ring;
@@ -208,4 +216,10 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb);
 
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ */
+void ovpn_peers_free(struct ovpn_struct *ovpn);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.43.2


