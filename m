Return-Path: <netdev+bounces-133157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D46995215
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422BA1F25FB0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E91DFE0A;
	Tue,  8 Oct 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ba2tlxru"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984251DDA15
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398487; cv=none; b=oGZdfMSGVzidOcw7AwSP+OLJbrLoOLS1yWe/3qjES5S8z6y6vi2s/x9lht1BUpld5E9tJKOggejDvTFLq4eFp9SHKP0q+RFuKU9XBhCs8NP7VPDJ9ssbrIK0y3KTDZsWgLI+OFy3Vayeaxvy1q2NT638237GFgOR25ZIM3Qsbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398487; c=relaxed/simple;
	bh=hn1jdbDzXZtlQf69CfD6v2PUnhSyrTgEx0zTJjfzTao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+q1RneMLgQ1NSQ1DgsaKqh7NImJI5hazpxRyrpv1D1xZzOdnZmr27vcae1hjGJh2siXJK+N2wIESrb1Dbp/MYFF7jxq2fexfw7sPzCNS0QQ+fIiiJqi1Bjx9EjuYfsUTGcP+41CgiLr67yPBpOzQ2/5PwvuGoo3Vz5zICNfuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ba2tlxru; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tMqRVp6JjPhygIe7O+g0ioGZ9JPhFOA6H38lcMmMNrE=; b=Ba2tlxruUDGokFArM2ETRHzzsN
	4xvSc5gfiRq64OZPyERY0Hh3f36SL8bxaurQqrCOVh9QfbrasIguz3w/nZwVTGAcH3U1CkWLOQoTW
	JExPvnFIfqIVO+406ltdN7qFk+AGbW0Up6Ee8JOfG7nPxNnf5ZCgnYVC7JfBPbRY1xc6gu59mfzVE
	ZrSM429WkjbZwpvFlTHjR10+vteBB1d67/FeIjMJbaCppimBHv/hYNQtJV3aelHdBpk++MlPTFAMZ
	a7xkOEBUU3y0skKqnKTHkVzVvXV99RvslSlQvnLdwvvP+7Np5J8ApiPUm9cBoEpTgfAwFom8RmnZY
	igxLfsjg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50028)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syBOp-0007c7-37;
	Tue, 08 Oct 2024 15:41:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syBOn-0005HI-0P;
	Tue, 08 Oct 2024 15:41:17 +0100
Date: Tue, 8 Oct 2024 15:41:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 0/3] Removing more phylink cruft
Message-ID: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
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

We then make mv88e6xxx_mac_select_pcs() return NULL, as we don't
want to invoke this old behaviour anymore - mv88e6xxx doesn't require
it.

This then clears the way to removing using_mac_select_pcs from phylink
and the check.

 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/phy/phylink.c        | 14 +++-----------
 net/dsa/port.c                   |  8 --------
 3 files changed, 4 insertions(+), 20 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

