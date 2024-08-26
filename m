Return-Path: <netdev+bounces-121820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DE95ED10
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405251C21765
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7664D145B1F;
	Mon, 26 Aug 2024 09:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2985654;
	Mon, 26 Aug 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664434; cv=none; b=TdUe0qOjG/DxartHCHap34kFXWsbLmAG9UXlCL0BpkXq0xXpyN4V/F0CXzRwGj6ZUXLnvWqsg4qZHB0oA0+7DxeAv/ctkuNZ46OlfiDMayEJoxKH1H3FVmJjUGL7jJkwif6nnH0+fgc7vY+OJmAtH/WePgyh8E8jxdWnBzpfcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664434; c=relaxed/simple;
	bh=tPHPyCneiMEpsTXZkmpOJ4fx4ARtckha6iFhtzuQnRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZobYrlq2MCSOMfpTESsLgwIfNfUKcMGaaX0CiXkbZD0w3yi/8FSzOMWBj/gKOwN1qLQAyK3queszN/TspIbB8u7Idsr6O/6qNqwEE0oNJOThddHnPOp03P/pl//009IgjfHUp8UbaeaFQFH5xlsYCIOP18WaanZZwxeuVWNU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wslfm30g6zpVsj;
	Mon, 26 Aug 2024 17:26:24 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FB8814037E;
	Mon, 26 Aug 2024 17:27:10 +0800 (CST)
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
Subject: [PATCH -next 3/3] net: airoha: fix module autoloading
Date: Mon, 26 Aug 2024 09:18:58 +0000
Message-ID: <20240826091858.369910-4-liaochen4@huawei.com>
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
 drivers/net/ethernet/mediatek/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 1c5b85a86df1..a80c1fae5c2d 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2715,6 +2715,7 @@ static const struct of_device_id of_airoha_match[] = {
 	{ .compatible = "airoha,en7581-eth" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_airoha_match);
 
 static struct platform_driver airoha_driver = {
 	.probe = airoha_probe,
-- 
2.34.1


