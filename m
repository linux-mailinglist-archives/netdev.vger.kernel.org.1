Return-Path: <netdev+bounces-117383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD694DAFC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A028B20A67
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320A4962B;
	Sat, 10 Aug 2024 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbLRDZz6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378D482DB
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268606; cv=none; b=V+Sf4u/HJFq4UZ9c81gg/HsPjO49dAuyDropzwQzzHxxwpimGs0Z6XEkHlQpaMwhri6ZofiTNqpFYxX1ghk+DJPno5CadnUycjzBx4waRF4b1g+WEdKpaNDF1Ob1cHGewNEYw4p/CCGAC2631ctXCmF2qTAprogECC9ChnFv4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268606; c=relaxed/simple;
	bh=Xiooa5dT7LuXNNfhA9zxFqsUFgBnqp2laqVYtDKyLWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOGyed/tjSNNjILaFLV/tYKO0RA++mBNzRHr2eJOxvxUA/AHiWpoOG3qz/8NAGwGkgPvQfa+w6EZ+mY8SO7mOfOvy2w5UkoIV/kVLMl3GXPsjM6lF4nePyqvwJ6IBjpceeUV366lcWcB+JMqdwcoJWH/k5ceIKUO2XP3JMY5lOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbLRDZz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64454C4AF11;
	Sat, 10 Aug 2024 05:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268606;
	bh=Xiooa5dT7LuXNNfhA9zxFqsUFgBnqp2laqVYtDKyLWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbLRDZz6zx5MokthnMg4ZjT6iFpZkOCOkcfkkUBoqcz2upqUppzYFKC6vBrXGSySb
	 W0meQEqzIgOpsPl5P6d70UqM0ukZyurFGtgCa9NWyejVq9aj50n+ORkGHWMckzseMn
	 XPKcs1m1/biaCDRs9CrtmzRSz3bpDmpTISKwkeMQawrv0dgiFva5zCdSX3WtOezQy6
	 TdTMMMBPsw0ciZkbNKTM6zdEfyVVFShe7kS8aIy+gPObk3170F/IyAotgmjm4yAOwR
	 uC8a8ELKpUpdtlh4WY4ZUovG7xTGK1pPZYEKiDG4CndcoqqDumPR0DDpuCLSCVtdvi
	 NyQuLwo7MRZQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/2] eth: fbnic: add support for basic qstats
Date: Fri,  9 Aug 2024 22:43:22 -0700
Message-ID: <20240810054322.2766421-3-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810054322.2766421-1-kuba@kernel.org>
References: <20240810054322.2766421-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Fomichev <sdf@fomichev.me>

Implement netdev_stat_ops and export the basic per-queue stats.

This interface expect users to set the values that are used
either to zero or to some other preserved value (they are 0xff by
default). So here we export bytes/packets/drops from tx and rx_stats
plus set some of the values that are exposed by queue stats
to zero.

  $ cd tools/testing/selftests/drivers/net && ./stats.py
  [...]
  Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index a048e4a617eb..571374361259 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -4,6 +4,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ipv6.h>
 #include <linux/types.h>
+#include <net/netdev_queues.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
@@ -395,6 +396,71 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_get_stats64	= fbnic_get_stats64,
 };
 
+static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *rx)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	struct fbnic_ring *rxr = fbn->rx[idx];
+	struct fbnic_queue_stats *stats;
+	unsigned int start;
+	u64 bytes, packets;
+
+	if (!rxr)
+		return;
+
+	stats = &rxr->stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		bytes = stats->bytes;
+		packets = stats->packets;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	rx->bytes = bytes;
+	rx->packets = packets;
+}
+
+static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_tx *tx)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	struct fbnic_ring *txr = fbn->tx[idx];
+	struct fbnic_queue_stats *stats;
+	unsigned int start;
+	u64 bytes, packets;
+
+	if (!txr)
+		return;
+
+	stats = &txr->stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		bytes = stats->bytes;
+		packets = stats->packets;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	tx->bytes = bytes;
+	tx->packets = packets;
+}
+
+static void fbnic_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+
+	tx->bytes = fbn->tx_stats.bytes;
+	tx->packets = fbn->tx_stats.packets;
+
+	rx->bytes = fbn->rx_stats.bytes;
+	rx->packets = fbn->rx_stats.packets;
+}
+
+static const struct netdev_stat_ops fbnic_stat_ops = {
+	.get_queue_stats_rx	= fbnic_get_queue_stats_rx,
+	.get_queue_stats_tx	= fbnic_get_queue_stats_tx,
+	.get_base_stats		= fbnic_get_base_stats,
+};
+
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx)
 {
@@ -453,6 +519,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbd->netdev = netdev;
 
 	netdev->netdev_ops = &fbnic_netdev_ops;
+	netdev->stat_ops = &fbnic_stat_ops;
 
 	fbn = netdev_priv(netdev);
 
-- 
2.46.0


