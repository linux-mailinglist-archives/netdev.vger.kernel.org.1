Return-Path: <netdev+bounces-121756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FB95E64D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9941C2096F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0EB1C3D;
	Mon, 26 Aug 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RdzlhAow"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FA635;
	Mon, 26 Aug 2024 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635684; cv=none; b=dqdE6HbeHO+VJWP4zJJMsrTfvLcAr9BzjW+xwGe6Auwz/R5oN3zYaA+0I1Difd850QHUPvGxzC8+BApW9xsc3d47o2Y+sJcHPrB+DVh5NOHkZmGtZ5+pwi7Tje74ZtPpbiaczEadDoMZpGQzWZF2a0ca3nKNllfcDHSYAcxa5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635684; c=relaxed/simple;
	bh=jQnMKCbw9cPpTGeYbEVRSB/TIo0K0/ZxJM1l5LI+lHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm+wB6zClh5QUZ5eC2KLlgGGK9E+rY5OLWpjYV/zpMX/sMOqwCLCOWaFQfiNrxDsus5ZivHS50/3S7Mvyt8bLTVtg6SduUpRqE4GbrBpAahqJ/Vc9mGDc0thDMDCOBnx+28tVF8CASmSdXU0Ma0SuEF01ty0Uyj6W+wjlTwP3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RdzlhAow; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wq6I1n2i+4v9oMF3fvNgMxvVPbr+6L9jXgJYIKYQaP0=; b=RdzlhAowBvRHgYGWIQ2wSeTj1v
	THRLFU7uGND0JkqHSpcXUcmNRsSis6mQ+dvZ9VNf/mLgj+LL4EszYIgLly07BbYXkw+7GnUBypuaK
	zad+Q/TSN3JqLSYR4c4boYJCm7p/KbTcZj3F7WBNgaA+5LTGlDFIN5iZK8CFxF2atQKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOWK-005fAA-HZ; Mon, 26 Aug 2024 03:27:48 +0200
Date: Mon, 26 Aug 2024 03:27:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com,
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
	f.fainelli@gmail.com, olteanv@gmail.com, o.rempel@pengutronix.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marex@denx.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Message-ID: <993d4f12-3620-4223-a50a-f1f50152c837@lunn.ch>
References: <BYAPR11MB3558F407712B5C5DFB6F409DEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
 <1411a2ff-538e-40c2-86ef-7b6c628b478b@cern.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411a2ff-538e-40c2-86ef-7b6c628b478b@cern.ch>

On Sun, Aug 25, 2024 at 09:18:47PM +0200, Pieter Van Trappen wrote:
> On 8/24/24 01:07, Tristram.Ha@microchip.com wrote:
> > KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
> > shares some registers and functions in those switches already
> > implemented in the KSZ DSA driver.
> > 
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> 
> Thanks to me the naming is somehow coherent now. I've quickly tested it with
> the KSZ8794 I have available to check for possible regressions and there's
> none I could see. So *not* tested with a KSZ8895/64; I don't know if that
> merits the tested-by tag but feel free to add it if you like:
> 
> Tested-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Regression testing is always welcome. Also it gives us a name of
somebody who we could ask in the future to do further regression
tests, which you can always say to, sorry i don't have the time.

	Andrew

