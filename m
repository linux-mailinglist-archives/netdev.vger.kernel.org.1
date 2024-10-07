Return-Path: <netdev+bounces-132815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4CD99348C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC23B20C07
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45431DCB39;
	Mon,  7 Oct 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="17Gnuf9a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEF1DBB3C;
	Mon,  7 Oct 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321241; cv=none; b=RsuB1mvgpZ+VErCmRvpqlQujhKdXuMpG2j4d8L4URDINT2D6i21fiyvTRQK0M93NdS5NFgWW168wn+cbHKGqDk85MUlj9VvAxX2Afz++CusazaJpZI10sZFWlXcSexc0yK0YDbKHgcTR+oa7rF0iGShQY9XiKqxYdydT3ZQh9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321241; c=relaxed/simple;
	bh=+1el5oe20173DkKtwlL01ebh1nxEK5s/2QXdYu96hEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf9YR+YownZXGMt9Aks+zm6Mx3FJ5o0haRg/xRGUhPQhN8JOvnNKHyu2LjYmrLdhzQcAQEsels7jg7c5IX/66EfUcb5q94RNIv8JffqdytTgooUQbAkQ236O2lKKYz4ZKc9uz3gsNHun4pRbTKKvKiv8n2FyIt/ZPYkxek/MXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=17Gnuf9a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w6ppkj+1yxEfd3/jQGqcf2ZXkXdKjMbZSyR2uVRspF4=; b=17Gnuf9acoMaaQd0RE23twEGwi
	wIEVPxK2AxR/WnNqghdtdfWTy7sL74c4oHHlIATIgasy+k7a57Xc16gAAyJ7ISAgb4wU8yEgW2q1+
	AFYFl7Ru+0553DIa9dmg1MNqd1vT3l1QX3gw7ZrBZydp2+lrLkCZEFoATg4HHmzGNdaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxrIi-009I7h-Rp; Mon, 07 Oct 2024 19:13:40 +0200
Date: Mon, 7 Oct 2024 19:13:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwPsdvzxQVsD7wHm@boqun-archlinux>

> > pub fn might_sleep() {
> >     // SAFETY: Always safe to call.
> >     unsafe { bindings::might_sleep() };
> 
> It's not always safe to call, because might_sleep() has a
> might_resched() and in preempt=voluntary kernel, that's a
> cond_resched(), which may eventually call __schedule() and report a
> quiescent state of RCU. This could means an unexpected early grace
> period, and that means a potential use-afer-free.

How does C handle this?

I'm not an RCU person...

But if you have called might_sleep() you are about to do something
which could sleep. If it does sleep, the scheduler is going to be
called, the grace period has ended, and RCU is going to do its
thing. If that results in a use-after-free, your code is
broken. might_sleep makes no difference here, the code is still
broken, it just happens to light the fuse for the explosion a bit
earlier.

Or, i'm missing something, not being an RCU person.

	Andrew

