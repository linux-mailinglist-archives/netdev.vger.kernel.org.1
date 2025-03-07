Return-Path: <netdev+bounces-173010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F5A56DA9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B63516E3B0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40623BCFA;
	Fri,  7 Mar 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PD4ApEoK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFD1E1E0B
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364890; cv=none; b=FbrK4CU0CQ3CtSGRg/QSgc+noDbt7/fqtv0oKbfGYdmHGat0IbEEbE8pbbaOMvFYNO89JEiupCUl0YTZbZTvi1uQfxX7QATS9udATRd/V3zSez8sVDUp2UlMTxsJ2GVPMKpIsz5YQ+QHbhBhuBludrFWhO4LVQ4HrE2lzYtQuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364890; c=relaxed/simple;
	bh=pGkiDp466gQ5KlPRgSlXKw7ysnTz5HCiuxhAFzC0xc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1lA2BrkhEkTD+fHwChebAhuG8R8wmSKEL0VE+3OHji9CSGzX1Hz5fE+ytricqTpZHAXmfHABG9z1hPZdkP6217Ala/MYeaId1fYYaWvnLh06FVxV73+WCzP2dEfxmgm31Znn2km/SgCAK2PanbU9lTv+coDMVqTWK+AdxIdajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PD4ApEoK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=W5wISx9IfH+VuHPib7yuiTre9EirHyZ1X2VzrLgTTr8=; b=PD
	4ApEoK9Tvd86zDl92pUuZiEo8WoSiq0Fp+gbdXk7Fu0HQIK11tTczD343oer52gKG/5MGZZtm/9jD
	nLruk46WqJvljsjo4sxViBO+W/EJyLCULb4vXZUD3sxIunnx6ezjDBeAbSj37xeS6X6MaTh5BJ7+G
	oJbzaptGBx3xV0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqaYI-003BuQ-Cs; Fri, 07 Mar 2025 17:27:58 +0100
Date: Fri, 7 Mar 2025 17:27:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org, ltrager@meta.com,
	linux@armlinux.org.uk, Jakub Kicinski <kuba@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for
 PHY loopback
Message-ID: <4a48d205-5026-4ec9-aa8b-bc1459641d33@lunn.ch>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
 <20250227203138.60420-3-gerhard@engleder-embedded.com>
 <20250303173500.431b298e@kernel.org>
 <3d98db01-e949-4dd7-8724-3efcc2e319d9@lunn.ch>
 <20250304081502.7f670381@kernel.org>
 <1d56eaf3-4d8c-40da-8a10-a287f09553e6@engleder-embedded.com>
 <53b21122-f077-46f6-8059-d1d87f66a3e7@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53b21122-f077-46f6-8059-d1d87f66a3e7@engleder-embedded.com>

On Thu, Mar 06, 2025 at 06:58:20AM +0100, Gerhard Engleder wrote:
> On 04.03.25 21:00, Gerhard Engleder wrote:
> > On 04.03.25 17:15, Jakub Kicinski wrote:
> > > On Tue, 4 Mar 2025 14:20:02 +0100 Andrew Lunn wrote:
> > > > The current IOCTL interface is definitely too limiting for what Lee
> > > > will need. So there is a netlink API coming soon. Should Gerhard and
> > > > Jijie try to shoehorn what they want into the current IOCTL handler,
> > > > or help design the netlink API? How can selftest.c be taken apart and
> > > > put back together to make it more useful? And should the high level
> > > > API for PRBS be exported through it, making it easier to use for any
> > > > netdev?
> > > 
> > > As we think about this let's keep in mind that selftests are generic,
> > > not PHY-centric. Even if we can pass all link settings in there are
> > > other innumerable params people may want in the future.
> > 
> > My patchset can be divided into two parts:
> > 1) Extend phy_loopback() to select a defined speed
> > 2) Extend tsnep selftests to get some in-kernel test coverage for the
> >     phy_loopback() extension
> > 
> > This discussion is related to the selftest rework of the second part.
> > Would it be ok to put the first part into a separate patchset, as this
> > changes make sense and work even without the selftests?
> 
> Andrew, is it ok to put phy_loopback() extension to a separate patch
> set?

Without the selftest part, the phy loopback changes go unused. We
don't normally add APIs without a user. So i would say no, it should
be all or nothing. I don't think it will cause many problems if these
patches need to wait a while, a rebase should be easy, this area of
phylib is pretty stable.

	Andrew

