Return-Path: <netdev+bounces-131573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A884B98EE8B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D96281F49
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50541154458;
	Thu,  3 Oct 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltZNEix7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149726AD4;
	Thu,  3 Oct 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956439; cv=none; b=fUl+4VEwkMdbjaW7E4tWysBAZrvhucMaNc2OEZ7Z1530n1USZu3eklZI+uui51i4szZhLCAV9umAm2xOIWzperAzoC4nJRIwgR6Aj0YyARM6OsNQFxLh11K4yO491cUKky/mnQ5QGqP3RDpRsUNclUCUDY1skqD9+0CKfW8qBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956439; c=relaxed/simple;
	bh=TGFkB0ZU1084qqYwIZPU+rqqdVN4fxP/5S7teQIuw9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrBysT9D4jJRQpG6rJGPgKBDh4BD3KZqMcsAYfFiFC+o8UrmAbGuerj/78izpM0F+LVNyXEga67kRKAOiL5YB+BaewQlEab525kUqAHTaJKQP4gjaJhQ9sYO7dFYV3+L/dVqLzjAPCLm1JctYrvk0OprxH1pojIas2EaIcaK2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltZNEix7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9b3cd75e5so88911285a.0;
        Thu, 03 Oct 2024 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956436; x=1728561236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBbY3/3NZlklc4+wp5IevCmEX3q1+eNI0S2tK1cSF+4=;
        b=ltZNEix7D2dS+8NjkZfYuvGLs6dM7LNxBGSbo50nEThDHCABrOenSnJWX53oHsiodt
         huMi9J1QHcVHZtdgZOVwa4eaiJNVZaniORjikgHzhrjmhe8uY8+Iob0lfbPJQtlCfxcg
         OlLffdvJgkpsh9YC8sNFLknmJHMfdLQKzwo4PaP4cBbs6dgUcF6RFTOR08bYxPLWTnlc
         vFYXCwtuA480auTw9Wn37FYeH/3ReQHK1mjKPc5zxo2T0Y1j9PD9LE2yb/+EazO0/GGC
         m8B7l//15Dqhgch5A6mIL4FHRGiqHZMjTe0DS7IlC3W8JJnzIRhgpCnmR3oXzQ5At6kn
         blCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956436; x=1728561236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBbY3/3NZlklc4+wp5IevCmEX3q1+eNI0S2tK1cSF+4=;
        b=K7HRH9wHf+kitUWIJnQqEd/XLhkh1o6+1oe1xinL9ZptuMxE5OGoQAqzY9p2wwtZZv
         9xiU+n3Ia+KQBN59UCUDDJIwP8QtXj1Ry2vXPXbo96NoSg5moegFMfYupfioq3oQk7br
         veWM9CoW/GOGH/qbBt4q1eT3ub7ZycFhdwx790cK1ypTE++odCw6vxtSKtswy8wj6gfe
         YP62XLWXEpr6+1upbLVe+89mxJdDZmCXe06Cm3I/YZ0MaOphBG9oXmW+qvhvtGj+MBYd
         IZgK94nj8CXcCoEXxXKgk0tI5jhzH7N5NQ7aBJI9ZEUlFkkeIXFgyXZ68kiAZSFppPkb
         dllQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMSBOgnQCQzPm06SSIzYwKN6bMKXwErIf+eOhRHf4vFWSvhMaqgHAdDLz45nDmgyTm885esQ=@vger.kernel.org, AJvYcCVNH6NCJvRO7AIcrvNWS2fTThnmunWq/4l0CaTuCZVCP8kvul1OdcGff1PJom9eITZtM0wFBap+dbyQSX3bUp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3msn7VCkZa/Kt1E460GjyqkOn9kSxnY8oGrr2tg08+hFTLsS
	Mme8djQkB9dZbkpEngAPlQcIvWpKM7Nx5ONbsu6tJicT7+vAWAKO
X-Google-Smtp-Source: AGHT+IGX0ojD/sD7RWnSU8gUdjbCkDbb+mJzZ8qrpRDvD+bi+2CS1Fu4xPi+HoxmeC6YrsWKtCwyQw==
X-Received: by 2002:a05:6214:5782:b0:6cb:45e3:11b0 with SMTP id 6a1803df08f44-6cb81cc5401mr109929536d6.47.1727956436443;
        Thu, 03 Oct 2024 04:53:56 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb935a6fdfsm5831186d6.12.2024.10.03.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:53:55 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5EB361200068;
	Thu,  3 Oct 2024 07:53:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 03 Oct 2024 07:53:55 -0400
X-ME-Sender: <xms:04X-ZtoKwiCwJkbO__2QbKQtGjqnw7bY4uepMBo9sxa-alib08nZfA>
    <xme:04X-ZvqWTJ2I_GPj3M0sH7oWntMM13mvErljCZx4L9le5bhHeF4Ec0bBJ9wG4NmeG
    lWzv1AkvfIWPFrEKg>
X-ME-Received: <xmr:04X-ZqM8GbvhlrdOXhc3fOJG5Zn9uzuRU91cmRRHESBMBvfdvje7_6v-6aSPnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepughirhhkrdgsvghhmhgvseguvgdrsghoshgthhdr
    tghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrlh
    hitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugi
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhkhgrlhhlfigvihhtudes
    ghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupd
    hrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:04X-Zo6vYNt76VafX9Cwy18bh97EuxXpEv82zjN_chjwwO9-gIIFUA>
    <xmx:04X-Zs4XEH2jNOnzN55WOuCDzptXjNdzEAqQ3TEF-oOA6D6BEMa3-w>
    <xmx:04X-ZgjTC8xSzFOQaYs5TUwVJzkXHdpkP-W0QHWZ2neu7KIk91e0LA>
    <xmx:04X-Zu6bn24CwqbXo1Nl_GkdTaEcv8btf2IheoYRx3ujC9pPxx_sqw>
    <xmx:04X-ZjIFJqy9PmBLzuTfv5J0t2ICMF7aUdTq4TXAb0g6WO-2qAijKdVl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 07:53:54 -0400 (EDT)
Date: Thu, 3 Oct 2024 04:52:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: dirk.behme@de.bosch.com, andrew@lunn.ch, aliceryhl@google.com,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
Message-ID: <Zv6FkGIMoh6PTdKY@boqun-archlinux>
References: <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
 <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
 <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
 <20241002.095636.680321517586867502.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002.095636.680321517586867502.fujita.tomonori@gmail.com>

On Wed, Oct 02, 2024 at 09:56:36AM +0000, FUJITA Tomonori wrote:
> On Wed, 2 Oct 2024 06:39:48 +0200
> Dirk Behme <dirk.behme@de.bosch.com> wrote:
> 
> >> I generally point developers at iopoll.h, because developers nearly
> >> always get this sort of polling for something to happen wrong.
> >> The kernel sleep functions guarantee the minimum sleep time. They say
> >> nothing about the maximum sleep time. You can ask it to sleep for 1ms,
> >> and in reality, due to something stealing the CPU and not being RT
> >> friendly, it actually sleeps for 10ms. This extra long sleep time
> >> blows straight past your timeout, if you have a time based timeout.
> >> What most developers do is after the sleep() returns they check to see
> >> if the timeout has been reached and then exit with -ETIMEDOUT. They
> >> don't check the state of the hardware, which given its had a long time
> >> to do its thing, probably is now in a good state. But the function
> >> returns -ETIMEDOUT.
> >> There should always be a check of the hardware state after the sleep,
> >> in order to determine ETIMEDOUT vs 0.
> >> As i said, most C developers get this wrong. So i don't really see why
> >> Rust developers also will not get this wrong. So i like to discourage
> >> this sort of code, and have Rust implementations of iopoll.h.
> > 
> > 
> > Do we talk about some simple Rust wrappers for the macros in iopoll.h?
> > E.g. something like [1]?
> > 
> > Or are we talking about some more complex (safety) dependencies which
> > need some more complex abstraction handling?
> 
> (snip)
> 
> > int rust_helper_readb_poll_timeout(const volatile void * addr,
> >                                   u64 val, u64 cond, u64 delay_us,
> >                                   u64 timeout_us)
> > {
> >        return readb_poll_timeout(addr, val, cond, delay_us, timeout_us);
> > }
> 
> I'm not sure a simple wrapper for iopoll.h works. We need to pass a
> function. I'm testing a macro like the following (not added ktime
> timeout yet):

You could use closure as a parameter to avoid macro interface, something
like:

	fn read_poll_timeout<Op, Cond, T>(
	    op: Op,
	    cond: Cond,
	    sleep: Delta,
	    timeout: Delta,
	) -> Result<T> where
	    Op: Fn() -> T,
	    cond: Fn() -> bool {

	    let __timeout = kernel::Ktime::ktime_get() + timeout;

	    let val = loop {
		let val = op();
		if cond() {
		    break Some(val);
		}
		kernel::delay::sleep(sleep);

		if __timeout.after(kernel::Ktime::ktime_get()) {
		    break None;
		}
	    };

	    if cond() {
		val
	    } else {
		Err(kernel::error::code::ETIMEDOUT)
	    }
	}

note that you don't need the args part, because `op` is a closure that
can capature value, so for example, if in C code you need to call foo(a,
b), with closure, you can do:

	<a and b are defined in the caller>
	read_poll_timeout(|| { foo(a, b) }, ...);

with above API.

Regards,
Boqun

> 
> macro_rules! read_poll_timeout {
>     ($op:expr, $val:expr, $cond:expr, $sleep:expr, $timeout:expr, $($args:expr),*) => {{
>         let _ = $val;
>         loop {
>             $val = $op($($args),*);
>             if $cond {
>                 break;
>             }
>             kernel::delay::sleep($sleep);
>         }
>         if $cond {
>             Ok(())
>         } else {
>             Err(kernel::error::code::ETIMEDOUT)
>         }
>     }};
> }
> 

