Return-Path: <netdev+bounces-151648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC89F0736
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DE188BDDB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9961B0103;
	Fri, 13 Dec 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YQIiuthd"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B321A8F8E;
	Fri, 13 Dec 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080736; cv=none; b=f2aYk4TGwv5XmyRCo6w5AyCHqoFwxllSSyAfxLxINATP3D1+DDuYth3p5J+bUGOPcrSh9Lc+xX3hSACwz5GT+Pxa1jHk0KjHEAQsugsBNF2dLP65uUJn2LpIYyR7wG2Y/IYC89fH9IKFNFdtRENOh+gOI+VvVg1BT14taqUwjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080736; c=relaxed/simple;
	bh=ilBWFqgVq7yPwsRijdnlrldsqjALC5AeeR5ONIWaYUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNcBRIxMUAaop4gTW2yesEHXs0XDcgpx1rVl499Z+XlmXMiehD3CIFAVWcA4+7ytOs4o/TyOyLp3KB/FLT3JBicItdOW6CKUu/i419fL6mxG8cOlZfdVqkdRRE8HzMJdnDnoJ04OvTF0Y0NtiOsxdz9wYA8yIM5Oopp8JoMLMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YQIiuthd; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A141E1BF209;
	Fri, 13 Dec 2024 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734080732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKPP2QZefEX/1xcDDWpR3rAb+ukEcDE/pNkA8dPwcZM=;
	b=YQIiuthdBqmu2By5+3wovQpNCgKIdq5aY+qrlpi1ANVyS5lJIrMMmLk3OsmBCKst3VMhlL
	sspuybomI1+fRmzNfp5flaYkXPtIceyJToBmlKlNsbfyrh32GWxzcvw5G4UXFjKPLy0bYu
	qIPTR4FKC31tmwFJV3UVMGl6kx1M0FVS3fE5CMNJC1hTReMMTRNwxMXxfkMVPLx04b24ZA
	qe73thbJpQ15jzIYcLRECkTJvpSji8U4cgGnrkHbwCFquh9c7c9PvAcPevSziXlVHwAoxj
	MSpWkoLIsWOz9hDeucZIaSUx5Phtod4t04K+OppfxGM5WEM4eBO9iJQb5edRMA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface modes from Lynx PCS as supported
Date: Fri, 13 Dec 2024 10:05:25 +0100
Message-ID: <20241213090526.71516-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Socfpga, the dwmac controller uses a variation of the Lynx PCS to get
additional support for SGMII and 1000BaseX. The switch between these
modes may occur at runtime (e.g. when the interface is wired to an SFP
cage). In such case, phylink will validate the newly selected interface
between the MAC and SFP based on the internal "supported_interfaces"
field.

For now in stmmac, this field is populated based on :
 - The interface specified in firmware (DT)
 - The interfaces supported by XPCS, when XPCS is in use.

In our case, the PCS in Lynx and not XPCS.

This commit makes so that the .pcs_init() implementation of
dwmac-socfpga populates the supported_interface when the Lynx PCS was
successfully initialized.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 8c7b82d29fd1..ff9a30afd7e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -425,6 +425,17 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
 		return PTR_ERR(pcs);
 
 	priv->hw->phylink_pcs = pcs;
+
+	/* Having a Lynx PCS means we can use SGMII and 1000BaseX. Phylink's
+	 * supported_interface is populated according to what's found in
+	 * devicetree, but as we can dynamically switch between both modes at
+	 * runtime, make sure both modes are marked as supported
+	 */
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  priv->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  priv->phylink_config.supported_interfaces);
+
 	return 0;
 }
 
-- 
2.47.1


