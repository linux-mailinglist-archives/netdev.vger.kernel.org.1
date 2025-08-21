Return-Path: <netdev+bounces-215472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D314B2EB8B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE55A62EF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4D2D3EEB;
	Thu, 21 Aug 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w4X7xw2L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B32D3ED7;
	Thu, 21 Aug 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745126; cv=none; b=IxIpD5sB8qXbXG555I8u6EPD3QkGAqEdlrbX86OlN4descerlC0AnF4YMWqB0PbgNGpRZOv/Wpa00JRFJNG1DTibjKkMF4gmgXMnK4YxK65qf7ej8eKUrcq20J0L1j+r6l4kxH53WkaCp/MYK53j4//nGC/MuvNzImf4doSwpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745126; c=relaxed/simple;
	bh=ipnT4qyQdgKYvzDTgVarpM3gJWUVAc083y4UR3xajUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8SAyEECOShXEFYqFvMgQi7WVNH9XY+fmRmTurhOZ3NiXzNCtQXIkYm5W1+sDq0V5N/LYIX74gHaCeX3Q4cKD9DrvTiV2qrVzzXeHLUTYBMl/UvzRnceorX40Sn9XFIDOTSSjpJOlN3QjSuT51E3JhQ8jQ+QNmlz19dwVWxIyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w4X7xw2L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L95uriYwgXcsKp7IEjNA2NGmB2cdqeLOLMS6FJXClwI=; b=w4X7xw2LaPr+dk2WvxqBTc6Q03
	pu4QSk23JtL9o5A/IfmhNAfuIB92SZHp0Axa+9nhLgQZZwCWcOoR95925q95ZOyX7RGlvyHMRyCgM
	6peUojZrhuH4pu4R2FlltqYcr6pja2lyJnO8mU+AiK2C8WEkcAnoJ3pnkRnIPh4xXyD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uovVP-005Oz4-9f; Thu, 21 Aug 2025 04:58:23 +0200
Date: Thu, 21 Aug 2025 04:58:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <58d31b56-8145-419e-b7be-1fd48cfeda88@lunn.ch>
References: <cover.1755654392.git.daniel@makrotopia.org>
 <88e9ca073e31cdd54ef093053731b32947e8bc67.1755654392.git.daniel@makrotopia.org>
 <aKZg3TviLUDgKgLz@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKZg3TviLUDgKgLz@pidgin.makrotopia.org>

> > +	priv->version = le16_to_cpu((__le16 __force)version);
> 
> I've researched this a bit more and came to the conclusion that while the
> above works fine because all Lantiq SoCs with built-in switch are
> big-endian machines it is still wrong.
> I base this conclusion on the fact that when dealing with more recent
> MDIO-connected switches (MaxLinear GSW1xx series) the host endian doesn't
> play a role in the driver -- when dealing with 16-bit values on the MDIO
> bus, the bus abstraction takes care of converting from/to host endianess.

I agree that all MDIO bus registers are host endian, 16 bit. The shift
register in the hardware is responsible for putting the bits on the
wire in the correct order for MDIO.

> Hence I believe this should simply be a swab16() which will always result
> in the version being in the right byte order to use comparative operators
> in a meaningful way.

How is this described in the datasheet? And is version special, or do
all registers need swapping?

	Andrew

