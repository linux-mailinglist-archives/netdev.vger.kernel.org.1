Return-Path: <netdev+bounces-222219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8CB5398E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF38169868
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A993570CB;
	Thu, 11 Sep 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="evlfnTsm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3A340DB3
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609062; cv=none; b=HBvCr0c7lVtdhgGZQi4QAtmcQRmfYq34eLR6xtiEpOx6Hzxsbbk9BL//9uK8ztdqWhMuNCwUhI10IlCg/dBK3X0YvrVvOQoakTakQ/3wnMVuIMSSu26CsPgy5INNGTlYdlTTR9oFGQjvFjWnSy420x/K0zOsa5lo8bj5QQxOxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609062; c=relaxed/simple;
	bh=HzCWVh953toMMhvu/kS53y5Ai1jkmoHBkHDrjiJCh/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfHp4RE3rumScGczlKrxvPx5V/muFr1pAJl/BXtnFki04W75zn8IVC0rdI3CpHIRkXdHFbLacpu1xbqyzi//0er2nLTRqdLhgFuFjDxjmj7geIaS5sbsaNTW9pPiHAq1nRGLX6sjKchMRB8KPejz934SyVzIeOph1r9BIQCiRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=evlfnTsm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4/r5vOb6rjLtRXsHgB8Dbz9QOXS5afFABjBGVjI4Kj4=; b=evlfnTsmedZkEUJm4MvM7tUald
	WbxEhvvYREe5cvBeWqVM/GoFMN0t/xlXqF/rW8XBgsjxQgDhhhZt27GNfDfewJczKLERMhyXBDQc6
	h1t66z5pvLz+meqeJS5qQ6kMkXxGpxEI0o0XDdfEPX3HWea7YagCeeSizbEZeyfCMj/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwkP1-0086vD-9N; Thu, 11 Sep 2025 18:44:07 +0200
Date: Thu, 11 Sep 2025 18:44:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phylink: warn if deprecated
 array-style fixed-link binding is used
Message-ID: <815dcbff-ab08-4b92-acf4-6e28a230e1bf@lunn.ch>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
 <bca6866a-4840-4da0-a735-1a394baadbd8@gmail.com>
 <51e11917-e9c7-4708-a80f-f369874d2ed3@kernel.org>
 <bb41943c-991a-46bc-a0de-e2f3f1295dc4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb41943c-991a-46bc-a0de-e2f3f1295dc4@gmail.com>

On Thu, Sep 11, 2025 at 06:28:03PM +0200, Heiner Kallweit wrote:
> On 9/11/2025 8:34 AM, Krzysztof Kozlowski wrote:
> > On 09/09/2025 21:16, Heiner Kallweit wrote:
> >> The array-style fixed-link binding has been marked deprecated for more
> >> than 10 yrs, but still there's a number of users. Print a warning when
> >> usage of the deprecated binding is detected.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/net/phy/phylink.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> >> index c7f867b36..d3cb52717 100644
> >> --- a/drivers/net/phy/phylink.c
> >> +++ b/drivers/net/phy/phylink.c
> >> @@ -700,6 +700,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> >>  			return -EINVAL;
> >>  		}
> >>  
> >> +		phylink_warn(pl, "%s uses deprecated array-style fixed-link binding!",
> >> +			     fwnode_get_name(fwnode));
> > Similar comment as for patch #1 - this seems to be going to printk, so
> > use proper % format for fwnodes (I think there is as well such).
> > 
> At least here no format for fwnodes is mentioned.
> https://www.kernel.org/doc/Documentation/printk-formats.txt

I could be reading it wrong, but:

https://elixir.bootlin.com/linux/v6.16.6/source/lib/vsprintf.c#L2432
https://elixir.bootlin.com/linux/v6.16.6/source/lib/vsprintf.c#L2522

	Andrew

