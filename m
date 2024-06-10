Return-Path: <netdev+bounces-102302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9090244E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8857EB26C8C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0312FF65;
	Mon, 10 Jun 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hgv+NT0z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF680BE5
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030464; cv=none; b=atdllxuT3BkpqeeL59VIiXZd+1fY7iLxDBH4O20dGU8h9wwf5VA5g+u+xippN2uUoV03lHVzwuryEZ5TDlrGw0IDuZLH2TmxX0i4mQ5E9JPu3Gl6ULi93Jum0nWGmz5uny5LL7Qz0/aGpVm57a8i8a9Z80hIUZQOtTS15DxgBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030464; c=relaxed/simple;
	bh=2oE/8hJn9cYyQuF73TPogjEQ0Ky8tE9HSDoZFULPWjY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gAzLgYnmuUA1Szv4S883k7NDCp0++/2AeZ20gFaCMnm5Jw7RaiZHytn4sbcHxIQl3BcWIA39B1w4Y5hUX03YD3h9zZYRHUomOFve9Web5rHsIx1MCx7DgPxZYTffefOH+Sj24TX/9ym60+eFzzMqQaURr4Lw92soSp9NEi0thCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hgv+NT0z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qnh/kTu/JXmNom+PLgMCpgP4S1lfWoc9AvP15HS0AJA=; b=hgv+NT0zRIBQvI29Nzf5xF1Ue7
	+ndz+46e+K4eYu8wTcm3elIntgAh7RFwXx4qwAREr4yDfX9tVRhMJdano4k7i41atq8AqutewPSao
	baEObDsNw/aumyQVjXCj+u3ZZnQYLH3w3W9HTYpkA75b3En3iKNMiFRtkOWQtace3sUq4oSFIv+2a
	m2J5KNC1CQhCYibD2RPdoP/GoyTdMAwM0L9j0NegrvhlnX569rlwvt0+e7NfnKKAPhmHllCLsKWPl
	nGSXhxY5c50Eft5rnSN35wbt8w7zOPSmEOWWHMOio0+KCQjhjukjNcWhXHlIozE5dmLCckhAU0VgS
	/8zF4kZg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55868 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sGgCU-0001fZ-1x;
	Mon, 10 Jun 2024 15:40:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sGgCX-00Fad5-92; Mon, 10 Jun 2024 15:40:49 +0100
In-Reply-To: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
References: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 4/5] net: stmmac: dwmac-socfpga: provide select_pcs()
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sGgCX-00Fad5-92@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Jun 2024 15:40:49 +0100

Provide a .select_pcs() implementation which returns the phylink PCS
that was created in the .pcs_init() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index b3d45f9dfb55..fdb4c773ec98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -429,6 +429,12 @@ static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
 		lynx_pcs_destroy(priv->hw->phylink_pcs);
 }
 
+static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
+						    phy_interface_t interface)
+{
+	return priv->hw->phylink_pcs;
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -478,6 +484,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
+	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.30.2


