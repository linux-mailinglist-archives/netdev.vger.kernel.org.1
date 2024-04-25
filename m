Return-Path: <netdev+bounces-91304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49E8B221E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA091C22902
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6A149C5A;
	Thu, 25 Apr 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BbbESW/R"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068A1494DB
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049946; cv=none; b=S6+4QH+2bjZs7WFmUIzydKkX12YrEgaMJGuFpUlMFfqiLypqXGh00aWIBhM/mXVxnMFokGJov4lHs+zm/O21lbzaREFBvFl0/c61RS7+NCGRQTCqoy27kOa/DJMNQwu6tfnmed/6EdFdcZoKA3aEh1EUNL67DdWO1BW3oOwGiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049946; c=relaxed/simple;
	bh=M6SmxO5/6HWUBjl3LCU40SGHS4eWuCP5wqLJO/TeQ+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/iRV4tQckuWfkdsOvu+jDJGaRrbOu9r0J11tH6kRg5d+3kpAQWpZYR/shqTwO7yuLHkWnOjRS5Y9ffJlNljZoKVO+X5HcoalFOqqzaKCkmlI+x2NDNzeJ6t0y4WAsDT5kqzDFgZJx7UhzuMtxbFwjaGGfzUiNE6JnYGVG3BLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BbbESW/R; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714049940; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tJge7rhA7eFJ/ScRh9Cw+FRMa1b17ZVyKgD8pV+Xg+8=;
	b=BbbESW/RnNXvHJGslQCQGDX4KCMlzowjHkpzPrHc0MoVQ6lbvTSSwZL4rDU25tEymnPAXULmodPnTZaR6qBLR3tyib3x6dmFIer0xaj5Ce3X7Sxrs+heoKJaccXPrKT1wqI6a2A2n2eya7+zWflJGE8Bgl6HVriSQA8wEl0r2y0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5FZNMk_1714049938;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5FZNMk_1714049938)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 20:58:59 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] virtio_net: fix possible dim status unrecoverable
Date: Thu, 25 Apr 2024 20:58:54 +0800
Message-Id: <20240425125855.87025-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240425125855.87025-1-hengqi@linux.alibaba.com>
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the dim worker is scheduled, if it no longer needs to issue
commands, dim may not be able to return to the working state later.

For example, the following single queue scenario:
  1. The dim worker of rxq0 is scheduled, and the dim status is
     changed to DIM_APPLY_NEW_PROFILE;
  2. dim is disabled or parameters have not been modified;
  3. virtnet_rx_dim_work exits directly;

Then, even if net_dim is invoked again, it cannot work because the
state is not restored to DIM_START_MEASURE.

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 79a1b30c173c..8f05bcf1d37d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3650,9 +3650,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (err)
 			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
 				 dev->name, qnum);
-		dim->state = DIM_START_MEASURE;
 	}
 out:
+	dim->state = DIM_START_MEASURE;
 	mutex_unlock(&rq->dim_lock);
 }
 
-- 
2.32.0.3.g01195cf9f


