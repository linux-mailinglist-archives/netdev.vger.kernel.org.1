Return-Path: <netdev+bounces-122846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F353962C43
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FD01C2114B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A29E1A3BC2;
	Wed, 28 Aug 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4QYF/WTy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825701A76DF;
	Wed, 28 Aug 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858731; cv=none; b=tV40/7esJ9TAwzUYOQC9eCiWbI1Z6slROT2yiwc/FiBsWY0z3lnFSLUbJ2Jyxz4TGhkG1Aj7vtep3RZHs0yaSlY0grKA4KRpTw1LOS6whYCF/IuTQ1BSsc0xGP2AplKsXc/5e+qvSHWHiJP7LJkxnib+Hhx/bbyI+3AMqXnOgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858731; c=relaxed/simple;
	bh=I1Nby7tDKVVdapSHtGQT7L9Eim8jq/dT28PjMGd+PHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3tMRwof3rvufRb5VpW+W52dGonLBakZIwt3oOnoSNRjQvl/Ld/norSE8rb2T13321rOMZ1AbuvfVvo69e/CGg9jf8fGUONHbYZ+pQie8XNAo+YrcOeHK4RpgtQXLPyJoyQBBR04Nqr4NDb0L3yTr7VfoNBrLoqzKMaFhfeOIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4QYF/WTy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q9URPVBkUtuX1b5vQ91DBWUEAecVTYj3WQtfiiyjLe8=; b=4QYF/WTy90NVcHGEOPZW700puH
	PsWHZNWpHEEmbUSmKRVNivVlJQkwuHYMKXyODQQdUQ9oRrpIMyHeXgljjtrbAc62/dTBO/DeDzES2
	ljIryYIG/AOUumjbxUyE+dFDD5Ya7ABiL3AzxT0XW2O9c/AC8edgXY63kxxwLYPrXxP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjKXU-005wr6-5U; Wed, 28 Aug 2024 17:24:52 +0200
Date: Wed, 28 Aug 2024 17:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, woojung.huh@microchip.com,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org
Subject: Re: [PATCH net-next v2 00/13] net: Simplified with scoped function
Message-ID: <6d88b103-ba8a-4631-bbf5-b9046b9b82cd@lunn.ch>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <6092e318-ae0c-44f6-89fa-989a384921b7@lunn.ch>
 <71deb322-4b54-4c1c-a665-d9de84ea9baf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71deb322-4b54-4c1c-a665-d9de84ea9baf@kernel.org>

On Wed, Aug 28, 2024 at 04:45:32PM +0200, Krzysztof Kozlowski wrote:
> On 28/08/2024 16:32, Andrew Lunn wrote:
> > On Wed, Aug 28, 2024 at 11:23:30AM +0800, Jinjie Ruan wrote:
> >> Simplify with scoped for each OF child loop and __free(), as well as
> >> dev_err_probe().
> >>
> >> Changes in v2:
> >> - Subject prefix: next -> net-next.
> >> - Split __free() from scoped for each OF child loop clean.
> >> - Fix use of_node_put() instead of __free() for the 5th patch.
> > 
> > I personally think all these __free() are ugly and magical. Can it
> 
> It is code readability so quite subjective.

Try.

But the __ is also a red flag. Anything starting with _ or __ in
general should not be used in common code. That prefix is supposed to
indicate it is internal plumbing which should be hidden away, out of
sight, not to be used directly. Yet here it is, being scattered
everywhere.

I also wounder if this is lipstick on a pig. I suspect the reference
counting on DT object is broken everywhere, because it is almost never
used. In general, DT blobs exist from boot to shutdown. They don't go
away, so these reference counts are never used. DT overlays do exist,
but account for what, 1% of DT objects? And how often does an overlay
actually get unloaded? Has anybody written a fuzzer to try unloading
parts of DT blobs? I suspect we would quickly drown in bug reports.

Adding missing of_node_put() seems to be high on the list of bot
driven patches, which cause a lot of maintainer effort for no real
gain. And those submitting the patches probably have little
understanding of what they are doing, other than making the bot happy.
Do we really want to be adding ugly code, probably with a few
additional bugs thrown in, just to make a bot happy, but probably no
real benefit?

	Andrew

