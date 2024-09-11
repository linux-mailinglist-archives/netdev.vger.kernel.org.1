Return-Path: <netdev+bounces-127305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF0974EAA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C311C22302
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030617ADFA;
	Wed, 11 Sep 2024 09:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E142056;
	Wed, 11 Sep 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047349; cv=none; b=pQul+OORVYkAXOz0sGdftY4iBhqmq+nJsHx/DypRyTsZLgKrQ5r0Y4Un9qOD7+EGj/QQI9rIdZ3Pl0aT/LoHke3QZmFN86WX0rHvzGr35M57yI+yvmlP1zZHNao/HySo3ck1O1NYjOhbwdAYdwYXzl6ZscKvfcavxZNYjB0NqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047349; c=relaxed/simple;
	bh=xKJrqC3Vz9IIrQzfnp5kBqp9keLOvzaOnIcs6xc/uBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRXaOWFlFzcXu3slCJVBiKJh2t10UJ8ZCpL5UiUWCNXK/Ts0n7FrKu2e2bghS7BRsKyjwd6YydZQldItGxkPviptHTb6ChjZane/EpT2K6ZwiIc3CCPGtrdvbe2y2LCdIJnj6OwmqNlKzRS4OHpTeoerMZ3cXr1iUXRwf0dTCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3b5H5XxwzyRqV;
	Wed, 11 Sep 2024 17:34:59 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EC3818010F;
	Wed, 11 Sep 2024 17:35:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Sep
 2024 17:35:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<louis.peens@corigine.com>, <damien.lemoal@opensource.wdc.com>,
	<set_pte_at@outlook.com>, <mpe@ellerman.id.au>, <horms@kernel.org>,
	<yinjun.zhang@corigine.com>, <ryno.swart@corigine.com>,
	<johannes.berg@intel.com>, <fei.qin@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net RESEND 1/3] net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 11 Sep 2024 17:44:43 +0800
Message-ID: <20240911094445.1922476-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911094445.1922476-1-ruanjinjie@huawei.com>
References: <20240911094445.1922476-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v1 -> RESEND
- Put wireless into another patch set.
---
 drivers/net/ethernet/apple/bmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 292b1f9cd9e7..785f4b4ff758 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -1317,7 +1317,7 @@ static int bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 
 	timer_setup(&bp->tx_timeout, bmac_tx_timeout, 0);
 
-	ret = request_irq(dev->irq, bmac_misc_intr, 0, "BMAC-misc", dev);
+	ret = request_irq(dev->irq, bmac_misc_intr, IRQF_NO_AUTOEN, "BMAC-misc", dev);
 	if (ret) {
 		printk(KERN_ERR "BMAC: can't get irq %d\n", dev->irq);
 		goto err_out_iounmap_rx;
@@ -1336,7 +1336,6 @@ static int bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 	/* Mask chip interrupts and disable chip, will be
 	 * re-enabled on open()
 	 */
-	disable_irq(dev->irq);
 	pmac_call_feature(PMAC_FTR_BMAC_ENABLE, macio_get_of_node(bp->mdev), 0, 0);
 
 	if (register_netdev(dev) != 0) {
-- 
2.34.1


