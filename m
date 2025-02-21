Return-Path: <netdev+bounces-168591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00018A3F6FC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911274200BD
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E41420DD;
	Fri, 21 Feb 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="njU4+l7j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155E20E320
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147343; cv=none; b=f6DjCnXFeeZGxgdZbvnamnieDt2afwSA+UMAS4t03SoKbO1Ut/+6T8D2Y0BarqiznIaHtD6I7Fn1VlFK40tiyuEYV0UnBDOgt4SbMuGXvGV0FHgqzUwMZAPI5wVcgdkMEfmlVfq90EhdyE0cy3fvtYmb/9Wzw28ykjCkLIhrzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147343; c=relaxed/simple;
	bh=PxUD8QO2IrafyoudBeSAKgiUxT2I7ZWaxZqv3RPvpQk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tlkq8b8KDe1W4cedLKQnGyzQD2/43paTbwZ7zMwHox3wuK1p6tUdIkW2ljv4gPZb/okknYy6z51GD/bYNJ/5JKxU2LrimNxYwt0hytp/sCKATjyiSBNg/ANzEKPVOoP7V5MblGi5TtRH3CcNOM2JAts0UKDb9nmnZ407Sr0M0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=njU4+l7j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9EYM2uy8xE8SDz3hxuTPLu62d49PDavTllU9e+M4HNw=; b=njU4+l7jYgaHqHYXdIZc8CokRV
	2sPUTQcNkg++bJ+4T9TPRwkFRG7fk7L53YxaQ5CtetHmvfO6oy7JOxeyuixhmH77z2eMAwvU0cWa/
	5u6ipI5KcceOYgOJFb7wa5rpQC+Lq2jJafVZAhT/htVJvLJI0iTM/+LrFY/skhxoGWvD1etorGCZP
	85943dHGlqdOkePjNuz1Y5QWEmt6RsYXkPvx8NjFiocC0bWXqKiH9efRetnxon4OSJQJKGANuddvw
	IYxkjESQKqKRQ3RAv17iXcGvBfuRDuB0iJpzjlKjYFZoF5edGnI/BSiUsiSd4FCCKPgNIv8ddsZk1
	4DY2AZuw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50484 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tlToS-0004nk-0u;
	Fri, 21 Feb 2025 14:15:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tlTo8-004W3a-CO; Fri, 21 Feb 2025 14:15:12 +0000
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
Subject: [PATCH net-next 1/2] net: stmmac: thead: use rgmii_clock() for RGMII
 clock rate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tlTo8-004W3a-CO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 21 Feb 2025 14:15:12 +0000

Switch to using rgmii_clock() to get the RGMII TXC rate, and calculate
the divisor from the parent clock rate and the rate indicated by
rgmii_clock().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c    | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index ddb1d8aba321..f16fa341aadb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -109,6 +109,7 @@ static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	struct plat_stmmacenet_data *plat;
 	struct thead_dwmac *dwmac = priv;
 	unsigned long rate;
+	long tx_rate;
 	u32 div, reg;
 
 	plat = dwmac->plat;
@@ -131,21 +132,14 @@ static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 
 		writel(0, dwmac->apb_base + GMAC_PLLCLK_DIV);
 
-		switch (speed) {
-		case SPEED_1000:
-			div = rate / GMAC_GMII_RGMII_RATE;
-			break;
-		case SPEED_100:
-			div = rate / GMAC_MII_RATE;
-			break;
-		case SPEED_10:
-			div = rate * 10 / GMAC_MII_RATE;
-			break;
-		default:
+		tx_rate = rgmii_clock(speed);
+		if (tx_rate < 0) {
 			dev_err(dwmac->dev, "invalid speed %d\n", speed);
 			return;
 		}
 
+		div = rate / tx_rate;
+
 		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
 		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div);
 		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
-- 
2.30.2


