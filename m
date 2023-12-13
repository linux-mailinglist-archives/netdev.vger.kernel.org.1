Return-Path: <netdev+bounces-57006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C548118DA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4791C20BC8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBED321A4;
	Wed, 13 Dec 2023 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aQ4Neh/E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FD5F2;
	Wed, 13 Dec 2023 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xV3wbVp3koIwVhD4qHfAMLfeq9KzkKaD2awlRFNRYZI=; b=aQ4Neh/EiRyFSY/SqHAJkSfh08
	Qf1GJpr6hYLA0xRB1eCDCFt23Lj8KGxoSQOmWtzH+I0LXyUARfiUR3/25hgXi9U7UIE5XWlW+3+21
	r71zkLs6JS4HnBxMO8U6P/9nISJdyQlpGSv0PvOgMyNWwP2fpd95/QA6jWkuwAQCjY9Kv0JWdXI+E
	LKe9Ml+IBJGRaZNOD1OKoXgR+ewr2hSsRuqeQU/zUkFWMUn6Us1KUJx8+gd1URkblm5WHQ7Ev7VIj
	sBHQ58IggmT+SqDs770buUqtd61FcSUTzP6opdgogyd+TKGoWXbnYKSv1/U03pKsw70GVGe/xWpMS
	3S9gcwHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDRrS-0000Em-1z;
	Wed, 13 Dec 2023 16:13:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDRrU-0001e1-NA; Wed, 13 Dec 2023 16:13:28 +0000
Date: Wed, 13 Dec 2023 16:13:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <ZXnYKLOeStCuVXY7@shell.armlinux.org.uk>
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
 <20231213105730.1731-3-ansuelsmth@gmail.com>
 <ZXnSB4YsuWZ0vdj2@shell.armlinux.org.uk>
 <6579d3df.050a0220.41f9b.a309@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6579d3df.050a0220.41f9b.a309@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 13, 2023 at 04:55:08PM +0100, Christian Marangi wrote:
> On Wed, Dec 13, 2023 at 03:47:19PM +0000, Russell King (Oracle) wrote:
> > On Wed, Dec 13, 2023 at 11:57:30AM +0100, Christian Marangi wrote:
> > > Some PHY in PHY package may require to read/write MMD regs to correctly
> > > configure the PHY package.
> > > 
> > > Add support for these additional required function in both lock and no
> > > lock variant.
> > > 
> > > It's assumed that the entire PHY package is either C22 or C45. We use
> > > C22 or C45 way of writing/reading to mmd regs based on the passed phydev
> > > whether it's C22 or C45.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > I don't recall what has been said in previous postings of this, but
> > introducing new helpers without an example user is normally frowned
> > upon. The lack of cover message for this three patch series also
> > doesn't help (the cover message could explain why there's no users
> > being proposed with this addition of helpers.)
> >
> 
> These are prereq for the qca803x PHY driver and the PHY package series.
> 
> I can move this single patch in those series, but it was suggested to
> move these simple change to a separate patch to lower the patch number
> since they were orthogonal to the PHY package series proposal.

... so adding a cover message (your series in general seem to lack
those) would be a good idea to explain that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

