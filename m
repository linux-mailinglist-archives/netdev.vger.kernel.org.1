Return-Path: <netdev+bounces-161384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A1CA20D98
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149661885E48
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770F1D79B3;
	Tue, 28 Jan 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FrwZRmJH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BB1D7E4F
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079344; cv=none; b=hpBtRFK6ejlecwLdS2sj/CwM4T5Qf4sFziRa0R4Px8uqQv18ZkJ06+NCZqXPqZH9pyjMxkcsaMBAIvhNDljR94PpyQ5Xj1vB/wQw9Q+pBIBXUA2XzJEDlBMY+ET6vtIRI+yRB8QOb9DurCwqJ/oSTX5cdTOHjdBQI0TGVpcYcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079344; c=relaxed/simple;
	bh=sTuYXbySmbjcVjNbfEfYlCDFF9wIlooim/PWT8qCq6Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mpu4vEUMo01rctLMetuMj+egSj2F18py4hG8+rG9uXDg5169tmPwxPoQz3myUzn7DLB3sji/HPmuYmBDLzsVZf4DQYIDbg+URINjIZ1HSn/q5PVSPl//na8cp0kAS35fGBy0Da3JBWWxbpSwt2Cgki+lT3rsV2Em18zK3DW9jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FrwZRmJH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IYHYMMQNyPankXBbRMqXeOpq9/s7Dc9NDhL2nVI10Tc=; b=FrwZRmJHLwfATFGXy1APiwPtpZ
	UgRMGwPbUKOl6q/YhJHjQQ/SGeqERmGHvUophAT6qbpMZVydILqHaNW5ARqJfB0X6hutuiMcKr6uv
	4P1sykj+BYMkXnT4k8+lqoxeimZp+JaeA2bet5UBoasZ4qVUCSHR/MVVBSGAH/3rrw5zE4vv+uDuc
	Pe1nAlBRFVZC02ieB+m92ptWea/T1dnzmxR7FqLZHOyybC1J/w8/16Pa+shA2H3sv08ts94QIy5Fo
	VKN7NoK3mB2saz4rw6ArgaGFuEh2HRfuQU95PKRBJUqu+ae17awYF5/Sz7+0BypHOd4uMt6Z0LQMm
	ZLkiqV/A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59948 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpg-0007Yl-2Y;
	Tue, 28 Jan 2025 15:48:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnpN-0037IC-G9; Tue, 28 Jan 2025 15:48:37 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 22/22] net: xpcs: group EEE code together
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnpN-0037IC-G9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:37 +0000

Move xpcs_config_eee() with the other EEE-related functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 58 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index cae6e8377191..ee0c1a27f06c 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -602,35 +602,6 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		__set_bit(compat->interface, interfaces);
 }
 
-static int xpcs_config_eee(struct dw_xpcs *xpcs, bool enable)
-{
-	u16 mask, val;
-	int ret;
-
-	mask = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
-	       DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
-	       DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
-	       DW_VR_MII_EEE_MULT_FACT_100NS;
-
-	if (enable)
-		val = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
-		      DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
-		      DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
-		      FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
-				 xpcs->eee_mult_fact);
-	else
-		val = 0;
-
-	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL0, mask,
-			  val);
-	if (ret < 0)
-		return ret;
-
-	return xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL1,
-			   DW_VR_MII_EEE_TRN_LPI,
-			   enable ? DW_VR_MII_EEE_TRN_LPI : 0);
-}
-
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
@@ -1192,6 +1163,35 @@ static void xpcs_an_restart(struct phylink_pcs *pcs)
 		    BMCR_ANRESTART);
 }
 
+static int xpcs_config_eee(struct dw_xpcs *xpcs, bool enable)
+{
+	u16 mask, val;
+	int ret;
+
+	mask = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
+	       DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
+	       DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
+	       DW_VR_MII_EEE_MULT_FACT_100NS;
+
+	if (enable)
+		val = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
+		      DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
+		      DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
+		      FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
+				 xpcs->eee_mult_fact);
+	else
+		val = 0;
+
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL0, mask,
+			  val);
+	if (ret < 0)
+		return ret;
+
+	return xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL1,
+			   DW_VR_MII_EEE_TRN_LPI,
+			   enable ? DW_VR_MII_EEE_TRN_LPI : 0);
+}
+
 static void xpcs_disable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
-- 
2.30.2


