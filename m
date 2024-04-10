Return-Path: <netdev+bounces-86722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B88A00C3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B491F22A67
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334218132D;
	Wed, 10 Apr 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nWs2Ixb0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54615DBB7
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778099; cv=none; b=ZlfmU82XAzqPevR/3ePQG43C4ivbFIp+YTQsv/I74n6hBrLlBueVBT6JDO89xmx+k9IF5L1YCLwDVqFyyei+pzlupqG8CWlxrznTb/zr+d4+kjxjOzLlm+w3mw8nBREXRfec4dMvc8wYdSXMveKBa5MTk3lowObZh7nXRHOvBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778099; c=relaxed/simple;
	bh=kTFxltJcBzCj5qxGgHnXykfyIVc/8VTbo1YAEe1IE9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AKvq6bUcMnlZP+Aopz7T3EKBHtsu3GDCUbzVyVBDbzqD1nQGwLsIHo3yb3e77OoOWPBSsl0kRfzAiC8evB8ujNfaxfP0kCWHf/zkn9iFgQq6Z5yc4jwcLpI++x1cvRk/KEj8DjATFmJ2PgZE4qSrq6WmeTYpRoMx8lZ6vNlYRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nWs2Ixb0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DnbgF+1nodPkDdzeA4YLfVJldBd/FAi0om49nshSkzk=; b=nWs2Ixb0hHsJKv2MEfecs7i7XZ
	ngc4av9ER0bcsb2BcTq7g9j177CYQIQDZwnBZGoM0QBn+VdJWX55lK1wNZnrFY8GVovbv+dG1LjgU
	Ucto6WF2DQrpq+43HCaWroMDaVOmwvq6TjcLBvu8B2QcSU93ROPRazOGcIgw8pAVGGQItXVVG5Juo
	2Ux40zJTd3kpHqZBaJtmLo5WB2IAw1nQ6V1GQlpmGQvqn3JWGcT42iCWqBNzCsQbFjedJCWUePc7x
	8RSQzRlBBxJh31SkG8/IvNC0Q4FOfODh+ytoA8aGJxo5B1ptdE5vTZz6+kEtgdSK6mk2dsiULaHhV
	TKXTR36A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36634)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rudp5-0008TF-2h;
	Wed, 10 Apr 2024 20:41:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rudp6-0006Dv-5D; Wed, 10 Apr 2024 20:41:32 +0100
Date: Wed, 10 Apr 2024 20:41:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] net: dsa: allow phylink_mac_ops in DSA
 drivers
Message-ID: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series showcases my idea of moving the phylink_mac_ops into DSA
drivers, using mv88e6xxx as an example. Since I'm only changing one
driver, providing the mac_ops has to be optional and the existing shims
need to be kept for unconverted drivers.

The first patch introduces a new helper that converts from the
phylink_config structure that phylink uses to communicate with MAC
drivers to the dsa_port structure. From this, DSA drivers can get
the dsa_switch structure and thus their implementation specific
data structure, and they can also retrieve the port index.

The second patch adds the support to the core DSA layer to allow
DSA drivers to provide phylink_mac_ops.

The third patch converts mv88e6xxx to use this.

I initially made this change after adding yet more phylink to DSA
driver shims for my work with phylink-based EEE support, and decided
that it was getting silly to keep implementing more and more shims.
There are cases where shims don't work well - we had already tripped
over a case a few years ago when the phylink mac_select_pcs operation
was introduced. Phylink tested for the presence of this in the ops
structure, but with DSA shims, this doesn't necessarily mean that
the sub-driver supports this method. The only way to find that out
is to call the method with dummy values and check the return code.

The same thing was partly true when adding EEE support, and I ended
up with this in phylink to determine whether the MAC supported EEE:

+static bool phylink_mac_supports_eee(struct phylink *pl)
+{
+       return pl->mac_ops->mac_disable_tx_lpi &&
+              pl->mac_ops->mac_enable_tx_lpi &&
+              pl->config->lpi_capabilities;
+}

because merely testing for the presence of the operations is
insufficient when shims are involved - and it wasn't possible to call
these functions in the way that mac_select_pcs could be called.

So, I think it's time to get away from this shimming model and instead
have drivers directly interface to the various subsystems.

This converts mv88e6xxx. I have similar patches for other DSA drivers
that will be sent once this has been reviewed.

RFC->v1: fix up patch 2 to call the mac_link_down() method as pointed out
by Vladimir
v2: add checks for phylink_mac_* and adjust_link methods in dsa_switch_ops
    if phylink_mac_ops is populated. Simplify dsa_shared_port_link_down().

 drivers/net/dsa/mv88e6xxx/chip.c | 63 +++++++++++++++++++++++++---------------
 include/net/dsa.h                | 11 +++++++
 net/dsa/dsa.c                    | 11 +++++++
 net/dsa/port.c                   | 38 ++++++++++++++++--------
 4 files changed, 87 insertions(+), 36 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

