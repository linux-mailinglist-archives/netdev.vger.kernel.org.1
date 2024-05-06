Return-Path: <netdev+bounces-93563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8F8BC54A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952241F213E8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45F3C463;
	Mon,  6 May 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GwXkqRPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2B41C73
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958142; cv=none; b=YWbBv62P3Ye6ZxuiCP6WE2LtVWju1PIR5ac1iZpXVkyHqYgNY+QH/vtwRJVtk4bPpAAXgEUjvxu2WCRgepGOYyApZuwcKlE901jWBsnhTfW4oTKhuA5K7eskrb0sG0B/sUbp4KxUMwAxdjSvG2uRgmXeQIYernoK6F8SHOoJNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958142; c=relaxed/simple;
	bh=AQQDVSTkoNuxKQah+jRste9mEB3Rjw1MT7xWb8MVLFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNk1+/t0WduC8dOpoProaRrYxOK8T6gPCBW7MvWELK220y9CBfWB5/p8mcp1Z5zJzJ/s/HBax41NWQ4uVPkvsUUqP+P34HQJvg5NhbtNGgDXIr2NdrUOyOkEut7Np+YkAlWqKsxXzTVTI6r+XKV5BYMjxo+IWW+nG83AIDwsawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GwXkqRPC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so12024365e9.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958138; x=1715562938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M3JkUU18dIkda8JbJYw3RZJAWt0NAlf5Xnnc0IYIKY=;
        b=GwXkqRPCexrp5sYZ0fPodu9d+KjoxTiF4mpl/25v4Qcsy0ivROUnvGlr0/X1E3UtTv
         N1oFMQ07oWneFgrqDL0gMC/aWZovQwtbHheXMKo2rq0Z/7nLWJrYUdhBZlew0PIlWVAS
         sulbJXvv1WKogKuSLejJh7te6qHMSG45XRlhw1g3KrZ2mHQnawYTJLLLgm7eHcxlaVET
         IXTJj5Rd4qc/IkQC4plVKbFOzEqzQgnBNDvDlM/K8kMi+AQOtzgIOreEMWSzPds4zXpx
         at3dhhQjdRpq9W/h4GWCcP7wChJC700qHoFzt++IZxu/i0Ta+c8j56H/LzdTqbvsN7ne
         +tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958138; x=1715562938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M3JkUU18dIkda8JbJYw3RZJAWt0NAlf5Xnnc0IYIKY=;
        b=kzpiv5LF0YDYIcJPAOGQoQvJdnMUTcVmoGNBcpymt64EXfP+T4dFQNJ4rApVt1LF/Y
         ovmCBVVvFSmu9QVezvNZPPngHUZ36Cq0W79rgmYf4+Gk4EsI57Y1Fbr6eDRhuOhrOEzH
         N/eS2IfjweA9SXHp5iiAlcDoBtboIl+PjaD3ZXJk5JVZrNnbzmlZ/TPEpy8a5YQNDWne
         ERSQ7UPzz5OGdI5snJRu012v+dbvqeUd7RZl0l/7+GX3KnOOMmbr1KDN/TY9TtZh2uFB
         WwHsdWtJ5yGxX9UeT+a1+1NFx5kIWyxqI+pqfXldE7eeT7cYMQ5whEU4FKK5k4c5nQbS
         l2Xw==
X-Gm-Message-State: AOJu0YyTF0DDVJAm2aCqmulg8GLkqxpjKZqJ4ciSj/UJHYWT2RqcqOIG
	NsKiCsc/mlCjkX00s+Mfsy5GOQP/xRAgto8TpDSfELYsFX8awFg+SXP7fDSXAbVySAuiXf5MBt+
	Q
X-Google-Smtp-Source: AGHT+IF2pkJabhEXky4dc0MpJoSBEReAVnGuyIWnB+aB3ls6B36NggH+w/x+lxDN/8tF8gYgipF6uA==
X-Received: by 2002:adf:fc4e:0:b0:349:8a92:7eda with SMTP id e14-20020adffc4e000000b003498a927edamr5848532wrs.12.1714958138001;
        Sun, 05 May 2024 18:15:38 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Date: Mon,  6 May 2024 03:16:20 +0200
Message-ID: <20240506011637.27272-8-antonio@openvpn.net>
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
 drivers/net/ovpn/bind.h       | 130 ++++++++++++
 drivers/net/ovpn/io.c         |   8 +
 drivers/net/ovpn/main.c       |  10 +
 drivers/net/ovpn/main.h       |   2 +
 drivers/net/ovpn/ovpnstruct.h |   7 +
 drivers/net/ovpn/peer.c       | 379 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h       | 152 ++++++++++++++
 9 files changed, 750 insertions(+)
 create mode 100644 drivers/net/ovpn/bind.c
 create mode 100644 drivers/net/ovpn/bind.h
 create mode 100644 drivers/net/ovpn/peer.c
 create mode 100644 drivers/net/ovpn/peer.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 201dc001419f..ce13499b3e17 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -7,7 +7,9 @@
 # Author:	Antonio Quartulli <antonio@openvpn.net>
 
 obj-$(CONFIG_OVPN) := ovpn.o
+ovpn-y += bind.o
 ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
+ovpn-y += peer.o
diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
new file mode 100644
index 000000000000..c1f842c06e32
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
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+
+#include "ovpnstruct.h"
+#include "io.h"
+#include "bind.h"
+#include "peer.h"
+
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
+/**
+ * ovpn_bind_release_rcu - RCU callback for releasing binding
+ * @head: the RCU head member
+ */
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
index 000000000000..61433550a961
--- /dev/null
+++ b/drivers/net/ovpn/bind.h
@@ -0,0 +1,130 @@
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
+struct ovpn_peer;
+
+/**
+ * struct ovpn_sockaddr - basic transport layer address
+ * @in4: IPv4 address
+ * @in6: IPv6 address
+ */
+struct ovpn_sockaddr {
+	union {
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	};
+};
+
+/**
+ * struct ovpn_bind - remote peer binding
+ * @sa: the remote peer sockaddress
+ * @local.ipv4: local IPv4 used to talk to the peer
+ * @local.ipv6: local IPv6 used to talk to the peer
+ * @rcu: used to schedule RCU cleanup job
+ */
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
+/**
+ * skb_protocol_to_family - translate skb->protocol to AF_INET or AF_INET6
+ * @skb: the packet sk_buff to inspect
+ *
+ * Return: AF_INET, AF_INET6 or 0 in case of unknown protocol
+ */
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
+/**
+ * ovpn_bind_skb_src_match - match packet source with binding
+ * @bind: the binding to match
+ * @skb: the packet to match
+ *
+ * Return: true if the packet source matches the remote peer sockaddr
+ * in the binding
+ */
+static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind,
+					   struct sk_buff *skb)
+{
+	const unsigned short family = skb_protocol_to_family(skb);
+	const struct ovpn_sockaddr *sa;
+
+	if (unlikely(!bind))
+		return false;
+
+	sa = &bind->sa;
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
+		if (unlikely(!ipv6_addr_equal(&sa->in6.sin6_addr,
+					      &ipv6_hdr(skb)->saddr)))
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
+/**
+ * ovpn_bind_from_sockaddr - retrieve binding matching sockaddr
+ * @sa: the sockaddr to match
+ *
+ * Return: the bind matching the passed sockaddr if found, NULL otherwise
+ */
+struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *sa);
+
+/**
+ * ovpn_bind_reset - assign new binding to peer
+ * @peer: the peer whose binding has to be replaced
+ * @bind: the new bind to assign
+ */
+void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *bind);
+
+#endif /* _NET_OVPN_OVPNBIND_H_ */
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 338e99dfe886..a420bb45f25f 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -13,6 +13,7 @@
 #include "io.h"
 #include "ovpnstruct.h"
 #include "netlink.h"
+#include "peer.h"
 
 int ovpn_struct_init(struct net_device *dev)
 {
@@ -25,6 +26,13 @@ int ovpn_struct_init(struct net_device *dev)
 	if (err < 0)
 		return err;
 
+	spin_lock_init(&ovpn->lock);
+
+	ovpn->events_wq = alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLAIM,
+					  0, dev->name);
+	if (!ovpn->events_wq)
+		return -ENOMEM;
+
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!dev->tstats)
 		return -ENOMEM;
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index cc8a97a1a189..dba35ecb236b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
+//#include <linux/rcupdate.h>
 #include <linux/version.h>
 #include <net/ip.h>
 #include <uapi/linux/if_arp.h>
@@ -21,6 +22,7 @@
 #include "netlink.h"
 #include "io.h"
 #include "packet.h"
+#include "peer.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
@@ -37,6 +39,9 @@ static void ovpn_struct_free(struct net_device *net)
 	rtnl_unlock();
 
 	free_percpu(net->tstats);
+	flush_workqueue(ovpn->events_wq);
+	destroy_workqueue(ovpn->events_wq);
+	rcu_barrier();
 }
 
 static int ovpn_net_open(struct net_device *dev)
@@ -168,6 +173,9 @@ void ovpn_iface_destruct(struct ovpn_struct *ovpn)
 
 	ovpn->registered = false;
 
+	if (ovpn->mode == OVPN_MODE_P2P)
+		ovpn_peer_release_p2p(ovpn);
+
 	unregister_netdevice(ovpn->dev);
 	synchronize_net();
 }
@@ -270,6 +278,8 @@ static __exit void ovpn_cleanup(void)
 	ovpn_nl_unregister();
 	unregister_pernet_device(&ovpn_pernet_ops);
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+
+	rcu_barrier();
 }
 
 module_init(ovpn_init);
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index 12b8d7e4a0fe..c08354e3ac8d 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -51,4 +51,6 @@ bool ovpn_dev_is_valid(const struct net_device *dev);
 #define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
 #define OVPN_MAX_PADDING 16
 
+#define OVPN_QUEUE_LEN 1024
+
 #endif /* _NET_OVPN_MAIN_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index ee05b8a2c61d..b79d4f0474b0 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -17,12 +17,19 @@
  * @dev: the actual netdev representing the tunnel
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @lock: protect this object
+ * @event_wq: used to schedule generic events that may sleep and that need to be
+ *            performed outside of softirq context
+ * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
  */
 struct ovpn_struct {
 	struct net_device *dev;
 	bool registered;
 	enum ovpn_mode mode;
+	spinlock_t lock; /* protect writing to the ovpn_struct object */
+	struct workqueue_struct *events_wq;
+	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
 };
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
new file mode 100644
index 000000000000..2948b7320d47
--- /dev/null
+++ b/drivers/net/ovpn/peer.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/skbuff.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+
+#include "ovpnstruct.h"
+#include "bind.h"
+#include "io.h"
+#include "main.h"
+#include "netlink.h"
+#include "peer.h"
+
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
+		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n",
+			   __func__);
+		goto err;
+	}
+
+	ret = ptr_ring_init(&peer->tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot allocate TX ring\n",
+			   __func__);
+		goto err_dst_cache;
+	}
+
+	ret = ptr_ring_init(&peer->rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot allocate RX ring\n",
+			   __func__);
+		goto err_tx_ring;
+	}
+
+	ret = ptr_ring_init(&peer->netif_rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot allocate NETIF RX ring\n",
+			   __func__);
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
+/**
+ * ovpn_peer_free - release private members and free peer object
+ * @peer: the peer to free
+ */
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
+/**
+ * ovpn_peer_release_rcu - RCU callback for releasing peer
+ * @head: the RCU head member
+ */
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
+/**
+ * ovpn_peer_delete_work - work scheduled to release peer in process context
+ * @work: the work object
+ */
+static void ovpn_peer_delete_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      delete_work);
+	ovpn_peer_release(peer);
+}
+
+void ovpn_peer_release_kref(struct kref *kref)
+{
+	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
+
+	INIT_WORK(&peer->delete_work, ovpn_peer_delete_work);
+	queue_work(peer->ovpn->events_wq, &peer->delete_work);
+}
+
+/**
+ * ovpn_peer_skb_to_sockaddr - fill sockaddr with skb source address
+ * @skb: the packet to extract data from
+ * @ss: the sockaddr to fill
+ *
+ * Return: true on success or false otherwise
+ */
+static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
+				      struct sockaddr_storage *ss)
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
+/**
+ * ovpn_peer_transp_match - check if sockaddr and peer binding match
+ * @peer: the peer to get the binding from
+ * @ss: the sockaddr to match
+ *
+ * Return: true if sockaddr and binding match or false otherwise
+ */
+static bool ovpn_peer_transp_match(struct ovpn_peer *peer,
+				   struct sockaddr_storage *ss)
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
+		if (memcmp(&sa6->sin6_addr, &bind->sa.in6.sin6_addr,
+			   sizeof(struct in6_addr)))
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
+/**
+ * ovpn_peer_get_by_transp_addr_p2p - get peer by transport address in a P2P
+ *                                    instance
+ * @ovpn: the openvpn instance to search
+ * @ss: the transport socket address
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *
+ovpn_peer_get_by_transp_addr_p2p(struct ovpn_struct *ovpn,
+				 struct sockaddr_storage *ss)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	rcu_read_lock();
+	tmp = rcu_dereference(ovpn->peer);
+	if (likely(tmp && ovpn_peer_transp_match(tmp, ss) &&
+		   ovpn_peer_hold(tmp)))
+		peer = tmp;
+	rcu_read_unlock();
+
+	return peer;
+}
+
+struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
+					       struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+	struct sockaddr_storage ss = { 0 };
+
+	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
+		return NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_get_by_id_p2p - get peer by ID in a P2P instance
+ * @ovpn: the openvpn instance to search
+ * @peer_id: the ID of the peer to find
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
+						 u32 peer_id)
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
+struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
+{
+	struct ovpn_peer *peer = NULL;
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+
+	return peer;
+}
+
+/**
+ * ovpn_peer_add_p2p - add per to related tables in a P2P instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
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
+/**
+ * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
+ * @peer: the peer to delete
+ * @reason: reason why the peer was deleted (sent to userspace)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
+			     enum ovpn_del_peer_reason reason)
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
index 000000000000..659df320525c
--- /dev/null
+++ b/drivers/net/ovpn/peer.h
@@ -0,0 +1,152 @@
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
+/**
+ * struct ovpn_peer - the main remote peer object
+ * @ovpn: main openvpn instance this peer belongs to
+ * @id: unique identifier
+ * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
+ * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @tx_ring: queue of outgoing poackets to this peer
+ * @rx_ring: queue of incoming packets from this peer
+ * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
+ * @dst_cache: cache for dst_entry used to send to peer
+ * @bind: remote peer binding
+ * @halt: true if ovpn_peer_mark_delete was called
+ * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
+ * @lock: protects binding to peer (bind)
+ * @refcount: reference counter
+ * @rcu: used to free peer in an RCU safe way
+ * @delete_work: deferred cleanup work, used to notify userspace
+ */
+struct ovpn_peer {
+	struct ovpn_struct *ovpn;
+	u32 id;
+	struct {
+		struct in_addr ipv4;
+		struct in6_addr ipv6;
+	} vpn_addrs;
+	struct ptr_ring tx_ring;
+	struct ptr_ring rx_ring;
+	struct ptr_ring netif_rx_ring;
+	struct dst_cache dst_cache;
+	struct ovpn_bind __rcu *bind;
+	bool halt;
+	enum ovpn_del_peer_reason delete_reason;
+	spinlock_t lock; /* protects bind */
+	struct kref refcount;
+	struct rcu_head rcu;
+	struct work_struct delete_work;
+};
+
+/**
+ * ovpn_peer_release_kref - callback for kref_put
+ * @kref: the kref object belonging to the peer
+ */
+void ovpn_peer_release_kref(struct kref *kref);
+
+/**
+ * ovpn_peer_release - schedule RCU cleanup work
+ * @peer: the peer to release
+ */
+void ovpn_peer_release(struct ovpn_peer *peer);
+
+/**
+ * ovpn_peer_hold - increase reference counter
+ * @peer: the peer whose counter should be increased
+ *
+ * Return: true if the counter was increased or false if it was zero already
+ */
+static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
+{
+	return kref_get_unless_zero(&peer->refcount);
+}
+
+/**
+ * ovpn_peer_put - decrease reference counter
+ * @peer: the peer whose counter should be decreased
+ */
+static inline void ovpn_peer_put(struct ovpn_peer *peer)
+{
+	kref_put(&peer->refcount, ovpn_peer_release_kref);
+}
+
+/**
+ * ovpn_peer_new - allocate and initialize a new peer object
+ * @ovpn: the openvpn instance inside which the peer should be created
+ * @id: the ID assigned to this peer
+ *
+ * Return: a pointer to the new peer on success or an error code otherwise
+ */
+struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id);
+
+/**
+ * ovpn_peer_add - add peer to the related tables
+ * @ovpn: the openvpn instance the peer belongs to
+ * @peer: the peer object to add
+ *
+ * Assume refcounter was increased by caller
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
+
+/**
+ * ovpn_peer_del - delete peer from related tables
+ * @peer: the peer object to delete
+ * @reason: reason for deleting peer (will be sent to userspace)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+
+/**
+ * ovpn_peer_find - find peer having the specified ID
+ * @ovpn: the openvpn instance to search
+ * @peer_id: the ID of the peer to find
+ *
+ * Return: a pointer to the peer if found or NULL otherwise
+ */
+struct ovpn_peer *ovpn_peer_find(struct ovpn_struct *ovpn, u32 peer_id);
+
+/**
+ * ovpn_peer_release_p2p - release peer upon P2P device teardown
+ * @ovpn: the instance being torn down
+ */
+void ovpn_peer_release_p2p(struct ovpn_struct *ovpn);
+
+/**
+ * ovpn_peer_get_by_transp_addr - retrieve peer by transport address
+ * @ovpn: the openvpn instance to search
+ * @skb: the skb to retrieve the source transport address from
+ *
+ * Return: a pointer to the peer if found or NULL otherwise
+ */
+struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
+					       struct sk_buff *skb);
+
+/**
+ * ovpn_peer_get_by_id - retrieve peer by ID
+ * @ovpn: the openvpn instance to search
+ * @peer_id: the unique peer identifier to match
+ *
+ * Return: a pointer to the peer if found or NULL otherwise
+ */
+struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
+
+#endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.43.2


