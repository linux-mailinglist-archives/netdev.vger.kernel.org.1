Return-Path: <netdev+bounces-170401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7CA48845
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235201890B9B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E041F26F443;
	Thu, 27 Feb 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bHtY1XH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5526E150
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682248; cv=none; b=jNLtOGyITlTboIjc4hLMbcZGb9SsDfRDJeQ9y2u//Ri41oZ22svDrpXtDPEcfNir1i/0PqdJgTxZyXk2eXOrMZmtz5Dqf5MYaOjDGNOz5sObW/HFpXc80hwWazrRoOIDwWkeDrSQO7U1lh4uSziTpV02aX8788ltyrVQmtF7RI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682248; c=relaxed/simple;
	bh=ruLhp//Dblw3Q1cnTDsehC77vyCvqCtIvwsJ3QV+GLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAJC11byd9C+V6elcn7h4SoBC8epYQ+wt8Ko7e31ZhbvYLRvQj19WNAo2d0ZvahxkzCXKkkqwD1oA1dZaTJ6cWqWK1eNU5Ew5EpQGGc9Dz1rne4ih+Dkdl0+NIepHSDyCU6zr7fP/w1sfzGIk2hxYiY7bevxlB2sNopLef53Lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bHtY1XH8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22359001f1aso23744025ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682246; x=1741287046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urTnWtLOZR1ii67wvyGmGFIgFDC5fRLxfMV5fbOG6tQ=;
        b=bHtY1XH8Ler7KSIYIt1+r11/hhJQ9PTVHZ2HBeaopyd8ttco5eya0Y70mbcMWBCW6L
         AqlN7/gYSbd53g4YnXXhd7/JvIvbGynLYwFzX9s6OdfJkG88JOrmfJsibwhGqFWfRscb
         miVtNn8BfDmHul6oVTU1TZg7ZHjsbwgy+Ce40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682246; x=1741287046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urTnWtLOZR1ii67wvyGmGFIgFDC5fRLxfMV5fbOG6tQ=;
        b=v93tzdgaBBUuZM6EcVWHmhJ8N5uFG/DaSWrGnkzelcxGlYVlSKDozYPncc1AuhrXQR
         E5F8JHpwfA+agpUA03/aD/rmL9GmzrQ3fUJG6Z182NIR4U8X+QZVlX3YsBRAjAjRnmrm
         XZsw9W/3i+BoPjTEVTxZewxbruqUDxr2rN08vPXM53+sqm5ZURPDcpFbvN3ploDXAGT1
         vKvxGAAPs54SIFkWthLR4kuwc5kaf2d2NAXzgK0VDNh4RzU696pkfPoo3+Q99nKpabCF
         9lKu9fGtUo8AS0FvTUFxLcRigc1cDf4bZuO7Cn8KmCLV1n/zqF536vwsJ1bo73r/dhzu
         u0cw==
X-Gm-Message-State: AOJu0Yy0QbU5MgdxheI5f/x2Z8vJ7PJ4WsYlUvC1dJgOYvncMtsU0/Gc
	858dDyxcXqmzoiBgV5qmM2VdMGptnITWN1F9ct/e+5ZZjE4tWTxfbsJYUjbadSQjDmCa3oidnPL
	jTG55wo+BK4KuH2kChQk1+J7EFy2CsEO4BKa9JwzsVHs4NYGh0vfxUBNmvqggSF8QSawWPAR8x+
	pAL7YgBNZqIE+wVWptsg4mjwu1U1UZ1Qgh0FVePQ==
X-Gm-Gg: ASbGncuQYGOrjl1khDrcIpYeFDNZGikALuozIrcyLQbXSoihjWNapGAcfs5QQqVEpLB
	A4R+ftCuyybWcXQ+xYlxbvRAYpaTUfidksloF4ZZSQGxAM7n6oPAe9NaDmn5r4HC/Q/MN2iAGCE
	xeHik6ZF7Ert/UxpJfU+QwkNl9cFeGPw46KBeEZGkIeWvkfJ3bStNNlRQIMCzMGGFTQitbL1Trj
	yTfgt56f6g/wKKX8LE7tDFaHH0wDWshXEW2mgdN5/gVqyf7Ttehe3C9dY36bpvq4u/d80YGWg+Q
	DbuVCy8c8Kuj/6zHVFikEmC8djjDvU2vbg==
X-Google-Smtp-Source: AGHT+IHu5hlvHH5LXXz1OMUSyDQuYBfGMEi0ghDf4USSKQwpy74Ccia4YTH/3ePDByGZSW6VYZTrMg==
X-Received: by 2002:a17:903:32cf:b0:223:6744:bfb7 with SMTP id d9443c01a7336-22368f732c9mr3587465ad.8.1740682245661;
        Thu, 27 Feb 2025 10:50:45 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:45 -0800 (PST)
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
Subject: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Date: Thu, 27 Feb 2025 18:50:13 +0000
Message-ID: <20250227185017.206785-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
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
  - refill_work, which has been updated to hold RTNL.

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
 drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e578885c1093..76dcd65ec0f2 100644
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
 
@@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
+		rtnl_lock();
 		virtnet_napi_disable(rq);
+		rtnl_unlock();
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
+
+		rtnl_lock();
 		virtnet_napi_enable(rq);
+		rtnl_unlock();
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -5650,8 +5669,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
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
@@ -5671,7 +5693,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
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


