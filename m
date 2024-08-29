Return-Path: <netdev+bounces-123270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2D964591
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32897287FC4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC60198A3F;
	Thu, 29 Aug 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fZlBtz0u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033218C90F;
	Thu, 29 Aug 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936038; cv=none; b=jcG3uYHtIG9Si+SZ4BqkV8/+glqp3bEwD53QUPQf/uDhun2jqtlyvlcpxih1CxwrXTUO1INdr9nqc0LOFOFHQr4AtEXiqjZO8hnF4MuJLzHQ9a2Dq4yvvBvPbTEuz2nRIUNyeepDNgV3P3swgM3it5MA5jlKBOQ846851QlPos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936038; c=relaxed/simple;
	bh=akqIJGfZ+CetypzqT5PTT5s5nd221k+EbJF/II58Ww0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW/eP8sakjlqe/ilbWL9dRYjzOXxmpBApl8t9mmFm6pPHO/hDAyulYKZiws0/+qA5UE16wCcA6TyVqp1UWZy34yclzhn4a+iXf/qz2tVU4yET2ySuSFz5fYoIjanhTf3XUNY2AMaIupPj2fE4JmbOPTJ6dKvzB7hJRqc22Xr/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fZlBtz0u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RyhO41qp+dG0dTUrvC4C4vtOfFhfg4SkW6gXQuoHNog=; b=fZlBtz0ur0XOnyG0JveAWDP+Qq
	AQGhUSvOTWuqOgfBPmYNh4m2GSRqjXtqhCvqlXn82fMOw/68KaoBgZdaceGjWg1MsDPXg1gqdNf1p
	6+pr0tBnabZKUscYSKd7dH1FzhbRVwj4y/QG66VkKSCiDtiAlL63mMPy2MlVp9jVLOmI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjeej-0062BV-6p; Thu, 29 Aug 2024 14:53:41 +0200
Date: Thu, 29 Aug 2024 14:53:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v3 09/13] net: mv643xx_eth: Simplify with scoped
 for each OF child loop
Message-ID: <f486660e-2bef-41cd-929d-f8cfaa39f2e3@lunn.ch>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <20240829063118.67453-10-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829063118.67453-10-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 02:31:14PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating
> over device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

