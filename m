Return-Path: <netdev+bounces-219916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39770B43B1D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D117E199
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219DB2C15B0;
	Thu,  4 Sep 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BEEpseDo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65782899
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987855; cv=none; b=lzrZ5DhzjroyjHDfmH6Uiye9l1lfI3sZQNxur5LDJV04UKeTQK+f59cKRAK8HuJodutSsDMGfmw7wRilaaE0fzd2T5PriJyR68+EQfOT2teTFWBaFqivYWqbIA4rukjTWBOAe6d/oxAeN93F+4djJUekkti0b5I1uqrMRZDP3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987855; c=relaxed/simple;
	bh=Y+ysbUiiamzaNFCUhIxI+5d9NB71EpLlImbUUaPXrHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qr1UuaQ+7DKLv2/RQLAxvTbg/dNcmGP7UeK3B18DIcuA2uY3KH6Tf3B2e26VpcdZ62sUm+TVa59EFCie7uCUIyQYHJKUv7Sis7wcqjdF0xuHYzo1zqZKty323zl9lJeuZ1jVc3IuUrN15aPkBjVlOd/nXP3DvpTNmIpUNsRRKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BEEpseDo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UM6zfWF0u7L0EiLPumM84yVNekT/Opoto010oDSlxHI=; b=BEEpseDoJgLW2hnUegX3r6yEdH
	ZRVvraXzhuUctfQq/biYhwN6IylSBPtjVyvBmOTXjeS1/YErNlCnUbwSUt5ea82c27TbSdJobr6DC
	GqigxS9/iVotnSKp4uF6HTvByseg59YrKUdAsge9aFHWXQXm/XtyKqpWP0A6/hVEOWnvE+qKE7Q0p
	hAKEFQ8aQLTiRYqtr6q8Kt60UWzuxB5CJe9o1bzySFa+XtDTYeBixCuzEDq4hYdHGyKoTKcG8T+Ls
	08H93sWt8n2my4avYRbCzjfg1aHK6HQuRfrj4NXe6BZHzpR96hvl/xwV5kW/8CeYF1S2SCFN6O46W
	NFUItaPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48470)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu8nd-000000001wn-0R8C;
	Thu, 04 Sep 2025 13:10:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu8na-000000001WV-1IVn;
	Thu, 04 Sep 2025 13:10:42 +0100
Date: Thu, 4 Sep 2025 13:10:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 00/11] net: stmmac: mdio cleanups
Message-ID: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 03, 2025 at 01:38:57PM +0100, Russell King (Oracle) wrote:
Hi,

Clean up the stmmac MDIO code:
- provide an address register formatter to avoid repeated code
- provide a common function to wait for the busy bit to clear
- pre-compute the CR field (mdio clock divider)
- move address formatter into read/write functions
- combine the read/write functions into a common accessor function
- move runtime PM handling into common accessor function
- rename register constants to better reflect manufacturer names
- move stmmac_clk_csr_set() into stmmac_mdio
- make stmmac_clk_csr_set() return the CR field value and remove
  priv->clk_csr
- clean up if() range tests in stmmac_clk_csr_set()
- use STMMAC_CSR_xxx definitions in initialisers

Untested on hardware; would be grateful for any testing people can do.

v2: add "Return:" to patch 1 and 9

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   5 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  82 -----
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 345 ++++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   5 +-
 6 files changed, 207 insertions(+), 235 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

