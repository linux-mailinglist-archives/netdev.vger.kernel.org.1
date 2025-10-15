Return-Path: <netdev+bounces-229668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F3BDF931
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48A6B357227
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA66335BB7;
	Wed, 15 Oct 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JSl3cHHK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894852163B2
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544564; cv=none; b=qqiDA2IjAD7TDqUI/61Qk65s9E4n14lCwHbI1dyo/ipWKQQUk+0aOogDc+tNCuXxd9KBOzXevblGyIMJnzrFZ/XvN7P95zlaRJdBylQR1EBij7fyI0zQpQdK5fnjnC2VQ9IB+T6H2MYQ9FvIYKJdO53VIPTFXPC8YqSmBdIpcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544564; c=relaxed/simple;
	bh=xAj4YtFiMV3R1GnaW/j6ontuCvlWuCaT3JXobU7Ai8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jW4LqGf6p4F8A+guSO0XZDzKpChMUzhalPp56DsRC+HCSg6xsbNjIDNrOB/BZGUQMYtOckexkDHQjtM+Jgtb99w+qzYbwsVL0Ubo/uwyWOIHFk0v2aiNKup4i6uMsfJ7LrW0K8qGLYYP46w1gILIfl1tK8FcwVdoPy+Xxkq4VOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JSl3cHHK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F8AivNmNX6ytHIHlRjMKoCXQh8wrZGlkylky6XBPiQc=; b=JSl3cHHKoZDp+JKzHu7hDUEWlw
	59mlLBmMOXJDVl0p0OuMwUoP6WEKYaTspfWZwwMBcB1GSFJzGee6OMchHlEPUXc+Lkwv9XJfVKUNg
	UGf6+0vAQH0LmaN6JKzr8HupJc5COgTuT1cDtllNsAgs19TaoYZ1SGoZfx18GWaMJGySOgJP0l6iS
	zEVRBEczRTsiwio6cv+4f2ZIO6oFTKf+mWQQQb28D0K7CCA7CD/w2R+hMrUMxEW2L3S6p7iwuabz/
	pgwkwRcKVSp58/aNGiJxOEE05/vwTnZgR2wUivvdpNnLByWxjMWgnksQ654zNpuQYBm+4T0Giptcj
	9BiTBHBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51416)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v943s-0000000059Q-2LIy;
	Wed, 15 Oct 2025 17:09:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v943n-000000002OD-3sXH;
	Wed, 15 Oct 2025 17:09:07 +0100
Date: Wed, 15 Oct 2025 17:09:07 +0100
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
Subject: [PATCH net-next 0/5] net: stmmac: more cleanups
Message-ID: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

The subject for the cover message is wearing thin as I've used it a
number of times, but the scope for cleaning up the driver continues,
and continue it will do, because this is just a small fraction of the
queue.

1. make a better job of one of my previous commits, moving the holding
   of the lock into stmmac_mdio.c

2. move the mac_finish() method to be in-order with the layout of
   struct phylink_mac_ops - this order was chosen because it reflects
   the order that the methods are called, thus making the flow more
   obvious when reading code.

3. continuing on the "removal of stuff that doesn't need to happen",
   patch 3 removes the phylink_speed_(up|down) out of the path that
   is used for MTU changes - we really don't need to fiddle with the
   PHY advertisement when changing the MTU!

4. clean up tc_init()'s initialisation of flow_entries_max - this is
   the sole place that this is written, and we might as well make the
   code more easy to follow.

5. stmmac_phy_setup() really confuses me when I read the code, it's
   not really about PHY setup, but about phylink setup. So, name its
   name reflect its functionality.

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 49 +++++++++++-----------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 14 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  6 +--
 5 files changed, 46 insertions(+), 29 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

