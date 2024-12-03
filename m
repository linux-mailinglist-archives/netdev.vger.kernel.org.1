Return-Path: <netdev+bounces-148566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D79E22FE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E7A285DF1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3691F7071;
	Tue,  3 Dec 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iSE/1sY+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FC1F76AF
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239854; cv=none; b=G3LPGd4wFQQrQhko8wfVz3yETxtI0xLJREK2cXp5r/DiNhjmzJONtX7WJFR+qh4UByoJSBcOniUwwhvMomlSG/RiEgiyx0JZ2A64DU2gRg160k8wSKZUReQA+YtZV0SDWtpREpu2Af5XYfGNuCBIOF5NaAgffmXHZbmNQWEVAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239854; c=relaxed/simple;
	bh=vCw3T5eo006PiTJtR6FlGhDML/s5bahY09jcxKbchXc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JdJ0Ssb6I60XOG02/HJSn6DpGkQdmlvkhvG6iF/DNsJLSia7WaJlVY5vl5QIibPoiTPw4WqKRO4qDYSCEO0RD2qWQV+0apcXe7905NdXMxOE1yQJ8eqqyuOkLNCmvM/V151/mP6uE5E1xL4F2KktfjPp/kYGNsx4C4fJ9W+q0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iSE/1sY+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cz4C+l8vmqUL+Hojmz5qNJTaZojjKeC+BKXJHOMAPRY=; b=iSE/1sY+DJj5BJ5E2o4q5zwYym
	JX7bv6VWa1UMPaAwv6W+UoOg7crk1nTlLTWR0HMssS6HIJpfyl2RhLW8y+rrAJ5EGZRahue8i408T
	B8CqDHqKohWcqLqu/k6FSHtRu9jSWkY1ihvQCjVA716aL/e1BgcuaILNWFU41K0ZBeqUabL/9OYx/
	GaIuqVlwuQyI2Heqbkhz3HRsGVsiG8QsfpM/Yyx6IsqSLmd2swUHFMarSz3FN2uPQnvTDoZUM8Shy
	L/N2e72+J/gDKBZxBh9zykn8UbWPz4yalMfiZFWLOYQ0ED9kELHpiMmm45IQX7fbd1OeFynFwh843
	tznagVzg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37770 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUrQ-00027X-0q;
	Tue, 03 Dec 2024 15:30:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUrP-006ITh-6u; Tue, 03 Dec 2024 15:30:47 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 01/13] net: phylink: pass phylink and pcs into
 phylink_pcs_neg_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUrP-006ITh-6u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:30:47 +0000

Move the call to phylink_pcs_neg_mode() in phylink_major_config() after
we have selected the appropriate PCS to allow the PCS to be passed in.

Add struct phylink and struct phylink_pcs pointers to
phylink_pcs_neg_mode() and pass in the appropriate structures. Set
pl->pcs_neg_mode before returning, and remove the return value.

This will allow the capabilities of the PCS and any PHY to be used when
deciding which pcs_neg_mode should be used.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 30a654e98352..daee679f33b3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1085,7 +1085,8 @@ static void phylink_pcs_an_restart(struct phylink *pl)
 
 /**
  * phylink_pcs_neg_mode() - helper to determine PCS inband mode
- * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ * @pcs: a pointer to &struct phylink_pcs
  * @interface: interface mode to be used
  * @advertising: adertisement ethtool link mode mask
  *
@@ -1102,11 +1103,13 @@ static void phylink_pcs_an_restart(struct phylink *pl)
  * Note: this is for cases where the PCS itself is involved in negotiation
  * (e.g. Clause 37, SGMII and similar) not Clause 73.
  */
-static unsigned int phylink_pcs_neg_mode(unsigned int mode,
-					 phy_interface_t interface,
-					 const unsigned long *advertising)
+static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
+				 phy_interface_t interface,
+				 const unsigned long *advertising)
 {
-	unsigned int neg_mode;
+	unsigned int neg_mode, mode;
+
+	mode = pl->cur_link_an_mode;
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
@@ -1147,7 +1150,7 @@ static unsigned int phylink_pcs_neg_mode(unsigned int mode,
 		break;
 	}
 
-	return neg_mode;
+	pl->pcs_neg_mode = neg_mode;
 }
 
 static void phylink_major_config(struct phylink *pl, bool restart,
@@ -1161,10 +1164,6 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
 
-	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
-						state->interface,
-						state->advertising);
-
 	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs)) {
@@ -1177,6 +1176,8 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		pcs_changed = pl->pcs != pcs;
 	}
 
+	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
+
 	phylink_pcs_poll_stop(pl);
 
 	if (pl->mac_ops->mac_prepare) {
@@ -1267,9 +1268,8 @@ static int phylink_change_inband_advert(struct phylink *pl)
 		    pl->link_config.pause);
 
 	/* Recompute the PCS neg mode */
-	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
-					pl->link_config.interface,
-					pl->link_config.advertising);
+	phylink_pcs_neg_mode(pl, pl->pcs, pl->link_config.interface,
+			     pl->link_config.advertising);
 
 	neg_mode = pl->cur_link_an_mode;
 	if (pl->pcs->neg_mode)
-- 
2.30.2


