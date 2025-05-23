Return-Path: <netdev+bounces-193070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB26AC2636
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7212B1BA17EC
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43D192D68;
	Fri, 23 May 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bBwVXnXV"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52F625;
	Fri, 23 May 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013459; cv=none; b=uI6EQ5TuQO3197N+nWr8DM4UqYd3plYciBfEkCgyTicm5J7e2HAmO4kqUkNEqTWp0YMh3kdWeUPMHTIQSLjnNpr/jW8hsPHsKfFhrQWxC+tSw6r76WzYU4JBh1B4Pr6ReM1zSfAUhUb+XMNH/oIoWX8ZqGr57QumuzJWXSaySHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013459; c=relaxed/simple;
	bh=grBDhLBnqrLejwb9yEY0MLDRtwM/n1iyGHbRGNy+k58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B5TkhzUycraGGcuChhsSnAS/8ZzpztqeZXLecTCnMlV2Qi0WLwsAkbBbl2NtDFEvP5+wc30rY391sNawCrz9dpzrOEErhsTLB8mazi4XhNUynb1YAZIkUO23BAhRmyzZysJREzbF7lWuOtMP3TEwAlsHPckoKGN+d54w+2iWMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bBwVXnXV; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=3aX8PUAXDaemiEQ3IrgJbnTZwuocxLWzcQByTZDngOU=;
	b=bBwVXnXV47gzp2czYWTvmcMKEgZrPMUK9feAAVxOgG4AOljD7u1FtJ/gbID3wl
	5TC1szaWCRf19jfCuTR/VW5SEF5Epmr+km/g05ps82PrudkZ4Yvhzmc8Mt1TrWCD
	6Jebflm7/aV9n/B/b9GcMaoiXetu2Kn3b8KGIMA2T9/L4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXbyELkTBoFV96Bg--.59745S2;
	Fri, 23 May 2025 23:15:35 +0800 (CST)
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
	wens@csie.org,
	u.kleine-koenig@baylibre.com,
	an.petrous@oss.nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH] net: dwmac-rk: MAC clock should be truned off
Date: Fri, 23 May 2025 08:15:21 -0700
Message-Id: <20250523151521.3503-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXbyELkTBoFV96Bg--.59745S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1kXry3Kw4Dtr4DKr4Uurg_yoWkWFbE9w
	1Ivrn3XF45XF40kF1DGw13Zr9agFs8ZFs5Ar42gFWSvFW7Zwn8Zr4kWrsrArn5Ww48AF9r
	Gr1xAF1Iyw1xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtCJPDUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBMR9Wq2gwKoMmeAABs9

if PHY power-on fails, clockassociated the MAC should
be disabled during the MAC initialization process

Signed-off-by: 李哲 <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..036e45be5828 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1648,7 +1648,7 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
-	int ret;
+	int ret = 0;
 	struct device *dev = &bsp_priv->pdev->dev;
 
 	if (enable) {
@@ -1661,7 +1661,7 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 			dev_err(dev, "fail to disable phy-supply\n");
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
-- 
2.17.1


