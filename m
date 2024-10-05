Return-Path: <netdev+bounces-132383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBD991748
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ED41F220D2
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C994155336;
	Sat,  5 Oct 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zTDGIfcQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0215530C;
	Sat,  5 Oct 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138020; cv=none; b=fbGPWjtljwmeGJtRU/JGsdkWSv0agBVLy+SyMbBpDQwsBPljLVCoN+kYB5zYDKZbJFLIdb6dcUsHNKr5kULgFvQFyDHuZhL6z1AOexMvMmmKmxC7r1aSrK0O11EbWFzORoCN1NU5XmER/9YxADZZeDs4YGBFmiQxxyeeUM7G1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138020; c=relaxed/simple;
	bh=wtRp8FAmaK/EorQIVlbahu7UK5Unh1c2NFD5CFB2Hmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX0keIkUy2o2RBEie6lzH3wRIDnX0ScxjlCNvc9A3fna/HGsOyU88Ysp+wjUZudjok+wMFwDen966jbvTMYRe/f6g/shbHyyPH3eEiEbqJs899IXReeVu/j3B3vrz+eJ2MDj3j9dUxhtR6F2dSqVC+lbmjURgJOcrHAU4DVa1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zTDGIfcQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fw1wJBjPYy1YfB/jCXAr3PQ7u4GuIXzZMqKoHSbpCL4=; b=zTDGIfcQ9828u6S5SFDjkcv5mw
	QETPdkL1fcxUGvGPhAtiSyckVF61O59wECOQlpDcHgqEBSEqmf1wpcAiuC8p7hAHWFrr65HNHr78m
	HSD0sLf26dUnm5JPHZfAd9S2Q+ypw/nCsT73bgFH6I1yUe1BBqJOOm23tteMxuGN6O70=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx5df-0098T1-On; Sat, 05 Oct 2024 16:20:07 +0200
Date: Sat, 5 Oct 2024 16:20:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: make sure paged read is
 protected by mutex
Message-ID: <32c342ef-62e8-4d85-8451-cfbb6024d869@lunn.ch>
References: <792b8c0d1fc194e2b53cb09d45a234bc668e34c6.1728057091.git.daniel@makrotopia.org>
 <398aed77-2c9c-4a43-b73a-459b415d439b@lunn.ch>
 <ZwBl5XBPGRS_eL9Y@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBl5XBPGRS_eL9Y@makrotopia.org>

On Fri, Oct 04, 2024 at 11:02:13PM +0100, Daniel Golle wrote:
> On Fri, Oct 04, 2024 at 11:25:29PM +0200, Andrew Lunn wrote:
> > On Fri, Oct 04, 2024 at 04:52:04PM +0100, Daniel Golle wrote:
> > > As we cannot rely on phy_read_paged function before the PHY is
> > > identified, the paged read in rtlgen_supports_2_5gbps needs to be open
> > > coded as it is being called by the match_phy_device function, ie. before
> > > .read_page and .write_page have been populated.
> > > 
> > > Make sure it is also protected by the MDIO bus mutex and use
> > > rtl821x_write_page instead of 3 individually locked MDIO bus operations.
> > 
> > match_phy_device() as far as i know, is only used during bus probe,
> > when trying to match a driver to a device. What are you trying to lock
> > against during probe?
> 
> The idea is to reduce the amount of unnecessary lock/unlock cycles (1 vs
> 3). Of course, we could just omit locking entirely here, but that seemed
> a bit wild to me, and even if it would work in that specific case, it
> just serve as a bad example.

I would just comment the requirement that it can only be used during
probe, and remove all the locks.

	Andrew

