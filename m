Return-Path: <netdev+bounces-229674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA84BDF985
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89424405579
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9A2DCBF1;
	Wed, 15 Oct 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HMbUq3eI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AC32ED2E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544677; cv=none; b=AJPm+Q+GYj5dYXFBph5aEKPwkvHiMjRIv7YA30VM1ttACWFbelljR+5aEDAzTiUy9tXZ8rKV+GZkrslR09Kl13/TkIgdAtnqEwgaVoR7iamSOnlSkz6sJYVUba0bqzKX2rx+i+BBzd5/eT6apnEvS5hVjKA3KDjT3hsh2cyAn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544677; c=relaxed/simple;
	bh=YBpfKHUXhgUhb2xBPiZKaY7khnnPifMbCzeAT05btls=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Kb2p6QSdVtrRa9l5oX0htrorAbjmwswBJhnYfCv/qZZrtkUmakbsceKlGVFWx02uN9Lbzp4pEgOfZ29nmWQUlJJ5rgWXXLogwU/s/4w0bZk8h77d/zHtJJ3+oN8R5hihZvocNMVp0ErdaTgbPu6AXncEOAylSOXuBUnnQWECIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HMbUq3eI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eplxvysfx85LPhdZ5hWcUUD0i0J3w274wHdDz18TaWo=; b=HMbUq3eIlPgCK522VNy2nopUYq
	bQGaUVC9JCVn8ftCRCvjxzbPLuQVr0BInbCKKAINI9eipgUEdzA1LAJ4Ak9GXzR4Gvc5YGjufyWIT
	WuSyNHpllPjvr9KXB4GDd/rQOpVNDYr75tlRHAc1YPiajIzKp7IcrzsDRAVtUAzBIDUZkcwd6KLo0
	UR/ghtOA18pTwvk0u/0zSO6cxDIJBbPwqaNp1VN00Usvt0kbsloAe4HPQG4BM27zjSzDyopkcYcNj
	JWcpXCi3QT0vw19qmqOp+R2ivohoAbvoNgn1tSVfu2v3AiX5ynLyg4EtXfQUX8NyCh/wu/PKgYbod
	BCXzzslg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42348 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v945g-000000005Ar-3gCO;
	Wed, 15 Oct 2025 17:11:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v945d-0000000Ameh-3Bs7;
	Wed, 15 Oct 2025 17:11:01 +0100
In-Reply-To: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/5] net: stmmac: rename stmmac_phy_setup() to
 include phylink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v945d-0000000Ameh-3Bs7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Oct 2025 17:11:01 +0100

stmmac_phy_setup() does not set up any PHY, but does setup phylink.
Rename this function to stmmac_phylink_setup() to reflect more what
it is doing.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 500cfd19e6b5..c9fa965c8566 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1185,7 +1185,7 @@ static int stmmac_init_phy(struct net_device *dev)
 	return 0;
 }
 
-static int stmmac_phy_setup(struct stmmac_priv *priv)
+static int stmmac_phylink_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct phylink_config *config;
@@ -7642,7 +7642,7 @@ int stmmac_dvr_probe(struct device *device,
 	if (ret)
 		goto error_pcs_setup;
 
-	ret = stmmac_phy_setup(priv);
+	ret = stmmac_phylink_setup(priv);
 	if (ret) {
 		netdev_err(ndev, "failed to setup phy (%d)\n", ret);
 		goto error_phy_setup;
-- 
2.47.3


