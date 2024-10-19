Return-Path: <netdev+bounces-137233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD19A5056
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 20:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECEBB25499
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837218E37C;
	Sat, 19 Oct 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MeanKRtL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036018DF6B;
	Sat, 19 Oct 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729363308; cv=none; b=RCguKD5ptuTeFBveUY5FCJtsPsPe9zvTgHEZt6y4x0dtheirGvbhqGRbQbM8XjGmGEJZtGUBJOOCRao0CDz3grDvTh69IrsikzcEP5Syz9slNAhnbLmfry031OYHFPdtYAjd/iww0vS1XefeVL0PR+bqOrZFTRsgzUAoWWKufxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729363308; c=relaxed/simple;
	bh=8FGcCLj2vFQWBEx14s25jzsnrnffI6LVHwOTizRNass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2CW35lTym/XMm+QMOSQIgsAXngeeGfNfWag+RWm98QG5m4WEIK3wpdqzfTAoBGNjYbeYWAI9Bjv/BX+6iZUgZhtnUrxuHgOYxIfvCDzecEiSHNQ9YF+sgGwnl5LIxtnAijO1/WhIL+b99QJO2HEIFR8dcOqgxD2VQr4lLx2yvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MeanKRtL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=er3taqAhn8eBwUdaGb5l/xyrI+eEqdNBV7XOVKviHw0=; b=Me
	anKRtLn2EkXxVYiSAToajqB6Uk1owwkd0m4BlBiDmpVUSieClmf0SfGmo9UPOpofnoVby9613NBwU
	yz/U/LgMq+RvoqjoyIhoF3l9uj5jYJ2X0q2nEIsCc/Wkk52ek2feF/imQYr1yr26YYonR8O3DSC/x
	6bhDqmsRFqnQiGI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2EO9-00AcGy-Di; Sat, 19 Oct 2024 20:41:21 +0200
Date: Sat, 19 Oct 2024 20:41:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
Message-ID: <fad19413-8d58-4cf5-82e6-8d4410fd7e50@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com>
 <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
 <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com>
 <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch>
 <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>

On Sat, Oct 19, 2024 at 02:21:45PM +0200, Miguel Ojeda wrote:
> On Fri, Oct 18, 2024 at 6:55 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Did you see my other comment, about not actually using these helpers?
> > I _guess_ it was not used because it does not in fact round up. So at
> > least for this patchset, the helpers are useless. Should we be adding
> > useless helpers? Or should we be adding useful helpers? Maybe these
> > helpers need a different name, and do actually round up?
> 
> Yeah, I saw that -- if I understand you correctly, you were asking why
> `as_nanos()` is used and not `as_secs()` directly (did you mean
> `as_micros()`?) by adding rounding on `Delta`'s `as_*()` methods.
> 
> So my point here was that a method with a name like `as_*()` has
> nothing to do with rounding, so I wouldn't add rounding here (it would
> be misleading).
> 
> Now, we can of course have rounding methods in `Delta` for convenience
> if that is something commonly needed by `Delta`'s consumers like
> `fsleep()`, that is fine, but those would need to be called
> differently, e.g. `to_micros_ceil`: `to_` since it is not "free"
> (following e.g. `to_radians`) and + `_ceil` to follow `div_ceil` from
> the `int_roundings` feature (and shorter than something like
> `_rounded_up`).
> 
> In other words, I think you see these small `as_*()` functions as
> "helpers" to do something else, and thus why you say we should provide
> those that we need (only) and make them do what we need (the
> rounding). That is fair.
> 
> However, another way of viewing these is as typical conversion methods
> of `Delta`, i.e. the very basic interface for a type like this. Thus
> Tomonori implemented the very basic interface, and since there was no
> rounding, then he added it in `fsleep()`.
> 
> I agree having rounding methods here could be useful, but I am
> ambivalent as to whether following the "no unused code" rule that far
> as to remove very basic APIs for a type like this.

I would say ignoring the rule about an API always having a user has
led to badly designed code, which is actually going to lead to bugs.

It is clearly a philosophical point, what the base of the type is, and
what are helpers. For me, the base is a i64 representing nano seconds,
operations too add, subtract and compare, and a way to get the number
of nanoseconds in and out.

I see being able to create such a type from microseconds, millisecond,
seconds and decades as helpers on top of this base. Also, being able
to extract the number of nanoseconds from the type but expressed in
microseconds, milliseconds, seconds and months are lossy helpers on
top of the base.

So far, we only have one use case for this type, holding a duration to
be passed to fsleep(). Rounding down what you pass to fsleep() is
generally not what the user wants to do, and we should try to design
the code to avoid this. The current helpers actually encourage such
bugs, because they round down. Because of this they are currently
unused. But they are a trap waiting for somebody to fall into. What
the current users of this type really want is lossy helpers which
round up. And by reviewing the one user against the API, it is clear
the current API is wrong.

So i say, throw away the round down helpers until somebody really
needs them. That avoids a class of bugs, passing a too low value to
sleep. Add the one helper which is actually needed right now.

There is potentially a better option. Make the actual sleep operation
part of the type. All the rounding up then becomes part of the core,
and the developer gets core code which just works correctly, with an
API which is hard to make do the wrong thing.

	Andrew

