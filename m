Return-Path: <netdev+bounces-68919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CB848D6F
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C732D1F21ADC
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439122232B;
	Sun,  4 Feb 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TGhkSIN8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24821224C7
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048803; cv=none; b=nTVxgrfvW7xOU+lp5H/xkW0AWfuIigTohLfxG6S7sO7WwCN8rDY2o9yZj53IEfLFnCM/3nmp4mToHbqmhjAl6J78VsZcBXXrL4VO2b2bBh7N9EHI1JVftqQ04HUxV9Ioj60AIod/dCJ+4tSQOXLVIn1nKie8SmUl462jdWlQuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048803; c=relaxed/simple;
	bh=FkglyUFLVGmgzghevLu312fm+xgqILeVVXK2NfkgNQs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=L046e6dKocjoYOziHwANxnd/VPeC8VH7DYESEf8/fLImSWHJVtvJnwBCVfJWxQwpccBCWTd2PBcGxK22gAmtEcRxf3pTn77Cw4PC7eYQwXtk3pPt9SgaWuHEh05oeAwPeKXPaYS/I+B+Yd9xsMBAprRG0WzObB1Nw4ElC1nRwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TGhkSIN8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SyevgUi2ILXbA7HnAxNwt9Z0WARK1WXsvJNPF6r31mA=; b=TGhkSIN8AK0mEzgsm+0WduSUtT
	0Lpzr26do4PDSHZNO7OiTXR9Y7x8V9KzFHkD078l1vdETfYvbll9fVlejdGOZ6Qie7opGiKYkj0EW
	V05WfQ1kzRcZqGuKvaGCF9cmQlfjvjK9Ht9ZAgw9UGj3LJ/7lTUuwUPvnLZItvpA4k311+SLD+mHR
	Rxms0Yc3iMU1zgEtPXjicfDP2/9UWa1/hupjrOvqhxeppfIFvUsFE7xmLIW8fXTAhBILeVjKRaBdd
	OTPjvXeQcQ3iYQIWoL8ml6N0vFlpEfNit0OqvVIibflHR/WeQH/MfoJ85q3fMAGDLqWhZo2g8OLoP
	e5IzOUXg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56018 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rWbMy-0007vx-1z;
	Sun, 04 Feb 2024 12:13:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rWbMx-002cCb-IU; Sun, 04 Feb 2024 12:13:07 +0000
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
Subject: [PATCH net-next v2 2/6] net: sxgbe: remove eee_enabled/eee_active in
 sxgbe_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rWbMx-002cCb-IU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 04 Feb 2024 12:13:07 +0000

sxgbe_get_eee() sets edata->eee_active and edata->eee_enabled from its
own copy, and then calls phy_ethtool_get_eee() which in turn will call
genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Therefore, setting these members in sxgbe_get_eee() is redundant.
Remove this, and remove the priv->eee_active member which then becomes
a write-only variable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h  | 1 -
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c | 2 --
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
index d14e0cfc3a6b..1458939c3bf5 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
@@ -503,7 +503,6 @@ struct sxgbe_priv_data {
 	bool tx_path_in_lpi_mode;
 	int lpi_irq;
 	int eee_enabled;
-	int eee_active;
 	int tx_lpi_timer;
 };
 
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
index d93b628b7046..4a439b34114d 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
@@ -140,8 +140,6 @@ static int sxgbe_get_eee(struct net_device *dev,
 	if (!priv->hw_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->eee_enabled = priv->eee_enabled;
-	edata->eee_active = priv->eee_active;
 	edata->tx_lpi_timer = priv->tx_lpi_timer;
 
 	return phy_ethtool_get_eee(dev->phydev, edata);
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 71439825ea4e..ecbe3994f2b1 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -130,7 +130,6 @@ bool sxgbe_eee_init(struct sxgbe_priv_data * const priv)
 		if (phy_init_eee(ndev->phydev, true))
 			return false;
 
-		priv->eee_active = 1;
 		timer_setup(&priv->eee_ctrl_timer, sxgbe_eee_ctrl_timer, 0);
 		priv->eee_ctrl_timer.expires = SXGBE_LPI_TIMER(eee_timer);
 		add_timer(&priv->eee_ctrl_timer);
-- 
2.30.2


