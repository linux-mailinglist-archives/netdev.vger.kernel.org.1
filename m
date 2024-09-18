Return-Path: <netdev+bounces-128820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64C97BCFB
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BB81F239D9
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15318A944;
	Wed, 18 Sep 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N3vGN9qD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DE18A6CA
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665618; cv=none; b=r2uQMNz38+HZqEc3uxulqzOJvSm4NmXtPuLKgs5P7nMNsSV/e2DS6vIkAiRnSkqb/RshRdfL7ZrZ3151+ybXzl+TsLNWUrRxOvRDAsgdkk4ULB9njzY3Sr1uh4PG4ipTIaXpHf8WkONke065qCCcNp+5dQCcP34OJxVAYmqen3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665618; c=relaxed/simple;
	bh=qasVY9q9JlT/gYIplGSzGfKBcxwHYNBMpM0Po9f558s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DeW/LMHFVMdv6G11lwjN85OyKnG5G1U/haWvLmxRjpo0Lc9ew7uQGkDTmnW/TW/TuOiPhsB1CAOeKnjU2U80Y4PC0MOwulbuCTWiN5pVzs8QDMuLHc+ZfDUPoCpB7mbWIJcmhjgZ4PPetVmsf8dpUIeUzdXGeClR0iEJmdcgGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N3vGN9qD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71788bfe60eso5101303b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726665615; x=1727270415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U14kx2C0BiP6Rt0qs7C1nD5REJe6+YgVN8tQlwgFjYA=;
        b=N3vGN9qDDGL5h+4KJvUOl0JhrZ3OCXu35mqaMH5nXq5ddWBfclQtyq9AoK0jUxi0qf
         BtEQ2+Jc6+4cWAgP62ZjQ7s/zjgjc3TwWBtA4EQey6jO64Vq1J24MqxoSYeeR0p7Gozt
         7GbRANwwyDZcJ0g9GsniwwhgkqMtzvGvTvlqKaWOdmOSdP4X/XcKlvj5HXaA3nTVrk5i
         Wqgi4X2g9ZEBndgwXWbryI8Ci0wyPHMG+gNI0A2htx38B06tFG89rFQp8EPqfL5KSALF
         RGFW7xemvcJJomCmRsm77jibzI9NiYXXXFBlKLlah06ZYUBCpxkuM/p6FFEiEnuilNra
         LA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665615; x=1727270415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U14kx2C0BiP6Rt0qs7C1nD5REJe6+YgVN8tQlwgFjYA=;
        b=MwH1a4vx85E2qklicTnWNq5t13AOrhbLFaWG4GY/yX2lqTHin1LX5m+rRQ7lC/Nw0u
         UX3reB6/qw7+o4OSlloz6Ivkpte/3ZusQjVJ0rFRAHYbqObARnWtNLN2vuAyv/HsVgPE
         UH4HXcHcuIMzol15yrBExNPRygsfmuR918hXw3cIiiI3aMg6Q8+WOk3UEmM66YW9Csch
         ssaYDFdQtntqsc6K4KihcaiJ0R2+8FdX+SBC/98QUrzV6qjvayo+AkqCchlfvbVBWmWl
         euAoTk4CBNLIkDJVPuhF+RQ73L1Y/Dt9T4ywl5qN2RJ57bfBqwCOSWkOLFvGvtqaLOhw
         +9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEAepklTJSiv61JrEyLyc3rviI6EzwESEyl+KtdBkQjKP0v2DJDndHFKzqWKWlK+mkkhfUxAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtE7Hj4g1Q1+KyOp/oreXdWfAbOizB5cBzzVmwFoOfSb/gDjPK
	zpKSMtUfqNr2Ms3gjhAcnv0Qlm0iNSHjNNci/XluUV87aQ38oC3Tf/dN7eJVIPk=
X-Google-Smtp-Source: AGHT+IFmyUFJ7YqItzZrWxCpO5NtkRt3lLOwk+f1KzPuBQI+jMhY31lixZxSduR+YwmQQqbJPHLS6g==
X-Received: by 2002:a05:6a20:e687:b0:1c6:fb2a:4696 with SMTP id adf61e73a8af0-1cf75eefa0cmr36702294637.19.1726665614849;
        Wed, 18 Sep 2024 06:20:14 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc17edsm6698666b3a.184.2024.09.18.06.20.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Sep 2024 06:20:14 -0700 (PDT)
From: Wenbo Li <liwenbo.martin@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenbo Li <liwenbo.martin@bytedance.com>,
	Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>
Subject: [PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed, 18 Sep 2024 21:20:05 +0800
Message-Id: <20240918132005.31174-1-liwenbo.martin@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the virtio-net driver will perform a pre-dma-mapping for
small or mergeable RX buffer. But for small packets, a mismatched address
without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.

That will result in unsynchronized buffers when SWIOTLB is enabled, for
example, when running as a TDX guest.

This patch unifies the address passed to the virtio core into the address of
the virtnet header and fixes the mismatched buffer address.

Changes from v2: unify the buf that passed to the virtio core in small
and merge mode.
Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f4781ec2b36..9446666c84aa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
 				     struct virtnet_rq_stats *stats)
 {
 	unsigned int xdp_headroom = (unsigned long)ctx;
-	struct page *page = virt_to_head_page(buf);
+	struct page *page;
 	struct sk_buff *skb;
 
+	// We passed the address of virtnet header to virtio-core,
+	// so truncate the padding.
+	buf -= VIRTNET_RX_PAD + xdp_headroom;
+
+	page = virt_to_head_page(buf);
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!buf))
 		return -ENOMEM;
 
-	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
-			       vi->hdr_len + GOOD_PACKET_LEN);
+	buf += VIRTNET_RX_PAD + xdp_headroom;
+
+	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-- 
2.20.1


