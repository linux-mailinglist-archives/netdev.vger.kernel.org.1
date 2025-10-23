Return-Path: <netdev+bounces-232044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED96C004BD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895BC1A669B0
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A936309DCB;
	Thu, 23 Oct 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Bt7dords"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E086309DB5
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212291; cv=none; b=IAeUkFA0q5XrskL634EEoEBmudgvQcRQ9zZW6eGgXpHdb9ORIzKCEWLjEstBh1NBflc6PtLVyTZv3t6lW0R8TAI166Fx+BHht6vqQDizIMu2YCAlT7NVtCZlaspFrn+HxE4Ei+YbYkQvlKciUCTFSF3jy0GzRfb4jfF4IHpslXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212291; c=relaxed/simple;
	bh=BcnOiWBL4Go5sWSNiJNzkifS7cVfrUWj1dyA5O/ATjo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=j0unVSEUGwntNPj0iVhLf8PQ/bYvln7vyh3fWN7e4P1Kp/1bEycXRm6sz03d7x8kxl8RGkEHIhZfvwtDxRQudogB4Zz60QQcebgH4uXyvZ2M/QO5ICe0oRQ7fX/4hHWZ5Iss364OhX3akYudfAGwuTct3VYzEyad+kYlcAI9yyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Bt7dords; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MniIYTSwJIk75GMpBUMARg+pYB/eOzkAbdFT6RC+gSQ=; b=Bt7dordsneJhhdeW7PufVPwLMX
	ELdr/gvQ7hQOgQ2Qn1JNTbwka0lMYVO516kjO1aXsNryNkYsATgMJFF9zs5LBkUjH0GMDsNdEiIhq
	f/Y/aTdxIzoWLY3bCB/WuO4gvphD5OchqU+HCvCxuuxX2xrNSZVs0XO1TduW6ZEsD2C8wLTLEkitz
	2/TUbGg8lTAMQz3b9UjlV/lH5SbPVEYok2od0ouQ7H8u+PkX9YgKAPc1OTnJ6PdaVYNo2PSmsDAkg
	VT5kFVvLAFg8nv4H/Pw2MVNS9lFe5cjgzMQX+16r7hbTqLTjGLyo8MsH4mV/cp6uMX0SctB7CgYqG
	0QeWp7Qw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49854 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrlg-0000000066r-3zGv;
	Thu, 23 Oct 2025 10:38:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrlg-0000000BMQS-0QYt;
	Thu, 23 Oct 2025 10:38:00 +0100
In-Reply-To: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 8/8] net: stmmac: reorganise stmmac_hwif_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrlg-0000000BMQS-0QYt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:38:00 +0100

Reorganise stmmac_hwif_init() to handle the error case of
stmmac_hwif_find() in the indented block, which follows normal
programming pattern.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 72 ++++++++++++----------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 187ae582a933..0c187f8175b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -364,41 +364,45 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 
 	/* Use synopsys_id var because some setups can override this */
 	entry = stmmac_hwif_find(core_type, priv->synopsys_id, version.dev_id);
-	if (entry) {
-		/* Only use generic HW helpers if needed */
-		mac->desc = mac->desc ? : entry->desc;
-		mac->dma = mac->dma ? : entry->dma;
-		mac->mac = mac->mac ? : entry->mac;
-		mac->ptp = mac->ptp ? : entry->hwtimestamp;
-		mac->mode = mac->mode ? : entry->mode;
-		mac->tc = mac->tc ? : entry->tc;
-		mac->mmc = mac->mmc ? : entry->mmc;
-		mac->est = mac->est ? : entry->est;
-		mac->vlan = mac->vlan ? : entry->vlan;
-
-		priv->hw = mac;
-		priv->fpe_cfg.reg = entry->regs.fpe_reg;
-		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
-		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
-		memcpy(&priv->ptp_clock_ops, entry->ptp,
-		       sizeof(struct ptp_clock_info));
-		if (entry->est)
-			priv->estaddr = priv->ioaddr + entry->regs.est_off;
-
-		/* Entry found */
-		if (needs_setup) {
-			ret = entry->setup(priv);
-			if (ret)
-				return ret;
-		}
+	if (!entry) {
+		dev_err(priv->device,
+			"Failed to find HW IF (id=0x%x, gmac=%d/%d)\n",
+			version.snpsver, core_type == DWMAC_CORE_GMAC,
+			core_type == DWMAC_CORE_GMAC4);
+
+		return -EINVAL;
+	}
 
-		/* Save quirks, if needed for posterior use */
-		priv->hwif_quirks = entry->quirks;
-		return 0;
+	/* Only use generic HW helpers if needed */
+	mac->desc = mac->desc ? : entry->desc;
+	mac->dma = mac->dma ? : entry->dma;
+	mac->mac = mac->mac ? : entry->mac;
+	mac->ptp = mac->ptp ? : entry->hwtimestamp;
+	mac->mode = mac->mode ? : entry->mode;
+	mac->tc = mac->tc ? : entry->tc;
+	mac->mmc = mac->mmc ? : entry->mmc;
+	mac->est = mac->est ? : entry->est;
+	mac->vlan = mac->vlan ? : entry->vlan;
+
+	priv->hw = mac;
+	priv->fpe_cfg.reg = entry->regs.fpe_reg;
+	priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
+	priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
+	memcpy(&priv->ptp_clock_ops, entry->ptp,
+	       sizeof(struct ptp_clock_info));
+
+	if (entry->est)
+		priv->estaddr = priv->ioaddr + entry->regs.est_off;
+
+	/* Entry found */
+	if (needs_setup) {
+		ret = entry->setup(priv);
+		if (ret)
+			return ret;
 	}
 
-	dev_err(priv->device, "Failed to find HW IF (id=0x%x, gmac=%d/%d)\n",
-		version.snpsver, core_type == DWMAC_CORE_GMAC,
-		core_type == DWMAC_CORE_GMAC4);
-	return -EINVAL;
+	/* Save quirks, if needed for posterior use */
+	priv->hwif_quirks = entry->quirks;
+
+	return 0;
 }
-- 
2.47.3


