Return-Path: <netdev+bounces-68918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F8848D65
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E81F21CA8
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219422098;
	Sun,  4 Feb 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xLyOxf3j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084312230C
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048797; cv=none; b=UD4RjN5XBGciTUMLslK9lao7omVebldzF10grBWIv3p1GvMRTj3rL1uLnm5l2Qa6g3IePiTLB3v5ZCTqXC/ilIzDPBggaA6YX/5DHDUrrKteOpnA6cdHgWsY2epqHuGaK6GO5QdsHyK7HfgQHuMx7M4XF0KE1dXTRNTkVW7ANsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048797; c=relaxed/simple;
	bh=iit7EVEbjSF4MpIqoLBpg8LtBq1xpqRXFgRC5EHgCSg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FkaIkO85OM0Se22z07AHh/9qV6iLPk0ehJaj7bZK/RjyJhxGtlkUFVNVPTFcW9TyelSTv97GhrZ+IHeGt1Fq6VjB9YQHOJkEn1tSy694v9bJJaIvLvp3cj7Lel5Oz9YnPCwe1ZOveEDZnsquVycsWrn9gmpTT6M35cjrhUfT6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xLyOxf3j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9TY+u62AIM3bIGhcSG/JvkNxj/XTkNruEmxy2Od3+9o=; b=xLyOxf3jDB9kplfJSOsQvCLQJY
	1nDryOf3Z6rODzM8WNjEQd1EeJQsohnR2+R13DkAQ3B7s41NxwBSulPRYnOvDQRF5VCRCK8jYfDw8
	xi0iWThDgMJXc72FC8kcWcilFfIU2yOLWct+hp+3D08hQy08k0U0xhGMgVNuTEzgeRNKYsx0Ae0kZ
	C4/oAhc5NthxmqvcQtS87bYEMZDjjR/KhhwBgIzZUCZeoj200pHE/6ljiN7jTrHqGzTi1g/LdaCK0
	qRmi3g24Lkkjv0Am4TA9DfY3FkImMFLriKdgXr/k2wcV7LXUAKE9tdATrtkJyOirFAfc4BfXgFstb
	rfWoQGjg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56012 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rWbMt-0007vf-1K;
	Sun, 04 Feb 2024 12:13:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rWbMs-002cCV-EE; Sun, 04 Feb 2024 12:13:02 +0000
In-Reply-To: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next v2 1/6] net: stmmac: remove eee_enabled/eee_active in
 stmmac_ethtool_op_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rWbMs-002cCV-EE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 04 Feb 2024 12:13:02 +0000

stmmac_ethtool_op_get_eee() sets both eee_enabled and eee_active, and
then goes on to call phylink_ethtool_get_eee().

phylink_ethtool_get_eee() will return -EOPNOTSUPP if there is no PHY
present, otherwise calling phy_ethtool_get_eee() which in turn will call
genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Thus, when there is no PHY, stmmac_ethtool_op_get_eee() will fail with
-EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
userspace. When there is a PHY, eee_enabled and eee_active will be
overwritten by phylib, making the setting of these members in
stmmac_ethtool_op_get_eee() entirely unnecessary.

Remove this code, thus simplifying stmmac_ethtool_op_get_eee().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index bbecb3b89535..411c3ac8cb17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -859,8 +859,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->eee_enabled = priv->eee_enabled;
-	edata->eee_active = priv->eee_active;
 	edata->tx_lpi_timer = priv->tx_lpi_timer;
 	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
 
-- 
2.30.2


