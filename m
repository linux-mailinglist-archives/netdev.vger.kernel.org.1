Return-Path: <netdev+bounces-75097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB1868268
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ACA1F25F8E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5813175E;
	Mon, 26 Feb 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMhuFxOv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F3131758
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981828; cv=none; b=S3y1IkaPhoXoFbUy6IGpiXHHgetXJ6jz5oj2czXuszpxHd+eqE/QKRgUfCRQfoGIwRGRP0HcHPIBeo+jkKyL5WNI34olyGf1Ppwab3WKo478KneHewRDQYavy3J7FHS818LYK1/Q929d/6MJrPpC/JD3BnkfQ17IhpZL7CPKGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981828; c=relaxed/simple;
	bh=LNSevtX8ZywwGiPiMyHWZaQ8//zI2a7WlnQ4OIi9b+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwIYPj1F5GdJEaypwz+4Z9+SJJq5lWVRgsXsEIRLE/AWiPaXehQoL+DAeTYcBcojJQmi+BClTedAeCmBQxtVikEzAKXDT4IH+/hd1UAZzpAlUVuJqH7K+n9YT+6PkVXgHRMgL5XAsNzOruM2UhF3LLFsUaL6nhcfL47/PbsLu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMhuFxOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67276C43601;
	Mon, 26 Feb 2024 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981827;
	bh=LNSevtX8ZywwGiPiMyHWZaQ8//zI2a7WlnQ4OIi9b+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMhuFxOv/kpEIy+ISRDJ2h70EdFYtPpNXIpUJtNptHu2WC9oZ5Vk2vFOEC//3aEv9
	 vxl83stkOyoaMovBTU15HL5sw24oCzfIwwBLAfG13hNt05L3XjSB7oISSs6S3hWv4J
	 5jQWUhTyDWszS4gxTfGAk4v2vq2h8UVdoJ3fV6SfD1TzurEkzI7WSK4FS6fMKfTr8j
	 EP9zu9wEP3gjElbhDEpr+iH3/SyD5nybKjiC/W1yz5Ze1e23/0JPsdxFSTxNWNZrDc
	 017WicLfgu4kNVjR/J0utw8wXDmTWk8WtBAAjb+kLEgTyPqXcXKQL4tnpSMxiPinO7
	 ZUHVq8V3IMVkQ==
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
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] eth: bnxt: support per-queue statistics
Date: Mon, 26 Feb 2024 13:10:15 -0800
Message-ID: <20240226211015.1244807-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226211015.1244807-1-kuba@kernel.org>
References: <20240226211015.1244807-1-kuba@kernel.org>
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
   --dump stats-get --json '{"scope": "queue"}'
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
   --dump stats-get --json '{"scope": "queue"}'
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
index a15e6d31fc22..97abde27d5fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14523,6 +14523,68 @@ static const struct net_device_ops bnxt_netdev_ops = {
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
@@ -14970,6 +15032,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
 	pci_set_drvdata(pdev, dev);
-- 
2.43.2


