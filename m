Return-Path: <netdev+bounces-194399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF8AC9374
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73D13A739A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82521C6FE8;
	Fri, 30 May 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bgOHFXZ6"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1819ABC2;
	Fri, 30 May 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622163; cv=none; b=V7ri+zByXm9p0GCQKqV+ukffzfEICm/x/0C4YSivOVk/ygQWqg0q2s2ZL1zSUfWeOBBlN3mQvSvrXEloncN2cVaiTmVNWoMEQlZEoiZJcdBRo/T87z/ck+JHhRtGVLq7AApAAEnROZ31Y5wUkUmEitrFlH99cTX3zy+fdFAOn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622163; c=relaxed/simple;
	bh=IvKiI2GS2Dj5Eans+fFHm32EoVrfpQ50Wh/C4X/ZLK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fjTqjIIXPUZ/vqj9kEHhhX2AeBdTGc8bHlDXojWivkKiNbacQB+GIKcaglDxWdJhAD+B9LVmAlEfyEpT2PO32TF9mczj4g6qUTwZVf/y04AvkUeecbI6lMelPQyRkMsdXuhbno0AVT1Zjf7NvTSBED51pJ0lhaf84BAN+3aaBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bgOHFXZ6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=jCdzSFwYnDZECKuJL2W/gBgula6jQ6d53Xso4SG8qwc=;
	b=bgOHFXZ6AOcPgSn6ym7msrP48dbWljzcAVEwnjzBO7/oXxAHAUULqJD6I27cdv
	h+u3PCaPWVgo99D0n4WzIDBoN/1HO8nONEPPv8U6LLdUdo510JQnPBbYoAPTlnF+
	DdEOs9elr2f1D+e77+cMf8c5O3YO7kQv3r+rMGeFbQ+18=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCXjDDH2jlouf2RFA--.37484S2;
	Sat, 31 May 2025 00:20:31 +0800 (CST)
From: =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	jonas@kwiboo.se,
	rmk+kernel@armlinux.org.uk,
	david.wu@rock-chips.com,
	jan.petrous@oss.nxp.com,
	detlev.casanova@collabora.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH] net: dwmac-rk: No need to check the return value of the phy_power_on()
Date: Fri, 30 May 2025 09:20:17 -0700
Message-Id: <20250530162017.3661-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXjDDH2jlouf2RFA--.37484S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4xKw1fAF1rZF13ArWDArb_yoW8Ww47p3
	9xCF92yr1kXryxGa17trsrZa45uayxtFy0qF1xt3yfu3WfCF1Dtry8tr4FvF109rykXF1a
	yr4UAF1fCFn8Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFfO5UUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBMQldq2g502LCbgAAsC

phy_power_on() is a local scope one within the driver, since the return
value of the phy_power_on() function is always 0, checking its return
value is redundant.

Signed-off-by: 李哲 <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..f7c32934f8a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1645,23 +1645,18 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	return 0;
 }
 
-static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
+static void phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
-	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
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
@@ -1839,11 +1834,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		dev_err(dev, "NO interface defined!\n");
 	}
 
-	ret = phy_power_on(bsp_priv, true);
-	if (ret) {
-		gmac_clk_enable(bsp_priv, false);
-		return ret;
-	}
+	phy_power_on(bsp_priv, true);
 
 	pm_runtime_get_sync(dev);
 
-- 
2.17.1


