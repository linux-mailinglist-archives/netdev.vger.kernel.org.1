Return-Path: <netdev+bounces-192220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F94ABEF92
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C3D1BA82DC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C0241139;
	Wed, 21 May 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXVjkvtn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82705241114
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819373; cv=none; b=FZ/FbALyzM5Pg7XZ9l3qvpju+dF0d466o/Rl01Lp3PIxHoH5JFv+NBS5/4SeIhPRprGHFtRr7vtuzVF9RtUx++QPTSIxEY9vHp6ktFaFDBEQRH/W/LoWQemuKwmLyKShJ6bF9k8I0S1XX/hp2BqHsCkym9qSWbIz8dpsG+5XUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819373; c=relaxed/simple;
	bh=jlqjkVr9S+fhQc/GQZSnUfDxqzxMGUWnuuXyXkSebJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx2eK1Y/p6Cf7xnUhsXrNbrBjk1Nj05p5NjYKQbU5IvI/fJoKpOEiPFAkoLTV4P3MQfW6ycBv8P1coLOYSzcawlr3Q10+w4jp4pHVQuhRxgljYbOe5OfWTceASVOGxo7wVPHlpIpRcJNgob0aKwKIpt4IFvZ7tzz6AzSVqaL2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXVjkvtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S01OyqRbOfmEw1jQdPVa38jcFNsvoKjej6vSXSbTUcg=;
	b=NXVjkvtnxqSR+Kw1oGBnIjgrO+XduolfRmeAeENXWdAc7UlS8DeF21wUKcrB893aJEIMrt
	S31FMPByLHzwRdXAqpCjdF7lIyKI+uoSm/pZ2Ep5qnUeVWvSfcjoynG4yBulIinHtQD1Lq
	/t0eq1zrZB/FLA9lTuXVdtrfUA7+PKs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-cPZKKRWmO-W7Nf7TD4DkwA-1; Wed,
 21 May 2025 05:22:48 -0400
X-MC-Unique: cPZKKRWmO-W7Nf7TD4DkwA-1
X-Mimecast-MFC-AGG-ID: cPZKKRWmO-W7Nf7TD4DkwA_1747819367
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A52161954B17;
	Wed, 21 May 2025 09:22:47 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEE8C1956096;
	Wed, 21 May 2025 09:22:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v2 3/3] virtio_net: Enforce minimum TX ring size for reliability
Date: Wed, 21 May 2025 11:22:36 +0200
Message-ID: <20250521092236.661410-4-lvivier@redhat.com>
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

The `tx_may_stop()` logic stops TX queues if free descriptors
(`sq->vq->num_free`) fall below the threshold of (`MAX_SKB_FRAGS` + 2).
If the total ring size (`ring_num`) is not strictly greater than this
value, queues can become persistently stopped or stop after minimal
use, severely degrading performance.

A single sk_buff transmission typically requires descriptors for:
- The virtio_net_hdr (1 descriptor)
- The sk_buff's linear data (head) (1 descriptor)
- Paged fragments (up to MAX_SKB_FRAGS descriptors)

This patch enforces that the TX ring size ('ring_num') must be strictly
greater than (MAX_SKB_FRAGS + 2). This ensures that the ring is
always large enough to hold at least one maximally-fragmented packet
plus at least one additional slot.

Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ff4160243538..50b851834ae2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 {
 	int qindex, err;
 
+	if (ring_num <= MAX_SKB_FRAGS + 2) {
+		netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
+			   ring_num, MAX_SKB_FRAGS + 2);
+		return -EINVAL;
+	}
+
 	qindex = sq - vi->sq;
 
 	virtnet_tx_pause(vi, sq);
-- 
2.49.0


