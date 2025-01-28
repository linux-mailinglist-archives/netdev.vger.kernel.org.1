Return-Path: <netdev+bounces-161382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8779A20D90
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94D67A25A7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998EB1D61B9;
	Tue, 28 Jan 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yB2Rd7p3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D81D7E4F
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079334; cv=none; b=RazXi7l4TXaXFUtHBM5Di0RBwwE/5beb5T4qiJJUTrHKLYkgURolLOUQYMteWAGIMS4D1Pufnqfv/GY4qlyv4rTE93lxUGGyhQhCUtrsk60L/eOxohQbYnMhIk6bXQH8UO4QFi5deu+ZfHu3MSTkJOo9GMmL1ORi6kuIYcf9w1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079334; c=relaxed/simple;
	bh=1BHe094AG80R20DlfxTgsAkD26DnDmTqKqyftUdquZY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=L7aIuuyYcSQF7xDNFbj/vZmd0dOg+Ww9oaR37uOj3zmZSXwhgrs8PB9rYZonXb9DtQsDm9fPWCfnr6CV+SJr6ENtMBlT3lg4srwAU7WFj+GH3KPXziVpqioiX1rBFXYJ0rOpFTExQJyTOT8ckLmTnDZ2XIpJ3P6jnkukowC8tfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yB2Rd7p3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6rfnXHnjbMDiB1789GYEEadHIP4lGhQCiXiqIwLjLMI=; b=yB2Rd7p3hmHAn71SUOZ1OntbEK
	c6jInQgQtAYCxM3VjPIRwBhe9YRM277yOyYVhXGWPJaocZwYIqeE8u2VLrdq7KVEQd46GcuHjgAKs
	u++FgDDI0Ef7SqzMKzb7pxNgG5rc15PAD2dTgIgBQDep6IRgL5wOQsUm6+9VDr1k2kMhi6B/OkCyG
	qIP2V8OOaBiNHtGghWPH+F9G5CS3BTR4zgDPs8FelzISngZKgilozrVHFUzHK8NHdlHYX63qalaFV
	qzZiKwHwLI4mP/6tmoV7ZZJttEPO4ZBFg32GSYpEAX8QaQO+Kcf2l/ygfcJSm82jyIJdQ/icKa54x
	JoZ2r7Jw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50694 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpW-0007YD-1d;
	Tue, 28 Jan 2025 15:48:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnpD-0037I0-7t; Tue, 28 Jan 2025 15:48:27 +0000
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
Subject: [PATCH RFC net-next 20/22] net: xpcs: remove xpcs_config_eee() from
 global scope
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnpD-0037I0-7t@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:27 +0000

Make xpcs_config_eee() private to the XPCS driver, called only from
the phylink pcs_disable_eee() and pcs_enable_eee() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 14 ++++----------
 include/linux/pcs/pcs-xpcs.h |  2 --
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 1f312b5589a3..6a28a4eae21c 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -602,8 +602,8 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		__set_bit(compat->interface, interfaces);
 }
 
-static int __xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
-			     int enable)
+static int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
+			   int enable)
 {
 	u16 mask, val;
 	int ret;
@@ -632,12 +632,6 @@ static int __xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 			   enable ? DW_VR_MII_EEE_TRN_LPI : 0);
 }
 
-int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
-{
-	return 0;
-}
-EXPORT_SYMBOL_GPL(xpcs_config_eee);
-
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
@@ -1203,14 +1197,14 @@ static void xpcs_disable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
-	__xpcs_config_eee(xpcs, 0, false);
+	xpcs_config_eee(xpcs, 0, false);
 }
 
 static void xpcs_enable_eee(struct phylink_pcs *pcs)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
-	__xpcs_config_eee(xpcs, xpcs->eee_mult_fact, true);
+	xpcs_config_eee(xpcs, xpcs->eee_mult_fact, true);
 }
 
 /**
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 749d40a9a086..e40f554ff717 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -50,8 +50,6 @@ struct dw_xpcs;
 
 struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs);
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
-		    int enable);
 void xpcs_config_eee_mult_fact(struct dw_xpcs *xpcs, u8 mult_fact);
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr);
 struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
-- 
2.30.2


