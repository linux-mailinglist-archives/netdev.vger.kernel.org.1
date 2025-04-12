Return-Path: <netdev+bounces-181887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD155A86C09
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B534F1B8131B
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47B19F12A;
	Sat, 12 Apr 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T7svPeX6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDB1F92E
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744450538; cv=none; b=qy5HNX7WCSe1C3Lw3BkyFX/E6t0oxMRkzS5k5gHcJBropRbcIqykZxNAZqEmtkVSHJzb2eZCQYo6dgT1ce9WVUKSDZPDSbyKyWpg/b62J49ADhNvxMxUQPNGf/blpAEiuMJDG69j0BIHcrPLzoKLSbJjIoI3wM9NF9VeJymIXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744450538; c=relaxed/simple;
	bh=mbEw1as3QdeeZBy+28hbqVPFL2+HCwu0WFDQFzhgvcc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ioiuxLjd3ulMuJjLHiDUEDfPHR+dzUa0vkU4WvdgYWAHi85qfDMT8EBz3E5JAzTDMZrRQJo4eYU5RLacn1mTSekVQctxzbxe3g5I6dKDy0yWpthmjSGrQcYiYsVQdFzFF3fDokmNeRmrqmGczfs1uQ2o2mN6LrW3qb39pP5wxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T7svPeX6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=05ovFAPDkAkxhJKvy8zVgSI4KCeD0hpMqQlpjrI1BSE=; b=T7svPeX6egutgSXZVYVP5HDSuG
	TIB0wQ49OTBC/sgI2Nu2W0g+EElGiyZQLiCiHVFsGcl8FY5l2deibTrDirXqxv9emxKthmgqtCVQN
	e0ELNRniurSMXE2788GDeytvJgtgMLIw+WJ/M/XNGhDgDkcjy7qcFQ8McA+PgJeCxL+FhTBAonhuR
	C7tXxgWL8OyO12vvEz8GRARyhlAIN6ecgVN90rjFiOfVeT2eEW2vb7xichNb/D1dnJW2cxhHIMfCE
	ekG2friBalZCAlnl5tmugX74Vqjuqfm4xnZf7KKDuOefwJTnyeH37nEusseBiMXDEGq1+XN5SehRN
	6gLX+HMw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34808 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3XGs-0004R6-1F;
	Sat, 12 Apr 2025 10:35:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3XGH-000EJs-6A; Sat, 12 Apr 2025 10:34:53 +0100
In-Reply-To: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
References: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/3] net: stmmac: leave enabling _RE and _TE to
 stmmac_mac_link_up()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3XGH-000EJs-6A@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 10:34:53 +0100

We only need to enable the MAC receiver and transmiter only when the
link has come up.

With commit "net: stmmac: move phylink_resume() after resume setup
is complete" we move the race between stmmac_mac_link_up() and
stmmac_hw_setup(), ensuring that stmmac_mac_link_up() happens
afterwards. This patch is a pre-requisit of this change.

Remove the unnecessary call to stmmac_mac_set(, true) in
stmmac_hw_setup().

Tested-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24eaabd1445e..83f62f50d8c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3533,9 +3533,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 
-- 
2.30.2


