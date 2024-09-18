Return-Path: <netdev+bounces-128861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2C97C18C
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 23:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C9C28376A
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD51CA6B1;
	Wed, 18 Sep 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2uMRqhng"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C06FB6;
	Wed, 18 Sep 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695971; cv=none; b=FEKjj+gdp/az5fa+sPZxtWt9KRXLaYGQtDi7BgyMFjXKW+jpisWJIFPePjmq8hiP2HwwLsMBgM3Wxlo2M+6WMJO6pZ9D4iSjX1F64BPfe6u2tJi66XIHSHAmC85qjPXsxCxanSYSJko/sO+bEvi/Qbx1Zzb6TCxoVpS6iZZ7jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695971; c=relaxed/simple;
	bh=2JAVXLbmvY5chR2s5ENXGYmaUDXwiVf9c2ghoNaPybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3GtxzaRVBX8dspWD3Og2UTT2LIu2OkpwncXDAJNOH/28fNMdwVbG7lG1XyftTYs9j52Yr475uWPLYj1250DnzvVH/F/Wi13bwCx5l3+mgiiXFe+9J2gexf6QDBRFv4UjKamCWMd+IzQGCrc67Xd6vYI6kT3YiW2aZ1w9b5IGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2uMRqhng; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LiTlMU5tNsXM0VVteoP1U3alR033HX1QCn0vzJFq568=; b=2uMRqhng2P9k5kwobap9kfvqLz
	wWF2oIkz+NWodWiTpWv4fNMB+ZD+vjhwEb1JCMp7/hmmOYZ3LXg5EVZTPD5OoUOpbwEZMI9d81syM
	HmfIdm6VuG0wkKUPoxcbJovX7ALTqObwkFm+Bhp1nB220NTGYTDGGqirD7Gozilvdp0A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sr2Uk-007kQk-60; Wed, 18 Sep 2024 23:45:54 +0200
Date: Wed, 18 Sep 2024 23:45:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>, kernel@quicinc.com
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
Message-ID: <473d2830-c7e0-4adf-8279-33b91e112f80@lunn.ch>
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
 <20240913100120.75f9d35c@fedora.home>
 <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>
 <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
 <ZulMct3UGzlfxV1T@shell.armlinux.org.uk>
 <1c58c34e-8845-41f2-8951-68ba5b9ced38@quicinc.com>
 <1ed3968a-ed7a-4ddf-99bd-3f1a6aa2528f@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed3968a-ed7a-4ddf-99bd-3f1a6aa2528f@quicinc.com>

> Russell and Andrew 
> 
> we added prints and understood what the phy is reporting as part of the 
> genphy_c45_pma_read_abilities 
> 
> [   12.041576] MDIO_STAT2: 0xb301
> 
> 
> [   12.050722] MDIO_PMA_EXTABLE: 0x40fc
> 
> >From the PMA extensible register we see that the phy is reporting that it supports
> 
> #define MDIO_PMA_EXTABLE_10GBT		0x0004	/* 10GBASE-T ability */
> #define MDIO_PMA_EXTABLE_10GBKX4	0x0008	/* 10GBASE-KX4 ability */
> #define MDIO_PMA_EXTABLE_10GBKR		0x0010	/* 10GBASE-KR ability */
> #define MDIO_PMA_EXTABLE_1000BT		0x0020	/* 1000BASE-T ability */
> #define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
> #define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
> #define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */
> 
> [   12.060265] MDIO_PMA_NG_EXTABLE: 0x3
> 
> /* 2.5G/5G Extended abilities register. */
> #define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
> #define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */
> 
> I feel that the phy here is incorrectly reporting all these abilities as 
> AQR115c supports speeds only upto 2.5Gbps 
> https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen4-product-brief.pdf
> 
> AQR115C / AQR115 Single port, 2.5Gbps / 1Gbps / 100Mbps / 10Mbps 7 x 7 mm / 7 x 11 mm

One things to check. Are you sure you have the correct firmware? Many
of the registers which the standards say should be Read Only can be
influenced by the firmware. So the wrong firmware, or provisioning
taken from another device could result in the wrong capabilities being
set.

You might want to report this issue to Marvell, but my guess would be,
they don't care. I would guess the vendor driver ignores these
registers and simply uses the product ID to determine what the device
actually supports.

> I am thinking of solving this problem by having 
> custom .get_features in the AQR115c driver to only set supported speeds 
> upto 2.5gbps 

Yes, that is the correct solution.

It would also be good if you could, in a separate patch, change the
aqcs109_config_init() to not call phy_set_max_speed() and add a custom
.get_features.

	Andrew

