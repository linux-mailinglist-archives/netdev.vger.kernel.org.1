Return-Path: <netdev+bounces-187235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F237AA5DF8
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE681BC4901
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E29225416;
	Thu,  1 May 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lKtWt8kX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B8224B12
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746099974; cv=none; b=DLKhIvg73gDq6O3xu1d8Ff8xM/5UUdbQKeMN8S1ThRbL+5H8kQhRgU2wP9cC8E+IW+3YLrDrRGgmZs6q/ki+DIhobuYtprNL0XNkSenXoi46xm4Am80GzHXLeCMW0J8+JHMCJ/fhSHAV8M5edH4Aj94s1SRBypF23kihO4Suk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746099974; c=relaxed/simple;
	bh=nR2EMxi+rY7fLTrDgvNtvKyEGsad1Zdk9KXAbH/8ZX8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KAuHYyp1l1ShL3I7dAQJz0Asf4/39K6qUoxANu3dp287Sw8oj9fA1USSQM4+U2QZc59FxYdQaCaZO9nFwDQ1vlX0YHJT6HXJtEzOgnbaVTbLcf77Xf1WbdFgb3aEaOY+ekI7Cb1qCucsrAE48Onlqxim6H7hqV4dyJ0wTgqfVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lKtWt8kX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vuFYQlpiboXulQVdnqCW/1ad3TJohzHdDO8kExCfgss=; b=lKtWt8kXWhnA4/k3Y+/frnORrS
	JOrP8BIAc7PoPCw7DvS2Rjlo2CNt5BGWoFoNtQHTY/jp7PhWWBJ5wP1JmLPVp8oKEbipGACerL2Ib
	4d8sW0w+l7BWElR5d7ekXHCNEeSGHkEfClq69MVtIZPmAPWDJmNBqf386RI33UvbjcOZoCQsn1T3v
	9CInpFHH9KjtxPaXsdWjmT1vbuht3oIf10nRj+SjmsHMR9rpkOqifREsm/YnPM1j8qA1zcfaCQZsR
	ob1erFbwKvTRX0cn+TK3x6uFjCzjBzQ5ZmRPfzlJX6HCgXZvmYOhvEIeNtndm8pu+nD9m4lkQUuUf
	3Q/CtabA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52288 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uASMf-00005x-1P;
	Thu, 01 May 2025 12:46:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uASM3-0021R3-2B; Thu, 01 May 2025 12:45:27 +0100
In-Reply-To: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 6/6] net: stmmac: remove speed_mode_2500() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uASM3-0021R3-2B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 01 May 2025 12:45:27 +0100

Remove the speed_mode_2500() platform method which is no longer used
or necessary, being superseded by the more flexible get_interfaces()
method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 include/linux/stmmac.h                            | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5f66f816a249..28b62bd73e23 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7736,9 +7736,6 @@ int stmmac_dvr_probe(struct device *device,
 		goto error_mdio_register;
 	}
 
-	if (priv->plat->speed_mode_2500)
-		priv->plat->speed_mode_2500(ndev, priv->plat->bsp_priv);
-
 	ret = stmmac_pcs_setup(ndev);
 	if (ret)
 		goto error_pcs_setup;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 537bced69c46..26ddf95d23f9 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -241,7 +241,6 @@ struct plat_stmmacenet_data {
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
-	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
 	int (*mac_finish)(struct net_device *ndev,
 			  void *priv,
 			  unsigned int mode,
-- 
2.30.2


