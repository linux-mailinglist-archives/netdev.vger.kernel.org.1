Return-Path: <netdev+bounces-41943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D367CC5D1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872311C20BE3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D543AAF;
	Tue, 17 Oct 2023 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sphavuOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3F43A84;
	Tue, 17 Oct 2023 14:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5F5C433C7;
	Tue, 17 Oct 2023 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697552514;
	bh=S0cFMSsiptioecYbb5PIgsQ87Q6x7neETMASL7MH+pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sphavuOhQS7yQjewzOpQOQIpDXM+vWNO7F0l2IlR0io0/I1VjP2VbccfCFjQ8PlXi
	 ksQ2w4oxO/iHXhK1MymVZbMVPFiokpE2CYNWcJ97c7AG1BCg0vrL+Hmfw9huuEnoqP
	 bPoVMdRgEPWV/KVkqi/oHYi+Ifg51eJbZyyiLI/0=
Date: Tue, 17 Oct 2023 16:21:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <2023101756-procedure-uninvited-f6c9@gregkh>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
 <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
 <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
 <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
 <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me>

On Tue, Oct 17, 2023 at 02:04:33PM +0000, Benno Lossin wrote:
> On 17.10.23 14:38, Andrew Lunn wrote:
> >>> Because set_speed() updates the member in phy_device and read()
> >>> updates the object that phy_device points to?
> >>
> >> `set_speed` is entirely implemented on the Rust side and is not protected
> >> by a lock.
> > 
> > With the current driver, all entry points into the driver are called
> > from the phylib core, and the core guarantees that the lock is
> > taken. So it should not matter if its entirely implemented in the Rust
> > side, somewhere up the call stack, the lock was taken.
> 
> Sure that might be the case, I am trying to guard against this future
> problem:
> 
>      fn soft_reset(driver: &mut Driver) -> Result {
>          let driver = driver
>          thread::scope(|s| {
>              let thread_a = s.spawn(|| {
>                  for _ in 0..100_000_000 {
>                      driver.set_speed(10);
>                  }
>              });
>              let thread_b = s.spawn(|| {
>                  for _ in 0..100_000_000 {
>                      driver.set_speed(10);
>                  }
>              });
>              thread_a.join();
>              thread_b.join();
>          });
>          Ok(())
>      }
> 
> This code spawns two new threads both of which can call `set_speed`,
> since it takes `&self`. But this leads to a data race, since those
> accesses are not serialized. I know that this is a very contrived
> example, but you never when this will become reality, so we should
> do the right thing now and just use `&mut self`, since that is exactly
> what it is for.

Kernel code is written for the use cases today, don't worry about
tomorrow, you can fix the issue tomorrow if you change something that
requires it.

And what "race" are you getting here?  You don't have threads in the
kernel :)

Also, if two things are setting the speed, wonderful, you get some sort
of value eventually, you have much bigger problems in your code as you
shouldn't have been doing that in the first place.

> Not that we do not even have a way to create threads on the Rust side
> at the moment.

Which is a good thing :)

> But we should already be thinking about any possible code pattern.

Again, no, deal with what we have today, kernel code is NOT
future-proof, that's not how we write this stuff.

If you really worry about a "split write" then us a lock, that's what
they are there for.  But that's not the issue here, so don't worry about
it.

thanks,

greg k-h

