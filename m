Return-Path: <netdev+bounces-209888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F7B11330
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 23:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36047AAB77
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44082238C35;
	Thu, 24 Jul 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvQG9mmb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156AC1F0E29;
	Thu, 24 Jul 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392962; cv=none; b=Zv2kGKcAp4wwS7mKr24Bmmyg5/EV5yffyvClNF/6hjXec26G/bZk4Hjqgm7tcu6v/40DCgaqVVUD3mbuRuSL0d5rlrj/GG2cg1IwN901XJRVgsAI3JwWjPQcXRRx3amu7p46g6e1HEuMATWJ4SBK5S+jjvxJAywnrNDwZjkytos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392962; c=relaxed/simple;
	bh=VktSpx31T4gvreXXwiCIHMGXxj+dIlDcqOXQZ0Nb58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coIuA90YJo8RkD9fL3US992k5hnl0NcZCg3qqbXBAgUBdxZjEc/rZWuF4BI0rzQUzx37Kxh5g23e4Lh1Sz73ZSLB3rj4Hu826m3dUez1O4Z/u1FGyRCBaTYrXHZhuuLr0BoCFQ+NhE3v65KxgLTOCEC3RonEAwlnGxMp/1XKuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvQG9mmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78382C4CEF5;
	Thu, 24 Jul 2025 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392961;
	bh=VktSpx31T4gvreXXwiCIHMGXxj+dIlDcqOXQZ0Nb58Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvQG9mmb5SVQIv3JuI8wf8n8pSM2jrkgynaWdk2Awu3haJcvmKJby/Kd7S+vZ84EX
	 adyzw36maWDQqPaFHuPeHT0+nkIzcT0s3WZj8NTYhYozRphxujua2r7fhZXtpj6sw/
	 0qiSpDzML0kKWPHphMZZkz1KeUbFheQe72eTsKgzTz86A8dBV2sY/kWPVyQJBoNeYS
	 fjsdsYdc2ePT2kAtvfcMqL5b+RqQpv0RKXSOeN8XgTxvFYZrgCYTkrv8+85eCOdi8p
	 Omz/ZmsnFeWz4K06ATI2kS8hyvhdkN636t+7F4rXOiHDG1XFdWrVSLN/v8jBesWrN1
	 Y/6X171UP2iTg==
Date: Thu, 24 Jul 2025 22:35:56 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	marex@denx.de, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <20250724213556.GG1266901@horms.kernel.org>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
 <20250720102224.GR2459@horms.kernel.org>
 <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250723162158.GJ1036606@horms.kernel.org>
 <DM3PR11MB87369E36CA76C1BB7C78CEB7EC5EA@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87369E36CA76C1BB7C78CEB7EC5EA@DM3PR11MB8736.namprd11.prod.outlook.com>

On Thu, Jul 24, 2025 at 02:28:56AM +0000, Tristram.Ha@microchip.com wrote:
> > On Wed, Jul 23, 2025 at 02:25:27AM +0000, Tristram.Ha@microchip.com wrote:
> > > > On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> > > > > On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com wrote:
> > > > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > > > >
> > > > > > KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> > > > > > to change some registers when using KSZ8463.
> > > > > >
> > > > > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > > > > ---
> > > > > > v3
> > > > > > - Replace cpu_to_be16() with swab16() to avoid compiler warning
> > > > >
> > > > > ...
> > > > >
> > > > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > > > b/drivers/net/dsa/microchip/ksz_common.c
> > > > >
> > > > > ...
> > > > >
> > > > > > @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
> > > > > >     }
> > > > > >
> > > > > >     /* set broadcast storm protection 10% rate */
> > > > > > -   regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
> > > > > > -                      BROADCAST_STORM_RATE,
> > > > > > -                      (BROADCAST_STORM_VALUE *
> > > > > > -                      BROADCAST_STORM_PROT_RATE) / 100);
> > > > > > +   storm_mask = BROADCAST_STORM_RATE;
> > > > > > +   storm_rate = (BROADCAST_STORM_VALUE *
> > > > BROADCAST_STORM_PROT_RATE) / 100;
> > > > > > +   if (ksz_is_ksz8463(dev)) {
> > > > > > +           storm_mask = swab16(storm_mask);
> > > > > > +           storm_rate = swab16(storm_rate);
> > > > > > +   }
> > > > > > +   regmap_update_bits(ksz_regmap_16(dev),
> > > > > > +                      reg16(dev, regs[S_BROADCAST_CTRL]),
> > > > > > +                      storm_mask, storm_rate);
> > > > >
> > > > > Hi Tristram,
> > > > >
> > > > > I am confused by the use of swab16() here.
> > > > >
> > > > > Let us say that we are running on a little endian host (likely).
> > > > > Then the effect of this is to pass big endian values to regmap_update_bits().
> > > > >
> > > > > But if we are running on a big endian host, the opposite will be true:
> > > > > little endian values will be passed to regmap_update_bits().
> > > > >
> > > > >
> > > > > Looking at KSZ_REGMAP_ENTRY() I see:
> > > > >
> > > > > #define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)         \
> > > > >         {                                                               \
> > > > >               ...
> > > > >                 .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
> > > > >                 .val_format_endian = REGMAP_ENDIAN_BIG                  \
> > > > >         }
> > > >
> > > > Update; I now see this in another patch of the series:
> > > >
> > > > +#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)    \
> > > > +       {                                                               \
> > > >                 ...
> > > > +               .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
> > > > +               .val_format_endian = REGMAP_ENDIAN_LITTLE               \
> > > > +       }
> > > >
> > > > Which I understand to mean that the hardware is expecting little endian
> > > > values. But still, my concerns raised in my previous email of this
> > > > thread remain.
> > > >
> > > > And I have a question: does this chip use little endian register values
> > > > whereas other chips used big endian register values?
> > > >
> > > > >
> > > > > Which based on a skimming the regmap code implies to me that
> > > > > regmap_update_bits() should be passed host byte order values
> > > > > which regmap will convert to big endian when writing out
> > > > > these values.
> > > > >
> > > > > It is unclear to me why changing the byte order of storm_mask
> > > > > and storm_rate is needed here. But it does seem clear that
> > > > > it will lead to inconsistent results on big endian and little
> > > > > endian hosts.
> > >
> > > The broadcast storm value 0x7ff is stored in registers 6 and 7 in KSZ8863
> > > where register 6 holds the 0x7 part while register 7 holds the 0xff part.
> > > In KSZ8463 register 6 is defined as 16-bit where the 0x7 part is held in
> > > lower byte and the 0xff part is held in higher byte.  It is necessary to
> > > swap the bytes when the value is passed to the 16-bit write function.
> > 
> > Perhaps naively, I would have expected
> > 
> >         .val_format_endian = REGMAP_ENDIAN_LITTLE
> > 
> > to handle writing the 16-bit value 0x7ff such that 0x7 is in
> > the lower byte, while 0xff is in the upper byte. Is that not the case?
> > 
> > If not, do you get the desired result by removing the swab16() calls
> > and using
> > 
> >         .val_format_endian = REGMAP_ENDIAN_BIG
> > 
> > But perhaps I misunderstand how .val_format_endian works.
> > 
> > >
> > > All other KSZ switches use 8-bit access with automatic address increase
> > > so a write to register 0 with value 0x12345678 means 0=0x12, 1=0x34,
> > > 2=0x56, and 3=0x78.
> 
> It is not about big-endian or little-endian.  It is just the presentation
> of this register is different between KSZ8863 and KSZ8463.  KSZ8863 uses
> big-endian for register value as the access is 8-bit and the address is
> automatically increased by 1.  Writing a value 0x03ff to register 6 means
> 6=0x03 and 7=0xff.  The actual SPI transfer commands are "02 06 03 ff."
> KSZ8463 uses little-endian for register value as the access is fixed at
> 8-bit, 16-bit, or 32-bit.  Writing 0x03ff results in the actual SPI
> transfer commands "80 70 ff 03" where the correct commands are
> "80 70 03 ff."

The difference between expressing a 16-bit value as "ff 03" and "03 ff"
sounds a lot like endianness to me.

"ff 03" is the little endian representation of 0x3ff.
"03 ff" is the big endian representation of 0x3ff.

I am very confused as to why you say "KSZ8463 uses little-endian for
register value". And then go on to say that the correct transfer command is
"02 06 03 ff", where the value in that command is "03 ff." That looks like
a big endian value to me.


In my reading of your code, it takes a host byte order value, and swapping
it's byte order. It is then passing it to an API that expects a host byte
order value. I think it would be much better to avoid doing that. This is
my main point.

Let us consider the (likely) case that the host is little endian.  The
value (and mask) are byte swapped, becoming big endian.  Thisbig endian
value (and mask) is passed to regmap_update_bits().

Now let us assume that, because REGMAP_ENDIAN_LITTLE is used,
they then pass through something like cpu_to_le16().
That's a noop on a little endian system. So the value remains big endian.

Next, let us consider a big endian host.
The value (and mask) are byte swapped, becoming little endian.
This little endian value (and mask) is passed to regmap_update_bits().

Then, let us assume that, because REGMAP_ENDIAN_LITTLE is used,
they then pass through something like cpu_to_le16().
This is a byte-swap on big endian hosts.
So the value (and mask) become big endian.

The result turns out to be the same for little endian and big endian hosts,
which is nice. But now let us assume that instead of passing byte-swapped
values to APIs that expect host byte order values, we instead pass host
byte order values and use REGMAP_ENDIAN_BIG.

In this case the host byte order values are passed to regmap_update_bits().
Then, as per our earlier assumptions, because REGMAP_ENDIAN_BIG is used,
the value (and mask) pass through cpu_to_be16 or similar. After which they
are big endian. The same result as above. But without passing byte-swapped
values to APIs that expect host byte order values.

Is my understanding of the effect of REGMAP_ENDIAN_LITTLE and
REGMAP_ENDIAN_BIG incorrect? Is some other part of my reasoning faulty?


I feel that we are talking past each other.
Let's try to find a common understanding.

