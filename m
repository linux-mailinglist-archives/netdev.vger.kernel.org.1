Return-Path: <netdev+bounces-131605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47598F017
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483111C21161
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC2186E40;
	Thu,  3 Oct 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1N44NjWk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281741487D5
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961174; cv=none; b=QKs6Dx+J/kR+eCMtliAYg7vsqBNqL/+yyJH2fqAzESapfCHCvXh2QFkXfxLd4CcdTntUwa/5InHpgOIk8xr5gwdq34jPkiUxM6BEmAxC0X8FdDoDXOXTwwHPDtWnLp6qxjvy+ghb0H7p4ia9+UtdsbwOeqkJyjzAOarsucJe4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961174; c=relaxed/simple;
	bh=LBpSrOObuxj4ZIdrEom63KK/SOB7Gg1K0Aw1do2lMYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3wl00fKjLOIE/9NyTILS6uHLaunbodHxp0qUbU2QAJfGMmQdX4uRxLCdIHPkaic6l0DXwLolLRYz6GwF0G2ZQfNMXs2Y3MqHieXglR+q/BR8ClCFBXlT5lC4bvNPWaHDcMguNnlhzbqFdlUjvJNZ3H6D2B7RMtJCvpkLVImE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1N44NjWk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Nbze640/QdqfpR0JGvWRsI+tUbGtbKc5UZhuCwbnARs=; b=1N
	44NjWkT4yVPOxhDZa6OXAyrDOqGbofgzacSwvDsI4vsiwT7mNQcIDJuLehlyjDKeB8o/y2OpfjGmy
	j6+kh3FwDQAUwV1+WaeeLCpC1FiTyGGufCTiaSehlLEiMMGE9ynx3FcpYMcMDIgT7kIppWqpej90D
	HgIj2Q1x6PAgvOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swLdM-008wsm-2I; Thu, 03 Oct 2024 15:12:44 +0200
Date: Thu, 3 Oct 2024 15:12:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: mdio: Switch back to struct
 platform_driver::remove()
Message-ID: <d3adbc38-8465-4f61-a613-976b3eacbc4a@lunn.ch>
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
 <0b60d8bfc45a3de8193f953794dda241e11032a9.1727949050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b60d8bfc45a3de8193f953794dda241e11032a9.1727949050.git.u.kleine-koenig@baylibre.com>

On Thu, Oct 03, 2024 at 12:01:05PM +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net/mdio to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

