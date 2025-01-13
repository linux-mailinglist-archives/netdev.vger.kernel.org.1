Return-Path: <netdev+bounces-157722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5DA0B602
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551FE1887FB3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837C22CF35;
	Mon, 13 Jan 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UzuOxMvT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7922A4C5
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768802; cv=none; b=BwqOH6GkZ3aJrpFzZmj5SCABwsKr6DKZ2Bvnqq9S7glZR0/gqQ0XGH+lePWKsEVxzhwsUIfnO+hEHMxiONCv3+6dfGzH2AxKxyGYP8jxIBXdgs/vFu8R8O+nAJg40wYk4hht1kHyXGYaIH2c/F6Z1FZDWWf0wb1q1ycAn4CfWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768802; c=relaxed/simple;
	bh=xJyD7NPSh+P4+8QSZgIofTL/eaFQt8sBnmAzer6CPt4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lPf2UJKW+e+lJB3Gf4+xD9r5s8wi//kG9g+9fRrtzrA7mttN3wo/edSeyZxB2lxtY8Dxjg7e3DWp35bkSwdAPL/bRhfNgp0YkEIHrcyXlVdUtCorHffCSalWidDASRCTugp84uoPTRwjRzi+vbWy9uV283b7MFdgB1J3JbIpiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UzuOxMvT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GEgZ/SvmKDS++MiOXpGxNiPvw6lP1RjmRHXTj59mUno=; b=UzuOxMvTAtG53wSYLB9oUkGFls
	0rdlR3mVUqQ5GeDjecci/PdH1Oe6/DtNZDKkXASsZRzNygPm42/To8o7qYkgSfdbtcx08lY25/ZrN
	hjfhQZJBLUGfRUelbeL5NL+bGjX6pmNXrUKU/9G6PJi4dMVgXdU8CPlnz/ImrwGVp04rZmxPafuw8
	9SehgNL4lnFstOOuELO1LBX5s/1fbFyhTER+/1Ue7/7VB5if5o9Gvls1vCWu74/nh9yWsxk6QZtbb
	mLcvTRhxWgXXslab5EJObH47SZHpUGpI6lrKF2WQyGc5fyfTeDz16l56JG8ibY7LrB1lRKg8eKVq6
	Csr5FThA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38262 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItu-0006Wn-2f;
	Mon, 13 Jan 2025 11:46:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItb-000MBa-OU; Mon, 13 Jan 2025 11:46:15 +0000
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
Subject: [PATCH net-next 8/9] net: stmmac: combine stmmac_enable_eee_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItb-000MBa-OU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:46:15 +0000

Combine stmmac_enable_eee_mode() with stmmac_try_to_start_sw_lpi()
which makes the code easier to read and the flow more logical. We
can now trivially see that if the transmit queues are busy, we
(re-)start the eee_ctrl_timer. Otherwise, if the transmit path is
not already in LPI mode, we ask the hardware to enter LPI mode.

I believe that now we can see better what is going on here, this
shows that there is a bug with the software LPI timer implementation.

The LPI timer is supposed to define how long after the last
transmittion completed before we start signalling LPI. However,
this code structure shows that if all transmit queues are empty,
and stmmac_try_to_start_sw_lpi() is called immediately after cleaning
the transmit queue, we will instruct the hardware to start signalling
LPI immediately.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 677a2172a85f..72f270013086 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -422,27 +422,22 @@ static void stmmac_restart_sw_lpi_timer(struct stmmac_priv *priv)
 }
 
 /**
- * stmmac_enable_eee_mode - check and enter in LPI mode
+ * stmmac_try_to_start_sw_lpi - check and enter in LPI mode
  * @priv: driver private structure
  * Description: this function is to verify and enter in LPI mode in case of
  * EEE.
  */
-static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
+static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
 {
-	if (stmmac_eee_tx_busy(priv))
-		return -EBUSY; /* still unfinished work */
+	if (stmmac_eee_tx_busy(priv)) {
+		stmmac_restart_sw_lpi_timer(priv);
+		return;
+	}
 
 	/* Check and enter in LPI mode */
 	if (!priv->tx_path_in_lpi_mode)
 		stmmac_set_eee_mode(priv, priv->hw,
 			priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGATING);
-	return 0;
-}
-
-static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
-{
-	if (stmmac_enable_eee_mode(priv))
-		stmmac_restart_sw_lpi_timer(priv);
 }
 
 /**
-- 
2.30.2


