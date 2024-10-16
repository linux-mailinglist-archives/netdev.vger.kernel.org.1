Return-Path: <netdev+bounces-136119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A89A063C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191091C226BF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A434206066;
	Wed, 16 Oct 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vQOVjdqj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81321206052
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072664; cv=none; b=iv5MMGV1+frnBBgnLKdIclqdpx6k2u1xo8BdzTzbZFUkfKXwACttLpBTzOl8lan2F+nyiAA8qJ3/5Ri/ifmo88i6YCCfjmMuOhrko/2Vopwmq2ev6rmStZFYVzIUQkn+HYVlBkue74xhaQuPayrHd0lAF5r8hB9uAqGFoA7sj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072664; c=relaxed/simple;
	bh=UM4U/kCd8oZ72j1DyNbAgh50SK9qiqJJp65cJULLWgk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vCdc2GyhtlbXYgpZtjD4OfirqhUc+/QlzXY6Q+Q6ZPK5QAq3jRfdwK5FlDP2zkIzAgK3hh8JagqLvVrZOA4lc2H8qlRdCPls990PhWH3zFs+kkiP3JMz6kVY3Xbp2jJXyAZNjKzO6FFVF7WA32fWafMWMo0fZ0A3Ipi2sZjZTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vQOVjdqj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4lvwQh2exdaoCqYLp7jg/7XYClhN7+M4G6G8llEyXHc=; b=vQOVjdqj3QkUcyz9Ag9c33uNR7
	mxxSPGgKrrh6hlZHHBCTfvJk+6YIQMG4l27BGbv0m9pPwSQ+Nm2A0U9nJGn92JSQNd1I3Vk7qIEPk
	LajqWTOfBxT7GmwD9x4wPmTM2YVL5vUvlgI388u64iap3kRKergwp9EUxdRO516YNRMJgn5CgZozJ
	tWjYvpZlT7THz7HhHwgxV/ut9j6ajPEjWq/Q70FSMM/AY/CJKTI+jMxN69TmTzz1lRETYf6WvZDus
	SMN+hIM0ZdvPv5zdSwxT2ToucIkHemTchuGxYe4kCVt/4ywX8CrF/SielPkY8lteQ25sInzS2USBt
	Ials/+Fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43668)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t10mZ-0004rH-2M;
	Wed, 16 Oct 2024 10:57:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t10mX-0005Ai-0T;
	Wed, 16 Oct 2024 10:57:29 +0100
Date: Wed, 16 Oct 2024 10:57:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 0/5] Removing more phylink cruft
Message-ID: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
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

Continuing on with the cleanups, this patch series removes
dsa_port_phylink_mac_select_pcs() which is no longer required. This
will have no functional effect as phylink does this:

        bool using_mac_select_pcs = false;

        if (mac_ops->mac_select_pcs &&
            mac_ops->mac_select_pcs(config, PHY_INTERFACE_MODE_NA) !=
              ERR_PTR(-EOPNOTSUPP))
                using_mac_select_pcs = true;

and no mac_select_pcs() method is equivalent to a mac_select_pcs()
that returns -EOPNOTSUPP.

We then make mv88e6xxx_mac_select_pcs() return NULL, as we don't want
to invoke this old behaviour anymore - mv88e6xxx doesn't require it.

Then, allow phylink to remove PCS, which has been a long standing
behavioural oddity.

Remove the use of pl->pcs when validating as this will never be
non-NULL unless "using_mac_select_pcs" was set.

This then clears the way to removing using_mac_select_pcs from phylink
and the check.

 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/phy/phylink.c        | 18 +++-----------
 net/dsa/port.c                   |  8 --------
 3 files changed, 5 insertions(+), 23 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

