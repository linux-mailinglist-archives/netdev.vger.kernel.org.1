Return-Path: <netdev+bounces-138222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01A9ACA55
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A21B22E69
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F31AB6C7;
	Wed, 23 Oct 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W1xL2f/0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20221AA795;
	Wed, 23 Oct 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687356; cv=none; b=brO2p04i0imrsiuEMgh0bhTotthsV3CQlBH/9J6yOHwy1Usuj3dT2VDAD63SNbUYyV+Y1niSNfwR3Q3rs/GtidZf5uRqas0/utQWaWYE99TyR5Tx+LVuFYUO/ksANc9DSAM/Ab9zV39WONbw+aH7uXxUHZMVWaGsbQ5dGCQ/Sbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687356; c=relaxed/simple;
	bh=8FMQ2U+Yx5+4JJKuH97KbfWiDSrVmukhFmnAsljLTQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPFuHg5UyT2yDw5TuzEKxTpd2lxcNFOGnemJh7Qqm1g3I3Ef24NX70AdI7R8E/ozrp3wa2dyxaxLxbtz9sGSbyu2Jk6p7xs8OKhNI7YprDJ+JmjxTgjBOd4HtT2I497+uubyUcT/OEuGSRDSCjgCYGco6Cb+BHldMSjqgxq9qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W1xL2f/0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ECkcLoi6nvRMZ6z485UUavRz1TW3AZP1oqqzMx62oAc=; b=W1xL2f/0ZkdIvu3RBvN4VPj7s8
	HWt25pPkWMTIeb8bKcnp5OzNWA++tl9VhjKT8RWGaFy7Um+O7/tUkG3clzs+mRlae+X3em5cuzPtq
	ld5s5T9R32kTtlewbDVrG+876rR8aV3XkHGKs2tR2LwwMS01GKyGXeEN/W7MS+Zs0g90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3agq-00Axlr-AW; Wed, 23 Oct 2024 14:42:16 +0200
Date: Wed, 23 Oct 2024 14:42:16 +0200
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
Message-ID: <79f9b971-8b3f-4f31-ab42-42a31d505607@lunn.ch>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
 <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
 <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>
 <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>
 <d691a687-c0e2-48a9-bf76-d0a086aa7870@lunn.ch>
 <amg64lxjjetkzo5bpi7icmsfgmt5e7jmu2z2h3duqy2jcloj7s@nma2hjk4so5b>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amg64lxjjetkzo5bpi7icmsfgmt5e7jmu2z2h3duqy2jcloj7s@nma2hjk4so5b>

> Yes, this is what I have done at the beginning. At first I only
> set up the phy setting and not set the config in the syscon. 
> But I got a weird thing: the phy lookback test is timeout. 
> Although the datasheet told it just adds a internal delay for 
> the phy, I suspect sophgo does something more to set this delay.

You need to understand what is going on here. Just because it works
does not mean it is correct.

	Andrew

