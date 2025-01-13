Return-Path: <netdev+bounces-157721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A1A0B600
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F52166A5F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D7C1CAA67;
	Mon, 13 Jan 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CEVqnTPu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1A46B5
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768799; cv=none; b=Upo9OPFp1ygmvPCfEbHfiI2Z93EY7Ul6936NyjedD4ZtdFsj8LpAxNqeylO9SiLo3ZNOneMUJdpn3s46J/awVBkBIVZIfY7o5rzgC3pi90jnR0yxfV6XcglPAOpXIqJrRMVmMfn2mndCHBy+3b6a2BspH3vSUo2KKnpr95sUVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768799; c=relaxed/simple;
	bh=SaWVE/5wGJByMRjrQAekiSQEyKV2wptipXfyzNG2sJQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=D5QgbBAADTPSNCz3KUpdQnM7Yv5Mc3zvs4ggKvtCV9b6ei43pt7POW0KKn1CrhW/WkVsZh3NTlGMWV/puwBgMvNORfALN2XkwzPW1ZNjDb6p93xeQ5StDv/9q+obbYZOfypuBgCSVEDhjsaJ4jPBjRm3R3qDjq9go9NEs5AYjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CEVqnTPu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OlZYWPX0QNCSKKO5JWx1URTrYTNj5bjTeUg1yJzKm6g=; b=CEVqnTPusTw+aupRrYqlu84HHr
	/uDDsggTdYHG/CMitY1r+ceWHqYlZxEnITYNiOoqAhCbEbg8LuDndZA2x8+B74LGUlk0xjizBemZY
	4MLhDG3qwEc/fn4P8fhTQEL5psw6fJsvJ3xYEJSm7ZoUqaUMBa2cVO4vPDBWEATKxqsPljsEjgAVb
	RAKjZqFXH7GpllEcahl4sbFKHZvhCZH3SgBNFfuzmVNWaD0lZBmaweN1ui4sj2ug2lSy3BAd/L8Q0
	/T94hvXNLMlEKf5R0f9lq8rVBlt8IMk7IuR7XkaCvdH9uKB7207cUoIp/eadNipG0So3kunn+R54S
	sx0BhEeg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45902 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItp-0006WZ-26;
	Mon, 13 Jan 2025 11:46:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItW-000MBU-KQ; Mon, 13 Jan 2025 11:46:10 +0000
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 7/9] net: stmmac: provide function for restarting sw
 LPI timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItW-000MBU-KQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:46:10 +0000

Provide a function that encapsulates restarting the software LPI
timer when we have determined that the transmit path is busy, or
whether the EEE parameters have changed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ddbcbe3886c0..677a2172a85f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -416,6 +416,11 @@ static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
 	return false;
 }
 
+static void stmmac_restart_sw_lpi_timer(struct stmmac_priv *priv)
+{
+	mod_timer(&priv->eee_ctrl_timer, STMMAC_LPI_T(priv->tx_lpi_timer));
+}
+
 /**
  * stmmac_enable_eee_mode - check and enter in LPI mode
  * @priv: driver private structure
@@ -437,8 +442,7 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
 {
 	if (stmmac_enable_eee_mode(priv))
-		mod_timer(&priv->eee_ctrl_timer,
-			  STMMAC_LPI_T(priv->tx_lpi_timer));
+		stmmac_restart_sw_lpi_timer(priv);
 }
 
 /**
@@ -526,8 +530,7 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 		/* Use software LPI mode */
 		priv->eee_sw_timer_en = true;
 		stmmac_disable_hw_lpi_timer(priv);
-		mod_timer(&priv->eee_ctrl_timer,
-			  STMMAC_LPI_T(priv->tx_lpi_timer));
+		stmmac_restart_sw_lpi_timer(priv);
 	}
 
 	priv->eee_enabled = true;
-- 
2.30.2


