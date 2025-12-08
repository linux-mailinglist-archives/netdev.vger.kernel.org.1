Return-Path: <netdev+bounces-244025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31697CAD9BA
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5585A302048E
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB72641C6;
	Mon,  8 Dec 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiADeDa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3C242D83
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208109; cv=none; b=Ti0LCy0q6orlLSOGFQHRpidQhQxXIA3pytjFXpC1exWrvwG9xkIgI/1KEh4UDjkSm/gfdbNiLdtG3vbYpa4cYwoKDIpnD1mAjLSXgTzQOy2EImvmtuyXGMM0zJHNc3z3EM2iphT3N/oh2Udv5ivY/rQ+XRe83hAjOhtsd3hfA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208109; c=relaxed/simple;
	bh=+dA/FLXdh91Tj4KvXzdrCX9sD7l/ZFnkWVRU35JvuQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkWtMXivTN+Bpbt2kcTp7/zUy0NdlP0+xo7+gFNTN72sYCFSSQgbTnDkQm7bH1HGE/oFpf9qsudsnmLUa5xr4OGcpAMP9330MtJ2eQ4HkSycTjbLC7Bp42bpOE8tLbvKGCpSAHSbM1UmCf7a8kuQT5xKYv+f8bRVSlR2uyLUQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiADeDa1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so5248329b3a.2
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208106; x=1765812906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWpFolnAyO+/LNdlTubeymU5rZAhEOvt75iUUlk8FxM=;
        b=DiADeDa1aZ29xlsEkqIYnezJx/4qPeuEmrN9xnMrSK/rmtc5igjjHJc+t/3wKmXl8V
         hexwZ0VfXSAyCcAe6EyP+gI7K+d4fYh327LFZtuQZD9yBl8kbDyo0EMYAgkeKKI64irw
         sJJO8CCVEZ+J+UWoRFXHansTq91rE/7+lq/7jHpSoNw1RqXLgi0kgNZQfztI4vxx04Dt
         uJX34FKQb6gAJN3IS3fBruvuY0rBsUk0EybBmLM6jhaHpA/kvAz4WfS594+gPl+4A5Zg
         UFv2D6b3h8N6jWdL1Rnsiz9bIaKTenMJs2oTtEq9yrJnizN0hX/GgM1dC7XEh48KE308
         3Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208106; x=1765812906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpFolnAyO+/LNdlTubeymU5rZAhEOvt75iUUlk8FxM=;
        b=oSFhEr4Pf5DVvQuSLk6k2+I1fUsSVVjKBc66ULxtPMX/r1POlTlgo4oPx99W8VS+xR
         7bWiptowmeBG0gzg0rcm5D5k3ErtX9Lpqnn9Lu3wCpVFQhFPukuUq9QWESG6r9E1cBbT
         RvDjcmtuXSjh8zP7nf/RZqP16P+742+dzuWHj39oF3bWApcG1ntFRUh1Ke8c4SB+VfO9
         zBbalp/Pcft0b5LNLTFqweky+NNnwbpe42tbD6tx9H1n/aIdmEsw9KgjXGnzMk/k9gy4
         mzdFtVeWsJjL0UnV+tWAHmzdwaQ1kJnGxFvxcA7h8rgO/X3HB2YYWhOU4k8ua6+i5tO7
         8u0w==
X-Gm-Message-State: AOJu0Yy983i0Fkm5aa0KSM/gzt8fXXoFFvhr3YHN7skjD0txNPb3BqLf
	HXSpn83rDduPW6i0brQgWw9WNhQ14itSz0MFRkNvHr9YHodk6EG4WM8cJMHxTjhx
X-Gm-Gg: ASbGnctTrF0NVu80AcPmpF+FKnYGMFg/JvrmB5AGsrmr/xqpGzJT4RObzx437pKdUIH
	gRT7UzinCiE2HtDD4vUpskB2y1BXZ6vRXfxXaBCZfv4kNT3D7CHu5dTmXBuM/5uZesKl3z2eCxZ
	jNv5Dp0EZLq3D9wXbM7s7n+9OBv76rl2L1dIpcSiRCD7rLaJojEjIMT73bKJnhA1HwL3YS+yvw9
	Qx3677xYtIrsCU1LZ3NgpUaRI6L8FzMQUH45oFK+CceqykQeXWFkx1EnQshr/eDXIKTlrQNPDXI
	NqFDShLE2oEbB3XPZFlxPcDyvJ//9jKQl4AP/5ilxboddKD7UFhk6HrDLsxqKsWPNFXCIYZFFPN
	za4t/zDTerG383N+Vlwsq8B7VmexooFeglmcgywfRxAH4XbpkGk3rNXv9W0AT2L4pUvoy/FYqGI
	FejMc3cb2SpXDA9hIzkglVaBiC
X-Google-Smtp-Source: AGHT+IHbKnsyQgrUfLKGFjvZ3WkKGG8QW0enhqd/Ng7kJy9ybz2AnhuklB93e/amB8t20kVBAd65NA==
X-Received: by 2002:a05:6a20:914c:b0:366:14ac:e1e4 with SMTP id adf61e73a8af0-3661814c501mr7552324637.74.1765208106236;
        Mon, 08 Dec 2025 07:35:06 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:2998:e0cd:90d5:9648])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bf6a14f40f5sm13106127a12.21.2025.12.08.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:35:00 -0800 (PST)
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
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net] virtio-net: enable all napis before scheduling refill work
Date: Mon,  8 Dec 2025 22:34:19 +0700
Message-ID: <20251208153419.18196-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

This fixes the deadlock by ensuring all receive queue's napis are
enabled before we enable the delayed refill work in
virtnet_rx_resume_all() and virtnet_open().

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..f2b1ea65767d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return err != -ENOMEM;
 }
 
+static void virtnet_rx_refill_all(struct virtnet_info *vi)
+{
+	bool schedule_refill = false;
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->curr_queue_pairs; i++)
+		if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+			schedule_refill = true;
+
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -3216,19 +3230,14 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
-
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
 	}
 
+	virtnet_rx_refill_all(vi);
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
@@ -3463,39 +3472,27 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	__virtnet_rx_pause(vi, rq);
 }
 
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
-{
-	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
-
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
-		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
-}
-
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+	if (netif_running(vi->dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			virtnet_napi_enable(&vi->rq[i]);
+
+		virtnet_rx_refill_all(vi);
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
-	__virtnet_rx_resume(vi, rq, true);
+	if (netif_running(vi->dev)) {
+		virtnet_napi_enable(rq);
+
+		enable_delayed_refill(vi);
+		if (!try_fill_recv(vi, rq, GFP_KERNEL))
+			schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-- 
2.43.0


