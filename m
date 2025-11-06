Return-Path: <netdev+bounces-236192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A6FC39AE8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF8484E2D11
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A33093BC;
	Thu,  6 Nov 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dhzJUk3z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F53090CA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419449; cv=none; b=kaPS4O/iBn09T2Tto3SjDtRIq32Z9WKRThwKhKePEFjMOLnVL0fME6KOPgaY7RdM2NiGnZG5jtI3ZGFGcfUZDq1vGFQDSGZq1ClN9nIL/7oqXMJ9DlQCqUcrNOXuuYX7ehBLxByeFFRcfRzjkF9SUC6n0O8YLQSDJf9j/Bkc33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419449; c=relaxed/simple;
	bh=A11yE0gELJxjGJ3mPN5xUExSw1JGYBDP+PFixcDyOeY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=j+kIUne4cEO9TY28ZqH2QWYPFwMHO41X/D+4jjRjLjV+Jzk6/5KtL6xv3gbeFHNm6sRPYrJTV4Vl7xTO9lk3h11QLNIF5JDdhbvtEsB+hlW8HRDyy2W6/PqtRKuMOPHtxKcWf5d6G7n9aIhurE9DMHPjoFvUyHBcXEg5m1unduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dhzJUk3z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Usa7VIevC0jki+KrHbnrqazXMhE2dQaXFRN8HRS1gCQ=; b=dhzJUk3zMFgdi4MjV1sWO+9fK0
	E95FPZYjoM4bJvTQR8mVJudcceLxckLDXUalVGW00Z9rZ9KHynRui3P/rCVfGm1peZ0D5VC2EZAUJ
	nLL+XIkc6jEeT7/cFDPuVQ67Y9Dw2eOUcdR9DVFcixpOHwPXrbScr6FV5+MgkylZ98R1CZcTZ/8M2
	o6XjSOdP1Bv6gg+yfyrPIwwEdzo8mqE5U25s4qKBbn8yYgDvWDVCZ62RjhiMOhON168ihXV3sr0PA
	ZGxxlOHjmSx+bxhoIbMknjP5FjuxkXh1mhHsSjRJ8pTghNQzsqH8YHgdtaUk7YqI/JrjrQdVQIEHx
	ZFNyhROQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58860 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvo0-000000004X5-2BYL;
	Thu, 06 Nov 2025 08:57:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvnz-0000000DWoJ-3KxL;
	Thu, 06 Nov 2025 08:57:19 +0000
In-Reply-To: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 01/11] net: stmmac: ingenic: move
 ingenic_mac_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvnz-0000000DWoJ-3KxL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:57:19 +0000

Move ingenic_mac_init() to between variant specific set_mode()
implementations and ingenic_mac_probe(). No code changes.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index c1670f6bae14..8d0627055799 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -71,20 +71,6 @@ struct ingenic_soc_info {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
 };
 
-static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
-{
-	struct ingenic_mac *mac = bsp_priv;
-	int ret;
-
-	if (mac->soc_info->set_mode) {
-		ret = mac->soc_info->set_mode(mac->plat_dat);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
@@ -234,6 +220,20 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
+static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
+{
+	struct ingenic_mac *mac = bsp_priv;
+	int ret;
+
+	if (mac->soc_info->set_mode) {
+		ret = mac->soc_info->set_mode(mac->plat_dat);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ingenic_mac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
-- 
2.47.3


