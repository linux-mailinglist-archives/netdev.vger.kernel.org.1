Return-Path: <netdev+bounces-137853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA4A9AA17D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B91C2225A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6832A19CCEA;
	Tue, 22 Oct 2024 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SC5dLt2g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB919D8BB
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598059; cv=none; b=LIyiT4C8PnqQ0Fcty2NUcifYd0Mv3yJp+ue8mVHh3nFlVgqeAIaUcuZ7/IyVvdItKpiIO3tKK8hqnEGJHLO78JoQKaqtd92Ouag0qCFJkV+YRvAOecYpwSsvsoYGGYhnSvhYT5pFgps9TWXhHeXEejMpXPnUgynd2xd24gtPJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598059; c=relaxed/simple;
	bh=Ao48/Um2MhZOrsbDS4x5euC8R11R/czyq81kkASN/JE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VMdUMzF+thks/OXfdKO8GXu6bqZPqMfUcI6k7HW5zweTjDZY3Oin/gs2URB3xXqFfdeEEjzvHKEl1MWkzUG8kpJ0KTMNKAS4WzEs20AufKkrCgMFij95zqJBkyBvOAkoR9cIpSFBayJHKgwq72qCTcUIvwC3CZjlLXdcVUMY7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SC5dLt2g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QQgh1NomSOBthESwOBrRKW8Cr2/LVqNRZ4pfNL/F96Q=; b=SC5dLt2g/zxZ/+C+mqBG2lFwsq
	VuZY9l1oEeZpWN8sJpJKUZzjO749sNN18W4fhXNav8UjWJ+Fd95FJLENyBEvmCqOATsqJM3XOFDMi
	akPmAslihU+rbvL7T6vKAqf2LKYp0zGmgvJZl0hAs3soCRt4QpYagC4nG3K8U/bLlvfj7P85HM2Al
	Q7Kcapda/OQXrAqkB1HdQlzObK1i26jREMqYujwbM2sKsHbOwdz+hfu4rCEXzWWTIKuQ/Biv3In78
	CkjYbgzyDyUaEolyJwnvs5wkKxUyC4xV1/4/VNhPj+JwFNXVcTuU5as8WCg05XeKDGSNlgZ4yDTo7
	QjEZLdAA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34204 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t3DSm-0004oP-1p;
	Tue, 22 Oct 2024 12:54:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t3DSm-000VxR-MN; Tue, 22 Oct 2024 12:54:12 +0100
In-Reply-To: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: phylink: validate sfp_select_interface()
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
Message-Id: <E1t3DSm-000VxR-MN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Oct 2024 12:54:12 +0100

Validate that the returned interface from sfp_select_interface() is
supportable by the MAC/PCS. If it isn't, print an error and return
the NA interface type. This is a preparatory step to reorganising
how a PHY on a SFP module is handled.

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


