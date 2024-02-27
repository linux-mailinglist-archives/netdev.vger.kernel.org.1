Return-Path: <netdev+bounces-75219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB1868A62
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774A51C20FCD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849956763;
	Tue, 27 Feb 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EkE6F3Mu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995F56762
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021001; cv=none; b=GGtTewcNliezlY2I4Q42dVb6ivKI//BXXuE/GHND/3g7U1CR+L/kRcX8/dG9AQE7p3Z/wzBxKhmG3sUTmEY/ct/zD7JF2KqZKUuYvjfauXLUDwM7+Qt5xisru+8QljcLuAlCnRI/ECLFl1C0yypu3aGpKodNDpLjjeJFzI3gm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021001; c=relaxed/simple;
	bh=I05ORVcpyq4EqsF2TIo6Eqrl9ra0z83u5K8YrZ0H74s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tl0Z+oBdhBl6zeQ4Z8lpVG6GjVLoYbZXsmVSvj52skHVGsYwL751Ds40CeGnhzb9occNUAhO5fUngHg9VcGwNUNKbAnDp9EoICimfybEJnUV7AysRDmkVTaB6IxVGGxjSuLv57iyvLVfD/uSlX3gk04DJht12oxtonRr37VZJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EkE6F3Mu; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709020991; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VmtlNttH2hCP8SSaBmAxTigLi+f8Htbao7d6R3uMQLs=;
	b=EkE6F3MuYde/3Rygcc6p2AXxO0b9sKY1eepkfCme6cN3T+7HYmqX6sJ+C4JS3EOBLZ86zRNdtXI5Csb4l2szazj09lKqD472R23Ebu7IG935ZH4Ty/i4fa+9fURTcXurJw2lIl48SH4wKDASPpwFTu/4gBK0nAtquqButcECsk0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1LxoIA_1709020989;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1LxoIA_1709020989)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:03:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v3 6/6] virtio_net: rename stat tx_timeout to timeout
Date: Tue, 27 Feb 2024 16:03:03 +0800
Message-Id: <20240227080303.63894-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cacd048f99e7
Content-Transfer-Encoding: 8bit

Now, we have this:

    tx_queue_0_tx_timeouts

This is used to record the tx schedule timeout.
But this has two "tx". I think the below is enough.

    tx_queue_0_timeouts

So I rename this field.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 91838d75cff2..4312850fd770 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -87,7 +87,7 @@ struct virtnet_sq_stats {
 	u64_stats_t xdp_tx;
 	u64_stats_t xdp_tx_drops;
 	u64_stats_t kicks;
-	u64_stats_t tx_timeouts;
+	u64_stats_t timeouts;
 };
 
 struct virtnet_rq_stats {
@@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 	{ "xdp_tx",		VIRTNET_SQ_STAT(xdp_tx) },
 	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
 	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
-	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
+	{ "timeouts",		VIRTNET_SQ_STAT(timeouts) },
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
@@ -2760,7 +2760,7 @@ static void virtnet_stats(struct net_device *dev,
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			tpackets = u64_stats_read(&sq->stats.packets);
 			tbytes   = u64_stats_read(&sq->stats.bytes);
-			terrors  = u64_stats_read(&sq->stats.tx_timeouts);
+			terrors  = u64_stats_read(&sq->stats.timeouts);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 
 		do {
@@ -4531,7 +4531,7 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_inc(&sq->stats.tx_timeouts);
+	u64_stats_inc(&sq->stats.timeouts);
 	u64_stats_update_end(&sq->stats.syncp);
 
 	netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name: %s, %u usecs ago\n",
-- 
2.32.0.3.g01195cf9f


