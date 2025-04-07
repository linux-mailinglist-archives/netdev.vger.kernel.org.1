Return-Path: <netdev+bounces-179873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477BA7ECB4
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5404440910
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FC25A2A1;
	Mon,  7 Apr 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aSGIamiJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DA259C90
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052393; cv=none; b=svtBqn68Gh7KcP6rt+fc4PzIDDNrmJyrQ/JgkNfOMid3VLMLBV3ce0JJyDrRlLb0mMawjSiweZ7DzHQQ5TfldqIco0kfrLdEYNVtC1YkTPpNfqDGb/VR5fcwfoBRvl63JIuTZ9j0rbn17J/6q07NAYhDB3zs3UUCqSwk8hVSjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052393; c=relaxed/simple;
	bh=kLCnRssc8WmKeFbm7JpTO/wcG5Hc89ZUj5kVl6Gn6s4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Hmt7H584fDa0GRVcBpqD53SNEIm2mN0y7oZwNYuOeAs4G4Tip9QW4OqraIknbuSvQr5MwxPVbrZBKfy8aXZstbNc0fbGenbKbLb3npNCNvkFtY2CtFLvBF+UxRtJKsjYd/hb9nDD7RV6xDbh1eEHtPcezerhUHPDZtxsgJPzYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aSGIamiJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g+gTqjr9DCh74fm5MrIN8IfG63yVQfUMTpEsACnoz9g=; b=aSGIamiJukybih316LqvTsGTCU
	VJrvt/A8Zi349runxTQ69QaQi0QPBl4R2XSxcE7aIP+xD5O1s5Rwajkxo+EHErgJM5Iy63s2KUKmM
	9bDd2+WP3srjq7mU2Lmxi9a57c6tQropXqxKy76NXPvRL4GWDKng97FpnMbZ7fhDeaAJq1se6+7AJ
	xLIYV42W3RV4xvEaXvdVpUyrEa8vs4MRHegTVntemDmTkXCAlwFRivqysD9KDJ7VYU6FL0Bkj8GzR
	WE0lGLkhEiq80lGjbyDZWRpTr+viXLhmvkbpZGECYwfVcH7+IpUBBjLMVT0C4ZCm9Rm/k+Ssudqnc
	F8zRG/Cw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43020 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u1rh9-0006AU-1k;
	Mon, 07 Apr 2025 19:59:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u1rgd-0013h1-Fz; Mon, 07 Apr 2025 19:59:11 +0100
In-Reply-To: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 5/5] net: stmmac: remove GMAC_1US_TIC_COUNTER
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u1rgd-0013h1-Fz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 07 Apr 2025 19:59:11 +0100

GMAC_1US_TIC_COUNTER is now no longer used, so remove the definition.
This was duplicated by GMAC4_MAC_ONEUS_TIC_COUNTER further down in the
same file.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 42fe29a4e300..5f387ec27c8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -31,7 +31,6 @@
 #define GMAC_RXQ_CTRL3			0x000000ac
 #define GMAC_INT_STATUS			0x000000b0
 #define GMAC_INT_EN			0x000000b4
-#define GMAC_1US_TIC_COUNTER		0x000000dc
 #define GMAC_PCS_BASE			0x000000e0
 #define GMAC_PHYIF_CONTROL_STATUS	0x000000f8
 #define GMAC_PMT			0x000000c0
-- 
2.30.2


