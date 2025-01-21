Return-Path: <netdev+bounces-160122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2EA18584
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBFF169E24
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4E1F8906;
	Tue, 21 Jan 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MBzaNvjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD051F666C
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486674; cv=none; b=bHtDG3BZefKud3k2Dk5nqsQczjAlvRNxhFix8Ubsc4NdBPSvKCG9n05gF7/muD+JY3ZxS4BAoLXEki8xg0J2E3ubYIazmatSmwWLZqGcjCvVoagzg+DK5UD13pMacRnwoJME2jR370NWw6CO1ndNR+RToAC7AShRrmANGAlvsfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486674; c=relaxed/simple;
	bh=CCW7kggp+rYbKpVhb0njIkNRisnJGwdMk+Hd84d4x2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERzkvF/uhNeqDJ8/Wo+SxlGT3+CjgRRSWpX0C5r4g04ND//EPiICMarJRy3RKF2AFuvWHB6RQpyGc3SnDQRPaKKVRsMX9yYeMP6lWAPGZGALYrFheK+4FKlb6fqv9kfDvw3JCP25sTNDRWfPha18bvOAnmXMjC7id1hwpinAgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MBzaNvjs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso8325077a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486672; x=1738091472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIxZmc2dYAqFea8fzwYrgwOnSbwHFqsyPk6MUVa0VxU=;
        b=MBzaNvjse7oevDYEBFWFKxZbDmgGUTUeZuKqKDYYq6jYzXhWxsXrb7XPPXxhnhTtKE
         9sirjjKXjzShNZ3fJBquEHmrtN3LKamzoC0YboN1lcadLa21ntzmmmoL/W7hzWwutDca
         wU19tnULStfkBwK7iTMX/kWcBxHKbQNAML64E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486672; x=1738091472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIxZmc2dYAqFea8fzwYrgwOnSbwHFqsyPk6MUVa0VxU=;
        b=DFFLW58y3r+reFocPOA/3BOT2B2jetd+/PteELueIyaPr4N6eR+UHeFW8ajUhMQBe3
         RqMSbsrcwx3sZKbOxyG5qSjmwCzkYFNZGi5lH0B+6UBT3WTjW8/wZIRqsqTkRDfHA3JL
         9r1N9oh0ndd8WI36Wi398PCboRY+l1hBEl4q/h4m0HSsKwhk0OM/xpPsb5LZBEO0iKuy
         4qrh5krso4JvlhotOXhExb5RlevA5fB2hvP+/FT7gTVt2d5ODiLflGfToZxwW6rHEh6U
         5qFOx/ZpSWb1qDZX+1vDW6ewFcGKrgdE5hioaDp38ooqrRC3dQfKmgeMUDWxNFEnJHAc
         5KeQ==
X-Gm-Message-State: AOJu0YxFLE0ApAgcC+AkPLVcc/vaEQ1Bf79QkwSvw/ctDKxXqDpIaXCw
	BbeWwOXWgAV3uoIO9avIoErz80P6C9GmSROcCKvXb9ZxRMQPAhMEePfwsVPcTULWQjJYTDm0oZl
	wTpNvK3k+HSnT3ypv0ltI329WYhUCj6U7YJwzVwgomra0DH8KDdVBNJ665evxAaosjqkvkMOFNx
	JDuCCeTb7ANv4xWlhPneNkKsWhrb556LMJeJc=
X-Gm-Gg: ASbGncsgcjk9+n0ngA7OwT4t0ep33nL72nIZYw61m6ukMyiG3diCmDn1b1HWGjAxRId
	oEk15891fkGBLQM3eghnXTZIf6Gtw1odfAItw5z310er4o7K/lUlzKO1klPLBW7hDm3/nRKmuva
	6q+KLaGdkz1c2f8c5CudXjTCPEje9c4Ld4B6sURjfNsDjEALGud1UErKxGknWCU9NN7SL3fT5/T
	UHoBxdvzGOPOuFlxIzVr0I4yWk+121eXP48Q4Jcq+pGQU+2jrtODO2nEeOUpTd//ENdLBip1l0Y
	yA==
X-Google-Smtp-Source: AGHT+IFmMAsVqWPTr/+MdaRMifAEOsKB5cFMykGXnqvqzynVvQlUx7VWgc1M158q6rlxSpFG7RmfQw==
X-Received: by 2002:a17:90b:5206:b0:2f4:f7f8:fc8b with SMTP id 98e67ed59e1d1-2f782d4ed77mr26908949a91.27.1737486672019;
        Tue, 21 Jan 2025 11:11:12 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:11 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 3/4] virtio_net: Map NAPIs to queues
Date: Tue, 21 Jan 2025 19:10:43 +0000
Message-Id: <20250121191047.269844-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
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
 rfcv3:
   - Eliminated XDP checks; NAPIs will always be mapped to RX queues, as
     Gerhard Engleder suggested.

 v2:
   - Eliminate RTNL code paths using the API Jakub introduced in patch 1
     of this v2.
   - Added virtnet_napi_disable to reduce code duplication as
     suggested by Jason Wang.

 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cff18c66b54a..c120cb2106c0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2805,7 +2805,11 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 
 static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+
 	virtnet_napi_do_enable(vq, napi);
+
+	netif_queue_set_napi(vi->dev, vq2rxq(vq), NETDEV_QUEUE_TYPE_RX, napi);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
@@ -2826,6 +2830,16 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 	virtnet_napi_do_enable(vq, napi);
 }
 
+static void virtnet_napi_disable(struct virtqueue *vq,
+				 struct napi_struct *napi)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+
+	netif_queue_set_napi(vi->dev, vq2rxq(vq), NETDEV_QUEUE_TYPE_RX, NULL);
+
+	napi_disable(napi);
+}
+
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
 {
 	if (napi->weight)
@@ -2842,7 +2856,8 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -3042,7 +3057,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3313,7 +3328,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -5932,7 +5947,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


