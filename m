Return-Path: <netdev+bounces-61435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E30823A8E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECD72863A6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD41FB3;
	Thu,  4 Jan 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoIGj18S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64D4C92
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704334475; x=1735870475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0U5UmR6PMwHkZDuBSqUu2+6F+st05wpiTCuJCM/VSpw=;
  b=QoIGj18S3HvMFxgR2nL2/FavoinqeB4o/E3pL8b5RNSeStvKvCcH999X
   qlRqjvyNEWSk/2B7Hmts8F6hOVyNoi+/z5knBjk7VBKg8RyvmTsAbmy9G
   ruVRHkNIcstTot707waMvYjydJRCUbwQYsUDa5vX9nhDR1+DskClN/I7t
   l6DlHv/ouvWB8OHCWCwIYZjlmuGwZwLwqtRAUUorF3OtBJkTCWMSreImd
   RSe7V6N9dlZFq/XIZ8xHB7uc9aTxJHYwGuFU19KZA7i6WaLV4jxY0xnp1
   CkzCbtSnqjwtmBKPU/1qLFtFNzRKxbnrfhoq7wbwOnKPvkmAp4i/ue2qT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4184422"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="4184422"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 18:14:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="28592886"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orviesa001.jf.intel.com with ESMTP; 03 Jan 2024 18:14:31 -0800
From: Zhu Yanjun <yanjun.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v3 1/1] =?UTF-8?q?virtio=5Fnet:=20Fix=20"=E2=80=98%d?= =?UTF-8?q?=E2=80=99=20directive=20writing=20between=201=20and=2011=20byte?= =?UTF-8?q?s=20into=20a=20region=20of=20size=2010"=20warnings?=
Date: Thu,  4 Jan 2024 10:09:02 +0800
Message-Id: <20240104020902.2753599-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Fix the warnings when building virtio_net driver.

"
drivers/net/virtio_net.c: In function ‘init_vqs’:
drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
 4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
      |                                                ^~
In function ‘virtnet_find_vqs’,
    inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
drivers/net/virtio_net.c:4551:41: note: directive argument in the range [-2147483643, 65534]
 4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
      |                                         ^~~~~~~~~~
drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 18 bytes into a destination of size 16
 4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/virtio_net.c: In function ‘init_vqs’:
drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
 4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
      |                                                 ^~
In function ‘virtnet_find_vqs’,
    inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
drivers/net/virtio_net.c:4552:41: note: directive argument in the range [-2147483643, 65534]
 4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
      |                                         ^~~~~~~~~~~
drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 19 bytes into a destination of size 16
 4552 |                 sprintf(vi->sq[i].name, "output.%d", i);

"

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
v2 -> v3: Follow Jakub Kicinski's advice, repost it
v1 -> v2: Add commit logs. Format string is changed.
---
 drivers/net/virtio_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061..89a15cc81396 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4096,10 +4096,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
-	int ret = -ENOMEM;
-	int i, total_vqs;
 	const char **names;
+	int ret = -ENOMEM;
+	int total_vqs;
 	bool *ctx;
+	u16 i;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
@@ -4136,8 +4137,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		callbacks[rxq2vq(i)] = skb_recv_done;
 		callbacks[txq2vq(i)] = skb_xmit_done;
-		sprintf(vi->rq[i].name, "input.%d", i);
-		sprintf(vi->sq[i].name, "output.%d", i);
+		sprintf(vi->rq[i].name, "input.%u", i);
+		sprintf(vi->sq[i].name, "output.%u", i);
 		names[rxq2vq(i)] = vi->rq[i].name;
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
-- 
2.27.0


