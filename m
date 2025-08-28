Return-Path: <netdev+bounces-217785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E7B39D50
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9299E7A7A84
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DAE30F7ED;
	Thu, 28 Aug 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mY8/R/zy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD71B0F1E;
	Thu, 28 Aug 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384220; cv=none; b=NNBExxx3kIlqh69zInZyDVuDqocd+hGOmel0IqgYUbzuaXBpYy2uiAxKksYdNxYacurZd5eB9asVdKsOFwfQKc8MXijQMAdUfQBfWI8L5p87vyG8oC8Hb4c5H9sZs8hO9ZEOhB1CsRQ6Aeaj70QR5dgNJbmFWdoq8pZPx79MdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384220; c=relaxed/simple;
	bh=uaVJpAMdPWrV9NtuD8VA/dcwu9Kie80TwIuBdrhSujE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DktvSIqlxi+KQJaFu4/KtrHdty3rbsGZ/hC3o006KGAnKsHs/+CyjeMjwBlds7ObCRqV7R7BCCb1FBpQg6okPloIo+vOUjMl9VmIyTxm+bj5AdJlx6PLfJ92YPyBlMu65YruxdF/ZsFr9IlG0mhxcH/q3PXyler/MQqO6MpAnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mY8/R/zy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gKv9reSnTFal7lXW3j+/yEjJ6IbCvDAdZ9nuha3XXs0=; b=mY8/R/zy6i0Kh4sWhO7Di3jfhe
	O1fXCoavC+3xOR1GDmIBwvtHBmXI6uVfOS3xgp3smq4SaVR5AqwjFaeGah/392dLciS56KV4Gd2Nn
	PlnfiS5M3FZfnoHd71YVXyepEf4+dQv4LBgbqlxmzAHIIOflkl7Jd6d+jZW8tY/TcUIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urbl7-006LUg-DP; Thu, 28 Aug 2025 14:29:41 +0200
Date: Thu, 28 Aug 2025 14:29:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <ecd74582-6d65-42eb-999d-05dbfc898370@lunn.ch>
References: <20250826-net-k1-emac-v7-0-5bc158d086ae@iscas.ac.cn>
 <20250826-net-k1-emac-v7-2-5bc158d086ae@iscas.ac.cn>
 <193454B6B44560D1+aK-x9J2EIB5aA9yr@LT-Guozexi>
 <6c221dcf-4310-4e31-b3e8-a8a3b68c3734@iscas.ac.cn>
 <D1B3E8CA05947AC1+aLAT40m4VCtlL2Yk@LT-Guozexi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1B3E8CA05947AC1+aLAT40m4VCtlL2Yk@LT-Guozexi>

> > You tricked me! There's one more review comment below :P
> Haha, You are so cute, Vivian.
> I'm surprised you were able to find it, because I went back to check after
> writing the last comment. So I wasn't able to find the final one myself.
> 
>                 - Troy
> 
> (This really is the final one this time.)

A nice illustration of why trimming replies to just the needed context
is a good idea.

Andrew

---
pw-bot: cr

