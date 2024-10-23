Return-Path: <netdev+bounces-138046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE69ABAD3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282DA1F244E0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700B1BDCF;
	Wed, 23 Oct 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aEgBdFd7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414E36B;
	Wed, 23 Oct 2024 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645753; cv=none; b=kPAz/0ShztyyubLHxEIiP/N/gOVwenzDMOrL3YQos6LD4sZpo01opfE5PmHtjWuJLJWyOZSHPqmDtIsWS7+WP9xUi9FDQ0/F4dbHh9vsE9Uqzmm/4POPj3Gk38hM2wwDqJkerm6zW2mkzw9arq2HrOwQQsKkOKwwqKm8x2UAaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645753; c=relaxed/simple;
	bh=eUyRW2nq2PM2+wK4ivE581lNhZuoS/1YaFjB9OcUsR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB+nL9Z5rdqLT/GMRKnyCOn+8LJ6WrSAOgfc/2xdwsC2ZkSjiaQXbSSlEPMd2SdxKNb0PpG268/F9tho/zVDUO8k56OC+yDos+f4fMfgIEVmwghtk7Z3b06FCZvKJ/qwpeusB+EnZHhU0EeY7VUzqSYnLSD5LQSmWPN6DBYBlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aEgBdFd7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Luc414sqlYd9r0hDusrFOUlGPmShpMBsFYhEzzPbPG8=; b=aEgBdFd7EvMykDpVG1QVfh49KR
	5u9QFtmR4J7sflyt1GIeWIFboSZRFtINEdsb08ZeGtSJbNlinAimtn8fpFRuP3MWjkp38q1HWNocG
	h8ynoSuwrb9LfOGoX/pw869W4udzciX9gh/6NHwhIGv5REsP6umt77XbQWTKsum6FfR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3Pro-00AtuF-B7; Wed, 23 Oct 2024 03:08:52 +0200
Date: Wed, 23 Oct 2024 03:08:52 +0200
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
Message-ID: <d691a687-c0e2-48a9-bf76-d0a086aa7870@lunn.ch>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
 <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
 <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>
 <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>

On Wed, Oct 23, 2024 at 08:41:36AM +0800, Inochi Amaoto wrote:
> On Tue, Oct 22, 2024 at 03:51:08PM +0200, Andrew Lunn wrote:
> > On Tue, Oct 22, 2024 at 06:21:49PM +0800, Inochi Amaoto wrote:
> > > On Mon, Oct 21, 2024 at 03:27:18PM +0200, Andrew Lunn wrote:
> > > > > It is related to the RGMII delay. On sg2044, when the phy 
> > > > > sets rx-delay, the interal mac is not set the same delay, 
> > > > > so this is needed to be set.
> > > > 
> > > > This is the wrong way to do it. Please look at how phy-mode should be
> > > > used, the four different "rgmii" values. Nearly everybody gets this
> > > > wrong, so there are plenty of emails from me in the netdev list about
> > > > how it should be done.
> > > > 
> > > 
> > > The phy-mode is alreay set to the "rgmii-id" and a rx delay is already
> > > set (a default tx delay is set by the phy driver). In the scenario 
> > > the extra bit is used to fix 2ns difference between the sampling clock
> > > and data. It is more like an extra setting and the kernel can not handle
> > > it by only setting the phy-mode.
> > 
> > This sounds wrong.
> > 
> > So in DT you have rgmii-id? You say the PHY is doing TX delay. So you
> > pass PHY_INTERFACE_MODE_RGMII_TXID to the PHY? It is not clear from
> > this patch, i don't see any code mentioning
> > PHY_INTERFACE_MODE_RGMII_TXID. Could you point me at that code.
> > 
> > 	Andrew
> 
> The phy on the board I have is YT8531, The config code is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/motorcomm.c#n868

This PHY should be able to do rgmii-id, so there is no need for the
MAC to add delays. We encourage that setup in linux, so all RGMII
MAC/PHY pairs are the same, the PHY add the delays.

	Andrew

