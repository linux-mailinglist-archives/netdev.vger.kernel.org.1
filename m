Return-Path: <netdev+bounces-138432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C79AD8D8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 01:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D991C21731
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 23:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54E200136;
	Wed, 23 Oct 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xXaPPxsW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E031E0087;
	Wed, 23 Oct 2024 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727814; cv=none; b=q2dIoNFHnM5coGuwUsH7yuUUhRRNtT0I0G6CsRspZ9j2LKwZ5B81f2OzFoSsH6JT5qjNiVoA5UKyr8F0CxHmX8NszBvj+VSXqyYyREImEaUsuixn3RHtesy7yNdxJ4HLzV/9PzA+QkyNbnj0mwLHjeKgeYMqwliwgV3WRSPZCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727814; c=relaxed/simple;
	bh=ER3FknFXrHM3OX+lTqkJggiQuTe6Auk+uTi2E4vUyzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8Tyy6i7zM9QFj3Yq2Hc69D47S3E3j0iwGRhG0UTQxH3tOIhU8FOw/M4N3IprCP5HP6Px8fKczoXU/eXacFB2KH/y+HHutDAMNLg9ItYbw5XfiLtjI+EDXKEic1gzCNewtEWutUkfEYCPgzPw1l3niJ9BzeGa/z9RAh8sqgv4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xXaPPxsW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RoRcRsT4dhnXehgIrOkavzDeXndrmIy2Jhqon6Rlw04=; b=xXaPPxsWzvAbAQuddJCjS9yg5d
	2/VF7BtvdVpWAbUQBX7qUUcBsszBfqG67ZBz0MoKXGrjtUWuGGs6saIWYGdTn8TV4PvEJkmh0Y136
	u6FUSMwVJaXCsPav2KWXtqSUkpKEBVRtn/vlgfd4QeXco3meEX/lWhBFZXMyMqHmxtOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3lDL-00B1qp-9U; Thu, 24 Oct 2024 01:56:31 +0200
Date: Thu, 24 Oct 2024 01:56:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <6f0e1c34-d5d3-4ee5-9374-768e67a0c067@lunn.ch>
References: <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
 <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
 <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>
 <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>
 <d691a687-c0e2-48a9-bf76-d0a086aa7870@lunn.ch>
 <amg64lxjjetkzo5bpi7icmsfgmt5e7jmu2z2h3duqy2jcloj7s@nma2hjk4so5b>
 <79f9b971-8b3f-4f31-ab42-42a31d505607@lunn.ch>
 <uzlmckuziavq5qeybvfm7htycprzogvkfdqj2pxrjmdkuovfut@5euc5nou7aly>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uzlmckuziavq5qeybvfm7htycprzogvkfdqj2pxrjmdkuovfut@5euc5nou7aly>

On Thu, Oct 24, 2024 at 06:36:06AM +0800, Inochi Amaoto wrote:
> On Wed, Oct 23, 2024 at 02:42:16PM +0200, Andrew Lunn wrote:
> > > Yes, this is what I have done at the beginning. At first I only
> > > set up the phy setting and not set the config in the syscon. 
> > > But I got a weird thing: the phy lookback test is timeout. 
> > > Although the datasheet told it just adds a internal delay for 
> > > the phy, I suspect sophgo does something more to set this delay.
> > 
> > You need to understand what is going on here. Just because it works
> > does not mean it is correct.
> > 
> 
> It seems like there is a missing info in the SG2044 doc: setting the
> syscon internal delay bit is not enabling the internal mac delay, but
> disable it. Now everything seems like normal: the mac adds no delay,
> and the phy adds its delay. 

That makes a lot more sense.

Thanks for digging into the details.

	Andrew

