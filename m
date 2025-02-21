Return-Path: <netdev+bounces-168592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB1A3F6FE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72E2861428
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08931C1AAA;
	Fri, 21 Feb 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i7UoQF2b"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D31420DD
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147348; cv=none; b=PW4srYpj5SaEJnjgusYoJSNaA7Js9dxiyeCmqFpt36u6c/jDCWbPpAKmtHIJCqAdUlQWPVY0Cm5tj+PwcZZ3MTXLNzhWXehnR0/LVidsKb5CMT9FwfWZ2OGjilUa3Q37zfHakIxJAWjg7YiT++/34Yam5VmJG2PrS+AADVxHAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147348; c=relaxed/simple;
	bh=YemvC5bOPnL6ooIpDML9rolxQ3QUmWjyxqSB3deoy6o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uC1uxE3tF3cKjkYnKVwM0vIbIC8XmHTp9b+A7/7jtQGm/x1bOVYDGnsyJGbJqlQDlscnW3A6JjaNnXMTYud2X4OAgM6Yqc78GLIqSM5PX3LpsPw1EKiiEzXuSGKqWo3QUzhITc2x+xt5t2QJGnmCmuaUGizhykhjGqmfQb1S9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i7UoQF2b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YmtTGwJJXhwMoenv9f1jJWRnRB0B2anyfjKqb6F0t6g=; b=i7UoQF2blTPs6VW1UGIaXkZX+k
	IJh5rrOMM3jtyTYE0yyIPfqvAgr5J7kr8tlhOag8TsD7uog8dTn/hrI9Zonguyry25QPpZ6Macig8
	Hnfw5IrCLzLsHbISCogcINMGXG0py/E+l9QG6MhzVO2xlW5UhzyKnu3PEP0H0JRM4QI1524TREqMO
	tV9vQsuHBH7ZBNmMBz9SoBHIM1/vgqeF6ghyFxiJBucJK2OlbNDI03ABq7My+5Y2QHYmErA/5CQsd
	UBZEl6/LX14f1p5R6sq5zrh3OTMqFZRvRu8MJh3bAJVUpaeM9S93akICrUQNRteaalKd0QlFOXt0x
	Gp6cO1Pw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50498 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tlToX-0004o0-1B;
	Fri, 21 Feb 2025 14:15:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tlToD-004W3g-HB; Fri, 21 Feb 2025 14:15:17 +0000
In-Reply-To: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>,
	Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/2] net: stmmac: thead: ensure divisor gives proper
 rate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tlToD-004W3g-HB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 21 Feb 2025 14:15:17 +0000

thead was checking that the stmmac_clk rate was a multiple of the
RGMII rates for 1G and 100M, but didn't check for 10M. Rather than
use this with hard-coded speeds, check that the calculated divisor
gives the required rate by multplying the transmit clock rate back
up to the stmmac clock rate and checking that it agrees.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index f16fa341aadb..f9f2bd65959f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -45,9 +45,6 @@
 #define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
 #define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
 
-#define GMAC_GMII_RGMII_RATE	125000000
-#define GMAC_MII_RATE		25000000
-
 struct thead_dwmac {
 	struct plat_stmmacenet_data *plat;
 	void __iomem *apb_base;
@@ -124,11 +121,6 @@ static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		rate = clk_get_rate(plat->stmmac_clk);
-		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
-		    rate % GMAC_MII_RATE != 0) {
-			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
-			return;
-		}
 
 		writel(0, dwmac->apb_base + GMAC_PLLCLK_DIV);
 
@@ -139,6 +131,10 @@ static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 		}
 
 		div = rate / tx_rate;
+		if (rate != tx_rate * div) {
+			dev_err(dwmac->dev, "invalid gmac rate %lu\n", rate);
+			return;
+		}
 
 		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
 		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div);
-- 
2.30.2


