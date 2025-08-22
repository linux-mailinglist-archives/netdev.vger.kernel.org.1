Return-Path: <netdev+bounces-215876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6875B30B8A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDDB66626
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921A1B808;
	Fri, 22 Aug 2025 02:06:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007A6D1A7;
	Fri, 22 Aug 2025 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828379; cv=none; b=FSmZ7z4h/oAoXxZJRk/20ID3E5P2+fkaaDXJ1d3rtW1RXH1xsPZ85NqgjLxKX5DPe/DLt30JROEca34iKwcxshgDaNQj7w+Pw4YfwU7X/WTZgu4iaFAe6kOdv0Yi3tG/yMNRZhyuUeoYC4WTRo/5gC5Y7Q1mSkrOPsytOSvS4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828379; c=relaxed/simple;
	bh=yZcpHu7c14dI6M3MOx8/jD27hzLBV1cYSzk3rdI0WvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwJ/94k+5jZ8QbGbOH7seeZoIp9qyuLAc45/oY8DtUWIRifNsvfVeKRq1te3rQZ1KU0YMWnhF7tRGbyJ1H4egHbzLraxyXIC2fJ1NJfmFmGWFpXAYgRFer1x8Pu79Xhz9v2ZVn9arKsYtBRiFGU243ST4iPIxmRg8l3sJixNzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upHAN-000000003bE-3f6W;
	Fri, 22 Aug 2025 02:06:07 +0000
Date: Fri, 22 Aug 2025 03:06:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Xu Liang <lxu@maxlinear.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: mxl-86110: add basic support
 for led_brightness_set op
Message-ID: <aKfQjLVRtZKo1rYZ@pidgin.makrotopia.org>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
 <73c364ee-2712-4b95-a05b-886c3e4c4e15@lunn.ch>
 <aKXOzyAg728qcylz@pidgin.makrotopia.org>
 <20250821173620.367ce05c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821173620.367ce05c@kernel.org>

On Thu, Aug 21, 2025 at 05:36:20PM -0700, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 14:34:07 +0100 Daniel Golle wrote:
> > > > +	if (index >= MXL86110_MAX_LEDS)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* force manual control */
> > > > +	set = MXL86110_COM_EXT_LED_GEN_CFG_LFE(index);
> > > > +	/* clear previous force mode */
> > > > +	mask = MXL86110_COM_EXT_LED_GEN_CFG_LFM(index);
> > > > +
> > > > +	/* force LED to be permanently on */
> > > > +	if (value != LED_OFF)
> > > > +		set |= MXL86110_COM_EXT_LED_GEN_CFG_LFME(index);  
> > > 
> > > That is particularly complex. We know index is a u8, so why not
> > > GENMASK_U8(1 + 3 * index, 3 * index)? But set is a u16, so
> > > GENMASK_U16() would also be valid.  
> > 
> > I chose this construct to avoid reusing the macro parameter as gcc would
> > rightously complain about that potentially having unexpected side-effects.
> > 
> > Eg.
> > 
> > #define FOO(a) ((a)+(a))
> > 
> > Now with var=10, when calling FOO(var++) the result will be 21 and
> > var will be equal to 12, which isn't intuitive without seeing the
> > macro definition.
> > 
> > Also using GENMASK_TYPE would not avoid the problem of macro
> > parameter reuse.
> > 
> > However, I agree that the macro itself is also weirdly complex and
> > confusing (but at the same time also very common, a quick grep reveals
> > hundreds of occurances of that pattern in Linux sources), so maybe we
> > should introduce some generic helpers for this (quite common) use-case?
> > I can do that, but I certainly can't take care of migrating all the
> > existing uses of this pattern to switch to the new helper.
> 
> IMHO this is one of the cases where the code would be far clearer
> without he macros..
> 
> #define MXL86110_COM_EXT_LED_GEN_CFG			0xA00B
> # define MXL86110_COM_EXT_LED_GEN_CFG_LFME(x)		(1 << (3 * (x)))
> # define MXL86110_COM_EXT_LED_GEN_CFG_LFE(x)		(2 << (3 * (x)))
> # define MXL86110_COM_EXT_LED_GEN_CFG_MASK(x)		(3 << (3 * (x)))
> 
> Right?

I agree. If everyone is fine with using numbers and bitshift instead of
GENMASK(...) then I'd also prefer it in this case.


