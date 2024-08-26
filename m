Return-Path: <netdev+bounces-121818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ADE95ED0D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA77282136
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BF144D1F;
	Mon, 26 Aug 2024 09:27:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7813A88D;
	Mon, 26 Aug 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664433; cv=none; b=bsYe1KSBL3TjxqHAzSgF6i8fCKJWWTTXrQwvnVvMPmdJOJiLs9KAhcgTNz8vnUjZlhDOFLZskDQ/OxeRvInE2B8dMIOzhJN9HSAGbORQYg9ZdBDNjLR8Q71kBm/1j7Q7/vLm2EpjeDxmTLEMyQuuyce4iSccz4GM10bQSrS4T7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664433; c=relaxed/simple;
	bh=AGbhaGZzYf8sUpXJdvrvt+qGEcxnb80Nxq5n0j8IBFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBtvgg5bniS2Hq8iKCKHULztkI6+AZgIKNlNpbaM6ajoGfgViL2ySn/Ul5DEtdZOpWQRarW+F4vsfV8cb1JpagAERa0YPz51whesKkkZWKxMD0Xft+8LvjoqiEHB+uhPBNO6qeztQrOL96ndvIRa+Xen6OO2lW0Yu4rW2FnZtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wslg54rQ2zyRB9;
	Mon, 26 Aug 2024 17:26:41 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id BA5C51800D0;
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
Subject: [PATCH -next 1/3] net: dm9051: fix module autoloading
Date: Mon, 26 Aug 2024 09:18:56 +0000
Message-ID: <20240826091858.369910-2-liaochen4@huawei.com>
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
 drivers/net/ethernet/davicom/dm9051.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/davicom/dm9051.c b/drivers/net/ethernet/davicom/dm9051.c
index bcfe52c11804..59ea48d4c9de 100644
--- a/drivers/net/ethernet/davicom/dm9051.c
+++ b/drivers/net/ethernet/davicom/dm9051.c
@@ -1235,6 +1235,7 @@ static const struct of_device_id dm9051_match_table[] = {
 	{ .compatible = "davicom,dm9051" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, dm9051_match_table);
 
 static const struct spi_device_id dm9051_id_table[] = {
 	{ "dm9051", 0 },
-- 
2.34.1


