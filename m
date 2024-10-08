Return-Path: <netdev+bounces-133160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03C995218
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD01F2600C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BEB1DF998;
	Tue,  8 Oct 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W5LsTAQt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E151DF73C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398514; cv=none; b=osesEx6sbYThSO1CAYJPF8wC3RHaz2YuyIDUnkqlcE3sOD7elPpTJtpRDpH93EqZR6BKzarNfrzygZBwVLAf/NI+REmork1aNP+MS6vDAYMHzwJCFhrtpXOZvw9uB8h2J8d7064jFEtlGeBEVuLCpXGV5G6jQt4GJmqk/PiTYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398514; c=relaxed/simple;
	bh=Vz0gFYM6a9ZLN2umEBCP+vIbgy9k3/ReuAZETMW0/kc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CQlhcvc7KepGuA9P41UiWzpcNC2ZlSR1tIyyosveauF0nHO1ta0fw2zRdJccQSmuCFfuDghfXtjAadWIbmYK61/p0ihfmLguGP+B3YO/rJryhLiRvblEBsslfPiWfQDtwGaA3xJFLegoTWCs46KwE2uRjBntIpWi2INdCDjivY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W5LsTAQt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rd5GuzrzONkq21TVGGwDwpRHf3yYF0nOc1Y+j6ndNLM=; b=W5LsTAQtZxLKCfNwUXSc9rP79j
	ZTtYNgUuabTwBT28V1eHSBfkAjiMWscuCDhmhoU5+cD9MeGXOZc9ETIgIgOc5r/Qb6pr4c0hZ2/8e
	b+y6StWV7aYrxtr0SAcr1hoVPb491zh+QihnXxsd9SItdnBHQ5RLzHbeMwy/bSfBFkXeI2hppnNDn
	vAJFgP98MmaBzZpmkBS5bK3Sp5nRecW3w4LaG9bQa05UbVn35U9YYl6JTc6UDHPMMkjrMK6BedtO0
	1BG8VlLpPqLdEuvK6lN+7YI9t6tRKbL2q0R2/u+vx/Lxy+ctDM3pdEM+yuWb+7ajARc2j2iwch4qG
	n8OGYhwg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57368 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1syBPG-0007cj-1E;
	Tue, 08 Oct 2024 15:41:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1syBPE-006Unh-TL; Tue, 08 Oct 2024 15:41:44 +0100
In-Reply-To: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 08 Oct 2024 15:41:44 +0100

With DSA's implementation of the mac_select_pcs() method removed, we
can now remove the detection of mac_select_pcs() implementation.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4309317de3d1..8f86599d3d78 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -79,7 +79,6 @@ struct phylink {
 	unsigned int pcs_state;
 
 	bool mac_link_dropped;
-	bool using_mac_select_pcs;
 
 	struct sfp_bus *sfp_bus;
 	bool sfp_may_have_phy;
@@ -661,12 +660,12 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 	int ret;
 
 	/* Get the PCS for this interface mode */
-	if (pl->using_mac_select_pcs) {
+	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs))
 			return PTR_ERR(pcs);
 	} else {
-		pcs = pl->pcs;
+		pcs = NULL;
 	}
 
 	if (pcs) {
@@ -1182,7 +1181,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 						state->interface,
 						state->advertising);
 
-	if (pl->using_mac_select_pcs) {
+	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs)) {
 			phylink_err(pl,
@@ -1698,7 +1697,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 			       phy_interface_t iface,
 			       const struct phylink_mac_ops *mac_ops)
 {
-	bool using_mac_select_pcs = false;
 	struct phylink *pl;
 	int ret;
 
@@ -1709,11 +1707,6 @@ struct phylink *phylink_create(struct phylink_config *config,
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
@@ -1732,7 +1725,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	pl->using_mac_select_pcs = using_mac_select_pcs;
 	pl->phy_state.interface = iface;
 	pl->link_interface = iface;
 	if (iface == PHY_INTERFACE_MODE_MOCA)
-- 
2.30.2


