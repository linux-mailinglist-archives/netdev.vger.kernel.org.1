Return-Path: <netdev+bounces-244371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EAACB58FF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DC13010984
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D253064BB;
	Thu, 11 Dec 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFyGYBJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC563305045
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450276; cv=none; b=DC1vHbfZqmERO/KmTQRNcKwOeY5jfsrfJdsBQDeCojMAWl5dptTOfCz7zdX2w1lySlJuCjX0wTnLD5H2Q9DIGHTakhQWwWAV3/oGwRkRLYAv4vqvkR2KMd77opb3MGn34o58uKzrgQ2HtWmcLZ3STGluemda2FU7f4J3VTgAFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450276; c=relaxed/simple;
	bh=gdPgK4oUQDxoPyQTXewOmQ7rKJ3Ie7VIM7Tt9UK5oHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmWiSMLwIvDyi864FtoiTcf998u02BvQwOfAOv3GsL1993TuhJpl0KXuMB9G3h9RfVHnjyx3YEd4N95CQY6/gdrNfNLeyAf8KYt5s3sqSVeDtOqYEqSTG+Okcyzvj0aRmZojSiKujW5MFGJKpXey80OrC2mhYs2Vj/ysd9SkLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFyGYBJB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b91680f8so8314495e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 02:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765450270; x=1766055070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2an3+eB2aZCZFSq1MVn0GhDCcCy4mOELw1EEwhLihM=;
        b=aFyGYBJBw0FsyfNecmdAwhem3orqKPqO9bWDns0FJwv4KaUCmCwXl5DA1WzF36+xj5
         NCaBsEhWhxzGlWS0US1VNeBhBq4Ctn/wzcNwKJJZKqgv9i6D2cP/iflXUe7ci7tDW++n
         2yGdz/l6O2SvmcdXK7Pwx2TeTHU5QURFkLxmfuZ+wq7fAPZLaKDr0sQduL0pgjl0B9os
         JuY5eeYAXbbekMPohwT05uXm6UTm6uzWKT7pgO7yF5ZQ35XApHqwDeYeWGOuKakLtvHd
         npk5bUBMzmBk4xn3EpAfcAnAuQEDQoLXGwdY/T1goITUlj/mavgnuD5qWWEfiuFTIWU4
         T1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765450270; x=1766055070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i2an3+eB2aZCZFSq1MVn0GhDCcCy4mOELw1EEwhLihM=;
        b=Pg7IFHKM98rkWCli+YXl9yCe1fU+vsjR9+wbCo752uqT4KByVunxHG6L/AcUY1j/d5
         SYNBE7twIjoyVQ6oPFmtEDP/T8xr8AVeQoE3bIB8BKF2k7vVvBqkNB5JXF+06WlTvYvR
         mre89/uixO0sBJ6n/xf7X7VAy2GNCb8FZn01P4OkOD4xVPuItXuU9X1A9xj7T4aOgQHJ
         tLa/iJKjCMSQ0vM+tk6iVZaJvb6XFBA1g5CYRCKf/iml9lSAw/e0xM7pF1f1xy4Pc6k3
         KcN9XNLcnkC4QhsRUY3k+7qe2T+0Lxn+tN7CFaJv0emTbaD7J6ZZCrOMqjggY9vSzN4o
         F1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUSHpaTzwrwLh1rF8ElWIKKlBxPFUQR/WE0MbjwGKGUPJ6FK+idiv1wg3cZ5AHKK8tsOXTj0pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwEoXX5j8Vl0vZ4wwSSDnmHlz86HWRmQc96SBWjo4pqJPOO36
	kGRuI5hs7HtwzQO17/OP/ktHPIjBX5wGTTNTuXCK8KLSn9sIHvKrUYx8
X-Gm-Gg: AY/fxX5uot3XUIUXWdbY5+IK029oHAZSll6O+eJEyWXPxb3hXwtA4iuZOfwOPi/Hzp2
	xT/Ev8mMWeM+6zeYQQVCJR6Fn2n9CIzIes8ZRco987OT5frXZk8oxlxHUbfsYaJOM2NkwHyA3mD
	HUyWdLBQaLc+nJ563gPod1Up794SflpshofW8CQp7g/ICo9ruWLwWrWa6AkVA6YG031ccAgDUh4
	bzo0y6RMtHFF45grLMtR2F5sUknJ4587kgy4chQ5g/UGNXHX13qhcWcGLwPpkUeY0OhGOjhBFPV
	ZsyUnn5QsdRK5ezOxWH+24ErHDLOuMJtTBIZdUgKi4MVJ3nbw98XTMH61cj105oNl8Zi9UHYbxn
	4HUxgVOHJjrVW517TtzCp3mEfMPy3w4tiDSv43EoiAQrfYEgzaPUOF4YjGxjkjTpVUOVtK/xy7A
	NmQ00CJZmlatr1Dj+auWOObmMymqrxWlS6F424eCVpcepV4MB2jlPs
X-Google-Smtp-Source: AGHT+IEIRS9wqLxDJDlOnBNoFsFIq4s5NrTQQ7QKheGrcA1JG2VukjGU7UB3LRszvTwp9D69CgR0ew==
X-Received: by 2002:a05:600c:630d:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47a837a41bemr53664785e9.36.1765450269932;
        Thu, 11 Dec 2025 02:51:09 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f0e42asm27917245e9.14.2025.12.11.02.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:51:09 -0800 (PST)
Date: Thu, 11 Dec 2025 10:51:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 0/9] bitfield: tidy up bitfield.h
Message-ID: <20251211105107.305e4828@pumpkin>
In-Reply-To: <aTm54HCyCTm5k5ci@yury>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<aTm54HCyCTm5k5ci@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 13:20:16 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Tue, Dec 09, 2025 at 10:03:04AM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
...
> > I noticed some very long (18KB) error messages from the compiler.
> > Turned out they were errors on lines that passed GENMASK() to FIELD_PREP().
> > Since most of the #defines are already statement functions the values
> > can be copied to locals so the actual parameters only get expanded once.
> > 
> > The 'bloat' is reduced further by using a simple test to ensure 'reg'
> > is large enough, slightly simplifying the test for constant 'val' and
> > only checking 'reg' and 'val' when the parameters are present.  
> 
> So, can you share the before/after?

Not that hard to generate since the kernel makefiles will create foo.i

I would have fed the .i file though xargs - but someone broke it
(there is no option to ignore quotes, and -s70 isn't allowed).
So I used:
tr ' ' '\n' foo.i | (ll=; while read -r l; do ll1="$ll $l"; [ ${#l} = 0 -o ${#ll1} -ge 70 ] && { echo "$ll"; ll="$l";} || ll="$ll1"; done; echo "$ll")

GENMASK(hi, lo)
    ((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))

A chunk of that would be removed by changing type_max() to do
2 * (n - 1) + 1 instead of (n - 1) + n, but for unsigned types
it isn't needed.
Changing type_max(t) to (t)-1 GENMASK(hi, lo) becomes
(patch not posted...)
    ((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) + ((unsigned long)-1
    << (lo) & (unsigned long)-1 >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))
There are still four expansions of both lo and hi - but they are
usually trivial. 

You asked for this one :-)
old FIELD_GET(GENMASK(hi, lo), reg)
    ({ do { __attribute__((__noreturn__)) extern void
    __compiletime_assert_769(void) __attribute__((__error__("FIELD_GET: "
    "type of reg too small for mask"))); if (!(!(((typeof(
    _Generic((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))), char: (unsigned
    char)0, unsigned char: (unsigned char)0, signed char: (unsigned
    char)0, unsigned short: (unsigned short)0, signed short: (unsigned
    short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0,
    unsigned long: (unsigned long)0, signed long: (unsigned long)0,
    unsigned long long: (unsigned long long)0, signed long long:
    (unsigned long long)0, default: (((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))))))(((unsigned
    long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi))))))) > ((typeof(
    _Generic((reg), char: (unsigned char)0, unsigned char: (unsigned
    char)0, signed char: (unsigned char)0, unsigned short: (unsigned
    short)0, signed short: (unsigned short)0, unsigned int: (unsigned
    int)0, signed int: (unsigned int)0, unsigned long: (unsigned long)0,
    signed long: (unsigned long)0, unsigned long long: (unsigned long
    long)0, signed long long: (unsigned long long)0, default:
    (reg))))(~0ull))))) __compiletime_assert_769(); } while (0); ({ ({ do
    { __attribute__((__noreturn__)) extern void
    __compiletime_assert_770(void) __attribute__((__error__("FIELD_GET: "
    "mask is not constant"))); if (!(!(!__builtin_constant_p(((unsigned
    long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))))))
    __compiletime_assert_770(); } while (0); do {
    __attribute__((__noreturn__)) extern void
    __compiletime_assert_771(void) __attribute__((__error__("FIELD_GET: "
    "mask is zero"))); if (!(!((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) == 0)))
    __compiletime_assert_771(); } while (0); do {
    __attribute__((__noreturn__)) extern void
    __compiletime_assert_772(void) __attribute__((__error__("FIELD_GET: "
    "value too large for the field"))); if (!(!(__builtin_constant_p(0U)
    ? ~((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) >>
    (__builtin_ffsll(((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) - 1)) & (0 + (0U)) :
    0))) __compiletime_assert_772(); } while (0); do {
    __attribute__((__noreturn__)) extern void
    __compiletime_assert_773(void) __attribute__((__error__("BUILD_BUG_ON
    failed: " "(((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), \"const_true((lo) > (hi))\" \" is true\");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) + (1ULL <<
    (__builtin_ffsll(((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), \"const_true((lo) > (hi))\" \" is true\");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) - 1))) &
    (((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), \"const_true((lo) > (hi))\" \" is true\");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) + (1ULL <<
    (__builtin_ffsll(((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), \"const_true((lo) > (hi))\" \" is true\");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) - 1))) - 1)) !=
    0"))); if (!(!((((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) + (1ULL <<
    (__builtin_ffsll(((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) - 1))) &
    (((((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) + (1ULL <<
    (__builtin_ffsll(((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) - 1))) - 1)) != 0)))
    __compiletime_assert_773(); } while (0); }); (typeof(((unsigned
    long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))))(((reg) & (((unsigned
    long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi))))))) >>
    (__builtin_ffsll(((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi)))))) - 1)); }); })

new FIELD_GET(GENMASK(hi, lo), reg)
    ({ __auto_type _mask = ((unsigned long)(((int)sizeof(struct
    {_Static_assert(!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ?
    ((void *)((long)((lo) > (hi)) * 0l)) : (int *)8))), (lo) > (hi),
    false)), "const_true((lo) > (hi))" " is true");})) +
    (((typeof(unsigned long))((((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<
    (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))
    < ( typeof(unsigned long))1))))) << (lo) & ((typeof(unsigned
    long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))
    - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -
    1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -
    1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))
    >> ((sizeof(unsigned long) * 8) - 1 - (hi))))); __auto_type _reg =
    reg; ({ do { do { __attribute__((__noreturn__)) extern void
    __compiletime_assert_697(void) __attribute__((__error__("FIELD_GET: "
    "mask is not constant"))); if (!(!(!__builtin_constant_p(_mask))))
    __compiletime_assert_697(); } while (0); do {
    __attribute__((__noreturn__)) extern void
    __compiletime_assert_698(void) __attribute__((__error__("FIELD_GET: "
    "mask is zero or not contiguous"))); if (!(!((!(_mask) || ((_mask) &
    ((_mask) + ((_mask) & -(_mask)))))))) __compiletime_assert_698(); }
    while (0); } while (0); do { __attribute__((__noreturn__)) extern
    void __compiletime_assert_699(void)
    __attribute__((__error__("FIELD_GET: " "type of reg too small for
    mask"))); if (!(!(_mask + 0U + 0UL + 0ULL > ~0ULL >> (64 - 8 * sizeof
    (_reg))))) __compiletime_assert_699(); } while (0); ((_reg) &
    (_mask)) >> (__builtin_ffsll(_mask) - 1); }); })

	David


