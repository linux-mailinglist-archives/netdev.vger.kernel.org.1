Return-Path: <netdev+bounces-136125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC4C9A0647
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5787B1F242C8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5BC206963;
	Wed, 16 Oct 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NPltmuQK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92920696F
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072730; cv=none; b=C4dlWlJFL7ZAcEB+9sqB5+BWikPwj0kcRQ1QpFSNxKLMLupJs4/rTTz4JT74glNOdOwA+wpWADtu8Y4BWiWt8xOOGJOPEczUqmmt1oESMFtzQfqHipCJrhYGhQaYbQ2E+f28hzH/XhMTOEQ00rXZSw4huE6Npe49T3zWS9Bqgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072730; c=relaxed/simple;
	bh=2ds4OK9uk/a9yojh+DhQQKhmCecIcIZKEccAR1SNYvs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aFRGdCLBw04CnXIPd14e0Yn9TOY35t53N90A1pkgXwnrY5L6naZ5RxqNYoVNGtjfPN4wn1oJIE6Rf+Q9X7HOKt6lawSky6fGrWq8AL78usecH3m/UA796qZamrP2UjxVjq8FESEEq4RSB8fyF2tM7TRqSGa9/zX+C4Bayds8Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NPltmuQK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bxOdeOMrMudqE5Fuk7n4O6n56Vq4jUeOIhl7EmwtXwo=; b=NPltmuQKQg9frFV0Lb568febCJ
	bem/oe7ek53c6cJTaZbi9kKF4/L/UUKRRD8b7k46FtdXBKQ8/5pwr7PtyWGnEZQF6Gcfomvy+3TEK
	FCBbCp/LHe4+i+0H4+FZYOPL3DZVV/ATMBaps58hDvkf+ouZGlgsOR7c2fE0mCwHHRBQaaG+fZ1sl
	xYahi8K49Ys1h7LUkJPeXfCvbKxg3tT0ZNOoAahrC8dfUkkJTxR5Z6EFiiaL9qLvEnZ7613MVrO/Z
	EES9UrarH7V7WkoiTYHUOHc3Q+IRZVUBRUFf1vQSekZ2MF8zyQl3v6wlppqXQapaCCrk6sEVHdcCf
	wEJclbcA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59096 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t10nk-0004sI-2g;
	Wed, 16 Oct 2024 10:58:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t10nk-000AWo-Sv; Wed, 16 Oct 2024 10:58:44 +0100
In-Reply-To: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 5/5] net: phylink: remove "using_mac_select_pcs"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t10nk-000AWo-Sv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Oct 2024 10:58:44 +0100

With DSA's implementation of the mac_select_pcs() method removed, we
can now remove the detection of mac_select_pcs() implementation.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 94f3c5fd09ed..b5870f8666ac 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -79,7 +79,6 @@ struct phylink {
 	unsigned int pcs_state;
 
 	bool mac_link_dropped;
-	bool using_mac_select_pcs;
 
 	struct sfp_bus *sfp_bus;
 	bool sfp_may_have_phy;
@@ -654,7 +653,7 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	int ret;
 
 	/* Get the PCS for this interface mode */
-	if (pl->using_mac_select_pcs) {
+	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs))
 			return PTR_ERR(pcs);
@@ -1173,7 +1172,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 						state->interface,
 						state->advertising);
 
-	if (pl->using_mac_select_pcs) {
+	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs)) {
 			phylink_err(pl,
@@ -1689,7 +1688,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 			       phy_interface_t iface,
 			       const struct phylink_mac_ops *mac_ops)
 {
-	bool using_mac_select_pcs = false;
 	struct phylink *pl;
 	int ret;
 
@@ -1700,11 +1698,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (mac_ops->mac_select_pcs &&
-	    mac_ops->mac_select_pcs(config, PHY_INTERFACE_MODE_NA) !=
-	      ERR_PTR(-EOPNOTSUPP))
-		using_mac_select_pcs = true;
-
 	pl = kzalloc(sizeof(*pl), GFP_KERNEL);
 	if (!pl)
 		return ERR_PTR(-ENOMEM);
@@ -1723,7 +1716,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	pl->using_mac_select_pcs = using_mac_select_pcs;
 	pl->phy_state.interface = iface;
 	pl->link_interface = iface;
 	if (iface == PHY_INTERFACE_MODE_MOCA)
-- 
2.30.2


