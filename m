Return-Path: <netdev+bounces-220347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30682B45827
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF7A0137D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB285343207;
	Fri,  5 Sep 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4bmfXcTw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRS9Gq2i"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FB1F61C;
	Fri,  5 Sep 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076516; cv=none; b=fR3Ca1P70z5yol1V6s/0ApIV/frFoUwK/PLyqPHSHMcjGQbKty8C4SM+rLcH6BNufsf/OGolIkIK1i/o3JZiw7iahNA4P7hnkKYhOtUnbuUxhZC6yyRTg654eC7KxdizWNU0UO3ZDmP1QjHmgnrMLUuyZbp7KfbHrxXY2C8/5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076516; c=relaxed/simple;
	bh=OMNPmmCMVXMzwDGq3OnNLXfRsxIS0bUTB/lhAmvdiFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irSuiYbNsg+12g3UoKQJo/wGqorf56ECeeyk6M5qVDMAxaWk6F42s756TLcRSoCG+UDnRoU4XNK1mk+/JaKpnBXQkAl3ltvTDWIqt1GhPO655wHlrOTv+sdDWWlxSNVmbKm1CMGpnVljNQbhfRs/w7F+3s0bIeQf7bjkXKr98nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4bmfXcTw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRS9Gq2i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757076513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSUHJh3xDiIm9pW8VoCAg1GSUkePKEwZVjDbv8m8+BI=;
	b=4bmfXcTw8Y18k0K93MHd2z4xoKhuj27LEKNzagHwUkN3vvLv348EwNEC/QFT+tbDkB/ksF
	n5EhEpx84GOiHwHdzeMgWUgMwh7Pu1k05YodsaO8JWiGt5anFx5Fn3cyDBHicWhhlodeaQ
	Z72YmeoMu2brVW207v/cPU1UI0CwLTeeUWIrRcavadaAKMOy5zBYrXStfb/n44/588eg3e
	OxPF47LDA2fe3eW6an5UlzFXHxCEyGhyJ71UI4kzUF3Yi1RFwiFyfL9HuB4GbmcJQO4M4/
	2NFgJZ+kzbQBnIqd1cdEq7dUZ6y1Y4Ff6nipNHenwHJRxg1QH/gaq+vxlXCJvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757076513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSUHJh3xDiIm9pW8VoCAg1GSUkePKEwZVjDbv8m8+BI=;
	b=rRS9Gq2iXNsV6UyxVw72BP9UQxCMNs96GCjrtSxXBoKfZJQ93Osvxj7+0Ke8UX2/7HLs96
	jmBXJeLI4LnwUNBQ==
To: Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>, Simon
 Horman <horms@kernel.org>, kuba@kernel.org, calvin@wbinvd.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
In-Reply-To: <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
References: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
Date: Fri, 05 Sep 2025 14:54:32 +0206
Message-ID: <84a539f4kf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for jumping in so late here. I just stumbled upon this thread.

Without understanding the details of the netconsole locking and network
performance, I would like to mention some things about the NBCON
interface to clear up some apparent confusion (most likely due to
insufficient documentation, which I am happy to improve upon).

Comments below...

On 2025-08-26, Breno Leitao <leitao@debian.org> wrote:
> On Fri, Aug 22, 2025 at 05:54:28AM +0200, Mike Galbraith wrote:
>> On Thu, 2025-08-21 at 10:35 -0700, Breno Leitao wrote:
>> > > On Thu, Aug 21, 2025 at 05:51:59AM +0200, Mike Galbraith wrote:
>>=20=20
>> > > > > --- a/drivers/net/netconsole.c
>> > > > > +++ b/drivers/net/netconsole.c
>> > > > > @@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
>> > > > > =C2=A0static void netconsole_device_lock(struct console *con, un=
signed long *flags)
>> > > > > =C2=A0{
>> > > > > =C2=A0	/* protects all the targets at the same time */
>> > > > > -	spin_lock_irqsave(&target_list_lock, *flags);
>> > > > > +	spin_lock(&target_list_lock);
>> > >=20
>> > > I personally think this target_list_lock can be moved to an RCU lock.
>> > >=20
>> > > If that is doable, then we probably make netconsole_device_lock()
>> > > to a simple `rcu_read_lock()`, which would solve this problem as wel=
l.
>>=20
>> The bigger issue for the nbcon patch would seem to be the seemingly
>> required .write_atomic leading to landing here with disabled IRQs.

Using spin_lock_irqsave()/spin_unlock_irqrestore() within the
->device_lock() and ->device->unlock() callbacks is fine. Even with
PREEMPT_RT this is fine. If you can use RCU to synchronize the target
list, that is probably a nice optimization, but it is certainly not a
requirement from the NBCON (and PREEMPT_RT/lockdep) perspective.

> In this case, instead of transmitting through netpoll directly in the
> .write_atomic context, we could queue the messages for later delivery.

The ->write_atomic() callback is intended to perform immediate
transmission. It is called with hardware interrupts disabled and is even
expected to work from NMI context. If you are not able to implement
these requirements, do not implement ->write_atomic(). Implementing some
sort of deferrment mechanism is inappropriate. Such a mechanism already
exists based on ->write_thread().

> With the current implementation, this is not straightforward unless we
> introduce an additional message copy at the start of .write_atomic.
>
> This is where the interface between netpoll and netconsole becomes
> problematic. Ideally, we would avoid carrying extra data into netconsole
> and instead copy the message into an SKB and queue the SKB for
> transmission.
>
> The core issue is that netpoll and netconsole are tightly coupled, and
> several pieces of functionality that live in netpoll really belong in
> netconsole. A good example is the SKB pool: that=E2=80=99s a netconsole c=
oncept,
> not a netpoll one. None of the other netpoll users send raw char *
> messages. They all work directly with skbs, so, in order to achieve it,
> we need to move the concept of skb pool into netconsole, and give
> netconsole the management of the skb pool.
>
>> WRT my patch, seeing a hard RT crash on wired box cleanly logged with
>> your nbcon patch applied (plus my twiddle mentioned earlier) tells me
>> my patch has lost its original reason to exist.  It's relevant to this
>> thread only in that those once thought to be RT specific IRQ disable
>> spots turned out to actually be RT agnostic wireless sore spots.
>
> Thanks. As a follow-up, I would suggest the following steps:
>
> 1) Decouple the SKB pool from netpoll and move it into netconsole
>
>   * This makes netconsole behave like any other netpoll user,
>     interacting with netpoll by sending SKBs.
> 	* The SKB population logic would then reside in netconsole, where it
> 	  logically belongs.
>
>   * Enable NBCONS in netconsole, guarded by NETCONSOLE_NBCON
> 	* In normal .write_atomic() mode, messages should be queued in
> 	  a workqueue.

This is the wrong approach. It cannot be expected that the workqueue is
functional during panic. ->write_atomic() needs to be able to write
directly, most likely using pre-allocated SKBs and pre-setup dedicated
network queues.

As an example, the graphics people implemented the Blue-Screen-Of-Death
by preallocating a separate graphics buffer. In case of a crash, the
hardware simply switches to the "crash buffer", rather than trying to
integrate and take control of the graphics buffer already in use.

However, it is also important to note that the graphics consoles do not
implement the ->write_atomic() callback. Instead they register a
kmsg_dumper to display the panic upon crash. This may also be a good
approach for netconsole if ->write_atomic() callbacks are not available.

> 	* If oops_in_progress is set, we bypass the queue and
> 	  transmit the SKB immediately. (Maybe disabling lockdep?!).

NBCON is meant to deprecate @oops_in_progress. However, it is true that
consoles not implementing ->write_atomic() will never print panic
output.

John Ogness

