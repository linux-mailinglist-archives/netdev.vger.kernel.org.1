Return-Path: <netdev+bounces-274714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFFQD+/rzmn/rwYAu9opvQ
	(envelope-from <netdev+bounces-274714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:21:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895738EC30
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E325430131C2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808E3C7DF0;
	Thu,  2 Apr 2026 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIdXPFjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2879388380
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168492; cv=none; b=anUC6lqbME12xzgL7fECgokHfTx0knjRI6tDqDaSxAnH0QYmsFF/x/apRkEDjG9zKadZxreGw4gCtSZ59T0bEV0tLPCOXMJD97bJyJDW3/mlWmwBcKclJMjJHyPppvhi5OI2hjt1+yGwW2M0GwSjtPjxkUmQNCbdqRz4mbTMofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168492; c=relaxed/simple;
	bh=JO36LpQ5gVtcWZ8brznoqUIkSZhSat8fICNZkux4Jcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1GZkYqd2dTJuUHVqsorMgicOeJxwGxBXu6140gO6CAteaXD/tx7vhNnvKVQ+VjFSQVfrvunh1nt5rOJvQV8Qd1rq+AsOLSkKc/Ir+u72Dlf8Fp7nFzA93WPaDAfzvehwry8BzZ2znh4loyQ/Fvfk5gGKfrI4MlAPofnP7387Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIdXPFjy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso5358445e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168489; x=1775773289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI/NcwHPy2CKiwxvNl8NgCnSDMnJLWJEe2Db1Alx/A0=;
        b=DIdXPFjyvyE29tkijnDmXva+c7sPAamv1XeBVojQCohIdwx/KbzLwMcxltCGsPqDbu
         8XFQr1wZp5xmx7VsWMj9Klk9xHq6gdbUF4P/1GWceV7Hq+NV8IYPYNGoQg5Cw4goeU72
         UCInCS7IFd8XvTUSFNBIFqmnRQ2tPC8FliuBHt5uqUtOR1RkMJ+fUhO1NhM1pLd4N6Vq
         LDxlQ+/0IzP7XRWsoEru2bpPo47TTyeFgEcUNke77+rA7BsL7Q7XfoDUxQ/6aMVxGmiF
         vhvfTF6G90MpTE78Rj8Gu0NphSRBPbJ9ZwiChfHW5cfxRPGbi3Epn66ImphiXZK/JN5H
         P0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168489; x=1775773289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dI/NcwHPy2CKiwxvNl8NgCnSDMnJLWJEe2Db1Alx/A0=;
        b=ZNRg37FGEBxLSADXCWgoTngQMPEgyQhn2za6sLsHTy2zLJs/3tTkLc1ROkmYuEyQ5m
         VT6iP0gbTbGg6wfMDvGyhiU8R2rC/JYHl6+d7r3io0Tca32ZO4hObA7l+uDaHzc1Tf2Q
         nuDVBGxVBqjXHrsOizBfMHv1zsYI08xXOFsiwq40FGGZy8NBb8EOK8YcvJbhnz7Od9U5
         4wmJBpklz5cGdMtSFmLzPOyHlUzYStt211ShnIW7FQaEu0Nex7MupB34tqJg8rJwwiL2
         bYgZ/0MVt/WQWPoU9YdMwNXPD9iB/u+OoOPe+PP/Bktpc6t1nBl6qnlyA5Y2U+kK+GQh
         l+cw==
X-Forwarded-Encrypted: i=1; AJvYcCXIYD5vlO72s0Qe6XyTUC3JRNr+pf7a1Iq8UTDsqsZlnn49OFmLf3qEX0o8ZJYOPa21z0tGKOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0YP4RiDptWKpI2jk8rnWMgxjNds2S6aQzbdPskTbpql1TXs4
	5kECSNCmxG8pUs0vhICy2bZMbCH3eHnkvLuTf2VPqlLvHQcWxC/MizY+
X-Gm-Gg: ATEYQzyClpBSLrTTc4Xo9jDw8bLp1xcQjXATCOTixdyDhxH0dP/iRFV/QZyaL9if6WH
	5KzzVz/1KZaEt1kaNSZRU41qDFUQ/oK+s/dB12Ix2a1sXyDFOz4+EvXzjsvyB4NYzE+pom8gBJs
	RFLUt3aBDNHZzZacd7w15FAp/GYcsGESoMJI4v2HiNEDlRMNvYnWu0O7V8T9no6zT1lUWwrCim1
	z+bEMKCBnpQmk2jY0Vt/OTDdyZgn2yYqAmrx+aH5Mn6eLo923ReVSZKwdwnNiOyhxGOn3Q+gxlC
	QBY8Fdq/RuzAZT8pCQzBz4zzsVigmd8F/zj3B4HXvluK6dsaWh+lhQMobWl/5LDeR6WAdDvua8d
	qkXuhM/MzfdLsUMoKWB7VxVd4nNb7Up7fWl+K5l88U3VPNpfWYUuctrcifQX/jY5xjzf2bm7jXo
	Rvv2NeWfG3CWA4rdJviidCbAHzKyVtqV5iImzjK9wBH46yJND9ivUpwqi84ZD3
X-Received: by 2002:a05:600c:a4a:b0:488:7f69:4abf with SMTP id 5b1f17b1804b1-488997426f9mr10489185e9.12.1775168488839;
        Thu, 02 Apr 2026 15:21:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e832585sm415970045e9.6.2026.04.02.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:21:28 -0700 (PDT)
Date: Thu, 2 Apr 2026 23:21:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Message-ID: <20260402232126.2e74631e@pumpkin>
In-Reply-To: <ac50sX3MZAcVSNJo@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
	<20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
	<acx_1dOF3EjvGt4B@yury>
	<CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
	<20260402102717.5eb48393@pumpkin>
	<ac50sX3MZAcVSNJo@yury>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274714-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 6895738EC30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 09:52:49 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> On Thu, Apr 02, 2026 at 10:27:17AM +0100, David Laight wrote:
> > On Thu, 2 Apr 2026 01:00:20 -0300
> > Luiz Angelo Daros de Luca <luizluca@gmail.com> wrote:
> >   
> > > > > +/**
> > > > > + * FIELD_WIDTH() - return the width of a bitfield
> > > > > + * @_mask: shifted mask defining the field's length and position
> > > > > + *
> > > > > + * Returns the number of contiguous bits covered by @_mask.
> > > > > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > > > > + */
> > > > > +#define FIELD_WIDTH(_mask)                                           \    
> > > >
> > > > Please no underscored names unless necessary.    
> > > 
> > > I used _mask to maintain consistency with the existing public macros
> > > in this file, such as FIELD_GET, FIELD_PREP, FIELD_MAX, and FIELD_FIT.
> > > All of them use the underscore prefix for parameters. Should I diverge
> > > from them?
> > >   
> > > > > +     ({                                                              \
> > > > > +             __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");   \
> > > > > +             __bf_shf(~FIELD_MAX(_mask));                            \
> > > > > +     })    
> > > >
> > > > I believe, this should be:
> > > >
> > > >   #define FIELD_WIDTH(mask) ({                                  \
> > > >         __BF_FIELD_CHECK_MASK(mask, 0ULL, "FIELD_WIDTH: ");     \
> > > >         HWEIGHT(mask);                                          \
> > > >   })    
> > > 
> > > HWEIGHT() is indeed much cleaner. However, to keep bitfield.h
> > > self-contained and avoid adding more includes, I'll try
> > > __builtin_popcountll() in a similar way __builtin_ffsll is already
> > > used.
> > > 
> > > I also noticed the suggestion to use __BF_FIELD_CHECK_MASK instead of
> > > __BF_FIELD_CHECK. Both FIELD_MAX and FIELD_FIT currently use the full
> > > __BF_FIELD_CHECK with 0ULL as a dummy register to ensure the mask fits
> > > within the header's supported limits. If __BF_FIELD_CHECK_MASK is
> > > preferred for FIELD_WIDTH, I can certainly use it, but should we also
> > > update FIELD_MAX and FIELD_FIT for consistency?  
> > 
> > All of the calls with the 0ULL placeholder (especially for the register)
> > should really be removed.
> > Last time I looked there where some calls that only had placeholders.
> > They just bloat the pre-processor output and slow down compilation.  
> 
> Have you any numbers? Can you send a patch?

It was all in a patch I send a while back.
Basically GENMASK() is a couple of hundred bytes and FIELD_PREP(GENMASK())
hits a few thousand due to the number of times mask (in particular)
get expanded.

The problem was bit-fields...

> 
> > > I intend to send a v2 with the following implementation:
> > > 
> > > #define __bf_shf(x) (__builtin_ffsll(x) - 1)
> > > +#define __bf_hweight(x) __builtin_popcountll(x)
> > > 
> > > #define __scalar_type_to_unsigned_cases(type)                          \
> > >                unsigned type:  (unsigned type)0,                       \
> > > @@ -111,6 +112,19 @@
> > >                (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
> > >        })
> > > 
> > > +/**
> > > + * FIELD_WIDTH() - return the width of a bitfield
> > > + * @_mask: shifted mask defining the field's length and position
> > > + *
> > > + * Returns the number of contiguous bits covered by @_mask.
> > > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > > + */
> > > +#define FIELD_WIDTH(_mask)                                             \
> > > +       ({                                                              \  
> > 
> > You ought to have:
> > 		auto _fw_mask = mask;
> > here. While _mask has to be a constant, if it comes from GENMASK()
> > it is very long.  
> 
> Yes, but what this _fw means? Here it could be just auto __mask = mask.
> That is what the underscores are used.

The problems arise when the expansions get nested.
Using unique names is compex (and unreadable).
Provided only different defines are nested it is enough to use
different names in each one.

> 
> > > +               __BF_FIELD_CHECK_MASK(_mask, 0ULL, "FIELD_WIDTH: ");   \
> > > +               (typeof(_mask))__bf_hweight(_mask);                     \  
> > 
> > Why the cast of the result?
> > They are everywhere in that file, and many are pointless.
> > But there is no point adding another one.
> > 
> > I'm not even sure you need the extra define.
> > Just use __builtin_popcountll().  
> 
> For __BF_FIELD_CHECK_MASK() check, I guess.

I meant why have __bf_hweight().

	David



