Return-Path: <netdev+bounces-50108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8EF7F4A42
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6CE1C20362
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F163D96F;
	Wed, 22 Nov 2023 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JYDBp5Xp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27419D
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SdKbDx0mIICTSgh44WEbwktgwt4xjrvcg04KmHiRw7E=; b=JYDBp5XpyHXjAwYVO9qAuVviOj
	BZf0o3ltEr99FsS57DjDhZRNsDOCWZ+8llspRhqg685dG2xLLz7VSmDDWwYAPTZoDTwAu39bfU3Yh
	PDDSdLNuJ/ppOBlhiT7KBf/iBT1alpWQeFJHcPAO88hObPMD9Ntb5aG3sN0ppQf6KTz0F9qPveikq
	jTzfMOE2A/wZFYmdWej1EAn0ys0iQfF8mLI9Qq7VQUZS1d8AHIN1t7FdrtQsBNlpTlUi0zHkCepm0
	UtjTk6j6v5xXJBTiT3xN/9lYTaII6RrLBeF0cZPwnXPEeBwlfzXSNafYXmMRBxp/7ed8SVWHiMSaj
	Sw5kc2bA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38628)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r5pBa-0000KC-1p;
	Wed, 22 Nov 2023 15:30:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r5pBb-0005IB-1K; Wed, 22 Nov 2023 15:30:43 +0000
Date: Wed, 22 Nov 2023 15:30:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC 00/10] net: phylink: improve PHY validation
Message-ID: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
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

One of the issues which has concerned me about the rate matching
implenentation that we have is that phy_get_rate_matching() returns
whether rate matching will be used for a particular interface, and we
enquire only for one interface.

Aquantia PHYs can be programmed with the rate matching and interface
mode settings on a per-media speed basis using the per-speed vendor 1
global configuration registers.

Thus, it is possible for the PHY to be configured to use rate matching
for 10G, 5G, 2.5G with 10GBASE-R, and then SGMII for the remaining
speeds. Therefore, it clearly doesn't make sense to enquire about rate
matching for just one interface mode.

Also, PHYs that change their interfaces are handled sub-optimally, in
that we validate all the interface modes that the host supports, rather
than the interface modes that the PHY will use.

This patch series changes the way we validate PHYs, but in order to do
so, we need to know exactly which interface modes will be used by the
PHY. So that phylib can convey this information, we add
"possible_interfaces" to struct phy_device.

possible_interfaces is to be filled in by a phylib driver once the PHY
is configured (in other words in the PHYs .config_init method) with the
interface modes that it will switch between. This then allows users of
phylib to know which interface modes will be used by the PHY.

This allows us to solve both these issues: where possible_interfaces is
provided, we can validate which ethtool link modes can be supported by
looking at which interface modes that both the PHY and host support,
and request rate matching information for each mode.

This should improve the accuracy of the validation.

 drivers/net/phy/aquantia/aquantia.h      |   5 +
 drivers/net/phy/aquantia/aquantia_main.c |  76 +++++++++++-
 drivers/net/phy/bcm84881.c               |  12 ++
 drivers/net/phy/marvell10g.c             | 203 ++++++++++++++++++++-----------
 drivers/net/phy/phy_device.c             |   2 +
 drivers/net/phy/phylink.c                | 177 +++++++++++++++++++--------
 include/linux/phy.h                      |   3 +
 7 files changed, 353 insertions(+), 125 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

