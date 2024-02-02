Return-Path: <netdev+bounces-68380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF605846C32
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F31F248D6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFC07D41E;
	Fri,  2 Feb 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RZLkUZQo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CD78695
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866472; cv=none; b=tAueY2QME1I2Wt6A7tz/i7N6sdPBDAdum549BlA1G80tgbuumf9Ol/vdxy7w2SDspbbmMrXEhDNYNtYWRG1K7S8uxG7T3lt9jk/mCS0Swc0niPlmxnHx/9uqBuRRHUItr4AgzIyTs6huChVpm5wUPmF32NiLANGt66IrOstSUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866472; c=relaxed/simple;
	bh=4bdbuxkxjPdMLMdXe1frJ8hAzyaPUw9WxSfoQMN+nqs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=szW9QlHptCTAQ1MnlpGc8IXx5O5wgXBCLI8AQVfOejUMicdGCqsxGO1doyX6QE05UhfZAN0H91SxCMjD8C0ZmxaqOxbuHMUhJCQDtsaPTmKqUKkhw4G+k81mkbREEdUjH9v/lUsIb7Fp1+zG4Nwuz4AG3fs0/43kyLlk4acVqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RZLkUZQo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M59Ne5bwhriKItk6IjExPwtQ/AHVVG1QMKc/HflM8hs=; b=RZLkUZQogpvKgwOO+Bka/H3IXN
	rLLis6XFiH8D1uVqWyFM9lmzFGNuDrlJdPHVoiawokkih/5BuP7oA6kjyvI/y+oovnt7b6X0luSOJ
	9jHFqtSyzm+QCp5CGzzohP0LorJb0fhb2eoZR/0UNdzzrItgsbBxm4Hzn1BwVJz9bFL13gNmZqdGC
	/vPbCCbmir2jUPWIlpKxABkb5Iq5LysXVHVLTmG4UZ84SfBQ0N68GqH49uUbwLituxyy1nIW+5fMP
	sk7d0YdqIUBPRZKx+McEo/86jyJ23pFE+BLaJVcFGbAAXx/NkMlBsz34Tqjheq8rwqMsgTLRFH3BM
	i/NZZDaA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38154 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVpw0-0005jl-0l;
	Fri, 02 Feb 2024 09:34:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVpvx-002PeD-71; Fri, 02 Feb 2024 09:34:05 +0000
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
Subject: [PATCH net-next 5/6] net: bcmasp: remove eee_enabled/eee_active in
 bcmasp_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVpvx-002PeD-71@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Feb 2024 09:34:05 +0000

bcmasp_get_eee() sets edata->eee_active and edata->eee_enabled from
its own copy, and then calls phy_ethtool_get_eee() which in turn will
call genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Therefore, setting these members in bcmasp_get_eee() is redundant, and
can be removed. This also makes intf->eee.eee_active unnecessary, so
remove this and use a local variable where appropriate.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 4 ----
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c    | 5 +++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 2851bed153e6..484fc2b5626f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -360,7 +360,6 @@ void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable)
 	umac_wl(intf, reg, UMC_EEE_CTRL);
 
 	intf->eee.eee_enabled = enable;
-	intf->eee.eee_active = enable;
 }
 
 static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
@@ -371,8 +370,6 @@ static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->eee_enabled = p->eee_enabled;
-	e->eee_active = p->eee_active;
 	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
 
@@ -399,7 +396,6 @@ static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 		}
 
 		umac_wl(intf, e->tx_lpi_timer, UMC_EEE_LPI_TIMER);
-		intf->eee.eee_active = ret >= 0;
 		intf->eee.tx_lpi_enabled = e->tx_lpi_enabled;
 		bcmasp_eee_enable_set(intf, true);
 	}
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 53e542881255..3a15f269c7d1 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -607,6 +607,7 @@ static void bcmasp_adj_link(struct net_device *dev)
 	struct phy_device *phydev = dev->phydev;
 	u32 cmd_bits = 0, reg;
 	int changed = 0;
+	bool active;
 
 	if (intf->old_link != phydev->link) {
 		changed = 1;
@@ -658,8 +659,8 @@ static void bcmasp_adj_link(struct net_device *dev)
 		reg |= cmd_bits;
 		umac_wl(intf, reg, UMC_CMD);
 
-		intf->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
-		bcmasp_eee_enable_set(intf, intf->eee.eee_active);
+		active = phy_init_eee(phydev, 0) >= 0;
+		bcmasp_eee_enable_set(intf, active);
 	}
 
 	reg = rgmii_rl(intf, RGMII_OOB_CNTRL);
-- 
2.30.2


