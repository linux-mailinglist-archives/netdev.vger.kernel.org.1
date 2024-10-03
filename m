Return-Path: <netdev+bounces-131586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA698EF49
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08895284774
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C4D18593E;
	Thu,  3 Oct 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H9bdYY+q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF917B50F;
	Thu,  3 Oct 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958823; cv=none; b=OKtR2dNbNqK/v+c1XWkLQ9loJv97zDO/PPG6Ou+r9RLDPOZSuej4DnAQqRhHQgOiFF2GMdP7UGh/uZz0X6/5KLtxGy8g3UBFhBg9O/jdMaJBjF16IwWZCiWN/MCwnozuOF42KVcpdkj4D4taUvWooB9V+3cnsHBoZkKkFnmzQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958823; c=relaxed/simple;
	bh=kWcAzz9FifPCsTODxJFXgL60C3ttKZAEXGAah7CRlKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1tgvTsP84kQQCkfOJfeap5s9W4TN64lkRF4FhQYF0msOA7n3AF/G0cS++caVGFmUTuBcvzUPUqNx9gC0M/cPNBVhJhScI1QuAmAxVqHZYhLX+HmRfyhVlPtz8vQLtZs5gXGu0sSLsFddyK+ewA0V7cIUylrOtfyi+MFmaX2TVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H9bdYY+q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Hy01CYDO7tj5pmHOFciG3w1mz3Rir/3ngTy4tz1ApTM=; b=H9
	bdYY+qgFwMfKgrf3jzbO83WCrXVntfHWEHXfT3e6kKHyOuv2pvzA3u3vSz7TWPjx6YyKx/58APf01
	fGf85JoZxcZ1QZ/Hp7lDMWmpjfLBnloROCwHE8kJf3Bv9UQlITB7YNex2WlnkUMCgayN2+J6GdHWE
	7jFOpbdoZPARsXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swL1N-008wdk-Uw; Thu, 03 Oct 2024 14:33:29 +0200
Date: Thu, 3 Oct 2024 14:33:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, tglx@linutronix.de,
	aliceryhl@google.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
Message-ID: <1c393c9e-8efa-40d4-a95d-a418ae4a9fd7@lunn.ch>
References: <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
 <CANiq72kf+NrKA14RqA=4pnRhB-=nbUuxOWRg-EXA8oV1KUFWdg@mail.gmail.com>
 <87bk02wawy.ffs@tglx>
 <20241003.012444.1141005464454659219.fujita.tomonori@gmail.com>
 <CANiq72n5y7ruB1bgGquONWctPK=LBZUWugBAP_1QOSzvOY+amw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n5y7ruB1bgGquONWctPK=LBZUWugBAP_1QOSzvOY+amw@mail.gmail.com>

On Thu, Oct 03, 2024 at 12:50:51PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 3, 2024 at 3:24 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Rust abstractions are typically merged with their users. I'm trying to
> > push the delay abstractions with a fix for QT2025 PHY driver
> > (drivers/net/phy/qt2025.rs), which uses delay.
> 
> To clarify, in case it helps: users indeed drive the need for
> abstractions (i.e. we don't merge abstractions without an expected
> user), and it can happen that they go together in the same patch
> series for convenience, that is true.
> 
> However, I don't think I would say "typically", since most
> abstractions went in on their own so far

Looking at the kernel as a whole, i would say that is actually
atypical. Rust is being somewhat special here. But it also seems to be
agreed on that this is O.K.

> In other words, the "default" is that the abstractions go through
> their tree, i.e. delay wouldn't go through netdev, unless the
> maintainers are OK with that (e.g. perhaps because it is simpler in a
> given case).

In this case, the fdelay() binding should be simple enough that i
think we can use the normal mechanism of merging it via netdev, so
long as the other subsystem Maintainer gives an Acked-by: But we can
also pull a stable branch into netdev if we need to.

A Rust equivalent of iopoll.h is going to be a bit more interesting.

./scripts/get_maintainer.pl -f include/linux/iopoll.h 
linux-kernel@vger.kernel.org (open list)

i.e. it does not have a Maintainer!

Looking at the Acked-by:s i would keep Arnd Bergmann <arnd@arndb.de>
in the loop.

	Andrew

