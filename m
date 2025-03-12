Return-Path: <netdev+bounces-174324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5198A5E4AF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7DA1886C60
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D6258CD2;
	Wed, 12 Mar 2025 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0vw3r5Mr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A37257458
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808620; cv=none; b=t7TcZ7Eb6pYUNQ3lbIe5HhblVTAT2523gyQLEJaqdBCHolnAOYjz+451E8tL4DZ6KbfoWq3xfGCaa4DGzoYo36mGTfHl1zJfOxTOzzxXSYOrT6BfUjKb36MI9YAPSxWnhyfhgD68Cz8TDr5aZVhI78ldDN/BRuTdV+PIdWCIYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808620; c=relaxed/simple;
	bh=PIP3ddYPAey6JiO0z7MwDt2G2nT2St7b2zoYdFWfdxc=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=no7fZRjTyX+fejEALa2331/qcGRJdw3dp602EaCUvm3MHDCDUjPYKKtJWxvQ3UsFu/eri71382zLd6dOTZMq8ABxpfRdxpUIgfYaqMNIo96qOV48VHM9OPYOzRC+zMbsoF7lPXgJlxz+42VYkHZokxIHyOpzmnDsosAcP5hVP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0vw3r5Mr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hNZU7Eufd1JegykKvVAxyzlCRzhTF9+s3bvb0sxIJX0=; b=0vw3r5MrcHlD21PyA7dl1mK4Kg
	ufSmqwKJDBV7slfX+xao+ZepvMw1mX1QA4f88351Me+OPN4sePXP4CmjSE6b6psd60uCnu/kTLe1Y
	xNgFMCUgcHk8oLevRFWtxMTLDJkg18Nq3oOOk/QefBWwuDV46iJCBWgFDuHy+u1Q7KiOEWNogwLfY
	j4dXk8xqzHPdYnVOhTryc6CmsIN+atWh/8TykZ3g+kA3bakaWXEGdsW6VrXO8+o6ZgtMVmRdePNvA
	tBdCG1wWJv/T0o7DOFJz0BruOt/VpMNJzRGGunRBw5f6oxthrbCSOPULsXrILs0iqxa0Y3v+lRjsg
	2aGRjHVw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42086 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tsRzG-000647-0E;
	Wed, 12 Mar 2025 19:43:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tsRyv-0064nU-O9; Wed, 12 Mar 2025 19:43:09 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joao Pinto <jpinto@synopsys.com>,
	Lars Persson <larper@axis.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: stmmac: dwc-qos-eth: use devm_kzalloc() for AXI data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tsRyv-0064nU-O9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 12 Mar 2025 19:43:09 +0000

Everywhere else in the driver uses devm_kzalloc() when allocating the
AXI data, so there is no kfree() of this structure. However,
dwc-qos-eth uses kzalloc(), which leads to this memory being leaked.
Switch to use devm_kzalloc().

Fixes: d8256121a91a ("stmmac: adding new glue driver dwmac-dwc-qos-eth")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index bd4eb187f8c6..b5a7e05ab7a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -46,7 +46,9 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 	u32 a_index = 0;
 
 	if (!plat_dat->axi) {
-		plat_dat->axi = kzalloc(sizeof(struct stmmac_axi), GFP_KERNEL);
+		plat_dat->axi = devm_kzalloc(&pdev->dev,
+					     sizeof(struct stmmac_axi),
+					     GFP_KERNEL);
 
 		if (!plat_dat->axi)
 			return -ENOMEM;
-- 
2.30.2


