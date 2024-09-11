Return-Path: <netdev+bounces-127307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B80974EB0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA170287E3C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C5185B48;
	Wed, 11 Sep 2024 09:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870C13D28A;
	Wed, 11 Sep 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047350; cv=none; b=iHGCS46PUAaT5Z73rmUe4hA2+tTP42t8kXujvAly3oolvfKCvCI9lDuRroF5QWe8GiqMRuOpwg4iZog5OSkLjh7Us/KwynfTgCp2weJZ9N0Ok7liJwxjiq9ub4eH18G5m3ZQ4ijC2iOzWRv3mDEitQYuWq66ItBmXyJnZH6ZKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047350; c=relaxed/simple;
	bh=sUcjMyqSFlIh5tFWjECBHnTjRvuDJcuVVDhbz0MEWsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lt2bBkQ8PulW6AluRWO1AWzrur5nFdIRj0+zDrFB+lZpMpH3oUoQytLglrT8+vKOk8HpB725xgsZ8/P8sq/5LPaRaEUXbR/2TUlZzOFfllesBg250NEPLkaq4XOEf/MvExeK3P5m2N4WdsYKallF0UQFTjIfjL27P2BKKHOsyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3b231hqVz1HJXh;
	Wed, 11 Sep 2024 17:32:11 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5231C180043;
	Wed, 11 Sep 2024 17:35:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Sep
 2024 17:35:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<louis.peens@corigine.com>, <damien.lemoal@opensource.wdc.com>,
	<set_pte_at@outlook.com>, <mpe@ellerman.id.au>, <horms@kernel.org>,
	<yinjun.zhang@corigine.com>, <ryno.swart@corigine.com>,
	<johannes.berg@intel.com>, <fei.qin@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net RESEND 2/3] net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 11 Sep 2024 17:44:44 +0800
Message-ID: <20240911094445.1922476-3-ruanjinjie@huawei.com>
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

Fixes: bbb96dc7fa1a ("enetc: Factor out the traffic start/stop procedures")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v1 -> RESEND
- Put wireless into another patch set.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5c45f42232d3..f04f42ea60c0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2305,12 +2305,11 @@ static int enetc_setup_irqs(struct enetc_ndev_priv *priv)
 
 		snprintf(v->name, sizeof(v->name), "%s-rxtx%d",
 			 priv->ndev->name, i);
-		err = request_irq(irq, enetc_msix, 0, v->name, v);
+		err = request_irq(irq, enetc_msix, IRQF_NO_AUTOEN, v->name, v);
 		if (err) {
 			dev_err(priv->dev, "request_irq() failed!\n");
 			goto irq_err;
 		}
-		disable_irq(irq);
 
 		v->tbier_base = hw->reg + ENETC_BDR(TX, 0, ENETC_TBIER);
 		v->rbier = hw->reg + ENETC_BDR(RX, i, ENETC_RBIER);
-- 
2.34.1


