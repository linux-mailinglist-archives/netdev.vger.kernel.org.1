Return-Path: <netdev+bounces-131670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F298F368
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7861F22342
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531881A3033;
	Thu,  3 Oct 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yk8UWvRF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC21552ED;
	Thu,  3 Oct 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971246; cv=none; b=PGtHo7bk4XD3FzltKjXA3FcQ2/pATuwraIOyTdwGZKQEMlr9H6aRkCH4PoPZYEPTO2GEuUxH/Pu4ne1SfTJOvota1mtt4gdNZcHQ+lCvzH6ehfJrIWeQTtHH8FNIdSFdAM8mauewrT9ZM3BVKNEnRX64QOshToNcETyGHupJ4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971246; c=relaxed/simple;
	bh=urJUWhWj0/jU6r0elSeILaeKSFqJ6kZ7W1mTMbJBVUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm5vwrWVPjGbrNVkCiGkasqAMeetUH8pW1NqFLYHZJGu4g+aWcbrOal1LcHbaLmXzPHGarntfha6VyqadE65llrt4IkLj/QEFTCwVEf16TYK4DVe7gAPLRxFaWPJtN6xFUaVCsaDBxjFZm8jT1lUa07JdQUe3usSanSdvHiLWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yk8UWvRF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mvGlqjg1Sye+h4uRdo45d9MUGSgM8SSKr87U+EOBzSI=; b=Yk8UWvRF2Osr9e4ObvDYc6Jkk6
	xVIhjMi3mFuj3coXxxVNEzKsy0c1ws4PUMsAVdcUVG4g/T3xJ1NF5plbyn93xgYugDZHFj34LsGKP
	23AoZOg5+Gwva3DPEi5P2Lb2YeJgohH9Q48Eq7HkNcdXSf4Jte36oWKR+FUm5i3WoGw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swOFo-008xcm-Qu; Thu, 03 Oct 2024 18:00:36 +0200
Date: Thu, 3 Oct 2024 18:00:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, dirk.behme@de.bosch.com,
	aliceryhl@google.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com
Subject: Re: iopoll abstraction
Message-ID: <f7906232-c2c7-4fd6-be6b-7e96bbfbbcad@lunn.ch>
References: <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
 <20241002.095636.680321517586867502.fujita.tomonori@gmail.com>
 <Zv6FkGIMoh6PTdKY@boqun-archlinux>
 <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
 <Zv6pW3Mn6qxHxTGE@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6pW3Mn6qxHxTGE@boqun-archlinux>

> > fn read_poll_timeout<Op, Cond, T: Copy>(
> >     mut op: Op,
> >     cond: Cond,
> >     sleep: Delta,
> >     timeout: Delta,
> > ) -> Result<T>
> > where
> >     Op: FnMut() -> Result<T>,
> >     Cond: Fn(T) -> bool,
> > {
> >     let timeout = Ktime::ktime_get() + timeout;
> >     let ret = loop {
> >         let val = op()?;
> >         if cond(val) {
> >             break Ok(val);
> >         }
> >         kernel::delay::sleep(sleep);
> > 
> >         if Ktime::ktime_get() > timeout {
> >             break Err(code::ETIMEDOUT);
> >         }
> >     };
> > 
> >     ret
> > }

This appears to have the usual bug when people implement it themselves
and i then point them at iopoll.h, which so far as been bug free.

kernel::delay::sleep(sleep) can sleep for an arbitrary amount of time
greater than sleep, if the system is busy doing other things. You
might only get around this loop once, and exit with ETIMEOUT, but
while you have been sleeping a long time the hardware has completed
its operation, but you never check.

There must be a call to cond() after the timeout to handle this
condition.

And this is not theoretical. I had a very reproducible case of this
during the boot of a device. It is less likely today, with SMP
systems, and all the RT patches, but if it does happen, it will be
very hard to track down.

	Andrew

