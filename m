Return-Path: <netdev+bounces-214045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6383B27F3A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298207A34B1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0C287243;
	Fri, 15 Aug 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PNSGHwZ+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17B2857CC
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257573; cv=none; b=BlTZp4nHoKThb0SM19YlBMU+XnG/KlIl71t+6qPg4CpdQAsm7mG526ReizXJh4lMVztNAbvECbb1+NPJxNQ8vCQ+4yHzZ10S4LZw6Cf6RojGVOQAJeSQhRIsp+SYzDDtb4i/x9uCmFekqXRsoqCJ0negoHqIzmSt2yztWA1pJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257573; c=relaxed/simple;
	bh=iZ+VDnZXett1+TRpMPqKtgIR/9beQxT3CD2B2u/4VLc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=O/bUg0ZCa+aEdGnhDeDILaw3fNu8yn83JhJ0g1dxE5YmXAHb2G515xX69LmD2qEnesZsmmwIphzaHbigqutCILklHbyuC3SiN00hBSu6hG/SsYpbV83By6tMWFHty9cMSlJ1pK2cY2cnUWjgrA8te+jtwJG4R6rES4O67HZMSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PNSGHwZ+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UVGyduMsGp9jIcV0Q/MypAFdrMixXAG4hD33b4pow40=; b=PNSGHwZ+Z3Ie+P8OzTLhtlVT+3
	9OgjuqQrxIg7OES+48tMdoGksYkXCWxHnnpo5vmFicR/LCozh+eH/kCurym1+Tew2O2NariRAqGc2
	4ImEfAUmTwSkQCFxjxJ5Vsy0f52Z/Gb6Odoks6xY6N72T3Rr38T+SDHN1JuluV/QtgZ9UW3WwFqoe
	TPek0CqlWF/ruFy1dszrx7L4S8Sy1ONqAhQC6AuiL7Y1XZg1skPFRKgChWP+XuwrnvZ7CwNDhSv7m
	liljNt42brDxAK4s/7sAKJe+d8b4qJVERZYv5ZWe8AccuxpYOpeIITJaPQx/3uaUFfePhSr0m1N4r
	RigqdMaQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52750 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1umsft-00011m-0l;
	Fri, 15 Aug 2025 12:32:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1umsfA-008vKW-H1; Fri, 15 Aug 2025 12:32:00 +0100
In-Reply-To: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/7] net: stmmac: remove redundant WoL option
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1umsfA-008vKW-H1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Aug 2025 12:32:00 +0100

The core ethtool API validates the WoL options passed from userspace
against the support which the driver reports from its get_wol() method,
returning EINVAL if an unsupported mode is requested.

Therefore, there is no need for stmmac to implement its own validation.
Remove this unnecessary code.

See ethnl_set_wol() in net/ethtool/wol.c and ethtool_set_wol() in
net/ethtool/ioctl.c.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index dda7ba1f524d..cd2fb92ac84c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -803,7 +803,6 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u32 support = WAKE_MAGIC | WAKE_UCAST;
 
 	if (!device_can_wakeup(priv->device))
 		return -EOPNOTSUPP;
@@ -816,15 +815,6 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
-	/* By default almost all GMAC devices support the WoL via
-	 * magic frame but we can disable it if the HW capability
-	 * register shows no support for pmt_magic_frame. */
-	if ((priv->hw_cap_support) && (!priv->dma_cap.pmt_magic_frame))
-		wol->wolopts &= ~WAKE_MAGIC;
-
-	if (wol->wolopts & ~support)
-		return -EINVAL;
-
 	if (wol->wolopts) {
 		pr_info("stmmac: wakeup enable\n");
 		device_set_wakeup_enable(priv->device, 1);
-- 
2.30.2


