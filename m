Return-Path: <netdev+bounces-116962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9794C361
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1294A1F22ECF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F536191474;
	Thu,  8 Aug 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEzrgdWY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10416190693
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136974; cv=none; b=iygKy7hYkDXLyze3QTyllcnd9kkYuvKLgOweqH3sa50eRCBrnl/PG09ng97E1xirFmjLxLnZORx1yAgPdH/ZLuY/UpdNK4DrGGkBdc57PpNOKvEZ69jxmEg8LSihoKTmJ8GhlM19pgY0npdyzhiM8TGtD8qN57FZSHZ2dkxK34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136974; c=relaxed/simple;
	bh=Xiooa5dT7LuXNNfhA9zxFqsUFgBnqp2laqVYtDKyLWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEZim7Py9/1Z13jbZnODc2j+kOU0F57q4udqsoxvp/OK6qXHmMqCf8xcwy3nRCd4doyXJtg36ZKFZrEQqnHMXxZqJgdWy2hWw3Ka+ZhQR9JLuXPF4gdjIfA8FbS78LZCssNnWXxJun0wkJCFYvKiFURoI0zEO/OXO6o1/tfL4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEzrgdWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E0C4AF0F;
	Thu,  8 Aug 2024 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723136973;
	bh=Xiooa5dT7LuXNNfhA9zxFqsUFgBnqp2laqVYtDKyLWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEzrgdWY/IFIQelDWP5YkfchZAuc4G+M/OsL7ijdm1jNGdcwrkvKR4XyEdEwGL11d
	 YpeAoRWDhNiKUX3Vks3sVuhcsfvy77Xm9jjguPHIGqxYhLtMciu56kwrdbqCRjJbt3
	 XJ1cwzy6vPch79gYyPyobOEMOFF2Zt/LNwLxLb0kkdDmX6A9w91YeOlDUGlJ3iY3X8
	 IPBTn1EJZ3vz7k3xrfSyhs47oo5Ux9spxpd8zoKt5quQY/SjYMLj+19FP3CqBGf0eu
	 rTFTLu/X8xLshj7V0TvitUeh6ul2rRGKsIrUYXECldnmN6YKjx8ydTCMwy6qkiO3Rw
	 Q6nQsKAruas1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] eth: fbnic: add support for basic qstats
Date: Thu,  8 Aug 2024 10:09:15 -0700
Message-ID: <20240808170915.2114410-3-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808170915.2114410-1-kuba@kernel.org>
References: <20240808170915.2114410-1-kuba@kernel.org>
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


