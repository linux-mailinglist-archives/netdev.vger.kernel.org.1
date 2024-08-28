Return-Path: <netdev+bounces-122812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9740962A4B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51061B212B4
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801A18A6B9;
	Wed, 28 Aug 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cL7IaxrU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5F19DF48;
	Wed, 28 Aug 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855551; cv=none; b=ac3XGBsdRnS3lzLhfTt5q24PMOXge2qSiM6TY7RTXkmdgbq/0UalOqkpBGPuS2Pnaj6i8/HOY+U6AnLXxPtTN4kjn7/LsXb/d4C+fJarnix59d9CRKI8iJgnLvoGwgjP8q/K3nkSVSl4KMCzofbCm5VQCQXDJWxjt9rWe+IeeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855551; c=relaxed/simple;
	bh=bT/aBCNB9QqhKwNipP1APafK9kmjMXK56AvUxp8ZDYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP0Rq0gR9fYJH87igeAB6ob44mp3oQw7TsA9vsqALdRbcXe+qz0yFpWkW/KQCyWqKJe+441y+sE/DszFTOD/15kiPJTOYKDRksJqjSxMCFun2ET2MBf2Aw8F7dtGFn30KmFUjbEY0W/46DEJR/c8C+SOYa6imypz+ohIou0Dxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cL7IaxrU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=upv6Gct3p8vF5m+JDKyEPBGa87pA4XfIxFiex6ZYkpc=; b=cL7IaxrU5cZh/nXivzyQcjY6tA
	XLrNAY64flw9b0tGm00VVgr5hGfVQ+lFFGHfwQnc4GKOkxmKDZ0p2QTCiVbb72Ap9/U8uYIz9O0L3
	YkoXOJ9v5yG7J27hqGhyMn5kpKffKOsGcwMH+EdrIHmTK+ws2GbfwH5CZkM5h76tVwrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjJiQ-005wX9-0I; Wed, 28 Aug 2024 16:32:06 +0200
Date: Wed, 28 Aug 2024 16:32:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, krzk@kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH net-next v2 00/13] net: Simplified with scoped function
Message-ID: <6092e318-ae0c-44f6-89fa-989a384921b7@lunn.ch>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828032343.1218749-1-ruanjinjie@huawei.com>

On Wed, Aug 28, 2024 at 11:23:30AM +0800, Jinjie Ruan wrote:
> Simplify with scoped for each OF child loop and __free(), as well as
> dev_err_probe().
> 
> Changes in v2:
> - Subject prefix: next -> net-next.
> - Split __free() from scoped for each OF child loop clean.
> - Fix use of_node_put() instead of __free() for the 5th patch.

I personally think all these __free() are ugly and magical. Can it
somehow be made part of of_get_child_by_name()? Add an
of_get_child_by_name_func_ref() which holds a reference to the node
for the scope of the function?

for_each_available_child_of_node_scoped() is fine. Once you have fixed
all the reverse christmas tree, please submit them. But i would like
to see alternatives to __free(), once which are less ugly.

	Andrew

---
pw-bot: cr


