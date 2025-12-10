Return-Path: <netdev+bounces-244289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94DCB4046
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 21:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D12303FA6A
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4232BF51;
	Wed, 10 Dec 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYljs9pz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B97329C54
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400361; cv=none; b=IBs/ibBOhTXaT6g1w5FOfb+oVcFMmow4UPpE86TdeTbi799IDLp18R/C+bZHsrJlasrBqauAvGJWB5KUXy8uHKegThu61yGdr9smHnGDgJXkQPHXEoB7uhfMfy3lCP8Th9s2gGFFud7eSeQIRgOoAkJ+tfYfzpGljs1UQchS8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400361; c=relaxed/simple;
	bh=ZcpC8Yxl/yp8T2h64azfVcrrmb4wlFbuHSjkmVg+Wjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krmX7sJgw398WgbtLvcTNVxChkmjC8b7HXZsbd/FFPZ3jWu1J2uGR43HpDcTnd0QT91/fMaVl4Ul6rYWnIFyaDFf58tnSiQWt/xBfhFhQUz7LQsB4Rgbz8uAP8Ii9/z7N7k9UeGst5AH6ZmasQRcMNQ3BPRbZ+qdJqqKICAkTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYljs9pz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775895d69cso1076245e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765400358; x=1766005158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XOBeiFzLRRI29udaIQcvDgIeWaap6zQQyEf4EzZYCk=;
        b=UYljs9pznvRD9MzX6MYUacxIqSINCRfbY5mWBARDuSYv7K32CGbYdHwD35NOBeavze
         iScvmXoAcWODmMQrRvzV5XvNyQ9aLZs0E7tOoy6JjudtLbV2zAQBco9mahJSCKCCRduc
         3bxjzIXEH/fETAsoRjTS1EXqLqeK5rwjQ9G96dQdfd9NzrD0rSB5ancpY1BxM3G8YFLz
         TEabuXdzHD2JutZa0oBozU1x19KOikCs0hyBD3E+fXczr7dmq4hKigFR9faBzSGPraZr
         AKReKW4yAUk6hXfM3LhjHdvq2eCvQGJfTUvX4Oee0UVdG1D+sv8hWXKpsFCPkp+rXs6n
         /Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765400358; x=1766005158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XOBeiFzLRRI29udaIQcvDgIeWaap6zQQyEf4EzZYCk=;
        b=gYQ6Sq8RhlguDGdEOVAo6K9uDadcIUtxvI8xqB6gX1JGuWKaJQsYOLTxlpbXH56F1W
         dXv6iE7AaIZlkGkCsfZHGXsyCTfSebJkvQxiLA6zVfOtdgh4DL77VrYJ2kQVtiWk5dlU
         fZN2gyXjdZ588HkmYmfuRbiELH8yBjcg8cMbvEKS0qJGRrA2mMN6XNCatfr1eSGPkgpg
         Znb8FRrYZ8YLTVtx5sb+7z/sytbKKRg9GotM3atkBXb5k9QXqk0WBGN/dvOsOVAp+WZq
         6cfpUW+DiOXs1q1YhS2zMwypZ5pTPPTGSxRla3mODmOf+JUq6UxW8Klg1pQHjzabaV5x
         mC0g==
X-Forwarded-Encrypted: i=1; AJvYcCWbp1yl+kWQdzukZ5D+2CBbFqi7ZNJkav5ji2uPhYH0mTdwst5Xq1DSI7mSqudr7wM/xBi3GFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFA9eaNTHx83sN1uw1DEkAyDv6oMPuAOJH2ttkZ2HWW2IgubnS
	+7sQ5+4WSUhjfrUvCsRboUKlZBEHEfcE0Vh1G1J78pUTdqHFqwSoycQ6
X-Gm-Gg: ASbGnctgwjmWnEwEr6nykHobq7BglG9lqpQwHfLdOqLJ5EramVLOWImYSdmTL8pGT76
	dTYbbNmhZhjI2STtNB5qDMz0zAhIXFHn6B+Y1ZUzoEcal35M0Sk6cMaQ/7XUirnGufdzfw6Mx3B
	jaudAAh6g5ZK+lSnbfXhV5eOB4XhqQnCtBRpNtwoWUp8vKzFt61epCuzk8jCj52tIicnOQ98hp0
	SRf3yIn22RCGZKkFfCzLiHj+Cscpb5ydABShH/ldd7Cfep4feWvm/Z8GF13C7NS/8ZnvM/cIu92
	BYzI5VNX0l/US1RdpfiR/zJuihIWnJ3iQrcH597m+8Qrrz8sFvygxfXcJG2XUeC2L6zws49e2/B
	+SdQhUMXLd0VsggZvlcnQbLZqiBx8Qzr3BgbVq4KClZ54gc4TAhJN1lVv0mGGRPL9TWu9eTuy/q
	31K2c14+5RdR5T93/j327CUm63tQi1/KyW/OJqrvgWBILoLYomru1E
X-Google-Smtp-Source: AGHT+IFqWl1AEZJdv33HjXUj4u2PW+9exisa6AWNrimk2s7J9PgpfVbwFVoIk0HS4W55/QiDrON3lw==
X-Received: by 2002:a05:600c:3105:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-47a8376e315mr34983765e9.2.1765400358218;
        Wed, 10 Dec 2025 12:59:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85feasm1051301f8f.27.2025.12.10.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:59:18 -0800 (PST)
Date: Wed, 10 Dec 2025 20:59:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 3/9] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Message-ID: <20251210205915.3b055b7c@pumpkin>
In-Reply-To: <2262600.PYKUYFuaPT@workhorse>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-4-david.laight.linux@gmail.com>
	<2262600.PYKUYFuaPT@workhorse>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 20:18:30 +0100
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> On Tuesday, 9 December 2025 11:03:07 Central European Standard Time david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > not be used outside bitfield) and open-coding the generation of the
> > masked value, just call FIELD_PREP() and add an extra check for
> > the mask being at most 16 bits.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  include/linux/hw_bitfield.h | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> > index df202e167ce4..d7f21b60449b 100644
> > --- a/include/linux/hw_bitfield.h
> > +++ b/include/linux/hw_bitfield.h
> > @@ -23,15 +23,14 @@
> >   * register, a bit in the lower half is only updated if the corresponding bit
> >   * in the upper half is high.
> >   */
> > -#define FIELD_PREP_WM16(_mask, _val)					     \
> > -	({								     \
> > -		typeof(_val) __val = _val;				     \
> > -		typeof(_mask) __mask = _mask;				     \
> > -		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
> > -				 "HWORD_UPDATE: ");			     \
> > -		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
> > -		((__mask) << 16);					     \
> > -	})
> > +#define FIELD_PREP_WM16(mask, val)				\
> > +({								\
> > +	__auto_type _mask = mask;				\
> > +	u32 _val = FIELD_PREP(_mask, val);			\
> > +	BUILD_BUG_ON_MSG(_mask > 0xffffu,			\
> > +			 "FIELD_PREP_WM16: mask too large");	\
> > +	_val | (_mask << 16);					\
> > +})
> >  
> >  /**
> >   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> >   
> 
> This breaks the build for at least one driver that uses
> FIELD_PREP_WM16, namely phy-rockchip-emmc.c:

Not in my allmodconfig build.
... 
> pcie-dw-rockchip.c is similarly broken by this change, except
> without the superfluous wrapper:

That one did get built.

The problem is that FIELD_PREP_WM16() needs to use different 'local'
variables than FIELD_PREP().
The 'proper' fix is to use unique names (as min() and max() do), but that
makes the whole thing unreadable and is best avoided unless nesting is
likely.
In this case s/mask/wm16_mask/ and s/val/wm16_val/ might be best.

	David


