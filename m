Return-Path: <netdev+bounces-54960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EA80908B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5319A1C20984
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0442ABB;
	Thu,  7 Dec 2023 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D+Bv31+p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B37F121;
	Thu,  7 Dec 2023 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SC4n/zXNUUfBAekQk0GSBXQG99rCFLSursm1c12jHB8=; b=D+Bv31+pmR2HKYSu9WWo8G+iKO
	Q+ym0IM0v5Np/DlRoQZzGADL3Mez59xLnfhj4GN9u8DEOA1ciWeqWxXwq08tv6sNCdJSAsITPtpWR
	ZggnqmzDkQGBLm9VnQiruV9Two2tFI4Bq6Vc+YTJkndgr5rwuCzQBdaeXq0gZOqgdsIqfVBbt8cxG
	vJRooJkXsYvWwjbQDWZ48Pt7V0ACG/eauYgwUBSKC9zcbSrI/cwU4jOYSUPfIH7HavLv3FBaJ5BQW
	YdPOpIMsrJuYZQgN1q/y5DaHHaA0mb1NnzLLDnLwE/ShkalxEWKfvoVLnCLMummC/R5BuQejHTHum
	4IFd2MrQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rBJSJ-0001YV-2i;
	Thu, 07 Dec 2023 18:50:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rBJSK-0003xn-Lc; Thu, 07 Dec 2023 18:50:40 +0000
Date: Thu, 7 Dec 2023 18:50:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Justin Chen <justin.chen@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
	Doug Berger <opendmb@gmail.com>, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Only resume phy if it is suspended
Message-ID: <ZXIUAPx1aClSsKED@shell.armlinux.org.uk>
References: <20231205234229.274601-1-justin.chen@broadcom.com>
 <7e3208aa-3adf-47ec-9e95-3c88a121e8a3@lunn.ch>
 <55a08719-cd18-4a01-9a2a-0115065c06a6@broadcom.com>
 <c2ce6d12-fb5e-4067-aa7c-4f57f4eb4613@broadcom.com>
 <f7eb20eb-3f0d-42c5-93fe-a622639c55a6@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7eb20eb-3f0d-42c5-93fe-a622639c55a6@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 07, 2023 at 09:56:01AM -0800, Florian Fainelli wrote:
> Hi Andrew,
> 
> So we discussed with Justin and Doug about this yesterday and the main
> reason for the phy_resume() ... MAC initialization ... phy_start() pattern
> has to do with external RGMII PHYs and the clocking dependency between the
> MAC and the PHY on the RX path. And also a tiny bit of cargo culting, but
> shhh.
> 
> When the external RGMII PHYs are suspended they will stop providing a RXC
> back to the Ethernet MAC and our Ethernet MAC like a lot of designs out
> there require the RXC in order to be functional and complete its reset
> procedure correctly (you would think there would be a way to mux in a
> different clock, but that does not appear to be the case). If we reset the
> UniMAC block without a RXC we will typically see duplicate packets being
> received, or absurdly long round trip times as soon as we try to use the RX
> path.

This issue keeps appearing, and I think phylib ought to be doing more
to support it, rather than ethernet drivers having to play fancy games.
If one recalls stmmac, that has similar issues - it needs the RXC from
the PHY to reset properly.

I did propose that we have:

+#define PHY_F_RXC_ALWAYS_ON    BIT(30)

that can be passed to phy_attach_direct()'s flags, which phylib drivers
can then act upon to e.g. in the case of at803x, disable their
hibernation mode which stops the RXC when the system isn't suspended.
(AT803x Hibernation mode is enabled by default and the PHY automatically
enters it when the link is down.)

Maybe this flag should be used to determine the resume behaviour,
e.g. to ensure that the RXC is re-enabled early without the MAC driver
needing to be involved?

WoL is a different problem - that depends whether the PHY is itself
doing WoL independently from the MAC, or whether the MAC is involved.
If the MAC is involved, then clearly the MII link between the PHY and
MAC needs to be maintained while the system is in low power mode,
which is an entirely different issue from the RXC being present
while the MAC is being resumed.

Maybe PHY_F_RXC_ALWAYS_ON is a bad name, as I intended it to only refer
to while the system is running, not while in low power mode.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

