Return-Path: <netdev+bounces-68378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D626846C29
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E1A28427C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1B78B66;
	Fri,  2 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EAa2XEyZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEDE5B020
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866464; cv=none; b=drS6kIUi3CTQRScaC8xgBpQbCpw+WuhXFvRYrMuR5lV7JGZipSXhqyFHzhisa6f68zAHxwIoDpLrUnWk119Ty/NZgVwy5/bP93xpqBYGLnOeYoIQ0hd4kEfjZ5T6SWC9eSfyFk0n+qKXah8FTNdWLj+EEH2yePvGEF7qpLVfHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866464; c=relaxed/simple;
	bh=mi8Qpq2AcOUwPg+2eQUjSMBtjoezBuLq7bTxFTqR/XY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZW6Ws+69NQloOw8cziMwSvoPCL8BJy64z20t6JnbB+SMw1sCR1d8Cp99VkO28wi75YI5olbl5GHN+qwO5lRKsuzsTblnqhhmFJhHYDGoHP7bp1ct5x4fCaPjgl5WBkb0QXOSpvxRwSgIFm2QcEGkzUj3X/p/vAfdf+5tv7XrdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EAa2XEyZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LAIXrcGLIz+mYluAnrDraCyjl4jRrDiCTuZzIy+Ppxk=; b=EAa2XEyZYQoZVTBu9npDD+xIUz
	QDggunk8rs8ihOSXhWjfHl+PbZMX6kA4cUQqNIvULz2DWnuSTMbEQlp5VLCJHbtQ/oPxWs1p61Ns9
	xbZpv3oS5r0og9VSVeNbobqT69IEy51wH6aD4zQsfdKTd8PXx1bo2ZvYEJVKigAHBsK2HUikx+M4d
	XVSM1cbuj06I9+zHxXg2aEZZymiWgKuNF4mQcxKzpx/JcigBSQTetKpO/PRahTI8WnaFOZ6QDKrL7
	x6MAwXAmQFq00jPhqa919W5+RTzBQI8tm2/0UFenHeFGr3evsoJmeRavhAr3NJxXNF00K1N5GBydp
	ywEbSFGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54174 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVpvm-0005j1-0i;
	Fri, 02 Feb 2024 09:33:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVpvh-002Pdv-Ol; Fri, 02 Feb 2024 09:33:49 +0000
In-Reply-To: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/6] net: sxgbe: remove eee_enabled/eee_active in
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
Message-Id: <E1rVpvh-002Pdv-Ol@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Feb 2024 09:33:49 +0000

sxgbe_get_eee() sets edata->eee_active and edata->eee_enabled from its
own copy, and then calls phy_ethtool_get_eee() which in turn will call
genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Therefore, setting these members in sxgbe_get_eee() is redundant.
Remove this, and remove the priv->eee_active member which then becomes
a write-only variable.

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


