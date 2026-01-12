Return-Path: <netdev+bounces-249053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D2D13299
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDD4E300CF0A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9062DECAA;
	Mon, 12 Jan 2026 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV8jkgxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F625A34F
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227873; cv=none; b=S+YZO/GZryPj+8Kp8OHS1xggKiQHkv1RuwgbH/7p4hYcogdisWzt+fbf8QqlHhGoDiSy1gu4xcxxCYGpIjJ9Yd5adpoM41bzR9pAYasBnsA5KfbFx7Lk2v51JN5yuyNhDWXLTJKkSn3HjcYvErEy4moWoFwgg6eoXpTZWtcYyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227873; c=relaxed/simple;
	bh=2ObwFh5a9qnfN7x/FqXgPYgMb9j99om7GusYn9HZMIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5kJIPoNyDSKSnI8IXfBiEE8zbvKZyJUPH2iNCPZaZiFPLyl7xy0UP016L+CQ0ftA4YcihsWg8EJ5jvAQ1f3yG7QFSBf4RArBIiQh4aYn7BdQh2rlbYGjCHeECM+5KhI9RcrffDBUOOGQSh3Nc9L/FVP9M0bRmjz5zS+wg5/e6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV8jkgxo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b30275e69so7575729e87.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768227870; x=1768832670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yhw2wjrT0ox2lSdYIPReva9D7cUp1KuTYkrSZgQfV7g=;
        b=YV8jkgxoCORvvBatfaP04YAQgbt9ULu4ZgGmG9yUXp7b2/yLxHKuAQ6JTLORdic8O8
         FZPbhvngSgquzE+PZGsgGchbVhYw5TbG9xDSWaB5QQPDTAwQoDoFTN3gRbcHrN3ge0C/
         JxfggH7koj0w9V+dO6eAGMX8EoXRoTIVDtUxlQSSpGlGlMYksxVDR7m1OEFipCKT44h3
         wI/iYQwSqqKlnoOPb7xdm9V3AxZdwJzOiRcu2icyINuSrqQxyoFBKVjVaeCkeyPUQTYC
         mzpxVWuEMhC0K08GBIbtgA3skh122fAXsoH7N806Vz+OY7UtuYCy6JH+7sP3GorsKS39
         djZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227870; x=1768832670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yhw2wjrT0ox2lSdYIPReva9D7cUp1KuTYkrSZgQfV7g=;
        b=TMf2o8HvnS1OYXkzTxNBPCbR5ZBsdpURXG+4q5Dn7tmM4uv1cLlX9btUutPw26LPYB
         nGFDJ4iaF/gDlSBgMTY+7D4AxfLiODw3REZGHzlCi1ZkTw8LM8aroODKHBp/I4LttuWq
         GyT9HYFhdVT9Sxknx46SSd/WYeVvO+R9s72tzktpDdnGRE9aT+j2GOq2XWOTVpHm39eY
         dIlqe1+45bAN9WtwgejiWIVE0DMpa4RYQW6kB3qKUiSaw8ZGTJhaBom86VXTXnoBXY03
         P1rfrGQbWl+IQsAz8gVuboyLVTJ5TmiR2iW2azXBgxHS4YWpCoqu836QbiuVteScS6Nf
         +SyA==
X-Gm-Message-State: AOJu0YyRQiIux7tWou2paA08aeYL+qDbk/J1kmrwasO6AmqNkD5PNmXF
	yd9kIghHrxB0cXEzLp6YGdTK5iCQ8nBGZN9i8ObxO5jw5f+Ocm10nbF/kuyw+kTvGME=
X-Gm-Gg: AY/fxX5+5eepLVq1FA7HTI23COHS3JoiMBZLUVmYlez0/pPXrrBG1qXNrOvNifRMN3w
	E8xITpms9+PDcMB9wscpU9Iv3MWvZEsuByxMVAYl6MpXDXGmpFqw1p9RAK2C1OCZdZpzW8P/cpU
	J1DKEjEs3NbrByfFeDOEpRZ7B7khQzLi6noqsDpk5QtC0SbV//5QIvXjeNSc1UrC8atXIvPMtZh
	vPl9jmFX/Lhj7YjBY8RUW7///WP/ruzQ00hlSFhDX7UYcuf3vhCM51B+OXwizWNVMfCiHMXKz4w
	8qYMUKASI3/hWkFuSc/F3gc/NS9kdkEj4R9z07PJ08D7IChhy/dCL13m9rZBQOuI6v7lhO7xoPD
	41yL7MRSfQfZi5mjcLqvJdFeujF4wT+R/7eVEQ9vSzv8nR1CO6UVyBnEsS+BdvTESNNPS3kTvfz
	haNk20SAmUPwFaATrSVclosNbr1xxHJzRzVdx3Riwo/54ANqJgclz79CnC
X-Google-Smtp-Source: AGHT+IGOIPhTp0akxGD0scJdGoJQ8L0yOtx8Snuv7AEqlUenvKvPIvhKG8n9k1Fer0SIv9P2kbSzdA==
X-Received: by 2002:a05:6512:3da7:b0:595:7fa2:acf with SMTP id 2adb3069b0e04-59b6f03a0a7mr6592243e87.31.1768227869353;
        Mon, 12 Jan 2026 06:24:29 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d0d86bsm4821886e87.23.2026.01.12.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:24:29 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Julian Vetter <julian@outer-limits.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH v5 net 1/2] ipvlan: Make the addrs_lock be per port
Date: Mon, 12 Jan 2026 17:24:06 +0300
Message-ID: <20260112142417.4039566-2-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
References: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
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
v4/v5:
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


