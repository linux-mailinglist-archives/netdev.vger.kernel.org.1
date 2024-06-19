Return-Path: <netdev+bounces-104944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87490F3E0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C97A2864E4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BD152181;
	Wed, 19 Jun 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B+ZaMes/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE99152799
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813958; cv=none; b=mo6e+KeW5RFsNGWHr3+KAW7BtPx5/pMjC/s5fEOLOj4V4ervV9zcFikNGtBDrTRxpzYE8Pv6nkI+zyze21bb9qEO8+wHINKz8ZLEauaE30uPZrA+UwszYd79wUIKKvBOQvLNlsoFzyX/4IBTJYdSR4Mz86atr2IzuTtgSQ6EHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813958; c=relaxed/simple;
	bh=3Yh5PsChSezWkJHGbQsZqeGy1wvAeYrKRxbMw+IleIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMrdTIkPSWiTbW33JfG0KjSukF3I4he73AyZL1NRLSMB0clmDmsis8TebLxzLK7Q8er1fIOMd642bw/65aTmn7PyJyZGjW+orx3Els9RQBEQuKK/DlEtHr10j1zfMayiBltY2VHQtVUVr/xYHsTAi4yEASx/uWvz9E3nBMCW72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B+ZaMes/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718813952; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5/ZfHHCtLhURn17PHo/pz9cGgrwQYJFZxD846L+urmA=;
	b=B+ZaMes/2SGGkhIEPO0b/MQMZihH6msKHyez2scfZJ0/K3XFACyZCXdQk7GLGTJW/tRRgj7gXO/L2sXIVaiDeifQGuvFMk98r9NW84UnNptiAXJrOosj7l45kY3CRJwo8LGJnGni90z310p6nbsSsTG0WHQbndhBl2u4EWkTCOo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8olDpW_1718813951;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8olDpW_1718813951)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 00:19:12 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 3/5] virtio_net: change the command token to completion
Date: Thu, 20 Jun 2024 00:19:06 +0800
Message-Id: <20240619161908.82348-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
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
index ed10084997d3..4256b1eda043 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2722,7 +2722,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
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


