Return-Path: <netdev+bounces-135024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A662899BE09
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 05:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEDE282B76
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6B73446;
	Mon, 14 Oct 2024 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cNCnrHu2"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B4487BE
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875566; cv=none; b=E94YyG95VCU+pxDoqqZ/U1eQ55s35ZO9xm+B4qVLxv4sHYzeH8YuvssLM4GX1zeOJL1L9C6sEIU5g+O0LAWnAdeS/GG8AGdK5ECC6qNf1eeCgid8kImndtYieoO4UuGMcMZ50x0glWHIs8HsoSVEvjMWGlWMNk0OhPSPi9N4QxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875566; c=relaxed/simple;
	bh=FUCJ34kAec4ze7MT1I06ed4vudzitxWwNszCM4IE2YM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5fwoFTOguIN7UV/jRM7EvLmZReproo4jL1kQZGaHi99tnxqKfVym7H2/WFMDpTBm1Z1V6YVB9zZhzcmjC11pjTkRyBPDywBxMahq+PP6QLQhM2YAMylzpYYwyytmEt55awncTt8QiJa9wsgcxziSJKdkbMj30/0IwohDsemhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cNCnrHu2; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875556; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kQQJRBTxO945uaJI4oANunCWCNhTnGMwAIxYBSbTKlE=;
	b=cNCnrHu2kdrgs5EQqR7K8NLoqCYxp8nLjVP5+sPxUt7I6zSCOHINufhASYGllJKpYCMEgWvNpIu3A/exiQQ/yLQX9UczEGmEUC+sAX8fGNPb48QevS6mpQUrqEpmfgFDEinhnbwe2GAyfr3SSN292/9z1+RfO7vTIMZpjJ4k3tE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.LEUC_1728875555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	"Si-Wei Liu" <si-wei.liu@oracle.com>
Subject: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Mon, 14 Oct 2024 11:12:30 +0800
Message-Id: <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

When the frag just got a page, then may lead to regression on VM.
Specially if the sysctl net.core.high_order_alloc_disable value is 1,
then the frag always get a page when do refill.

Which could see reliable crashes or scp failure (scp a file 100M in size
to VM):

The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
of a new frag. When the frag size is larger than PAGE_SIZE,
everything is fine. However, if the frag is only one page and the
total size of the buffer and virtnet_rq_dma is larger than one page, an
overflow may occur.

Here, when the frag size is not enough, we reduce the buffer len to fix
this problem.

Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f8131f92a392..59a99bbaf852 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -926,9 +926,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	void *buf, *head;
 	dma_addr_t addr;
 
-	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
-		return NULL;
-
 	head = page_address(alloc_frag->page);
 
 	if (rq->do_dma) {
@@ -2423,6 +2420,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
+	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
+		return -ENOMEM;
+
 	buf = virtnet_rq_alloc(rq, len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
@@ -2525,6 +2525,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
 
+	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
+		return -ENOMEM;
+
+	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
+		len -= sizeof(struct virtnet_rq_dma);
+
 	buf = virtnet_rq_alloc(rq, len + room, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
-- 
2.32.0.3.g01195cf9f


