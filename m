Return-Path: <netdev+bounces-101268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C278FDE95
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127EF1F2493F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045BD6E611;
	Thu,  6 Jun 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RPuve9lA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2576E5FD
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654510; cv=none; b=l/P3fZdrNN218H5yV0ictEMz4dktN5GAYhtOXoG/4PGDfFbO5qxtw2BSN/q6BMDMiN7r5Yqzq3D2IPE68lY9/hbru/4LPnwV+oBhckwOf1QVaDdm7S7d3W3X7ouPyxRXTwxdnMo5C409WOFqCZ+hvwd1NwopPi+fPr4ERwIDPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654510; c=relaxed/simple;
	bh=zXnfciQQNb2Lfc05fsXzI/NnV4/1qVXdVVKeIiTQvI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QULROEHYcEoQfxnUakgEiQ+RcWAWSP6V2Rh8Dj+tGlRQiuXxEvKb+MC9UjyUI+zu6aCizrcDtMxNWgXnEZp+UgbHoZEQaZuXSZTh6vqzqIRTFdTx0V8PAkBIQPkO0kDEnuIEzY/K3iZb+DGb6jT4++rFiWqYkTGobyFG6qLhI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RPuve9lA; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717654506; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=g7p9CKsxWqJ+feqirR1b+m5bMzTWg9wmNNIV2XQLW18=;
	b=RPuve9lAKzP39i6/B32QLAn3LynbBl3DJdSKOaYG8jEnxuy+Sq/koO5rXVsZ+wmP/ywcwP0rgBz+mzAuSBrYVcDi6r8TQpSaaQPq5omt5ZVoHGrSGTbVwQGLM44C1cDpLmWh31VoRoePfJfO7AjFseaPY1gYF8vpbynQ62HTJtE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7xKiCT_1717654499;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7xKiCT_1717654499)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 14:15:04 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 3/4] virtio_net: change the command token to completion
Date: Thu,  6 Jun 2024 14:14:45 +0800
Message-Id: <20240606061446.127802-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240606061446.127802-1-hengqi@linux.alibaba.com>
References: <20240606061446.127802-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, control vq only allowed a single request to be sent,
so using virtnet_info as a global token was fine. To support
concurrent requests, the driver needs to use a command-level token
to distinguish between requests that have been sent.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 823a9dca51c1..e59e12bb7601 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2721,7 +2721,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
 		sgs[out_num + in_num++] = in;
 
 	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num,
+				&ctrl->completion, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
 			 "Failed to add sgs for command vq: %d\n.", ret);
-- 
2.32.0.3.g01195cf9f


