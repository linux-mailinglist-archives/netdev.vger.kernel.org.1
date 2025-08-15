Return-Path: <netdev+bounces-214050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A3DB27F6A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EA55E888C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3D2882AB;
	Fri, 15 Aug 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W68PAZaG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158122882A1
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258058; cv=none; b=ZAsetlV2tj9G9KOBrtbKSNteEwdHr9ypYQ14b0vvgV46Wy+hagBpHoGn6BYLVgJ8tixFOEKFan/x61YYjN0lATd3fTtHIpWbUvpyCfU877WmVtRBd58s06M4ha1edGECM8hC7RlzYBaOH4YR2pvYIYcc3oYQuHag/dxXg8H4AzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258058; c=relaxed/simple;
	bh=cE34NWWXUbEfPcM19T7ipPs9W7IVS3H3fymUalH0zWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QpYSxjINrBmPwxaj90fb7ABf2vZMmRgOAbd6Dr1qJwIdGWjYJZaDOg+VY4SuBBw7iUlKCVzd9YNHExWB6NPqNYCvZ0AZJKAhfhNJ5ttk8D/hNPklMaOQMU02inbpLdCmXOZjCIt4hrUzEqj6XwC+x/CDSQs5PQ4DEwkRvLOfr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W68PAZaG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SDbLIaJdSHw36NzR0ioLCe3S12aekEVvio9d7DRkSBk=; b=W68PAZaGAeBz/3ym5gAoNQAaTM
	sDyK+cs7pavgU7fpCosDe5zqrTuvLJ0OcoMxWpnn1tR5UG2PnEsWYGgTNxX6TiJ91mHwUqSHeb1pm
	eg1Awifi7syTFy9B/Uq5soq5MvrQ5jK5U+CKePQkVOUInRWeU/Lescw7kVNRDirKkcNyol2QhFYUL
	IjaCr7LUavhq49Ek6OHlJZ2fMITYfz+2yT5ROmGlihpmNBR3kd1JaeTe+VJbd4nExmFCWw8BD2Hzh
	OHrjGZw9UygsA4PIGxDhpDHibMu1DCS8+Qk9d9m20yge20B9znD5eym6mxqlnlNTkWJuRnK/fYeIY
	ulDUbeCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51372)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umsfR-00010z-0c;
	Fri, 15 Aug 2025 12:32:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umsfM-0007mf-2I;
	Fri, 15 Aug 2025 12:32:12 +0100
Date: Fri, 15 Aug 2025 12:32:12 +0100
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
Subject: [PATCH net-next 0/7] net: stmmac: EEE and WoL cleanups
Message-ID: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
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

This series contains a series of cleanup patches for the EEE and WoL
code in stmmac, prompted by issues raised during the last three weeks.

Andrew's r-b's added from the RFC posting.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 11 +++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 31 +---------------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 21 ++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  4 +--
 5 files changed, 25 insertions(+), 43 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

