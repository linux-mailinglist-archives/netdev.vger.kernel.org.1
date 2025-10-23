Return-Path: <netdev+bounces-232022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FDC0030E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C683D4FDC81
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA72FD676;
	Thu, 23 Oct 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BOjmGp7m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B64257828;
	Thu, 23 Oct 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210997; cv=none; b=hOqeYeG+mJHFLKEoyjcf7YcWkTpBlxMl9Rp6ws3jrBa2bdwdkEPeLZxfgUJ6lz/9TnXX2w5dnG/cejHbKrAuJzoHkej1BytOeGIObSEfMTVi+7VXNgPSnJ9ZDUDvyaV9+RhmNZ26HUH1CbAObba3h0YXpzpcvhZ+cfgf70n0DS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210997; c=relaxed/simple;
	bh=8tY3bdFBnFAgO25anX3wP0+qH7Ke9IvNQaRNX8mW+ok=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ToZw6Xuj5RTCQRl8cLBzRc6O4EK8m2tK4X+Qp0qEUhl5uYbCk4cJ3nzYGFY9XMQ3GLLQZblX6Mpk+OodHKrJKfGHGZdRwk43y/54zwz0kJi49QMLFuHWWzWE1zVZ2RIUa+UIEWkCQgFzEQz7eotHbwOBxi+ncHkKM/9HwWPXVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BOjmGp7m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LlxgOL4iHOhRq2rg3Bphni6vekg4JHIOiNC2UJ8koDs=; b=BOjmGp7myOoyHmJURfM6X+Y6Pg
	KCRGtf92cVW6xC9FyDu4td6zv9dMlbvaTXyRqwsoJGlEaPf1K8JHf87g+TU8XVNNX97AsjCoTcBOn
	PaXL97A/Oy3+gu/EBHlp8XixgIAa0NkP0GQsdUWBTeHvkKuU7SsWCAfTRzMhArbczwcRBF/zS2C24
	ZQ94WOp3EovPAy0bZDe7CA2OUAb9JBZKqJ1v0PIyCeNQ3wrxHYM0RiZGrDRDsZTx8LkLbw4LhsS+Q
	JxPnt0ob6Q5X7ZU34JLJnm3ovkDvnAWfD+xaY/KC3bSFhwNcH/DoGzORYGK4pzB45DFmUv/BYHgUL
	WMcWWFzA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46440 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrQt-0000000060d-06iT;
	Thu, 23 Oct 2025 10:16:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrQs-0000000BLzI-0w3U;
	Thu, 23 Oct 2025 10:16:30 +0100
In-Reply-To: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
References: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH net-next v2 1/6] net: phy: add phy_can_wakeup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrQs-0000000BLzI-0w3U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:16:30 +0100

Add phy_can_wakeup() to report whether the PHY driver has marked the
PHY device as being wake-up capable as far as the driver model is
concerned.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phy.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c7634482356..3eeeaec52832 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1379,6 +1379,18 @@ static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode
 	linkmode_clear_bit(link_mode, phydev->advertising_eee);
 }
 
+/**
+ * phy_can_wakeup() - indicate whether PHY has driver model wakeup capabilities
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_capable()
+ * setting.
+ */
+static inline bool phy_can_wakeup(struct phy_device *phydev)
+{
+	return device_can_wakeup(&phydev->mdio.dev);
+}
+
 void phy_resolve_aneg_pause(struct phy_device *phydev);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev);
 
-- 
2.47.3


