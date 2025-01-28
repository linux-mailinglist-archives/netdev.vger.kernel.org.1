Return-Path: <netdev+bounces-161380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC59A20D94
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EEF188AACC
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1641D6187;
	Tue, 28 Jan 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oe44UCKY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B141CF5E2
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079324; cv=none; b=DWWCSISXRJm+xg1BBTVrWT4jVrC+Kw75b7kQW/K6bQw7zvmSkakL65NyvyBt6Ffxby7N5tgrUEhrSWzVUNHpNcraGkKJeI+3dKb0G0ELwfO+XY8W/Q3W5es34TBHS/ylho/WL8ILwGqEPCYtXEFS6B1YssJlw2zZoVTJuNrtxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079324; c=relaxed/simple;
	bh=auudkUENHR/rzJTrBZhDpWZRXW5L7xS8S3P1pJxlUnI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ise7C23HUYfrw5LJ/kEegekuH5rGOTF+m56GrVI7lsEW8KjaiObOxA4H+0FI3Ijq83stNi1PC4BI6RYbw6YQNF46PpVv8fURNc6BaWYbXb4kt4KpyxUdcsqGxyj9xd3FaJ6y4kvLh30a3OoJOLdb5pv+E7DWoDi7od8zLYZPJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oe44UCKY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j461s14qgObm3BQcSpP69PwmbamUjRyDGX5X2yhG5V8=; b=oe44UCKY8l5X1WRxH1YJQkcxVl
	E6fOGhrBZANAxzVyo9bWBMGLJGRm3n6tkqJlJcFXh4aymNHlPBKgT5MwLpAx6pp3mP33+bOs+Hb1M
	dKDJ+ZnGkAIah0SF2w85oC7SyZWg9hd5naUQJxaadXt3DCanjtSPt0nWN2yHNFWFaUrAqwEysDeDE
	0piFftfZ+7TrcF3v207yhem/TVYpn+LwlQmkiQ18L0kHIGaZqCT6l6SdzrzXKqQ5hADUNxdreubf/
	dO1V2fFUrhY0xqvnYg7kiFNr0N2tlizwpQWmRcgVgHaCaNQcnIRAL5etWHkRMESg/7rRLhrKrG1CJ
	DUx4H4fA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45710 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpM-0007Xf-1C;
	Tue, 28 Jan 2025 15:48:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnp3-0037Ho-0d; Tue, 28 Jan 2025 15:48:17 +0000
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
Subject: [PATCH RFC net-next 18/22] net: xpcs: convert to phylink managed EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnp3-0037Ho-0d@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:17 +0000

Convert XPCS to use the new pcs_disable_eee() and pcs_enable_eee()
methods. Since stmmac is the only user of xpcs_config_eee(), we can
make this a no-op along with this change.

Questions:
1. Do we actually need this level of control at the PCS - or would it
   be sufficient to configure it once during initialisation?
2. Do we need to clear the mult_fact field when disabling EEE?

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 91ce4b13df32..1f312b5589a3 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -602,7 +602,8 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		__set_bit(compat->interface, interfaces);
 }
 
-int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
+static int __xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
+			     int enable)
 {
 	u16 mask, val;
 	int ret;
@@ -630,6 +631,11 @@ int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
 			   DW_VR_MII_EEE_TRN_LPI,
 			   enable ? DW_VR_MII_EEE_TRN_LPI : 0);
 }
+
+int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
+{
+	return 0;
+}
 EXPORT_SYMBOL_GPL(xpcs_config_eee);
 
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
@@ -1193,6 +1199,20 @@ static void xpcs_an_restart(struct phylink_pcs *pcs)
 		    BMCR_ANRESTART);
 }
 
+static void xpcs_disable_eee(struct phylink_pcs *pcs)
+{
+	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+
+	__xpcs_config_eee(xpcs, 0, false);
+}
+
+static void xpcs_enable_eee(struct phylink_pcs *pcs)
+{
+	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+
+	__xpcs_config_eee(xpcs, xpcs->eee_mult_fact, true);
+}
+
 /**
  * xpcs_config_eee_mult_fact() - set the EEE clock multiplying factor
  * @xpcs: pointer to a &struct dw_xpcs instance
@@ -1355,6 +1375,8 @@ static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_get_state = xpcs_get_state,
 	.pcs_an_restart = xpcs_an_restart,
 	.pcs_link_up = xpcs_link_up,
+	.pcs_disable_eee = xpcs_disable_eee,
+	.pcs_enable_eee = xpcs_enable_eee,
 };
 
 static int xpcs_identify(struct dw_xpcs *xpcs)
-- 
2.30.2


