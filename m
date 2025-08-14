Return-Path: <netdev+bounces-213858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A7B27222
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EB516A3F7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7402B284B3B;
	Thu, 14 Aug 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eh4laDJH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14916281357
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211320; cv=none; b=RrlozEIWO+8uZK3rUXecgWrGl7/6FcDUmGC1dGr65g1fQr15EsxcMmhRezr9i1in/h+fqPZpHfJh7/tffGJiDMUOgvZp0fxcGUDC7cdueB/wmGRsa5PyBMwm9O24q+wlf+Q1TJeMCj+nAjwiAlemiiSVTO8bMf/pDdn1kVtQYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211320; c=relaxed/simple;
	bh=3+CO5GSNK05sFZm/hXSx1v7BZfTCSFMOevY9LLg3a5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oezu8brDr1Ys+uH0H1CAORNiTXSBhTzrbPnegLW84kYdV5WOouZ0R0AsxdgEP4xm3zBgoLWcA3EqA0rZa6TZRFa9715oT0r7Il/me17YH5cG+opjaSiDfX/6sjxCmpScp3o5NPfkbK271TDanQF3HCAJtSzOBgqwUjGZDZ7XI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eh4laDJH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YTVI1No4QA16QX1BBc+djTOsMW+Qo6gmJTgqHgYGrxU=; b=eh4laDJHDm2+JKMN9pu1ATYtJJ
	gvuKarJNouVbDvbblZUb5HlOYaeVAnkqvVg2z1n/uwQ9vmc7qpQd7X9ObU3FWEvPVpJSrlrrT7piT
	bzRc03Nu/K+7DwC7bl4UpCvUC7Ky9XNwS6wELKkV0QnpktZzY7SWeRIElAGvdIISdwMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umgGs-004km3-QA; Fri, 15 Aug 2025 00:18:06 +0200
Date: Fri, 15 Aug 2025 00:18:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, michael@fossekall.de, daniel@makrotopia.org,
	netdev@vger.kernel.org, jan@3e8.eu
Subject: Re: [PATCH v3] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <98215f6b-9e44-466b-a671-15966ad96a6b@lunn.ch>
References: <20250804105037.2609906-1-markus.stockhausen@gmx.de>
 <20250812143112.2d912cc4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812143112.2d912cc4@kernel.org>

On Tue, Aug 12, 2025 at 02:31:12PM -0700, Jakub Kicinski wrote:
> On Mon,  4 Aug 2025 06:50:37 -0400 Markus Stockhausen wrote:
> > Short: Convert the RTL8226-CG to c45 so it can be used in its
> > Realtek based ecosystems.
> 
> Sorry for the delay, looks like nobody who participated in v2
> discussion is willing to venture a review tag.. :(
> 
> > Mainline already gained support with the rtl9300 mdio driver
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
> > /drivers/net/mdio/mdio-realtek-rtl9300.c?h=v6.16
> 
> Could you replace this reference with 
> 
>  Mainline already gained support for the rtl9300 mdio driver
>  in commit 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver").
> 
> Are you okay with this change going to the -next branch?

I would say this goes via net-next. If it worked before, it was by
chance. I also agree there is a small danger of regressions, so
net-next would allow more testing before it affects too many people.

	Andrew

