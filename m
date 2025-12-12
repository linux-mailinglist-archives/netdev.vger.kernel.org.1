Return-Path: <netdev+bounces-244507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8D4CB91F2
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E092300A9F1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3A31813F;
	Fri, 12 Dec 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoOXaMoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A6274671
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553280; cv=none; b=RxibaLFJdi2RvaoGgrcjrDGXU2a6dhrQTPktBVBJSRcAzUcn975QlPupexnGtV55M7GvOdG/ngBNhutZhZ2DVqGo+MW4FhzW/m8f2MK1CH2IooBaVn2n3f2yu3dB4RSMEIswV3APiyJjZxXlltJqVGBD4wreDALDErjL8UHP4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553280; c=relaxed/simple;
	bh=i+qr47P2eCDHTXJAVkjOdS7xg57iGJ43qDshBEK6miY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtYnsPeDlm1uv9z4VLI1fzE1DM3wv87mL/t8eVvDVE6me6aOLL9M96K8aVi6jvoT9nsuoffxP45IWv3GjO/udwE/7vHGwf2bwRYLMIwgtIIYoKnN21BsL1Ek0BNUaVY4DVad4HnB8FDCGRiBMQ5focv+Y1jIp9xdzDK1Jq7cjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoOXaMoQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso293356a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553277; x=1766158077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzENitL8AUZ68RERyt6xp7p+jtCblr0NyYweq7WA0Os=;
        b=eoOXaMoQMgVMdNzz88yV8SuElgbM5NJDiq50Dw5EON2DksG0/gN/2zEa+0K7l+sHOQ
         xZfhP6miNtyaLWBbDErCy5ygXBmp34U7aa8DfgeVifkOWjuQGpMkZzCLlyCZw1RVVf+U
         5xHMjRPTqj40hU+Sd1ruoHaKLiG1Qz/YY6S6+nj+c99ebjbIN32yk03UFby0vNS4hsak
         XYKgok0TfoKpLfTgy9dE9eKuRujiYWNeWrC86U71RWS/HfGA+FZ3WzYqRHO4ElJL7p88
         9qDZlh/m9QHdPjsbYext/O66FGo63fyMErF7n21elANS5+aPUoO2sfBHtEfWlYikU5So
         49qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553277; x=1766158077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzENitL8AUZ68RERyt6xp7p+jtCblr0NyYweq7WA0Os=;
        b=xJ3RVtCDvcWv5iRpAmI1kYUF4GPJ1i4WRY9OLuSIFAvzmuHwlTJQD99CKpsJhihzBr
         DgB2jEM7LU0lsjfnBzOUYS3Ce2xk/LcXNVjxp9CJbgDcLVT7pA8CbdROPvlwklgI7143
         0MgL+iqIbx11BXnt6VN5qz71JD9MYMERCTLpzZdUUIPyCZ/bARqmLANSVdmDZJVeDte0
         FQhejFlXqLyeuYWYCcajU0AchbKrtu7/5pu6JFSNSiEDshFBWO6wd0b5Y1dr2/JSBvxr
         8n8ah/A0dO/XiJ8BFbKhheeNLauQq8XECvMTY8ERvLH733frKubBwxeDSs5MrwsQ4Nxf
         0UHw==
X-Gm-Message-State: AOJu0Yy1IUA8eqWzHDNMj2IQB1y1tYjz9sWz2aEqThy5kDeMJL9hexWn
	mD4ttvyAdCVsstJyefac4QbisG2vHXvAa+D04KisrqcsSCIRYvjXvcElc6DjLg==
X-Gm-Gg: AY/fxX6uaXjeMpZZRfFfH8fuyQWvHCXxfqVTtpH3nGCmFPmPVAEzaJiYnw+v+dj+RRO
	rFvZLyyPp9B4jebW8A8vsUY/oX4JlU25ioNar7rdRD3QX9gdIoqldzL3yWtTVnpTNtPr6d5ERWS
	Tp/1esuFX76os8GC2IpEk2N9sRlQw6Fo2EQH812tMXRFxBMLVvAgY9F4KMV0Uat/8fzpe/R3BYC
	qQaLJavOxWCR6hUyVckHZ+i2gUJnFamJiMjk3CxAjBY8947yYiRoej8ghU+Mp44m9sABtlKgOa6
	1VCQCfP8E5AcqKnVOPilzUmQpC31/c+QjDyqiAaIQ40/ahWjizvVlsJ5nbQRx2VYF9Pte+scX+V
	ZhZkTQSlwpS5sbM25BKgVFIP1NL1yHGG9AVYUTSMXJsFiZ6B6bdqnG2ASUFSrRYfK/NW1lq85+e
	rURVpWCNLS3bhby++qiU6dw0bz
X-Google-Smtp-Source: AGHT+IGJkdJ9hixisUeeYL/0HntI53jNSy5a6YB1w0C5X5lbrmy3dicEMz346CEDNpxcNlRXqX/xeA==
X-Received: by 2002:a17:90b:35c9:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-34abd858b3cmr2097689a91.26.1765553277401;
        Fri, 12 Dec 2025 07:27:57 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:5402:1cf7:eb53:9399])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34abe3dea94sm2288511a91.11.2025.12.12.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:27:56 -0800 (PST)
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
Subject: [PATCH net v2] virtio-net: enable all napis before scheduling refill work
Date: Fri, 12 Dec 2025 22:27:41 +0700
Message-ID: <20251212152741.11656-1-minhquangbui99@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Move try_fill_recv() before rx napi_enable()
- Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..4e08880a9467 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool schedule_refill = false;
 	int i, err;
 
-	enable_delayed_refill(vi);
-
+	/* - We must call try_fill_recv before enabling napi of the same receive
+	 * queue so that it doesn't race with the call in virtnet_receive.
+	 * - We must enable and schedule delayed refill work only when we have
+	 * enabled all the receive queue's napi. Otherwise, in refill_work, we
+	 * have a deadlock when calling napi_disable on an already disabled
+	 * napi.
+	 */
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				schedule_refill = true;
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
 	}
 
+	enable_delayed_refill(vi);
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
@@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	__virtnet_rx_pause(vi, rq);
 }
 
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
-	bool running = netif_running(vi->dev);
 	bool schedule_refill = false;
+	int i;
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
-		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
-}
+	if (netif_running(vi->dev)) {
+		/* See the comment in virtnet_open for the ordering rule
+		 * of try_fill_recv, receive queue napi_enable and delayed
+		 * refill enable/schedule.
+		 */
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			if (i < vi->curr_queue_pairs)
+				if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+					schedule_refill = true;
 
-static void virtnet_rx_resume_all(struct virtnet_info *vi)
-{
-	int i;
+			virtnet_napi_enable(&vi->rq[i]);
+		}
 
-	enable_delayed_refill(vi);
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+		enable_delayed_refill(vi);
+		if (schedule_refill)
+			schedule_delayed_work(&vi->refill, 0);
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
-	__virtnet_rx_resume(vi, rq, true);
+	bool schedule_refill = false;
+
+	if (netif_running(vi->dev)) {
+		/* See the comment in virtnet_open for the ordering rule
+		 * of try_fill_recv, receive queue napi_enable and delayed
+		 * refill enable/schedule.
+		 */
+		if (!try_fill_recv(vi, rq, GFP_KERNEL))
+			schedule_refill = true;
+
+		virtnet_napi_enable(rq);
+
+		enable_delayed_refill(vi);
+		if (schedule_refill)
+			schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-- 
2.43.0


