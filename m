Return-Path: <netdev+bounces-77133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F48704E0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702F7287050
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154C46557;
	Mon,  4 Mar 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HoGsRqID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E550481D7
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564950; cv=none; b=TS8zj/eMs2tZ0+aarGi61/3ngJjWLhwQ3zyejQPCzgGJh/w9uYgPZJrK/iDJ90M45WsSbBSD3JmjNRivyUaCAXp3I/TY895do3GttnbmS3ACJqhvhT9eb7N1rxQUt/IXzeqfblPIleYq2xA9RoQalCdGeRJ6K6LvSE+sTnlZmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564950; c=relaxed/simple;
	bh=N8Fosf95HqIyeZ7BQDWv26fQXuy7oSaRhAtaz18e/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b344q++JT2uzvT6pC4Va/BtZ3Zx6d/9+4+vOpPaTsAm4G0tAo5a8m1XIZy73S7nzTrSuVGgwaipLVhUjFLXuXDr/0Ode3WoWzMX/GUyO9Bdii7vNddQZSG+jr4h2O6kAtbSnYrl+g97y8bHU1QYNvHZTzgnG9juxnGV1r1a44kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HoGsRqID; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e4f4e463so4756269e87.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564945; x=1710169745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB6Olt+LnxnuFvGHYwJN4ChVO33z48VbFxCBGRs5kdk=;
        b=HoGsRqIDhroFFMuk2SEOpe1FEzSn3HtgdGVSk8CO4aw7CnUF/PBHRPzyNfbG8OCY0s
         HIPRk5S9+nD5TBA4pQlRX67vsJWm8TZK7F5Td3YjAJWhYQXVwHW0hzilX/ew6T8Li6+s
         kp2Uf8J/AKls2lY8ZsLY2byBziWDA5O5RKq8CSEDL53sf8Qnuti7wMxBF6G35qz9UVq7
         wvt6jjcKqB5bL9a8mbo7Ki9m5EbSiIK4SRrecxUTxaWvyFg7jNUeZN9lOV/YfOl5zu6h
         hMKRb5rQ9iioBHU/aIeyXsUHlYnGFcPUoVwohGTXTWUhtVibn6p6BEHYG8rTP5fWYdBV
         2cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564945; x=1710169745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB6Olt+LnxnuFvGHYwJN4ChVO33z48VbFxCBGRs5kdk=;
        b=Oac6Il7ADWFgdzURxkvPHOtUwSek9tbCWiLaMCTeOiELjmu+Fnvn7H5nhU/KXna4b7
         rplsZ5iFi/ZHb+NnEvFo18jkf1RYTuOCaJ5hMtCp92Y0EllArbJKofgNnBmPe8B9E3xK
         aaPwwGdeebjn5aNN8Y3uupf47ayNOsBpgm2PyJARSJVMpdV1dlibjfOIVP1I9uIAzfgc
         8Tcl1zxoGyVavvcwpQBUIR8jHxnSY0XbqyBL1OTITD6Cr0e5OR6/7miQSPuw4Wdr7gTi
         Mi74zBt4cb+CawOdNhaVkcA6KyYTQxg9AbJ78N0tAzx8/8dXwfKRr1FL1KEWdpkUElLv
         CB9Q==
X-Gm-Message-State: AOJu0Yy10v4inYnxZ8PUXtwPsa4K4pw3UnZ/m+G/tySpAmSN5ii9MGUf
	b2nUWa3LOzPs9oNs+T2pEJh8DkChl/DG9M5wlef0dBe8qnOUfp2dmCseOnw0H5C/kIGLuGfLpXs
	/34g=
X-Google-Smtp-Source: AGHT+IHf6SeGHeLthRGQPinVItGBUDTE3/nUJal5b8zBlvYB/DtP68+5HRMWYIuygWt9Z69PVU5U9Q==
X-Received: by 2002:a05:6512:44a:b0:513:2b10:cc28 with SMTP id y10-20020a056512044a00b005132b10cc28mr6693746lfk.9.1709564945037;
        Mon, 04 Mar 2024 07:09:05 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:04 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Date: Mon,  4 Mar 2024 16:08:57 +0100
Message-ID: <20240304150914.11444-7-antonio@openvpn.net>
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

An ovpn_peer object holds the whole status of a remote peer
(regardless whether it is a server or a client).

This includes status for crypto, tx/rx buffers, napi, etc.

Only support for one peer is introduced (P2P mode).
Multi peer support is introduced with a later patch.

Along with the ovpn_peer, also the ovpn_bind object is introcued
as the two are strictly related.
An ovpn_bind object wraps a sockaddr representing the local
coordinates being used to talk to a specific peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile     |   2 +
 drivers/net/ovpn/bind.c       |  60 ++++++
 drivers/net/ovpn/bind.h       |  91 +++++++++
 drivers/net/ovpn/io.c         |   7 +
 drivers/net/ovpn/main.c       |   6 +
 drivers/net/ovpn/ovpnstruct.h |  12 +-
 drivers/net/ovpn/peer.c       | 354 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       |  88 +++++++++
 8 files changed, 619 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ovpn/bind.c
 create mode 100644 drivers/net/ovpn/bind.h
 create mode 100644 drivers/net/ovpn/peer.c
 create mode 100644 drivers/net/ovpn/peer.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 7e406a69892a..1399b9d9c076 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -7,6 +7,8 @@
 # Author:	Antonio Quartulli <antonio@openvpn.net>
 
 obj-$(CONFIG_OVPN) += ovpn.o
+ovpn-y += bind.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
+ovpn-y += peer.o
diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
new file mode 100644
index 000000000000..b14a1afa207e
--- /dev/null
+++ b/drivers/net/ovpn/bind.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2012-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "io.h"
+#include "bind.h"
+#include "peer.h"
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+/* Given a remote sockaddr, compute the skb hash
+ * and get a dst_entry so we can send packets to the remote.
+ */
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
+{
+	struct ovpn_bind *bind;
+	size_t sa_len;
+
+	if (ss->ss_family == AF_INET)
+		sa_len = sizeof(struct sockaddr_in);
+	else if (ss->ss_family == AF_INET6)
+		sa_len = sizeof(struct sockaddr_in6);
+	else
+		return ERR_PTR(-EAFNOSUPPORT);
+
+	bind = kzalloc(sizeof(*bind), GFP_ATOMIC);
+	if (unlikely(!bind))
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&bind->sa, ss, sa_len);
+
+	return bind;
+}
+
+static void ovpn_bind_release_rcu(struct rcu_head *head)
+{
+	struct ovpn_bind *bind = container_of(head, struct ovpn_bind, rcu);
+
+	kfree(bind);
+}
+
+void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
+{
+	struct ovpn_bind *old;
+
+	spin_lock_bh(&peer->lock);
+	old = rcu_replace_pointer(peer->bind, new, true);
+	spin_unlock_bh(&peer->lock);
+
+	if (old)
+		call_rcu(&old->rcu, ovpn_bind_release_rcu);
+}
diff --git a/drivers/net/ovpn/bind.h b/drivers/net/ovpn/bind.h
new file mode 100644
index 000000000000..d5b1939ea1f1
--- /dev/null
+++ b/drivers/net/ovpn/bind.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2012-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNBIND_H_
+#define _NET_OVPN_OVPNBIND_H_
+
+#include <net/ip.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/rcupdate.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+
+
+struct ovpn_peer;
+
+/* our basic transport layer address */
+struct ovpn_sockaddr {
+	union {
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	};
+};
+
+struct ovpn_bind {
+	struct ovpn_sockaddr sa;  /* remote sockaddr */
+
+	union {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} local;
+
+	struct rcu_head rcu;
+};
+
+/* Translate skb->protocol value to AF_INET or AF_INET6 */
+static inline unsigned short skb_protocol_to_family(const struct sk_buff *skb)
+{
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return AF_INET;
+	case htons(ETH_P_IPV6):
+		return AF_INET6;
+	default:
+		return 0;
+	}
+}
+
+static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind, struct sk_buff *skb)
+{
+	const unsigned short family = skb_protocol_to_family(skb);
+	const struct ovpn_sockaddr *sa = &bind->sa;
+
+	if (unlikely(!bind))
+		return false;
+
+	if (unlikely(sa->in4.sin_family != family))
+		return false;
+
+	switch (family) {
+	case AF_INET:
+		if (unlikely(sa->in4.sin_addr.s_addr != ip_hdr(skb)->saddr))
+			return false;
+
+		if (unlikely(sa->in4.sin_port != udp_hdr(skb)->source))
+			return false;
+		break;
+	case AF_INET6:
+		if (unlikely(!ipv6_addr_equal(&sa->in6.sin6_addr, &ipv6_hdr(skb)->saddr)))
+			return false;
+
+		if (unlikely(sa->in6.sin6_port != udp_hdr(skb)->source))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *sa);
+void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *bind);
+
+#endif /* _NET_OVPN_OVPNBIND_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index b283449ba479..ede15c84ea69 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -10,6 +10,7 @@
 #include "io.h"
 #include "ovpnstruct.h"
 #include "netlink.h"
+#include "peer.h"
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
@@ -28,6 +29,12 @@ int ovpn_struct_init(struct net_device *dev)
 	if (err < 0)
 		return err;
 
+	spin_lock_init(&ovpn->lock);
+
+	ovpn->events_wq = alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLAIM, 0, dev->name);
+	if (!ovpn->events_wq)
+		return -ENOMEM;
+
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!dev->tstats)
 		return -ENOMEM;
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 1be0fd50c356..3e054811b8c6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -21,6 +21,7 @@
 #include <linux/net.h>
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
+#include <linux/rcupdate.h>
 #include <linux/version.h>
 #include <net/ip.h>
 #include <uapi/linux/if_arp.h>
@@ -41,6 +42,9 @@ static void ovpn_struct_free(struct net_device *net)
 
 	security_tun_dev_free_security(ovpn->security);
 	free_percpu(net->tstats);
+	flush_workqueue(ovpn->events_wq);
+	destroy_workqueue(ovpn->events_wq);
+	rcu_barrier();
 }
 
 /* Net device open */
@@ -228,6 +232,8 @@ static __exit void ovpn_cleanup(void)
 {
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 	ovpn_nl_unregister();
+
+	rcu_barrier();
 }
 
 module_init(ovpn_init);
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index c2cdfd6f84b3..a595d44f2276 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -12,6 +12,7 @@
 
 #include <uapi/linux/ovpn.h>
 #include <linux/netdevice.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 /* Our state per ovpn interface */
@@ -24,7 +25,16 @@ struct ovpn_struct {
 	/* device operation mode (i.e. P2P, MP) */
 	enum ovpn_mode mode;
 
-	unsigned int max_tun_queue_len;
+	/* protect writing to the ovpn_struct object */
+	spinlock_t lock;
+
+	/* workqueue used to schedule generic event that may sleep or that need
+	 * to be performed out of softirq context
+	 */
+	struct workqueue_struct *events_wq;
+
+	/* for p2p mode */
+	struct ovpn_peer __rcu *peer;
 
 	netdev_features_t set_features;
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
new file mode 100644
index 000000000000..4319271927a4
--- /dev/null
+++ b/drivers/net/ovpn/peer.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "bind.h"
+#include "io.h"
+#include "main.h"
+#include "netlink.h"
+#include "ovpnstruct.h"
+#include "peer.h"
+
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/skbuff.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+
+
+/* Construct a new peer */
+struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
+{
+	struct ovpn_peer *peer;
+	int ret;
+
+	/* alloc and init peer object */
+	peer = kzalloc(sizeof(*peer), GFP_KERNEL);
+	if (!peer)
+		return ERR_PTR(-ENOMEM);
+
+	peer->id = id;
+	peer->halt = false;
+	peer->ovpn = ovpn;
+
+	peer->vpn_addrs.ipv4.s_addr = htonl(INADDR_ANY);
+	peer->vpn_addrs.ipv6 = in6addr_any;
+
+	RCU_INIT_POINTER(peer->bind, NULL);
+	spin_lock_init(&peer->lock);
+	kref_init(&peer->refcount);
+
+	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n", __func__);
+		goto err;
+	}
+
+	ret = ptr_ring_init(&peer->tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot allocate TX ring\n", __func__);
+		goto err_dst_cache;
+	}
+
+	ret = ptr_ring_init(&peer->rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot allocate RX ring\n", __func__);
+		goto err_tx_ring;
+	}
+
+	ret = ptr_ring_init(&peer->netif_rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot allocate NETIF RX ring\n", __func__);
+		goto err_rx_ring;
+	}
+
+	dev_hold(ovpn->dev);
+
+	return peer;
+err_rx_ring:
+	ptr_ring_cleanup(&peer->rx_ring, NULL);
+err_tx_ring:
+	ptr_ring_cleanup(&peer->tx_ring, NULL);
+err_dst_cache:
+	dst_cache_destroy(&peer->dst_cache);
+err:
+	kfree(peer);
+	return ERR_PTR(ret);
+}
+
+#define ovpn_peer_index(_tbl, _key, _key_len)		\
+	(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))	\
+
+static void ovpn_peer_free(struct ovpn_peer *peer)
+{
+	ovpn_bind_reset(peer, NULL);
+
+	WARN_ON(!__ptr_ring_empty(&peer->tx_ring));
+	ptr_ring_cleanup(&peer->tx_ring, NULL);
+	WARN_ON(!__ptr_ring_empty(&peer->rx_ring));
+	ptr_ring_cleanup(&peer->rx_ring, NULL);
+	WARN_ON(!__ptr_ring_empty(&peer->netif_rx_ring));
+	ptr_ring_cleanup(&peer->netif_rx_ring, NULL);
+
+	dst_cache_destroy(&peer->dst_cache);
+
+	dev_put(peer->ovpn->dev);
+
+	kfree(peer);
+}
+
+static void ovpn_peer_release_rcu(struct rcu_head *head)
+{
+	struct ovpn_peer *peer = container_of(head, struct ovpn_peer, rcu);
+
+	ovpn_peer_free(peer);
+}
+
+void ovpn_peer_release(struct ovpn_peer *peer)
+{
+	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
+}
+
+static void ovpn_peer_delete_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      delete_work);
+	ovpn_peer_release(peer);
+}
+
+/* Use with kref_put calls, when releasing refcount
+ * on ovpn_peer objects.  This method should only
+ * be called from process context with config_mutex held.
+ */
+void ovpn_peer_release_kref(struct kref *kref)
+{
+	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
+
+	INIT_WORK(&peer->delete_work, ovpn_peer_delete_work);
+	queue_work(peer->ovpn->events_wq, &peer->delete_work);
+}
+
+/**
+ * ovpn_peer_lookup_by_dst() - Lookup peer to send skb to
+ *
+ * This function takes a tunnel packet and looks up the peer to send it to
+ * after encapsulation. The skb is expected to be the in-tunnel packet, without
+ * any OpenVPN related header.
+ *
+ * Assume that the IP header is accessible in the skb data.
+ *
+ * @ovpn: the private data representing the current VPN session
+ * @skb: the skb to extract the destination address from
+ *
+ * Return the peer if found or NULL otherwise.
+ */
+struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_buff *skb)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to the single peer
+	 * listening on the other side
+	 */
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		rcu_read_lock();
+		tmp = rcu_dereference(ovpn->peer);
+		if (likely(tmp && ovpn_peer_hold(tmp)))
+			peer = tmp;
+		rcu_read_unlock();
+	}
+
+	return peer;
+}
+
+static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb, struct sockaddr_storage *ss)
+{
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+
+	ss->ss_family = skb_protocol_to_family(skb);
+	switch (ss->ss_family) {
+	case AF_INET:
+		sa4 = (struct sockaddr_in *)ss;
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa4->sin_port = udp_hdr(skb)->source;
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool ovpn_peer_transp_match(struct ovpn_peer *peer, struct sockaddr_storage *ss)
+{
+	struct ovpn_bind *bind = rcu_dereference(peer->bind);
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+
+	if (unlikely(!bind))
+		return false;
+
+	if (ss->ss_family != bind->sa.in4.sin_family)
+		return false;
+
+	switch (ss->ss_family) {
+	case AF_INET:
+		sa4 = (struct sockaddr_in *)ss;
+		if (sa4->sin_addr.s_addr != bind->sa.in4.sin_addr.s_addr)
+			return false;
+		if (sa4->sin_port != bind->sa.in4.sin_port)
+			return false;
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)ss;
+		if (memcmp(&sa6->sin6_addr, &bind->sa.in6.sin6_addr, sizeof(struct in6_addr)))
+			return false;
+		if (sa6->sin6_port != bind->sa.in6.sin6_port)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static struct ovpn_peer *ovpn_peer_lookup_transp_addr_p2p(struct ovpn_struct *ovpn,
+							  struct sockaddr_storage *ss)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	rcu_read_lock();
+	tmp = rcu_dereference(ovpn->peer);
+	if (likely(tmp && ovpn_peer_transp_match(tmp, ss) && ovpn_peer_hold(tmp)))
+		peer = tmp;
+	rcu_read_unlock();
+
+	return peer;
+}
+
+struct ovpn_peer *ovpn_peer_lookup_transp_addr(struct ovpn_struct *ovpn, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+	struct sockaddr_storage ss = { 0 };
+
+	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
+		return NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_lookup_transp_addr_p2p(ovpn, &ss);
+
+	return peer;
+}
+
+static struct ovpn_peer *ovpn_peer_lookup_id_p2p(struct ovpn_struct *ovpn, u32 peer_id)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	rcu_read_lock();
+	tmp = rcu_dereference(ovpn->peer);
+	if (likely(tmp && tmp->id == peer_id && ovpn_peer_hold(tmp)))
+		peer = tmp;
+	rcu_read_unlock();
+
+	return peer;
+}
+
+struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id)
+{
+	struct ovpn_peer *peer = NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_lookup_id_p2p(ovpn, peer_id);
+
+	return peer;
+}
+
+static int ovpn_peer_add_p2p(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
+{
+	struct ovpn_peer *tmp;
+
+	spin_lock_bh(&ovpn->lock);
+	/* in p2p mode it is possible to have a single peer only, therefore the
+	 * old one is released and substituted by the new one
+	 */
+	tmp = rcu_dereference(ovpn->peer);
+	if (tmp) {
+		tmp->delete_reason = OVPN_DEL_PEER_REASON_TEARDOWN;
+		ovpn_peer_put(tmp);
+	}
+
+	rcu_assign_pointer(ovpn->peer, peer);
+	spin_unlock_bh(&ovpn->lock);
+
+	return 0;
+}
+
+/* assume refcounter was increased by caller */
+int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
+{
+	switch (ovpn->mode) {
+	case OVPN_MODE_P2P:
+		return ovpn_peer_add_p2p(ovpn, peer);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ovpn_peer_del_p2p(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	spin_lock_bh(&peer->ovpn->lock);
+	tmp = rcu_dereference(peer->ovpn->peer);
+	if (tmp != peer)
+		goto unlock;
+
+	ovpn_peer_put(tmp);
+	tmp->delete_reason = reason;
+	RCU_INIT_POINTER(peer->ovpn->peer, NULL);
+	ret = 0;
+
+unlock:
+	spin_unlock_bh(&peer->ovpn->lock);
+
+	return ret;
+}
+
+void ovpn_peer_release_p2p(struct ovpn_struct *ovpn)
+{
+	struct ovpn_peer *tmp;
+
+	rcu_read_lock();
+	tmp = rcu_dereference(ovpn->peer);
+	if (!tmp)
+		goto unlock;
+
+	ovpn_peer_del_p2p(tmp, OVPN_DEL_PEER_REASON_TEARDOWN);
+unlock:
+	rcu_read_unlock();
+}
+
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
+{
+	switch (peer->ovpn->mode) {
+	case OVPN_MODE_P2P:
+		return ovpn_peer_del_p2p(peer, reason);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
new file mode 100644
index 000000000000..c3ccbb6bdf41
--- /dev/null
+++ b/drivers/net/ovpn/peer.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNPEER_H_
+#define _NET_OVPN_OVPNPEER_H_
+
+#include "bind.h"
+
+#include <linux/ptr_ring.h>
+#include <net/dst_cache.h>
+#include <uapi/linux/ovpn.h>
+
+
+struct ovpn_peer {
+	struct ovpn_struct *ovpn;
+
+	u32 id;
+
+	struct {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} vpn_addrs;
+
+	struct ptr_ring tx_ring;
+	struct ptr_ring rx_ring;
+	struct ptr_ring netif_rx_ring;
+
+	struct dst_cache dst_cache;
+
+	/* our binding to peer, protected by spinlock */
+	struct ovpn_bind __rcu *bind;
+
+	/* true if ovpn_peer_mark_delete was called */
+	bool halt;
+
+	/* why peer was deleted - keepalive timeout, module removed etc */
+	enum ovpn_del_peer_reason delete_reason;
+
+	/* protects binding to peer (bind) and timers
+	 * (keepalive_xmit, keepalive_expire)
+	 */
+	spinlock_t lock;
+
+	/* needed because crypto methods can go async */
+	struct kref refcount;
+
+	/* needed to free a peer in an RCU safe way */
+	struct rcu_head rcu;
+
+	/* needed to notify userspace about deletion */
+	struct work_struct delete_work;
+};
+
+void ovpn_peer_release_kref(struct kref *kref);
+void ovpn_peer_release(struct ovpn_peer *peer);
+
+static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
+{
+	return kref_get_unless_zero(&peer->refcount);
+}
+
+static inline void ovpn_peer_put(struct ovpn_peer *peer)
+{
+	kref_put(&peer->refcount, ovpn_peer_release_kref);
+}
+
+struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
+
+int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+struct ovpn_peer *ovpn_peer_find(struct ovpn_struct *ovpn, u32 peer_id);
+void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
+
+struct ovpn_peer *ovpn_peer_lookup_transp_addr(struct ovpn_struct *ovpn, struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb);
+struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id);
+
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer, const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
+
+#endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.43.0


