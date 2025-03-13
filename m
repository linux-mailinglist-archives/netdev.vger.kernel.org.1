Return-Path: <netdev+bounces-174575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA6A5F565
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDB83AFC8C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374662676F1;
	Thu, 13 Mar 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YR7vNdiw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9522673A1;
	Thu, 13 Mar 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871166; cv=none; b=GDRAWnOfNnrZ8IFwqYKeOy3pDEPtFBpkCKRnpADPiAB00va5obU2/EfZqyYYlHj2WQsy20Kp4LkADFcdYptux4MDovP7YLzFYpMMRKfcfs7AmeTpVL6Ejy2Dhpw7dkdV5zLy0gTgRLlRC/mAXIIsMeIdRPdnUghJwcyUO1ErH7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871166; c=relaxed/simple;
	bh=DJidz3G5oows9bOJvTTZpWDJZyinL5CdZqY0dpNPwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfUPZMBlOlqhqzcDgWwI8a+R0S6xKxWo1aKil+8lr/b9+n29f8B7dKrFOhWATr6LFvwTz0yJsuQWcrfc3xJ+6fFcX351cDWKZp1koH2V7Np9mjcRJy2BLa6ctEzWwIpbl66IwwVKXeB2fRlztMKxLuPxwgKpk+NF39o6AgEAOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YR7vNdiw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DdVlJKa2eeRcUiESBmi2FXwO487h8QxuUtCG3zWuj7U=; b=YR7vNdiwWBEv4O/vH0UVdtQ8as
	7LmrqYIABxZJwLGaNy0CqfifsT2CcGBmEk4qhBLkJMk5fSmxdZBHmJJHOZNs9jRGse0Ywe44PSWvy
	cKqsERv5OPKVF5mcUjyDfFuSSAqMU8tGIzzze9UsTdPGonP8NNpUGxgkUQosvtgd8LiE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsiFu-004zhi-UL; Thu, 13 Mar 2025 14:05:46 +0100
Date: Thu, 13 Mar 2025 14:05:46 +0100
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
Message-ID: <478cf6c2-8461-46f8-bcde-d89032c35d63@lunn.ch>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
 <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
 <Z88FBR7m1olkTXxR@pidgin.makrotopia.org>
 <7269cf0f-21c6-45e1-a1f3-5463bdd9fd5c@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7269cf0f-21c6-45e1-a1f3-5463bdd9fd5c@alliedtelesis.co.nz>

> Ah I get it. It's about tracking the current page for a particular 
> device address and using that instead of 0xfff in 
> FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff). I'm not sure it's going to work 
> generically. Realtek switches know about Realtek PHYs but I've seen 
> plenty of other PHYs that do paging via addresses other than 0x1f 
> (Marvell 88E1111 for example uses 0x1d for its extaddr, some Broadcom 
> PHYs seem to use 0x1c). I'm not sure how many systems are mixing vendors 
> for C22 PHYs (the Zyxel boards seem to have Marvell AQR 10G PHYs but 
> that's C45).

It is worse than that. The switch needs to change the page itself:

static int rtlgen_read_status(struct phy_device *phydev)
{
        int ret, val;

        ret = genphy_read_status(phydev);
        if (ret < 0)
                return ret;

        if (!phydev->link)
                return 0;

        val = phy_read_paged(phydev, 0xa43, 0x12);
        if (val < 0)
                return val;

        rtlgen_decode_physr(phydev, val);

It needs to read register 0x12 from page 0xa43.

I do agree this cannot work in the general case. Which is why i asked
about what the limitations are for configuring the MAC in software.

	Andrew

