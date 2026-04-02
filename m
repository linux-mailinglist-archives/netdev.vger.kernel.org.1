Return-Path: <netdev+bounces-274445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGRdOrk3zmmAmAYAu9opvQ
	(envelope-from <netdev+bounces-274445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:32:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF2386F8D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A71AB312DB86
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36EC3803C1;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkh6fBFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46038BF80
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122052; cv=none; b=CZVOAMGZbyc1KEyhZkpol/lCRubLBj4jIpMBx0DHDekNNSTHIAO7QDa6MCvPlRAj4MsWQ2eKoRTISVALkrGwXY8/q/qsVExf19siZlKCu6CDLOkr1NwEXsP0w5GZ8EsO5I3ymjQKQ6GLLCKqdjGRZdsA0yg32uRcoPT7aEXBLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122052; c=relaxed/simple;
	bh=vGu0j1BWdrTbhRQ4Oaw/kZt4VRjMGk3aihw1/eBe/b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkUT7OHbt5dwBQaUMmmgHGtYEJE5KNjvjujc/JlHKBJYWnZA86FcBUndx382MgjyAQ6J74J7rI1fp5jbiny9gW8SgcjdUBA8r++XAtBfapJi/WE4kWw15gZ3JevNH2aJZ+cFUm1luZlHDEAIemaw4iXn8OdQvVoFMxqIdYMRaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkh6fBFa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb439299so5647955e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122040; x=1775726840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YINHRsfnSuEmSggTqij5TiRWncArUtra2UoEEP8ANg=;
        b=bkh6fBFa885MMREHG+4D8eUs1K/Q1RHpjoisKPctszwxao0trO+Xyrdq+pCoEkEU5/
         1b6t+jW1lw9wUAULyfh/a9NH+s8lxbYeon4siIddgiKFQr/KfUpwAYfEakz0xyj79M81
         HI4DVZSYvHp4tcHabTeVOUbBiKcBNAcwvA5NSvhLvkitk4enqGgLoglwFuFDfyGBInxZ
         N4GWnN2ORpUe8WyA6aWD4fQ6YEm80FJeqnzqzKsNp+TnNM7q8wuPFn5A8bK4GFzQzt8a
         F3Zz87xwY9gGqYHlV86fB7j5P7+bA9PZ+go9reaKNTm3i9frRhCHzxiaSsj5MMdgP+gp
         Fflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122040; x=1775726840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YINHRsfnSuEmSggTqij5TiRWncArUtra2UoEEP8ANg=;
        b=D5l9PkUk8dBcqvEZoaNSapsPT6egbwHhnN8V5zpjx0LmLEYgRa/Mse6LKA1PMqTyff
         KDJbBcnluztpKsnapE3WqvF8Rq0Bjf7R/VPKal7GYHPlRmRMDWoYJFWnTW7txnitrl78
         7aFP+vab1QZaEWqW4DDgZdhMr/vXYRxTr+SkKJE1EPjXY0v37wJYqrRkrObvm2ed7sFe
         HJ3WM8wz+clQ4lCCfcm0CEC1OJxdSjwPaOB89rGeVNGP2cIh1lcx8TDbbXKzM8+8T/O6
         3+VnvO+vYXl5HE5sT5j2EupNl/X/U1lq/Dmb8tW1mkD886Xl5XQ40XrBlTyzZjmeTdts
         hH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlxCiuluvlKs/a8qFJfYKFArawQ9gJ8TKdwwzXmB1jDPJCgnbLBXewYJbJ6705gvXt7NSnlSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEjrI1PVKA2YnXAD9GIZOgXrjYF67p7xLK+jeTH8SQu2lxk1L
	XxTe2Gcu5BAGSQmmXoygNL/wNq44wQ9eqDysFY2byF1wnxcUmRACY1uj
X-Gm-Gg: ATEYQzxl7iFSUhuOkFO7jl7GHhDZ1Ij1csTY1rOinHw0N8zKQ1hs90so15feXmF+mfI
	X0K8WPcZDj4F3EOCAw3ejJcjt8qpW/1iRuAxvRbQkywnZO3HxfW9X72dHLeV3y4JuOFX3+30vZp
	FvkXLNaDfaHSqNdFsH7yiJNMTFikeU4kUIK93TO+Szxc31KeDglyZ1mLVweuk42UBREwE8FG+++
	SWsWYWDz20x9iiZ4eBJFhZL1uek6F1HEbivBCMF5HUzDCm2V5IcmXOAoLrj8+kRGiGuZ6Zn9CIt
	vPx4sqy/l6laJkWyMLUZ1wPTKfvZlJSykBfGA/Z7DyqNpGnzQ+jfKPXgwoB5kginCBdnJtU4OpY
	2SlHfLqWAgdzJQC0L2mfU0ihM3lzgEU8fpkYUk2LrNAQbZMoqyfoM0VelJStYIA5PTX7IYYSe4r
	E2XHYAYtbj5napngDUfhwzvnBRE+2feaaPO/WmoZ0Cv4r+Vs/qO62LhaI61tgI
X-Received: by 2002:a05:600c:1f11:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-48883568b02mr113620225e9.2.1775122039987;
        Thu, 02 Apr 2026 02:27:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adadf4fsm63280675e9.11.2026.04.02.02.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:27:19 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:27:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <20260402102717.5eb48393@pumpkin>
In-Reply-To: <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
	<20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
	<acx_1dOF3EjvGt4B@yury>
	<CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274445-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 67FF2386F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 01:00:20 -0300
Luiz Angelo Daros de Luca <luizluca@gmail.com> wrote:

> > > +/**
> > > + * FIELD_WIDTH() - return the width of a bitfield
> > > + * @_mask: shifted mask defining the field's length and position
> > > + *
> > > + * Returns the number of contiguous bits covered by @_mask.
> > > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > > + */
> > > +#define FIELD_WIDTH(_mask)                                           \  
> >
> > Please no underscored names unless necessary.  
> 
> I used _mask to maintain consistency with the existing public macros
> in this file, such as FIELD_GET, FIELD_PREP, FIELD_MAX, and FIELD_FIT.
> All of them use the underscore prefix for parameters. Should I diverge
> from them?
> 
> > > +     ({                                                              \
> > > +             __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");   \
> > > +             __bf_shf(~FIELD_MAX(_mask));                            \
> > > +     })  
> >
> > I believe, this should be:
> >
> >   #define FIELD_WIDTH(mask) ({                                  \
> >         __BF_FIELD_CHECK_MASK(mask, 0ULL, "FIELD_WIDTH: ");     \
> >         HWEIGHT(mask);                                          \
> >   })  
> 
> HWEIGHT() is indeed much cleaner. However, to keep bitfield.h
> self-contained and avoid adding more includes, I'll try
> __builtin_popcountll() in a similar way __builtin_ffsll is already
> used.
> 
> I also noticed the suggestion to use __BF_FIELD_CHECK_MASK instead of
> __BF_FIELD_CHECK. Both FIELD_MAX and FIELD_FIT currently use the full
> __BF_FIELD_CHECK with 0ULL as a dummy register to ensure the mask fits
> within the header's supported limits. If __BF_FIELD_CHECK_MASK is
> preferred for FIELD_WIDTH, I can certainly use it, but should we also
> update FIELD_MAX and FIELD_FIT for consistency?

All of the calls with the 0ULL placeholder (especially for the register)
should really be removed.
Last time I looked there where some calls that only had placeholders.
They just bloat the pre-processor output and slow down compilation.

> 
> I intend to send a v2 with the following implementation:
> 
> #define __bf_shf(x) (__builtin_ffsll(x) - 1)
> +#define __bf_hweight(x) __builtin_popcountll(x)
> 
> #define __scalar_type_to_unsigned_cases(type)                          \
>                unsigned type:  (unsigned type)0,                       \
> @@ -111,6 +112,19 @@
>                (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
>        })
> 
> +/**
> + * FIELD_WIDTH() - return the width of a bitfield
> + * @_mask: shifted mask defining the field's length and position
> + *
> + * Returns the number of contiguous bits covered by @_mask.
> + * This corresponds to the bit width of FIELD_MAX(@_mask).
> + */
> +#define FIELD_WIDTH(_mask)                                             \
> +       ({                                                              \

You ought to have:
		auto _fw_mask = mask;
here. While _mask has to be a constant, if it comes from GENMASK()
it is very long.

> +               __BF_FIELD_CHECK_MASK(_mask, 0ULL, "FIELD_WIDTH: ");   \
> +               (typeof(_mask))__bf_hweight(_mask);                     \

Why the cast of the result?
They are everywhere in that file, and many are pointless.
But there is no point adding another one.

I'm not even sure you need the extra define.
Just use __builtin_popcountll().

	David

> +       })
> +
> 
> Regards,
> 
> Luiz
> 


