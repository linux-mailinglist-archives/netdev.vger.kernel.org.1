Return-Path: <netdev+bounces-122594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30545961CF5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D2A1C2418D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343C159596;
	Wed, 28 Aug 2024 03:16:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8115853E;
	Wed, 28 Aug 2024 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814970; cv=none; b=BC3cELNweJuGSalb8oWVURusvZPLtTZX8dH7j0glgWfGgYtUYySKaDOTFHzk/C6J/RaJfdUySWtF1n4n1ghp/922qtTjfkHKbtcnBnMSzl8zvASEF1OG5pZDQACe67cY+iB7uvHgg/YYzLB2Zdpz3wsf8W6BrYKrMeFXpvRrZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814970; c=relaxed/simple;
	bh=jv4XI5yACXeh2L/Tsbj6z0l+qxWAU6Sc3h6P+yEirmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1U/lprxvr+oFbbvO8fI+H36KVU51lDPGpfle1kEuar0Bpcj1Dzb6BKtKqqbGEbOlEC3l8oGFT1XCAY7XidZG1f4Gsvs58VMoi67GybG2oWAJVVFYor9ifc5G0I3cTVXmtIvr42On3xRlRlRLyZKhKapqboofBX+1yGLpxweZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WtqLF5yThz1S907;
	Wed, 28 Aug 2024 11:15:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 515BC140135;
	Wed, 28 Aug 2024 11:16:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 11:16:00 +0800
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
Subject: [PATCH net-next v2 09/13] net: mv643xx_eth: Simplify with scoped for each OF child loop
Date: Wed, 28 Aug 2024 11:23:39 +0800
Message-ID: <20240828032343.1218749-10-ruanjinjie@huawei.com>
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

Use scoped for_each_available_child_of_node_scoped() when iterating
over device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f35ae2c88091..9e80899546d9 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2802,7 +2802,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 static int mv643xx_eth_shared_of_probe(struct platform_device *pdev)
 {
 	struct mv643xx_eth_shared_platform_data *pd;
-	struct device_node *pnp, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	/* bail out if not registered from DT */
@@ -2816,10 +2816,9 @@ static int mv643xx_eth_shared_of_probe(struct platform_device *pdev)
 
 	mv643xx_eth_property(np, "tx-checksum-limit", pd->tx_csum_limit);
 
-	for_each_available_child_of_node(np, pnp) {
+	for_each_available_child_of_node_scoped(np, pnp) {
 		ret = mv643xx_eth_shared_of_add_port(pdev, pnp);
 		if (ret) {
-			of_node_put(pnp);
 			mv643xx_eth_shared_of_remove();
 			return ret;
 		}
-- 
2.34.1


