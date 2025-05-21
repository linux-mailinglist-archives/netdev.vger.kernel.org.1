Return-Path: <netdev+bounces-192219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF3ABEF9B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC67A4594
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E323ED5A;
	Wed, 21 May 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aC9rS4WW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9723E324
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819372; cv=none; b=qSMcHQsisfyZsLiCeATbLdSy301nNxktGRzpKArveRUy/72YS6ulBsWd0Cpvj8PrVeYXIrF5Y6eAO+2AJb9pkHtQB00wKtZ3dGQavxpJjMHPYyt381CmLOq05G2GR/uugnAuQA95h2CVr0x9AqTEICE9HzVuElZKL1ajg4/+AeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819372; c=relaxed/simple;
	bh=VluP8qpCkS3H4WO+0xV1NzMW93mtebEWW0WnxKY06kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+mxnBUVOunbaAkRFme73x9R7y1h08+ywUYG3ORIgr1Cxmm0tEJYsKgZuNHJ851D/5ry/AUDAnrPHBvaspqRbcuUbD0MUk9SD/koKhC+L97AqKgEqqiwuyGLmuQK4X9w0wMsQkhPg8mnq3XlDNBGUoC84wvg5HiVG01PfVOvdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aC9rS4WW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCjXdTR4Wx9dhjp6rerToyVYaVci27rrR2sB2aTajX8=;
	b=aC9rS4WWnjBtRKR68/VN7kuj7UKlm09XP/xuFMxa8+u3YI/Z2sE8IE+LlJTcSMDLe5ZG0G
	oGyQIq7RQZ4eMDBJnze6oRSq5KpEV6E1m1fvfA7pbuROvCpPKAt2xbcmAVT+B0AZ0r3ghj
	Ke5glIeAYIZdGr1xIu67HV2iFVX5tgA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-HUAiizX9PKqv0gXXtfkSXQ-1; Wed,
 21 May 2025 05:22:46 -0400
X-MC-Unique: HUAiizX9PKqv0gXXtfkSXQ-1
X-Mimecast-MFC-AGG-ID: HUAiizX9PKqv0gXXtfkSXQ_1747819365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43E2C195608A;
	Wed, 21 May 2025 09:22:45 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62927195608F;
	Wed, 21 May 2025 09:22:43 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v2 2/3] virtio_net: Cleanup '2+MAX_SKB_FRAGS'
Date: Wed, 21 May 2025 11:22:35 +0200
Message-ID: <20250521092236.661410-3-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-1-lvivier@redhat.com>
References: <20250521092236.661410-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Improve consistency by using everywhere it is needed
'MAX_SKB_FRAGS + 2' rather than '2+MAX_SKB_FRAGS' or
'2 + MAX_SKB_FRAGS'.

No functional change.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..ff4160243538 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1084,7 +1084,7 @@ static bool tx_may_stop(struct virtnet_info *vi,
 	 * Since most packets only take 1 or 2 ring slots, stopping the queue
 	 * early means 16 slots are typically wasted.
 	 */
-	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
+	if (sq->vq->num_free < MAX_SKB_FRAGS + 2) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
 
 		netif_tx_stop_queue(txq);
@@ -1116,7 +1116,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
 			free_old_xmit(sq, txq, false);
-			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
+			if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
 				netif_start_subqueue(dev, qnum);
 				u64_stats_update_begin(&sq->stats.syncp);
 				u64_stats_inc(&sq->stats.wake);
@@ -2998,7 +2998,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 			free_old_xmit(sq, txq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
-		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
 			if (netif_tx_queue_stopped(txq)) {
 				u64_stats_update_begin(&sq->stats.syncp);
 				u64_stats_inc(&sq->stats.wake);
@@ -3195,7 +3195,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	else
 		free_old_xmit(sq, txq, !!budget);
 
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+	if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
 		if (netif_tx_queue_stopped(txq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			u64_stats_inc(&sq->stats.wake);
-- 
2.49.0


