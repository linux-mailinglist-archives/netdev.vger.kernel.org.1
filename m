Return-Path: <netdev+bounces-97488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B78CB9EE
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 05:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4D31C2170F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3D70CC9;
	Wed, 22 May 2024 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ot5msr/j"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060C1EB2C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349556; cv=none; b=JBDXpkEsfoOYD6VUvBGBNlr9c1klOi00dSxArJzCKFOR8hkMYbF0oSR/dmzEE5z/qdHX61jdRhyFjbhg2Bx9bp8geC9NacWvlsHNEr/jSZ9rSSaKAuSYNAZqz1QNKpfx0UrkxbiySVcPI1ywMshmf5xJi9ulux/Ss8vFxzcfHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349556; c=relaxed/simple;
	bh=P8l2yrTy7ck3J2AdS7gQzuJbWvqXIx3UPmTzaHMWrsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbcK/Y8sCPKzuZ9zn+zL2/3BgMPd3mHqUG2Wws/t5oq4gCROfBqJW2e6kycTqfj7+wcmg7S14PIcUySLmJxqKgW41gIW7tO5nMIaj8xZkk1K1ATtbDBfZPU1zbIHcMv7IZThqqBvA7mwlQMyi33Td+8647ghOg+aJbO23n8PiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ot5msr/j; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716349552; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=f2Cqgpxov3hMddM74lTIUNbl5mhHeceqLFqZDMFCeIU=;
	b=ot5msr/jlFL6dJxhmhEhbHmbiGHTM4Wq6Us0BbNNGoHBWLog7+ZA3kHXl7ZPGVKz9iFM8rE6D7pDKdxtQBivwRMFSOAhg2lGfymZG85m1kBhLi1BtYDYitt/Td+Bi3jlsgRf+IJ2tFkPbjC9pVeZlG7ZSPEy2pEIOH7l38Od0VA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6zlMSW_1716349550;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6zlMSW_1716349550)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 11:45:51 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 1/2] virtio_net: fix possible dim status unrecoverable
Date: Wed, 22 May 2024 11:45:47 +0800
Message-Id: <20240522034548.58131-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240522034548.58131-1-hengqi@linux.alibaba.com>
References: <20240522034548.58131-1-hengqi@linux.alibaba.com>
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
index 4e1a0fc0d555..1cad06cef230 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4417,9 +4417,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
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


