Return-Path: <netdev+bounces-131212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A822798D3A6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82ABB20AC0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6931CFEB7;
	Wed,  2 Oct 2024 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EfoZwASo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18661198E7F;
	Wed,  2 Oct 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873507; cv=none; b=Oogh2rv7iQAJIs3ihDmevrLXxw32Wiy1hYbJa8skXsV77GOVux0ZDhQkZuex9Ia4s/6s7J1fmAq+V14z+WpAapJtyVyF+doWY+Bw/q5LPm5td7/65Am4gWHUSJGA8SWKcNjmcQ9QOz6stqOXycvobPf4fu5uENhV8nPZeDbD8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873507; c=relaxed/simple;
	bh=EgmNny/bGesw3UnRWw0PqAII9j0gnQUKWKOko8vaFaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL/gzi7zastjYBJsgYEUh4inkp/VYu+xL6xEugwsWw84WfEqWdTT29m1OI1cQqrObWKDJ8eF63nLZN53DyUu8RSd+txaRqKA/GodraV81mikqBIxVtg8Z7rBcoDBF4sBwfyhK/Fq5/09duW04XyOb8Oc8TIVBcOf2PacIzqYJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EfoZwASo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FPU0Dhvh3yCmEHscJ+U4ryfcjQtVeUp/uCzTu9j3UwI=; b=Ef
	oZwASoVKk96+v5v5Uh70vpAGlT5b8Ar/IuKTLMK+iWqBKrF2xeJOZHboKgR4U3KFNG26A2Ft/GhPU
	Ug8EdgaleLXw1cdq8SlM8KWfqnB6Z9cU4jHf1zNEB/vq8TztS51DmzDJYRsMG1TKZwq9dKmyjzNjo
	LNEdi4ij6B92S20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svypR-008rFk-IE; Wed, 02 Oct 2024 14:51:41 +0200
Date: Wed, 2 Oct 2024 14:51:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
Message-ID: <3fc44d62-586f-4ed0-88ee-a561bef1fdaf@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com>
 <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
 <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
 <CANiq72mX4nJNw2RbZd9U_FdbGmnNHav3wMPMJyLSRN=PULan8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mX4nJNw2RbZd9U_FdbGmnNHav3wMPMJyLSRN=PULan8g@mail.gmail.com>

On Wed, Oct 02, 2024 at 02:35:57PM +0200, Miguel Ojeda wrote:
> On Wed, Oct 2, 2024 at 2:19 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > How well know is that? And is there a rust-for-linux wide preference
> > to use Duration for time? Are we going to get into a situation that
> > some abstractions use Duration, others seconds, some milliseconds,
> > etc, just like C code?
> 
> We have `Ktime` that wraps `ktime_t`.
> 
> However, note that something like `Ktime` or `Duration` are types, not
> a typedef, i.e. it is not an integer where you may confuse the unit.
> 
> So, for instance, the implementation here calls `as_micros()` to get
> the actual integer. And whoever constructs e.g. a `Duration` has
> several constructors to do so, not just the one that takes seconds and
> nanoseconds, e.g. there is also `from_millis()`.
> 
> Perhaps we may end up needing different abstractions depending on what
> we need (Cc'ing Thomas), but we will almost certainly want to still
> use types like this, rather than plain integers or typedefs where
> units can be confused.
> 
> > Anyway, i would still document the parameter is a Duration, since it
> > is different to how C fsleep() works.
> 
> That is in the signature itself -- so taking into account what I
> mentioned above, does it make sense that seeing the type in the
> signature would be enough?

Which is better, the Rust type system catching the error, or not
making the error in the first place because you read the documentation
and it pointed you in the right direction?

Maybe this is my background as a C programmer, with its sloppy type
system, but i prefer to have this very clear, maybe redundantly
stating it in words in addition to the signature.

	Andrew

