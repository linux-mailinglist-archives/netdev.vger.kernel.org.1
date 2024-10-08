Return-Path: <netdev+bounces-133223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15B995573
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0D41F21B86
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D81F9A9F;
	Tue,  8 Oct 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fAh0ynRY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A781F943E;
	Tue,  8 Oct 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407824; cv=none; b=gdVFzvDBhp4k4Zb6lkY4J9fwaDv2iq3UGYGwZicDcjznEgJC2gpgdan87RDht6hYl7LRvLzrUx4oNi8h9SmAbzgKvvWozo0LdmmIDacRbluXGgxZUyik0Cjt+BKJRF6f+iToC51gn1xjNxOKUDeEvcfe/Vh9cVnvW3H3YKoE4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407824; c=relaxed/simple;
	bh=OjUSR2PF13JtkSK4P44cBDx3HSO9zrtYh8NlSmy4W0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJH4KVrzh6ePu7LTgV6QskhYXjRMnRn3KpjLMnywLrYRjF/6WnfFqT6gos/nqk1Q1TOBgyQmosmLEHwhhyqFSUINJvyfkbCYYzz22zLDh3dRRJGVDTWO+VCXzHZE8W++TQP0Jq6mjYL4CBPMafK4RmeQBgK9YPrTCF3HwNhauXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fAh0ynRY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BYelIuhdwCMOp3hSfF4Y8G97oI/WtzSte+kcZyAyHKI=; b=fA
	h0ynRYZ6/Vf0avTjGHz/KkJjBpq7V/rlFiFTnOM68+y0adeEbG3leHqJkp8wG1zoFleHFHqoVjP2K
	6RQmBUEfm3r6/nvcPH+S5kckWJDDn7+TIkRAGO/FEkGi4T3Rago9VvFaULgFtqnk1xc3Me4e83vaH
	oS22lCoY8zM6u2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syDpC-009Ob7-R5; Tue, 08 Oct 2024 19:16:42 +0200
Date: Tue, 8 Oct 2024 19:16:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <df2c9ea8-fa3a-416e-affd-b3891b2ab3f7@lunn.ch>
References: <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
 <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
 <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>

On Tue, Oct 08, 2024 at 03:14:05PM +0200, Miguel Ojeda wrote:
> On Tue, Oct 8, 2024 at 2:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > As far as i see, might_sleep() will cause UAF where there is going to
> > be a UAF anyway. If you are using it correctly, it does not cause UAF.
> 
> This already implies that it is an unsafe function (in general, i.e.
> modulo klint, or a way to force the user to have to write `unsafe`
> somewhere else, or what I call ASHes -- "acknowledged soundness
> holes").
> 
> If we consider as safe functions that, if used correctly, do not cause
> UB, then all functions would be safe.

From what i hear, klint is still WIP. So we have to accept there will
be bad code out there, which will UAF. We want to find such bad code,
and the easiest way to find it at the moment is to make it UAF as fast
as possible. might_sleep() does that, __might_sleep() does not, and
using neither is the slowest way.

	Andrew

