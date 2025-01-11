Return-Path: <netdev+bounces-157442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD0A0A517
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE6D3A2BA7
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01B1B0425;
	Sat, 11 Jan 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LGhyUz0H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCE18CBFE
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736616673; cv=none; b=rFUsg9XbLPD6zvAsnF9JTxTWrvisR47A5PMiw0P93kBMJrppUNzVp20aRohhV+gNsBkXRy7IMWGj8tbqXCitv9cJk5Z/0+wPfIhaBJyMYgG0vaU/TEjsolL7Bp+z/fOMENp/YwiUwLbBhuGPUAiGc9wEZ9E1IWvu90+Zlqc0n4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736616673; c=relaxed/simple;
	bh=TmuPaALJ/p5THvc1u9dIk7CBxooi6Nxnmxh7E7QUL98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyZJMyjFO5Z+/lrW3Gn0RmIcIou/jm27mnd5+YGn9qhQaPrsYq34+9fCTJHisZ+Ppfab9WmeHPwZGFC3icPJL1ucBqIpisrcCG+nRAamAgiJggOCV/xyIUlH2ooynieHZofy5ZGwubW4wE/gl9y5YxoG8GOWQWeqEZVV/DUM98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LGhyUz0H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TCDbmZY35ZhNIILYWGXO0BX/ZiJ5OdoE6UvtVduSN4M=; b=LGhyUz0HFpIIy1mxgd3zTrZ40a
	bI4ZaXl5gu1Pvi2PsL83Hsbp9F7fyBz53N6uSNKjKKijyn8+J8er/r3nyd6SjQ6fHfM2hNhrRcAb5
	kWGjxdNRFVX3CFgKpUbxoXpgHKdIXWVphX5CEVc8puxETZNjvIozHyyaqUf9h+eFEtls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWfKC-003aKg-Ny; Sat, 11 Jan 2025 18:31:04 +0100
Date: Sat, 11 Jan 2025 18:31:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
Message-ID: <be4d2a28-3618-451f-ab08-432489360410@lunn.ch>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
 <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
 <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
 <0212f9e8-8f60-461b-a7fe-bd4054f3689b@gmail.com>
 <Z4KKi2WxSrben9-Z@shell.armlinux.org.uk>
 <b1d56e22-5bbb-4881-abc1-6f8832bb575d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d56e22-5bbb-4881-abc1-6f8832bb575d@gmail.com>

> > I disagree with some of this. Userspace should expect:
> > 
> > - read current settings
> > - copy supported modes to advertised modes
> > - write current settings
> > 
> > to work. If it fails, then how does ethtool, or even the user, work out
> > which link modes are actually supported or not.
> > 
> > If we're introducing a failure on the "disabled" modes, then that is
> > a user-breaking change, and we need to avoid that. The current code
> > silently ignored the broken modes, your new code would error out on
> > the above action - and that's a bug.
> > 
> OK, then I think what we can/should do:
> - filter out disabled EEE modes when populating data->supported in
>   genphy_c45_ethtool_get_eee
> - silently filter out disabled EEE modes from user space provided
>   EEE advertisement in genphy_c45_ethtool_set_eee

Ideally, the kAPI should work just the same as normal advertised
modes. The read API returns what can actually be used, and write API
expects a subset of that.

But maybe we have too much history and cannot enforce the subset
without regressions, we just silently ignore the extra modes?

It might be too much plumbing, but it would be nice to include an
extack saying some modes have been ignored? I _think_ extack can be
used without an error.

	Andrew





