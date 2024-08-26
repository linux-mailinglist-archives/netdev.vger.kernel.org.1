Return-Path: <netdev+bounces-121821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269495ED11
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145D22820D1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F84146019;
	Mon, 26 Aug 2024 09:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD77143882;
	Mon, 26 Aug 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664434; cv=none; b=Vat7n14EcgpNUqsaxGiWh1J89KplRTnvTgdoAy7uTCZhDBbrE+12ZhMm1GzRMRStVzpqA2DimIdNzgZJD/pZ/HDWAtiI7qLeht02z9rcEruL0lnw2npoAVjwzVp+fpCvCSjZ83I6S/2XDpLgtaXRznNj58x6Wgc/Wd3lwI/bnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664434; c=relaxed/simple;
	bh=syn/L+vM4fo0OtrQMlyGH6kMlbemWb3b4imeD/jQ8x8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgxwJIcgI9C8LxdfzRk8wN3cDELcsSwbnSDwxZA3UkclKk0meUrvrtyBoe+nKYV9uROw69MLxWqna+8ci0xXqavo4HhJLId+6lH47VvavkGp3cP13ra1HKwy2mDkcFX0OShtTfXVuIUx9TNUKdIkObByirwl6UJArSCNGGmwj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WsldH0C95zhYTp;
	Mon, 26 Aug 2024 17:25:07 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id E990F14037E;
	Mon, 26 Aug 2024 17:27:09 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 17:27:09 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <chris.snook@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <lorenzo@kernel.org>, <nbd@nbd.name>,
	<sean.wang@mediatek.com>, <Mark-MC.Lee@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<liaochen4@huawei.com>
Subject: [PATCH -next 2/3] net: ag71xx: fix module autoloading
Date: Mon, 26 Aug 2024 09:18:57 +0000
Message-ID: <20240826091858.369910-3-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826091858.369910-1-liaochen4@huawei.com>
References: <20240826091858.369910-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index a38be924cdaa..844b86abd90a 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -2064,6 +2064,7 @@ static const struct of_device_id ag71xx_match[] = {
 	{ .compatible = "qca,qca9560-eth", .data = &ag71xx_dcfg_qca9550 },
 	{}
 };
+MODULE_DEVICE_TABLE(of, ag71xx_match);
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
-- 
2.34.1


