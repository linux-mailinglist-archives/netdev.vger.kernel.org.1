Return-Path: <netdev+bounces-154975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF9A00882
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEA81884FD2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6B11F9F61;
	Fri,  3 Jan 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kyq2ffio"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1017FE
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903038; cv=none; b=X15YFrxYF+N6wfyRaeKRYx0GzSSY76y/3j1kz6pqgX0L8uY8yInvwWjPRyb0m0pSSoa0VX7AJS/dr3nkbic3w9Vj7+6nQN8n0gdc+b2luv0H+g+eGSy3SNwrIdQS6YBPdw6sTIxRxsHi5+cDaeYtUnEN6Lqsafi/J7HNB2C0f50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903038; c=relaxed/simple;
	bh=mkFlIV2oi3evycH0IuC57I9VpZu+kF/6M/G0ffNiNwA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ij9srzGru6XT7l7HL+yk9aLMlGbvnCSpDKSAsImA9mEYdRDFysg1H1XmabXxQKkjekPEDe7mmvYV36LETOUkoWV+PaTZBvHZb9HJ43SyZL08s1OqPv8WxppuuNrfaimiFGtBE10sL1M9qGcrYMBKREhQTmkOXMVgFYmmd2t+K2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kyq2ffio; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/MH/1XbuHmmzMIpU0/jitxqDYSfeHmJOlhMeOQiQWSQ=; b=kyq2ffionUdzxezwxw1n7SSUNJ
	QOwJve95yZcDFYj/8AbI4Cd7R27VoBHYCihpPknn1P/j1BxO3KEhCfgxJqhvq0TnDSeEOzj3Ps0uh
	zHmXaY0gXRIM9i/eJtzcnExq8UkRkzCESa+xUsBtpWvg7x7gJALYXj1t8eHTgWxUdlMPzinWZeX7G
	cJARELl9wB4lXw1v7OAaH+hyFepu73JhFPIMuxmjWQ39FAw/ZJHwPRBEuZHOvrPH9XijDcPAm+QBz
	sr8R3d8+C0vbT6YLCbMOodxu7X5mr9qbkCvtWOcMjJ4r8iBbqV0myf5LRi4BWRNrGhHc466Pv5EPn
	IAOHlwDA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39002 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tTffn-00031h-2c;
	Fri, 03 Jan 2025 11:16:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tTffk-007Roi-JM; Fri, 03 Jan 2025 11:16:56 +0000
In-Reply-To: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/6] net: pcs: xpcs: make xpcs_get_interfaces()
 static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tTffk-007Roi-JM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 03 Jan 2025 11:16:56 +0000

xpcs_get_interfaces() should no longer be used outside of the XPCS
code, so make it static.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 3 +--
 include/linux/pcs/pcs-xpcs.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index cf41dc5e74e8..c06b66f40022 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -594,14 +594,13 @@ static unsigned int xpcs_inband_caps(struct phylink_pcs *pcs,
 	}
 }
 
-void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
+static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 {
 	const struct dw_xpcs_compat *compat;
 
 	for (compat = xpcs->desc->compat; compat->supported; compat++)
 		__set_bit(compat->interface, interfaces);
 }
-EXPORT_SYMBOL_GPL(xpcs_get_interfaces);
 
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
 {
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index b5b5d17998b8..733f4ddd2ef1 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -50,7 +50,6 @@ struct dw_xpcs;
 
 struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs);
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr);
-- 
2.30.2


