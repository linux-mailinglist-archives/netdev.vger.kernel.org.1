Return-Path: <netdev+bounces-102298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E3902438
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB3FB2435C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D2212F5BE;
	Mon, 10 Jun 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U6GF4YgN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930A80BE5
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030442; cv=none; b=Qq9yNSla+6ZMT3V7GtqWRYehu4X+Yv1xT9ghitnebKkQDU4eUh4rOqUXM24l5mpNnD1AHRFpgGsSasQtsqDWAdwbOxDncVq0oQ8LRjBPVmfkwzU2GvlZk+EFl/R/0aSYahVKCZpt5hdM2czXz6gHsfZnWLIOcL0UqMt2QxR25fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030442; c=relaxed/simple;
	bh=CG3E/lWa2HbQ5Ft+v2UKDjTAYRT4JPotru51yN4MBVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lKKzJxmCaaYpYjUHZ8hy2JaBPF56rIUujkJWE8wIN9o8Qm7Z4/zYxC7FHZdj1XzR+L56HBfDY3cuP34OjC06X9VDrOarN0MvhzUseNIpIngQTuupQSti2tjoEFL8unhGmKA7fYNlcIPZHRSNTWNv4aLX30fpZeqikZjSrhoEYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U6GF4YgN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CAzlZ/VNndl4AKegQFi0JffzH+O3JQElVuoC5uZz9qc=; b=U6GF4YgN3Vi6k0LXMKBgQ2XAfR
	20erK5ZVMUuBt9yBkPFzPKw1Sw82O5TxYQE2i15OZDIKrsLDBiw5/WAKehddfV/PhIIFpjn254xtN
	ShpD12vsLP0yH9lx1xWgOdaK50M8k4APqbvxnyiDIbRh1L3lMbUIhzy0HzT1JdE01cnVdFZ/XT61u
	69kttqT/fAWqj9YKWHSV6OzzJCl5h1N401eVE4ki0ENPquT6Mj57WmzeQbYegzqt0XHDju8fCAUmz
	ectnd1NRBwT00YCqq2J1U3Rb/EFmcqwv7dmYgrsMQZrsnxp2qP5hV+UJg3PExC+LRqBm+7ralTQh4
	IjCW/hRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39964)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGgC0-0001eS-1p;
	Mon, 10 Jun 2024 15:40:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGgBy-0006xF-Fk; Mon, 10 Jun 2024 15:40:14 +0100
Date: Mon, 10 Jun 2024 15:40:14 +0100
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
Subject: [PATCH net-next 0/5] net: stmmac: provide platform select_pcs method
Message-ID: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
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

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c   | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c    |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 +++++++---
 include/linux/stmmac.h                              |  4 +++-
 5 files changed, 35 insertions(+), 4 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

