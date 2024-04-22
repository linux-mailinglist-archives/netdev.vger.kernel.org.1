Return-Path: <netdev+bounces-89905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00FA8AC29E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F8F1C208B2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA44437;
	Mon, 22 Apr 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fnSgEDJk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A83D60
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750861; cv=none; b=hCwZER8RDB4v6GSiV1FSyjVY8yFiPztWpTrrqxivguifI/CStO/nUwOVLWLF5X5xcWyD5zGoFpG4Z7AZfY6UKGqR4Ah+GOiYlccw0iqFjn1Vf3ZpJPp1Khrsn3nlbpKDvZdXMhQeNstmZ5U5W0rbzZ8gsj38kGqYeoUnHGEOu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750861; c=relaxed/simple;
	bh=L+5iKg2JOcu81gYPrzG12eHMxzy6vRQflndEiznoB/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4Ypkd2jaYXdhfukTRhNLmwSAw2tJEzD+8d6b1Ll+cO91OfdvRUmfYZBjRdUiFPzvhD4faSnfegCrKm8+WH33Bw3CECxsgPuk2FkrDQ8jR6zTCwk6Cnoc4k4tur6JnVue06GfX6/LjaI8u5UEHTdW1jaOPqmvs9SedbdICPBDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fnSgEDJk; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713750852; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Od8DVGrElE/G4mB/sMFtr2HoAzT/Sn6eJF9sxWhZtyw=;
	b=fnSgEDJkIpBprPart/0cyoCiNhqn3rP3mv9y8W5eKiJzSyddrsN6d6Mqb/KyFY1M94DjuDxg6aQGuinGXoVeYw1iO8xGkcA3on5fjaSWaj1Ez/DAVanQQQWk667RdPzi00en5qx62ftYg4VgxRgV5hpdmhe1zS19Ap+ltaxCnvA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4y4sLh_1713750850;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4y4sLh_1713750850)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v1 5/7] virtio_net: enable premapped by default
Date: Mon, 22 Apr 2024 09:54:01 +0800
Message-Id: <20240422015403.72526-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
References: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2c089e81de7e
Content-Transfer-Encoding: 8bit

Currently, big, merge, and small modes all support the premapped mode.
We can now enable premapped mode by default. Furthermore,
virtqueue_set_dma_premapped() must succeed when called immediately after
find_vqs(). Consequently, we can assume that premapped mode is always
enabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 75f33bbfd5fa..1bf49956dce8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -896,13 +896,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
 	int i;
 
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
+		/* error never happen */
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
 
 		vi->rq[i].do_dma = true;
 	}
-- 
2.32.0.3.g01195cf9f


