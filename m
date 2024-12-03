Return-Path: <netdev+bounces-148568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2309E2306
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5988E284E1C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B833A1F892F;
	Tue,  3 Dec 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oD9svZ8Q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070031F76B6
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239864; cv=none; b=SPYTpd+0Q6GHb/1kW+2wAxDy/KR11z16yLaZ6MMDycORvx7IBkqPq8IzL4lEvxUdtoID9PCRXhGfVTqQurZb/jSCevhdULEXCI7x8B2iWQKTOf4U01THDZzfGvNJAmCfWbj6M8QSVyLGsRQv+UdeZcMUx9bmA0OoezqNR/hvxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239864; c=relaxed/simple;
	bh=x+AIx4ZZeWbt38uaAwe99Em9roaM5o8fQ31dZTHtiRI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JYAfhp07mQG60ZYA9S2JCQLqvyGYe9btkRBipeY1LWjvoJwQQeStPXkf9ttezl99doqiKQ8e3GRE+esIa7NUo63Umqe6tTk9wbjXEE+gYKyAcmIvRfH+FeYYc9wVrbGkgOlbr89ztgsOPWiWGFwRuDviotHdpJBPPjsKHq45aWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oD9svZ8Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FhUvzxnuVDixMZxhUGaSHtFZIgM9Vh2OnyfCEA61XUg=; b=oD9svZ8QfAaAlSmXthmiXJyE5m
	PEWvUgt6iwdP7baggrp3KQwkUKokezdNLB7T/OuxBEtmGhFZAE4KaNLCnqmuiX7s8ib0dRxWoKDJB
	LxjPjNY5gtkzCvu1a3YgKTQO4B9y/BIBzDGDcSNeDOcBXEopct8iaVdDLTm+R08/tEP94tb6p5Sfm
	wfUMg0nxTrc8a8pHijfixyOlhM9j5dPuquPPuYQVdjVDcZApfM7xOxpEDozZYpTJd1OwW6atXRPsb
	CmIh73RomTD6iTUBqun6OMdRAMcaLCFXP95ENyTra19BwM87pI5ii53tZIeWjfSc1BqAxxU9m8wf6
	ONk55eiA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50438 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUra-00027t-1p;
	Tue, 03 Dec 2024 15:30:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUrZ-006ITt-Fa; Tue, 03 Dec 2024 15:30:57 +0000
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
Subject: [PATCH net-next 03/13] net: phylink: add debug for
 phylink_major_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUrZ-006ITt-Fa@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:30:57 +0000

Now that we have a more complexity in phylink_major_config(), augment
the debugging so we can see what's going on there.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 098021f1ab49..fda53dd58285 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -175,6 +175,24 @@ static const char *phylink_an_mode_str(unsigned int mode)
 	return mode < ARRAY_SIZE(modestr) ? modestr[mode] : "unknown";
 }
 
+static const char *phylink_pcs_mode_str(unsigned int mode)
+{
+	if (!mode)
+		return "none";
+
+	if (mode & PHYLINK_PCS_NEG_OUTBAND)
+		return "outband";
+
+	if (mode & PHYLINK_PCS_NEG_INBAND) {
+		if (mode & PHYLINK_PCS_NEG_ENABLED)
+			return "inband,an-enabled";
+		else
+			return "inband,an-disabled";
+	}
+
+	return "unknown";
+}
+
 static unsigned int phylink_interface_signal_rate(phy_interface_t interface)
 {
 	switch (interface) {
@@ -1164,7 +1182,9 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	unsigned int neg_mode;
 	int err;
 
-	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
+	phylink_dbg(pl, "major config, requested %s/%s\n",
+		    phylink_an_mode_str(pl->req_link_an_mode),
+		    phy_modes(state->interface));
 
 	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
@@ -1180,6 +1200,11 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
 
+	phylink_dbg(pl, "major config, active %s/%s/%s\n",
+		    phylink_an_mode_str(pl->act_link_an_mode),
+		    phylink_pcs_mode_str(pl->pcs_neg_mode),
+		    phy_modes(state->interface));
+
 	phylink_pcs_poll_stop(pl);
 
 	if (pl->mac_ops->mac_prepare) {
-- 
2.30.2


