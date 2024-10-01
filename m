Return-Path: <netdev+bounces-130939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91098C21D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F11C21D86
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0F1C242E;
	Tue,  1 Oct 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sCPAyHol"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD447A48
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798603; cv=none; b=hqYKgWRXCrccb+bR11M74bJVY46NkptqergmBaBAG4ihthpoEHSI5RbcJMv3YulTecsdKwnokG8yb+qy5Fr8mf+WJZTWarLnS5RkW/J+o012dS2b17+NEDacyB7zKjEvmBLanpruFXgqtZuV5hh1LrDzqSU7fR/8mPUxOePKH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798603; c=relaxed/simple;
	bh=q1cSO9Bu7RSL+bwzKreXtSWMuMYntCZdOlKdrEMQhUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XJNsn6QS1npjKfJqrYuyc4Cw65MlEAiguwbnCgHNw1BEZL8OfbsXHZJP9mygE5XSSRjGFJgHGlW9XBIzDogHcvnK/4ITSnXQ4/Dn2uTcTIybx+TbsGlgPLoneAH4YpfrPT/JIt0lulDBBoO4Kzj9LCYOwzkwSva3wn/HRyPVaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sCPAyHol; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lxU6m74sMOqbJJJW/j/WEzyJZ3dIO/M0FxXkS3nCyJE=; b=sCPAyHolJvckbrBVmAXO4SD+Lf
	eP0MHUaLrmdqWKLeEym2qnB98HODvToSjQ4238haMfQQckJwqxkiVAQTe7L6DJMIHBoEdw4+QJpii
	jySTnRHbqVq4b9ghCQXcXz2iICX+SdSNCf/4p5HndbnLTW++V4bDyBxA7+UhWuI6ujO2JJ0VvM5bN
	PpsorjefsCHyjYVh4y8RigywgdTUhfVmY8olw/69InE9jU4TpSMqWZABzXRGVa4ugYixjtmD4Knol
	xy/5V+tcSOdQrI59G4gSttJKxTzQrrXCcWE+v52SaRpp2pbfDbEBTg6G+ZEWD91umXgbXr7kwKndX
	aDWEFS0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1svfKy-00064b-0I;
	Tue, 01 Oct 2024 17:02:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1svfKq-000540-29;
	Tue, 01 Oct 2024 17:02:48 +0100
Date: Tue, 1 Oct 2024 17:02:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 00/10] net: pcs: xpcs: cleanups batch 1
Message-ID: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
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

First, sorry for the bland series subject - this is the first in a
number of cleanup series to the XPCS driver. This series has some
functional changes beyond merely cleanups, notably the first patch.

This series starts off with a patch that moves the PCS reset from
the xpcs_create*() family of calls to when phylink first configures
the PHY. The motivation for this change is to get rid of the
interface argument to the xpcs_create*() functions, which I see as
unnecessary complexity. This patch should be tested on Wangxun
and STMMAC drivers.

Patch 2 removes the now unnecessary interface argument from the
internal xpcs_create() and xpcs_init_iface() functions. With this,
xpcs_init_iface() becomes a misnamed function, but patch 3 removes
this function, moving its now meager contents to xpcs_create().

Patch 4 adds xpcs_destroy_pcs() and xpcs_create_pcs_mdiodev()
functions which return and take a phylink_pcs, allowing SJA1105
and Wangxun drivers to be converted to using the phylink_pcs
structure internally.

Patches 5 through 8 convert both these drivers to that end.

Patch 9 drops the interface argument from the remaining xpcs_create*()
functions, addressing the only remaining caller of these functions,
that being the STMMAC driver.

As patch 7 removed the direct calls to the XPCS config/link-up
functions, the last patch makes these functions static.

 drivers/net/dsa/sja1105/sja1105.h                 |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c            | 85 ++++++++++----------
 drivers/net/dsa/sja1105/sja1105_mdio.c            | 28 ++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  7 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c    | 18 ++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h   |  2 +-
 drivers/net/pcs/pcs-xpcs.c                        | 92 ++++++++++++++---------
 include/linux/pcs/pcs-xpcs.h                      | 14 ++--
 8 files changed, 132 insertions(+), 116 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

