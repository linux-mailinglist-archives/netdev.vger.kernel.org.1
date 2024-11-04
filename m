Return-Path: <netdev+bounces-141606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF29BBB0B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541B71C216B5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9A1D0E0F;
	Mon,  4 Nov 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LzD3z90R"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5C1CD15;
	Mon,  4 Nov 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739787; cv=none; b=O/IDFBqlDeOzkNdxdapgBX0TWbdwaR6v9t/9swMG/8gKhbqB4F/3xJW0dhRCj/I6E/RPTJfUI2BJhfY2ISReLWmuOKFJxi9njq9vI0U+nCOv8aOfyG92zUn1kS3B6EoY5ZneW1aCi1wAKFP5QkWlSCPWWgACbP1G+WYIqlq4vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739787; c=relaxed/simple;
	bh=Qhke3aQ/LKX8NgnOjf25kpHzyWzOYic/Qlwn68EtZMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt8neyeklVoOh9szFCc9ljtMoZo17ASOUd10P/ibkSutv4SQLja9CYgf+WQOt9OoOn9TRgcHWrmp42ckalIVOJ+k4oAcGZGrcIlUN6akKMaFzcvn4ggrhL0cKsQrnohLJqHOx6N3UMaqkEEaXE31ctohwpuzj1fsDhJOWsymbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LzD3z90R; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA89B60011;
	Mon,  4 Nov 2024 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42kxzvTWuXxqunQIkofuM5yI8E9ydjyRl0t7IPFnnsE=;
	b=LzD3z90R2ZmbkZFhVPMAW0gFfa9+bUK16e+zoEJoUBBvhtWJPhZcznkicbtoAdTxMZrVix
	xLZJ952dU70MPKkt74w4plYF1NWSGl1mryyakbyJM9kKdBOvJYL3k24voD5zOSexzFIJdd
	UcWxH3vg5UC/a6yek1Fb2zGqahRyBZcXbctWPyaE7aq4Bm24IpEQzeUun7ep81+Ml1wFHr
	CuJbpYp6xqa36dUYYxjkkQBNR1Uwx3z9MRLAWkzqgoRt5BcjFnFVFSenBDrvAcMYxiOVIR
	FmDI5xqlgJZcG69FqRrXkwsDCpyk+yhbyXkUOdLtWptTGkk3Ou2rZONsxtvf4w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 9/9] net: stmmac: dwmac_socfpga: This platform has GMAC
Date: Mon,  4 Nov 2024 18:02:49 +0100
Message-ID: <20241104170251.2202270-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Indicate that dwmac_socfpga has a gmac. This will make sure that
gmac-specific interrupt processing is done, including timestamp
interrupt handling. Without this, the external snapshot interrupt is
never ack'd and we have an interrupt storm on external snapshot event.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: new patch

 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 0745117d5872..248b30d7b864 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -485,6 +485,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
+	plat_dat->has_gmac = true;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.47.0


