Return-Path: <netdev+bounces-62125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFC825D13
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 00:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43713284F44
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41047360BD;
	Fri,  5 Jan 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ULxoohPT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A765360A4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EcfCznjjYinqcWS7LH1wVHQoYGs871InSj/P23AGb08=; b=ULxoohPT3vcXJQt/9UzlD79opR
	yrNIKI/ADyjuaDfPUuUt1S2uhkmspGFrnuFWvPDQzbdy+21Wm438vJOJS31CUBmYgwO4Py/g1+FFr
	0EfJwYEvO8BgL22hj1oqOh0KiqLPr//hwq/Moybdj2bfq90IIUJo8Lalnse0APrz5fsw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLtPK-004Uhs-I7; Sat, 06 Jan 2024 00:15:18 +0100
Date: Sat, 6 Jan 2024 00:15:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and extend
 struct ethtool_eee
Message-ID: <53909c11-825a-489f-822a-dd4829dc8041@lunn.ch>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
 <a044621e-07f3-4387-9573-015f255db895@gmail.com>
 <f704864d-56bb-4ff4-933d-8771d0bb6c19@lunn.ch>
 <8bfd2b95-2c73-4372-bf63-0c6ab7cd03c8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfd2b95-2c73-4372-bf63-0c6ab7cd03c8@gmail.com>

> Looking at the ethtool EEE ops implementation of the relevant 16 drivers i see
> quite some fixing/refactoring need. Just look at igc_ethtool_get_eee():
> 
>         edata->supported = SUPPORTED_Autoneg;
>         edata->advertised = SUPPORTED_Autoneg;
>         edata->lp_advertised = SUPPORTED_Autoneg;
> 
> This doesn't make sense at all, this function never worked and apparently
> nobody ever noticed this. Maybe the author meant
> edata->supported |= SUPPORTED_Autoneg, but even this wouldn't make sense
> for an EEE mode bitmap.

Yes, i noticed this as well. EEE is not too well defined, but this is
wrong. Since it never worked, just deleting this is fine, and leave it
to Intel engineers to set actual bitmaps.

> I'd prefer to separate the needed refactoring/fixing from the EEE linkmode
> bitmap extension, therefore omit step 3.
> 
> Steps 1 and 2 are good, they allow to decouple struct ethtool_keee from
> ethtool_eee, so we can simplify struct ethtool_keee and reduce it to what's
> needed on kernel side.

I would not do too much refactoring. I have a big patchset which
refactors most of the phylib driven drivers code for EEE, removing a
lot of it and pushing it into phylib. Its been sat in my repo a while
and i need to find the time/energy to post it and get it merged.

    Andrew

