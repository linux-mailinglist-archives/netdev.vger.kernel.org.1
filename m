Return-Path: <netdev+bounces-122313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712C960B20
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61C9280938
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF31BB6B7;
	Tue, 27 Aug 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MpYyPnlb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E41BA862;
	Tue, 27 Aug 2024 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763203; cv=none; b=qBFDFgzdnCufP8q9LCTRvmPj8TDdsqjDbMrIxTk8Z5Me188qGRkAT6DV5zRjs8PkL86c4ionBZGfejO9laoonPT4v1fIQoOqHJuWHJRH/u1UL6Mv+0B22IIp10EUSnYvp8rXn28gLJA7vG3Z2XrnR9aBXLQScvEDctkb9IVgQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763203; c=relaxed/simple;
	bh=F7xy/xy4elXDt2+yN/2c2vqWIunm9L16b76gNRkDuR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfSgB4SdrVCC0BZ1EPg5cr4zGpN+1nl0jQENiofy/T/LM3tfKMPOw8p3G3GHGMVbgBOmjQK7WgcxLAsl+o0Ac6/4V/xRik1Uvjm46C+h0Lt/fqEb+WBGW1kGtarkSjLZuW1UStEN0jHvC3mX2mljdrPz2F2NbGQJacY8BPMi3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MpYyPnlb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vrPxkN5qo38VBrMAk2CnFGULGgTtH0FEYGlABHo3oNU=; b=MpYyPnlbEy/2mqAR9iE/At5+/l
	HQV5EOceQmJDl6G2svDwINba443IzDmRVzCE+98K/Sj/Bzuy5brCs5OCyxiniVUMol1cRB/NzpGtx
	B8REDAbuExMz3LDcByylXl+tR7VlAHgxZb36vUetos2ntBunFKsb7AnnK6hxQRYbgscM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sivgx-005onN-ID; Tue, 27 Aug 2024 14:52:59 +0200
Date: Tue, 27 Aug 2024 14:52:59 +0200
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
Subject: Re: [PATCH -next 1/7] net: stmmac: dwmac-sun8i: Use
 for_each_child_of_node_scoped() and __free()
Message-ID: <804da030-ff7e-4bf2-84f8-2784fc93e9e8@lunn.ch>
References: <20240827075219.3793198-1-ruanjinjie@huawei.com>
 <20240827075219.3793198-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827075219.3793198-2-ruanjinjie@huawei.com>

On Tue, Aug 27, 2024 at 03:52:13PM +0800, Jinjie Ruan wrote:
> Avoid need to manually handle of_node_put() by using
> for_each_child_of_node_scoped() and __free(), which can simplfy code.

Please could you split this in two. for_each_child_of_node_scoped() is
fine, it solves a common bug, forgetting to do a node_put() on a early
exit from the loop.

I personally find __free() ugly, and would prefer to reject those
changes.

	Andrew


