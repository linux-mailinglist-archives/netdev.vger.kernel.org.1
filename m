Return-Path: <netdev+bounces-205091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E26AFD33F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D688E422091
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA002E54BD;
	Tue,  8 Jul 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yl9rFPHB"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320008F5E;
	Tue,  8 Jul 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993539; cv=none; b=ONfpxd+mde+PtRz7tKLEywvZsk8YPrq1aTjbXXxMlAJ6ikb9PM8rTXuNuTCFmFVeZRPNHB216woeli6J8lM6ZVzyB2p6QXZRczzDlwmO732rInlc8EIO6T56cGK8ye+WhX3keGaDIUDivmmoCggh+KZbGYxU0i249EIBCdW+c7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993539; c=relaxed/simple;
	bh=x0s4vKXtQGcRzZcSyjECLh5CtsGE03bks9gI82RuAII=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H45L58jq9RNi6tJMsVmTu+op0MVIUcLaMuHzzRqogB86tReuLAEwpXcvH3c17onVctbOygSvQUTE0v1hs9hHNArtoAna4uu07Y3AS7BLh7vTgvmXqkGhXDi9ducPLyLLHuOLKEMmq+qWDH69iNIPyJi1kp0TB+woRb5uz/DuOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yl9rFPHB; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=qWsk8ZwHDgxqYRw
	HFFMeZK+uhE/KHO9DpLNrBBEM2ik=; b=Yl9rFPHB+UQOpXdume2OML+tQvwGWaA
	WxqYuy2HVfemmvq97tBl0ud9qt7mfqnwyWoxUALB2pP8142yvWtnwG/gHwRWhQaa
	WdX84sR4eO8l5KUOyXc2hmYwCiOpgKeXNXC2zdKuGgH+JHG/eJKkIPPf3+VAvS5i
	rmok7Iri9uMM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3YqRnTG1oypwxDg--.1262S2;
	Wed, 09 Jul 2025 00:51:01 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com,
	sensor1010@163.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Support gpio high-level reset for devices requiring it
Date: Tue,  8 Jul 2025 09:50:44 -0700
Message-Id: <20250708165044.3923-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wC3YqRnTG1oypwxDg--.1262S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF15Aw17Zr48JF1kKr1kuFg_yoW8Ar48p3
	yrua4UZr97Jr13tw4kXw48Zr95Ka93tr40k3Wfu3yS9rWDWFZIqr1a9rW3XFy3KrZ5uFya
	vw1UCF13Zan0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKBKEq2htS5kM0AAAse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

some devices only reset when the GPIO is at a high level, but the
current function lacks support for such devices. add high-level
reset functionality to the function to support devices that require
high-level triggering for reset

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 836f2848dfeb..cb989e6d7eac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -458,6 +458,7 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 #ifdef CONFIG_OF
 	if (priv->device->of_node) {
+		int active_low = 0;
 		struct gpio_desc *reset_gpio;
 		u32 delays[3] = { 0, 0, 0 };
 
@@ -467,6 +468,9 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 		if (IS_ERR(reset_gpio))
 			return PTR_ERR(reset_gpio);
 
+		if (reset_gpio)
+			active_low = gpiod_is_active_low(reset_gpio);
+
 		device_property_read_u32_array(priv->device,
 					       "snps,reset-delays-us",
 					       delays, ARRAY_SIZE(delays));
@@ -474,11 +478,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 		if (delays[0])
 			msleep(DIV_ROUND_UP(delays[0], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 1);
+		gpiod_set_value_cansleep(reset_gpio, active_low ? 1 : 0);
 		if (delays[1])
 			msleep(DIV_ROUND_UP(delays[1], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 0);
+		gpiod_set_value_cansleep(reset_gpio, active_low ? 0 : 1);
 		if (delays[2])
 			msleep(DIV_ROUND_UP(delays[2], 1000));
 	}
-- 
2.17.1


