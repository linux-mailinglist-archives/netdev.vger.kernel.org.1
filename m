Return-Path: <netdev+bounces-214049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82989B27F41
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73052AE5D6C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886862877FA;
	Fri, 15 Aug 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wNe4uxYM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE482287265
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257594; cv=none; b=K9kfwLj3AZ8RoM7fsYRZ6XMcOP/bCJY/JP1fr0FYeSwO1WInfnRyTAwx6WuPkp+02ueqdcJrAK+Ucw4vJLe8AVbxohYoeKcfttQAj3uJ8BaEFE1S127Kf6BXYZ2In0jz/uL2x8sk4x1n+9lc9NXrIoAD9WB5azUTPa5qTPia4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257594; c=relaxed/simple;
	bh=p48e2pl6c0Z+Pev6Ka6cPOliQH25+FwdQB4roHwALj0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XVrNCiC1987acJPkTf7huXrf8VcCl3X4wVetN4PBziNvw6b8MMYH/iW4X1QR00MjGWhNdpql9RAFMxxWGGZQzS8at0V/cvGC6vbrs/3x9IvMjPe2R5Mo1SjGSPsSPb/ATbG1F8LEURAiNALBgm2E3z6Y0eou8sMpE0zFWzMHjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wNe4uxYM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r57K7fI/6hd/8/DWGPUEw3UErVzL98S6GiksmsGJenw=; b=wNe4uxYMTL9+wEnSz8LQJNZqR4
	n7uVBy4Wr8EQKQ/r3yyUu49dKLtuR5jqED3sfrSzQ65T+G/X3fSxICgWeOaTyNSVaMWZOnTY+afT0
	9atmWCgTBCUvn6tWbn7Zt2E9SavecBrEsxoQChPNoKXd46YIVO8bmGz70J7wNjDGbbgNvOf3BWDFJ
	nBkwxsQrdLze9NbnpMLMm9cdfi3nM21ihlp4HZNldPSBO9J9HeFNunK5kk7I+MROOk4067rugcmNa
	1DLiSYUrIQIYXALATUL/X+sEa1njlIShghs3KevBYwF1Ui6WLFfYz5I2x0nLQUWi77ZJ48EuSanvT
	EO5zVKGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34540 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1umsgD-00012n-31;
	Fri, 15 Aug 2025 12:33:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1umsfV-008vKv-1O; Fri, 15 Aug 2025 12:32:21 +0100
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
Subject: [PATCH net-next 7/7] net: stmmac: explain the phylink_speed_down()
 call in stmmac_release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1umsfV-008vKv-1O@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Aug 2025 12:32:21 +0100

The call to phylink_speed_down() looks odd on the face of it. Add a
comment to explain why this call is there. phylink_speed_up() is
always called in __stmmac_open(), and already has a comment.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 78113e2602ee..b5f1fb8b2b30 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4138,8 +4138,13 @@ static int stmmac_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u32 chan;
 
+	/* If the PHY or MAC has WoL enabled, then the PHY will not be
+	 * suspended when phylink_stop() is called below. Set the PHY
+	 * to its slowest speed to save power.
+	 */
 	if (device_may_wakeup(priv->device))
 		phylink_speed_down(priv->phylink, false);
+
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 	phylink_disconnect_phy(priv->phylink);
-- 
2.30.2


