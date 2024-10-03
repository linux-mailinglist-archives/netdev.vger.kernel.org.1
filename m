Return-Path: <netdev+bounces-131606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D04E98F018
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759971C21448
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77F199935;
	Thu,  3 Oct 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z5u2I7bB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA3199397
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961228; cv=none; b=nmDnaq9WH9klNM3L48Se/TwTjd+PG7rWUabOcLhD8Bf0GpiXc83ior/XFIJTsShEc21pvDxKMSnD4tiQpXtcTz70oxdMmyDIeITyYS5mud+sgTf6qHOcl+5k026i4lcdKZGaFW8OsufPxdKYO9UCPVROWONPN6o2Gx1ltSv4Ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961228; c=relaxed/simple;
	bh=C88iGpKYUdGcsFIxx5S3x+/1Xpki6PgMT/wV/CkWZIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPyJbGDycqvJO3eo+iysY1D2WG26nbsobmRUxdt6dYwrHYbUcE+EGTiQKsYhW2X8z06jWvnfuO6sI8Rvso5dYPYXY8xbSwDSrQ7DTPEWaKn5InsAkxnjI+X6oaxA/sYe5+eP4hDfLYzxjiiHeOdPYQphMOmZitCZgyRDDD9ifE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z5u2I7bB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gBhKSk/pz3Q1FSnthROMNE7S2y32Wo2UNC5oUXVfi8Q=; b=z5
	u2I7bBL+85jbKi2d1SVIRqZ3G9z3VoVkGG/uqrMBwID7h0xlJmzZy3mYYLJ98sk4ZWeNhSfANqyut
	ZarCp878HC/mZyrR/JUh07egfo3MNr58d1rZbnVctc8+CA/pO9TXVEav9PyNvHwL2M/wahWaTZtM5
	dGjCoN1eK9iycO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swLe7-008wtX-2b; Thu, 03 Oct 2024 15:13:31 +0200
Date: Thu, 3 Oct 2024 15:13:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: Switch back to struct
 platform_driver::remove()
Message-ID: <610fbb95-99ba-4b87-943c-8ef5beaee82b@lunn.ch>
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
 <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>

On Thu, Oct 03, 2024 at 12:01:06PM +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net after the previous
> conversion commits apart from the wireless drivers to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

