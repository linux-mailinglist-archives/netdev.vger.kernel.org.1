Return-Path: <netdev+bounces-114931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C91944B45
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E951C2460F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5F19E7E0;
	Thu,  1 Aug 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R8YBDqqd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626221A00F7
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515271; cv=none; b=Dopz/bNMf0aEQRcfHlsqr/aUfthEbTdekOZIZ5L27Y8jSJuY7TtvQcPOPwC1cqcNWr4U6dYiGqyopA8ZKuPqWZvwf9Vg3kPxcE1v+u0eeu6Pgz9qiB/9qro34ndYGSBE5jass7xwO8yGJaaZhPUMeTKpGQYblBo+a9w5PdHnwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515271; c=relaxed/simple;
	bh=pxAMgUl6RpgEzddwp0OuSLVZnmbZKSASw1sE3RPnW5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TVuwoWEruQzZBTS969RRs31xx4gFBi9ZfWMTm3SF9NIpPG8Uj/dDK3fjvA/LesmSZ4g8Zls+h6ZyhKeWZ0+0iNxcjyNvXwxZGDbcw/rcx602q54izeQiFcvQDVJCby0P8zNGXLp0gYYnswUPuqF6yaXskjMD6vNwGTFcPdrY4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R8YBDqqd; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722515261; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nmlezCt3y4sHPiSBV8DTZAgWvKS3ESvpRmOQCDwrnNQ=;
	b=R8YBDqqd2if+ovCqsGIZ2VJJixark+MR41xZCMJWolQTxyZF1oZLAWzZrKVgHxMjF4VqSv2ysqvXOZsszEy6hy54W4uRZz4dG8e70Dbm9mIiRygueM7hmv6oSadROSXgNEYtMugbNC3j0Qy8YibOmsxjiVvkoWetpD4sOCzq6Jo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtI8bF_1722515260;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtI8bF_1722515260)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 20:27:41 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v3 1/2] virtio-net: check feature before configuring the vq coalescing command
Date: Thu,  1 Aug 2024 20:27:38 +0800
Message-Id: <20240801122739.49008-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240801122739.49008-1-hengqi@linux.alibaba.com>
References: <20240801122739.49008-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio spec says:

	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.

So we add the feature negotiation check to
virtnet_send_{r,t}x_ctrl_coal_vq_cmd as a basis for the next bugfix patch.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v2->v3:
  - Break out the feature check and the fix into separate patches.

 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..b1176be8fcfd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 {
 	int err;
 
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
 					    max_usecs, max_packets);
 	if (err)
@@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 {
 	int err;
 
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
 					    max_usecs, max_packets);
 	if (err)
-- 
2.32.0.3.g01195cf9f


