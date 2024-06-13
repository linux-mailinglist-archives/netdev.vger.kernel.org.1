Return-Path: <netdev+bounces-103162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCEF906A1C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD56286A49
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A31428EE;
	Thu, 13 Jun 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tlmMnd2m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C41428E4
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274941; cv=none; b=I5uuyerKYASWfluSnhXuiOiRcavKn01Nf5zsnUIFbD8q8i7MSr+Rds8jmhGAm+j5nn4HcqZx9OwqXNFmHWdCinHrNoyh2LHhkaqrttj4CxyoiDnos6wAfeqacPwOHz7j1VqqKzkfjseReoWG2JAuLCmhyq/PjdGHN9TYlKsmsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274941; c=relaxed/simple;
	bh=I7aIdB55mdOMSnJcwNBUdglKu9OhkhLcDwWVBg4Bb0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ueXTtZkb6MOgFbkmUXTLLNom9/MGfxy6DIeI6MX3QfTt/DUbl9aJlvoClLfu2CpmksWK4K8tI1mirKjBYSC33Zy0JoAMG7H3ZJQ3yi/GRAelVtCwgGhupAx2m4P/qBWNJZKYuRK0DpBK2W0HoZLZzWoRKtw0iBJo7gXzfctL1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tlmMnd2m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XDX8tJG6OxM+mLvXyG16Cgba3hnOXG1D0oaigEUeTh0=; b=tlmMnd2mkd7oHEs59Rc5WmY+ks
	HdEDuTTPJ/Pe7I+KafJeUJ1uEYlFSIiylhFt6e44nG6uzqFXe9T3orabflTEWwT6o9aYKTfnOPSar
	aCqltvwveJF6CjKVgMTLqHTZ7EgjIuD6Uawu+RrEO6i/SwViUmwj4mG7QoRAAy3U7tRiag4M25Nm0
	KY7X9tBS/1AI/xxIzM1xLIPi9TDfwwZ1qVFZS19Oc6rp1GNy8PIDxZ3HVnhJR474maHVaFkfJLn+f
	KcTbK4cHHFJt3v/V0NUrl3tK6VNcI3rirJJ+fLHzCGjJL4MKGFX6JPWyH18ueW1JWc4dfyghY8kN+
	NAcj1Khg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38912)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHhng-00064v-0I;
	Thu, 13 Jun 2024 11:35:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHhnh-00019D-NY; Thu, 13 Jun 2024 11:35:25 +0100
Date: Thu, 13 Jun 2024 11:35:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v2 0/5] net: stmmac: provide platform select_pcs
 method
Message-ID: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
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

This series adds a select_pcs() method to the stmmac platform data to
allow platforms that need to provide their own PCSes to do so, moving
the decision making into platform code.

This avoids questions such as "what should the priority of XPCS vs
some other platform PCS be?" and when we provide a PCS for the
internal PCS, how that interacts with both the XPCS and platform
provided PCS.

Note that if a platform implements the select_pcs() method, then the
return values are:
- a phylink_pcs pointer - the PCS to be used.
- NULL - no phylink_pcs to be used.
Otherwise (if not implemented or returns an error-pointer), then
allow the the stmmac internal PCS to be used if appropriate (once
that patch set is merged.)

Patch 1 introduces the new method.
Patch 2 converts Intel mGBE to use this to provide the XPCS and
 removes the XPCS decision making from core code.
Patch 3 provides an implementation for rzn1 to return its PCS.
Patch 4 does the same for socfpga.
Patch 5 removes the core code returning priv->hw->phylink_pcs.

No functional change is anticipated. Once this has been merged, it
will be expected that platforms should populate all three PCS
methods or none of the PCS methods.

v1->v2:
- Fix build error in patch 2.
- Add attributations from Romain Gantois.

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c   | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c    |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 +++++++---
 include/linux/stmmac.h                              |  4 +++-
 5 files changed, 35 insertions(+), 4 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

