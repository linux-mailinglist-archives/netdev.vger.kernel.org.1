Return-Path: <netdev+bounces-245290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74787CCAFA4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC07730090B3
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F812BF00B;
	Thu, 18 Dec 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7HNO1GH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465F2ECEBB
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047493; cv=none; b=UsdCvIahJi/AXVquDLdtFFRoVR/UqCJ6749Shvou/FoudgOM6CnkxNUXRddtAD7icYkrOX34mperiV8yMjsGqqRA/qwvk076St32VFH8yDeRNT8fma8O7MYtz2NYQC45gFuXkrOTkeuwzoZKrbBelR2EhAzJAyNCPK0OLjpl6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047493; c=relaxed/simple;
	bh=5u3i+h+gDY6CdOEWpn+Beo7NNaVht96wfUN2hkRg5As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTogvT85/75suc0h8GwxIxNLIlEv5mX2kDxWfOIR75vtYZ4icPQEvjtkK4foDs1xhstd+8dYHFFigj3IMse+ExxEhY0EcdisaVc/mCAdr7WBL6kqDLKZaHFCjztkEDR+XFKSsBu3sHoh7C/2v5AMODB81BiAHLc45U2Mc5bXzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7HNO1GH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so2030595e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766047489; x=1766652289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UY/yArC4o6EdxdfNYyVM9hqIXvxv+BzpVpHyD2GXVc=;
        b=J7HNO1GHJb06tmZ94fE4GvdgnRNd9yjhtSXC1V2w/P5dgs3AJ+59ixdJzdGgcof823
         4gF4l8lfXzakuQfCsb0lf5PikXJfKO04RVN3XGBsAikcbGwkRZ8KAJjnR8A4S9uQHDOI
         R6y4OOP9xXjYeKtayQMxH6YwaelacT+hQWikC8eYyXwilC3FfuBITm+kcXM74XSW+X3v
         rCG+57/Cy+DuGZ0YjsISAE72MGFixNggApusJaZPDh2ptepjVi2kPln34OhVFcOFv/dl
         ysaNBLm4bnFrJvrL9MxvCwqKkZ6D/xTB0UGWmpmmsFnN7uBZl+LM56hX+y6EcGkN2a84
         pFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766047489; x=1766652289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8UY/yArC4o6EdxdfNYyVM9hqIXvxv+BzpVpHyD2GXVc=;
        b=SEZ8PQibkvjb1hS23YjgLm+HrnnY7snQzf6Rk2m8Hu9aRrzYZaQ90jYH0jEYP1JZCy
         trOnZeO97LXY+cTAUBNVqAo5IggBH7eDrAeYX+O6ktEYW4NbnpiysyCkrpluecFzdNjW
         7gYHIb2e5gCFi58dAl/4y78fvXubIJDy3Twxa+igx8UYcTdhsfovD6SclkH+VZCepntW
         1rhB8cxJBrXmuMscdk3wHoZ6Yp9sHvnyjUH2jh2P6MHDzYpfn6SQr/DYHP5P10Q+en7b
         M9NS3c8F3eMK+4P01LgDmYB50L3EzMYcrGiMaLaNLidnJfoNFM3ls4RfEGjiX9PChl1b
         gXHA==
X-Forwarded-Encrypted: i=1; AJvYcCXHJPYk5tso3Ob9Hoc7gR7R0PzMnUaxMmfVvNrXsY0E50Gwqat+H3rEMe0EMVr/GxsODLfc73g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRheNIZip1YkB6PV9lOTuHo4X7prB3kj8h5HH8/7nwdgdpmmo
	+i2mPlz4+uFDFImTUT+KCS759bOyjKyHvcoN92FNgOrB+R/jMN5aEb9o
X-Gm-Gg: AY/fxX6u2SJIPc4YWgztmPfCICFY2vdFRJ9/cVA4yXy36XCOkGLBn6rhhdKyCOmTooD
	agyp+1d8dwyz+LlyUnJjWsdvpqu8r30/Sj/KsFGBK0FKKlXwafdHXLnvqq/KoLDMYpsKs5Ckro8
	dtP7DXbiDtLk7vFZqNOfNIdmhCjm60CXZ4Pf00h6anav8WL/KfT6eL7Xf5xjeAX4r1FxbK93vlN
	vr++f9FMOKo7Z3jRpAAZvnwo04dZW4Wta7/sZLN7Hxv8DWmPeK7protWhPdLY8L5t4K975/v6hC
	W/Ij1SqEnAycS9JGp5GmzCyydueDJOXQbTZ3RVZqOUpqULUo5QKZ1hOzpfFphyX/eW4BvbVw8eI
	W8Tyfss4oVmrmXbD2V4V6NLqAFfFjaTpibzwxIfwE/dcdHtEXbS73NBRUO9lNZAUca4tnv+r/+H
	YUOYDBpVLHjXHHgt/z0RJZCbRkbxuOhm9p94AvMd9KAnObR+xj2sqB
X-Google-Smtp-Source: AGHT+IGxKeRhQYKrkJnvOfNy88ecEa71cowOWYtNvzpQsro+N005TxE21DHaH/Asg8ETI09DOi2fpA==
X-Received: by 2002:a05:600c:c4b7:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47a97193f3amr163980825e9.31.1766047488655;
        Thu, 18 Dec 2025 00:44:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3029fb7sm26083015e9.8.2025.12.18.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:44:48 -0800 (PST)
Date: Thu, 18 Dec 2025 08:44:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Message-ID: <20251218084446.580f29b9@pumpkin>
In-Reply-To: <aUNHyjKS9b2KwdGJ@yury>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-4-david.laight.linux@gmail.com>
	<5257288.LvFx2qVVIh@workhorse>
	<aUNHyjKS9b2KwdGJ@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 19:16:10 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Wed, Dec 17, 2025 at 02:22:32PM +0100, Nicolas Frattaroli wrote:
> > On Friday, 12 December 2025 20:37:08 Central European Standard Time david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > > not be used outside bitfield) and open-coding the generation of the
> > > masked value, just call FIELD_PREP() and add an extra check for
> > > the mask being at most 16 bits.
> > > The extra check is added after calling FIELD_PREP() to get a sane
> > > error message if 'mask' isn't constant.
> > > 
> > > Remove the leading _ from the formal parameter names.
> > > Prefix the local variables with _wm16_ to hopefully make them
> > > unique.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > > 
> > > Changes for v2:
> > > - Update kerneldoc to match changed formal parameter names.
> > > - Change local variables to not collide with those in FIELD_PREP().
> > > 
> > > Most of the examples are constants and get optimised away.
> > > 
> > >  include/linux/hw_bitfield.h | 21 ++++++++++-----------
> > >  1 file changed, 10 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> > > index df202e167ce4..0bd1040a5f93 100644
> > > --- a/include/linux/hw_bitfield.h
> > > +++ b/include/linux/hw_bitfield.h
> > > @@ -12,8 +12,8 @@
> > >  
> > >  /**
> > >   * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
> > > - * @_mask: shifted mask defining the field's length and position
> > > - * @_val:  value to put in the field
> > > + * @mask: shifted mask defining the field's length and position
> > > + * @val:  value to put in the field
> > >   *
> > >   * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
> > >   * result with the mask shifted up by 16.
> > > @@ -23,15 +23,14 @@
> > >   * register, a bit in the lower half is only updated if the corresponding bit
> > >   * in the upper half is high.
> > >   */
> > > -#define FIELD_PREP_WM16(_mask, _val)					     \
> > > -	({								     \
> > > -		typeof(_val) __val = _val;				     \
> > > -		typeof(_mask) __mask = _mask;				     \
> > > -		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
> > > -				 "HWORD_UPDATE: ");			     \
> > > -		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
> > > -		((__mask) << 16);					     \
> > > -	})
> > > +#define FIELD_PREP_WM16(mask, val)				\
> > > +({								\
> > > +	__auto_type _wm16_mask = mask;				\
> > > +	u32 _wm16_val = FIELD_PREP(_wm16_mask, val);		\
> > > +	BUILD_BUG_ON_MSG(_wm16_mask > 0xffffu,			\
> > > +			 "FIELD_PREP_WM16: mask too large");	\
> > > +	_wm16_val | (_wm16_mask << 16);				\
> > > +})
> > >  
> > >  /**
> > >   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> > >   
> > 
> > Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> > Compiled it with my usual config and booted it on a board that uses
> > drivers that make use of these macros, and checked that things are
> > working.  
> 
> Nicolas, thanks for testing! Would you also want to add an explicit
> ack or review tag?
> 
> David, I'm OK with this change. Please add bloat-o-meter and code
> generation examples, and minimize the diff as I asked in v1, before I
> can merge it.

That is pretty much the minimal diff.
By the time you've changed the three lines that do anything 'real'
and realigned the continuation markers all the lines have changed.

I did look at the generated code, but since 'mask' is a constant
the whole thing is just ((val << const_a) | const_b) pretty much
regardless of the actual source - most of which is compile-time checks.
There isn't anything for the bloat-o-meter to find.
	
	David


> 
> Thanks,
> Yury


