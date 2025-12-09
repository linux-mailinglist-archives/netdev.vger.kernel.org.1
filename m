Return-Path: <netdev+bounces-244159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA0CB0E89
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 20:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22BF030A7332
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200F3043B0;
	Tue,  9 Dec 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2x8JN5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDE3009D2
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765307516; cv=none; b=ph3yUUWCejkzIu4B8yoSvBTk/S580u90x8rmNK3op+cl2MUe2hVm6zgwnGiyCyc+gUa0iL4rZqSMzHEWNjDzoFEYiUkU9aqD/krFS/M3fIEguXmZpbP/67JkdU0LfrjT3eUS5vbCcpp8SGiT1cd5qXBBw2cn6OT1q5X+FGIBexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765307516; c=relaxed/simple;
	bh=Vigss2VmDX7bEdaP1IC8CfMj88h+qnBHbPLRY6X9h5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRbIT8ygzWhYBUh8H9hmmE469tdwCgPGHYOGA3gzeDwR0v9E1ED/uoAdhMGkJOJipRCOZN2WEqqwPxEMhWAgvApd5K0rmWCMAAsnLmsWnEPH4zSEUVBzPK16yxAF8pbeF047+eN5AUI4vYi6HAJkClbgnv3bXuETHPK1Ss6h88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2x8JN5a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso62154285e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765307512; x=1765912312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VrojYWmad2/hXGEw6Ve6lcVoq3UDRgDrKieHhrBvuI=;
        b=V2x8JN5aduJWBdc8uCNsZyEklP+C0uNfe+QvXzXdSWGvPA5xiAIQL5Z0UmQMFUmDvy
         rl7dk1XxmNLpyMDbbo8ew3yoLhZPEC7VUrntT3JNTRqWzTEg22Ee4qtHJaiIRiVUDkhz
         Fw9t6SxoD2kuWNJEqbX93PUy3cB79ZgtEFh7dwI3SLcnxSy/RkbUH4BkQx/3Gl3VXd25
         bxRY5grX8OSWpzIvyRnyJjxze080GeypAE5qKRiKqw8mZaijNarH1I4hh7U3kot3lCS2
         3x+iPvKJemi5fbenOq/INQyYPzNKFOxfHPNoCfHXPGdwniPI4CqM8RAwUZRrDk1OOM9H
         vg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765307512; x=1765912312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7VrojYWmad2/hXGEw6Ve6lcVoq3UDRgDrKieHhrBvuI=;
        b=SwPrX3LVqKcvGOlFry7jGKCUD1Rw4qGoGaM1iMJyOGDEqdzHi2bJRYs3/h9CwcIwXQ
         qYIfv+Fs1sVjPVmpEtdAJJ4WopGwXSYUJp3c84u/oA522jG1nSBgNb/OFR7pCX4Uz8EH
         +mQ/z+qBtDrEi7mDWACcGKnnxUfZ6Tz20kaY+9AkCEjZsIAdAwKdDM1r0xPrvwgjeq2h
         pR2uoS9yVmUYrKhO31RWAk3ku4e1k4if04LMLO66sW7yEK07IqDpqWH9gPx/iXlS2XUH
         B9ovd6l5nUfDY6D2tm03LpiV3NRNQpRAIjps9Vmfha6rTzI6iwDH0SIjQkZMA83kJ7dy
         dWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0CZE0pi46xKHxxJZVqK3r/LmwXNrKJkOY9rikgv12yubEp5PEPOkmQyP+dlttqq9L4KTC7Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCvyaWYiQO0M0l1nOzBQFDThJbwd+O6HyH4WVXlrWBhx3eauM
	SUG56XAMhAAxleVCnoZZusggEqyaw+cHXGTWj9dqjIViJDfx7Dt+Tsz0
X-Gm-Gg: ASbGnct1Pgw7AJSFMpdeD56JHFLa/7s8s3kRULbu4f0UVOlpMlfcMV9AcbOiKxs0xfK
	eeMVRy79LqnhxoZMoDGpV6QZ/GpvZ1DUiiM7Lijw0KOPdN0+C8pHJ2v8H9pZkhDoBKx4Rf/bQL+
	KGDEaKkYSzpANqPTU6uEXsTfAKgz1A+vrWPgrAYURnXTwm16ctwVXJCYDrlGhSCCeA0wJyPcKhv
	C/Y6+3SEvevvfq52rgrkASHLrM+3bQOyiM6fllgmP19KbgZglNtXOLkK2atlWYVjCI2xFrDdMx4
	PEvQJxvhVSmeLqWp8C7Th/oeMKGCx7gvo0Ak6i68/PgdkmrtxjAbDYyha7n5802ijlDrm8epm6n
	lN9RrWOT29AoqoQG6kM8/UfdDArxQqOx6fyfqhg9HeI0Gt6Uxt4CtUk0Rqpt4RlcLJYgi+OA8Ji
	etM9T0GrSsuV6B8E7nWCWBsIJXIz6yy+9p08urbXnOZcgVplsBEBnO
X-Google-Smtp-Source: AGHT+IF6wLKEoqKWHUIso/KMV2us/t6CixsT57DQtOhmkn/Y6ES7LiNIjvfalect3nhhJyAITGuBxw==
X-Received: by 2002:a05:600c:37c3:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-47939e37b60mr131029595e9.27.1765307512383;
        Tue, 09 Dec 2025 11:11:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222478sm32697794f8f.20.2025.12.09.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 11:11:52 -0800 (PST)
Date: Tue, 9 Dec 2025 19:11:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 4/9] bitfield: Copy #define parameters to locals
Message-ID: <20251209191148.16b7fdee@pumpkin>
In-Reply-To: <aThFlDZVFBEyBhFq@smile.fi.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-5-david.laight.linux@gmail.com>
	<aThFlDZVFBEyBhFq@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2025 17:51:48 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 09, 2025 at 10:03:08AM +0000, david.laight.linux@gmail.com wrote:
> 
> > Use __auto_type to take copies of parameters to both ensure they are
> > evaluated only once and to avoid bloating the pre-processor output.
> > In particular 'mask' is likely to be GENMASK() and the expension
> > of FIELD_GET() is then about 18KB.
> > 
> > Remove any extra (), update kerneldoc.  
> 
> > Consistently use xxx for #define formal parameters and _xxx for
> > local variables.  
> 
> Okay, I commented below, and I think this is too huge to be in this commit.
> Can we make it separate?

I originally wrote a much longer patch set, then merged some to reduce
the number of patches - you can't win really.

> 
> > Rather than use (typeof(mask))(val) to ensure bits aren't lost when
> > val is shifted left, use '__auto_type _val = 1 ? (val) : _mask;'
> > relying on the ?: operator to generate a type that is large enough.
> > 
> > Remove the (typeof(mask)) cast from __FIELD_GET(), it can only make
> > a difference if 'reg' is larger than 'mask' and the caller cares about
> > the actual type.
> > Note that mask usually comes from GENMASK() and is then 'unsigned long'.
> > 
> > Rename the internal defines __FIELD_PREP to __BF_FIELD_PREP and
> > __FIELD_GET to __BF_FIELD_GET.
> > 
> > Now that field_prep() and field_get() copy their parameters there is
> > no need for the __field_prep() and __field_get() defines.
> > But add a define to generate the required 'shift' to use in both defines.  
> 
> ...
> 
> > -#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
> > +#define __BF_FIELD_CHECK_MASK(mask, val, pfx)				\
> >  	({								\
> > -		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
> > -				 _pfx "mask is not constant");		\
> > -		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> > -		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> > -				 ~((_mask) >> __bf_shf(_mask)) &	\
> > -					(0 + (_val)) : 0,		\
> > -				 _pfx "value too large for the field"); \
> > -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> > -					      (1ULL << __bf_shf(_mask))); \
> > +		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
> > +				 pfx "mask is not constant");		\
> > +		BUILD_BUG_ON_MSG((mask) == 0, _pfx "mask is zero");	\
> > +		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
> > +				 ~((mask) >> __bf_shf(mask)) &		\
> > +					(0 + (val)) : 0,		\
> > +				 pfx "value too large for the field");	\
> > +		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
> > +					      (1ULL << __bf_shf(mask))); \
> >  	})  
> 
> I looks like renaming parameters without any benefit, actually the opposite
> it's very hard to see if there is any interesting change here. Please, drop
> this or make it clear to focus only on the things that needs to be changed.

I'm pretty sure there are no other changes in that bit.
(The entire define is pretty much re-written in a later patch and I
did want to separate the changes.)

I wanted to the file to be absolutely consistent with the parameter/variable
names.
Plausibly the scheme could be slightly different:
'user' parameters are 'xxx', '__auto_type' variables are '_xxx'.
But internal defines that evaluate/expand parameters more than once are
'_xxx' and must be 'copied' by an outer define.

	David


