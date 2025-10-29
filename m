Return-Path: <netdev+bounces-233699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD6C17760
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9D1A21382
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE11CAB3;
	Wed, 29 Oct 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WsDF+H4z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985FF9E8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696205; cv=none; b=L1AirWTVE/iaukAAXK98AzXB8K9joL11P3EZw/Pvk6jfNQeMouD+/lYENoiOom19DGacz2ArEMwb37G5+cNGFpgI40Lgv7OGAvSMnekh3I8qF3fyoDZ4wCwQLJDPZ/P8KRowuor8K/Dnf48pGSPdEXkaw5ggXPmbjjtEVAteQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696205; c=relaxed/simple;
	bh=ZR431G0D+JxxCHr6OR20vQk7b99RLGPvT88tdRpCa2w=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MucolsD6w0OLA4G/AZzd9ys1bE0wbuaY1IywQQR6ieuE1iw7Adw4wgOL04PunvSIC6ed6SgYnZfzl67yb4TVJorw2Kb4ByYzVpmZ9UEVt1fE2YLatifJgDyOWA7NnaC09BdTtoskD2m57+pYtKNbJ2cWt7kkfI1P9KLXDjb1J0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WsDF+H4z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q+Sn/ZaE2pW4I+k9n++I48OlOtx1MXpzYWaNdIX9qzc=; b=WsDF+H4zA8zx0Q/KMHayNmq8c5
	nVWittVYqpxxvZMcRiRF97RHPkDdI0Z9yPDUWGNeqmvPJdLQZI4uRbN8ISQFOSzRAnMNfoZqchRiv
	vsxNy5QN/eatEcYkP7n0SrBZBSyOxlgZ3v5lkgSzu3P1/gLd9LyRV0oEVCrLcOzaP1awp96cB+iiX
	qWVJ7ef9eQSjF64qvQGfe9kM/jpoI3OUcmYlqgV8APbKBCiYzlkakH7KD/NwXh3HRtimXL+28Y7Fp
	bGe6P2DiG/sm1VlNAGAru2l5wDH8Bs8th3LwJmQ1rBDBNvv33mDEwjNQyRyCKpVPaI65910GuDRDM
	yqQyG1yg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54984 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDtem-000000003gj-33e5;
	Wed, 29 Oct 2025 00:03:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDtel-0000000CCBx-3Lpf;
	Wed, 29 Oct 2025 00:03:15 +0000
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 2/8] net: stmmac: simplify stmmac_get_version()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vDtel-0000000CCBx-3Lpf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:15 +0000

We can simplify stmmac_get_version() by pre-initialising the version
members to zero, detecting the MAC100 core and returning, otherwise
determining the version register offset separately from calling
stmmac_get_id() and stmmac_get_dev_id(). Do this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
--
v2: fix "verison" -> "version" typo (and subsequent patches)
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 4924e74997e4..f6ada5a905fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -49,18 +49,22 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 			       struct stmmac_version *ver)
 {
 	enum dwmac_core_type core_type = priv->plat->core_type;
+	unsigned int version_offset;
 
+	ver->snpsver = 0;
 	ver->dev_id = 0;
 
-	if (core_type == DWMAC_CORE_GMAC) {
-		ver->snpsver = stmmac_get_id(priv, GMAC_VERSION);
-	} else if (dwmac_is_xmac(core_type)) {
-		ver->snpsver = stmmac_get_id(priv, GMAC4_VERSION);
-		if (core_type == DWMAC_CORE_XGMAC)
-			ver->dev_id = stmmac_get_dev_id(priv, GMAC4_VERSION);
-	} else {
-		ver->snpsver = 0;
-	}
+	if (core_type == DWMAC_CORE_MAC100)
+		return;
+
+	if (core_type == DWMAC_CORE_GMAC)
+		version_offset = GMAC_VERSION;
+	else
+		version_offset = GMAC4_VERSION;
+
+	ver->snpsver = stmmac_get_id(priv, version_offset);
+	if (core_type == DWMAC_CORE_XGMAC)
+		ver->dev_id = stmmac_get_dev_id(priv, version_offset);
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
-- 
2.47.3


