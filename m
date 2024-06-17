Return-Path: <netdev+bounces-104024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8290AEDA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030DA1F27BBF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E5198826;
	Mon, 17 Jun 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vdjBUJ4t"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32F1DFF4
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630133; cv=none; b=YM/V/4wt41J+Tn1SIQVIvRuRH+K6ONc2LlwCfGgo2vOo4JheUwGIZjMzskplj5Y6lNyfKgpSIm9NZSGkkOiMiQdJQlItsHy5t1w9Gvw9Tgna6apQGdOeLiSvuYDTnV9NGBYwWyuMzulzliDRKmIEqJt7un8bSIMI67C+mbNQvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630133; c=relaxed/simple;
	bh=JC6+JAN40Zy6Tqcb+/Cxp+CoLq5SClRaE2RYAoFywOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9g7Zahg4m7eImffsjBF0EOn7y/iep5h+1/mhS5+/mjAIOIM+ODaUxiNSnKTj+L/7r1nTHRaTy4gqN4FuE4/NOxxzR2uqHDdUcNsv3TZZCvgb7rfQxc1Kgxmh9MbABEMS8pm2tifNkhD21x3jhQ1ilAF7KL6S916mhEgp17zfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vdjBUJ4t; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718630128; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dwhiCYViO2Sb5s0QwKB36F6bgPn0fPUH1OG3Wt9jiU0=;
	b=vdjBUJ4ty9GhC3pfSJ17GVELSyvHa3GyP6Dxo/roOkqGioZKUCwbfKLAUPtzvAy4DdwB3UEIEN+oZ9VVDtpSbA5TpMiw0174K82FAgn7+v/HLqpmhHSaHyGFpUYyQFxIVOGILs4M4O7KPXaQfwFKWMHDCipQui6+/ls6P1tc7pE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8enhha_1718630126;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8enhha_1718630126)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 21:15:27 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Thomas Huth <thuth@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets handling
Date: Mon, 17 Jun 2024 21:15:24 +0800
Message-Id: <20240617131524.63662-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240617131524.63662-1-hengqi@linux.alibaba.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XDP program can't correctly handle partially checksummed
packets, but works fine with fully checksummed packets. If the
device has already validated fully checksummed packets, then
the driver doesn't need to re-validate them, saving CPU resources.

Additionally, the driver does not drop all partially checksummed
packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
not a bug, as the driver has always done this.

Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after processing XDP")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index aa70a7ed8072..ea10db9a09fa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (unlikely(hdr->hdr.gso_type))
 		goto err_xdp;
 
+	/* Partially checksummed packets must be dropped. */
+	if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+		goto err_xdp;
+
 	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
@@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 	if (unlikely(hdr->hdr.gso_type))
 		return NULL;
 
+	/* Partially checksummed packets must be dropped. */
+	if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+		return NULL;
+
 	/* Now XDP core assumes frag size is PAGE_SIZE, but buffers
 	 * with headroom may add hole in truesize, which
 	 * make their length exceed PAGE_SIZE. So we disabled the
@@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
+	u8 flags;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
+	/* 1. Save the flags early, as the XDP program might overwrite them.
+	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
+	 * stay valid after XDP processing.
+	 * 2. XDP doesn't work with partially checksummed packets (refer to
+	 * virtnet_xdp_set()), so packets marked as
+	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
+	 */
+	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
+
 	if (vi->mergeable_rx_bufs)
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
@@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
 		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
 
-	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
+	if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
-- 
2.32.0.3.g01195cf9f


