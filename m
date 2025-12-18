Return-Path: <netdev+bounces-245258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD8CC9DEC
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D57643020343
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396611A8F84;
	Thu, 18 Dec 2025 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHinvTbx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD717A2FC
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766016974; cv=none; b=ItYSlBGb7DHsLx0BOHqRrbDF1iGUrfqnLkS6iziqoksbehwdnCP/1NPvR5xB3Wo0fK+3TZbuMUDKdNzpuxxbtVLLMlmaVy2iRg+NGEY+1kKJkzKlPB0pDFmdV2iGeLjlBttPy8OOPu3ACmvnGhLghQmM0wKev7SWFnFvYgRs1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766016974; c=relaxed/simple;
	bh=q1qmuBmza8VfaF3Afck0gRS869aOeEUoNVUKKya/bPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAWB2SKiYkqGlsrPsDNsxcszoWsjkwTiPY+xIlWjM5MeOZ1YY0rKCsdTyQWOU2obD+F0P2+dm3nYuoo5PiIKeS7C3c05BUTJ2b8qfe7swezpkT/TeBB8PHG85zWlz2BWxXRN/drBhbBxkTzbQ8aT5oGdTMP1V3Momf/4yYHek/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHinvTbx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78e7ba9fc29so276967b3.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 16:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766016971; x=1766621771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wlE8EMvGYZyAfYwBWrqMm3bD5k/3jSk7d8mDOagPfI=;
        b=LHinvTbxnwVcoDOIbtWzGxpZlxOsmfwb+PhUXmGfIRhBxuxtMVxZcUR4GGL+hMaqQG
         uNkIG+DCd4rUIB5JgAJM4FQFAmF61ml3JA0E/amvqxN9bwDzlVN5A4fpdKRaMakQ2wpF
         jEoZBl1sAYyRZg8laPBpj06jCLLXy7Z1wL/b6I6JQ4mJA1WquovXJ6M3/FHY8CZK/x7L
         pPOF6uMlVbsb5LHLDkvQLBpxb+ao1cdEGrGCJV1xGAvRXG8fDPT4W3bUOnQkJ0jSFwy9
         8qP3TbgjAPwwFjwzzNjdW3dN/+CNnzOJV9T+O8G3mX4zOzujZWYcYRX+2phof4ITj/MR
         ZEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766016971; x=1766621771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wlE8EMvGYZyAfYwBWrqMm3bD5k/3jSk7d8mDOagPfI=;
        b=CkGdbhA4sIWKeLK8ToWogEo6YQtSzhUZ/FYl1B0y8MXp2b61Y1kMjKAhNuRc7zGiJF
         ZpYAvf4iI7moD0b1qZQB4VEFDlxM4by7Lh6Go0onsu9NHpZ3sYTzH2m7nVnr24uvSiSQ
         cvZSQ/dnqWijvS+h75Yq4hcho/5wx++jYC08krYIuahzs8lJwAnSn9zpHuAlxN6iXHC7
         zgX/tC4yLCCgBZ/+eZIBvcZeQjx/pTOisDB05P7OxCFoTtCy7Z+k5S1HrrjcF5ohM7O3
         jCfkt1lohLQTfaZBz51YHHmdp9iXHqn4wF4Uq3vlue1ZCuhJN+y2+LXlHvKqWCivbTaW
         lMgA==
X-Forwarded-Encrypted: i=1; AJvYcCXtz+RElA+J/j8mrrXWS79KbHIRHn9sI3vv/swdbcvxNvH51TN+L2nZY9W5tHvS7ODDIKJQ/pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3ukS6WdXHlgFfRKP6y1otyyq+yYYH7Lz9DFvjcY7xLDebnbS
	lxM8bqAHg3AyBDn0uqvSKi06sR99mF2WpYTvsevDgxOzu+NEdg78qH7r
X-Gm-Gg: AY/fxX7H5Z6PcWzIa0IerYYlqOwj16D8E5CGDtU2JE0CdRn8HGTr5hs0L+MXxcqq5Gv
	yCd8TsrorBj8L5xm1X59/aUVZIokaJptN8xmMpYY/irZVnoMpGPQ0M1bhabNcpqG9sn8wxsF2Qh
	airJm26ZXMu9DJKVFsG1qc2vCdOYaQ3il4jnB9nvaHE+Cu7faXHxCZrYWcRQtVgVrwAEt6WK/Bt
	fI/baTsVJevi+FFFgRZr6725Yghbo+zQJjj5MD/oo9LnxInz1Ih8gVLPQudlyOnHCaFmJYZaqt9
	5RMJ/MXdc55zRjEG6Xk55sxHULEVE7yJhj2C/5nKkt6nZZePKTBHDmwtsBuxe1IQgYDNF5G18fA
	RJorF6Y9sb3Gwl/uLwTF0yNdTBMH5tb0ds1Y5tDeS48HYTc+7v6c6g48aA9sav3pMBoy4dDHE04
	YNKE6tvuE=
X-Google-Smtp-Source: AGHT+IHqImXHRFrZT3XyJarbiuJdBni3A40c6SKiUdO+XjAYNcXK5lXxWE1jISl+My5MBXmoC4N2uA==
X-Received: by 2002:a05:690c:6004:b0:786:5c6f:d242 with SMTP id 00721157ae682-78e66eaaba2mr159494997b3.69.1766016971272;
        Wed, 17 Dec 2025 16:16:11 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:52c0:aec0:bf15:a891])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa72aa1casm2473007b3.48.2025.12.17.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:16:10 -0800 (PST)
Date: Wed, 17 Dec 2025 19:16:10 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Message-ID: <aUNHyjKS9b2KwdGJ@yury>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
 <20251212193721.740055-4-david.laight.linux@gmail.com>
 <5257288.LvFx2qVVIh@workhorse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5257288.LvFx2qVVIh@workhorse>

On Wed, Dec 17, 2025 at 02:22:32PM +0100, Nicolas Frattaroli wrote:
> On Friday, 12 December 2025 20:37:08 Central European Standard Time david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > not be used outside bitfield) and open-coding the generation of the
> > masked value, just call FIELD_PREP() and add an extra check for
> > the mask being at most 16 bits.
> > The extra check is added after calling FIELD_PREP() to get a sane
> > error message if 'mask' isn't constant.
> > 
> > Remove the leading _ from the formal parameter names.
> > Prefix the local variables with _wm16_ to hopefully make them
> > unique.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > 
> > Changes for v2:
> > - Update kerneldoc to match changed formal parameter names.
> > - Change local variables to not collide with those in FIELD_PREP().
> > 
> > Most of the examples are constants and get optimised away.
> > 
> >  include/linux/hw_bitfield.h | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
> > index df202e167ce4..0bd1040a5f93 100644
> > --- a/include/linux/hw_bitfield.h
> > +++ b/include/linux/hw_bitfield.h
> > @@ -12,8 +12,8 @@
> >  
> >  /**
> >   * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
> > - * @_mask: shifted mask defining the field's length and position
> > - * @_val:  value to put in the field
> > + * @mask: shifted mask defining the field's length and position
> > + * @val:  value to put in the field
> >   *
> >   * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
> >   * result with the mask shifted up by 16.
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
> > +	__auto_type _wm16_mask = mask;				\
> > +	u32 _wm16_val = FIELD_PREP(_wm16_mask, val);		\
> > +	BUILD_BUG_ON_MSG(_wm16_mask > 0xffffu,			\
> > +			 "FIELD_PREP_WM16: mask too large");	\
> > +	_wm16_val | (_wm16_mask << 16);				\
> > +})
> >  
> >  /**
> >   * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
> > 
> 
> Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Compiled it with my usual config and booted it on a board that uses
> drivers that make use of these macros, and checked that things are
> working.

Nicolas, thanks for testing! Would you also want to add an explicit
ack or review tag?

David, I'm OK with this change. Please add bloat-o-meter and code
generation examples, and minimize the diff as I asked in v1, before I
can merge it.

Thanks,
Yury

