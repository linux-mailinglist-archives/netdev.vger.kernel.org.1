Return-Path: <netdev+bounces-246361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB8CE9DCC
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 15:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 212CF303C9A6
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A5D824BD;
	Tue, 30 Dec 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRyp0v6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0723EABC
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103433; cv=none; b=DYuFEQEiUgIWiqtmulJ3TMr5dupZx3/Wqbv0Dj8lA0K7Cnn1p9eXHHvH87fjtUjgr/Xa3TXSxFGYkPlhnoDsFhABhhwxvpA2KdADJaiEI8BpVS7cfVo3OWYPi5PS9nuLdJzOH4jC6/+C2Q9kQznx9XvUGrcRYk7RrceZE8DpSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103433; c=relaxed/simple;
	bh=ai57lw+IyZPLDZShfOAW2fr8DOx+AZ1J6NXtWpvW6Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY5CeiFiUn7d/EQsh71znEDpUEwcSRY9BrGHBan2ovEIYdvHGzN/Rngp1r0YR/tyDtzkAli5fc3UUaBDFINiFUVvKE+/njja4xFvCfmiZAU97bVg/3Yzz8SXis9GIrWdri4xIHa9PmgdSU6v7DGOe6VSZSZxKvE/ysOvPIPYhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRyp0v6d; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-597d712c0a7so10311552e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767103428; x=1767708228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9j6F6fJjGlBfrFM5KhwZ/tPyJ1L3hpmhboVpZuKn+I=;
        b=PRyp0v6d+BGC0RqOWBnyDVtmw0XXsN4fnlEVv5LSjYaHVoUrdW3+rl0Rqpcp7hazpq
         21izm6DRrN5OVl3z8GlRVn8SrKgTF56Pav/vWmPWTXMCq1JdzKNVrvD0bTKkZezchxtj
         rpyeS0Owi+dUuTurU6n4fMvZ9Jlp48zEcsBecigKSUMMACzezYBCjZ7ARZpMKfcoLwEB
         IS50VEDhSSARgFY3o7a0y4sl6aiLHAF8y6py7u7o+kz/rPfFr2GFeze42s18uszFQJke
         uVLJIoRphHiBMuAm/fBF/RMvewKz4enmXPHApjZKdwY/Jc5PXMh0YyKRN2qFdMG5a9EM
         RlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767103428; x=1767708228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9j6F6fJjGlBfrFM5KhwZ/tPyJ1L3hpmhboVpZuKn+I=;
        b=A3eP1hUM1ONvZsCMR3HA7PVMWRpapWtujwr5MfJMXaD+y4WX5PHUoCr9PP5pOPu7Yt
         0iDpCYLi252zKQ8DzqjMQiI2Jtznj+Va1yqNLwlb/I3NSqoUaeM1f0oNyLMeRKn0iuGS
         qP/2dMu3RU4xpnxr+a/00Dl6qAOW9RfFTHgOktkyymMAOOdCLIlmwpIEUVIxO08lPjDt
         EYlXzJSQzhLlMBTAGMGqcu4sCDN6uRLgGFPzfDFcdYw/3XOlviBRpX1W1NzoxmJAoOxn
         ynZz9p0/y/oRNI29rDKtedrZyk+BazgaF8t1XJDxn4WZha4p4xZAwJU8UhCUovnSk17Z
         uX7A==
X-Gm-Message-State: AOJu0YypW8R1pSHuPBjLeEQM6I7GCwjBQ7iA1TsfMnJc0LzsgSxNDG+c
	FEXQdnUuUD77XR+U7AMv0cn4BKsMdi8OqRSo1LWEHTdXsWq4GVtHmqhyfEUFxZ7SufQ=
X-Gm-Gg: AY/fxX4W5ONgra/H914IDkN0jaMxhZDLFYx4tzN9PumL6oq+acHZQ5MlxWYr2rsWLmC
	oG/CjTNLWDgxqEhlAl8GGSkzLbtqFzAnWq6D55Rf0eKPQZdnaaiCCFuOdzrRg4p+80q4DjEbOTE
	SyKSIKQvp1raXdFml5+KkCUBailBB4AGcZiDJpwDnDFB1sm56OO02kaFII4JHjMAjcbObZWhpIF
	4tzD0JyDUAo1vJxUSxZHOmnVAx22cM1Ohlq7X/n72A4Hiwt46Xr7YoBLFnQGUPmewIbbETlYscQ
	+BJC0XkoEaHbC0YxxhESx8TRHTEMgTE3PODhSirvUT/wnQtTUVUbylQUxNPzYC8FS63NCTru5zN
	6F/ssgkzs67ShJmZL/WtlJKbuXvahzgk8FYc31HjYRx1KgnWZFYui/GnqW4DmQm/8fMY64GWQUV
	SwhxAIQ1HzBXWVAXySlvmVMVltiZ6vUe7jkz2/AADvzy8m48ogVG1k6FdJ+tjdrGjEOf3r+U2ow
	qdR7Q==
X-Google-Smtp-Source: AGHT+IGL+RQbOEG7EUZxzoIIE8038KcGKWRpMiOxd2cKkfZY7kLSoUdYdfUWrJZZotTYpIWT1c6OHw==
X-Received: by 2002:a05:6512:32c7:b0:59a:1357:e440 with SMTP id 2adb3069b0e04-59a17d9a251mr12205895e87.28.1767103428099;
        Tue, 30 Dec 2025 06:03:48 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f7f5sm10191272e87.72.2025.12.30.06.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:03:47 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Julian Vetter <julian@outer-limits.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guillaume Nault <gnault@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH v4 net 1/2] ipvlan: Make the addrs_lock be per port
Date: Tue, 30 Dec 2025 17:03:23 +0300
Message-ID: <20251230140333.2088391-2-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
References: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the addrs_lock be per port, not per ipvlan dev.

Initial code seems to be written in the assumption,
that any address change must occur under RTNL.
But it is not so for the case of IPv6. So

1) Introduce per-port addrs_lock.

2) It was needed to fix places where it was forgotten
to take lock (ipvlan_open/ipvlan_close)

This appears to be a very minor problem though.
Since it's highly unlikely that ipvlan_add_addr() will
be called on 2 CPU simultaneously. But nevertheless,
this could cause:

1) False-negative of ipvlan_addr_busy(): one interface
iterated through all port->ipvlans + ipvlan->addrs
under some ipvlan spinlock, and another added IP
under its own lock. Though this is only possible
for IPv6, since looks like only ipvlan_addr6_event() can be
called without rtnl_lock.

2) Race since ipvlan_ht_addr_add(port) is called under
different ipvlan->addrs_lock locks

This should not affect performance, since add/remove IP
is a rare situation and spinlock is not taken on fast
paths.

Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
---
v4:
  - No changes since v3

 drivers/net/ipvlan/ipvlan.h      |  2 +-
 drivers/net/ipvlan/ipvlan_core.c | 16 +++++------
 drivers/net/ipvlan/ipvlan_main.c | 49 +++++++++++++++++++-------------
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 50de3ee204db..80f84fc87008 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -69,7 +69,6 @@ struct ipvl_dev {
 	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
 	netdev_features_t	sfeatures;
 	u32			msg_enable;
-	spinlock_t		addrs_lock;
 };
 
 struct ipvl_addr {
@@ -90,6 +89,7 @@ struct ipvl_port {
 	struct net_device	*dev;
 	possible_net_t		pnet;
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
+	spinlock_t		addrs_lock; /* guards hash-table and addrs */
 	struct list_head	ipvlans;
 	u16			mode;
 	u16			flags;
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 2efa3ba148aa..bdb3a46b327c 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -107,17 +107,15 @@ void ipvlan_ht_addr_del(struct ipvl_addr *addr)
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6)
 {
-	struct ipvl_addr *addr, *ret = NULL;
+	struct ipvl_addr *addr;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode) {
-		if (addr_equal(is_v6, addr, iaddr)) {
-			ret = addr;
-			break;
-		}
+	assert_spin_locked(&ipvlan->port->addrs_lock);
+
+	list_for_each_entry(addr, &ipvlan->addrs, anode) {
+		if (addr_equal(is_v6, addr, iaddr))
+			return addr;
 	}
-	rcu_read_unlock();
-	return ret;
+	return NULL;
 }
 
 bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 660f3db11766..baccdad695fd 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -75,6 +75,7 @@ static int ipvlan_port_create(struct net_device *dev)
 	for (idx = 0; idx < IPVLAN_HASH_SIZE; idx++)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
+	spin_lock_init(&port->addrs_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
@@ -181,6 +182,7 @@ static void ipvlan_uninit(struct net_device *dev)
 static int ipvlan_open(struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct ipvl_port *port = ipvlan->port;
 	struct ipvl_addr *addr;
 
 	if (ipvlan->port->mode == IPVLAN_MODE_L3 ||
@@ -189,10 +191,10 @@ static int ipvlan_open(struct net_device *dev)
 	else
 		dev->flags &= ~IFF_NOARP;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
+	spin_lock_bh(&port->addrs_lock);
+	list_for_each_entry(addr, &ipvlan->addrs, anode)
 		ipvlan_ht_addr_add(ipvlan, addr);
-	rcu_read_unlock();
+	spin_unlock_bh(&port->addrs_lock);
 
 	return 0;
 }
@@ -206,10 +208,10 @@ static int ipvlan_stop(struct net_device *dev)
 	dev_uc_unsync(phy_dev, dev);
 	dev_mc_unsync(phy_dev, dev);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
+	spin_lock_bh(&ipvlan->port->addrs_lock);
+	list_for_each_entry(addr, &ipvlan->addrs, anode)
 		ipvlan_ht_addr_del(addr);
-	rcu_read_unlock();
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 
 	return 0;
 }
@@ -579,7 +581,6 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (!tb[IFLA_MTU])
 		ipvlan_adjust_mtu(ipvlan, phy_dev);
 	INIT_LIST_HEAD(&ipvlan->addrs);
-	spin_lock_init(&ipvlan->addrs_lock);
 
 	/* TODO Probably put random address here to be presented to the
 	 * world but keep using the physical-dev address for the outgoing
@@ -657,13 +658,13 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	list_for_each_entry_safe(addr, next, &ipvlan->addrs, anode) {
 		ipvlan_ht_addr_del(addr);
 		list_del_rcu(&addr->anode);
 		kfree_rcu(addr, rcu);
 	}
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 
 	ida_free(&ipvlan->port->ida, dev->dev_id);
 	list_del_rcu(&ipvlan->pnode);
@@ -817,6 +818,8 @@ static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
+	assert_spin_locked(&ipvlan->port->addrs_lock);
+
 	addr = kzalloc(sizeof(struct ipvl_addr), GFP_ATOMIC);
 	if (!addr)
 		return -ENOMEM;
@@ -847,16 +850,16 @@ static void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	addr = ipvlan_find_addr(ipvlan, iaddr, is_v6);
 	if (!addr) {
-		spin_unlock_bh(&ipvlan->addrs_lock);
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
 		return;
 	}
 
 	ipvlan_ht_addr_del(addr);
 	list_del_rcu(&addr->anode);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	kfree_rcu(addr, rcu);
 }
 
@@ -878,14 +881,14 @@ static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
 	int ret = -EINVAL;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	if (ipvlan_addr_busy(ipvlan->port, ip6_addr, true))
 		netif_err(ipvlan, ifup, ipvlan->dev,
 			  "Failed to add IPv6=%pI6c addr for %s intf\n",
 			  ip6_addr, ipvlan->dev->name);
 	else
 		ret = ipvlan_add_addr(ipvlan, ip6_addr, true);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
@@ -924,21 +927,24 @@ static int ipvlan_addr6_validator_event(struct notifier_block *unused,
 	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
 	struct net_device *dev = (struct net_device *)i6vi->i6vi_dev->dev;
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	int ret = NOTIFY_OK;
 
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
+		spin_lock_bh(&ipvlan->port->addrs_lock);
 		if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true)) {
 			NL_SET_ERR_MSG(i6vi->extack,
 				       "Address already assigned to an ipvlan device");
-			return notifier_from_errno(-EADDRINUSE);
+			ret = notifier_from_errno(-EADDRINUSE);
 		}
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
 		break;
 	}
 
-	return NOTIFY_OK;
+	return ret;
 }
 #endif
 
@@ -946,14 +952,14 @@ static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
 {
 	int ret = -EINVAL;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	if (ipvlan_addr_busy(ipvlan->port, ip4_addr, false))
 		netif_err(ipvlan, ifup, ipvlan->dev,
 			  "Failed to add IPv4=%pI4 on %s intf.\n",
 			  ip4_addr, ipvlan->dev->name);
 	else
 		ret = ipvlan_add_addr(ipvlan, ip4_addr, false);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
@@ -995,21 +1001,24 @@ static int ipvlan_addr4_validator_event(struct notifier_block *unused,
 	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
 	struct net_device *dev = (struct net_device *)ivi->ivi_dev->dev;
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	int ret = NOTIFY_OK;
 
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
+		spin_lock_bh(&ipvlan->port->addrs_lock);
 		if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)) {
 			NL_SET_ERR_MSG(ivi->extack,
 				       "Address already assigned to an ipvlan device");
-			return notifier_from_errno(-EADDRINUSE);
+			ret = notifier_from_errno(-EADDRINUSE);
 		}
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
 		break;
 	}
 
-	return NOTIFY_OK;
+	return ret;
 }
 
 static struct notifier_block ipvlan_addr4_notifier_block __read_mostly = {
-- 
2.43.0


