Return-Path: <netdev+bounces-233700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96AC1776A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A21A2270E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2BF9E8;
	Wed, 29 Oct 2025 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J9RSanNM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF245224F6
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696211; cv=none; b=fsFeRBdGWX3RcPpVhyeE32Th2tdXhcWP7ETe6QffQwoc9MsLv0OgJ6pu9hrjazyfQiD6FUln0dz1A/62N8jCFOv1jFJF9w2L9B9lmfe+oP+Td3smCL912tdGyJgwK9POoBCNAJ322ESV3n/2i6kslth2y5djSqsQQXpNHAHzbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696211; c=relaxed/simple;
	bh=mNdObIAO1wj1ttRBYwdFB5wdIXi0gNxwMDOhXWajprw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uC1ZLd3Jd0UErAUTYK+GSuPmqN+5rh8r2GsU+FcBxk/SsbMjhjtkJLodbW/dFTatUFLJ4Fp7zyqMjSgHIsKR/oRkQ6zSt+WbQu38dinWUl1uDmo37FWQ0SNd5YszSbL2K4dLvpv8a3bvnHg6UxTXwNRTkG3LdU3GYKlEXm9Urjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J9RSanNM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YKb3zcptv29O5DmjlyLQJ8+1I6cjWJtKnsSRvomNl/o=; b=J9RSanNMSyln0KRV7qgbPC0Ws9
	Lput0KQVfn5Ofk4SFVg1vzJM3LmScJx/mVbmXOJ4R3IWwh37qRaKIxchOyfWG5l23d+NBjl/Uibm6
	ShIDdrPJ2JmWVjFo5kS248ZbeOC4J2QgxClJJxqXGkbQttcl4mm+1WAJ/4El7aSi0igR4dIBGNW60
	rUs2Xd8/6BMtxlwUJ9nURlv3Zno0gmFe1ztyByF2mTcGU7vWz/wS8URF+s7vImBmubqujS87iGk8b
	X9bpZtWNGXdurc6M+vrXiIesR4JSvIzfHFvUNp5UO+2J871eiRWstl5rWYhkRJpSKL2C7bqiUikIT
	6UCmhQFg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56210 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDter-000000003gz-3N0n;
	Wed, 29 Oct 2025 00:03:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDteq-0000000CCC3-3zbJ;
	Wed, 29 Oct 2025 00:03:20 +0000
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next v3 3/8] net: stmmac: consolidate version reading and
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vDteq-0000000CCC3-3zbJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:20 +0000

There is no need to read the version register twice, once in
stmmac_get_id() and then again in stmmac_get_dev_id(). Consolidate
this into stmmac_get_version() and pass each of these this value.

As both functions unnecessarily issue the same warning for a zero
register value, also move this into stmmac_get_version().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 29 ++++++++--------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index f6ada5a905fe..ffdc101ce3ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -18,30 +18,16 @@ struct stmmac_version {
 	u8 dev_id;
 };
 
-static u32 stmmac_get_id(struct stmmac_priv *priv, u32 id_reg)
+static u32 stmmac_get_id(struct stmmac_priv *priv, u32 reg)
 {
-	u32 reg = readl(priv->ioaddr + id_reg);
-
-	if (!reg) {
-		dev_info(priv->device, "Version ID not available\n");
-		return 0x0;
-	}
-
 	dev_info(priv->device, "User ID: 0x%x, Synopsys ID: 0x%x\n",
 			(unsigned int)(reg & GENMASK(15, 8)) >> 8,
 			(unsigned int)(reg & GENMASK(7, 0)));
 	return reg & GENMASK(7, 0);
 }
 
-static u32 stmmac_get_dev_id(struct stmmac_priv *priv, u32 id_reg)
+static u32 stmmac_get_dev_id(struct stmmac_priv *priv, u32 reg)
 {
-	u32 reg = readl(priv->ioaddr + id_reg);
-
-	if (!reg) {
-		dev_info(priv->device, "Version ID not available\n");
-		return 0x0;
-	}
-
 	return (reg & GENMASK(15, 8)) >> 8;
 }
 
@@ -50,6 +36,7 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 {
 	enum dwmac_core_type core_type = priv->plat->core_type;
 	unsigned int version_offset;
+	u32 version;
 
 	ver->snpsver = 0;
 	ver->dev_id = 0;
@@ -62,9 +49,15 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 	else
 		version_offset = GMAC4_VERSION;
 
-	ver->snpsver = stmmac_get_id(priv, version_offset);
+	version = readl(priv->ioaddr + version_offset);
+	if (version == 0) {
+		dev_info(priv->device, "Version ID not available\n");
+		return;
+	}
+
+	ver->snpsver = stmmac_get_id(priv, version);
 	if (core_type == DWMAC_CORE_XGMAC)
-		ver->dev_id = stmmac_get_dev_id(priv, version_offset);
+		ver->dev_id = stmmac_get_dev_id(priv, version);
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
-- 
2.47.3


