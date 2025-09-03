Return-Path: <netdev+bounces-219569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA1B41F66
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4291A83BD7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814F2FF163;
	Wed,  3 Sep 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y0/DOkBI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65032FFDDC
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903215; cv=none; b=SwHUKg/Cm6CrBxGTc5b4T6sCvQ0zvKqL3eGP2hV5V0im4mdT9XFNnFtAMDtto4FaQGad6qhUEC7eSPrzKqU8AL+tT8XQ7vjVqhrmpnfVkbm4kaSzsE3UrWN+qvlE+ZJLLZQMMrHUf/V9cuwPZqpAidJQFe7lcL718g3CuuclvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903215; c=relaxed/simple;
	bh=Da8lenjlHO68wKcw+mjm7Pq328v9boIwFJPX7mAlfo4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lCTxZZE9JduCGqf5xq5szBQ8SB2QG0WcX6wWte0yI1KzZhMsNuvA0btEkSfrnpM7+DRrnAODoXQYsRvZoa+5V6cTIrVsA3YxBuU/dm9pj1GB9qtI9R1cCsGZk32LQl7w3F3OGgir9ByMRo3EDcu8OvI2QQtoCuHk3cg4xajOezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y0/DOkBI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mC/No0ng9OP1QG5vP36eN7zONL2hjkecSyux6oN6Bvo=; b=Y0/DOkBIui9ksiL/p/TosmKYfs
	X+YHLbv9Y4GWYyn2QXK9/dI1r9Nbb7c5kuPqxILWc497lw4hpdKtzkEp/QKNJvjr70nT02i1l4nOy
	4VJIiKysSUmop4QtC+8J2gfZ5q4V4onjYz5QVw7owBoCElO8/9SO502Yip0vmmMrBC3o0CD9ZRZ+M
	h52g9BHDdY+jkUnbBqTolrWzMGOXjACn2wmgcwjR03R4e/PjbyN8GLJZo5uewPg83bYeDnxyP2gMx
	4IIaUVIOiizaP7KdQk9gIuDB069PMmvkm6obRHWZRyRBRHLp09xEwYNBIfd6UFPs2NC6K3dwK8Jwn
	555A+srg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39592 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmmT-000000000XA-3iY0;
	Wed, 03 Sep 2025 13:40:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmmT-00000001s0x-0TMB;
	Wed, 03 Sep 2025 13:40:05 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 10/11] net: stmmac: mdio: remove redundant clock rate
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmmT-00000001s0x-0TMB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:40:05 +0100

The pattern:

	... if (v < A)
		...
	else if (v >= A && v < B)
		...

can be simplified to:

	... if (v < A)
		...
	else if (v < B)
		...

which makes the string of ifelse more readable.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 7326cf5401cc..4c1a60ce9d42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -499,19 +499,19 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 	 */
 	if (clk_rate < CSR_F_35M)
 		value = STMMAC_CSR_20_35M;
-	else if ((clk_rate >= CSR_F_35M) && (clk_rate < CSR_F_60M))
+	else if (clk_rate < CSR_F_60M)
 		value = STMMAC_CSR_35_60M;
-	else if ((clk_rate >= CSR_F_60M) && (clk_rate < CSR_F_100M))
+	else if (clk_rate < CSR_F_100M)
 		value = STMMAC_CSR_60_100M;
-	else if ((clk_rate >= CSR_F_100M) && (clk_rate < CSR_F_150M))
+	else if (clk_rate < CSR_F_150M)
 		value = STMMAC_CSR_100_150M;
-	else if ((clk_rate >= CSR_F_150M) && (clk_rate < CSR_F_250M))
+	else if (clk_rate < CSR_F_250M)
 		value = STMMAC_CSR_150_250M;
-	else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
+	else if (clk_rate <= CSR_F_300M)
 		value = STMMAC_CSR_250_300M;
-	else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
+	else if (clk_rate < CSR_F_500M)
 		value = STMMAC_CSR_300_500M;
-	else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
+	else if (clk_rate < CSR_F_800M)
 		value = STMMAC_CSR_500_800M;
 
 	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
-- 
2.47.2


