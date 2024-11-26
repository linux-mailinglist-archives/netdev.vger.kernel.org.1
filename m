Return-Path: <netdev+bounces-147360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF49D945A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48F2283153
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0451BC069;
	Tue, 26 Nov 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vw5DRYJ9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F118E057
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613076; cv=none; b=SsG+z8aqmbnLS7Ey5J510fziIGHpShpU6eM/pwpXlTYus+IYFsIWPWFxrtbDXMaOsiWKoZKzxCrCUV8xGtfjmyq8Vv+BXAEJnc2u6LUZpuHGiCsPKp+RAoznaY+80vAvDMMEsal/JcOL8ya8cHxLzPwlVGy/Vq7U0ykkHLPFJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613076; c=relaxed/simple;
	bh=Pfu7vZEj6fSubOfqWR5vDzcGfo6ZOx2dIjRoBvUNlcg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=or5yi6ElSBWfDI/Nh1+s6uRufndJZhOlVQ4aHFcniECF83xhak2EZ7tnHohWRkWnhQNiIdQy8CVYbMPXnaexX1TuroA0scstd7ZcpYdVSvjOF+5Ob6s04SBfnkTL7NAInYhgUEcfHHSzSJBHHgmmTPDv9Ls8lqBX5JMzRxrNkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vw5DRYJ9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PEFP7moTXhDwLu8mliziU9KVQdVyXflN9X2ifDX1sAk=; b=vw5DRYJ9kwjc12cJzmTAXwTz4E
	2QY87lZlQovEZnnVjNEvQ/bxy45yBs3keUZMGvPTuIJlaTe68IzhfLQB3onNojqmNBp1VfK3H171y
	lzfKpZZ6ls4AAjAg44nQ3RI6ZHicU7bUImdWhyRHGE5LjIFR/qANhb0+5UmnJT+RxIQXG9pJbvK8W
	2sXesbbwx9Rbd+xa5c0NLviFjvLi/bde5i3ULA3DCICH/0g5y+0MMof9NdBVaTF0B6btRnwbt3Q08
	S3Q5F3D4iO7QN4FJjU2ubtPtBUhr7ytRfer78F5e3A26cd3cKWhq5CXyRIqP/bfGA3EmFfMzXJIIo
	mQKtWdAA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35820 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFrnx-0006Rq-1v;
	Tue, 26 Nov 2024 09:24:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFrnw-005xPe-KN; Tue, 26 Nov 2024 09:24:20 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 01/16] net: phylink: pass phylink and pcs into
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
Message-Id: <E1tFrnw-005xPe-KN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:20 +0000

Move the call to phylink_pcs_neg_mode() in phylink_major_config() after
we have selected the appropriate PCS to allow the PCS to be passed in.

Add struct phylink and struct phylink_pcs pointers to
phylink_pcs_neg_mode() and pass in the appropriate structures. Set
pl->pcs_neg_mode before returning, and remove the return value.

This will allow the capabilities of the PCS and any PHY to be used when
deciding which pcs_neg_mode should be used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3b5ceca2637c..8a43b81d5846 100644
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


