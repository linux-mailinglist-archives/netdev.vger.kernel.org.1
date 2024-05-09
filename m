Return-Path: <netdev+bounces-95134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01468C17A8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9591C21DD5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFF7CF16;
	Thu,  9 May 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vBndXtjF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0D4C618;
	Thu,  9 May 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287032; cv=none; b=BlNAaMDx0ORVOr+50Bxa3YKMkqYvPlHUb62yKDbDf8gJUbsKUqbHCS1jhRfvydme8dujdJ51hMgiwvxfz8rX/O/ZsoyWOiKbaEwpQJ3Id15b7t25xfYv4ZL7j7AKv9FR+Lm57Grzrx6YvLG4voIzcaKLL9Dej2Ux8/prHlAPtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287032; c=relaxed/simple;
	bh=x7LhucK821k3vSDngfFbnMiXnOtN4rPhBuqtaKRTceA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbPH7pOY0F6ynYZFbEfzCBWlbM0JuhY9M3e6iLi99FGDeM1/FQodEY5f0eKWbgU8Tj/PFzrZk0dzVRApnrY4Z4AK6YbJN+0q3CZcOL38XDw4pat2wrJrGVRbC7upNh7gOTyZXiqszggZdm7m0LRp66w+n9A9lFuCCUNM8D6lUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vBndXtjF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Ts0hQ/+xW7g60neUMYTCGyqDcd3REU5NHScQ5L3JXqY=; b=vB
	ndXtjFxiQyjGyXFPOPqJvLSuYj1dZgBZBtGlR0d534n0nhdN/FqezzvTA6FSRMOSooXTH6Mw2mv+F
	krBi5WwH8hWLFR/pPsDeq6MRSc/Z3lUJhDrf8OTVPellNItjSPBqaRgngM4K6lIldyp2KxQdeufcG
	ImLBwCUicnKLxqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5AVd-00F4zH-4P; Thu, 09 May 2024 22:36:57 +0200
Date: Thu, 9 May 2024 22:36:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
Message-ID: <98259c2f-b44a-467e-8854-48641984e468@lunn.ch>
References: <20240509121713.190076-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509121713.190076-2-thorsten.blum@toblux.com>

On Thu, May 09, 2024 at 02:17:14PM +0200, Thorsten Blum wrote:
> Compiling the m68k kernel with support for the ColdFire CPU family fails
> with the following error:
> 
> In file included from drivers/net/ethernet/smsc/smc91x.c:80:
> drivers/net/ethernet/smsc/smc91x.c: In function ‘smc_reset’:
> drivers/net/ethernet/smsc/smc91x.h:160:40: error: implicit declaration of function ‘_swapw’; did you mean ‘swap’? [-Werror=implicit-function-declaration]
>   160 | #define SMC_outw(lp, v, a, r)   writew(_swapw(v), (a) + (r))
>       |                                        ^~~~~~
> drivers/net/ethernet/smsc/smc91x.h:904:25: note: in expansion of macro ‘SMC_outw’
>   904 |                         SMC_outw(lp, x, ioaddr, BANK_SELECT);           \
>       |                         ^~~~~~~~
> drivers/net/ethernet/smsc/smc91x.c:250:9: note: in expansion of macro ‘SMC_SELECT_BANK’
>   250 |         SMC_SELECT_BANK(lp, 2);
>       |         ^~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> The function _swapw() was removed in commit d97cf70af097 ("m68k: use
> asm-generic/io.h for non-MMU io access functions"), but is still used in
> drivers/net/ethernet/smsc/smc91x.h.
> 
> Re-adding the previously deleted _swapw() function resolves the error.

This seems like the wrong fix.

commit d97cf70af09721ef416c61faa44543e3b84c9a55
Author: Greg Ungerer <gerg@linux-m68k.org>
Date:   Fri Mar 23 23:39:10 2018 +1000

    m68k: use asm-generic/io.h for non-MMU io access functions
    
    There is nothing really special about the non-MMU m68k IO access functions.
    So we can easily switch to using the asm-generic/io.h functions.

So it rather than put something back which there is an aim to remove,
please find the generic replacement. This _swapw() swaps a 16 bit
word. The generic for that is swab16().

I'm also surprised it took 6 years to find this. Has something else
changed recently?

    Andrew

---
pw-bot: cr

