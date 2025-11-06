Return-Path: <netdev+bounces-236194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE14C39AEE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B034FBC2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139553093C4;
	Thu,  6 Nov 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xze24uQa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC393090CA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419459; cv=none; b=qGVhv4/EvMpzn2cU1Nj2DGyKI+l0HjqPIHvlLn7zPNK00Da1U+nAbM9kfSvsay3EOrJeWb1hTnnBu4MCfdbf1YG6M9XDqY++HuaAyDR5oYaaa0EZQp9NfUPy52y4tguojWR9mkvpjB3K01TVI8pYCa5OEjZoGmomFXfdsQ8BAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419459; c=relaxed/simple;
	bh=vgUwB4+OupFGo8Ok6mzcL9vuyU+zJ/9sw7c4eBQi9sk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WP7uGtRmKXnDRyhvXegcXekennbGHVwJHfz0tuQ9Vhnh9I942yV3DJALDbL9Q2kRVl4XYWvyxbMIcYf5LvBInmzvXptENaf1jD9smeXQxnXSb/wjJ70g6igmlRQlqyuNLWM/YOVNLJg01AYZ6/MTm0Bho2VTV5MP1P4NUQ9rP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xze24uQa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RV2Kcd9Kteghpl7hZuqvVfyvxIDyd7jGMl9t2h0yvHU=; b=Xze24uQa9WHp6D+5NIgZoxRTas
	ZXI25lXWgGmRaF5Qe8YAt7XSDRul1d2bKUy7BWGSRpUnhhstaoHd5JDgvQ9DiWr09VyBg8hUteepi
	Clav554NA8i9/bE633IYCmf0IAqTk5JNvurOkumtXPxA/9LmIEUBEBsKb2vG7RJ/IpS1tHAJysb+s
	I265sHo3lhRp7VgcbtyWmcaHYXgsmeMAznkkeS0Jz5hxM4taEzOBUlHB9ABt1QETqIXIScvrFMaCH
	/eY+2MXtMUbLXz5i0L7nMvp10rXMqY5tbdYT5hDyVk8V4hQeSGFBgyvIWZVYVCwBM/GMtkASOMpCw
	8R7ou9XA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47784 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvoA-000000004XY-3Fsw;
	Thu, 06 Nov 2025 08:57:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvoA-0000000DWoV-064n;
	Thu, 06 Nov 2025 08:57:30 +0000
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
Subject: [PATCH net-next v2 03/11] net: stmmac: ingenic: use PHY_INTF_SEL_xxx
 to select PHY interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvoA-0000000DWoV-064n@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:57:30 +0000

Use the common dwmac definitions for the PHY interface selection field.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index c6c82f277f62..5de2bd984d34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -35,10 +35,10 @@
 #define MACPHYC_RX_DELAY_MASK		GENMASK(10, 4)
 #define MACPHYC_SOFT_RST_MASK		GENMASK(3, 3)
 #define MACPHYC_PHY_INFT_MASK		GENMASK(2, 0)
-#define MACPHYC_PHY_INFT_RMII		0x4
-#define MACPHYC_PHY_INFT_RGMII		0x1
-#define MACPHYC_PHY_INFT_GMII		0x0
-#define MACPHYC_PHY_INFT_MII		0x0
+#define MACPHYC_PHY_INFT_RMII		PHY_INTF_SEL_RMII
+#define MACPHYC_PHY_INFT_RGMII		PHY_INTF_SEL_RGMII
+#define MACPHYC_PHY_INFT_GMII		PHY_INTF_SEL_GMII_MII
+#define MACPHYC_PHY_INFT_MII		PHY_INTF_SEL_GMII_MII
 
 #define MACPHYC_TX_DELAY_PS_MAX		2496
 #define MACPHYC_TX_DELAY_PS_MIN		20
-- 
2.47.3


