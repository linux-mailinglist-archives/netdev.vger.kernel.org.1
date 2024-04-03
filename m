Return-Path: <netdev+bounces-84518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9949897252
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1821C239CD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C3148844;
	Wed,  3 Apr 2024 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HdyJ3cFa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7731168BD
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153882; cv=none; b=mukWLpnzZLrPPjfzpqyOsaeKj+kGaKh0Faq4BQ/TuZ8e75+WEyjDtbSkAHpf4MKJSbf5fCqt+Z1lC3zbqg0BbATf2FKD/7aTcLQpG95jgF64UqEFwHFepjbCTdQc3s0eCrUsz5fYcdOQTWfuynbqBmwO5nIt0HykTTVxeG23Y/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153882; c=relaxed/simple;
	bh=CFi0jrAWbdV2Wa3/R/kcYTnwI8Vh8pKic0qAaDGwfJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VH6Crrte9Z6PFgeq09lGyNT9BWbxGegpWSu8V3pi9oo2CCn0WeB7NwBu0GlaR+lDHiO/0MOwcafBevGwzWA6v8/16Rqz8E/esamgUlyWPcJvKF4XCUgar2lIUboEyOrUZJOYkJ2mHfcw89Gtq/vBkbo6RUwacEVoaCnglXQK9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HdyJ3cFa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dpEu9cSFkC0FzMmlWCssUiFAamfolZ2iGgjFc5gm4fM=; b=HdyJ3cFaSsMA6aB0LW5VQsMJa/
	esXlqB08jVgC+h+kh+SgaT7dclHv9r4eSojXhCxuC/wAOl2FbRJhiogD6AwFSayOP39htuM+dZu94
	4sM9V+FvGL7Fy2SzBvvIz+8Tu88oxMCBhdYPMa51dHa7rj0ZOqdvzp9NeK4adPUDHL+1ng83/K8uu
	Eh9kbJmvitKUwQG3Xsy5KUqGcZXrL0ANZLfbYlGTgyB2WWYOOVkE2qeEt/+ooqopl4ZQx2wKM/ATe
	PDBWaqYix6pvs3Y8YIvrxHOBLghIdM4umm9ILYnVqp6MRQQUxqAKSHeeiz+hednfl3I58W3G6PGIE
	pcCz24ow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rs1R2-0008V9-33;
	Wed, 03 Apr 2024 15:17:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rs1R2-00080a-Er; Wed, 03 Apr 2024 15:17:52 +0100
Date: Wed, 3 Apr 2024 15:17:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC 0/3] net: dsa: allow phylink_mac_ops in DSA drivers
Message-ID: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
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

 drivers/net/dsa/mv88e6xxx/chip.c | 63 +++++++++++++++++++++++++---------------
 include/net/dsa.h                | 11 +++++++
 net/dsa/port.c                   | 21 +++++++++-----
 3 files changed, 63 insertions(+), 32 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

