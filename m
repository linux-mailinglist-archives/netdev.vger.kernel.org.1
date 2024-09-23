Return-Path: <netdev+bounces-129306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5797ECAD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5EA1F2220A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C6198A05;
	Mon, 23 Sep 2024 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A4FHBbQh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EE2AEE7
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100066; cv=none; b=J9KlFN87SiYqdA7OS7QDKhDtDxLDjAPV7TMarVkM/vYvV8s9I/qwfW29CJrElDe81Sd6eOb/ldxQkRcYhzEXGEnMAxpxUZXZdDIxYdcQ53y+2UX+5VItExZxza2u/6bLsqHSUCHfUQVWY2q77bKpUxParGDINm0a0b1thrB1c7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100066; c=relaxed/simple;
	bh=hRdH2Ue7sQj2ekCL2EgyUV+w9IVgHS2ISFg0UX3e5yM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DqiM8F9FZQNCr3dzD9nm+gIX5/gqAGGOa2a+sYU8GHwNoOlDWjq7QADnmcQuHl1Jye9UIdVpy565b/dPHbNRFhdyEx69dfHIoYXi/fFWfo6omQzcwqWF/Kn3EA/ZEJEhqlHkFVSj2Edam6vloGB7aBVe+WuDIoxGSgu6N2i0S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A4FHBbQh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rlbTSzoMwe9Gz7cOZS88v/Qn7t4z6TgShE6pjDg4V1k=; b=A4FHBbQhqKW7VgJM5LpclvPSZy
	czYMWcV6w2EfKbTnq1cJ3SacoYM6cOTN2aEkMLpdEyRbTsCuIqw863Vzf0gicAwfpUj4B0EqLUq0T
	vvOiHYC55hjeng9BpqsQxaQwIfDISbIlr/8AvLtdI++cbbnJRKuUKIJRwA+BcSAy17h+PNjgBmMYT
	eR/K2cClBpu70SIz/W4TqJF4T1+g2OjWWCK5PYLc92liq1wRje34i3Wl+k5npj3Y7kp60EH8glv5D
	1HGTO+KELiRTMu/6LYGzy5cIo9GRkqiL4Q1zx46dKiKiZwhU5njSt+Vq6cdWX36CUIR4+jsDthdtl
	nnU+KSqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49610)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ssjcB-0004Gt-19;
	Mon, 23 Sep 2024 15:00:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ssjc2-0005RQ-1V;
	Mon, 23 Sep 2024 15:00:26 +0100
Date: Mon, 23 Sep 2024 15:00:26 +0100
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
Subject: [PATCH RFC 00/10] net: pcs: xpcs: cleanups batch 1
Message-ID: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
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
unnecessary complexity. This patch needs testing on SJA1105, Wangxun
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
 drivers/net/dsa/sja1105/sja1105_main.c            | 83 ++++++++++----------
 drivers/net/dsa/sja1105/sja1105_mdio.c            | 28 ++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  7 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c    | 18 ++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h   |  2 +-
 drivers/net/pcs/pcs-xpcs.c                        | 92 ++++++++++++++---------
 include/linux/pcs/pcs-xpcs.h                      | 14 ++--
 8 files changed, 130 insertions(+), 116 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

