Return-Path: <netdev+bounces-158178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA7A10CB2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102BF3A3799
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7571ADC79;
	Tue, 14 Jan 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uJQScRrF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A40232459
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873475; cv=none; b=nKRtI0S43zgdoGcl5hPGdHLvWTfCy5CeGjTGV/a6FqnrxXS1I7udMSxavK4AUB131f/6dXn9OJ7PfsMO0afehVxcFc8NYFQwRlEv+t6ZzxXH72EnMxWEVjTfmqDEZJk1Tuht0x+AELy9XR23J58RseMNCKNj01y9GmpbaLXEl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873475; c=relaxed/simple;
	bh=RcVSz5A7WTX07UZH0a3d61vsaNjL9w6wB09GU+odVGI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=E5oMR63nNWeoLW9imGipykDksj2/mqsaCsNw9WRDsF8OzQrSxQCR5Voxqli568FudxURJgS+EHBQ9DMaawBHZLOjw9MSkeUs3TVG3d8vKK59s8yO12D2l2fkkcYEvlyCmpZPq6jRmV2uJLLIwmTz9Eu6WDa6IZUnRm6sxKZDJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uJQScRrF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fMDPibTGVutVnoUV7xjLJg1ugDt9ePaw7m06y1uj5gw=; b=uJQScRrF22OwgBKkXrcgJx8pMw
	KgqhDM9jlafpk/fwbNqBd7N0z9qx1r+tCCXdSQYzohuvj9LKMt71VHP/7C+mVrDRY8rN3GXFhGJXw
	IpzOQQ+9y8mSGS5xWDDYV0+WKlWr/h5agTCYjeWtiTDfSxjzBSrweXyH4UrScLa4c2uLycsmlJw45
	kGcqc/k54VAYZnWt2uiG+Qq6TdhrZcPCrstUKsDgJAMjgn0ZL7kqbUrLuNheM/L1QUv0u1au48P8Q
	SnW9IOewZ1Q7S/WRbkRGSRBt94GrbhbBzcvX3c8wF5xFEaeDsvePBbfmJM/ceL95hrgiAGyc0dKnI
	jQ+Pl3sQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58802 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXk8A-0008Nr-2U;
	Tue, 14 Jan 2025 16:51:06 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXk7r-000r4l-Li; Tue, 14 Jan 2025 16:50:47 +0000
In-Reply-To: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	bcm-kernel-feedback-list@broadcom.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: bcm: asp2: fix LPI timer handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXk7r-000r4l-Li@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 16:50:47 +0000

Fix the LPI timer handling in Broadcom ASP2 driver after the phylib
managed EEE patches were merged.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 2 --
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c    | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 9da5ae29a105..139058a0dbbb 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -371,7 +371,6 @@ static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 		return -ENODEV;
 
 	e->tx_lpi_enabled = p->tx_lpi_enabled;
-	e->tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
 }
@@ -395,7 +394,6 @@ static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 			return ret;
 		}
 
-		umac_wl(intf, e->tx_lpi_timer, UMC_EEE_LPI_TIMER);
 		intf->eee.tx_lpi_enabled = e->tx_lpi_enabled;
 		bcmasp_eee_enable_set(intf, true);
 	}
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index cfd50efbdbc0..62861a454a27 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -677,6 +677,8 @@ static void bcmasp_adj_link(struct net_device *dev)
 		}
 		umac_wl(intf, reg, UMC_CMD);
 
+		umac_wl(intf, phydev->eee_cfg.tx_lpi_timer, UMC_EEE_LPI_TIMER);
+
 		active = phy_init_eee(phydev, 0) >= 0;
 		bcmasp_eee_enable_set(intf, active);
 	}
@@ -1055,6 +1057,9 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 
 		/* Indicate that the MAC is responsible for PHY PM */
 		phydev->mac_managed_pm = true;
+
+		/* Set phylib's copy of the LPI timer */
+		phydev->eee_cfg.tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
 	}
 
 	umac_reset(intf);
-- 
2.30.2


