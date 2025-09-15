Return-Path: <netdev+bounces-222899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A9B56E6B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C811899FA9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A32367D7;
	Mon, 15 Sep 2025 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM20zokM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413422E004
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904449; cv=none; b=cacHUcb7U60BLolNyA9CVAhawcmNOgJl2I3Uu3XPU0zn8viCZJ+1FaNzursevq3yp1MRD4z9Fyld1+tRrKHm3Y/DDJ4DLYxGhrX3Q1YkGmsbHP+DT8Hh5rBaRKqnxmZjfsOGgVGIvxknBAPlza4fpnw9qfF8YM8d4Bl0UCSA51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904449; c=relaxed/simple;
	bh=8GJVW/zsmNTckR6s7s8uhqoZVkSUSxkac/V9wVNeGFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3CJ06NNd2svQZ7vu3Gvq4f2E29PE83Ln2Es56qnvD6FDfkENXxQnfefAUZgnKfSt6zFGa/5n8SqOZHiUosz81l/vAvVbfmpaxXsxwxH4+mLsFXMPsMlLAMyISBiF3PZXp1cAX0CPeQawwJ60KVXlTtubbdtQdF41e3AbmvVSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MM20zokM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757904447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/o3/NdZm8Bg1E0IxrkcNGdZEp1mb4kyWRa75oZhvTM=;
	b=MM20zokMCkfVMcsX9l2o7PV1AH2OUDQ7ea3PN+0JOIhRwEGJ529wMno+9BB1sAFsnJaKnQ
	tK/YLd3SAwHxv3twM9a6JxAo5XihKEYjWp+eBI4eBvkaqOGWnNIhRu38VlIqnq+3pxADAJ
	lYnmj+1xvzjbucylSa+hNTroGvB51B4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-t-cEfNWgOFSH9cAcD-wbpQ-1; Sun,
 14 Sep 2025 22:47:21 -0400
X-MC-Unique: t-cEfNWgOFSH9cAcD-wbpQ-1
X-Mimecast-MFC-AGG-ID: t-cEfNWgOFSH9cAcD-wbpQ_1757904440
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44DF418004D4;
	Mon, 15 Sep 2025 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E0801800446;
	Mon, 15 Sep 2025 02:47:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: jonah.palmer@oracle.com,
	kuba@kernel.org,
	jon@nutanix.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net V2 2/2] vhost-net: correctly flush batched packet before enabling notification
Date: Mon, 15 Sep 2025 10:47:03 +0800
Message-ID: <20250915024703.2206-2-jasowang@redhat.com>
In-Reply-To: <20250915024703.2206-1-jasowang@redhat.com>
References: <20250915024703.2206-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is
spotted. This will bring side effects as the new logic would be reused
for several other error conditions.

One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
might return -EAGAIN and exit the loop and see there's still available
buffers, so it will queue the tx work again until userspace feed the
IOTLB entry correctly. This will slowdown the tx processing and
trigger the TX watchdog in the guest as reported in
https://lkml.org/lkml/2025/9/10/1596.

Fixing this via partially reverting 8c2e6b26ffe2 and sticking the
notification enabling logic inside the loop when nothing new is
spotted and flush the batched before.

Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Tweak the commit log
- Typo fixes
---
 drivers/vhost/net.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 16e39f3ab956..3611b7537932 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int err;
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
-	bool busyloop_intr;
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 
 	do {
-		busyloop_intr = false;
+		bool busyloop_intr = false;
+
 		if (nvq->done_idx == VHOST_NET_BATCH)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
@@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			/* Kicks are disabled at this point, break loop and
-			 * process any remaining batched packets. Queue will
-			 * be re-enabled afterwards.
+			/* Flush batched packets before enabling
+			 * virqtueue notification to reduce
+			 * unnecssary virtqueue kicks.
 			 */
+			vhost_tx_batch(net, nvq, sock, &msg);
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev,
+								vq))) {
+				vhost_disable_notify(&net->dev, vq);
+				continue;
+			}
 			break;
 		}
 
@@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		++nvq->done_idx;
 	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
 
-	/* Kicks are still disabled, dispatch any remaining batched msgs. */
 	vhost_tx_batch(net, nvq, sock, &msg);
-
-	if (unlikely(busyloop_intr))
-		/* If interrupted while doing busy polling, requeue the
-		 * handler to be fair handle_rx as well as other tasks
-		 * waiting on cpu.
-		 */
-		vhost_poll_queue(&vq->poll);
-	else
-		/* All of our work has been completed; however, before
-		 * leaving the TX handler, do one last check for work,
-		 * and requeue handler if necessary. If there is no work,
-		 * queue will be reenabled.
-		 */
-		vhost_net_busy_poll_try_queue(net, vq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
-- 
2.34.1


