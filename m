Return-Path: <netdev+bounces-122592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF26961CEF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CA11F23060
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90C13D613;
	Wed, 28 Aug 2024 03:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF731552FA;
	Wed, 28 Aug 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814968; cv=none; b=c3AFM5K2YN/Qe+kklOAgOeA861MbKvIGwsAd4weRIwcFi9U1Ea6BC7bhVv8GFUH6pgCeNLqw89TbSuIvRGYXp3IVRPyzIVkCpH7GTeLtsToQa83X9SSctWSQoXwd+q29fjKTq8rMTzd1qP1eW5ffwtGJYWOq3PplWMtM5paXPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814968; c=relaxed/simple;
	bh=p0qTLt/5qzQhme8u/FNUJc0MxPq8A5fh7mTEWHzqp1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJj/ZE9pagU2yrjztIRcHOnorTpkRvZf01Fbfq2uG1BwLG8n6/em+23I4gXX4cBE95FLDlsHdABBH2zOksib55J3EsLGt/WAuljgoGI/RM+P96mzgtXcmN6wXwL3d7hRswipOZpv4UKuRuaPgv6h8zJdVJRSC3gehIflMIlVLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtqJ846fhzfbgy;
	Wed, 28 Aug 2024 11:14:00 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FC2A14022E;
	Wed, 28 Aug 2024 11:16:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:16:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 12/13] net: bcmasp: Simplify with scoped for each OF child loop
Date: Wed, 28 Aug 2024 11:23:42 +0800
Message-ID: <20240828032343.1218749-13-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828032343.1218749-1-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when
iterating over device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split into 2 patches.
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 20c6529ec135..70219094b7f6 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1300,7 +1300,7 @@ static void bcmasp_remove_intfs(struct bcmasp_priv *priv)
 
 static int bcmasp_probe(struct platform_device *pdev)
 {
-	struct device_node *ports_node, *intf_node;
+	struct device_node *ports_node;
 	const struct bcmasp_plat_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct bcmasp_priv *priv;
@@ -1374,12 +1374,11 @@ static int bcmasp_probe(struct platform_device *pdev)
 	}
 
 	i = 0;
-	for_each_available_child_of_node(ports_node, intf_node) {
+	for_each_available_child_of_node_scoped(ports_node, intf_node) {
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
-			of_node_put(intf_node);
 			ret = -ENOMEM;
 			goto of_put_exit;
 		}
-- 
2.34.1


