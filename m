Return-Path: <netdev+bounces-154973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE4A0087F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44A97A1229
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84B1F941C;
	Fri,  3 Jan 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gOefpy8x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5B1F9F61
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903030; cv=none; b=nTi2PNhGNIGvj9kwwO4KHrljxZBPRnoY1Yuxa0k99WRRFcP+ism2ZGBk90XOom4ZOX+GWN9xBLzZbFp3XPKPuo59U4QyJ3cleuPPLClUe7jklp29D6jEP7vShrrt8eYvoOA8DN8o/Dq4GGuceMweW7okvxkdyR27+g2qmA5cfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903030; c=relaxed/simple;
	bh=NKj6sffVv1j95XX7EjHNIn9LNv9+aZipHpCrib03IA8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qvEs00CQZnW5lHy9Mq/mX2QzWeylwzWmK7LzIjWtuCXX/t0ou1BGuCzw6mXjrkImE7jBGqPZh2MeXoc2fPf3w2rGbrPAr/sFWlF6UfyHNw0FFKl0QXGS75QUpLbcjBj3kfTgEFKII9S7qzBAl4H5Hup75ocx+KahopVIZ3UO2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gOefpy8x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3fPVeRok7tYyHKGOJNHqGUAhct3mDxnPXluFsW2qsWM=; b=gOefpy8xxs5g/L1BY+Zh8RPhQj
	v9KfDZSN/ifIgCYkqe781yncGB0YH4fGoElH1eC5LYFFI9M2MOf6DAGXcmDfGLooBdkujx5X1XBOi
	tqOKjWrTLKzx+8/FB6B18Y3o7ICKFHioYewNNR0KdPC/wjOLne5MnMloOeujheh+51WK/18y5hUc+
	V8kwKQ6mzN/FsYHidfWMW67ooW4EppvxiUiZCxhqH9n+QWahTgSgDznMDQcOAv3e9zDRDAmdl5Ua4
	mhEC7/GoL07FAZA8+OH8tjwu+DR6Euq+BzoCOZeI94cM3vRJEZHyHy6U9kwkp6aGSQoyPq23aQF0q
	/42PUrSA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50410 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tTffd-00030z-1d;
	Fri, 03 Jan 2025 11:16:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tTffa-007RoV-Bo; Fri, 03 Jan 2025 11:16:46 +0000
In-Reply-To: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/6] net: pcs: lynx: fill in PCS supported_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tTffa-007RoV-Bo@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 03 Jan 2025 11:16:46 +0000

Fill in the new PCS supported_interfaces member with the interfaces
that Lynx supports.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-lynx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 767a8c0714ac..6457190ec6e7 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -334,9 +334,19 @@ static const struct phylink_pcs_ops lynx_pcs_phylink_ops = {
 	.pcs_link_up = lynx_pcs_link_up,
 };
 
+static const phy_interface_t lynx_interfaces[] = {
+	PHY_INTERFACE_MODE_SGMII,
+	PHY_INTERFACE_MODE_QSGMII,
+	PHY_INTERFACE_MODE_1000BASEX,
+	PHY_INTERFACE_MODE_2500BASEX,
+	PHY_INTERFACE_MODE_10GBASER,
+	PHY_INTERFACE_MODE_USXGMII,
+};
+
 static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 {
 	struct lynx_pcs *lynx;
+	int i;
 
 	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
 	if (!lynx)
@@ -348,6 +358,9 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 	lynx->pcs.neg_mode = true;
 	lynx->pcs.poll = true;
 
+	for (i = 0; i < ARRAY_SIZE(lynx_interfaces); i++)
+		__set_bit(lynx_interfaces[i], lynx->pcs.supported_interfaces);
+
 	return lynx_to_phylink_pcs(lynx);
 }
 
-- 
2.30.2


