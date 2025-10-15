Return-Path: <netdev+bounces-229455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD4BDC95E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D3844E62F7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B093019AB;
	Wed, 15 Oct 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IZCxiCu/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD23016E2;
	Wed, 15 Oct 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505391; cv=none; b=u03syqfzKD8qLKVbp8/FfTRdfh5kHrPWUo7jKranwopVZW28HHitQexkYNrzWPFGGvNQzZAHbLJSotomCr+nlQwqaCra1oerqDAcf0Jui42nyCHCAnKTFuirIw7wm1//qsPUoQHY4R1Jkzh6tKQY/OAujq29fsVJvUROiXTJYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505391; c=relaxed/simple;
	bh=wgKM6x3Yhy8jmtIn6xOwrUMNqwYV8Rli1qUtnZeVb54=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fw1o6pmgCazPm7nxkzTSSrEfqTRFGMTa/zWqSwjHsHKnq449J9S6YpwqaQ6Fcl08sREoV1euJd3jonFlxXvx1gmrKE+0xUcWx1Z0k06z0qT6wxN0U6ldATaVBbj656qm4jdowGZsks8xaUdQOOiRaFs8SRIyPEPkUIb89zRasxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IZCxiCu/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=vkfC6oyc+tLRX6p
	AwVB+5VChWivTatMtNmzCnEAtV8E=; b=IZCxiCu/r6Hb/EqJWciCLAtIAxvXOZp
	mcNdDpjjx/DQqiT0He8sYn6aK/VnrTICv5kjxM3e/38lGkunTWsv4Ix2bpHcWNK1
	o1Lewgfy3VxxtMkdIclIkVsRLDogrEOXlwucgVA+OsTW/m8LkwGFWsuxZOVV705n
	4ydacRZzF2zk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3A5TILe9ovbHOAA--.30995S2;
	Wed, 15 Oct 2025 13:15:06 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	jonas@kwiboo.se,
	chaoyi.chen@rock-chips.com,
	david.wu@rock-chips.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH net-next] net: dwmac-rk: No need to check the return value of phy_power_on()
Date: Tue, 14 Oct 2025 22:14:46 -0700
Message-Id: <20251015051446.2677-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:PygvCgB3A5TILe9ovbHOAA--.30995S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4xKw13WFyfXr15Gr4fGrg_yoW8tr13pa
	93GF9Fyr1kXa4xGa12yFsrZa45C3y3try0qF1xA34ruF13AF1Dtr10yryFvF1j9rykXFya
	yr4UAF1xC3Z8ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRrb1bUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKBrnq2jvHAA8gQABsZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

'phy_power_on' is a local scope one within the driver, since the
return value of the phy_power_on() function is always 0, checking
its return value is redundant.

the function name 'phy_power_on()' conflicts with the existing
phy_power_on() function in the PHY subsystem. a suitable alternative
name would be rk_phy_power_set(), particularly since when the
second argument is false, this function actually powers off the PHY

Signed-off-by: Lizhe <sensor1010@163.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 51ea0caf16c1..ac3324430b2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1461,23 +1461,18 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	return 0;
 }
 
-static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
+static void rk_phy_power_set(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
 	struct device *dev = bsp_priv->dev;
-	int ret;
 
 	if (enable) {
-		ret = regulator_enable(ldo);
-		if (ret)
+		if (regulator_enable(ldo))
 			dev_err(dev, "fail to enable phy-supply\n");
 	} else {
-		ret = regulator_disable(ldo);
-		if (ret)
+		if (regulator_disable(ldo))
 			dev_err(dev, "fail to disable phy-supply\n");
 	}
-
-	return 0;
 }
 
 static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
@@ -1655,11 +1650,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		dev_err(dev, "NO interface defined!\n");
 	}
 
-	ret = phy_power_on(bsp_priv, true);
-	if (ret) {
-		gmac_clk_enable(bsp_priv, false);
-		return ret;
-	}
+	rk_phy_power_set(bsp_priv, true);
 
 	pm_runtime_get_sync(dev);
 
@@ -1676,7 +1667,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 
 	pm_runtime_put_sync(gmac->dev);
 
-	phy_power_on(gmac, false);
+	rk_phy_power_set(gmac, false);
 	gmac_clk_enable(gmac, false);
 }
 
-- 
2.17.1


