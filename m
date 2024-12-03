Return-Path: <netdev+bounces-148299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61639E10E0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE9163F2A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732F42A8C;
	Tue,  3 Dec 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pe1aDSZh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EFB663;
	Tue,  3 Dec 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190231; cv=none; b=IJCVbkp2s1opSL9w/D5BEpA8J2Tb6D3o8GqH06dhuggbGdu6XVUUgP0dbiJU9w3xtGrTjpDdpUkUmL7mvLg3gFDHyBUcS2mCNHBV15pyPqhwd6Z6OL1XYeYIt2AksU82w50BpNnITuvlglWRYTBqTgM1/xOhlTIukaVjWXBZaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190231; c=relaxed/simple;
	bh=Karowkl6XPq6fTtg5fueN5Dd9W+1K/kC1QmwqCYYCmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxnkqL8zKkvVdwcQIEV5/fI3xzXTHjOijmeIWw/NJLQw2EeAtv4LJyAIh7f39db+/2b2NSFTwZgk25+AyLzZRkwcJqcBLHalSHKG/ZDzaiBMCWYM7mWeFyzM6NuPmW+KIzP7RgnoC3BagTUwxrh+a/JOQyjlyTt1qGMARWCIQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pe1aDSZh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+2BawypFFndD3SrGkOuaOBklERnQr8M/kRlTiV79YKA=; b=Pe1aDSZhV4jQUs1b8BbmvYSH21
	YpVo8jw8cVF6cIMafA0FBeyAKLNamFvRU98nDh6kvZOv3mbr/K4blghnVzE2dAEDg8M+iG+L5MPXY
	Ld94wp7cF4STHSj6GVnyCvp6cHRiavTXWt+kUBNb/sv1bjNLUPIhrnANNvuyfKYde40M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIHwo-00F1En-LE; Tue, 03 Dec 2024 02:43:30 +0100
Date: Tue, 3 Dec 2024 02:43:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
Message-ID: <9f2c8532-8e52-439a-b253-ad2ceb07b21b@lunn.ch>
References: <20241202023643.75010-1-a0987203069@gmail.com>
 <20241202023643.75010-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202023643.75010-4-a0987203069@gmail.com>

> +	/* We support WoL by magic packet, override pmt to make it work! */
> +	plat_dat->pmt = 1;
> +	device_set_wakeup_capable(&pdev->dev, 1);

It seems odd to me that there is no WoL support in this glue
driver. So i assume the core driver is doing it? So why does the core
driver not set pmt and wakeup_capable ?

	Andrew

