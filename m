Return-Path: <netdev+bounces-132080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E993990566
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051341F22DBF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7D216A17;
	Fri,  4 Oct 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o2gytmUW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321DB217330;
	Fri,  4 Oct 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050925; cv=none; b=cTX7GGILcgw2ANQbaZHVQ8b7xsJbG6UXEFOJ87B30YmU6AWG3XQQJS/GCb9279eEwk8eUJYTVu1x8g3PiHmWtIdNMlvlh1GGA3ZxAU0xMXt1cAK5lN9tneaR/B0ZBj1QXl9K63k4JGf7g+fjLsG3WF9EEskhc7DEZJ7d0z1ypUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050925; c=relaxed/simple;
	bh=U7BUQogmfsMjFigsPg+8A9a5e640pTLMXpZg/OyxEuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOxTst4KtvyMpzsgD34I8++3faejQG4qILHz6DUzmjQf9qnyzGsp/JVBj4Ih1/6chskPkVjkhSaW252XTK5L+3j3w/0rF41DOa8lXyr8D0u7G/4DR1bnmopKQJV8FjgjI5qUjD1Q32fsAnZDeTtGUZ9kZCqdbdwxFTLUWt1zS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o2gytmUW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G3PLQYP5REX3puY1XA/8DApG8sWPavvbMNP15YqbO4k=; b=o2gytmUWMn4XHhQ3buhr1lfP9a
	BTuBMi9rFRmR9CcSVF0s+Mehw0/pFyOEMOKdjg4BjVsAxwMnD4YehaxriZeocbvFGFxkbSJmBSEiJ
	MiTWL1JisvnUHZljPi/V0L/NGm6W2lR20ibz0S8MCgR09qG8LzyLcPNpFuUKo5//7JuA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swiz2-0093N4-RC; Fri, 04 Oct 2024 16:08:40 +0200
Date: Fri, 4 Oct 2024 16:08:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
Message-ID: <9e55ccea-0c0b-4008-bc02-963701a38832@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com>
 <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241004.210819.1707532374343509254.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004.210819.1707532374343509254.fujita.tomonori@gmail.com>

On Fri, Oct 04, 2024 at 09:08:19PM +0900, FUJITA Tomonori wrote:
> On Tue, 1 Oct 2024 14:31:39 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> +/// Sleeps for a given duration.
> >> +///
> >> +/// Equivalent to the kernel's [`fsleep`] function, internally calls `udelay`,
> >> +/// `usleep_range`, or `msleep`.
> > 
> > Is it possible to cross reference
> > Documentation/timers/timers-howto.rst ?  fsleep() points to it, so it
> > would e good if the Rust version also did.
> 
> Looks like the pointer to Documentation/timers/timers-howto.rst in
> fsleep will be removed soon.
> 
> https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de/

It would be more accurate to say it gets replaced with a new document:

Documentation/timers/delay_sleep_functions.rst

So please reference that.

	Andrew

