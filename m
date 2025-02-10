Return-Path: <netdev+bounces-164668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DBA2EA2D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B814188C235
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4E1E3DF2;
	Mon, 10 Feb 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rWdK/lS7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91C1DFE18
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184873; cv=none; b=ZIzb0T1hR7r3EVY/LC+H3AElyH4dRbukDBHyWmuP/NrEYCdCbQ5WPt04UkKQNBU+t1Ntks5lBF2hVGcoy5LQaUM/x7iEPlqeWMYqGDpg920nZuHI2sJXwZHdCZ9CMxOFI5VuRbL9kkoxNMN3xja4xOVL6Ns+shnUnt6Op0V2pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184873; c=relaxed/simple;
	bh=1BHe094AG80R20DlfxTgsAkD26DnDmTqKqyftUdquZY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lq8/4a9urPx+pmu1VNoBU/oezP16ZTz/VQY5Cc0ptiBG4LQ7i8h2mT8mZYrLoAkhdQZdgNeUUcO4IViGFhvViTDTPq0upnik2ggdF/xXNZrKyWdK9POm60IO+SFvc+19d0uxCLdGgk63Evx5ifFJvQ2wtlMWe3DtdvbM8L7l/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rWdK/lS7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6rfnXHnjbMDiB1789GYEEadHIP4lGhQCiXiqIwLjLMI=; b=rWdK/lS7AVCPrMFjgiWGWpmLq9
	HO7u3jx9D7Ucee/3UFZDywpNb+HquCfNRFXfPU2MpL2l8Jeqv3SY399efN5K7/rtgjFdytLGkW8Rg
	ppfNcjxzPup11DSdviXH/b/03Av/ftjgxxL9AJJRzXqXfs1nTII9GHa0+tRUb/yg/dG8nlaxPzgzb
	FFIFFrNuiJrqJmfwWNAKeHZclK3vqTr/I+qk2tVpKeUKYtofaH/p15bXqyRigpKTef+jRxFAzxzHU
	U+Y1XWcCQ4PvOyChqdQCq0u/P53g1QNAwVYdC5pwb7A+2ONeDv3kWPfdHf1bjUve0h72UYZjNqsiu
	3Ai4mYEg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52128 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRQm-0006WZ-3A;
	Mon, 10 Feb 2025 10:54:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thRQT-003w7O-Ec; Mon, 10 Feb 2025 10:54:05 +0000
In-Reply-To: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
References: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 6/8] net: xpcs: remove xpcs_config_eee() from global
 scope
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thRQT-003w7O-Ec@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:54:05 +0000

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


