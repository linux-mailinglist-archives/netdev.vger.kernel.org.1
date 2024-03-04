Return-Path: <netdev+bounces-77140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932568704E7
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78F91C22643
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECD4C615;
	Mon,  4 Mar 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aASNI8qP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491BA4AEE3
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564959; cv=none; b=GDU+CmnRYuGpNXXU1ztFrEZ05xOC79ysLjLHsTh0e7qBUfMa37qsewzW/AyP5b6aHhehs1SURZtOBs6BsvVsS9fSJf7BeYzx0xjRHWjWEtPOzGjnwPKAEOHt/wrODkGqwA977hxum9XBYIexhOztrs72mn/x+Bh8dPK5AEVdTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564959; c=relaxed/simple;
	bh=rHEbO+GuELUp7BdGRRxETWZai2DgklQPEd7SSyUOmu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCwD8A9jAF/V6Jje+R502lJsqd+J5eULmTmV+04/gCx9jjLqpAl/a412xu9DMEMtV4f4ScvJoHoTdNtcqnQstJe9RPr8wHc3C+lj/RjS/YqrLLOneQoj7JrtuWOeX5KwQX7XdNRvcp5Iazi5S/Ct/m2HTT1/Octw1TFnT+byHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aASNI8qP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so755323366b.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564955; x=1710169755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvtkpz5gaGRdeW/I5R4kOc2rZBfO03TSHCQ14mg82ec=;
        b=aASNI8qPypsZ5C2rKB+0Q2inEzqMlxQmlvtdbQLIcid3E+645n/puvGXYmMUVXC+OZ
         vx9JoOD1gVkPh52Xn6i/Af8Vo2v61MyGS1w85hvjTn9hiC/78VgQkYmHFNMuwe2VknwV
         2QZPBad/40eGvpxFaM4E/4dyIJ1PiORg+MJr5jdQ1MHjtiad6mOhzyRlroCZACTukIQn
         iK6Hm3adlUyheVkLmaUfpfaCxNhnwFY16iUcC30sh8A0uI4W3v7a6pzLJnGbLkPJPLf8
         7fR0RqNpy9rmlyugtq41cq5JX45qd9piqU+ITWVfZSfU7ML3wHdkTWqTkkzk0vR6FOH7
         ph7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564955; x=1710169755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvtkpz5gaGRdeW/I5R4kOc2rZBfO03TSHCQ14mg82ec=;
        b=sWi9ik9FGnsO02mHmG9gl6wLviDmwmPzXvvhQh6mH3gbI8ozh3Ut2v76HwPiL015dz
         cKCpYoXqm5AM27BJZuyKD4RiuDLv9H3HlY0xO34Xd1tziX9QcEqvK0JI0JlNnr6TWH9b
         IDweROMH7q34Tr5uJJohQN+xulI/61KSMUiTOnyx2S36fQA6AObiBxqVxBRkcNXVs1qD
         +qFYDYf/5QVRMJypJqamTRD+eWJOOrPayoH1S7khwVH9j/SnUkOUEXIg89AnNwixvjT+
         iS3SEkfrg1pHG56MhQ3nJZagDerS5ebKQE4ZyH1UlEbn6NSPn0rxqVRSVOhahRyXDYnc
         bJEg==
X-Gm-Message-State: AOJu0Yy7xfAInp0xn0Tl87z1en+DgnqT7HoHxmdowinO2llAt6r9LR4A
	RqZKRFq7EFRz++oBmkB5r3Z98RGGH+bvdxInVUQ85lzyMb7wRGxBDzG8Fxc+XKvbSXsJz3IXsMX
	cXSU=
X-Google-Smtp-Source: AGHT+IGSsNCL6Fd6u2IcwaJVO1ylVK6FZqz8/8mGqDouYKKhRcu4zqXRtC28IFqIVWo9lLmSOMIM6w==
X-Received: by 2002:a17:906:da06:b0:a44:4c7e:fc07 with SMTP id fi6-20020a170906da0600b00a444c7efc07mr6697545ejb.0.1709564954991;
        Mon, 04 Mar 2024 07:09:14 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:14 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 13/22] ovpn: implement multi-peer support
Date: Mon,  4 Mar 2024 16:09:04 +0100
Message-ID: <20240304150914.11444-14-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
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
 drivers/net/ovpn/ovpnstruct.h |   9 +++
 drivers/net/ovpn/peer.c       | 124 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |   7 ++
 drivers/net/ovpn/skb.h        |  51 ++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 drivers/net/ovpn/skb.h

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 28d05e42cc98..91706c55784d 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -36,6 +36,7 @@ int ovpn_struct_init(struct net_device *dev)
 		return err;
 
 	spin_lock_init(&ovpn->lock);
+	spin_lock_init(&ovpn->peers.lock);
 
 	ovpn->crypto_wq = alloc_workqueue("ovpn-crypto-wq-%s",
 					  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 300906bc694f..63ac1f0e7afe 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -36,6 +36,15 @@ struct ovpn_struct {
 	 */
 	struct workqueue_struct *events_wq;
 
+	/* list of known peers */
+	struct {
+		DECLARE_HASHTABLE(by_id, 12);
+		DECLARE_HASHTABLE(by_transp_addr, 12);
+		DECLARE_HASHTABLE(by_vpn_addr, 12);
+		/* protects write access to any of the hashtables above */
+		spinlock_t lock;
+	} peers;
+
 	/* for p2p mode */
 	struct ovpn_peer __rcu *peer;
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 658d922d4ae8..6c2c6877d539 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -314,6 +314,79 @@ struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id)
 	return peer;
 }
 
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
+	tmp = ovpn_peer_lookup_id(ovpn, peer->id);
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
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &peer->vpn_addrs.ipv4,
+					sizeof(peer->vpn_addrs.ipv4));
+		hlist_add_head_rcu(&peer->hash_entry_addr4, &ovpn->peers.by_vpn_addr[index]);
+	}
+
+	hlist_del_init_rcu(&peer->hash_entry_addr6);
+	if (memcmp(&peer->vpn_addrs.ipv6, &in6addr_any, sizeof(peer->vpn_addrs.ipv6))) {
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &peer->vpn_addrs.ipv6,
+					sizeof(peer->vpn_addrs.ipv6));
+		hlist_add_head_rcu(&peer->hash_entry_addr6, &ovpn->peers.by_vpn_addr[index]);
+	}
+
+unlock:
+	spin_unlock_bh(&ovpn->peers.lock);
+
+	return ret;
+}
+
 static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	struct ovpn_peer *tmp;
@@ -338,6 +411,8 @@ static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
 	default:
@@ -345,6 +420,39 @@ int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 	}
 }
 
+static void ovpn_peer_unhash(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
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
+static int ovpn_peer_del_mp(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_peer *tmp;
+	int ret = 0;
+
+	spin_lock_bh(&peer->ovpn->peers.lock);
+	tmp = ovpn_peer_lookup_id(peer->ovpn, peer->id);
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
 static int ovpn_peer_del_p2p(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 {
 	struct ovpn_peer *tmp;
@@ -383,9 +491,25 @@ void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
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
+	dump_stack();
+
+	spin_lock_bh(&ovpn->peers.lock);
+	hash_for_each_safe(ovpn->peers.by_id, bkt, tmp, peer, hash_entry_id)
+		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
+	spin_unlock_bh(&ovpn->peers.lock);
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1cae726bbbf5..72bbe8ffd252 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -30,6 +30,11 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 
+	struct hlist_node hash_entry_id;
+	struct hlist_node hash_entry_addr4;
+	struct hlist_node hash_entry_addr6;
+	struct hlist_node hash_entry_transp_addr;
+
 	/* work objects to handle encryption/decryption of packets.
 	 * these works are queued on the ovpn->crypt_wq workqueue.
 	 */
@@ -127,4 +132,6 @@ struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id);
 int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer, const struct sockaddr_storage *ss,
 			     const u8 *local_ip);
 
+void ovpn_peers_free(struct ovpn_struct *ovpn);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 000000000000..ba92811e12ff
--- /dev/null
+++ b/drivers/net/ovpn/skb.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_SKB_H_
+#define _NET_OVPN_SKB_H_
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+#define OVPN_SKB_CB(skb) ((struct ovpn_skb_cb *)&((skb)->cb))
+
+struct ovpn_skb_cb {
+	union {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} local;
+	sa_family_t sa_fam;
+};
+
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear,
+	 * make sure IP header is in non-fragmented part
+	 */
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		return 0;
+
+	if (ip_hdr(skb)->version == 4)
+		proto = htons(ETH_P_IP);
+	else if (ip_hdr(skb)->version == 6)
+		proto = htons(ETH_P_IPV6);
+
+	return proto;
+}
+
+#endif /* _NET_OVPN_SKB_H_ */
-- 
2.43.0


