Return-Path: <netdev+bounces-130949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A198C23E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B96B1C21CE2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B521CB536;
	Tue,  1 Oct 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IWv6v430"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2E1CBE9A
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798711; cv=none; b=ppB1LSWj7wY6a2ZBuh9CwmANViPO68Qacmenn4XiQoSMj6kaHY2wLhOr7oeVnevnuVRclvufUFL1VSj2C/DdjCDH/bcu8UocPoMtmrL9Xpx5yQKGpd3HKlGttsBhBbtBvxt+UTGkjAVwFQVYZ1/DbEcGLS+9kqrrrqe2bxotupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798711; c=relaxed/simple;
	bh=Bm8to34FG4fmwaEWn+HpPoMOFWPAFu9gEDZ5X83XOB0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=H7Nm9M4Qu8xKlFWAcU61UTt6+fQ5ynHpaqTOeL8fL5eQ40K11jynS5+KSueb31q5M8VBz5VCHq7lgHfUQMs64HnhhCKjko02vR5XeOogCefM8h4Bh/U1oqaHfCl2ipsRERL5F3kO73HwNG8Zc+x3k4+yIfJ2EjBxjIZaL46jamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IWv6v430; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v3pW1PogcLfiKVOCsE0vMbePZsD5C2IxoJvwNUxC1VY=; b=IWv6v430VoWh6y3uV1hUArp7K5
	Po/Bgs0Zmo/Joby/TO7PP2w4FFnYeOyF0kulhuqzAbhhj4fjP40nsDjiVOu/dS/u0ev6qnk37FIs2
	V1l8DbRF29e2eb1RwvUG9AQAkQIYHHJWjS/BGQMpmMRybmFj3s5uPiNQUyD0zuTjAqyKXpjOiCBuA
	hToOWtH4FUnSHxypqC89YbGFy03HRrquPZ+y0kr2MebJAPCaGjqDh4zApKev0vMnDQqCkHf+wqvSk
	q2E5H4MfEIcXewNBaz2fEpTtH7QV6FpiwFvl6YYgFDrbxiEXpAUaP7NT/F7Ypw8MrrOMLYIM2rSUe
	KXenWYzQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49178 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMw-00067g-2a;
	Tue, 01 Oct 2024 17:04:58 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMv-005ZIv-2M; Tue, 01 Oct 2024 17:04:57 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 10/10] net: pcs: xpcs: make xpcs_do_config() and
 xpcs_link_up() internal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMv-005ZIv-2M@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:57 +0100

As nothing outside pcs-xpcs.c calls neither xpcs_do_config() nor
xpcs_link_up(), remove their exports and prototypes.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 11 +++++------
 include/linux/pcs/pcs-xpcs.h |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index f25e7afdfdf5..0a01c552f591 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -851,8 +851,9 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
 }
 
-int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
-		   const unsigned long *advertising, unsigned int neg_mode)
+static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
+			  const unsigned long *advertising,
+			  unsigned int neg_mode)
 {
 	const struct dw_xpcs_compat *compat;
 	int ret;
@@ -905,7 +906,6 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xpcs_do_config);
 
 static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		       phy_interface_t interface,
@@ -1207,8 +1207,8 @@ static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
 		pr_err("%s: xpcs_write returned %pe\n", __func__, ERR_PTR(ret));
 }
 
-void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
-		  phy_interface_t interface, int speed, int duplex)
+static void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+			 phy_interface_t interface, int speed, int duplex)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
@@ -1219,7 +1219,6 @@ void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (interface == PHY_INTERFACE_MODE_1000BASEX)
 		return xpcs_link_up_1000basex(xpcs, neg_mode, speed, duplex);
 }
-EXPORT_SYMBOL_GPL(xpcs_link_up);
 
 static void xpcs_an_restart(struct phylink_pcs *pcs)
 {
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 758daabb76c7..abda475111d1 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -65,10 +65,6 @@ struct dw_xpcs {
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
-		  phy_interface_t interface, int speed, int duplex);
-int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
-		   const unsigned long *advertising, unsigned int neg_mode);
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
-- 
2.30.2


