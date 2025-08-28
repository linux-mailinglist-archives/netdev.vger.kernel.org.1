Return-Path: <netdev+bounces-217774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3EB39CBE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4536B171A0D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051F31AF23;
	Thu, 28 Aug 2025 12:11:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB931A560;
	Thu, 28 Aug 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383063; cv=none; b=sWbRDvrtKbfFpHn1MlO2V0d0Ivd8SbDsRbfL/1qzWKJ7CtaxxNeJLFR5zjUz5EGalUvq3Ga4cT0tlrf8ghHjdgeb0ZwibSVa3765Ew5OPtjXHDeK0hnIk/2HDwVMVmJNsb/RI6TrIVDu/mLv/ww9vVvH3BctzNZINx5c2hhkWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383063; c=relaxed/simple;
	bh=gRDviIgZhugWQ/4oS/bkSZnIMfIe7NgTJ0tPvil8e24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrDGE+wh2oZlr0q4lKesCxqlqHr9J9+UkKcwS56UEbP5kyC+0lhbl8Zt+YIczM0GkWs4lBXAR3VR9N5pbqhZfcLppDdKYKUqWrTywY9WOLRNviTxlNAv/az5g6MOHOM0n4GJgBNJ25+eJ4rqTrLKOdCdM+l4ct1EuDgqotoLkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cCKss6Bgxz1R92W;
	Thu, 28 Aug 2025 20:08:01 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9465F1402CA;
	Thu, 28 Aug 2025 20:10:58 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:57 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v02 13/14] hinic3: Fix missing napi->dev in netif_queue_set_napi
Date: Thu, 28 Aug 2025 20:10:19 +0800
Message-ID: <71685e8f14c4523add7580dbfd078b1b2763f7c3.1756378721.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756378721.git.zhuyikai1@h-partners.com>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

As netif_queue_set_napi checks napi->dev, if it doesn't have it and
it will warn_on and return. So we should use netif_napi_add before
netif_queue_set_napi because netif_napi_add has "napi->dev = dev".

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index 33eb9080739d..a69b361225e9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -42,11 +42,11 @@ static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
 
+	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
 	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
 			     NETDEV_QUEUE_TYPE_RX, &irq_cfg->napi);
 	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
 			     NETDEV_QUEUE_TYPE_TX, &irq_cfg->napi);
-	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
 	napi_enable(&irq_cfg->napi);
 }
 
-- 
2.43.0


