Return-Path: <netdev+bounces-24750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7BC7718DA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 05:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D3F281140
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 03:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579CA41;
	Mon,  7 Aug 2023 03:49:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D480F
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 03:49:49 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBE10FD;
	Sun,  6 Aug 2023 20:49:46 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376N0HJt005441;
	Sun, 6 Aug 2023 20:49:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=pyTQoH8mIIaArXwMJduVBQJnNnjf2BQfpuaQRcDIquo=;
 b=dNvEmt/9JUAS2xDF1/EWNi8uCIuJBTmp5DK6uJAd61uy3G2eAyEjlTJpYFs8jMkXUAlU
 1sQd6WUEWAs08GgFfRTJVGJVwmfYcjp7JiZnPz0kEU1GmOo5lPky8kOagnDDd6CormSj
 T/8X5QEy3aQeFIUG2y0xoklly1+R6VxfDOsBJUAzFKjUhQMZv1QwRgZ8SAQuJdnexrjX
 ZVQ1gpBqXxQnsQ337LXZkAnuwREuNJJJBWxVKcqOpZeufPe1iaR0jxc5N49wiyt/J1SP
 9HPO+3Cam9Wv/xQ4x/ZdkoED5bQN1Uv2IU/JOQdhnvsEnW+ki2KeS23XTheh6F4dlqXY kg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s9nxkuau1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 06 Aug 2023 20:49:39 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Aug
 2023 20:49:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 6 Aug 2023 20:49:36 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 22EF23F7091;
	Sun,  6 Aug 2023 20:49:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] page_pool: Clamp ring size to 32K
Date: Mon, 7 Aug 2023 09:19:32 +0530
Message-ID: <20230807034932.4000598-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yWjY0_jY_CfydcVPHQHZBy3u28HWd_a8
X-Proofpoint-ORIG-GUID: yWjY0_jY_CfydcVPHQHZBy3u28HWd_a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_01,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

https://lore.kernel.org/netdev/20230804133512.4dbbbc16@kernel.org/T/
Capping the recycle ring to 32k instead of returning the error.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5d615a169718..404f835a94be 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -182,9 +182,9 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->p.pool_size)
 		ring_qsize = pool->p.pool_size;
 
-	/* Sanity limit mem that can be pinned down */
+	/* Clamp to 32K */
 	if (ring_qsize > 32768)
-		return -E2BIG;
+		ring_qsize = 32768;
 
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
-- 
2.25.1


