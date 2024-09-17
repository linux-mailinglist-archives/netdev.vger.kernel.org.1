Return-Path: <netdev+bounces-128632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF397AA23
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5802628A536
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623676410;
	Tue, 17 Sep 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OByEvMCM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7775338D
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535299; cv=none; b=iUGAySndPuJvH03rZvw8pKRNAXLw7H70XfIABnfqUE1zwrAdu8QeYr0+piHjl1Elm5dq1PhRoZZ0secku8K9LGiGahy4CfeXQEFCYn2ZrrrXxRkKwLFdP0VEM42A8k0NlXFaBCDid2SnAgiuxWmb0KxchBinMH3eRYaS7MlbH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535299; c=relaxed/simple;
	bh=latZ0sog6JTJDN1OQhhxqsnqbC01e/1KltFWOaOINoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKLUiaTYi/DIer2IlkrplQPk+dx171w0B+x+N8DNc5bIgBizAPtS0Co5KtOqFgMAhgI0iWIOXgi1RRu33A5MnppUFAiNmTzQOSNA7AilprtBHwojXbDBa3jPjKcfGcsCq6E3maIrgJhePwOZLzKvQKH+Rxex2BQgMNN3kwrRQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OByEvMCM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so31543695e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535295; x=1727140095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/5Q88ZCj6N4rHmI1lKwrJbL37tgWCzlPAQ6NjwZ3xc=;
        b=OByEvMCMGbwQJFFXJcnPrIcO424I7+AfmhEfpGisVcOSqd4qkN53eCtPMCCGl17qFJ
         GCXGTs4tARfsmY7fyw1GWlgXABCFVS7YW5H1324jyHW1hE66Eb0VMXJuvJHknfChjwUQ
         ZfCxJDzgF06g3CRdsRDwVA1FsdDVLEjRm9QcGS2bUvC6Q6gY24OKZjZy3uQKTqKFCBhq
         wmcgLH3npE82F9jMUev4rMEsg3459o5bDUo4F3pV2JGnwXhttVHMw7C1qcwtYUpc24A+
         tvJmtjtIkNlB/oSJaU7JcFyW3pWBG/6jlhI4AwSl676wdzh73AYegypz+zg7i11GDutv
         gyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535295; x=1727140095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/5Q88ZCj6N4rHmI1lKwrJbL37tgWCzlPAQ6NjwZ3xc=;
        b=r2rXxJB6AM71h6KmxwtTU4ffhrWRok5vFUxeaWUXej6y4DqViFrL4uwQRZsyBMXxk4
         GxQiR+qW9B4yzeoHjV5uARHDcs1bmpaQX9r5dUAWK3WXfGQj0GQb2CYnCs+oqSYb+nKr
         scVYQe4jcvN2ZrqdfFUN3rcalB6z9Oa6jkjHEt5gWNr9bpJ/JlOal2LdWLnHxiBhS13y
         S8xzMxArWCLJQUJLNvIgq/vOK4NcxrV2pBFM78+EGo459wSNLyR2jvRak2xr0NP3r5vc
         sfEe0bvDhGYj2xNCN7Ekrrr6xkppjIafXP9HAtviU4KJm1b9PKRa2rQKALialkOmbbdt
         +g+g==
X-Gm-Message-State: AOJu0YznSZbnewjlohTg7vJTjxMfRnIcjQueZ209bNPUk06okL3WZlfc
	2X/q6Sru6jmvo9Se74fUImjvj0Y2m50B2/TgxVe1UEC7JhySZgN9OqyH9OflQUG76wT/P12OrPj
	N
X-Google-Smtp-Source: AGHT+IHKFRU6ZgyRWSQlWzXQ9iSnW3iviQjPe9OvPuuZz5MkC/9gGxCaEeFU2N3YHh9/r8gK8OBCOA==
X-Received: by 2002:a05:600c:1d9b:b0:42c:b9a0:c17c with SMTP id 5b1f17b1804b1-42d96508943mr73827825e9.35.1726535294867;
        Mon, 16 Sep 2024 18:08:14 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:14 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 15/25] ovpn: implement multi-peer support
Date: Tue, 17 Sep 2024 03:07:24 +0200
Message-ID: <20240917010734.1905-16-antonio@openvpn.net>
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

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c       |  50 +++++++++-
 drivers/net/ovpn/ovpnstruct.h |  18 ++++
 drivers/net/ovpn/peer.c       | 174 ++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h       |   9 ++
 4 files changed, 241 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3fa130abf940..97cf93f06d8d 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -50,13 +50,53 @@ static void ovpn_struct_free(struct net_device *net)
 	struct ovpn_struct *ovpn = netdev_priv(net);
 
 	gro_cells_destroy(&ovpn->gro_cells);
+	kfree(ovpn->peers);
 }
 
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_struct *ovpn = netdev_priv(dev);
+	struct in_device *dev_v4;
+	int i, err;
 
-	return gro_cells_init(&ovpn->gro_cells, dev);
+	err = gro_cells_init(&ovpn->gro_cells, dev);
+	if (err)
+		return err;
+
+	if (ovpn->mode == OVPN_MODE_MP) {
+		dev_v4 = __in_dev_get_rtnl(dev);
+		if (dev_v4) {
+			/* disable redirects as Linux gets confused by ovpn
+			 * handling same-LAN routing.
+			 * This happens because a multipeer interface is used as
+			 * relay point between hosts in the same subnet, while
+			 * in a classic LAN this would not be needed because the
+			 * two hosts would be able to talk directly.
+			 */
+			IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+			IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+		}
+
+		/* the peer container is fairly large, therefore we dynamically
+		 * allocate it only when needed
+		 */
+		ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
+		if (!ovpn->peers) {
+			gro_cells_destroy(&ovpn->gro_cells);
+			return -ENOMEM;
+		}
+
+		spin_lock_init(&ovpn->peers->lock);
+
+		for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
+			INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
+			INIT_HLIST_HEAD(&ovpn->peers->by_vpn_addr[i]);
+			INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i],
+					      i);
+		}
+	}
+
+	return 0;
 }
 
 static int ovpn_net_open(struct net_device *dev)
@@ -202,8 +242,14 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
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
 }
 
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 65497ce115aa..66c90682c7f0 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -14,6 +14,22 @@
 #include <net/net_trackers.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_vpn_addr: table of peers indexed by VPN IP address
+ * @by_transp_addr: table of peers indexed by transport address (items can be
+ *		    rehashed on the fly due to peer IP change)
+ * @lock: protects writes to peer tables
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	DECLARE_HASHTABLE(by_vpn_addr, 12);
+	struct hlist_nulls_head by_transp_addr[1 << 12];
+
+	spinlock_t lock; /* protects writes to peer tables */
+};
+
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
@@ -21,6 +37,7 @@
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
@@ -31,6 +48,7 @@ struct ovpn_struct {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 6d34c56a4a51..60d75be336b8 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -65,13 +66,12 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 }
 
 /**
- * ovpn_peer_release - release peer private members
- * @peer: the peer to release
+ * ovpn_peer_release_rcu - release peer private members
+ * @head: RCU head belonging to peer being released
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+static void ovpn_peer_release_rcu(struct rcu_head *head)
 {
-	if (peer->sock)
-		ovpn_socket_put(peer->sock);
+	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
 
 	ovpn_crypto_state_release(&peer->crypto);
 	ovpn_bind_reset(peer, NULL);
@@ -86,9 +86,10 @@ void ovpn_peer_release_kref(struct kref *kref)
 {
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
-	ovpn_peer_release(peer);
+	if (peer->sock)
+		ovpn_socket_put(peer->sock);
 	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
-	kfree_rcu(peer, rcu);
+	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 
 /**
@@ -309,6 +310,90 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
+
+/**
+ * ovpn_peer_add_mp - add peer to related tables in a MP instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
+{
+	struct sockaddr_storage sa = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+	struct hlist_head *head;
+	struct ovpn_bind *bind;
+	struct ovpn_peer *tmp;
+	size_t salen;
+	int ret = 0;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	/* do not add duplicates */
+	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
+	if (tmp) {
+		ovpn_peer_put(tmp);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	bind = rcu_dereference_protected(peer->bind, true);
+	/* peers connected via TCP have bind == NULL */
+	if (bind) {
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			sa4 = (struct sockaddr_in *)&sa;
+
+			sa4->sin_family = AF_INET;
+			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
+			sa4->sin_port = bind->remote.in4.sin_port;
+			salen = sizeof(*sa4);
+			break;
+		case AF_INET6:
+			sa6 = (struct sockaddr_in6 *)&sa;
+
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = bind->remote.in6.sin6_addr;
+			sa6->sin6_port = bind->remote.in6.sin6_port;
+			salen = sizeof(*sa6);
+			break;
+		default:
+			ret = -EPROTONOSUPPORT;
+			goto out;
+		}
+
+		nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
+					   salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+	}
+
+	hlist_add_head_rcu(&peer->hash_entry_id,
+			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
+					      sizeof(peer->id)));
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		head = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					  &peer->vpn_addrs.ipv4,
+					  sizeof(peer->vpn_addrs.ipv4));
+		hlist_add_head_rcu(&peer->hash_entry_addr4, head);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		head = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					  &peer->vpn_addrs.ipv6,
+					  sizeof(peer->vpn_addrs.ipv6));
+		hlist_add_head_rcu(&peer->hash_entry_addr6, head);
+	}
+out:
+	spin_unlock_bh(&ovpn->peers->lock);
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -349,6 +434,8 @@ static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
 	default:
@@ -356,6 +443,51 @@ int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 	}
 }
 
+/**
+ * ovpn_peer_unhash - remove peer reference from all hashtables
+ * @peer: the peer to remove
+ * @reason: the delete reason to attach to the peer
+ */
+static void ovpn_peer_unhash(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
+	__must_hold(&ovpn->peers->lock)
+{
+	hlist_del_init_rcu(&peer->hash_entry_id);
+
+	hlist_del_init_rcu(&peer->hash_entry_addr4);
+	hlist_del_init_rcu(&peer->hash_entry_addr6);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
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
+	__must_hold(&peer->ovpn->peers->lock)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp == peer) {
+		ovpn_peer_unhash(peer, reason);
+		ret = 0;
+	}
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
@@ -411,10 +543,36 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
  */
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 {
+	int ret;
+
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		spin_lock_bh(&peer->ovpn->peers->lock);
+		ret = ovpn_peer_del_mp(peer, reason);
+		spin_unlock_bh(&peer->ovpn->peers->lock);
+		return ret;
 	case OVPN_MODE_P2P:
-		return ovpn_peer_del_p2p(peer, reason);
+		spin_lock_bh(&peer->ovpn->lock);
+		ret = ovpn_peer_del_p2p(peer, reason);
+		spin_unlock_bh(&peer->ovpn->lock);
+		return ret;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
+
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ */
+void ovpn_peers_free(struct ovpn_struct *ovpn)
+{
+	struct hlist_node *tmp;
+	struct ovpn_peer *peer;
+	int bkt;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id)
+		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
+	spin_unlock_bh(&ovpn->peers->lock);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 86d4696b1529..dc51cc93ef20 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -30,6 +30,10 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @hash_entry_id: entry in the peer ID hashtable
+ * @hash_entry_addr4: entry in the peer IPv4 hashtable
+ * @hash_entry_addr6: entry in the peer IPv6 hashtable
+ * @hash_entry_transp_addr: entry in the peer transport address hashtable
  * @sock: the socket being used to talk to this peer
  * @tcp: keeps track of TCP specific state
  * @tcp.strp: stream parser context (TCP only)
@@ -62,6 +66,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_node hash_entry_addr4;
+	struct hlist_node hash_entry_addr6;
+	struct hlist_nulls_node hash_entry_transp_addr;
 	struct ovpn_socket *sock;
 
 	/* state of the TCP reading. Needed to keep track of how much of a
@@ -126,6 +134,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
 void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
+void ovpn_peers_free(struct ovpn_struct *ovpn);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb);
-- 
2.44.2


