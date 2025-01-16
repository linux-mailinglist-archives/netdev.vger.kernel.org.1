Return-Path: <netdev+bounces-158773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C8A132D4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2E2188A6AA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674A199FAF;
	Thu, 16 Jan 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="je22sd/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34518D65F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006812; cv=none; b=UDr+CryWNF5GdcN/DuAqivqpXlGWe/ohaAa/8PrHY4u739ER/8Bbgy/xI5uIkUPqKvQIaeiXB8deMxY1LmJ4x0sPcwAG21y1CdfIMbfLcRMpbrXUW+nxGVYWYnG4U5sHkC7HBzk0d1r1oomT5vh+bkwBqYaevjD5MX2fXZ5DXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006812; c=relaxed/simple;
	bh=yJvHEqdHpoC28W6nXw4OZ31j2d6z3msHRmx43NIpiUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkHR2iKOpiposuJJ5baJCkB+NqNQjAXFvJ0gRYM290A8OCV5ZMel015ykDTKVowaqNxNnTGID50S6885yQ7ypwZThwZzNYMLShr42EGjBjWNyYJYHQX6BLj1FuQEXEO2ORPSFMn/u19ZB8ixKZYOSt2vmhzffYuOHMsfyFiY2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=je22sd/f; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f8263ae0so7859875ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006810; x=1737611610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcY+kSjeMMu9asV4FI3bEFO3nH1Uxd3geQomjlGuQlg=;
        b=je22sd/fJcZhtwphfQVNewEqm2VkNwWJJMpSKRwXvR9DgY62lYvJvA+H/L5m+spZ7A
         SHs1miH+OVjFyDAKPenomDBdEQ/MOJxFFufjAuWh8BO5GyFfvq4PUgF9M7PoHlbpbnts
         Fosczt5RJ/tn3BtaL3xdsPJNBprVgDJvk6ios=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006810; x=1737611610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcY+kSjeMMu9asV4FI3bEFO3nH1Uxd3geQomjlGuQlg=;
        b=KXJ9L8s1HRveTv/SvCnNIdzD4M68HZRAPPtxv7MG4YoOTg4PlFgxq++G7PyW3rb966
         J5rQ6FweZsiHtHgNn5mYnhIY8TLZ10NcdgZDtDJr194vjPaueRWdBklOnoNkGVE6f7yj
         BrBoYy8V3wUoft+xJAPxpOXWlTyfHWnlTiUtBrXHtMoBlG55o1/krPiYT+q1+zdGqQc+
         YqROufyzUKH5ul+zDbO2K88jVM2jPX6gHeykF6fe2gnZ5S6Axu0ZiPZU4DvrQbbT+44+
         xzYc0iwVb/zsw6mRZRS10OPNq4pYM4lbdwOg5+eL4il3ki7t0gKAMJvVF7AZRx2ZKSwy
         oCyA==
X-Gm-Message-State: AOJu0YwzdFi8gRsZoFZcG4tM7Rqo+eysMy6EtJFitezWlZMhHHmXjiYJ
	DrybG8TA7amYTosbUrOpqQXlPvlVZc1r6cIbdulK2lSUjZZDGRaqrYg6HjRRTN8N/aLvXKXVyxE
	UWY7ZJxda59Ey00VPa8rjDp4YK9Sdu+OF+pgNilR4qtH3Mvr1vpxd3k93IrgkMskb6eQ0EGrATn
	xa093MlepwC9N1oFEzerawFc0XUR4apXUqdIQ=
X-Gm-Gg: ASbGncto8git5E9z3Tui8kV+6dVXaMBRjwKGpC/wqmEDC/dTykRTw34VzyYd4xR2Lj0
	y2JSVanwsi4/aJr3GoG8SsZuTFXucrFmgqkmCIU85Oge6ajNNh3hDlXP6nFq7DlBbYUlz4UQKI5
	eSxq1mGxWaOdo+7x96sbJAljalB101+Cg2whdHdBcSxAfN3Xd1FKKbUOL71CaciP6q3rLKh1g2y
	oHPXA9ybvyXkL+Puzerz2+s13IjA4RDzsMDBs6AzHXC8XeEUT7Jv/2fdxc9EaVC
X-Google-Smtp-Source: AGHT+IFGBkkanzsZABlx+kwVbhQWzWrd9fcJLyyqg9XrcMim/tp4HH707mqDKYrn2ErGZPkhsWUDLA==
X-Received: by 2002:a17:903:2311:b0:210:fce4:11ec with SMTP id d9443c01a7336-21a83f42687mr507328185ad.1.1737006809538;
        Wed, 15 Jan 2025 21:53:29 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:29 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
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
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Date: Thu, 16 Jan 2025 05:52:58 +0000
Message-Id: <20250116055302.14308-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116055302.14308-1-jdamato@fastly.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps.

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
 v2:
   - Eliminate RTNL code paths using the API Jakub introduced in patch 1
     of this v2.
   - Added virtnet_napi_disable to reduce code duplication as
     suggested by Jason Wang.

 drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cff18c66b54a..c6fda756dd07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 	local_bh_enable();
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_enable(struct virtqueue *vq,
+				struct napi_struct *napi)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	int q = vq2rxq(vq);
+	u16 curr_qs;
+
 	virtnet_napi_do_enable(vq, napi);
+
+	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
+	if (!vi->xdp_enabled || q < curr_qs)
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
@@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 	virtnet_napi_do_enable(vq, napi);
 }
 
+static void virtnet_napi_disable(struct virtqueue *vq,
+				 struct napi_struct *napi)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int q = vq2rxq(vq);
+	u16 curr_qs;
+
+	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
+	if (!vi->xdp_enabled || q < curr_qs)
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
+
+	napi_disable(napi);
+}
+
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
 {
 	if (napi->weight)
@@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
+			virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].napi);
 			virtnet_napi_tx_disable(&vi->sq[i].napi);
 		}
 	}
-- 
2.25.1


