Return-Path: <netdev+bounces-191813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2CFABD5E4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1A3A5B8B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FB27E7FD;
	Tue, 20 May 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsefpQsp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE427C864
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739141; cv=none; b=HqWfmvLLfYeMVXmM2sjRlq5NlfACX1r2TocGB+lIvbbBaB/6DLQx5xGrYaNNUdD3ZvyNmDj+AUekd2E6UjV0qk7whiFJrWFl/v4SBs+S7IPM54FgB+YlFBsmOMv62WWZDTx7vyaq3os4bBrHQYFdus2Bmgu29889Ja+l2ij9dds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739141; c=relaxed/simple;
	bh=b+YrCJ42KjHUkvwgT4xR/mxKsHO8cOHl9FN4Vq7fOL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNabZJYrW/84w21wwyeJdUj/3kytfGankuQtH1xRYmA4dC4DU0ZCtVgFlWCmfnl4s6yUvYM+1xJTLa4o7zLY+XEBYl5jxgFdrH6exynpNZkXq/OMsrMDZ98DskLEm6fVbJwoMdwJoCjNmbgn0vk03g28xqDDV3YA0wX4cohtySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsefpQsp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747739138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3L6s3nZuJ4uDKFUqy+XqgUhFnSv9Fk5O3ApL5qopTw=;
	b=KsefpQsp0V25jbLE2/os+ZwpM2Okn5q3/qMU47EOPGIhkSSQlRyTmTkivm2j1soxWx+igv
	UQVZimwZcp3AlDpYv6s1HoQKSK4kHQAzerb8uEAGmr9lW+sz0NOgE2dVKXm7sIGwdLUnWv
	Q1Qz/owv7QzYO7vycXYGdVFSdqX5ANo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-fTA5-6DCO7aER2-un1MXKQ-1; Tue,
 20 May 2025 07:05:36 -0400
X-MC-Unique: fTA5-6DCO7aER2-un1MXKQ-1
X-Mimecast-MFC-AGG-ID: fTA5-6DCO7aER2-un1MXKQ_1747739135
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9369F180034E;
	Tue, 20 May 2025 11:05:35 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B003E19560A3;
	Tue, 20 May 2025 11:05:33 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 2/2] virtio_net: Enforce minimum TX ring size for reliability
Date: Tue, 20 May 2025 13:05:26 +0200
Message-ID: <20250520110526.635507-3-lvivier@redhat.com>
In-Reply-To: <20250520110526.635507-1-lvivier@redhat.com>
References: <20250520110526.635507-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The `tx_may_stop()` logic stops TX queues if free descriptors
(`sq->vq->num_free`) fall below the threshold of (2 + `MAX_SKB_FRAGS`).
If the total ring size (`ring_num`) is not strictly greater than this
value, queues can become persistently stopped or stop after minimal
use, severely degrading performance.

A single sk_buff transmission typically requires descriptors for:
- The virtio_net_hdr (1 descriptor)
- The sk_buff's linear data (head) (1 descriptor)
- Paged fragments (up to MAX_SKB_FRAGS descriptors)

This patch enforces that the TX ring size ('ring_num') must be strictly
greater than (2 + MAX_SKB_FRAGS). This ensures that the ring is
always large enough to hold at least one maximally-fragmented packet
plus at least one additional slot.

Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..866961f368a2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 {
 	int qindex, err;
 
+	if (ring_num <= 2+MAX_SKB_FRAGS) {
+		netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
+			   ring_num, 2+MAX_SKB_FRAGS);
+		return -EINVAL;
+	}
+
 	qindex = sq - vi->sq;
 
 	virtnet_tx_pause(vi, sq);
-- 
2.49.0


