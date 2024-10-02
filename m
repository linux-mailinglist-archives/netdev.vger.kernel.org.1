Return-Path: <netdev+bounces-131200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E798D34A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA87B234EF
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC634194A73;
	Wed,  2 Oct 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="57izO1BQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8481D52B;
	Wed,  2 Oct 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872272; cv=none; b=IscvoBi6q0KPpM14NobsaZXa0fomoiNPv/e8oxlag5wIDHJx2Ea6vlgtwprSWiMLDgzA0fUd9gXwkMiwTEpQtVyj/foYsWNKiIJN9j2KOQTtvdTxAc+mdSnXHxSc56JEikF37nv+Lwyp9V0Kujlyha0gAlJFBzzMgh6E8ztJAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872272; c=relaxed/simple;
	bh=y9wY8I/zjyHIOrRCdYUnf8u7lfoDOBcwF1CzuLB5r+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7cQLKjU+SFr3ST3xLP9+yZmg87Sz66foz34vIygAphKzjoksi0frnYrf8MYroe5J8HbsnoISfdyg0VA1YE2XER/V1QwMY1PjMXr71wuw+6aIzDh+YToL3Dkgx6OSJ0ABIMFIHWboVqctnCludHvqKlTxaMcP/8vHlR6x6il2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=57izO1BQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dJpjuwwNU1sI8cy4/CDlp+ignGc/c/8eL5sgCTYQSEw=; b=57izO1BQ6Cd1ciJWZx/pMDfEgX
	mCn9Q0ifRTWtVan6O9T1JoAYnR46L9snT1riKugZxcTrYBHH37sVMZ8CgCqAK9p0wBRcwEHaSFyKC
	AjuVLFjFZz+bVeSLyXGZCD23F+ZgD5EhMbqcXZguWXoC55wC9Bjrt//hornI37hlfayA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svyVX-008r1N-JH; Wed, 02 Oct 2024 14:31:07 +0200
Date: Wed, 2 Oct 2024 14:31:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY becomes
 ready
Message-ID: <ec7267b5-ae77-4c4a-94f8-aa933c87a9a2@lunn.ch>
References: <20241001112512.4861-3-fujita.tomonori@gmail.com>
 <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
 <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
 <20241002.101339.524991396881946498.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002.101339.524991396881946498.fujita.tomonori@gmail.com>

On Wed, Oct 02, 2024 at 10:13:39AM +0000, FUJITA Tomonori wrote:
> On Tue, 1 Oct 2024 14:48:06 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > I generally point developers at iopoll.h, because developers nearly
> > always get this sort of polling for something to happen wrong. 
> 
> Ah, I had forgotten about iopoll.h. Make senses. I'll try implement an
> equivalent in Rust.

There are some subtleties involved with PHYs, which is why we have our
own wrapper around the macros in iopoll.h:

https://elixir.bootlin.com/linux/v6.11.1/source/include/linux/phy.h#L1288

Normally an IO operation cannot fail. But PHYs are different, a read
could return -EOPNOTSUPP, -EIO, -ETIMEDOUT etc. That needs to be take
into account and checked before evaluating the condition.

So you might need to think about something similar for Rust. A generic
read_poll_timeout() and a phy_read_poll_timeout() built on top of it.

This is a worthwhile set of helpers to have, since the bugs in this
are nothing to do with memory safety, but plain simple logic bugs,
which Rust itself is unlikely to help with.

	Andrew

