Return-Path: <netdev+bounces-173591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C336FA59B12
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F74D3A6DAB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE061C1F10;
	Mon, 10 Mar 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wk1KH7M0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAA1E519;
	Mon, 10 Mar 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624380; cv=none; b=OttqO9R4DqRexLuwpGt/vH1MKiDe7e2Z8iBXjqW60p6rr3+9qoDt5vHmx1h9wlG1BrJZJCe83yvJ39jk3TWs/Ks//8MMf2e1AAT5wX5vo80XoI3YZwyWNeHOBgRF1OZ/FMcdwxClOlIXab6igMjPNrlstVkQOW1yd2b3t1gNMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624380; c=relaxed/simple;
	bh=Kvfc91l2KCRnMxu6n4P8Y+FQRrKgptGelFtGLwt5Uzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mopX/8Xjkfw+/xyIHbniSJvQI46fDLtJRbCRCGTwSWHuhO7V20Xm/ujZtDUUmta1d6Ox/V2ypjYsZTiN5rwFiTPhkvIYxQKeh0Ad004DpwUUTLGI7kTzhsZSIXsISTb/S5nfLW9/Uk/Tnk++we3OARTYhluk0Ak+bGfmVYXJwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wk1KH7M0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SKPAgvVsARXQJlsa+JzX7lDRyNQEsQ5O09OnW/tTa5A=; b=wk1KH7M085aceyZG7pKgjU6QA2
	SjJZKcrT9DpYbHa5Eizma9GizYt/6GV7sspdrJor2gaWJCOtXn0UheJV8d6FWtJP0p2h1PWJtrDEA
	l2l1ZzJkps19MBtDSr7cJUU8RsxTRrEtPwuVUwHkXQ7USyEAMcaqW2yYA9GT4Elrl2WM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trg3V-0044HZ-1B; Mon, 10 Mar 2025 17:32:41 +0100
Date: Mon, 10 Mar 2025 17:32:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Daniel Golle <daniel@makrotopia.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"sander@svanheule.net" <sander@svanheule.net>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Message-ID: <f6c7581d-7e4b-4114-bb57-8b009d66c5d2@lunn.ch>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
 <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>

> So far upstream Linux doesn't have generic paged PHY register functions. 

Yes it does:

phy_write_paged() and phy_read_paged().

These do all the locking to make sure they are atomic with respect to
other phy read/writes while the page is selected. The driver just
needs to provide two methods to read the current page and the set the
current page,

https://elixir.bootlin.com/linux/v6.13.6/source/include/linux/phy.h#L1060

	/** @read_page: Return the current PHY register page number */
	int (*read_page)(struct phy_device *dev);
	/** @write_page: Set the current PHY register page number */
	int (*write_page)(struct phy_device *dev, int page);

Andrew

