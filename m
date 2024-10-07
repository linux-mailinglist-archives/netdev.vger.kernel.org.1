Return-Path: <netdev+bounces-132695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF42992CE3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E59284C4D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA91D358F;
	Mon,  7 Oct 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pYIQO231"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226A1662E4;
	Mon,  7 Oct 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306980; cv=none; b=g1xligSH+CSLWUiBNVRMFxtgYoUDigwvLQ4JxSH7Si5DJHF1JbX3jVRExe2L1KzScsA+BJUr3yVTjhY3JJ4y74fdjgvSZXmvuFQSDnH2NNPRp2h+VedBmWhSSwDg4xz2gv3BxJOqIj9zLxKAIf46DGwMKMFLCmBTLbfd532yyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306980; c=relaxed/simple;
	bh=h9HMAZC5cj+kkbyIeOL1U6IwbzQtt39sN9Jp0GH/HZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRGbaLksinAfJrBtKOvUKjLilmH6EhM5uGjhq7jH45wGYhQqSPRmHCdrlMkUT9pdxmMo8lv0if/HjzP6f5Xo1lFF7YOgSem9k7ZR+bpRNDeLLBJplf5+Y3qJgXJcEZFyFhx3pEMpxZEdmyLLSuQoTHsG2YhAN/jpnHcjNHbsNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pYIQO231; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=q3PDkjJiycoFfoOfMI+sM+elP9ldxC6SsvMw4k/Rm3I=; b=pY
	IQO2318qRssb+4bkHP126iLiSUGK4fbIOQNvRZDJTGu4YbW747bUxXqAU03TfNSgyZBOGU6PK9Jy0
	723eOtYtz424KiszzHTJpRoPWqIUAnx3dWA+dMtyvOMeqxsM2enWbZkhSqRZKEHxVEGxB3RaG0Owv
	bs1BVnHAyQJloj0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxnad-009GPl-CY; Mon, 07 Oct 2024 15:15:55 +0200
Date: Mon, 7 Oct 2024 15:15:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, finn@kloenk.dev,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
Message-ID: <f31d6f3e-e53c-4ced-920a-976ac44235e9@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-2-fujita.tomonori@gmail.com>
 <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
 <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
 <CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com>

On Mon, Oct 07, 2024 at 10:41:23AM +0200, Alice Ryhl wrote:
> On Mon, Oct 7, 2024 at 7:37 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > On Sun, 06 Oct 2024 12:28:59 +0200
> > Fiona Behrens <finn@kloenk.dev> wrote:
> >
> > >> Implement PartialEq and PartialOrd trait for Ktime by using C's
> > >> ktime_compare function so two Ktime instances can be compared to
> > >> determine whether a timeout is met or not.
> > >
> > > Why is this only PartialEq/PartialOrd? Could we either document why or implement Eq/Ord as well?
> >
> > Because what we need to do is comparing two Ktime instances so we
> > don't need them?
> 
> When you implement PartialEq without Eq, you are telling the reader
> that this is a weird type such as floats where there exists values
> that are not equal to themselves. That's not the case here, so don't
> confuse the reader by leaving out `Eq`.
 
This might be one of those areas where there needs to be a difference
between C and Rust in terms of kernel rules. For C, there would need
to be a user. Here you seem to be saying the type system needs it, for
the type to be meaningful, even if there is no user?

Without Eq, would the compiler complain on an == operation, saying it
is not a valid operation? Is there a clear difference between nobody
has implemented this yet, vs such an operation is impossible, such as
your float example?

	Andrew

