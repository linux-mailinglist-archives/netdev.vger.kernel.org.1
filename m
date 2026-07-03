Return-Path: <netdev+bounces-304312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1QQiH3P+RmpLgQsAu9opvQ
	(envelope-from <netdev+bounces-304312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C26FD902
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=p7TCUSn5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE51530730C0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF771DF736;
	Fri,  3 Jul 2026 00:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC61D9A5F
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037422; cv=none; b=SZkU+HxGgfLG96cC15aoZ4j/H6ff+dTveSg/7Z6tENwRifJkiLkY2c7vkprnzWUuhsK3Oo5HNo+rrXW74OvU5RRcOgx8BsUBsObSyYxXRaQtaW2BFQHlImVuY6sLV9h9nphQjW5ba4QdVx7wsMTHaQayxe5lU4ovUX0R9tNGpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037422; c=relaxed/simple;
	bh=ZeIw1Lv1MM6xDl2w1A6Jwv7YPFGPnCh+bCupk0+6zTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gvIWSlQYnpzNteWumlTHHXGsMUnS2jI5DWvuZ1UgDdL97Z3dtO4DDBXbCb1P2T57LuUN4byary7UWiwE0aMpItqjaI1BdV7a5v5a4GuF//ftHhGMahcvO5UwiCl5HMfcEtqomiLoXKybvLuL1HlfogWffSbhNiUlZPykqwen+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7TCUSn5; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37fe90ee192so3731873a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037420; x=1783642220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4S8chRcbYHIzuZiXMgtlX/KF1+2v+ZqceA6HRBq1Ss=;
        b=p7TCUSn5eRuyZ90+tBqAHk3uFYzeFS96krHk9zypP4wT2TsEFHAAc6VPt7OKIx5onA
         hA21ceQmfuJDbzXYRLAuL8r3bVxmqEPWeVv21tvs8PxmUBuUZwqX/m9XTIqK/X7QpJzt
         tkTZTfjOZemC1yqw1611m4MMj8AdZNR9aQdTxxq5Kou4wyEFmb5yeiBnH2Ey5DpbRyqO
         goX+QNLdIURWRxj8YvN3t+Rd49FnZzunm7Gvl0UZqH49ve1eY3Oafi2NwDlQZoKrkIBC
         ZWg2gwrV10juS3FweG2WERWF2THV6jWCrPbrAmNpgYqccAMYX1sxKx9+Am13194eRHoZ
         aRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037420; x=1783642220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4S8chRcbYHIzuZiXMgtlX/KF1+2v+ZqceA6HRBq1Ss=;
        b=fBMKzUVpL+vjOxXFsjZcIz0nxgXx6wkaA1qoQo9HRLC3UH3ieeiwG36vkloZiXoeIW
         SMu7ttmRFJpe5W3uix+Ub5sZcf0UPZ41/oh1R5+fOli0rXIt+PO8D1a6VFDF/sv348cA
         zdF4hNZ2pEPAx8f2Q66CA6f38qKVUJunIn5jN9KmlAVAzohTcqix9ejWPRDQX3E+ejj7
         DZYQggZlDGRMxpTEJJqfkmfNwSPcwOUoYHXbiAyWMwyjJVSAZZoPqq+Dll8O6xR26/nR
         SUAEEiBGtYllmIwnxU2XWXP9xKuQ19F4YrbNQ0MGmkZ5n2D8KnPMHttJNNs1MCuEcznJ
         xjuw==
X-Forwarded-Encrypted: i=1; AHgh+Rpb2lgLtWTeAGSg9goIoGrllfPrZ5FglZ/gZJ2rT2A9fK/b6H43fS2cbKe32OQ9Y+wOMjaAUII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4hP6/A1vY3Jcmfe/mUj4uYNZEDNbk9MCHEuN4NKxk5cSCeqL
	i9Md46eChVUfdk6GkffXmyS0qaBWzFdkGMwyOvMIz/LxiAR4OLMaKIgjfurOTuItzHSRpsogC0O
	SKNO2TA==
X-Received: from pjqa19.prod.google.com ([2002:a17:90a:a513:b0:37d:9c91:ff75])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c04:b0:37f:9ce2:3489
 with SMTP id 98e67ed59e1d1-380aa204c8bmr8929545a91.26.1783037420094; Thu, 02
 Jul 2026 17:10:20 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:22 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/14] ipvlan: Convert ipvl_port.count to refcount_t.
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304312-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B0C26FD902

struct ipvl_port is shared between a lower device and its upper
ipvlan devices.

While each upper device can always access ipvl_port safely via
ipvlan_dev.port, the lower device relies on RTNL to access it
via net_device.rx_handler_data.

Once RTNL is removed, the lower device cannot read ipvl_port safely
in ipvlan_device_event() because the port could be freed concurrently
and net_device.rx_handler_data is set to NULL if the last ipvlan
device in another namespace is unregistered.

Let's convert ipvl_port.count to refcount_t and use RCU along with
refcount_inc_not_zero() in ipvlan_device_event().

netdev_put() in ipvlan_port_destroy() is also moved down after
cancel_work_sync(), which is the last user of port->dev.

Note that ipvlan->port is now set in ipvlan_init() so that it can
be used in ipvlan_uninit(), instead of ipvlan_port_get_rtnl()
(rtnl_dereference()).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ipvlan/ipvlan.h      |  2 +-
 drivers/net/ipvlan/ipvlan_main.c | 75 ++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 80f84fc87008..78f9107fa752 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -96,7 +96,7 @@ struct ipvl_port {
 	u16			dev_id_start;
 	struct work_struct	wq;
 	struct sk_buff_head	backlog;
-	int			count;
+	refcount_t		count;
 	struct ida		ida;
 	netdevice_tracker	dev_tracker;
 };
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ed46439a9f4e..b4906a8d24ef 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -86,6 +86,7 @@ static int ipvlan_port_create(struct net_device *dev)
 		goto err;
 
 	netdev_hold(dev, &port->dev_tracker, GFP_KERNEL);
+
 	return 0;
 
 err:
@@ -93,16 +94,18 @@ static int ipvlan_port_create(struct net_device *dev)
 	return err;
 }
 
-static void ipvlan_port_destroy(struct net_device *dev)
+static void ipvlan_port_destroy(struct ipvl_port *port)
 {
-	struct ipvl_port *port = ipvlan_port_get_rtnl(dev);
+	struct net_device *dev = port->dev;
 	struct sk_buff *skb;
 
-	netdev_put(dev, &port->dev_tracker);
 	if (port->mode == IPVLAN_MODE_L3S)
 		ipvlan_l3s_unregister(port);
+
 	netdev_rx_handler_unregister(dev);
 	cancel_work_sync(&port->wq);
+	netdev_put(dev, &port->dev_tracker);
+
 	while ((skb = __skb_dequeue(&port->backlog)) != NULL) {
 		dev_put(skb->dev);
 		kfree_skb(skb);
@@ -111,6 +114,27 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	kfree(port);
 }
 
+static void ipvlan_port_put(struct ipvl_port *port)
+{
+	if (refcount_dec_and_test(&port->count))
+		ipvlan_port_destroy(port);
+}
+
+static struct ipvl_port *ipvlan_port_get(struct net_device *dev)
+{
+	struct ipvl_port *port = NULL;
+
+	rcu_read_lock();
+	if (netif_is_ipvlan_port(dev)) {
+		port = ipvlan_port_get_rcu(dev);
+		if (!refcount_inc_not_zero(&port->count))
+			port = NULL;
+	}
+	rcu_read_unlock();
+
+	return port;
+}
+
 #define IPVLAN_ALWAYS_ON_OFLOADS \
 	(NETIF_F_SG | NETIF_F_HW_CSUM | \
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL)
@@ -159,24 +183,24 @@ static int ipvlan_init(struct net_device *dev)
 			free_percpu(ipvlan->pcpu_stats);
 			return err;
 		}
+		port = ipvlan_port_get_rtnl(phy_dev);
+		refcount_set(&port->count, 1);
+	} else {
+		port = ipvlan_port_get_rtnl(phy_dev);
+		refcount_inc(&port->count);
 	}
-	port = ipvlan_port_get_rtnl(phy_dev);
-	port->count += 1;
+
+	ipvlan->port = port;
+
 	return 0;
 }
 
 static void ipvlan_uninit(struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	struct net_device *phy_dev = ipvlan->phy_dev;
-	struct ipvl_port *port;
 
 	free_percpu(ipvlan->pcpu_stats);
-
-	port = ipvlan_port_get_rtnl(phy_dev);
-	port->count -= 1;
-	if (!port->count)
-		ipvlan_port_destroy(port->dev);
+	ipvlan_port_put(ipvlan->port);
 }
 
 static int ipvlan_open(struct net_device *dev)
@@ -594,9 +618,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (err < 0)
 		return err;
 
-	/* ipvlan_init() would have created the port, if required */
-	port = ipvlan_port_get_rtnl(phy_dev);
-	ipvlan->port = port;
+	port = ipvlan->port;
 
 	/* If the port-id base is at the MAX value, then wrap it around and
 	 * begin from 0x1 again. This may be due to a busy system where lots
@@ -729,14 +751,13 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	struct netdev_notifier_pre_changeaddr_info *prechaddr_info;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct ipvl_dev *ipvlan, *next;
+	int err, ret = NOTIFY_DONE;
 	struct ipvl_port *port;
 	LIST_HEAD(lst_kill);
-	int err;
-
-	if (!netif_is_ipvlan_port(dev))
-		return NOTIFY_DONE;
 
-	port = ipvlan_port_get_rtnl(dev);
+	port = ipvlan_port_get(dev);
+	if (!port)
+		return ret;
 
 	switch (event) {
 	case NETDEV_UP:
@@ -788,8 +809,10 @@ static int ipvlan_device_event(struct notifier_block *unused,
 			err = netif_pre_changeaddr_notify(ipvlan->dev,
 							  prechaddr_info->dev_addr,
 							  extack);
-			if (err)
-				return notifier_from_errno(err);
+			if (err) {
+				ret = notifier_from_errno(err);
+				break;
+			}
 		}
 		break;
 
@@ -802,7 +825,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 	case NETDEV_PRE_TYPE_CHANGE:
 		/* Forbid underlying device to change its type. */
-		return NOTIFY_BAD;
+		ret = NOTIFY_BAD;
+		break;
 
 	case NETDEV_NOTIFY_PEERS:
 	case NETDEV_BONDING_FAILOVER:
@@ -810,7 +834,10 @@ static int ipvlan_device_event(struct notifier_block *unused,
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
 			call_netdevice_notifiers(event, ipvlan->dev);
 	}
-	return NOTIFY_DONE;
+
+	ipvlan_port_put(port);
+
+	return ret;
 }
 
 /* the caller must held the addrs lock */
-- 
2.55.0.rc0.799.gd6f94ed593-goog


