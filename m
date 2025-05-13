Return-Path: <netdev+bounces-190022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E5AB5014
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98247B1637
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57AD238C26;
	Tue, 13 May 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBQFW/OS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA41E570D;
	Tue, 13 May 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129293; cv=none; b=IiMvEbLuwUWBLLAhfR9Zf6kbzmF1eSdtdAQeb58X4WY5ivWxGK6aBKNHDAus7Bt+MApVgd94mtSr/6CsMWa6Da54+acqHBzVnesy1dGnp5QOPyeipuBJZNwe9dPT3SnZAJrIkGBAudvL64j0a3AFz9V37SugZvXEKYRu0e/ufrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129293; c=relaxed/simple;
	bh=9LpchjhiZX+DBZ6lMeGJvFj12PZytbaMZ9VCzKNnWKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5B/Q0QeyF5jS2TtxrjiVbPHTfR2/lXJmBIqW5Q8qH1IXOjoVXXYaON3NxsBD21dnTraothZBADinzLACxWZ8baqSn36pXN2v5ze56/70+WYqqRDWi7DYyxHrqVkj3Zs5pvMOQoz4aP4+N6F+ci2gLXZDd5uMbqMr1qKP/+E0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBQFW/OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D74C4CEE4;
	Tue, 13 May 2025 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747129293;
	bh=9LpchjhiZX+DBZ6lMeGJvFj12PZytbaMZ9VCzKNnWKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBQFW/OSWl0JKCgO3wU5Zev4svkXFf7hg1hXf5vz/dafM3maiJzs1pvZB4PggT3J7
	 4Fgb0P+P3LbyvaBBr+NTPBk5toNUyb87sBxZfI029TpdTVwCYABse2TcYvVL3TzZRe
	 9C4BxfZkhY6ir7IctfItjKlVifYGxX11uT+x8kHAsC7aCQrQyotU+baHY2Z0qsG4XD
	 Vg9Gu0DWBjjxzBIlamIYcZ9EPvglCZ2lXw9NX7+y5wXevRIfDjRe3oukq9hP9DTrSd
	 jegikYcugiinVo0isHFxAPJLdkQ+V3E8WpGg+7wZWeF7zzIkfEjiL7pChb+hsn8aX5
	 OCNDfyrLDoADg==
Date: Tue, 13 May 2025 10:41:26 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <20250513094126.GF2936510@google.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
 <aBt1N6TcSckYj23A@smile.fi.intel.com>
 <20250507152609.GK3865826@google.com>
 <b095ffb9-c274-4520-a45e-96861268500b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b095ffb9-c274-4520-a45e-96861268500b@redhat.com>

On Mon, 12 May 2025, Ivan Vecera wrote:

> On 07. 05. 25 5:26 odp., Lee Jones wrote:
> > On Wed, 07 May 2025, Andy Shevchenko wrote:
> > 
> > > On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
> > > > On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
> > > > > On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
> > > 
> > > ...
> > > 
> > > > > > +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
> > > > > > +       { .channel = 0, },
> > > > > > +       { .channel = 1, },
> > > > > > +       { .channel = 2, },
> > > > > > +       { .channel = 3, },
> > > > > > +       { .channel = 4, },
> > > > > > +};
> > > > > 
> > > > > > +static const struct mfd_cell zl3073x_devs[] = {
> > > > > > +       ZL3073X_CELL("zl3073x-dpll", 0),
> > > > > > +       ZL3073X_CELL("zl3073x-dpll", 1),
> > > > > > +       ZL3073X_CELL("zl3073x-dpll", 2),
> > > > > > +       ZL3073X_CELL("zl3073x-dpll", 3),
> > > > > > +       ZL3073X_CELL("zl3073x-dpll", 4),
> > > > > > +};
> > > > > 
> > > > > > +#define ZL3073X_MAX_CHANNELS   5
> > > > > 
> > > > > Btw, wouldn't be better to keep the above lists synchronised like
> > > > > 
> > > > > 1. Make ZL3073X_CELL() to use indexed variant
> > > > > 
> > > > > [idx] = ...
> > > > > 
> > > > > 2. Define the channel numbers
> > > > > 
> > > > > and use them in both data structures.
> > > > > 
> > > > > ...
> > > > 
> > > > WDYM?
> > > > 
> > > > > OTOH, I'm not sure why we even need this. If this is going to be
> > > > > sequential, can't we make a core to decide which cell will be given
> > > > > which id?
> > > > 
> > > > Just a note that after introduction of PHC sub-driver the array will look
> > > > like:
> > > > static const struct mfd_cell zl3073x_devs[] = {
> > > >         ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
> > > >         ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
> > > >         ZL3073X_CELL("zl3073x-dpll", 1),  // ...
> > > >         ZL3073X_CELL("zl3073x-phc", 1),
> > > >         ZL3073X_CELL("zl3073x-dpll", 2),
> > > >         ZL3073X_CELL("zl3073x-phc", 2),
> > > >         ZL3073X_CELL("zl3073x-dpll", 3),
> > > >         ZL3073X_CELL("zl3073x-phc", 3),
> > > >         ZL3073X_CELL("zl3073x-dpll", 4),
> > > >         ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
> > > > };
> > > 
> > > Ah, this is very important piece. Then I mean only this kind of change
> > > 
> > > enum {
> > > 	// this or whatever meaningful names
> > > 	..._CH_0	0
> > > 	..._CH_1	1
> > > 	...
> > > };
> > > 
> > > static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
> > >         { .channel = ..._CH_0, },
> > >         ...
> > > };
> > > 
> > > static const struct mfd_cell zl3073x_devs[] = {
> > >         ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
> > >         ZL3073X_CELL("zl3073x-phc", ..._CH_0),
> > >         ...
> > > };
> > 
> > This is getting hectic.  All for a sequential enumeration.  Seeing as
> > there are no other differentiations, why not use IDA in the child
> > instead?
> 
> For that, there have to be two IDAs, one for DPLLs and one for PHCs...

Sorry, can you explain a bit more.  Why is this a problem?

The IDA API is very simple.

Much better than building your own bespoke MACROs.

> The approach in my second reply in this thread is simpler and taken
> in v8.
> 
> <cite>
> +#define ZL3073X_PDATA(_channel)			\
> +	(&(const struct zl3073x_pdata) {	\
> +		.channel = _channel,		\
> +	})
> +
> +#define ZL3073X_CELL(_name, _channel)				\
> +	MFD_CELL_BASIC(_name, NULL, ZL3073X_PDATA(_channel),	\
> +		       sizeof(struct zl3073x_pdata), 0)
> +
> +static const struct mfd_cell zl3073x_devs[] = {
> +	ZL3073X_CELL("zl3073x-dpll", 0),
> +	ZL3073X_CELL("zl3073x-dpll", 1),
> +	ZL3073X_CELL("zl3073x-dpll", 2),
> +	ZL3073X_CELL("zl3073x-dpll", 3),
> +	ZL3073X_CELL("zl3073x-dpll", 4),
> +};
> </cite>
> 
> Lee, WDYT?
> 
> Thanks,
> Ivan
> 

-- 
Lee Jones [李琼斯]

