Return-Path: <netdev+bounces-303853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsmjOPyKRWr3BgsAu9opvQ
	(envelope-from <netdev+bounces-303853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693B6F1EF0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=D4ggogV4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303853-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303853-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51AF731422E9
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA13C378D;
	Wed,  1 Jul 2026 21:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C93C0610
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942235; cv=none; b=JfqSnufRYQy3tpzOnscQso1Syy8jsbLp1M2T7/1cOdi6FgC6H7HZX2gFpj88z2zQ8J5TVJ+qzPSfraPGkGP3JEHV2+u1zWEdmjvlzk24x/sCsxf2mEd0ZwIagIgUj0qcdMO0wRGhZl9/qWnJgOm/jR5dYHgAcT8gBOKIc4qm5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942235; c=relaxed/simple;
	bh=N85TsSVfiXwV7Dhay0+hWuCPLueK2Nng3Oe24ibmbDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DfeQN/GNCSorf/rTwVt4qrB0BwKr5kR6biMxkkHN3F/0mC4N800lZhH+STH1KbXC8Awe3IzSNTQXbd+LkzJmY6x3FSYfK7k742MjXW0yVyHhH5yt+UZc6qyj+5NrPnnFU7cai4GeSphBP5yW//jtSUBAkp7iVsg6RS4Dwsgtprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4ggogV4; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80f89b64bso17731555ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942234; x=1783547034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hReG2tLuI+IOI3uZUoRYeDbymHgG20XIWW6hVW0ZTs=;
        b=D4ggogV4zjGH5MCsv7pgQoinwMqIcgU43xp9lt0xJI05aKHFNpEe7JNmvWf1Br3sEj
         xrrCyp++NFIRF7U2SOTJ6RGVpYeO8xJyTCPDFB/PhtgcMXihutO79RnhEBl0siy1SsHj
         NjHKYgTyFhmegtiU7kkHSR2tCoK/yEhSuRz90U1ULz93BiBYerJBtxkuMYS3SO2w8/I8
         OX1R5aMDYv+37JBJTN36mpns+71UfPcAoxggW3Ltrw9et34T0uBiynMOFPooajM4LayW
         WPyWrrph0BT2lQXOxCWPQQzp6Ks2cl/2ELBeN1mG8rU83LFxAQolYA/nsfuKoqd3QnZN
         ly0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942234; x=1783547034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hReG2tLuI+IOI3uZUoRYeDbymHgG20XIWW6hVW0ZTs=;
        b=qPku8Orj5wqgCr2yLq4eyy1d4ZVp2C6jMg7ADimK/BWLzRi0U+uh0oKcTkyltBicYQ
         NMY0XJLmagK2AQ3SXv2ZinTS6DVmUJHRrsTuOlg9B6Bfp5oTaD0Ss1g4We49tO2OAYeV
         72PAiFvGxpaF5eitgupviNBgLQRPz272spphkuUNgkCwRwJDsVfmoihPeX1Ujpn5F/YC
         +EmefJxWP5We2uvFWKfEwB4r1cEzrPGfQolRH7p6OQWRNBI4N7lRq28vTa9U7k3nXJis
         x8Z52fCOPsMfkNj+6N8Am+MYHyyE3I7F2Tpp/sfr7CPTmHcP9Gu7Y8MWcmg6+Y4LuXTU
         kLiA==
X-Forwarded-Encrypted: i=1; AHgh+RpGUbmBQGggOclUHqJzhHoQckxDIkJY3MZ/SIOKJjPW0ODAN0JEO8WsrguGj0IvWgdC1o2332k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65yvxstiPmcUabmjFM0gvvHjnA7Tu7sBtNYUdDGvxLbTT8nXl
	XbGKCYnhrUv7k6tcZupnYVlsXi1wLz5u1n1WqpvpBaZpWtKIEYAQZrHijZ2Ys+m2Pu+KbauhfII
	VFtBK1A==
X-Received: from plzv12.prod.google.com ([2002:a17:902:b7cc:b0:2c7:a38:d02b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc4:b0:2ca:de3:15e1
 with SMTP id d9443c01a7336-2ca7e75ceedmr32901335ad.31.1782942233471; Wed, 01
 Jul 2026 14:43:53 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:51 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/14] ipvlan: Protect ipvl_port.ipvlans with mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303853-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4693B6F1EF0

struct ipvl_port is shared between a lower device and its upper
ipvlan devices.

All upper devices are linked to ipvl_port.ipvlans.

Once RTNL is removed, the list can be modified concurrently from
different netns due to device removal.

Let's protect it with a per-port mutex.

NETDEV_PRECHANGEUPPER and NETDEV_CHANGEUPPER are explicitly
skipped to avoid deadlock for netdev_upper_dev_unlink() called
from NETDEV_UNREGISTER.

Note that __ipvtap_dellink() and struct ipvtap_dev is moved to
ipvlan.c/h for CONFIG_IPVLAN=y but CONFIG_IPVTAP=m.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ipvlan/ipvlan.h      | 14 ++++++++-
 drivers/net/ipvlan/ipvlan_main.c | 54 +++++++++++++++++++++++++++++---
 drivers/net/ipvlan/ipvtap.c      | 15 +++------
 3 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 78f9107fa752..a0736f5c89f6 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -16,6 +16,9 @@
 #include <linux/if_arp.h>
 #include <linux/if_link.h>
 #include <linux/if_vlan.h>
+#if IS_ENABLED(CONFIG_IPVTAP)
+#include <linux/if_tap.h>
+#endif
 #include <linux/ip.h>
 #include <linux/inetdevice.h>
 #include <linux/netfilter.h>
@@ -91,6 +94,7 @@ struct ipvl_port {
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
 	spinlock_t		addrs_lock; /* guards hash-table and addrs */
 	struct list_head	ipvlans;
+	struct mutex		pnodes_lock;
 	u16			mode;
 	u16			flags;
 	u16			dev_id_start;
@@ -168,7 +172,6 @@ void ipvlan_count_rx(const struct ipvl_dev *ipvlan,
 		     unsigned int len, bool success, bool mcast);
 int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 		    struct netlink_ext_ack *extack);
-void ipvlan_link_delete(struct net_device *dev, struct list_head *head);
 void ipvlan_link_setup(struct net_device *dev);
 int ipvlan_link_register(struct rtnl_link_ops *ops);
 #ifdef CONFIG_IPVLAN_L3S
@@ -207,4 +210,13 @@ static inline bool netif_is_ipvlan_port(const struct net_device *dev)
 	return rcu_access_pointer(dev->rx_handler) == ipvlan_handle_frame;
 }
 
+#if IS_ENABLED(CONFIG_IPVTAP)
+struct ipvtap_dev {
+	struct ipvl_dev vlan;
+	struct tap_dev	  tap;
+};
+
+void __ipvtap_dellink(struct net_device *dev, struct list_head *head);
+#endif
+
 #endif /* __IPVLAN_H */
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 7adad781e9b5..41024fe27b78 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -16,6 +16,8 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 
 	ASSERT_RTNL();
 	if (port->mode != nval) {
+		mutex_lock(&port->pnodes_lock);
+
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			flags = ipvlan->dev->flags;
 			if (nval == IPVLAN_MODE_L3 || nval == IPVLAN_MODE_L3S) {
@@ -40,6 +42,8 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 			ipvlan_l3s_unregister(port);
 		}
 		port->mode = nval;
+
+		mutex_unlock(&port->pnodes_lock);
 	}
 	return 0;
 
@@ -56,6 +60,8 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 					 NULL);
 	}
 
+	mutex_unlock(&port->pnodes_lock);
+
 	return err;
 }
 
@@ -76,6 +82,7 @@ static int ipvlan_port_create(struct net_device *dev)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
 	spin_lock_init(&port->addrs_lock);
+	mutex_init(&port->pnodes_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
@@ -676,7 +683,10 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (err)
 		goto unlink_netdev;
 
+	mutex_lock(&port->pnodes_lock);
 	list_add_tail_rcu(&ipvlan->pnode, &port->ipvlans);
+	mutex_unlock(&port->pnodes_lock);
+
 	netif_stacked_transfer_operstate(phy_dev, dev);
 	return 0;
 
@@ -690,7 +700,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_new);
 
-void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+static void __ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
@@ -708,7 +718,27 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 	netdev_upper_dev_unlink(ipvlan->phy_dev, dev);
 }
-EXPORT_SYMBOL_GPL(ipvlan_link_delete);
+
+static void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	mutex_lock(&ipvlan->port->pnodes_lock);
+	__ipvlan_link_delete(dev, head);
+	mutex_unlock(&ipvlan->port->pnodes_lock);
+}
+
+#if IS_ENABLED(CONFIG_IPVTAP)
+void __ipvtap_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct ipvtap_dev *vlantap = netdev_priv(dev);
+
+	netdev_rx_handler_unregister(dev);
+	tap_del_queues(&vlantap->tap);
+	__ipvlan_link_delete(dev, head);
+}
+EXPORT_SYMBOL_GPL(__ipvtap_dellink);
+#endif
 
 void ipvlan_link_setup(struct net_device *dev)
 {
@@ -770,10 +800,16 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	struct ipvl_port *port;
 	LIST_HEAD(lst_kill);
 
+	if (event == NETDEV_PRECHANGEUPPER ||
+	    event == NETDEV_CHANGEUPPER)
+		return ret;
+
 	port = ipvlan_port_get(dev);
 	if (!port)
 		return ret;
 
+	mutex_lock(&port->pnodes_lock);
+
 	switch (event) {
 	case NETDEV_UP:
 	case NETDEV_DOWN:
@@ -800,9 +836,15 @@ static int ipvlan_device_event(struct notifier_block *unused,
 		if (dev->reg_state != NETREG_UNREGISTERING)
 			break;
 
-		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode)
-			ipvlan->dev->rtnl_link_ops->dellink(ipvlan->dev,
-							    &lst_kill);
+		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode) {
+#if IS_ENABLED(CONFIG_IPVTAP)
+			if (ipvlan->dev->rtnl_link_ops != &ipvlan_link_ops)
+				__ipvtap_dellink(ipvlan->dev, &lst_kill);
+			else
+#endif
+				__ipvlan_link_delete(ipvlan->dev, &lst_kill);
+		}
+
 		unregister_netdevice_many(&lst_kill);
 		break;
 
@@ -850,6 +892,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 			call_netdevice_notifiers(event, ipvlan->dev);
 	}
 
+	mutex_unlock(&port->pnodes_lock);
+
 	ipvlan_port_put(port);
 
 	return ret;
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 2d6bbddd1edd..17b0dd7cf73b 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -2,7 +2,6 @@
 #include <linux/etherdevice.h>
 #include "ipvlan.h"
 #include <linux/if_vlan.h>
-#include <linux/if_tap.h>
 #include <linux/interrupt.h>
 #include <linux/nsproxy.h>
 #include <linux/compat.h>
@@ -43,11 +42,6 @@ static struct class ipvtap_class = {
 	 .namespace = ipvtap_net_namespace,
 };
 
-struct ipvtap_dev {
-	struct ipvl_dev vlan;
-	struct tap_dev	  tap;
-};
-
 static void ipvtap_count_tx_dropped(struct tap_dev *tap)
 {
 	struct ipvtap_dev *vlantap = container_of(tap, struct ipvtap_dev, tap);
@@ -112,11 +106,12 @@ static int ipvtap_newlink(struct net_device *dev,
 static void ipvtap_dellink(struct net_device *dev,
 			   struct list_head *head)
 {
-	struct ipvtap_dev *vlan = netdev_priv(dev);
+	struct ipvtap_dev *vlantap = netdev_priv(dev);
+	struct ipvl_port *port = vlantap->vlan.port;
 
-	netdev_rx_handler_unregister(dev);
-	tap_del_queues(&vlan->tap);
-	ipvlan_link_delete(dev, head);
+	mutex_lock(&port->pnodes_lock);
+	__ipvtap_dellink(dev, head);
+	mutex_unlock(&port->pnodes_lock);
 }
 
 static void ipvtap_setup(struct net_device *dev)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


