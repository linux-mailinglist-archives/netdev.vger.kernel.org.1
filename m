Return-Path: <netdev+bounces-200307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557AFAE47EB
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46ACE7ABC3A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77032275113;
	Mon, 23 Jun 2025 15:08:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D3241116
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691300; cv=none; b=eP0o0JOw5sYkG6QThFZ/h+RqPtLRpWEig81s3pYJK3U2wQVjy0Ms9PvgKZaiRmNwEACMpMbXRtcUHCDXl1JWbVUvxzavhTzrtgJqAfR42fN07vC5fNBihCiZvu8Bt09yclBmAHxL3KOHl2WLSQAbfZ2eMS9zhH9MAIiibvxLg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691300; c=relaxed/simple;
	bh=SLW7H2gmPy+r/6BjuczGQPDIf35LJQ2oBMYEWn8LmoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1/iwrwopMdn/CAwTrAcdUaoyYaDEOmqEdTAz9jdhuYi+5QLPmhOje8571eaNuDp6D2CCIhO4WtfVVTxVgKYpw8dCzV+P2m1vDXpJGS/M5qAsQGbBgWPMmQaaOXZufhWacCCVLBHDr9ed9xMvEQ+TncWxeAlxUQAeuOfjJ/l6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74264d1832eso5456520b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691297; x=1751296097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn8bNSdSoW2fvwOm8dTF41RcGOT2Ayexz8DypEbvIi0=;
        b=HY5WQBaNgReagCFU0OsB4iqCnESSFvU7sM3GeyPnBC/MCqZE3kDqL3gxSUwRGtzAi8
         JS7Frx9LJwdfA2ZsWvZTgNCqAJeesxB8dwra8IkjTHukA/N6pP5UFiSFPR5VlC8FZNmr
         9qJKGGyCw9V3rU3MGEsssRhkKwgi8HS+41FfBq+apP+PMpQz/Qs9+0xdSCNLccOBJKdZ
         6ZRDsAUhkfc6gefZDWs4Ni3ffEBS/HE/icb0vnH6cMo2xQBKs5bumP7TY63P+8LTPbn+
         CfatS/g2m47YQGSxY5QPv4biiJBsonRJcPrezDzPWl4+atX8ZWptiel7Pc8i683DDsiT
         q82Q==
X-Gm-Message-State: AOJu0YwjD+KsSeYD1ZRRVTLnebcV0rW5cY83Nx5inki4CjNCG4SB2c/O
	1/o6xefbdosXrmqc64SFT7Ob7+VV5+MwJnhtCchXlo9yjd/CkwJR6a2KUztV
X-Gm-Gg: ASbGncu6o3L8gZmnIlDMZMR7v0mF/gJo7smvCiOU+NzLFPZmS5hLDQrihJWJ1/q8uu0
	kOXSHpCXrqr3DJLsBk8t9D9AKr09o5iApBAb2rtrh5dqr57FoPHrJo9zC+HlpKXi9Xjr9WCcCkB
	I3hZx8QeHaSz4c1wkw1DKHD5c5JdWcwXsFBJQzGC99IWxUqyTKPSTOLtWQ1y6K5ASqv948XRp0n
	Q7td1XvMrRXR+aovcbWlqvF95+NfU8K2cnoIsiIFDkEjQXN2ofFUAk2wzEvVG8Jq02YGH77Jy3i
	yKXaeVIC/Bvry5cwQEm/BMaucITucPWPVkEpvn+I2vkc2+U5V0HF561XzTJJYZmDLPk07e3XGd4
	PCZXBuiyeBfnOADpWRLM0FtM=
X-Google-Smtp-Source: AGHT+IHd5R3Bx2bTtRcxxvt32tXzMdN6dxfB9AiOfWdBlb+0vhUhyOgIkS/kcnc/XmZq+b9Wo6CkgQ==
X-Received: by 2002:a05:6a00:4f8e:b0:73e:970:731 with SMTP id d2e1a72fcca58-7490d660de3mr16912702b3a.16.1750691297052;
        Mon, 23 Jun 2025 08:08:17 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a62768bsm8462068b3a.100.2025.06.23.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 1/8] net: s/dev_get_stats/netif_get_stats/
Date: Mon, 23 Jun 2025 08:08:07 -0700
Message-ID: <20250623150814.3149231-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623150814.3149231-1-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintain netif vs dev semantics.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 arch/s390/appldata/appldata_net_sum.c         |  2 +-
 drivers/leds/trigger/ledtrig-netdev.c         |  2 +-
 drivers/net/bonding/bond_main.c               |  4 ++--
 .../ethernet/apm/xgene/xgene_enet_ethtool.c   |  2 +-
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  2 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |  2 +-
 drivers/net/net_failover.c                    | 12 +++++------
 drivers/net/netdevsim/netdev.c                |  6 +++---
 drivers/scsi/fcoe/fcoe_transport.c            |  2 +-
 drivers/usb/gadget/function/rndis.c           |  2 +-
 include/linux/netdevice.h                     |  6 +++---
 net/8021q/vlanproc.c                          |  2 +-
 net/core/dev.c                                | 20 +++++++++----------
 net/core/net-procfs.c                         |  2 +-
 net/core/net-sysfs.c                          |  3 ++-
 net/core/rtnetlink.c                          |  4 ++--
 net/openvswitch/vport.c                       |  2 +-
 20 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/s390/appldata/appldata_net_sum.c b/arch/s390/appldata/appldata_net_sum.c
index 59c282ca002f..47609e5f9d5d 100644
--- a/arch/s390/appldata/appldata_net_sum.c
+++ b/arch/s390/appldata/appldata_net_sum.c
@@ -83,7 +83,7 @@ static void appldata_get_net_sum_data(void *data)
 		const struct rtnl_link_stats64 *stats;
 		struct rtnl_link_stats64 temp;
 
-		stats = dev_get_stats(dev, &temp);
+		stats = netif_get_stats(dev, &temp);
 		rx_packets += stats->rx_packets;
 		tx_packets += stats->tx_packets;
 		rx_bytes   += stats->rx_bytes;
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 4e048e08c4fd..da4a09b1335c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -657,7 +657,7 @@ static void netdev_trig_work(struct work_struct *work)
 	    !test_bit(TRIGGER_NETDEV_RX_ERR, &trigger_data->mode))
 		return;
 
-	dev_stats = dev_get_stats(trigger_data->net_dev, &temp);
+	dev_stats = netif_get_stats(trigger_data->net_dev, &temp);
 	new_activity =
 	    (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ?
 		dev_stats->tx_packets : 0) +
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c4d53e8e7c15..43a580a444af 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2145,7 +2145,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	slave_dev->priv_flags |= IFF_BONDING;
 	/* initialize slave stats */
-	dev_get_stats(new_slave->dev, &new_slave->slave_stats);
+	netif_get_stats(new_slave->dev, &new_slave->slave_stats);
 
 	if (bond_is_lb(bond)) {
 		/* bond_alb_init_slave() must be called before all other stages since
@@ -4581,7 +4581,7 @@ static void bond_get_stats(struct net_device *bond_dev,
 
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		const struct rtnl_link_stats64 *new =
-			dev_get_stats(slave->dev, &temp);
+			netif_get_stats(slave->dev, &temp);
 
 		bond_fold_stats(stats, new, &slave->slave_stats);
 
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
index ada70425b48c..4dcd4035f2a9 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
@@ -268,7 +268,7 @@ static void xgene_get_ethtool_stats(struct net_device *ndev,
 	struct rtnl_link_stats64 stats;
 	int i;
 
-	dev_get_stats(ndev, &stats);
+	netif_get_stats(ndev, &stats);
 	for (i = 0; i < XGENE_STATS_LEN; i++)
 		data[i] = *(u64 *)((char *)&stats + gstrings_stats[i].offset);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4f40f6afe88f..751e2dd6b827 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1314,7 +1314,7 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	if (netif_running(dev))
 		bcmgenet_update_mib_counters(priv);
 
-	dev_get_stats(dev, &stats64);
+	netif_get_stats(dev, &stats64);
 
 	for (i = 0; i < BCMGENET_STATS_LEN; i++) {
 		const struct bcmgenet_stats *s;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 60a586a951a0..d401fb4b1609 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -857,7 +857,7 @@ static void hns_get_ethtool_stats(struct net_device *netdev,
 
 	h->dev->ops->update_stats(h, &netdev->stats);
 
-	net_stats = dev_get_stats(netdev, &temp);
+	net_stats = netif_get_stats(netdev, &temp);
 
 	/* get netdev statistics */
 	p[0] = net_stats->rx_packets;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index c0bbb12eed2e..971356281afe 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2050,7 +2050,7 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 	int i;
 	char *p = NULL;
 
-	dev_get_stats(netdev, &net_stats);
+	netif_get_stats(netdev, &net_stats);
 
 	for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
 		switch (e1000_gstrings_stats[i].type) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 25c3a09ad7f1..317d79f0ff8f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1406,7 +1406,7 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
 	char *p = NULL;
 
 	ixgbe_update_stats(adapter);
-	net_stats = dev_get_stats(netdev, &temp);
+	net_stats = netif_get_stats(netdev, &temp);
 	for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++) {
 		switch (ixgbe_gstrings_stats[i].type) {
 		case NETDEV_STATS:
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 7ac53171b041..52eedfef9797 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -428,7 +428,7 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 	char *p;
 
 	ixgbevf_update_stats(adapter);
-	net_stats = dev_get_stats(netdev, &temp);
+	net_stats = netif_get_stats(netdev, &temp);
 	for (i = 0; i < IXGBEVF_GLOBAL_STATS_LEN; i++) {
 		switch (ixgbevf_gstrings_stats[i].type) {
 		case NETDEV_STATS:
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 5b50d9186f12..ac18dd861f52 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -190,14 +190,14 @@ static void net_failover_get_stats(struct net_device *dev,
 
 	slave_dev = rcu_dereference(nfo_info->primary_dev);
 	if (slave_dev) {
-		new = dev_get_stats(slave_dev, &temp);
+		new = netif_get_stats(slave_dev, &temp);
 		net_failover_fold_stats(stats, new, &nfo_info->primary_stats);
 		memcpy(&nfo_info->primary_stats, new, sizeof(*new));
 	}
 
 	slave_dev = rcu_dereference(nfo_info->standby_dev);
 	if (slave_dev) {
-		new = dev_get_stats(slave_dev, &temp);
+		new = netif_get_stats(slave_dev, &temp);
 		net_failover_fold_stats(stats, new, &nfo_info->standby_stats);
 		memcpy(&nfo_info->standby_stats, new, sizeof(*new));
 	}
@@ -540,11 +540,11 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	if (slave_is_standby) {
 		rcu_assign_pointer(nfo_info->standby_dev, slave_dev);
 		standby_dev = slave_dev;
-		dev_get_stats(standby_dev, &nfo_info->standby_stats);
+		netif_get_stats(standby_dev, &nfo_info->standby_stats);
 	} else {
 		rcu_assign_pointer(nfo_info->primary_dev, slave_dev);
 		primary_dev = slave_dev;
-		dev_get_stats(primary_dev, &nfo_info->primary_stats);
+		netif_get_stats(primary_dev, &nfo_info->primary_stats);
 		failover_dev->min_mtu = slave_dev->min_mtu;
 		failover_dev->max_mtu = slave_dev->max_mtu;
 	}
@@ -606,7 +606,7 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 	dev_close(slave_dev);
 
 	nfo_info = netdev_priv(failover_dev);
-	dev_get_stats(failover_dev, &nfo_info->failover_stats);
+	netif_get_stats(failover_dev, &nfo_info->failover_stats);
 
 	slave_is_standby = slave_dev->dev.parent == failover_dev->dev.parent;
 	if (slave_is_standby) {
@@ -648,7 +648,7 @@ static int net_failover_slave_link_change(struct net_device *slave_dev,
 		netif_carrier_on(failover_dev);
 		netif_tx_wake_all_queues(failover_dev);
 	} else {
-		dev_get_stats(failover_dev, &nfo_info->failover_stats);
+		netif_get_stats(failover_dev, &nfo_info->failover_stats);
 		netif_carrier_off(failover_dev);
 		netif_tx_stop_all_queues(failover_dev);
 	}
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2d..55d93c8c6050 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -581,7 +581,7 @@ static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		dev_get_stats(dev, &rtstats);
+		netif_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;
 	stats->bytes = rtstats.rx_bytes;
@@ -593,7 +593,7 @@ static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		dev_get_stats(dev, &rtstats);
+		netif_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
 	stats->bytes = rtstats.tx_bytes;
@@ -605,7 +605,7 @@ static void nsim_get_base_stats(struct net_device *dev,
 {
 	struct rtnl_link_stats64 rtstats = {};
 
-	dev_get_stats(dev, &rtstats);
+	netif_get_stats(dev, &rtstats);
 
 	rx->packets = !!rtstats.rx_packets;
 	rx->bytes = 0;
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index 2f478426f16e..91ea25f7c5b6 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -191,7 +191,7 @@ void __fcoe_get_lesb(struct fc_lport *lport,
 	lesb->lesb_vlink_fail = htonl(vlfc);
 	lesb->lesb_miss_fka = htonl(mdac);
 	lesb->lesb_fcs_error =
-			htonl(dev_get_stats(netdev, &temp)->rx_crc_errors);
+			htonl(netif_get_stats(netdev, &temp)->rx_crc_errors);
 }
 EXPORT_SYMBOL_GPL(__fcoe_get_lesb);
 
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index afd75d72412c..0cdb72f2d9ff 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -199,7 +199,7 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
 	resp->InformationBufferOffset = cpu_to_le32(16);
 
 	net = params->dev;
-	stats = dev_get_stats(net, &temp);
+	stats = netif_get_stats(net, &temp);
 
 	switch (OID) {
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03c26bb0fbbe..b9a7dd16eafe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -218,7 +218,7 @@ struct net_device_stats {
 #undef NET_DEV_STAT
 
 /* per-cpu stats, allocated on demand.
- * Try to fit them in a single cache line, for dev_get_stats() sake.
+ * Try to fit them in a single cache line, for netif_get_stats() sake.
  */
 struct net_device_core_stats {
 	unsigned long	rx_dropped;
@@ -5004,8 +5004,8 @@ void netdev_notify_peers(struct net_device *dev);
 void netdev_features_change(struct net_device *dev);
 /* Load a device via the kmod */
 void dev_load(struct net *net, const char *name);
-struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
-					struct rtnl_link_stats64 *storage);
+struct rtnl_link_stats64 *netif_get_stats(struct net_device *dev,
+					  struct rtnl_link_stats64 *storage);
 void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 			     const struct net_device_stats *netdev_stats);
 void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index fa67374bda49..bcdcbf419e09 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -236,7 +236,7 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 	if (!is_vlan_dev(vlandev))
 		return 0;
 
-	stats = dev_get_stats(vlandev, &temp);
+	stats = netif_get_stats(vlandev, &temp);
 	seq_printf(seq,
 		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %x\n",
 		   vlandev->name, vlan->vlan_id,
diff --git a/net/core/dev.c b/net/core/dev.c
index 7ee808eb068e..7198a833f697 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11558,17 +11558,17 @@ noinline void netdev_core_stats_inc(struct net_device *dev, u32 offset)
 EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
 
 /**
- *	dev_get_stats	- get network device statistics
- *	@dev: device to get statistics from
- *	@storage: place to store stats
+ * netif_get_stats() - get network device statistics
+ * @dev: device to get statistics from
+ * @storage: place to store stats
  *
- *	Get network statistics from device. Return @storage.
- *	The device driver may provide its own method by setting
- *	dev->netdev_ops->get_stats64 or dev->netdev_ops->get_stats;
- *	otherwise the internal statistics structure is used.
+ * Get network statistics from device. Return @storage.
+ * The device driver may provide its own method by setting
+ * dev->netdev_ops->get_stats64 or dev->netdev_ops->get_stats;
+ * otherwise the internal statistics structure is used.
  */
-struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
-					struct rtnl_link_stats64 *storage)
+struct rtnl_link_stats64 *netif_get_stats(struct net_device *dev,
+					  struct rtnl_link_stats64 *storage)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	const struct net_device_core_stats __percpu *p;
@@ -11616,7 +11616,7 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 	}
 	return storage;
 }
-EXPORT_SYMBOL(dev_get_stats);
+EXPORT_SYMBOL(netif_get_stats);
 
 /**
  *	dev_fetch_sw_netstats - get per-cpu network device statistics
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 4f0f0709a1cb..14b8bebacefd 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -44,7 +44,7 @@ static void dev_seq_stop(struct seq_file *seq, void *v)
 static void dev_seq_printf_stats(struct seq_file *seq, struct net_device *dev)
 {
 	struct rtnl_link_stats64 temp;
-	const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
+	const struct rtnl_link_stats64 *stats = netif_get_stats(dev, &temp);
 
 	seq_printf(seq, "%6s: %7llu %7llu %4llu %4llu %4llu %5llu %10llu %9llu "
 		   "%8llu %7llu %4llu %4llu %4llu %5llu %7llu %10llu\n",
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c9b969386399..69109584efef 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -818,7 +818,8 @@ static ssize_t netstat_show(const struct device *d,
 	rcu_read_lock();
 	if (dev_isalive(dev)) {
 		struct rtnl_link_stats64 temp;
-		const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
+		const struct rtnl_link_stats64 *stats = netif_get_stats(dev,
+									&temp);
 
 		ret = sysfs_emit(buf, fmt_u64, *(u64 *)(((u8 *)stats) + offset));
 	}
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c57692eb8da9..6d75030aa70f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1471,7 +1471,7 @@ static noinline_for_stack int rtnl_fill_stats(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	sp = nla_data(attr);
-	dev_get_stats(dev, sp);
+	netif_get_stats(dev, sp);
 
 	attr = nla_reserve(skb, IFLA_STATS,
 			   sizeof(struct rtnl_link_stats));
@@ -5935,7 +5935,7 @@ static int rtnl_fill_statsinfo(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		sp = nla_data(attr);
-		dev_get_stats(dev, sp);
+		netif_get_stats(dev, sp);
 	}
 
 	if (stats_attr_valid(filter_mask, IFLA_STATS_LINK_XSTATS, *idxattr)) {
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 8732f6e51ae5..33049a860287 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -286,7 +286,7 @@ void ovs_vport_get_stats(struct vport *vport, struct ovs_vport_stats *stats)
 	const struct rtnl_link_stats64 *dev_stats;
 	struct rtnl_link_stats64 temp;
 
-	dev_stats = dev_get_stats(vport->dev, &temp);
+	dev_stats = netif_get_stats(vport->dev, &temp);
 	stats->rx_errors  = dev_stats->rx_errors;
 	stats->tx_errors  = dev_stats->tx_errors;
 	stats->tx_dropped = dev_stats->tx_dropped;
-- 
2.49.0


