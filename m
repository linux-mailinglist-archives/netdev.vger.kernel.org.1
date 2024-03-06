Return-Path: <netdev+bounces-78100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93828740E8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368C1B22F1D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874E1419A2;
	Wed,  6 Mar 2024 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKmWQGEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB5140E5E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754920; cv=none; b=LEGWohpDVaQP8Eq8rr5V3olOqU3hP6wNvjZ6jn0eMYqTzwPt4EfyYYjSX1w0N8KaOGBIp0DGuuKLiZdrOywuS0w5CUbIe12Zy8DSGsmMGO7VnUUHJj0UOj+nkxMaw35tJCNurPXqQebqOqxG9CB3afOMvTsRNUXrjM0OmyP0jGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754920; c=relaxed/simple;
	bh=YnNfZSHRGY0ahVBNkOW5LJ2BSmRiXIn5epEb/6BH+UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnZstkQSvoiUh2QxwLDPhUzWbtshkDJQ5Iv9t1m8QjjF2wwNJd1x/DY3s5or3ChcHI3EPDNkDaw7UHX8fcogk+30BQbKAe0p4c3aWg92POLNwRYXlgnPvwrPA004dR6+pJk83mjSS2u1rpieT2tTelGfKdSYNo6X0SKxMGJyajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKmWQGEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B80C433F1;
	Wed,  6 Mar 2024 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754919;
	bh=YnNfZSHRGY0ahVBNkOW5LJ2BSmRiXIn5epEb/6BH+UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKmWQGElFlzX8YRA6pKIL9kk9HB+znXORAGZDmbasS8llm/QzOa/Uh1GyBgpvyTZX
	 t6ASDNoOzhhZjUP/JbudpF7NwK7aXEh7aVB/dXcMzDsEdxl07cx4R6yiAKBeS7iJ8D
	 MeHBB7BPePx3Sc5bv9otBVu33a1S8IyT9OqDwK3B6qYtAhS2BfYWnoOZvo4e8o4RPS
	 RvovUWiNxgAU074WjoJIgckiJ6ujiYSlk0ZwPra0t+4Jy7JLPls9X5xVACYxSZXRls
	 nwKPgg5M0SpvvfLFiPfmlM6fnFvt2qN1DrcfOQaMacCGOqRHgq3B2vFQYcCKtMBk78
	 hv2lJo8b7x2ag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	danielj@nvidia.com,
	mst@redhat.com,
	michael.chan@broadcom.com,
	sdf@google.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 3/3] eth: bnxt: support per-queue statistics
Date: Wed,  6 Mar 2024 11:55:09 -0800
Message-ID: <20240306195509.1502746-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306195509.1502746-1-kuba@kernel.org>
References: <20240306195509.1502746-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support per-queue statistics API in bnxt.

$ ethtool -S eth0
NIC statistics:
     [0]: rx_ucast_packets: 1418
     [0]: rx_mcast_packets: 178
     [0]: rx_bcast_packets: 0
     [0]: rx_discards: 0
     [0]: rx_errors: 0
     [0]: rx_ucast_bytes: 1141815
     [0]: rx_mcast_bytes: 16766
     [0]: rx_bcast_bytes: 0
     [0]: tx_ucast_packets: 1734
...

$ ./cli.py --spec netlink/specs/netdev.yaml \
   --dump qstats-get --json '{"scope": "queue"}'
[{'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 1164931,
  'rx-packets': 1641},
...
 {'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 631494,
  'tx-packets': 1771},
...

Reset the per queue counters:
$ ethtool -L eth0 combined 4

Inspect again:

$ ./cli.py --spec netlink/specs/netdev.yaml \
   --dump qstats-get --json '{"scope": "queue"}'
[{'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 32397,
  'rx-packets': 145},
...
 {'ifindex': 2,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 37481,
  'tx-packets': 196},
...

$ ethtool -S eth0 | head
NIC statistics:
     [0]: rx_ucast_packets: 174
     [0]: rx_mcast_packets: 3
     [0]: rx_bcast_packets: 0
     [0]: rx_discards: 0
     [0]: rx_errors: 0
     [0]: rx_ucast_bytes: 37151
     [0]: rx_mcast_bytes: 267
     [0]: rx_bcast_bytes: 0
     [0]: tx_ucast_packets: 267
...

Totals are still correct:

$ ./cli.py --spec netlink/specs/netdev.yaml --dump qstats-get
[{'ifindex': 2,
  'rx-alloc-fail': 0,
  'rx-bytes': 281949995,
  'rx-packets': 216524,
  'tx-bytes': 52694905,
  'tx-packets': 75546}]
$ ip -s link show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 14:23:f2:61:05:40 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
     282519546  218100      0       0       0     516
    TX:  bytes packets errors dropped carrier collsns
      53323054   77674      0       0       0       0

Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3: fix mapping the ring index to ring w/ XDP present
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a15e6d31fc22..493b724848c8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14523,6 +14523,70 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_bridge_setlink	= bnxt_bridge_setlink,
 };
 
+static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_cp_ring_info *cpr;
+	u64 *sw;
+
+	cpr = &bp->bnapi[i]->cp_ring;
+	sw = cpr->stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNXT_GET_RING_STATS64(sw, rx_ucast_pkts);
+	stats->packets += BNXT_GET_RING_STATS64(sw, rx_mcast_pkts);
+	stats->packets += BNXT_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_ucast_bytes);
+	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_mcast_bytes);
+	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+	stats->alloc_fail = cpr->sw_stats.rx.rx_oom_discards;
+}
+
+static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_napi *bnapi;
+	u64 *sw;
+
+	bnapi = bp->tx_ring[bp->tx_ring_map[i]].bnapi;
+	sw = bnapi->cp_ring.stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNXT_GET_RING_STATS64(sw, tx_ucast_pkts);
+	stats->packets += BNXT_GET_RING_STATS64(sw, tx_mcast_pkts);
+	stats->packets += BNXT_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_ucast_bytes);
+	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_mcast_bytes);
+	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_bcast_bytes);
+}
+
+static void bnxt_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	rx->packets = bp->net_stats_prev.rx_packets;
+	rx->bytes = bp->net_stats_prev.rx_bytes;
+	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
+
+	tx->packets = bp->net_stats_prev.tx_packets;
+	tx->bytes = bp->net_stats_prev.tx_bytes;
+}
+
+static const struct netdev_stat_ops bnxt_stat_ops = {
+	.get_queue_stats_rx	= bnxt_get_queue_stats_rx,
+	.get_queue_stats_tx	= bnxt_get_queue_stats_tx,
+	.get_base_stats		= bnxt_get_base_stats,
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -14970,6 +15034,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
 	pci_set_drvdata(pdev, dev);
-- 
2.44.0


