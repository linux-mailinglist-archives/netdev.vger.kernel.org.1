Return-Path: <netdev+bounces-229451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861BEBDC6DD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4584F3BEB09
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB432DF139;
	Wed, 15 Oct 2025 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wq681msY"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA31C5496;
	Wed, 15 Oct 2025 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501436; cv=none; b=dqf6C+tQABt9fmv5uk85JyBg1F80DVyjJBv5bfZIrNJMqj8qsmiQop55ES3rwg9UjPljDrgGPGo61Ja6NBnCHOqtnfWC9jTF/wtb4b4PjCNdSlAdsUr5zbKOt1F8Y4IwijadLAWPbJLg9JSrw+Q1PonA/jUAe+vcQdGGu26fYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501436; c=relaxed/simple;
	bh=jPF7gTlGf0G+R1JQGvqCwxI+bu1DKLmlZH/GzgPoQQk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oihvA8dj+4B1c211cy04hMY0XblruX5er0opuv6ChQoONnftynjB+6llisxpiku2E0t7Xy41WTEVVeSJpLFv3gxpTR/Ob2ENW/EikWODcDzcrNxThrNVRMbLqcAzX7BIvjCg381AF8okaBd+x6mJErgRzvpOIIFsASNJOwNXpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wq681msY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=F8qagTfnP+U3q0F
	8E63xc12CZLmAkp6qB26cnOxilr8=; b=Wq681msYKhw1B/NUTb0zuyzYfVfOZdm
	3k0JEoYtRbxscNKNFaQX2cnE2TkcCuzJPc28tfYpVKfvPVsBxkoAGbl3XGnVCcLx
	q99Vs12Io7dOm0AkEiV6IKvSGHgTAMEP3tISYKqHYnABpEUYIUP2M+M+9zgRtPrz
	omQsyEy4qfac=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXnOhRHu9ovBl6AQ--.40673S2;
	Wed, 15 Oct 2025 12:09:04 +0800 (CST)
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
Subject: [PATCH net-next] net: dwmac-rk: No need to check the return value of the phy_power_on()
Date: Tue, 14 Oct 2025 21:08:47 -0700
Message-Id: <20251015040847.6421-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wCXnOhRHu9ovBl6AQ--.40673S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4xKw13WFyfXr15Gr4fGrg_yoW8ZryUp3
	93CF9Fyw1kXa4xGa17tFsrZa45u3y7Kry0qF1xA34ru3W3AF1DKF18tr1FvF1jgrykXFya
	yF4UAF1xC3Z8ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFPfQUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKBrnq2jvHAA8fgAAsn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

'phy_power_on' is a local scope one within the driver, since the return
value of the phy_power_on() function is always 0, checking its return
value is redundant.

the function name 'phy_power_on()' conflicts with the existing
phy_power_on() function in the PHY subsystem. a suitable alternative
name would be rk_phy_power_set(), particularly since when the second
argument is false, this function actually powers off the PHY

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 51ea0caf16c1..9d296bfab013 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1461,23 +1461,18 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	return 0;
 }
 
-static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
+static void rk_phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
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
+	rk_phy_power_on(bsp_priv, true);
 
 	pm_runtime_get_sync(dev);
 
-- 
2.17.1


