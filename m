Return-Path: <netdev+bounces-142485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E959BF513
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8F28826D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96586206E92;
	Wed,  6 Nov 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai2G6Qr+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8F206E69;
	Wed,  6 Nov 2024 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917088; cv=none; b=ov6kvdbXI+23g2eLA4Tk5LvL3ndl9oFiF/enNiD5C2ErFkbesCsM7xPIsYYEvMc4PeIZwFu/H+wfC0vFll0JMig9adC3G44Vb6mUmWY4OBjIQbkxiMHJ43Ap7+t7UKG0qZODRhPCQf8ChculkyrVOWvKSWzYyfMkoDd+nNppimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917088; c=relaxed/simple;
	bh=JOqzxSLeHWD0n7cfTKM/sSVhPy5OUMMkSiGbDTUDwEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi7G8oQYKqHmXpP15UFPQYMzZiGZAhMDSzBwLiv3dUutLkgpUTCbMKh14YIKzNSlqO7qWNtF1+W6tn2WqMtW0Z7zWCkXsR5PGz8krPJXUh7QtDr7pvZb2YzxOmiQMYA7G3+106HJOomVa6rb4/crsLBHVJWuX0PGAX1IX0n8ZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai2G6Qr+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460b2e4c50fso702781cf.0;
        Wed, 06 Nov 2024 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730917085; x=1731521885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQwj/GWrTbMpB2h+csAzG3gf0YiNR+Wiy6DXEYYkKXY=;
        b=ai2G6Qr+EAGWmaamyvc8iGjPbv7UaLcEg7apI6IJ2PceWcFN2BGiQRuzmtsUEcvEL8
         gRwOF4g2FRNT1Dg3lpgfs5mbhYpCUHsT5eppefr5gzTjSVcJ1Vd/sUdkXnIKL67C49kZ
         3THM3LY135EhMwOcKxcF/Yw09iIjk+puF4wP/JCk/PbOeIOfuau6kWfuFbeiaZEGv8vi
         I2Q9ngnvAYGyA1AUkxk6vRH5gJZq4YdNucnein0Ug6sjtuHPOqdrrnbvJ/QKv+wxyHXA
         7qW4ejhA662cCXK7Txi1vCtVa4rA4wyhubdrmELX0UYIbWPTl1yf4tG18nXmRYm1/JQV
         jZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730917085; x=1731521885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQwj/GWrTbMpB2h+csAzG3gf0YiNR+Wiy6DXEYYkKXY=;
        b=vy1BW9i1GxSdFvyYsxrWleXtxMfuxggpUrthm9abiQFXvRo3IVv5vj7N9ztEXkt9H4
         ulJJl7HPJVpWElM9KbASS8X1YswOgHpcyHXMWV/f0h6gF1X5NDw35J/aml1U8ZG8upOC
         yI1Cb5HSaM7sGNwXtMyGm2HYWFY+D5vaBMJhJ+d8KJ7eNjQxjTQFO59a0SHdx8yVUXko
         RnxBYdOUhbRDwfmV0fUIpEgcXYOLmtXlRS3LldR2PboT9RgnHS0Dr7wysKzrjB5insHJ
         ioJnSiJB2RAwLDvIlDcKHw6JFBWqrElboxQxvirz0OLI6v9eN5PNXjGbv0YOVJXNWHit
         b+zg==
X-Forwarded-Encrypted: i=1; AJvYcCVC6jN5MmDdhzxMg0Z3st9qxN0fG2FrRXDT8/09wW0P5CgTdEUp1uxO+h3YkFltfZH2QieOItg0jmEtkGrMHYk=@vger.kernel.org, AJvYcCWgu8r3CDf/KPmEGAHVvVFz+bxxPwdmskz/tSTo+VwpKDg6Qs7s2wGqvFXlV5nzsx2PYyqBL588@vger.kernel.org, AJvYcCXDWaO2MbjvjO6t0r8AAPyzgkjPbqLcEvD9k/o1TjG76REmvg6iGLBDFdaDzq3MfsnV2G20Ow94+kvBn+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDzKAYmzN1zZPtKabax5ITE5+sSupUfYo7AtrhEzf3tSEKCwU
	VzuM18hG93nH815dEizk31hpnIU3Wez9nfgcS5S5Tk+Yh2U0YwBl
X-Google-Smtp-Source: AGHT+IHbd+iWdp0AZ8TZAWXa3c1ZwOS+r/2JbXndDVsoOY5g+73G1rcnWC8pcgBWuIsZYJpy7tWZaA==
X-Received: by 2002:a05:622a:58d:b0:460:8e3b:6790 with SMTP id d75a77b69052e-4613c1a74d0mr605708961cf.48.1730917085472;
        Wed, 06 Nov 2024 10:18:05 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462f18fd044sm10816751cf.10.2024.11.06.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:18:05 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 900D31200066;
	Wed,  6 Nov 2024 13:18:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 13:18:04 -0500
X-ME-Sender: <xms:3LIrZ5iOrx11gTigcukRQ9RCdoyQ5QS-SUMptEgYY2SqHgf8L7yK_A>
    <xme:3LIrZ-Bi8unVoVxdPGOUiydSiOZODHd6xhK2ITehAzXrgG6d0iYQuLjzzz10A2mpR
    LJHpON45QmX5U54FQ>
X-ME-Received: <xmr:3LIrZ5Gx6b7BZ6D4jaUhOg1QKwHvkEif7xgKZakAwmVOvr882lDxWocY4F0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhi
    gidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehjshhtuhhl
    thiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:3LIrZ-RMmPNreF3mQ-rm_liTbjo8K15_Ha_ng8vPkpcCnxDqxjlj_A>
    <xmx:3LIrZ2xZYWPV9VsH7ErEuXbJe71BCIt_Rt7sVypp4JZddLcxj_5liw>
    <xmx:3LIrZ063QF9vCZSMWjv3QVLsYSZnXYMdDOXWcsnk0PyKXsoa5DBzVg>
    <xmx:3LIrZ7yxw8WgkFqywVN1zpxISPc7_sgTv93r1RO766Uxv648ZOZCKQ>
    <xmx:3LIrZ-hhAvDFEDwuCXnVU61RZ_ke3YwDGwvkfoKWlIwAbl_434YbyEik>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 13:18:04 -0500 (EST)
Date: Wed, 6 Nov 2024 10:18:03 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
Message-ID: <Zyuy25viG51DDRk7@Boquns-Mac-mini.local>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101010121.69221-7-fujita.tomonori@gmail.com>

On Fri, Nov 01, 2024 at 10:01:20AM +0900, FUJITA Tomonori wrote:
[...]
> @@ -44,6 +45,7 @@
>  pub mod page;
>  pub mod prelude;
>  pub mod print;
> +pub mod processor;
>  pub mod sizes;
>  pub mod rbtree;
>  mod static_assert;
> diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
> new file mode 100644
> index 000000000000..eeeff4be84fa
> --- /dev/null
> +++ b/rust/kernel/processor.rs

What else would we put into this file? `smp_processor_id()` and IPI
functionality? If so, I would probably want to rename this to cpu.rs.

Regards,
Boqun

> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Processor related primitives.
> +//!
> +//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h).
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
> +///
> +/// It also happens to serve as a compiler barrier.
> +pub fn cpu_relax() {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::cpu_relax() }
> +}
> -- 
> 2.43.0
> 
> 

