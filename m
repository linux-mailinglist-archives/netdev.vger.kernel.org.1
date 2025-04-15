Return-Path: <netdev+bounces-182890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95894A8A46F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99813440543
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9529A3E9;
	Tue, 15 Apr 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dWVPmuqL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330221E0BA
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735402; cv=none; b=Ku67t+ih/mYW6HVrZ2qYZ7y8DED9F7ALyli7NpU3wFnOTtmPFLwntCvaZ2oJOfmK2SqdTpxIu50sxlcYOwikMC5fqeEmds58B7oTQCSfLhL1luF6HcxaHsI5FS2DDwqym/S3MXkNRlJ0+TTjx5bc0GIezuVMrY8VBdM0bYUzszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735402; c=relaxed/simple;
	bh=x1fB3pHBotfOi7mPT6sMh3Pf6evZj3XlHs//4cPj7+M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dSjlG09rqe/EG5BmTnP7EMtO/rozNq1BxqGDOfkWJ/ujWWKC6xKVeB7kb847qgTfbZBk/dbTZSxXIRIdd5GHhfBv6v4+IX5fvRoJ3iIAIs8wwZZ656to2T4Dcn6jGT4Ay3ciq2jx0lO7LHmKTb9XpzUUCcNJNRgShuSnK11ah78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dWVPmuqL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6j3qmk+PLNPRkwcbnRoXCkpFbV5l4jb32cwoTVChRAA=; b=dWVPmuqLkjRgDS4eABop1SUB+d
	j1kPQn2IN8b3fUtMYxTdiwHgw7Vj4k6Lt+pS4fofFOMk+VeOhohtBPX0PFbrbPJNiBNP53l0zz51g
	RQ6lAp2vQNgK+9RAXIKc9C8kOaGRWSyRgqYZOaaOaTsHYsqkJ5JWAGuRqjnaHioFFGivvPx0nYybZ
	uG2cC+17xP5j7/9/al5rBM0ztUnWyFzT5VgfpThJLlqFJWEdfkfvLYMbGiH/92jAIoyU9oF1a3DHJ
	zZKQJbh2Yrn4sjb9+mw2N+jdkjHj3EAcmjaSN7PwkDLJNDnFPNGffIK0NITKYeYC7axug2SJL226q
	KRPpytgA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44024 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jNP-0008WK-2D;
	Tue, 15 Apr 2025 17:43:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4jMo-000rCS-6f; Tue, 15 Apr 2025 17:42:34 +0100
In-Reply-To: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: stmmac: sti: convert to stmmac_pltfr_pm_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4jMo-000rCS-6f@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:42:34 +0100

As we now have the plat_dat->init()/plat_dat->exit() populated which
have the required functionality on suspend/resume, we can now use
stmmac_pltfr_pm_ops which has methods that call these two functions.
Switch over to use this.

Doing so also fills in the runtime PM ops and _noirq variants as well.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index b6e09bd33894..53d5ce1f6dc6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -298,29 +298,6 @@ static int sti_dwmac_probe(struct platform_device *pdev)
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
-static int sti_dwmac_suspend(struct device *dev)
-{
-	struct sti_dwmac *dwmac = get_stmmac_bsp_priv(dev);
-	int ret = stmmac_suspend(dev);
-
-	clk_disable_unprepare(dwmac->clk);
-
-	return ret;
-}
-
-static int sti_dwmac_resume(struct device *dev)
-{
-	struct sti_dwmac *dwmac = get_stmmac_bsp_priv(dev);
-
-	clk_prepare_enable(dwmac->clk);
-	sti_dwmac_set_mode(dwmac);
-
-	return stmmac_resume(dev);
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
-						  sti_dwmac_resume);
-
 static const struct sti_dwmac_of_data stih4xx_dwmac_data = {
 	.fix_retime_src = stih4xx_fix_retime_src,
 };
@@ -335,7 +312,7 @@ static struct platform_driver sti_dwmac_driver = {
 	.probe  = sti_dwmac_probe,
 	.driver = {
 		.name           = "sti-dwmac",
-		.pm		= pm_sleep_ptr(&sti_dwmac_pm_ops),
+		.pm		= &stmmac_pltfr_pm_ops,
 		.of_match_table = sti_dwmac_match,
 	},
 };
-- 
2.30.2


