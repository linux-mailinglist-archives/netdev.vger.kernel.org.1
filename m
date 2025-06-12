Return-Path: <netdev+bounces-197048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF1DAD76E4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766C93BD097
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B91299A9C;
	Thu, 12 Jun 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0pgm9N7k"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6129994C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742869; cv=none; b=DpJDXIv+KZJKZxqVxFxMVUjVvM9IbGL/pia2tY3rvTNm8O8aH/04Ci1lORxQcSrSn0MyPt0BVXOUDjAlDJsQX8OvLb9ZKo/sfmPtimS9GQPFh9nhK+3m8FRne2dFpbfxB2zsdVXQx/0SIAX4xBIaQKPmD/jKNAC/Z7EdXhjaeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742869; c=relaxed/simple;
	bh=ZPcDShdjx+nCTSQod47ShrHk7gOnPleGBIFHcgcuXnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QB5TYv5YwKsqMSV+dS409QHWMTcprMJtt84UR0T+AXFO64/Xs7p+YkTz15DtD3CX5SCIiardHne9zF95nC4mP/TOaaAcs4z57PB45nZG1fxya9/KzHmHyPWFCfE/3mXVFVZYbY8ZjDwFf4+ei4OnLsqEApeOZVqXd1iuCW/ogvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0pgm9N7k; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ovLz1bXOwuyb8LOC7DzxQcjGmyjM0gF1HJUD1277E/E=; b=0pgm9N7kHgk7OBk8ajf/hV/MYm
	81fRtd8g0erMhPmAyoRZ47m9U30VPZRp8hqFxlGArohluP0+CO1LPc9Z4q96EYTrl0mLDe3MDfd0s
	DFXFCzS3G7AQforiMBlF+hf0Xlz/tSvVz5FhvcmMGUQHhN98GoCNp80biRzuMOSYUwWaR1Lpi4vBt
	hPUdhaP880Rz+Ny0Z2MT7+1cOtU0Jabkf6xS9up3vYdtADVHdHxa2eXdGrJ/FA+wWAjX7MEjfyJAq
	1M9c4np7ZJwpZZcArG7uUWDRxAtX0jgLanBpa5s80EW2Sdq88Hz6kV6qwTMNQp0Jx0okFUTCBpAAw
	O9pr/ypg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uPk31-000837-1j;
	Thu, 12 Jun 2025 16:40:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uPk2w-0000uM-0f;
	Thu, 12 Jun 2025 16:40:54 +0100
Date: Thu, 12 Jun 2025 16:40:54 +0100
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
Subject: [PATCH net-next 0/9] net: stmmac: rk: much needed cleanups
Message-ID: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
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

This series starts attacking the reams of fairly identical duplicated
code in dwmac-rk. Every new SoC that comes along seems to need more
code added to this file because e.g. the way the clock is controlled
is different in every SoC.

The first thing to realise is that the driver only supports RMII and
RGMII interface modes. So, the first patch adds a .get_interfaces()
implementation which reports this for phylink's usage, thus ensuring
that we error out during initialisation should something that isn't
supported be specified. Note that there is one case where there are
a pair of interfaces, one supports only RMII the other supports RMII
and RGMII, but we report both anyway - something that the existing
driver allows. A future patch may attempt to fix this.

Rather than writing code, let's realise that there are two major
implementations here:

1. a struct clk that needs to be set.
2. writing a register with settings for RGMII and RMII speeds.

Provide implementations for these, Also realise that as a result
of doing this, we can kill off the .set_rgmii_speed() and
.set_rmii_speed() methods by combining them together - indeed,
this is what later SoCs already do by pointing both these methods
at the same function.

Overall, this patch series shrinks the file LOC by almost 8.7%
by removing 175 lines from over 2000 lines.

Apart from the error reporting changing and restricting interface
modes to those that the driver supports, no functional change is
anticipated with this patch. However, I have no hardware to test
this.

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 689 +++++++++----------------
 1 file changed, 257 insertions(+), 432 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

