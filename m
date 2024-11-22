Return-Path: <netdev+bounces-146814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8C9D602F
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721371F21C8B
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFEE2BB04;
	Fri, 22 Nov 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EPxDcobP"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAE79C0;
	Fri, 22 Nov 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284791; cv=none; b=VhvDGb6Lx8y3sB0P8rxOuOLRQfAJWu32WXMeg9yNPH1/oP6rI8Q8hl3vMpuK751tgfaw3wywuk0pWbA7f7hYdm1IfED626y08AE1kKBKc7zdT44pMISP3sxnmE2gALHj8r7OJ0yO7OhnaFs/R59DkvpB11E7WY9VBYWutorPqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284791; c=relaxed/simple;
	bh=7bXRyUg528fYaEeKIULUUicaZ3evTJltL2qw2YdaAq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTEoKjaqk/9h/ythhlKM8CkYBupxN7kkmpsSGQPaEDuP3rw0PrShQOMPBEefSS5P6/JN1/BORXG3XkmeZd1Sx3pgyx8BNWBn3Bjus7Sy6blPUQuCvBJ/ldHsu7eMjcLztO3dBkXanBwP3DEOkVlOf2FaM6AfljD2yiQ6hUshfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EPxDcobP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9B381BF204;
	Fri, 22 Nov 2024 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732284781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+01xzJeV3qRX2WUWGKaOOxbz2v9CPnb9VQR2tAoftiY=;
	b=EPxDcobPHDeJCBnjLXZtIBQaHN3OS6jpELxflv23dxJ/V44WfAMfNEUKav0FLPtpF0C2s7
	rKbYlya+ZEhOac2lw0RWwCdf6/Y9b6/LMgXWyvz7STEx7lCwbMzmMZPDUysI6HB/FbPM+1
	NMb5euWe1AY54iZoHTnqm4LACVr3Xohdk+Cl/1izvYTxbS2c07+4Je7B+4Utd/3yR33wm8
	paLh3eWkk4sBJtvGIQbQ4uXUdIzjZ8Qyy+gqCDtLPjYCR2YS2AlzmIHxvAChQ6Bvl2G1ek
	Tfycg8ero7EGeQFugWRS4PRZ9YgL0mA1QyUrjUcdkQNWQQaM6R52V9uuyK2xMA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
Date: Fri, 22 Nov 2024 15:12:55 +0100
Message-ID: <20241122141256.764578-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On DWMAC3 and later, there's a RX Watchdog interrupt that's used for
interrupt coalescing. It's known to be buggy on some platforms, and
dwmac-socfpga appears to be one of them. Changing the interrupt
coalescing from ethtool doesn't appear to have any effect here.

Without disabling RIWT (Received Interrupt Watchdog Timer, I
believe...), we observe latencies while receiving traffic that amount to
around ~0.4ms. This was discovered with NTP but can be easily reproduced
with a simple ping. Without this patch :

64 bytes from 192.168.5.2: icmp_seq=1 ttl=64 time=0.657 ms

With this patch :

64 bytes from 192.168.5.2: icmp_seq=1 ttl=64 time=0.254 ms

Fixes: 801d233b7302 ("net: stmmac: Add SOCFPGA glue driver")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 248b30d7b864..16020b72dec8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -487,6 +487,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 	plat_dat->has_gmac = true;
 
+	plat_dat->riwt_off = 1;
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
 		return ret;
-- 
2.47.0


