Return-Path: <netdev+bounces-193519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72BAC44C8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D04189DE51
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA723FC74;
	Mon, 26 May 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T879ss70"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322C1F1906;
	Mon, 26 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294550; cv=none; b=aYLRQ17a51wpzVNxka+otNwsbHlzysLl/jbgE6r+N8vMd7hDgBXxWXtVDanCyHulPs1sGwARg2zGOgivKsQzk+sHlQ8MInw/YB8KkDM3oa1n5mP8xsbeDTGWiVRtOtseqEC8Va+N8OTurxcLJaugFNc5zTOgnGUGIlB/CI6vDjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294550; c=relaxed/simple;
	bh=AEB3sdJFEe6kq1nhAoqoXatxYCvpL//JbaGJhy7u9NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpWXaF41FuTq4tqAD4f4yAB0vP5yLW8q+JFKFEoeWY+pb8hEUcU2pNH5dHDknr8sMXwYDrT4KORcAc4scvLi0erKVN5Li1On/Wqhg58le0rAozq1Qjj42NnN5pgcMVzvFxSJZsgbnpkv1wfubAcxMM49vwyTvz/Sjrk5FKlPTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T879ss70; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kk/X2iMwkZ9QRWnt0o+BzHTjRbwP4NWs5dzU8KffOaA=; b=T879ss70/t9wA4mWiMI6mNI8BN
	UsnlixureesQqmV8uikvpnWFL2TZSc/FkVkD80DuZqSV07g5JosbMXOrJsiurr98FpjN+fcIdl4+2
	+RrySl2KnWyJagD2A3mOAbo80nAx0wASVHs7OeWfsVASTy0ha7jq2Nl7E9IdsODflT7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJfH0-00E1mE-Dn; Mon, 26 May 2025 23:22:18 +0200
Date: Mon, 26 May 2025 23:22:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
Message-ID: <5b7bf54e-4838-48b3-a357-70f117674523@lunn.ch>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-2-james.hilliard1@gmail.com>
 <a2ac65eb-e240-48f1-b787-c57b5f3ce135@lunn.ch>
 <CADvTj4rO-thqYE3VZPE0B0fTTR_v=gJDAxBA3=fo501OL+qvNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4rO-thqYE3VZPE0B0fTTR_v=gJDAxBA3=fo501OL+qvNg@mail.gmail.com>

> > The normal way to do this is phy_find_first().
> 
> Sure, but there are problems with that approach here.
> 
> The initialization sequences are rather different and the devices
> won't be visible on the mdio bus until after they are initialized.
> 
> The resets will be specific to either the AC200 or AC300 so we
> need to choose the correct PHY based on the efuse value rather
> than a mdio bus scan to avoid a circular dependency essentially.
> 
> AC200: i2c based reset/init sequence
> AC300: mdio based reset/init sequence

O.K. so you need to post more, so we get to see the complete
problem/solution. It seems to me, AC200 and AC300 are not compatible,
so should have different compatible strings. That might be part of the
solution. But it is too early to say.

	Andrew


