Return-Path: <netdev+bounces-170322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24771A48276
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82026188DC82
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE625FA30;
	Thu, 27 Feb 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a9KJOkrz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53425FA3E
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668441; cv=none; b=neSmR+1rXoEeqExml7eoYIqsdJg5O9FY+qn7K0RpnhQErhLBWUr0ebwwIsXzJhJBQv9t2h8n36PfG4Ao2GHS9snwQxgvFgyBs/TJyMXhIQl9GrA2LPkEnht/y+cx3+Zrimq4aYwBvVCKD2RLKHCi390PApAq+vTwJLezhcnzuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668441; c=relaxed/simple;
	bh=cTpHgkMQ3O3YpOCxc+EcJff6/0s8KZuLsU5SVJPhrpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cDHrmOiGKTIkiHku3yIXdEx65dIzaSinaKbB/KJ8HdGzBvCTR3udpeD+z/sqwMK5b+tdOsAU/4uVvZ70M9xNMuo4M9mnMx0mfGQEv5ZHH++tgiU0cMEN+8MB3JeFO9mfq+m/IzfUiI8fksUIYLtc6mi8h/u7C/nc0S2fsyy3OhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a9KJOkrz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PgMRekuM6/wN27KKXDqw9MR6fLL7vwR1VpZwGH+P4Y8=; b=a9KJOkrzhoferwAPNCQyMPdkU2
	qZq3mkWYyvs6Z4TJGj35fJVHCiby0eopRMzZYQ5xd0L6GlUXgF3/QPA/AOsBkurMLKePFqo0iHFLK
	AlGAlRAPdSiZj5m+yHUBbsES7QgzC4r2bJWRb1u3BBTEWgDJmFIaG+xLeVwlj4uq51q+kNwyV7M2M
	hvvLTPAUWPEK9XJIhQ7+N7rxB2Xao20o/RB+zNLhcu6qspur//+lo795Ax+Eml/Iu6IdgnV55xvp5
	qqytsHGLIeT7+mWIjr5Z9FQ7vmG9AR/49sH9HCIfxFKxHUzsMhkIe6f6DRcz/cyq8++/4JGaST5wZ
	xogKCMyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54178)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnfNH-0007Vv-0H;
	Thu, 27 Feb 2025 15:00:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnfNE-0008EE-31;
	Thu, 27 Feb 2025 15:00:28 +0000
Date: Thu, 27 Feb 2025 15:00:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC 0/5] net: stmmac: fix setting RE and TE inappropriately
Message-ID: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
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

Note: this series depends on "net: stmmac: fix resume failures due to
RX clock".

This series addresses inappropriate setting of the receive and transmit
enables in the GMAC control register.

The databook is clear for the receive enable, that this should not be
set until the initialisation of the MAC and DMA has been completed.
The previous RFC patch series ("net: stmmac: fix resume failures due to
RX clock") which moves phylink_resume() solves that, but we are left
with these enables being set when the link is down. This is not correct.

Sadly, when XDP support was added, new calls to netif_carrier_on() and
netif_carrier_off() were added, which are incorrect in drivers that
make use of phylink - by doing so, the driver has no guarantee that
the .mac_link_up() and .mac_link_down() methods will be called in
sequence anymore.

Solving this requires a number of changes. First, fixing XDP to call
into phylink to bring the link down. This removes a source of
phylink method de-sync mentioned above.

Then we remove the racy teardown in the driver's remove method -
nothing should be torn down while userspace still has access to the
netdev.

Then we remove an unnecessary call to disable the enable bits in
the .ndo_stop() method.

Finally, we remove manipulation of the RE and TE bits from the
start_tx(), stop_tx(), start_rx() and stop_rx() methods.

 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  8 --------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 12 ------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 22 ++++++----------------
 3 files changed, 6 insertions(+), 36 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

