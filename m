Return-Path: <netdev+bounces-63707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516882EF8A
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E6C1F2471F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781A1BC5F;
	Tue, 16 Jan 2024 13:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962851BC50
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-mERuN_1705410695;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-mERuN_1705410695)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 21:11:35 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 1/3] virtio-net: fix possible dim status unrecoverable
Date: Tue, 16 Jan 2024 21:11:31 +0800
Message-Id: <1705410693-118895-2-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

When the dim worker is scheduled, if it fails to acquire the lock,
dim may not be able to return to the working state later.

For example, the following single queue scenario:
  1. The dim worker of rxq0 is scheduled, and the dim status is
     changed to DIM_APPLY_NEW_PROFILE;
  2. The ethtool command is holding rtnl lock;
  3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
     to acquire the lock and exits;

Then, even if net_dim is invoked again, it cannot work because the
state is not restored to DIM_START_MEASURE.

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
Belongs to the net branch.

 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1..f6ac3e7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3524,8 +3524,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int i, qnum, err;
 
-	if (!rtnl_trylock())
+	if (!rtnl_trylock()) {
+		schedule_work(&dim->work);
 		return;
+	}
 
 	/* Each rxq's work is queued by "net_dim()->schedule_work()"
 	 * in response to NAPI traffic changes. Note that dim->profile_ix
-- 
1.8.3.1


