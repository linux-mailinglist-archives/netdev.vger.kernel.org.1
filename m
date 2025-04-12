Return-Path: <netdev+bounces-181909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29BA86D9E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 16:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC1A3B09BE
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36707186E54;
	Sat, 12 Apr 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZXhZqFZm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40EE13E02D
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467473; cv=none; b=Dk9FmY9Y8/gM9WoQu4yIMkh7WmJ23AYUyt8URxPm6qsId4s7axR0Z6EQzDRsjdvFjLVlCeDM8D7DthZWxL0UOGV2QhJTdAfqu76tgYP1S7fGNuI09tHTahiEmotvgNz8BvBsJuLf3g0ycuwDrL7uu19bFOaXUUuLsBP3huaVIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467473; c=relaxed/simple;
	bh=OAob/O7wRvs6WQnewkhL2HbtW2PxQJRhD3GKD/t3iUw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rOuuR4oCAfdkpffW9nMvS+4JKRaCkOhxn/CXk69kVA0VQ57YYyP46H5HmLu0ooxUN9wAHlPsEijVI0cDInTyZ3AeFE8ZjEkQanIzthKOnxk1CJHAOVZIIorYUrjudWz89JJoEvJTywaXcYf1Cz4Qz8dw8DbPLlHouMMujZ0f9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZXhZqFZm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I+tqpzcvIfMSvkwfj4Wt8zWvm38OZPWN5QBKZwmvXH4=; b=ZXhZqFZmvU0DA71lAdEBfkv6Yg
	Hh/Fquh2A1e+7EN4Hbk9iRdkk+LZHdbA+VlQ+aXRndwFXblwb+lxR+2jvDEZGhq4uY/AhBF6d1sLz
	Pxql//PL0H41zCovGuDT+YtKT7xzSF4/BadgJAGFxHHj2hLm9MrD3z4GAjXYiqXO/gKwKHOYk8xDT
	v2rSHrOlRW6Ms/3onSGO2WW5f56TQ1ZiVy1RJEk6mcxI0/6CzOIdYKS7lgYVX3tlmDGj480jTIyDl
	rzhcrOndRejBBotBIK1oPAMBSQac+txe5BHlRWLWCgQ0egCJD5UM9b53NO9Cw6QxdrH3bR5uCIyuB
	alE2+VeA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50618 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3bg0-0004cU-2d;
	Sat, 12 Apr 2025 15:17:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3bfP-000Elx-JE; Sat, 12 Apr 2025 15:17:07 +0100
In-Reply-To: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/4] net: stmmac: anarion: use stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3bfP-000Elx-JE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 15:17:07 +0100

Rather than open-coding the call to anarion_gmac_init() and then
stmmac_dvr_probe(), omitting the cleanup of calling
anarion_gmac_exit(), use stmmac_pltfr_probe() which will handle this
for us.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 941ea724c643..8bbedf32d512 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -111,10 +111,9 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->init = anarion_gmac_init;
 	plat_dat->exit = anarion_gmac_exit;
-	anarion_gmac_init(pdev, gmac);
 	plat_dat->bsp_priv = gmac;
 
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	return stmmac_pltfr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id anarion_dwmac_match[] = {
-- 
2.30.2


