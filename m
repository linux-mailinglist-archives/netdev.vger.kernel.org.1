Return-Path: <netdev+bounces-138250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA39ACB79
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAB22868E3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC451AF4EF;
	Wed, 23 Oct 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S9r8GVTb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752B1BD017
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690918; cv=none; b=bn7rArBY/R5e/IfG7p2V81WdYz4DQzPGvTCDVfE/JLxC/wOGh2f/LVsLxqzdlqSGq3kp5s2axWB7FsA+fHnbjt+Dg+se2n3DYAMqCuOgBhhohfBTPMADcTZr1DgaV+C78MT7E2dX1o7C+dP6eroUjdDod+FKM7Rsef0q97W6KFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690918; c=relaxed/simple;
	bh=Y/9LSH97RISVAGv2vWka3noTDVtyFdpgKSTe9/umAkw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=n2ClkjqRaSoiYal65yKFT/+mPR7dEC4okhlG7SSI7lwoMF2rMJJ/jJYcfiyRO1lF9P/7oKMzfb7VQXO5UE40H18UNDO2zEdeeVNIyhHEXjqrYuszPsm/ajVzMS+yOQQWl3UVkPDNgkZaIM0lWq0D+GIjA6V41qVNxn4j56Himwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S9r8GVTb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N3W6iTA+tH+JqtoxZsmnNdn92DjZQLTDiLxEsqa4ACY=; b=S9r8GVTb+oEhuvHfYI5cPjH1Nf
	gK0QP5DYAJB15FJxgwUEVVSSt51aJP0UWoD4Cvc2Z1GQWwicMjEwmvqvK+h/Zo5gRdmD1W5i2ggU+
	yWQw6ZsVAH/NMAAYexflOtiiyM7W/C1MyIytEf/dkkYeyyBNcnKtIC0CtD/WfXOr6DioRHBP9DXyO
	cKlqvFdbiBhudhJ/TrpUqv0034r6npDpPkk9ZUzbG5xs2GxVsuvF6FqfRjjZwA3uwt2MczB0Fjt5M
	5vaWZJXB7Vl4Thh4mCmZVzuiGnyhKW+AFgDseLgvdc7jnyfrmApREAbh5jzJbUSK2uq4A3IYYrO2m
	3AoB11XQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34452 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t3bcV-0006Ux-2m;
	Wed, 23 Oct 2024 14:41:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t3bcV-000c8B-Vz; Wed, 23 Oct 2024 14:41:52 +0100
In-Reply-To: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
References: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: phylink: validate sfp_select_interface()
 returned interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t3bcV-000c8B-Vz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 23 Oct 2024 14:41:51 +0100

Validate that the returned interface from sfp_select_interface() is
supportable by the MAC/PCS. If it isn't, print an error and return
the NA interface type. This is a preparatory step to reorganising
how a PHY on a SFP module is handled.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 62d347d1112c..4049d85cb477 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2421,11 +2421,22 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 	phy_interface_t interface;
 
 	interface = sfp_select_interface(pl->sfp_bus, link_modes);
-	if (interface == PHY_INTERFACE_MODE_NA)
+	if (interface == PHY_INTERFACE_MODE_NA) {
 		phylink_err(pl,
 			    "selection of interface failed, advertisement %*pb\n",
 			    __ETHTOOL_LINK_MODE_MASK_NBITS,
 			    link_modes);
+		return interface;
+	}
+
+	if (!test_bit(interface, pl->config->supported_interfaces)) {
+		phylink_err(pl,
+			    "selection of interface failed, SFP selected %s (%u) but MAC supports %*pbl\n",
+			    phy_modes(interface), interface,
+			    (int)PHY_INTERFACE_MODE_MAX,
+			    pl->config->supported_interfaces);
+		return PHY_INTERFACE_MODE_NA;
+	}
 
 	return interface;
 }
-- 
2.30.2


