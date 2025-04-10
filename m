Return-Path: <netdev+bounces-181379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A547A84BB0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DB94E410E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3728CF5E;
	Thu, 10 Apr 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bNa6eJWB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF028C5D0;
	Thu, 10 Apr 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307446; cv=none; b=lqwc3X6tyjX4RMczZw1jcd412302bbN1FIvZXGjfaddq5SjcTegenjlCuThji7YCH7ul+W0sq5L+JeDK7WgE9jV8iGrv6JZ5Chqcg7Yoc3XS93Eci4x21aPx8OSlgUjHY+7z2F2s7etAyrUlaXn0y6uxu41j7sBEClnUEhAj384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307446; c=relaxed/simple;
	bh=33+Hhj/C1mkwkvLYMTMpS5FWuWANTeZYzuHG2sg2BVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/GFt/NWLCKyvsDFLQSwWe+DD2lFtc79WbPWUWNpvMevm6e/kv/krJVgWXGn0OqnQd8qUq3GGeKJCimMipZ20rRnYjGK+OBAXLL287MOynmcqr5g5M9NrriuefvjM2xTGG5qut6SLIHALt7EmlMmeRnnNiJAK5xD0GJN+Ovc0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bNa6eJWB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QwONnJdPBKErdw/aCustfNSuAYc8JI8kxJhxFvlmSBw=; b=bNa6eJWBFnUez17aW+EQoPI3DG
	GuAfLCsxmvGgkTJtpDf8z9rOHFRcrbG2tTw+52Y3N10KP8Oiy1lL8kycLnisyGIDwREOYDWHCfdh5
	uAznCC8Oh7jg15HOrZv5NdtCX5zjsCNFDJk2SpF80xjHY3q7V5udx0BYA7E0nhAsbI3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2w2o-008iLP-9j; Thu, 10 Apr 2025 19:50:30 +0200
Date: Thu, 10 Apr 2025 19:50:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 03/14] mfd: Add Microchip ZL3073x support
Message-ID: <2b877823-a3d9-42bb-9b37-afc45180c404@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-4-ivecera@redhat.com>
 <Z_aVlIiT07ZDE2Kf@smile.fi.intel.com>
 <eecfb843-e9cd-4d07-bb72-15cf84a25706@kernel.org>
 <e760caeb-5c7b-4014-810c-c2a97b3bda28@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e760caeb-5c7b-4014-810c-c2a97b3bda28@redhat.com>

On Thu, Apr 10, 2025 at 09:52:39AM +0200, Ivan Vecera wrote:
> 
> 
> On 10. 04. 25 9:19 dop., Krzysztof Kozlowski wrote:
> > On 09/04/2025 17:43, Andy Shevchenko wrote:
> > > > +/*
> > > > + * Regmap range configuration
> > > > + *
> > > > + * The device uses 7-bit addressing and has 16 register pages with
> > > > + * range 0x00-0x7f. The register 0x7f in each page acts as page
> > > > + * selector where bits 0-3 contains currently selected page.
> > > > + */
> > > > +static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
> > > > +	{
> > > > +		.range_min	= 0,
> > > 
> > > This still has the same issue, you haven't given a chance to me to reply
> > > in v1 thread. I'm not going to review this as it's not settled down yet.
> > > Let's first discuss the questions you have in v1.
> > > 
> 
> Sorry for that but I don't understand where the issue is... Many drivers
> uses this the same way.
> E.g.
> drivers/leds/leds-aw200xx.c
> drivers/mfd/rsmu_i2c.c
> sound/soc/codecs/tas2562.c
> ...and many others
> 
> All of them uses selector register that is present on all pages, wide range
> for register access <0, num_pages*window_size> and window <0, window_size>
> 
> Do they also do incorrectly or am I missing something?

The bigger point is, you should of asked this as part of the
discussion on the previous version. You should not post a new version
until all discussion has come to an end, you understand all the
comments, or you have persuaded the commentor that the code is in fact
correct.

Posting more versions without having that discussion just wastes
reviewers/Maintainers time, and that is not what you want to do if you
want to get your patch merged.

	Andrew

