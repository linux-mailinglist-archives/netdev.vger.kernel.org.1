Return-Path: <netdev+bounces-221648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26149B516C1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57A54E6EE9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFD314B91;
	Wed, 10 Sep 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jqetjXQS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTth6Z4H"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBD264638;
	Wed, 10 Sep 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506965; cv=none; b=WHF9tX3tTyYQEXI2nqo44UA03/u2vQIaGjitaLAY3xkcPJq4XYB5b9iwIyQEEpweWDvNczocQPjpVoJ8UsXyGhGBKhN6nLGYXwmx6ZgJJPNxvuBaT3hSgyxfM42LkEeErgk7p7om8fwvVvIO0Vrh/zPKQkjwotxiKpGs/iHLXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506965; c=relaxed/simple;
	bh=BwxyMEeBT09wMo5qLxDbA+/05iLRP/gfF25ofOeH7N0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOqlpVMchzOdFgpGUU7zUVTp135xalIvYFCN556/5D4YEsT5rMOK7fKN2p3vJ/t7Ly3cfldiDgvNLg0WSc74GJe0ioKHTakHEKbGPYxWjCMJIbHmrsMMJ89Ysm95Rz2KnHdqADt459QsenH/7acWNIMToW9iRyoTkJr1G7w7BC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jqetjXQS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTth6Z4H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757506961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHwKGf7XcwoTWq5YZJRF3zyvIA6i/G0FyPAlWbZYSVg=;
	b=jqetjXQSybNkO+cFqj71bhG+1TaOr/qSVe7nFdNrfUyp5LcfySEUbWtBDUV2NSjgtoOg5f
	VTCjA614lmtW4+ZPib4+Bn8EhobXYLrX3LMLnzKGSZ+V8N8Qpvw0kBsNKgrnYR4q1x9Cnp
	o0ziLec/W831nnzJncCTDLGZnh9llZICVdCaIu5Sbz8G1+iS7HZRu3b05S/vFt+6FF5cxx
	Wf1EIjG3A5nhnvQiYIXHcjU52gNzPZD/w4w9PVzNnTARUCI4yi3oYaqrWXkfMQ3xJWKK0C
	z8fAt/M/Zx2hbABoMmgkUlS3SOMZJyPa69I36aKoZ2tcpAgA+MC33t8XFaF4yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757506961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHwKGf7XcwoTWq5YZJRF3zyvIA6i/G0FyPAlWbZYSVg=;
	b=oTth6Z4HiklDZFhAhkf99oN4zYAWIbbRmn65oz+zofjJY0JCRdSY/O1/nFTf4PyLcddLcC
	470nmr4MeJsVtODQ==
To: Breno Leitao <leitao@debian.org>
Cc: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>,
 kuba@kernel.org, calvin@wbinvd.org, Pavel Begunkov
 <asml.silence@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
In-Reply-To: <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
References: <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
Date: Wed, 10 Sep 2025 14:28:40 +0206
Message-ID: <847by65wfj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(Added CC printk folks since we are now talking about the nbcon API.)

Hi Breno,

On 2025-09-09, Breno Leitao <leitao@debian.org> wrote:
> To summarize the problem:
>
> 1) netpoll calls .ndo_start_xmit() with IRQ disabled, which causes the
> lockdep problem reported in this thread. (current code)
>
> 2) moving netconsole to use NBCON will help in the thread context, given
> that .write_thread() doesn't need to have IRQ disabled. (This requires
> rework of netconsole target_list_lock)

Aside from reworking the target_list_lock, be aware that ->device_lock()
must at least disable migration. The kerneldoc for the ->device_lock()
callback talks about this.

> 3) In the atomic context, there is no easy solution so far. The options
> are not good, but, I will list them here for the sake of getting things
> clear:
>
>   a) Defer the msg as proposed initially.
>     Pro: If the machine is not crashing, it should simply work (?!)
>     Cons: It cannot be expected that the workqueue is functional during panic, thus
>           the messages might be lost

To be clear, "might be lost" means the message was not printed on the
netconsole. The message still will have made it into the ringbuffer and
attempted output to any other consoles as well as being available to
crash tools.

My problem with implementing deferring is that is what ->write_thread()
is already doing.

I wonder if we should extend the nbcon interface so that it is possible
to specify that ->write_atomic() is not safe. Then it would only be used
as a last resort in panic context.

@pmladek: We could introduce a new console flag (NBCON_ATOMIC_UNSAFE) so
that the callback is only used by nbcon_atomic_flush_unsafe().

>   b) Send the message anyway (and hope for the best)
>     Cons: Netpoll will continue to call IRQ unsafe locks from IRQ safe
>           context (lockdep will continue to be unhappy)
>     Pro: This is how it works today already, so, it is not making the problem worse.
>          In fact, it is narrowing the problem to only .write_atomic().

Two concerns here:

1. ->write_atomic() is also used during normal operation

2. It is expected that ->write_atomic() callbacks are implemented
   safely. The other nbcon citizens are doing this. Having an nbcon
   driver with an unsafe ->write_atomic() puts all nbcon drivers at risk
   of not functioning during panic.

This could be combined with (a) so that ->write_atomic() implements its
own deferred queue of messages to print and only when
@legacy_allow_panic_sync is true, will it try to send immediately and
hope for the best. @legacy_allow_panic_sync is set after all nbcon
drivers have had a chance to flush their buffers safely and then the
kernel starts to allow less safe drivers to flush.

Although I would prefer the NBCON_ATOMIC_UNSAFE approach instead.

>   c) Not implementing .write_atomic
>     Cons: we lose the most important messages of the boot.
>
>   Any other option I am not seeing?

d) Not implementing ->write_atomic() and instead implement a kmsg_dumper
   for netconsole. This registers a callback that is called during
   panic.

   Con: The kmsg_dumper interface has nothing to do with consoles, so it
        would require some effort coordinating with the console drivers.

   Pro: There is absolute freedom for the dumper to implement its own
        panic-only solution to get messages out.

e) Involve support from the underlying network drivers to implement true
   atomic sending. Thomas Gleixner talked [0] very briefly about how
   this could be implemented for netconsole during the 2022
   proof-of-concept presentation of the nbcon API.

   Cons: It most likely requires new API callbacks for the network
         drivers to implement hardware-specific solutions. Many (most?)
         drivers would not be able to support it.

   Pro: True reliable atomic printing via network.

John Ogness

[0] https://www.youtube.com/watch?v=TVhNcKQvzxI&t=3020s (begin 50:20)

