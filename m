Return-Path: <netdev+bounces-224659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1FB879D5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 03:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5AC7E340C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E2215789;
	Fri, 19 Sep 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ep1TzzB7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CD34BA29
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245702; cv=none; b=cUWasaLh93vWfhHI11KArMoZLIRffdjQ5L4mSO5M1MWy92nUvcR2+egFNeZjEezw5OL1H5WJ6LZJms0312WzzMGEzkZrc+TW6PIwBMXm4IHdXnB5QLp9rvUYNs0+IyoGLmMbrh8EkC4N26iiGNOi8ZUXG/W+QNNEEV9Z5aWsIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245702; c=relaxed/simple;
	bh=lJYEuAf6VDWdCErnVrRsVKPl4GfmP3hnp2qqY2A30ps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GbhywEFZkUw6+j6PESTqRMZAPcwW3VibDrQbIbdxnO0KAPK7YYJZ4DQg7vMX4nyX0EAMz9Xr9ZaOwyU+hXYr9GtsLXWI9RRx5pd6wv7F/Ft9YTWCKPUmLhXrYZL5bAWwZdVwkWmOk5T6U7nDbDU63HGjXl7T1P4zd/h0r+i0GPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ep1TzzB7; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758245691; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NsFGh+9mw+WdnZ/caHT4763xAMzma/QFNrbt/6FOTkk=;
	b=Ep1TzzB7F3N843z5e40jcDkVKnw4QDdsGBe3PyjTOkHCO43JBT0GvHL1FgbYPYfa2EWEodAPoyr0JR1u3mBiYXQhpfX5Pw1Rvj2oX/MOY6mdQKN7Z6RhIGmloBsJbzYjrmRHKamLQWqzRijGg8nZpGnXpmwyL9p50kcxgRaMRMw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WoHsaiy_1758245691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 09:34:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Date: Fri, 19 Sep 2025 09:34:50 +0800
Message-Id: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7426b57cb775
Content-Transfer-Encoding: 8bit

The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
checksummed packets handling") is to record the flags in advance, as
their value may be overwritten in the XDP case. However, the flags
recorded under big mode are incorrect, because in big mode, the passed
buf does not point to the rx buffer, but rather to the page of the
submitted buffer. This commit fixes this issue.

For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
buf address when unmapping for small packets") fixed it.

Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84..6e6e74390955 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	 */
 	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 
-	if (vi->mergeable_rx_bufs)
+	if (vi->mergeable_rx_bufs) {
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
-	else if (vi->big_packets)
+	} else if (vi->big_packets) {
+		void *p;
+
+		p = page_address((struct page *)buf);
+		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
+
 		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
+	} else {
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+	}
 
 	if (unlikely(!skb))
 		return;
-- 
2.32.0.3.g01195cf9f


