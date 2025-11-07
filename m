Return-Path: <netdev+bounces-236686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81341C3EF27
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F04D3ADAAE
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BF30F94B;
	Fri,  7 Nov 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z4vWbDH8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C730F93A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504124; cv=none; b=GwOcCAU0aF9V/0yAQFqnyR9yMoq2NuKFELKJmlDV/d1ojOyQi73lbQG+q2iDTrs2n7NxP3ZoDRYtLz8/k3U55abhM15FybDPINbziXcSbkyz7rZnSfir6cIn4I5QzE18MUVdZ0yDnRv/ax9LPzKNJFgHe8sg/5NddwBtQEQbRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504124; c=relaxed/simple;
	bh=vs+TxUdvRwkssxzfGd/vbgKbALAl2a+5Z74NoPSGubU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lzGNdwWbYCPyBZLJHXX5KaLCf7sEWu9XQrUBpoJq9QQ9F/iKlAX3YDe+Hh0fgvm2VS77Rl+XeA/JcUzdkPFm1Uu8YKq2MT+nwW+wsl+7T831Nl1UjvxLPz1wtC18CXJIzOxKtdb6WkCNXg4phrPpYHFn75wH3LeOm0qpnq8Sr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z4vWbDH8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g7ILgVSl1cCXHuRsPTglZobkv3bXbExIQncijaA3L+c=; b=Z4vWbDH8DlbE81UFNr0LreGoWB
	bt2+X09KBN+ES4kUdAYQDQEjqpVyVQTUoVUbsF1TVkMTghkdX7cQqt3ckJEwDlzdVU2Ua4OIf6hB5
	Ag57yJT0unQFnGrKfsqCV0BIpSyonA1albhbfgGL7evXgjHQFC9MlkVBRyvcepm3/c59d/F/i6Bry
	VnK4fvjOTKC36KSwF4IMkj5Cs7/SYqwjcazWuCwtNT60MDu7cvLXcl6XLyXAQMgEs7yFSeXHb6AKN
	PygDSuHBwAI9rxQXsuUSAMrw67Cg80jlWQW9G7wNkgLbTZ/4rM9W0xxzfDmW3wUhSf5HrloqY+sSY
	PjlR5Gow==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58618 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vHHpj-0000000068d-33jw;
	Fri, 07 Nov 2025 08:28:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vHHpi-0000000Djqp-4910;
	Fri, 07 Nov 2025 08:28:35 +0000
In-Reply-To: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
References: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 01/11] net: stmmac: ingenic: move
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
Message-Id: <E1vHHpi-0000000Djqp-4910@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Nov 2025 08:28:34 +0000

Move ingenic_mac_init() to between variant specific set_mode()
implementations and ingenic_mac_probe(). No code changes.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


