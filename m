Return-Path: <netdev+bounces-164667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E6A2EA2C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EA9188C363
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153441DF26B;
	Mon, 10 Feb 2025 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TYpTedd2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CA1DFE18
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184868; cv=none; b=Yx3vYte6GI6C2dXW68BmoHV0NQLijJyjPhDp4VfTLCxttoBwy4MZ2bw2zjkJx+IrdOz+5Gs+ozrX2W0jHbQ3ma+t/F9+sAwJZGkPBZFvkymH6ZT7POgTsP+lHiGmhvu+CtVW8KdS6jp77KfKLhsdeqZPtzPUUFVW0uiHRn5uAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184868; c=relaxed/simple;
	bh=50LzgtK24bUtzJoh7LuTX6+iUSXjSrkKf94Nub1yn3g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=C76wljn431vlHjllvRrTVQDShty51ZVzBg/W9oEe3dgQDzOEmDITzCwE/x8V86nSJqQTaRseK+N6fXnXQCeB9k+ig+x2KltzqVZIfdMXj3AWtC6y4W45e1Te7EJEeW5sXX4+KkaAgOShLKIBa3yGIByn8JN59AdOt+fTBZWkpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TYpTedd2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ELqbi+gpufx0/yKmKxb0he5MB5h1Oc7NMvQUCKuJaVA=; b=TYpTedd21CZ6jBLg3V5dD3+HSa
	qgu4+FBV/vgxPPur1vSkX1Vmo2eu8ptRqW5mwdO+GP6n5IhFvghpxxjWSEFS+w0es/Qqb0sXYdCLm
	Zew+RYmfT2V2TaDZRH70rmfJfUS+Mx81MdaMbLAcbZ1j30NDuiYFgKVtewgYcP0OgumxhLM31d969
	osBtwEfS9Gp9XTtbNlyg/wPySSF3PBOyGP/0PIFoVvONn9wHJE9Ma01QfrODPvkafqk13rjBDkXzi
	MDW38i5QlrFUClG+j+7PMGO+9i5RVXil0uyoMWextRWyPOReuA1yIO6E90BtnqZo1Dvv0G+nqSent
	zbCTJt2Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48442 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRQh-0006WH-37;
	Mon, 10 Feb 2025 10:54:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thRQO-003w7I-Ap; Mon, 10 Feb 2025 10:54:00 +0000
In-Reply-To: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
References: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/8] net: stmmac: remove calls to xpcs_config_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thRQO-003w7I-Ap@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:54:00 +0000

Remove the explicit calls to xpcs_config_eee() from the stmmac driver,
preferring instead for phylink to manage the EEE configuration at the
PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3b77597ada52..526df6fd732b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1046,10 +1046,6 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	priv->tx_path_in_lpi_mode = false;
 
 	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
-	if (priv->hw->xpcs)
-		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
-				false);
-
 	mutex_unlock(&priv->lock);
 }
 
@@ -1068,9 +1064,6 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
 			     STMMAC_DEFAULT_TWT_LS);
-	if (priv->hw->xpcs)
-		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
-				true);
 
 	/* Try to cnfigure the hardware timer. */
 	ret = stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_TIMER,
-- 
2.30.2


