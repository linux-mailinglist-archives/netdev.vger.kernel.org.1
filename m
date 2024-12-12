Return-Path: <netdev+bounces-151401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BE9EE93F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86AD160FBF
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C762147E5;
	Thu, 12 Dec 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZQWhfJRJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CD2135C7
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014786; cv=none; b=SxdMS36bfkG4aMfafUfYgL9Bb4YXZUIjWBNJDZe5MwwPaQlA5J1eBkp7iSO+jdZnJ2QQ9KFFhc7EpTxZFjqjybRw46fVkvl3Io4vtMjsABZSvizYDEIOCqXoeFh3vBnvy/xjjHjYHchhjLt56qKnUVX0ACyAV7HSX2jowzBAr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014786; c=relaxed/simple;
	bh=x/PbJKOVZEe7ivL0a/qiPt9cC0j7WaoNamdTjzv11ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rJ9wAgmum9QbCST1YQzVY4JnitROAtxEBCROCy9hbLCHm88KD9C8EEd4GROX7j4L8hNVb9xEEoqrHMWvicS2WbbrgMMKp98jr8D7A3krxJY9zT5TysiP8L1ceNZeY6NG+EyUn223cPxcceiMRjsZfYXap5d5EbNkMcgCHDEMHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZQWhfJRJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZkrXX153lKu3k/l3jT/iu1cloY9TaUjnBUlB62dxb9w=; b=ZQWhfJRJtI5LqxCpw7MJ14SgcT
	vXk32dFCdmOPf+ZiAv1JAf0ZBJbhLG6BodeEN6UHNB5uBqDSjcZQdel0JS0QwAVCE1FaNIMEd8qvb
	KfpwjB7bwyrnKOm+DEY2f8xhcCaf2Qa4aEbj8MGY0WPYf7nqf3KwQ4cQqBIMXin0sAquDVB4tWmRD
	YBIO4h3SjY3LA5ft1qPdX9UqnlltVOZ73wqQIYg6UfdqzKVdQn/fXgHafIYqwk5J2hPgfJ+Y0BGQ8
	fSWJhhBWO4WqjnfWArVzmwB04MtzVvs25hjlIYAxHGlmKNq75f8w0FoVDmz0hPNl1q8l8PEeHZj7a
	tYIfrYsg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44810)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLkSD-0005KA-0D;
	Thu, 12 Dec 2024 14:46:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLkS9-0005PQ-1i;
	Thu, 12 Dec 2024 14:46:09 +0000
Date: Thu, 12 Dec 2024 14:46:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/7] net: stmmac: clean up and fix EEE implementation
Message-ID: <Z1r3MWZOt36SgGxf@shell.armlinux.org.uk>
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

This is a rework of stmmac's EEE support in light of the addition of EEE
management to phylib.

Patch 1 adds configuration of the receive clock phy_eee_rx_clock_stop()
(which was part of another series.)

Patch 2 moves the tracking of tx_lpi_timer to phylib.

Patch 3 makes stmmac EEE state depend on phylib's enable_tx_lpi flag.

Patch 4 removes redundant code from the ethtool EEE operations.

Patch 5 removes the driver private tx_lpi_enabled, which will now be
managed by phylib.

Patch 6 removes the dependence of EEE error statistics on the EEE
enable state, instead depending on whether EEE is supported by the
hardware.

Patch 7 removes phy_init_eee(), instead using phy_eee_rx_clock_stop()
to configure whether the PHY may stop the receive clock.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  1 -
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 25 ++------------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 26 +++++++++++++--------
 drivers/net/phy/phy.c                              | 27 ++++++++++++++++++----
 include/linux/phy.h                                |  1 +
 5 files changed, 42 insertions(+), 38 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

