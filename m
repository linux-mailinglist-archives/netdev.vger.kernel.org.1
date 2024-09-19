Return-Path: <netdev+bounces-128895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681197C5A6
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEC81F236FB
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24777198A37;
	Thu, 19 Sep 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OIrIXV4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3041957F8
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733641; cv=none; b=QSgRj0rdmYDZ0z1lHZn25Za8NmwnI87+iJjd1xISGF0gzZAv7AqqERNEbaRlFYn8PxxDywUuTjzxljsy1DQk/ezSm2rVF8ZRQ7HqmEYTOucwRUaUfuEQT9ImXULonFUyfOscTdJVBmvLGK2PelHDZwBQZnKZV5yVcmyLPBt+o9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733641; c=relaxed/simple;
	bh=obPizuvNjntWiaeSWyWHSSnIyiXDkzWD/VemLy1LTHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DFGGxNMFhiPSUg4F0b2SP60u0jpPB4VC3dCVMSh5PQzcGLzHCscEBlxuEtzQHDEAoe/JADO4uSx9Zwe2YdHOnHRW22WehEBrnTSCoGMHSCBE5w01Mz2ZqQ4VGgGPCg+fCogBA5A9eMYvZHBbP2IWbSMVfRSoatw90ytnQBOIUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OIrIXV4z; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e03974b6a5so277587b6e.3
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726733638; x=1727338438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dmixfEFYfutwhSv2UHLcy5Vr3qDSZZFKkZiBqJtRic=;
        b=OIrIXV4z1pYVVJfNXsRgEqaOv33YKzaD37SnwiyYNvpQu9f7ggjsieTbQgVLsm81fI
         iveriqlFhuiAmWrw2ttjkX/v90T5D4nW0o+2GO1w7oVCaU1y30J6Bmkpq6Qc9O9xDhx2
         V/eseJ1k3evNzwcUAimfUoU/Hx8WnLMdz2hTDGTFXR1w3ziGf4BWZDdmVFrF7TuWf3Qz
         eoss3GfC/6wuvK6hCiOybWddZjQkk7esuE0AICPIfNiIN95Xe2ycLkeHN5xbWd+nWmIV
         H9uTAkzcgESRinZCS8jsa2VSlCUPGD29UO+yHdOU3Vpo+YoWyz3el0HvBL4NwqW2HU1K
         E04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733638; x=1727338438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dmixfEFYfutwhSv2UHLcy5Vr3qDSZZFKkZiBqJtRic=;
        b=KmgPJIBFceW6jwmZQPF/pUBBCdmBnkE4WxWmfVyOsRQM5Bq1exXMsRqncusj09ZlbH
         qUw5DOX1iyDMdRlG9Nb+6VIELDQJ1tMNt/R80mzizalHcAQxzsSADPHUIaJUpPbBccYi
         mF60GZJY+YPlHGZ6ZqFO32l42DMhWAF9mdleGfCS9T2TER/tZXjaUmmqyGAmkKKP6dgk
         qzEw0TS8HMcbQc9i8s5BYwltcTYOeNGhdOq+4SEHqzXYxR36fTUlV86DQitG0f5NYS1o
         FzEi3+2IC8ecmokiBalZdrB9ipmh/pXSU2g79iogvbYsHOfNeDMaEEgQ+STj8Tr4FHFN
         wa1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAldTYGHhGNCB7i3U7bS2ri2NviHhc+ZRB6ok1Ii0tw/wevN4DfnHa6CSDV3rVIAyClI5jMP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZFXaUEOfZjffOiG8UZHjx7Rp0dTavlySUp1TcPdDGttmWuBZ
	3XE59Y1BCMUnfNffZZRczBCA4P8jVXOMDvx1gGDFlfoM4afZOHthQSE9o7CCPUQ=
X-Google-Smtp-Source: AGHT+IHrrnzRxSY4w/ZqyCFd4PYtjfrKVDqkWH8qTW+OmjOTvxBIUj5ZqO1lp38Ok8sq4NeMIAkHWQ==
X-Received: by 2002:a05:6808:2292:b0:3e2:5b9a:d43 with SMTP id 5614622812f47-3e25b9a0f53mr7459331b6e.34.1726733638252;
        Thu, 19 Sep 2024 01:13:58 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([2408:8642:893:ac37:a1db:b4af:9e2e:2d1c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498fb8f4sm7544306a12.32.2024.09.19.01.13.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Sep 2024 01:13:57 -0700 (PDT)
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
Subject: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 16:13:51 +0800
Message-Id: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
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

This patch unifies the address passed to the virtio core as the address of
the virtnet header and fixes the mismatched buffer address.

Changes from v2: unify the buf that passed to the virtio core in small
and merge mode.
Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f4781ec2b36..f8131f92a392 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1807,6 +1807,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	struct sk_buff *skb;
 
+	/* We passed the address of virtnet header to virtio-core,
+	 * so truncate the padding.
+	 */
+	buf -= VIRTNET_RX_PAD + xdp_headroom;
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2422,8 +2427,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
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


