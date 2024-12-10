Return-Path: <netdev+bounces-150656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593FB9EB20B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F60E188AD1D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7601A9B2F;
	Tue, 10 Dec 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Felk73iO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BD23DEB6;
	Tue, 10 Dec 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837922; cv=none; b=jUCgTE9pEvUwrq9n/yXIg5E6kdXCNm+mSrCfI+AeBZL1nN15aDXP075rnGJLhFuSrL9MSQ5XsdSnv6n+0QBWP35oqRXTveLZP9E3jF0DeHr4ZeNu8IaXeZQH4Fv0XzKRxadnFJYWyIa/Bq/RMbCci/kxxjSbVU0ha9hdvurRgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837922; c=relaxed/simple;
	bh=7QVI3OM2T4jIx2QkXvgRWsJtnh39wdWi7Qlh6lv14yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkglcBoEAxE9LEBaj25/SI8z0jm+DKxWsqfQDhr8oQwamnk5QtwfKFhy30Kr6PIsrcNy3kIL4xpXSDrnLXozzgDbZWsy8YaGZaw3CBjHt5DxwNWQHPctNqhvXUQQGqNfPtRVeNbtzzU+qj2inacNNcSvuWN7Iqnwk+QmxS2vHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Felk73iO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JTFT+9zxHZAYsd5at7fqwUdZUtL0uBlHOOcBL8Go5hg=; b=Felk73iOHWeImqFqE1wd/6xiCQ
	B3JbqkHtRYmqA+R0jQbvEt6aX1fDNkuCBWAuLvNduTKPOYVM+B6OuzCfzmqEr8MCde9cyEeOsYXj1
	XB5EDdHe+tY4f1W0Wfl95hvJfE1NOievTDHjON28WntZWO610Hximxl8m8+Zg5Sbvhao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL0RR-00Fnwk-Ue; Tue, 10 Dec 2024 14:38:21 +0100
Date: Tue, 10 Dec 2024 14:38:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 6/9] net: mdio: Add Airoha AN8855 Switch
 MDIO Passtrough
Message-ID: <0523b9a2-0d77-4bb8-ac1e-f28b96eb36b2@lunn.ch>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-7-ansuelsmth@gmail.com>
 <5aec4a94-3cea-41a4-8500-71472fae51d4@lunn.ch>
 <67582eca.050a0220.3b9b85.2de4@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67582eca.050a0220.3b9b85.2de4@mx.google.com>

On Tue, Dec 10, 2024 at 01:06:29PM +0100, Christian Marangi wrote:
> On Tue, Dec 10, 2024 at 02:53:34AM +0100, Andrew Lunn wrote:
> > > +static int an855_phy_restore_page(struct an8855_mfd_priv *priv,
> > > +				  int phy) __must_hold(&priv->bus->mdio_lock)
> > > +{
> > > +	/* Check PHY page only for addr shared with switch */
> > > +	if (phy != priv->switch_addr)
> > > +		return 0;
> > > +
> > > +	/* Don't restore page if it's not set to switch page */
> > > +	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
> > > +					    AN8855_PHY_PAGE_EXTENDED_4))
> > > +		return 0;
> > > +
> > > +	/* Restore page to 0, PHY might change page right after but that
> > > +	 * will be ignored as it won't be a switch page.
> > > +	 */
> > > +	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
> > > +}
> > 
> > I don't really understand what is going on here. Maybe the commit
> > message needs expanding, or the function names changing.
> > 
> > Generally, i would expect a save/restore action. Save the current
> > page, swap to the PHY page, do the PHY access, and then restore to the
> > saved page.
> >
> 
> Idea is to save on extra read/write on subsequent write on the same
> page.
> 
> Idea here is that PHY will receive most of the read (for status
> poll) hence in 90% of the time page will be 0.
> 
> And switch will receive read/write only on setup or fdb/vlan access on
> configuration so it will receive subsequent write on the same page.
> (page 4)
> 
> PHY might also need to write on page 1 on setup but never on page 4 as
> that is reserved for switch.
> 
> Making the read/swap/write/restore adds 2 additional operation that can
> really be skipped 90% of the time.
> 
> Also curret_page cache is indirectly protected by the mdio lock.
> 
> So in short this function makes sure PHY for port 0 is configured on the
> right page based on the prev page set.
> 
> An alternative way might be assume PHY is always on page 0 and any
> switch operation save and restore the page.
> 
> Hope it's clear now why this is needed. Is this ok or you prefer the
> alternative way? 

Please think about naming. I'm not sure _restore_ is the correct name
for the function. Maybe select. And i suggest adding some comments to
explain what is going on, since it is not obvious from the code in
this file, you probably need to cross reference it with code in the
DSA driver as well.

	Andrew

