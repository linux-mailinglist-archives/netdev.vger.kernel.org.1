Return-Path: <netdev+bounces-172719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755DA55CD5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2423AF941
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6D17A597;
	Fri,  7 Mar 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AuYLTS+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD71531E9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309948; cv=none; b=gMCWLAxMVD9f3QjuNkrwKzJUAeCPjuYFVi7MbOJdzedGXsqA9hXuT1oQ3kF6TieOsAxPE+KW2lkx45YbBwJPweybfY/bSWon69CiV1vwG6v3YSKcd2oclVmJ5UT1pFnDF58ZjcCbXLO16MsOPiqdMDHCByncDbXsWzXUgz85DI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309948; c=relaxed/simple;
	bh=O43CjekhpNhqU5hy99CW3Pg6sV7P2M0U4HkhUdlpIoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWO6LnAItTnI+o22lMSHyMhb9MTHHzW8+CWkzvNJVJw4KEnXi1EJ82Da9XHelHxwlQiMCaHHxFhNnf5jAoEauo9SMAv/Os6Vq1XsH2GSpguhQ3+hXDCK8fyTCLfefDou1ZC/ofj2AKpH4bpVlNnvGgn+4qd92BgCpkSaxKjnCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AuYLTS+j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22356471820so22014705ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 17:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309945; x=1741914745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kov/5Qi5/eXa3sZew7Uff/swL40CZY7WdNdYduRpGtQ=;
        b=AuYLTS+jy449um+B57nkmg+yhdv3lzxVzXFWpLvsij3FDJXQcl3+YVdHRLmXRvyneD
         17OFw/7kC+QScQObKN2Wg1qC8LGpRkRhHJvG1nODAnI+G69UXHgDZSjfrh0oJY2BaoIp
         UtR3ZjI6ym4fwQPKUeuqFfjWV7gz9kjML8W10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309945; x=1741914745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kov/5Qi5/eXa3sZew7Uff/swL40CZY7WdNdYduRpGtQ=;
        b=t6tLwhMXC3glLvyzXEqt1SJLWGKWwiSBkRchqInIrbKgBBrtVNDoQ1gJ1n51cMGjX4
         z6xMQvcP1Mk7x+vx3G+Ep6QAqjKkY02FqNUF5Dt+k5S2oGbD7H02s0xvkFdU+KencjDl
         dcuHd4WWtDzaGGxVtHB18wYhLQxhlYVhotVyzkIVxpCTT+e+YkxpMYqvtVMdIrJDyPgC
         80dqUvktAPzTQta9X5VC03ZyfDYqsMRaTDeurrPCQQwl14OeNJHT8GBEhr/NfkZXtjOs
         LBm5IW+m2flEwGbol7IxVc+LsKNhyEJCP2Uc01tF52lO2RxHRABfphHlLAZ/zzwO5NZI
         u5+A==
X-Gm-Message-State: AOJu0Yx3/5AfLbLHHcOihDFSipg83AW8Ez4MyOqe+4/yfucJt/SyyEDg
	+fq6/hcSt9Cwfqj/JK6z2RnAbvw9PfROSvugsRHDOwN2NXKoeHqUSild785vzJQAppod8xe0YLN
	nZTnUZrVaEqXIvqfy7tt05p9nlx2YaJe/F+OmANrx8cQPNgP3hrR/xallARnZmRAH+rSEIZGKE7
	1VOr3ejBAfh206lruoQoBx1oleE5fCG8eavZHjyA==
X-Gm-Gg: ASbGncuchN7LXzzdztgR/yuLEjarMIsqXQ9Sdeq3NZIVTTp00KZqBof9tn0RT2k2QGd
	wqpfgOx6TzqXUgHvWfkUaRssA4/s8U5R/D/HXe4lC5B+JSHFHH0s7FQcyLXq3yakGBkt9bhXLpu
	YmHkFJ5Cv610MgqVZLkKejOXnt2dorwkhUwZAj5pjnIXCBthLG7SVQyVkQL8MMKaQ8rmEK+LdZl
	kfha1HYcgLF6n9HQPLokOckAQXoKiVH/ZAujcA8gMegCp1sGcN4ECu01+ng268u6dL+gAk+9uGf
	4xJ1dOaV/3AcLfA7j/WSBXYgaDkYKpB9DQ6q4FRce+iz0Dn149fD
X-Google-Smtp-Source: AGHT+IHk3rKIVw3xzN+NcT/1jnN7TTEd2BEkiVLbP8IFN0cXRTvNB5nEIsZoYv+ZdmtXYxpnfUvrZA==
X-Received: by 2002:a17:903:1cf:b0:223:2630:6b82 with SMTP id d9443c01a7336-2242887fe22mr25579105ad.10.1741309945056;
        Thu, 06 Mar 2025 17:12:25 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:24 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 3/4] virtio-net: Map NAPIs to queues
Date: Fri,  7 Mar 2025 01:12:11 +0000
Message-ID: <20250307011215.266806-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps. Note that the netif_queue_set_napi
currently requires RTNL, so care must be taken to ensure RTNL is held on
paths where this API might be reached.

The paths in the driver where this API can be reached appear to be:

  - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
  - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
    an ethtool ioctl or via XSK - neither path requires a driver change.
  - power management paths (which call open and close), which have been
    updated to hold/release RTNL.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e578885c1093..7bd63a677123 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2823,13 +2823,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 
 static void virtnet_napi_enable(struct receive_queue *rq)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	int qidx = vq2rxq(rq->vq);
+
 	virtnet_napi_do_enable(rq->vq, &rq->napi);
+	netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
 }
 
 static void virtnet_napi_tx_enable(struct send_queue *sq)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
 	if (!napi->weight)
 		return;
@@ -2843,20 +2848,28 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	}
 
 	virtnet_napi_do_enable(sq->vq, napi);
+	netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
 }
 
 static void virtnet_napi_tx_disable(struct send_queue *sq)
 {
+	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
-	if (napi->weight)
+	if (napi->weight) {
+		netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
 		napi_disable(napi);
+	}
 }
 
 static void virtnet_napi_disable(struct receive_queue *rq)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct napi_struct *napi = &rq->napi;
+	int qidx = vq2rxq(rq->vq);
 
+	netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(napi);
 }
 
@@ -2870,9 +2883,23 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		virtnet_napi_disable(rq);
+		/*
+		 * When queue API support is added in the future and the call
+		 * below becomes napi_disable_locked, this driver will need to
+		 * be refactored.
+		 *
+		 * One possible solution would be to:
+		 *   - cancel refill_work with cancel_delayed_work (note:
+		 *     non-sync)
+		 *   - cancel refill_work with cancel_delayed_work_sync in
+		 *     virtnet_remove after the netdev is unregistered
+		 *   - wrap all of the work in a lock (perhaps the netdev
+		 *     instance lock)
+		 *   - check netif_running() and return early to avoid a race
+		 */
+		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq);
+		virtnet_napi_do_enable(rq->vq, &rq->napi);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -5650,8 +5677,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
-	if (netif_running(vi->dev))
+	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		virtnet_close(vi->dev);
+		rtnl_unlock();
+	}
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5671,7 +5701,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		err = virtnet_open(vi->dev);
+		rtnl_unlock();
 		if (err)
 			return err;
 	}
-- 
2.45.2


