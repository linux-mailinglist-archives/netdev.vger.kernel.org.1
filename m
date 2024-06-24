Return-Path: <netdev+bounces-106085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5049148B7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17791C224CA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991813C681;
	Mon, 24 Jun 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EdYjMmEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D563715E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228608; cv=none; b=dxAD4ZtcXcsISCblj0Vpqm6RngXDjDV30DkhaB/a0BWieQjsefZYk8D2nizeUB2W+Z7EKZUFug5FMwf/114iwkWbyEyUAM36OuzfGAC76rU9/x7WhkDgqaFLfAyZ8b7jv8tf2nsQ8uARhimuhH4P/UamtN9kkMSOaTORTIjStAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228608; c=relaxed/simple;
	bh=GNiV/rPgh6Cwj8UFhF88bhyKF5Cj5+PqQupq3PajI6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE4Xvy8/73HNdjwrjTomi6BgD3QX5pd9au6dVb4jgRQcPe7geO8ExJQG8hh3tVivWfkavpb6G21tGa1x0/YPVf7A1EIyue8agCOmPnl4WJ85JIPsEXP8FQmTfv5i26oUuo5LbvtRsnn16PHkcqS/P4OVwKeP8gocz27k5CKrBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EdYjMmEN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so3133162f8f.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228604; x=1719833404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd983Osk3B0nFZ6aKtZEUvwfSj9mgccJsi1JqruS6dM=;
        b=EdYjMmENDbjHom0yGxRd4kWCn4E+IONeL9Sx9X904lE8bPxi0SJ/S2Kg3tAj4Hpcuk
         b1xWefINn02600+XDKr6aK5CxxEyPobE9v16FKBvqOxmQlUngW5Y9cXCQq+t2bDANdFd
         oAELPa6r4m7if19i/9G2ItD3nYWtAzwBq/98yx34RZjQAilpHLIkN4lxexeIxW2l4ilz
         5CuiXVMfaF+4ebBau4nZmw5jK+LQ2pxWUwAIDOB4uIHgXetIqwxVzHM9f59xhQJS4UGC
         P4aHxj43riuFPt0e6ct/d7KY+t7N3Cyy+0omjrscWqGHOBE+CKntnzIPxECXirOwpPiE
         wahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228604; x=1719833404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd983Osk3B0nFZ6aKtZEUvwfSj9mgccJsi1JqruS6dM=;
        b=FKROpDdCW2stQqpVRp3FPfybX0W7o/tz3dDMFzA2iwcGWm6Hbs14+huXDuLOVCDJ2H
         +UiGI6pzip2vJ1AKFM9ot8p8uh7Xq2TMoK7NjX2F1nXeUU9mUqV2XtdpGFe61CX8isbs
         Yh1Jq0gFIDA/Qr9ttHLiOXPlDHiGqaooronn+fmWrS4ssEVscsh3sn2I1BbkHJLi//0I
         aG4Hh3nwK6cJPhtd5fJUx1WX4DKPZqrEkg3Loo6ho2J+W7WUh7oZoPKLmlmPlRrqWp8w
         g8mAZS3Qq/xYjg9/+2ShHmvXkpiQtNPYGAuo3knkoECFu+uoRwBHvcOqL01RTYka+vwH
         IBLw==
X-Gm-Message-State: AOJu0YyQ5MgwN8gmm7qKPXJhVpgSuBS6eeCZVVV7cwrgW2EMMTgaixjF
	DRqfmpZLRlIafDfu2hzveK5JEH7ZbpTcrEkV5tbhlSZcwQaitWDhxqqiCNZRHPdqYf+OasjyNht
	9
X-Google-Smtp-Source: AGHT+IHqlcNf2hBU9dePuDl3PMekvnLhcLco+lcHWFvVL8/6XOfxf+1JJBUAyHReQEAbemB/z6KCkg==
X-Received: by 2002:a05:6000:241:b0:35f:2fd3:85c1 with SMTP id ffacd0b85a97d-366e94d91d7mr2908578f8f.12.1719228604261;
        Mon, 24 Jun 2024 04:30:04 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:03 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 15/25] ovpn: implement multi-peer support
Date: Mon, 24 Jun 2024 13:31:12 +0200
Message-ID: <20240624113122.12732-16-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
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
 drivers/net/ovpn/main.c       |  41 ++++++++-
 drivers/net/ovpn/ovpnstruct.h |  16 ++++
 drivers/net/ovpn/peer.c       | 152 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |   9 ++
 4 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 19f7c0ff679b..cefd7010ab37 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -46,6 +46,17 @@ static int ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
 	ovpn->mode = mode;
 	spin_lock_init(&ovpn->lock);
 
+	if (mode == OVPN_MODE_MP) {
+		/* the peer container is fairly large, therefore we dynamically
+		 * allocate it only when needed
+		 */
+		ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
+		if (!ovpn->peers)
+			return -ENOMEM;
+
+		spin_lock_init(&ovpn->peers->lock);
+	}
+
 	return 0;
 }
 
@@ -54,14 +65,34 @@ static void ovpn_struct_free(struct net_device *net)
 	struct ovpn_struct *ovpn = netdev_priv(net);
 
 	gro_cells_destroy(&ovpn->gro_cells);
+	kfree(ovpn->peers);
 	rcu_barrier();
 }
 
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_struct *ovpn = netdev_priv(dev);
+	int err = gro_cells_init(&ovpn->gro_cells, dev);
+	struct in_device *dev_v4;
+
+	if (err)
+		return err;
 
-	return gro_cells_init(&ovpn->gro_cells, dev);
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
+	}
+	return 0;
 }
 
 static int ovpn_net_open(struct net_device *dev)
@@ -210,8 +241,14 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
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
index af39ee86f168..482e02b918e4 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -13,12 +13,27 @@
 #include <net/gro_cells.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_transp_addr: table of peers indexed by transport address
+ * @by_vpn_addr: table of peers indexed by VPN IP address
+ * @lock: protects writes to peers tables
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	DECLARE_HASHTABLE(by_transp_addr, 12);
+	DECLARE_HASHTABLE(by_vpn_addr, 12);
+	spinlock_t lock; /* protects writes to peers tables */
+};
+
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  * @gro_cells: pointer to the Generic Receive Offload cell
@@ -28,6 +43,7 @@ struct ovpn_struct {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 	struct gro_cells gro_cells;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index f633b70bb140..2b5e2bbb2578 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -311,6 +312,90 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 	return match;
 }
 
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
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+	struct ovpn_bind *bind;
+	struct ovpn_peer *tmp;
+	size_t salen;
+	int ret = 0;
+	u32 index;
+
+	spin_lock_bh(&ovpn->peers->lock);
+	/* do not add duplicates */
+	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
+	if (tmp) {
+		ovpn_peer_put(tmp);
+		ret = -EEXIST;
+		goto unlock;
+	}
+
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
+		index = ovpn_peer_index(ovpn->peers->by_transp_addr, &sa,
+					salen);
+		hlist_add_head_rcu(&peer->hash_entry_transp_addr,
+				   &ovpn->peers->by_transp_addr[index]);
+	}
+
+	index = ovpn_peer_index(ovpn->peers->by_id, &peer->id,
+				sizeof(peer->id));
+	hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers->by_id[index]);
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		index = ovpn_peer_index(ovpn->peers->by_vpn_addr,
+					&peer->vpn_addrs.ipv4,
+					sizeof(peer->vpn_addrs.ipv4));
+		hlist_add_head_rcu(&peer->hash_entry_addr4,
+				   &ovpn->peers->by_vpn_addr[index]);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		index = ovpn_peer_index(ovpn->peers->by_vpn_addr,
+					&peer->vpn_addrs.ipv6,
+					sizeof(peer->vpn_addrs.ipv6));
+		hlist_add_head_rcu(&peer->hash_entry_addr6,
+				   &ovpn->peers->by_vpn_addr[index]);
+	}
+
+unlock:
+	spin_unlock_bh(&ovpn->peers->lock);
+
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -351,6 +436,8 @@ static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
 	default:
@@ -358,6 +445,53 @@ int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
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
+	spin_lock_bh(&peer->ovpn->peers->lock);
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp != peer) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+	ovpn_peer_unhash(peer, reason);
+
+unlock:
+	spin_unlock_bh(&peer->ovpn->peers->lock);
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
@@ -415,9 +549,27 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
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
index 86d4696b1529..6e92e09a3504 100644
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
+	struct hlist_node hash_entry_transp_addr;
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


