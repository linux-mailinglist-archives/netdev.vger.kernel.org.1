Return-Path: <netdev+bounces-182086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF00A87B75
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D284188DD46
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3BF25D20B;
	Mon, 14 Apr 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hoLn4b4z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A325A622
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621626; cv=none; b=E3f00d2sNtkt7ugEI40A07eQIpZSMbYgSSlIaYD7gQcM1UpGRc5YnQHvfa9C4b5Gl5ClP1w94UdPwhCn++EkCXxRHsm4a7+3nl8Gbcm24j8KMFiPto35RM3k/+xF6jBmOkM61KFL8L4QQ5wBvghF1OEZjPDmVaRz5F5rakqLa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621626; c=relaxed/simple;
	bh=O+sIjCE5KmxXQyvWnHBSsSOa7CvNrZu4Z48cxqaXJRc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=sZageSZ58vZJ4RCYe1oo1JO8z0ce7PnaXm1vp4luxM2mVahJfYzVSJk4Yccbbs6SNPOJpS5hC+IAss243l8JXb0Q6iVM2efQgAe1x6iZDo6P0eKFH9gbAzMKexLY+jAyoUY9mFK8aWg7KZzLnazt8t35YhyOYCokFeDsCMLDsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hoLn4b4z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ueUNA14OVeEPQ6yDhGtqR0ixCik1TrsIANs9nUl+K/4=; b=hoLn4b4zLHROIv6XBtc1AVDBlg
	IxzwN6NDNuK2sV394D+tTFGvbVWW5ZVGDfMnUCom4AczNYgDIg8X5CJdSJWagwjENKO0rosNxHgvO
	XC3Mvju7IEa32zcE0TTOxaLpj7+w4uztvykihRHhIsAT0i0TR+yQlYIGeNB1pmRArj+TXO80GtCD7
	RzhEzFAZ6TULGHHyJhvKPi+TXtO/CqwwLoDPEfJvItX9fQW6YsZt2jmssd9rT8zCEFbOF9wPpB3bu
	Er3c7TkkaAbGnDRBtlt0tb+6QZ4b8ckh/9hv6JrZVEJVJ0hKewXl/QKIKu8Qk1LnNxuyFzVj9sXy3
	8RVxId8Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41512 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4FmB-0006Cn-2J;
	Mon, 14 Apr 2025 10:06:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4Fla-000XjM-Bw; Mon, 14 Apr 2025 10:06:10 +0100
In-Reply-To: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
References: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 3/4] net: stmmac: anarion: use
 stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4Fla-000XjM-Bw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 14 Apr 2025 10:06:10 +0100

Rather than open-coding the call to anarion_gmac_init() and then
stmmac_dvr_probe(), omitting the cleanup of calling
anarion_gmac_exit(), use stmmac_pltfr_probe() which will handle this
for us.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 941ea724c643..99f6c977ec41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -111,10 +111,9 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->init = anarion_gmac_init;
 	plat_dat->exit = anarion_gmac_exit;
-	anarion_gmac_init(pdev, gmac);
 	plat_dat->bsp_priv = gmac;
 
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id anarion_dwmac_match[] = {
-- 
2.30.2


