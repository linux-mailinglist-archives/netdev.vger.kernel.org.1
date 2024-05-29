Return-Path: <netdev+bounces-98899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474248D31BB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727ED1C21357
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92D163A9B;
	Wed, 29 May 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HD3GavIt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2967347D
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972058; cv=none; b=K7f+q0FDTniMeRGiVXzPsnQa7BOHpKBAIUnSi92SwFg0ijWmi3heUofgBxos3QJpOC8Riw0KaX3dA/aBMAWwoDk6Lp1uFlcmRqq/9YNcHxTBcW48rFkHMEhZZok5UiTWuztiT5CEC9mu9W9vQ5JOookG6NG5EneW8X/5q8D8Z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972058; c=relaxed/simple;
	bh=cCdHpYYuMg/S9ihbBS55tP8KZaTYjOotB3eYOWt2F9E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ObDi3So7zIKyW6qpA22zCLqVCeu3Cc93fIk+mxk5hNGTIDQpMvKWtFnsqaHiSHuEkc63lWvWk1vfeeT1UYK4WRnhrRzQhtrcP71YRwj379N+YIp8WQRL0RclQrxkv7HJGc3SrWaqLgzDFvs7Nu1Z7CGJwsRnMyJ6njdeMNmD0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HD3GavIt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SF4BuJLiju0JGcrTZ4HGvQB6GXKp+081aEYB84kEgGw=; b=HD3GavItN4Cl+aBFJOSt0ANABe
	Xsj/hqnT5RCKO6JFXFNbZTeeb4doXnsfF6KqBXYaS2YG7je2t3XjeyA6vLeFF62Ev1dHtqRlytJkE
	wecDzwdXy4V77kY/JpTzpcarw2/O4usvhS4FuMKfS2PUVfVg8mvx++Y4RtVQWrElUtQUIKbPWG28r
	qiKtgdEHJGGe9/cYphzMmcT8Tl0GAO3zkR7O2mzZqt1hv72r4D/6SuD7fWhkJtHWxOLUIuPBPqb1/
	Cyd/bVMm/MFDCGm7JORBJoas8Zq4QdkvbofwoFoPctFN23SecfiThKswcom0w6mjhBxgpxS+xkFtX
	2tOmdehg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44964 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCErS-0005m1-0P;
	Wed, 29 May 2024 09:40:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCErU-00EOPr-MC; Wed, 29 May 2024 09:40:44 +0100
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 3/6] net: stmmac: remove pcs_rane() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCErU-00EOPr-MC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 09:40:44 +0100

The pcs_rane() method is not called, so lets just remove this
redundant code.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c    |  6 ------
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c   |  8 --------
 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  3 ---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h    | 17 -----------------
 4 files changed, 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 8555299443f4..d0c7c2320d8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -404,11 +404,6 @@ static void dwmac1000_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-static void dwmac1000_rane(void __iomem *ioaddr, bool restart)
-{
-	dwmac_rane(ioaddr, GMAC_PCS_BASE, restart);
-}
-
 static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
 {
 	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
@@ -519,7 +514,6 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
 	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
-	.pcs_rane = dwmac1000_rane,
 	.pcs_get_adv_lp = dwmac1000_get_adv_lp,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index b25774d69195..dbd9f93b2460 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -758,11 +758,6 @@ static void dwmac4_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-static void dwmac4_rane(void __iomem *ioaddr, bool restart)
-{
-	dwmac_rane(ioaddr, GMAC_PCS_BASE, restart);
-}
-
 static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
 {
 	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
@@ -1215,7 +1210,6 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_rane = dwmac4_rane,
 	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
@@ -1260,7 +1254,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_rane = dwmac4_rane,
 	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
@@ -1309,7 +1302,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_rane = dwmac4_rane,
 	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 90384db228b5..97934ccba5b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -370,7 +370,6 @@ struct stmmac_ops {
 	/* PCS calls */
 	void (*pcs_ctrl_ane)(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 			     bool loopback);
-	void (*pcs_rane)(void __iomem *ioaddr, bool restart);
 	void (*pcs_get_adv_lp)(void __iomem *ioaddr, struct rgmii_adv *adv);
 	/* Safety Features */
 	int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp,
@@ -484,8 +483,6 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, debug, __priv, __args)
 #define stmmac_pcs_ctrl_ane(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, pcs_ctrl_ane, __args)
-#define stmmac_pcs_rane(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, pcs_rane, __priv, __args)
 #define stmmac_pcs_get_adv_lp(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, pcs_get_adv_lp, __args)
 #define stmmac_safety_feat_config(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 13a30e6df4c1..1bdf87b237c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -74,23 +74,6 @@ static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
 	}
 }
 
-/**
- * dwmac_rane - To restart ANE
- * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
- * @restart: to restart ANE
- * Description: this is to just restart the Auto-Negotiation.
- */
-static inline void dwmac_rane(void __iomem *ioaddr, u32 reg, bool restart)
-{
-	u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
-
-	if (restart)
-		value |= GMAC_AN_CTRL_RAN;
-
-	writel(value, ioaddr + GMAC_AN_CTRL(reg));
-}
-
 /**
  * dwmac_ctrl_ane - To program the AN Control Register.
  * @ioaddr: IO registers pointer
-- 
2.30.2


