Return-Path: <netdev+bounces-168631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E968A3FE32
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA63BDE18
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774EC2512C9;
	Fri, 21 Feb 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHcjYxJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829131CAA90;
	Fri, 21 Feb 2025 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161082; cv=none; b=PsVlpxIAVPEUPo5hCI6++KcyTIyo+0wH10Y6bwzAA54iwCVIBs3jz1j194pvrtyirSfvk5aWulXdOW/kN2/qaXPCDssBD1pUwzMmZsQ/rJ40np7uMOR9mOw3R5Sv0fVQLNtQefHu9jICmzWqh5ZuviZRdRQYGhR3V5lJhzH4OfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161082; c=relaxed/simple;
	bh=9aMZE364K486QAxLJ/ZNbxZVklK8NjPrlBoPl3rLfGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m97zb6lnlR28z+7VjDAFnYNGjsy+M/e2vPQ5egy7RlM2YxDSJyeWdArpRUegL33oi1uii+VdX64Rp10oGecKnSLdXrudloX+Ic3aV3S/KUnjBhVSyNgPoFhWSLdDLsecRl/xxitZSOT5xHeSIJ1byEX5c4fNLsKj1xFggtCr7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHcjYxJk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so20965705e9.1;
        Fri, 21 Feb 2025 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161078; x=1740765878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D08fN3Xk4KdmoYxvgS9MK5BgvFndwMmKF/+z4H8I+eA=;
        b=RHcjYxJkPS70qL97ro0iR2QK25M9hJ2ODbgqgRNKxiGaiv8NXMNprTBQnqH1T9N5Xs
         93crWZggnuYIfCaTel2LfMuZWuGdVe/AD/NQxHd7z0g4cvDsGQs13H/aEuNejPWkXlHH
         SR4/SwiX04OafMI0pSEvY3sVCCTEx1qjI2XAoxlJrdvw8T3JZBqv9GMX3bcHPiI98N9g
         Qp+vJ2PVtjcGjtW3+/Ql3T0DwRaYpXBGFnfpaVm+sUVnPTRGLTLyYZIx+qvt8BSlDotc
         EXWCIRQrSx6Myo5orRKA4tR+TaNuP4oFpyuShtRw0BAzhqz6ZuQ1uFUyLMVSb0FH4PK+
         y64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161078; x=1740765878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D08fN3Xk4KdmoYxvgS9MK5BgvFndwMmKF/+z4H8I+eA=;
        b=uKeJXW8hr/IqF481wP6vsy1bVU3k4SzRGF4NWKeU8VGNB6zgtpfXR9and37ye91CHk
         G9EeLNaQNnT4gn43eBIZ1iJhlYGtq5QMDkKtBe2ML0KRrUcQJaBxxS1yeNAUBtGh9JVU
         WzcPm2mIwZQs+rnYegzlPYfl4y0nXs7p1lAO95bkSAcOWivGXJaJIbNs6UmpFdVMxZho
         pV35nwnN0Q6RcCHxdk6DJktlVej+Ja86uP4t6WBkTYJTtQjas4MZ+l0x0WgJhMaH1NIr
         mO7+VqufRotiHuG0TLpCTEarOoNxO+KhhLWGIPskjju0xxldrEIVUDg+6Jn581podASj
         yAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz/0DRvwSGm2HZYolQ1aW5Q3AgFUY6q7ZDtBQoGpw/Ou7cuTxoOHJBniw7U1oQCrotuHChwEzxAyNBqwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFozMncfZASuBI5Gm4bxEXURU/jVoay1KkxCy52DRCDz9JCTI5
	xH7P6LhTSICxHAOSId9GHYRnTQR9BGpxAqtUPeWveiA3LljQo04x
X-Gm-Gg: ASbGncv27GBXFGe/KEB8urZ1nJe09M6H/GGLKhiVUsO8UCgAaYgR16jXyfWJicfOO2s
	xL+3uSm+VlADVRGlFP7rOdVUBDVT4I30e5GNeMOz3MptdToki6rxnylYpTW/6fVrt5MUEBxrYth
	VRShN5bDQxl+0r5G0C0F8I/W93vX/TOCdNKOVqeqHmOzHcmxigeqkkX/eYiPgtNe0V637MHXZmb
	67JZKrRZAF/PUih/hhlrD5LT47QctBq440EzxFY15wkNO5KF/+XsHO8IvzoWtqwHc8sBOWMkIzh
	zuVslckrj9s9hjCzsfAyRIdBm47mlA8GRoi+64MqU/2ItwXHO0CCPeIZ5Ss7sRp4
X-Google-Smtp-Source: AGHT+IFgnW7CtVnR30ocGrxT4E0GJCDxMkGoT4am7vr/lpqvphvlcsJFHp5NwkPWrF+K41xGbSMcYg==
X-Received: by 2002:a5d:5988:0:b0:38d:d274:4537 with SMTP id ffacd0b85a97d-38f614b54fcmr6090661f8f.7.1740161078090;
        Fri, 21 Feb 2025 10:04:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce435sm25131955e9.3.2025.02.21.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:04:37 -0800 (PST)
Date: Fri, 21 Feb 2025 18:04:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <20250221180435.4bbf8c8f@pumpkin>
In-Reply-To: <Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
	<20250219211102.225324-2-nnac123@linux.ibm.com>
	<20250220220050.61aa504d@pumpkin>
	<Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 11:37:46 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> Hi David,
> 
> On Thu, Feb 20, 2025 at 10:00:50PM +0000, David Laight wrote:
> > On Wed, 19 Feb 2025 15:11:00 -0600
> > Nick Child <nnac123@linux.ibm.com> wrote:
> >   
> > > ---
> > >  include/linux/printk.h | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index 4217a9f412b2..12e51b1cdca5 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > +				   buf, len) \
> > > +	for ((i) = 0;							\
> > > +	     (i) < (len) &&						\
> > > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > > +				(len) - (i), (rowsize), (groupsize),	\
> > > +				(linebuf), (linebuflen), false);	\  
> > 
> > You can avoid the compiler actually checking the function result
> > it you try a bit harder - see below.
> >   
> 
> This was an extra precaution against infinite loops, breaking when
> hex_dump_to_buffer returns 0 when len is 0. Technically this won't happen
> since we check i < len first, and increment i by at least 16 (though
> your proposal removes the latter assertion). 
> 
> My other thought was to check for error case by checking if
> the return value was > linebuflen. But I actually prefer the behavior
> of continuing with the truncated result.
> 
> I think I prefer it how it is rather than completely ignoring it.
> Open to other opinons though.

There are plenty of ways to generate infinite loops.
I wouldn't worry about someone passing 0 for rowsize.

> 
> > > +	     (i) += (rowsize) == 32 ? 32 : 16				\
> > > +	    )  
> > 
> > If you are doing this as a #define you really shouldn't evaluate the
> > arguments more than once.
> > I'd also not add more code that relies on the perverse and pointless
> > code that enforces rowsize of 16 or 32.
> > Maybe document it, but there is no point changing the stride without
> > doing the equivalent change to the rowsize passed to hex_dump_to_buffer.
> >   
> 
> The equivalent conditonal exists in hex_dump_to_buffer so doing it
> again seemed unnecessary. I understand your recent patch [1] is trying
> to replace the rowsize is 16 or 32 rule with rowsize is a power of 2
> and multiple of groupsize. I suppose the most straightforward and
> flexible thing the for_each loop can do is to just assume rowsize is
> valid.
> 
> > You could do:
> > #define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
> > for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
> > 	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \
          ^ needs to be buf_offset.

> > 		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
> > 	_offset += _rowsize )
> > 
> > (Assuming I've not mistyped it.)
> >   
> 
> Trying to understand the reasoning for declaring new tmp variables;
> Is this to prevent the values from changing in the body of the loop?

No, it is to prevent side-effects happening more than once.
Think about what would happen if someone passed 'foo -= 4' for len.

> I tried to avoid declaring new vars in this design because I thought it
> would recive pushback due to possible name collision and variable
> declaration inside for loop initializer.

The c std level got upped recently to allow declarations inside loops.
Usually for a 'loop iterator' - but I think you needed that to be
exposed outsize the loop.
(Otherwise you don't need _offset and buf_offset.

> I suppose both implementations come with tradeoffs.
> 
> > As soon as 'ascii' gets replaced by 'flags' you'll need to pass it through.
> >   
> 
> Yes, if hex_dump_to_buffer becomes a wrapper around a new function
> (which accepts flag arg), I think there is an opportunity for a lot
> of confusion to clear up. Old behaviour of hex_dump_to_buffer will be
> respected but the underlying function will be more flexible.

My changed version (honoring row_size) passes all the self tests.
I've not done a grep (yet) to if anything other that 16 or 32 is
actually passed.

	David

> 
> Appreciate the review!
> - Nick
> 
> [1] - https://lore.kernel.org/lkml/20250216201901.161781-1-david.laight.linux@gmail.com/


