Return-Path: <netdev+bounces-116292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207B949DC0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1FD1F24156
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8518FDD5;
	Wed,  7 Aug 2024 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbKZ4Nv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DF18FDC9
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722997596; cv=none; b=idd5StRx4EklXm6pjWcYOMnDoB6BSAq1SpUNHiwC1iZWW0UHB8N3DupYyTTnI87exSNH0a6D1hZpMXdbdngeWVIucfoExg97C8xaWOYvJBnnk8tptK8TcigjZzK6fgh7/tkGuFBrXCegNatidaqKphUUwONic6/TtmB76zWcgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722997596; c=relaxed/simple;
	bh=QGyvh5EcTDRd1Lr7lcs2sKAsd1Mza/UZQ3OvxOiRJvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSeEx/wTnkvTwql3WLab/0xwqG2KNxve0InimBhWb674nk9K8dY97+NxGQ9AP/0NyX39dwy9R0LkFxCkrgw7U1z/CRfc2UP3yEQxi3v4iEX9JAbHOUlykqjsq88POw9DuAhNbinm8KtAelhqjA5ErloYDnYKQXXmHGiF7XHJJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbKZ4Nv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D9C4AF0D;
	Wed,  7 Aug 2024 02:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722997595;
	bh=QGyvh5EcTDRd1Lr7lcs2sKAsd1Mza/UZQ3OvxOiRJvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbKZ4Nv65ryvSNPknMmYI3uNIqI+IJAMzABYzzcZuNchHCQDLzTqwQjkzBPoxva1P
	 3SwKrOf3hw19+Vbz6SDBdge9rSKAmaECMQHnK8U0Ngnc6FvE796ae5UbKO0VF2/Cjm
	 gthML8V/iBTt03ZgpYVctdkjgEOQ7XNqP8ueU2filSOb2MNVQMBt8VefimXIWarOkG
	 F6HpOvKM+ehZRan/GNuJDoSj1SnfgfaSdsTvhEdlnFfB8BYDubcN/EnHCvxdTn08jY
	 7eZFMM45RhEZLxLHJH7i2tYQYLnGGFqR0vIP+UCOlA50YV2o0p8BQYZZ4zk9Wy7D+O
	 k2MRkAlAI5Rgg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] eth: fbnic: add support for basic qstats
Date: Tue,  6 Aug 2024 19:26:31 -0700
Message-ID: <20240807022631.1664327-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807022631.1664327-1-kuba@kernel.org>
References: <20240807022631.1664327-1-kuba@kernel.org>
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
2.45.2


