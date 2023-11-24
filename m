Return-Path: <netdev+bounces-50817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1067F73C1
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65061281303
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9EC249E2;
	Fri, 24 Nov 2023 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ly2EujlL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15742D71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJ4pJItto6MO5iPtZbee1r50454UJOBT1TQ8fJJMqok=; b=Ly2EujlL0oRmNrqS/oanmy4DqD
	WSEBUrvRFxdvt4SFxBUFU6i9ppQHvLtLOAIqB7lUsUPzWl82rTbtVTPpmlTKzTl/y1x6BRurZWZsO
	Td1OV8Hriugetkx8JQPOm237NgU9oaRHPB8NiOsftGIsLeC5Gop+su/IgfGN1iMGNihUga8N+CfW5
	j1esv7JSs8Skq4RuzjUQwCjyDxGTaGnt2l8sajNYxY1HabX6sLgcBK3A7Cqo4duB3grq0xmU8FTVS
	gMuuEsgYBafytaWO4BoLW+v5EvqRnC6xhIclziAjmKmft+H9KcTL+850/JO0Q9+EKc5TzwGievag2
	3YV5fYdQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r6VFs-0002rh-38;
	Fri, 24 Nov 2023 12:25:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r6VFu-0007Eg-CP; Fri, 24 Nov 2023 12:25:58 +0000
Date: Fri, 24 Nov 2023 12:25:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 00/10] net: phylink: improve PHY validation
Message-ID: <ZWCWVtgSsxZUCErJ@shell.armlinux.org.uk>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
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

Sending this out again without RFC as Jie Luo will need it for the
QCA8084 changes. No changes except to add the attributations already
received. Thanks!

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

