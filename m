Return-Path: <netdev+bounces-161378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09BA20D92
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182E3188A3F7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BED1D6187;
	Tue, 28 Jan 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sQL2X3J9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B51D61A4
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079314; cv=none; b=HmCXoj7jLIHQhlpQn/+wMQYPELkeEamzUpMRZvqYkratSjzSiRHkut9xN2yvx+IHjHhmbgWYPT8WC5L83iudlisXphEXYmlbaIX9VQTa3bHNjxGstbZNcezenNRcZKw0F+fDmPEozupQsG1/Zs00wq/4rTGLT2Y/XZKL/6jz/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079314; c=relaxed/simple;
	bh=3lEjclNIQAarZZzElBDdf9g3ebKiSzxLxIypX+Un3Ng=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MfPbLYqOPNVLyQnuyfS1ZO1g3D2hY+OCe8cg1RQKO/6yFlR+pCRBqhq7tLMBQvsn0c/hRTb3g6HBDC41t5vhotmKcTFWsTnOK8rNoWnOc5GIi6oYbFdnUWbU2Vs6X4pXxa5U8oKfFOgPesn/wjcY3RlpiBZ/z5lWKoJ3Q4UuB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sQL2X3J9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CSrV54CZkdKosAaMmEy/XHbQ07NRRzWFba+cISFZsFY=; b=sQL2X3J9A+Dxb9UAwmqesJ2Wr1
	YjcLEMsf59y60fdMHdoNTi6mtYzZqVNjjLKxxk086u1VtYEGtL8ltTZMypyd70hQt/W1m6LZR4st9
	yf0zpZs/b8ZBZ0+NqDT78/L6au0OyMecHvaEjafeoVnlYQQ/mHLNIH/0b3ewR+ovOqtPahp7ly7kD
	y+YnZm0asTsdFqZcN0y05zElSblq/1lJk3Cqf6DF9BL3qfqzR/Ku2BA/UW3XEceubuKzmslu+pxM2
	zai3JEigmtoDN2WdnniOUs/YK0hpZOpto8VH8/MdD3TqPtvQcY3wi48qvvH8AdZeTioUCR5+tEFbg
	FuV4TEGg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43236 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpC-0007X0-0G;
	Tue, 28 Jan 2025 15:48:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnos-0037Hc-PG; Tue, 28 Jan 2025 15:48:06 +0000
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
Subject: [PATCH RFC net-next 16/22] net: xpcs: add function to configure EEE
 clock multiplying factor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnos-0037Hc-PG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:06 +0000

Add a function to separate out the EEE clock multiplying factor. This
will be called by the stmmac driver to configure this value.

It would have been better had the driver used the CLK API to retrieve
this clock, get its rate and calculate the appropriate multiplier, but
that door has closed.

Question: Is there any other solution to this so we can avoid keeping
this XPCS-specific function that MAC drivers have to know about if
they are going to use EEE with XPCS?

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 14 ++++++++++++++
 drivers/net/pcs/pcs-xpcs.h   |  1 +
 include/linux/pcs/pcs-xpcs.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 1faa37f0e7b9..91ce4b13df32 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1193,6 +1193,20 @@ static void xpcs_an_restart(struct phylink_pcs *pcs)
 		    BMCR_ANRESTART);
 }
 
+/**
+ * xpcs_config_eee_mult_fact() - set the EEE clock multiplying factor
+ * @xpcs: pointer to a &struct dw_xpcs instance
+ * @mult_fact: the multiplying factor
+ *
+ * Configure the EEE clock multiplying factor. This value should be such that
+ * clk_eee_time_period * (mult_fact + 1) is within the range 80 to 120ns.
+ */
+void xpcs_config_eee_mult_fact(struct dw_xpcs *xpcs, u8 mult_fact)
+{
+	xpcs->eee_mult_fact = mult_fact;
+}
+EXPORT_SYMBOL_GPL(xpcs_config_eee_mult_fact);
+
 static int xpcs_read_ids(struct dw_xpcs *xpcs)
 {
 	int ret;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index adc5a0b3c883..39d3f517b557 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -122,6 +122,7 @@ struct dw_xpcs {
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	bool need_reset;
+	u8 eee_mult_fact;
 };
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 733f4ddd2ef1..749d40a9a086 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -52,6 +52,7 @@ struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs);
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
+void xpcs_config_eee_mult_fact(struct dw_xpcs *xpcs, u8 mult_fact);
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr);
 struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy(struct dw_xpcs *xpcs);
-- 
2.30.2


