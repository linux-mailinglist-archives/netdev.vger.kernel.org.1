Return-Path: <netdev+bounces-143162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A19C14DC
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556C3B21E99
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4119E83C;
	Fri,  8 Nov 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP/RiuCj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF902629F;
	Fri,  8 Nov 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037926; cv=none; b=S8TDXtjCR5KG8R2lOkun4Qtbz+Rc0UZmAYTDDQIqnbvCvfnuxj1Ql+4mg8/I/6KHmbDFgEJylhLsNiv5eqbgdae36AclRBej83j5LVm5Q2cS8TZE0m72pvRcdntDbub87puqkcm3y5viG2hObRsrNEQouhRXzzqiyz0xL3WfGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037926; c=relaxed/simple;
	bh=vH7XkTIsSGwj6EYZboBBqubxtPyWoyZm2MhA5P3n/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlf5OH8BMZYQATOLIAif8SmDr6GRE2L4Vj5MU5Qf5vbfcJkbPp6nNvPkId/tcOZa8iQYT9kg2li3QxKeHUNpmV6F0VcC9utfMQLp8elP54JjzXYUb5yqIeOAqTbsSRu8l4/jjqm+FcDXpBWNdomyCc5QCmgIJoaC4t+PeE1bzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP/RiuCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AF4C4CECE;
	Fri,  8 Nov 2024 03:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731037925;
	bh=vH7XkTIsSGwj6EYZboBBqubxtPyWoyZm2MhA5P3n/ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FP/RiuCjt+Bgr+QH8DCrKKW7l59wDcHRVpewrrvxHBvKYP5XilCJNC5pmFZEUUvUm
	 FI89/o1/9dHPDf1SOKoNSZiNILhPx05J2vpt9rKGwQWw2DlfN8HcPihvMWd5aUIkz9
	 UZ3mhdSxJ4Dxl7UPzm/uRe27TRgpQgXqM1RW1uvjme9mQMPCO9Zwe1t2NrJQs2TsFw
	 cs5zZC/TX0DgE4tQUYjREAIHfRvj9f3qYrAuArghy6FVl8QulEdR1twGlczhSJdthT
	 AM6YqB49HbWYw1vp421cPSwERbd5qr+qWhEfsxGLAa4lGuz55WUxqA9vKdmhgDcr7c
	 Do7p5jnHgXzgQ==
Date: Thu, 7 Nov 2024 19:52:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
 bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 2/7] net: Suspend softirq when
 prefer_busy_poll is set
Message-ID: <20241107195203.72ea09b9@kernel.org>
In-Reply-To: <Zywy8PQDljS5r_rX@LQ3V64L9R2>
References: <20241104215542.215919-1-jdamato@fastly.com>
	<20241104215542.215919-3-jdamato@fastly.com>
	<20241105210338.5364375d@kernel.org>
	<ZyuesOyJLI3U0C5e@LQ3V64L9R2>
	<20241106153100.45fbe646@kernel.org>
	<Zywy8PQDljS5r_rX@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 19:24:32 -0800 Joe Damato wrote:
> > In your case, when machine is not melting under 100% load - prefer busy
> > poll will be set once or not at all.  
> 
> I am not sure what you mean by that last sentence, because the
> prefer busy poll flag is set by the application?

There are two flags with almost exactly the same name, that's probably
the source of misunderstanding. NAPI_F_PREFER_BUSY_POLL will always be
set, but unless we are actually in a "napi live lock"
NAPI_STATE_PREFER_BUSY_POLL will not get set, and the latter is what
napi_prefer_busy_poll() tests. But we're dropping this patch so
doesn't matter. I was trying to pile up reasons why checking
napi_prefer_busy_poll() should not be necessary.

> Similar to prefer busy poll piggybacking on IRQ deferral, we
> piggyback on prefer busy polling by allowing the application to use
> an even larger timeout while it is processing incoming data, i.e.,
> deferring IRQs for a longer period, but only after a successful busy
> poll. This makes prefer busy poll + irq suspend useful when
> utilization is below 100%.
> 
> > > The overall point to make is that: the suspend timer is used to
> > > prevent misbehaving userland applications from taking too long. It's
> > > essentially a backstop and, as long as the app is making forward
> > > progress, allows the app to continue running its busy poll loop
> > > undisturbed (via napi_complete_done preventing the driver from
> > > enabling IRQs).
> > > 
> > > Does that make sense?  
> > 
> > My mental model put in yet another way is that only epoll knows if it
> > has events, and therefore whether the timeout should be short or long.
> > So the suspend timer should only be applied by epoll.  
> 
> Here's what we are thinking, can you let me know if you agree with
> this?
> 
>   - We can drop patch 2 entirely
>   - Update the documentation about IRQ suspension as needed now
>     that patch 2 has been dropped
>   - Leave the rest of the series as is
>   - Re-run our tests to gather sufficient data for the test cases
>     outlined in the cover letter to ensure that the performance
>     numbers hold over several iterations
> 
> Does that seem reasonable for the v7 to you?
> 
> I am asking because generating the amount of data over the number of
> scenarios we are testing takes a long time and I want to make sure
> we are as aligned as we can be before I kick off another run :)

SGTM, the rest of the series makes perfect sense to me.
Sorry for the delay..

