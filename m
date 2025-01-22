Return-Path: <netdev+bounces-160195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB65DA18BD5
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA3F163584
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DA31B043D;
	Wed, 22 Jan 2025 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxwuzoYe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E71AF0C9
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526605; cv=none; b=KNLBAiqgNKEiqarc1PQNVPGYMSBdLMnXq+owkCuUHaoA8z6f3xdu9gEjNgCNN4P63Ncgb2Kf2AQNUhwf15KZOLwgazFurmJfVxnqgF8lJMUujVfUkdSnltxNhZHOz2+x0K5ZngcM2HRB9wCzKrf80FlJiC5Hetaye+YVhXR3cXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526605; c=relaxed/simple;
	bh=GZGUwVzWf5+5sjzsGJcUxmWjuTb6BhXtQolSlxaJT00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW+wS9NnA1G+qvuZXYjHUO8iI28kQRwcfV5hkXfH3lYeIDIptmIR2rMfktaSnU122aM2SL7TfF4u/BWAV4wnvuXzbSqbBYe9tIgG41sphcBP6KtGX/jLbxGN/Y7xKdXmL5NHlL308cni+SOH9Sp66AuMqg1sjV4i5v8PFyylh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxwuzoYe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TypPk55BtLKceg++bY0mZyDDDIxWVaP+cjWBoSEYbfM=;
	b=CxwuzoYeSW8FJXcQqJiHuuV3GFAOaBM+VEoB9z81/gtF6w66VH735PYxLlduTTJBsK0DYe
	GBC7w/5/6pBy2Gz5MhpBlXMfW682KQI5TUSpHRQdV1RS73jJvBIRij6tHbMvyi+ITW5+I2
	0i8nVARWqKAwj0ywCy4kEuMetRjOnZ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-MofZaBIbNiyjfo_FPljYyg-1; Wed,
 22 Jan 2025 01:16:38 -0500
X-MC-Unique: MofZaBIbNiyjfo_FPljYyg-1
X-Mimecast-MFC-AGG-ID: MofZaBIbNiyjfo_FPljYyg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7007B19560B7;
	Wed, 22 Jan 2025 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.209])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97BBA195608A;
	Wed, 22 Jan 2025 06:16:29 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RFC 2/2] virtio-net: free old xmit skbs only in NAPI
Date: Wed, 22 Jan 2025 14:16:00 +0800
Message-ID: <20250122061600.16781-3-jasowang@redhat.com>
In-Reply-To: <20250122061600.16781-1-jasowang@redhat.com>
References: <20250122061600.16781-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When NAPI mode is enabled, we try to free old transmited packets
before sending a packet. This has several side effects:

- transmitted packets need to be freed before sending a packet, this
  introduces delay and increases the average packets transmit time.
- more time in hold the TX lock that causes more TX lock contention
  with the TX NAPI

This would be more noticeable when using a fast device like
vhost-user/DPDK. So this patch tries to avoid those issues by not
cleaning transmitted packets in start_xmit() when TX NAPI is
enabled. Notification will be disabled at the beginning of the
start_xmit() but we can't enable delayed notification after TX is
stopped. Instead, the delayed notification needs to be enabled if we
need to kick the virtqueue.

Performance numbers:

1) pktgen_sample03_burst_single_flow.sh (burst 256) + testpmd (rxonly)
   on the host:

- When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
  increased 62% from 6.45 Mpps to 10.5 Mpps; packed virtqueue PPS were
  increased 60% from 7.8 Mpps to 12.5 Mpps.
- When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
  were increased 25% from 6.15 Mpps to 7.7 Mpps; packed virtqueue PPS
  were increased 50.6% from 8.3Mpps to 12.5 Mpps.

2) Netperf:

- Netperf in guest + vhost-net/TAP on the host doesn't show obvious
  differences.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2f6c3dc68ba0..3d5c44546dc1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3271,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 	bool kick;
 
-	/* Free up any pending old buffers before queueing new ones. */
-	do {
-		if (use_napi)
-			virtqueue_disable_cb(sq->vq);
-
+	if (!use_napi)
 		free_old_xmit(sq, txq, false);
-
-	} while (use_napi && !xmit_more &&
-	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
+	else
+		virtqueue_disable_cb(sq->vq);
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
@@ -3305,7 +3300,18 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset_ct(skb);
 	}
 
-	check_sq_full_and_disable(vi, dev, sq);
+	if (tx_may_stop(vi, dev, sq) && !use_napi &&
+	    unlikely(virtqueue_enable_cb_delayed(sq->vq))) {
+		/* More just got used, free them then recheck. */
+		free_old_xmit(sq, txq, false);
+		if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
+			netif_start_subqueue(dev, qnum);
+			u64_stats_update_begin(&sq->stats.syncp);
+			u64_stats_inc(&sq->stats.wake);
+			u64_stats_update_end(&sq->stats.syncp);
+			virtqueue_disable_cb(sq->vq);
+		}
+	}
 
 	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
 			  !xmit_more || netif_xmit_stopped(txq);
@@ -3317,6 +3323,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+	if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
+		virtqueue_napi_schedule(&sq->napi, sq->vq);
+
 	return NETDEV_TX_OK;
 }
 
-- 
2.34.1


