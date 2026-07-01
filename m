Return-Path: <netdev+bounces-303854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P91PDgqLRWr4BgsAu9opvQ
	(envelope-from <netdev+bounces-303854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD36F1EF3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HjDBiKy0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CD531494F6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1D3C0A1B;
	Wed,  1 Jul 2026 21:43:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2583C1F57
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942236; cv=none; b=Dr7HIILHepmmG1WWrFyLjLfY5mv20t6mBv8PKKfjAmg5kVNqS89qztOIJqy3QSdOEo3vK8y/uIYWJjF2w3mKcAsb2CHrLsLnq6rsei+IBQTvjePqzl/D4EkMF2UaiqDYk8vrFU2Odna9K7Kv6DlbHoctCbqVQ05nt5Ed2pG9jF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942236; c=relaxed/simple;
	bh=t5ENd1mkzQuGPmYd+42MsFofJlhIs2UEVwgmrhSGLWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dIql4u++raCUMnWQHz1vZveuY2QBeQrPFRjLqubft9tzoOB/ICiBR0jeM/pjJzK5BVPHNrjVqGdL2YN0h6jSi41Q5S0KOZtWanZx+VrtCr9+tnPkjH4UDHT5kBbNwPkZIWwGqakt6EdHnTuplinYcec/k2pqPykRhDD/5I/aC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HjDBiKy0; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847a90cc5e2so1568357b3a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942234; x=1783547034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lD9cIoKFwBPvf1p48oEMY4xy9M+2NiAOdwcFJgB+KVg=;
        b=HjDBiKy0W2gMnDS+kDjcYYEqa/7ML9elNdzXrpOkRa79y4xxE7tNWG6OUs8tLHTP1L
         C4OFTVdcHRkKH+V6DGoJs267iiE4XQdnIS+5YfG731ndy8MSwXGu7ZH3cIoduXrV41Q2
         oFbZvr90m02x845jxOQvaWnznYC8Bq4TbfKYCkOVfJiLlQD4sb/hfeenmwPF4X9Jh4eQ
         bqBIByqSR+z8ijgJIQRJ2iCxepp4UrncjCuW+aub8JMr9FOhwdzjZl+JcokI8dNn9JvL
         zpxGvDciIimQ6t5FPsERMEUoUH/WzIo1bBWj1+Gm5b8W28UfDu0qR7UbbdSyqHt/VawA
         +13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942234; x=1783547034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD9cIoKFwBPvf1p48oEMY4xy9M+2NiAOdwcFJgB+KVg=;
        b=DE2wRBcJ8s/xpv7CqpNyncmNW3xvKr3S6q5nKJiw4FYagpiGjh+Xt4kcOEfPbPLs+f
         Hg4jTOobDpdcQtR/rRFZbD7+IbXxyJrXJnf9BHlH/imrzD5wpPFkYrLm4/QjkwGngrXx
         rh3KA1kIIlAkIoBaSSIHXMW/aGuRMBdMc0GWzN7WuBzXT7BzyMdJteFMjCdmDWEO4vWp
         Nu4vwsOOC46CR3T5dhlp32grOUdlDq3JL49XgUzifICPprUe28JmSzBA3jYQ8JaodgzZ
         DDG/WFiIRvhianlHc9Qc9eYvYJ4/bx2LjXzLK7GilJHEVGBmeV7lhpZdKbH/1csr+8rp
         QFaw==
X-Forwarded-Encrypted: i=1; AFNElJ/3Jk3pmOEqeeDFxMYTt1BKeSXHP3ygxr0qmOKKYii3QxqDQBjxxXE6g3ytcN0m3HMPdZT543Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWNN3P045x2u4w6U84QOV9PhVMzD38KMOvTVqkzDXGHq6yDHo
	I4pcseykBnkKfbvnTXs74PgTm9Lz6mDMDues05TkpcypsJSxZC6Q5AE4/Yq/TVup8ukSomC4zld
	D8s8Xtg==
X-Received: from pfnr24.prod.google.com ([2002:aa7:8458:0:b0:847:ac08:fdf6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:420d:b0:846:2f5c:dc39
 with SMTP id d2e1a72fcca58-847c0a39468mr3190362b3a.42.1782942234231; Wed, 01
 Jul 2026 14:43:54 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:52 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-15-kuniyu@google.com>
Subject: [PATCH v1 net-next 14/14] ipvlan: Support per-netns netdev unregistration.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303854-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DCD36F1EF3

When a lower device is unregistered, its upper ipvlan devices
must also be unregistered.  However, these upper devices may
reside in different netns than the lower device.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration for ipvlan.

The new dying flag in struct ipvl_dev is used to avoid a race
that ipvlan_link_delete() is called while its lower device is
being removed in ipvlan_device_event().

If dying is true in ipvlan_link_delete(), the ipvlan device is
already destructed but not yet unregistered.  In this case,
unregistration will be done in __rtnl_net_unlock() of the
->dellink() caller.

Tested:

1. Create veth in ns1 and two ipvlan devices in ns2 and ns3.

  # ip netns add ns1
  # ip netns add ns2
  # ip netns add ns3
  # ip -n ns1 link add veth0 type veth peer veth1
  # ip -n ns2 link add ipvl2 link veth0 link-netns ns1 type ipvlan mode l2
  # ip -n ns3 link add ipvl3 link veth0 link-netns ns1 type ipvlan mode l2

2. Run bpftrace to check that veth is unregistered first but
   wait ipvlan to be unregistered

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:ipvlan_uninit,
  kprobe:veth_dellink,
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

3. Remove the lower veth0 in ns1.

  # ip -n ns1 link del veth0

We can see that veth0 is freed after unregistering ipvl2 and ipvl3
in per-netns work because ipvl_port holds refcount of veth0.

  PID: 2010 | DEV: veth0
          veth_dellink+5
          rtnl_dellink+1213
          rtnetlink_rcv_msg+1791
  ...
  PID: 440 | DEV: ipvl2
          ipvlan_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 440 | DEV: ipvl2
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...
  PID: 440 | DEV: ipvl3
          ipvlan_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 2010 | DEV: veth0
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
  ...
  PID: 440 | DEV: ipvl3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ipvlan/ipvlan.h      |  4 +++-
 drivers/net/ipvlan/ipvlan_main.c | 25 ++++++++++++++++---------
 drivers/net/ipvlan/ipvtap.c      |  3 ++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index a0736f5c89f6..a83313244add 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -72,6 +72,7 @@ struct ipvl_dev {
 	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
 	netdev_features_t	sfeatures;
 	u32			msg_enable;
+	bool			dying;
 };
 
 struct ipvl_addr {
@@ -216,7 +217,8 @@ struct ipvtap_dev {
 	struct tap_dev	  tap;
 };
 
-void __ipvtap_dellink(struct net_device *dev, struct list_head *head);
+void __ipvtap_dellink(struct net *net, struct net_device *dev,
+		      struct list_head *head);
 #endif
 
 #endif /* __IPVLAN_H */
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 41024fe27b78..7e2cf43ca78a 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -700,7 +700,8 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_new);
 
-static void __ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+static void __ipvlan_link_delete(struct net *net, struct net_device *dev,
+				 struct list_head *head)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
@@ -715,7 +716,7 @@ static void __ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 
 	ida_free(&ipvlan->port->ida, dev->dev_id);
 	list_del_rcu(&ipvlan->pnode);
-	unregister_netdevice_queue(dev, head);
+	unregister_netdevice_queue_net(net, dev, head);
 	netdev_upper_dev_unlink(ipvlan->phy_dev, dev);
 }
 
@@ -724,18 +725,20 @@ static void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 
 	mutex_lock(&ipvlan->port->pnodes_lock);
-	__ipvlan_link_delete(dev, head);
+	if (!ipvlan->dying)
+		__ipvlan_link_delete(dev_net(dev), dev, head);
 	mutex_unlock(&ipvlan->port->pnodes_lock);
 }
 
 #if IS_ENABLED(CONFIG_IPVTAP)
-void __ipvtap_dellink(struct net_device *dev, struct list_head *head)
+void __ipvtap_dellink(struct net *net, struct net_device *dev,
+		      struct list_head *head)
 {
 	struct ipvtap_dev *vlantap = netdev_priv(dev);
 
 	netdev_rx_handler_unregister(dev);
 	tap_del_queues(&vlantap->tap);
-	__ipvlan_link_delete(dev, head);
+	__ipvlan_link_delete(net, dev, head);
 }
 EXPORT_SYMBOL_GPL(__ipvtap_dellink);
 #endif
@@ -832,22 +835,26 @@ static int ipvlan_device_event(struct notifier_block *unused,
 			ipvlan_migrate_l3s_hook(oldnet, newnet);
 		break;
 	}
-	case NETDEV_UNREGISTER:
+	case NETDEV_UNREGISTER: {
+		struct net *net = dev_net(dev);
+
 		if (dev->reg_state != NETREG_UNREGISTERING)
 			break;
 
 		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode) {
+			ipvlan->dying = true;
+
 #if IS_ENABLED(CONFIG_IPVTAP)
 			if (ipvlan->dev->rtnl_link_ops != &ipvlan_link_ops)
-				__ipvtap_dellink(ipvlan->dev, &lst_kill);
+				__ipvtap_dellink(net, ipvlan->dev, &lst_kill);
 			else
 #endif
-				__ipvlan_link_delete(ipvlan->dev, &lst_kill);
+				__ipvlan_link_delete(net, ipvlan->dev, &lst_kill);
 		}
 
 		unregister_netdevice_many(&lst_kill);
 		break;
-
+	}
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			netif_inherit_tso_max(ipvlan->dev, dev);
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 17b0dd7cf73b..b790959c03f5 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -110,7 +110,8 @@ static void ipvtap_dellink(struct net_device *dev,
 	struct ipvl_port *port = vlantap->vlan.port;
 
 	mutex_lock(&port->pnodes_lock);
-	__ipvtap_dellink(dev, head);
+	if (!vlantap->vlan.dying)
+		__ipvtap_dellink(dev_net(dev), dev, head);
 	mutex_unlock(&port->pnodes_lock);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


