Return-Path: <netdev+bounces-152625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8E9F4EB5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B2E1622BD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8F1F4E3D;
	Tue, 17 Dec 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tV6Fkrgl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDB1D63D1;
	Tue, 17 Dec 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447724; cv=none; b=aGaI+vtRZslcyZZwX/mR+iJoPYr8Da7JvjdM8EZjGKffreF+iZG9U9yu8AO4bNVfmWK2Kg/TjphiYGsX2vs1BuMwrQSa5DhrFGl+lZlMhTBKvCbJfByEKKb2EljdTfK0Li0HOhmg5e0D1JB2KkrYA3fgILI3kA6ntaMmmHHkYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447724; c=relaxed/simple;
	bh=JNZZ2aM0oMfi9c/mZXA49bLtyx1YSaXsrj/GnBaDn1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWWyJviBoF3A/x2GkG43ejlFZlOPvMQL2HQM+aKWyOlFQYb7LJeCye2oyACd2uVBYWL3mjOTyzdwd0HU/98e2wGYVHHbQb6Y0Q02VSxO5utJtjFtbl7zQ5/pDpL/MOg4d7uXSnVoUPVSGQdbffRrBkm0jwATtORoNK6jaKhQFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tV6Fkrgl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8TTtKmFbudORFQQwDyjlSKxxqapRe1+o+8mBW1wuAGo=; b=tV6FkrglzRzfZcPz3NeeiGkVKJ
	tRKPX2PWZZqmjMPH03fDqnV1mKTyCrwBzA18BLYSFKTbVGekMPmMC16HkrpFZ2sgzNGOPqtPI8GGc
	VnCH7Z1xpps+MxxmyFNY9FhFzuc2VZVyaWGzjMQTAsX8y81putQ6tt0cElQJ7qZuPfa8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNZ4p-000ytm-L7; Tue, 17 Dec 2024 16:01:35 +0100
Date: Tue, 17 Dec 2024 16:01:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>, Daniel Golle <daniel@makrotopia.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: avoid undefined behavior in
 *_led_polarity_set()
Message-ID: <73474cad-ebe1-4602-858c-825e72b0e3af@lunn.ch>
References: <20241217081056.238792-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217081056.238792-1-arnd@kernel.org>

On Tue, Dec 17, 2024 at 09:10:34AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc runs into undefined behavior at the end of the three led_polarity_set()
> callback functions if it were called with a zero 'modes' argument and it
> just ends the function there without returning from it.
> 
> This gets flagged by 'objtool' as a function that continues on
> to the next one:
> 
> drivers/net/phy/aquantia/aquantia_leds.o: warning: objtool: aqr_phy_led_polarity_set+0xf: can't find jump dest instruction at .text+0x5d9
> drivers/net/phy/intel-xway.o: warning: objtool: xway_gphy_led_polarity_set() falls through to next function xway_gphy_config_init()
> drivers/net/phy/mxl-gpy.o: warning: objtool: gpy_led_polarity_set() falls through to next function gpy_led_hw_control_get()
> 
> There is no point to micro-optimize the behavior here to save a single-digit
> number of bytes in the kernel, so just change this to a "return -EINVAL"
> as we do when any unexpected bits are set.
> 
> Fixes: 1758af47b98c ("net: phy: intel-xway: add support for PHY LEDs")
> Fixes: 9d55e68b19f2 ("net: phy: aquantia: correctly describe LED polarity override")
> Fixes: eb89c79c1b8f ("net: phy: mxl-gpy: correctly describe LED polarity")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

