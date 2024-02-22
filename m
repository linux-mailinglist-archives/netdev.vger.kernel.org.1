Return-Path: <netdev+bounces-74181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA378605C8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649571F22617
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C718AED;
	Thu, 22 Feb 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDPukzcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720A18629
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641400; cv=none; b=G5nznivEFwPdGZ8ztWSNHyyCJEGIEbhANS/K6xw8KPcA/BcyFV0hEuZLU1Ea/wxuKBjIZZkCsOLmJ1ZIBF9iO1+KOoCdFM8fWzymcVCdXHzjmvV5Idd7AxfuEXnu2Y5Zwzb6y+lg+p03fxmgXkfq4KwIr0nAOjISo/nsjRx4V48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641400; c=relaxed/simple;
	bh=y2TqdJwOayjsoEJFG1VE7jJDCdC/74DnFX+xqFparTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUaYkVzWCqlEeDTfXWWRIHvJndSRHN+03gFpz6awWIAlkE1lCh6rkZhBLGlk9Q6U3V5JgCkMRnallXfhMMKvZzM/DK1FtkxOQ+rQjY44Es+Mp/yWVNeeDQbo/XNogb3RQCk/4vj3GQ6JmDFBZZjd79YXZ+Oox0ZRQAeOfzwHl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDPukzcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B443BC433A6;
	Thu, 22 Feb 2024 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708641400;
	bh=y2TqdJwOayjsoEJFG1VE7jJDCdC/74DnFX+xqFparTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDPukzcDEDuBxZ1mH3/U8B3i38yFuSfOfAT66gnYHiX8ueceeMpxWPKXPllqrlCPU
	 htl7WEMO0tF4XTGyGljEu5u32A+0pJ4n68dnX/FPZs857uvQcIRCRG2kJgQ4qtJRbV
	 W9QG48InmhS5MClBLopvK/Dtsj8/ptkAj675rtKh06iz0iVs5jXvwA4/canHPq9ysj
	 jMCGJ2Djs4ine6yC1izc/6UIFdpzePCoV8ERWBwFMEpFE1Aq8eYBw6fyUB6E3afvSF
	 Oe94VoGlm+memqG4yvuaqmFf0c1J5WOa/ewPefF4tOeMxpW+vclDjuBM5Ikp2A9ueQ
	 Ujg9PPv9OqYPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	danielj@nvidia.com,
	mst@redhat.com,
	amritha.nambiar@intel.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 3/3] eth: bnxt: support per-queue statistics
Date: Thu, 22 Feb 2024 14:36:29 -0800
Message-ID: <20240222223629.158254-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222223629.158254-1-kuba@kernel.org>
References: <20240222223629.158254-1-kuba@kernel.org>
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
   --dump stats-get --json '{"projection": 1}'
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
   --dump stats-get --json '{"projection": 1}'
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

$ ./cli.py --spec netlink/specs/netdev.yaml --dump stats-get
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 +++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6f415425dc14..3ee8e3b827e3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14432,6 +14432,68 @@ static const struct net_device_ops bnxt_netdev_ops = {
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
+	u64 *sw;
+
+	sw = bp->bnapi[i]->cp_ring.stats.sw_stats;
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
@@ -14879,6 +14941,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
 	pci_set_drvdata(pdev, dev);
-- 
2.43.2


