Return-Path: <netdev+bounces-236805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66543C40424
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02B63A2D85
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01F326D4F;
	Fri,  7 Nov 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XaL90Lj0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03105322C8A;
	Fri,  7 Nov 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524477; cv=none; b=SRrkjhkrrSmXVL6t7kUbohWyY7XPkAd3h/bjDP0HsEDalYGTs0Tpdo3ejmClUmfOp1fCVQdPc9TJ2lj5vUfwTfwVrcMnJbjcK+j+nMIZ1wHy0aK6WXWK6LO3CIcQmn6PPG+7fsWFYNZnkGovoVNyKcgIZVt1COSoZWIK7f9nibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524477; c=relaxed/simple;
	bh=xi1p3UfI6cYReWzHLuKB5wOsq/CZTjbGUDAcn6Mfw/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4SM8ZrWeLhNHfjv2/Ko+gZYLkOXL5KPTvKfh0NcSMNzz97V2ymXk7MiHRBFGTsY62Z6FYzq8Ntw1cO9VyQRHYHgtwKzlkb4LJbIjDJu+4LR6p8QCaEI84eFDXmxbkOeI/Txj1tIrtd+G1Q2GgKiV7dsRMozxbnqwvQH/0SNTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XaL90Lj0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WunMkou0PFfY6bJoaMJMYMVjxXwdEk+75gvzjYVSq28=; b=XaL90Lj0UmeyzKx5vwcmlnpnya
	IDudWDWkYWo1FguM7xqIkANCUZz3R6Cn8uGur6HR+Wb9oD+1iaGW+t2YlLLyk5pmDmQ8/zAMcPf/k
	RbnlqW0Q76TUX2qyC0Tl/jXs2fBWS5HDe7SMFJI9CcY9pVqIFzq9G9DPouTH0m3qHPmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHN80-00DEaN-TA; Fri, 07 Nov 2025 15:07:48 +0100
Date: Fri, 7 Nov 2025 15:07:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode
 interpretation
Message-ID: <ec456ae4-18ea-4f77-ba9a-a5d35bf1b1fd@lunn.ch>
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
 <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch>
 <CAOiHx=kt+pMVJ+MCUKC3M6QeMg+gamYsnhBAHkG3b6SGEknOuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=kt+pMVJ+MCUKC3M6QeMg+gamYsnhBAHkG3b6SGEknOuw@mail.gmail.com>

> There is allwinner/sun7i-a20-lamobo-r1.dts, which uses "rgmii-txid",
> which is untouched by this patch. The ethernet interface uses "rgmii".

Which is odd, but lets leave it alone.

> And there is arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts,
> where a comment says that it has a BCM53134, but there is no such
> node. The ethernet node uses "rgmii".

aspeed pretty much always get phy-mode wrong. So i would not worry too
much about this.

> So one doesn't define one, one uses rgmii-id on the switch / phy side
> and rgmii on the ethernet mac side, and one only defines the ethernet
> mac side as rgmii.

That is reasonable. It is a lot less clear what is correct for a
MAC-MAC connection. For a MAC-PHY connection we do have documentation,
the preference is that the PHY adds the delays, not the MAC. If the
switch is playing PHY, then having it add delays is sensible.

> > I would maybe add a dev_warn() here, saying the DT blob is out of date
> > and needs fixing. And fix all the in kernel .dts files.
> 
> Sure I can add a warning.

Great, thanks.

	Andrew

