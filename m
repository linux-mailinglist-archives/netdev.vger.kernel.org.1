Return-Path: <netdev+bounces-247375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390ECF8FAD
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5F303068B9B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3D21A95D;
	Tue,  6 Jan 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InUmX2Tc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAD336ECD
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711905; cv=none; b=G7kDXc4eM9aJDcgI1T2jaRuLXhAHBNkqdku4o916IwTy8KikTjGB/qOtHZQpLgpi7TFwITX9xJUmx44uWq3oYRNb5IVBE3g3TueeGOBwQJX2/Gs71CjuAjoscUytTOTlqzKWKn7Luc8obqdBQOe8eWD1ifFADpCeJCXVkZS0G6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711905; c=relaxed/simple;
	bh=xszaQ3qzOot1odzGyBA0Zkfa9b0Ivks3e8yQFqhs2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osx2tXnDrEEqvsdg1ZrVEz66qpco1w+4b9qiYVkdrtR+WFtEEZZX0pBxqUCS15As8bvqubtE52IzTJmYGSDMOdbG6pvvhH8PFZQTbJRQEnarjx0zdA6fZ4mBhbkO6+rnSxM7sAfKsKKDWPcyf0AN7EbPrjOqMoSxjmfGFFc9HVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InUmX2Tc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so771175b3a.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711901; x=1768316701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCgDdsFcTcXxf+qbWNQRt/nwxivkvn3dRLkqvh820N0=;
        b=InUmX2Tc85X+x4r1XsBfynIkmazzuKxkR4u+dpkAHvul0xSw+BeGD/9SAhp9Bq77Go
         XGqgUM5aZJeylku7TEDr4kYRwbnH8Uln41jW3De/Yc0G0BfCc7GD+Qz2L0XxQdqyfyHK
         ugpnj9OtaUgXdhfIozd3XfVq9K0QX8Qf+V4dx+3oEhuMpDxPds7pjibwrJ30yUGnj23O
         sXCQxNFAKbkAFPnM1noZzT39K2I/x2VvHINveqRBwpIp7CV/YrSzQpip9HhkurwGBSAQ
         wCV8t06fGv28Id8n65INMNw2+8ahemFmK76qQvt5qfxCi7axA6Wa1OFnbfsmZG00G99A
         AwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711901; x=1768316701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCgDdsFcTcXxf+qbWNQRt/nwxivkvn3dRLkqvh820N0=;
        b=kqN+H9gZIx3kqXmBUYoOhSYZOAGrz83J2ZhJfexWSRux8xP+axe7O7QvGGS4vecOJY
         uk96UuaoOH8ZNVFSQK2GkbFwpgg762etNsi2HXdxO167DOay3mzhvCzp3YNF7d4DMsiL
         tEImiNpyZ2K+e0zK+DKI5YCAJv+O5xLUWVWAkcz3jd4Jo0e+AsI6ZdsK/HzXEJ5ScScR
         DriWAse5Wu3VHgQEzy0Jx+uyWbmt9PqbxWBHty/G03lIfUZ6hEV66wxXYxuxHNgBIqkJ
         2bvNK/r+P3VE9Y6Rh9NU9UDDND1s38gK5nDMClpVJC8qKTzApXuAApClUpO3afwh+jvm
         cftQ==
X-Gm-Message-State: AOJu0YyXGHE2LajbdUOP0unuBtz0Sex45ZgCn07orp4XOpc0A37hwoZt
	0u6/Tqj3WPYiOvtglFjxXnPY9WgiqGNfb0Rpykq4xiK2H5vUQ0T+LPXIRnIiJA==
X-Gm-Gg: AY/fxX7hwNX9p8QhJwFwWnUGPG+IgIwKkxaXNrRRJrhsyp9Soikb3X4c63yxaaMKDGm
	SFphfhxanvhhP5Kw6fv9ulsPdm6smZtbcCzNPH+7kC8qC3zBr5rqib14RwVyMP8IRkdKlee9/gW
	8Hf0nEZ631p535E9GHkPc8tA8V/iNJwKqWRFLXoC5vKTYga/7LVZY0mTCkg8yEvKkhgH7mvLyzl
	G8wVKmGPt4YMv2rcBaSoPhsBTjQkXfbfuCfY1jNy1ZEClDHQQoQKZpbMNjszrjDgsEPtd+dL6hN
	Qi+s+jygduvcm1vT2eBTiHFOUZ5EriKi8IdG+KLYn3k450b0PxYOpQf84P2qIceAQdxX1kaxqpT
	r9dRgy7E4LBgVSbTmLHg1iZdJh5X70VTBHQaqnyJKX14xr6ZekGX3hyi5wh48f2plh3zYVE3qKl
	tpZ68IyZkqU0X5x9j1nBA=
X-Google-Smtp-Source: AGHT+IHDogIdZKcYrYsV8f80P4yM3C43vbE23Xgd+qTKk7rTQsoMMRcLT36sPlF6l2euTU7zw8ZVRA==
X-Received: by 2002:a05:6a20:244a:b0:34f:2070:89d5 with SMTP id adf61e73a8af0-389822449d3mr2785149637.11.1767711901107;
        Tue, 06 Jan 2026 07:05:01 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:00 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill worker
Date: Tue,  6 Jan 2026 22:04:36 +0700
Message-ID: <20260106150438.7425-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106150438.7425-1-minhquangbui99@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we fail to refill the receive buffers, we schedule a delayed worker
to retry later. However, this worker creates some concurrency issues.
For example, when the worker runs concurrently with virtnet_xdp_set,
both need to temporarily disable queue's NAPI before enabling again.
Without proper synchronization, a deadlock can happen when
napi_disable() is called on an already disabled NAPI. That
napi_disable() call will be stuck and so will the subsequent
napi_enable() call.

To simplify the logic and avoid further problems, we will instead retry
refilling in the next NAPI poll.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..f986abf0c236 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	else
 		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
 
+	u64_stats_set(&stats.packets, packets);
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
-		}
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+			/* We need to retry refilling in the next NAPI poll so
+			 * we must return budget to make sure the NAPI is
+			 * repolled.
+			 */
+			packets = budget;
 	}
 
-	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
 	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
@@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+			/* Pre-fill rq agressively, to make sure we are ready to
+			 * get packets immediately.
+			 */
+			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 				struct receive_queue *rq,
 				bool refill)
 {
-	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
+	if (netif_running(vi->dev)) {
+		/* Pre-fill rq agressively, to make sure we are ready to get
+		 * packets immediately.
+		 */
+		if (refill)
+			try_fill_recv(vi, rq, GFP_KERNEL);
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
 		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	}
 succ:
 	vi->curr_queue_pairs = queue_pairs;
-	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		local_bh_disable();
+		for (int i = 0; i < vi->curr_queue_pairs; ++i)
+			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
+
+		local_bh_enable();
+	}
 
 	return 0;
 }
-- 
2.43.0


