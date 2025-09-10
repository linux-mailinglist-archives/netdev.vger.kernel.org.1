Return-Path: <netdev+bounces-221732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8088B51B2E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7823C460BE8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13029E11D;
	Wed, 10 Sep 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mdve/p9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9B255F28
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517171; cv=none; b=tnecVStleuwDTXZ8DlwFycPoL/veAQUAU0LdE/iurVNi5T3zThV/CVNn3Am+GvXuFOjNyFPY9l8cR1y7YXs7RV1nRRIydzI/bf5FrNu309jeGHbUQKF4UD+eTTMmG+0wYR/h37hzGt/aN7fxvFSbDE0q7ajVYxOThWfzp15Hi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517171; c=relaxed/simple;
	bh=yEPNFizhlMLYtzzCJT8WnF7ItC7mAbP5GDBNbLX2dIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOOUkUnmnz3JhJauyOZWb4pmlQ20wJREXG0sl6mGkmWwEq+SpCVDZ6THM/zCTa4ztjtQFcWT2Na8C2e+G4ZH5o0Sb0piJWiyABndNhYJR3V7r0t+oNiCwsarb3pbQpp4x9TA5Yk1mNPdJqOaoIKpUeTuAisXv5exevLfH4KZqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mdve/p9F; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so11855980a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757517167; x=1758121967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lS4B/kVyOWsTepn7TGoZ2DE5rifwijFnY4ZfdnGn4f8=;
        b=Mdve/p9F+UqNTYsq2yRthjQml9zzizC3UQJXiusMOTGjkDJc5hwNY5fILvKxW+XzkS
         26o3NUG7U9gQT7B7nYsANoXa/Wcy6xKtiDjvKdhPPV9qjCkHJL06rYOZFC5rXQJIkgQJ
         INePFaUb70ttosO7vBgv3Gy9Uj77EC3Pfv1ZVFSeAdb6RGviqRE8Gcr6UvIOyylrTKIz
         ChCyWxyNaLIyRuNiPMajzGsLhzxAJoP/N4QPM6RfopU4zcuYJsl2qk9Blckqgxv7KTS7
         JbMp1J9zCW5FIo+7lNGKk426uY26dLguGejnEwM2bAkH54Wpf6KdS8pLa56eWSb0yZkm
         m06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517167; x=1758121967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS4B/kVyOWsTepn7TGoZ2DE5rifwijFnY4ZfdnGn4f8=;
        b=iC47H1dQ2ZEugGhjaE7+3Xn34ZcqImENoqVMeqw4B8mGgq7b+CuZGJ/vB/ejzv4Rz7
         B0x8CE4W6VKqUxKvkhuI8sVzezBqhK2YLEJ8RXFhlSC9M+gwddmKrXAoEbQmzYq+7pu6
         rXl+0fHk2V5ovD7Wo8au4mREAm8Tptit/SIoEFjzlgFNi4ebkv/JeTAZ49tfWrrcSi+J
         BVrKnzyKXbsyrJ0uw/LrYYAzrUqdaNz6HKVLYZwoyaNEvBatpzjeHZVSrwYRgX3mdDyb
         LhwJInfsLSffsyxw/Q6sA+DIn0pwCutYs0lyXTw+ygwKtFdZFfhRrko6Cx3+7LmrXs1f
         Z3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5sqMJaVxg+iJ+56/cogx47i9iiSdL4UgrsyoUaCB8dKRnrOo5BbFhDVRg8ZSewK6jGe7X+KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAV+nljTwqwWCjsc1nwlbOUVS/DIKVVvMgK+ogzv8QeJ8S5w82
	b+FQQk1V23y0matMQIQlXZ1iru+tKVrOHfzuwh7yl44wSeTkAQRxZzSvMl1WaYiz0NQ=
X-Gm-Gg: ASbGncstQdnKeNDXIgFlZYZ9YXsDMGMHdi0gcIJw32DQb0Xx2cvlyBfE3LDWSbH1fEX
	iFp30qd7J9zA/zBjznMOf348416BubyW9WU+C2Ly5Rbys/+HlYgu3nnFAI5Z+MIjtyQUjzihOT8
	Zk8yjBXIurJc55g5gR1EgdiZN2hR78W6KGYyQQ3i+BrfHgeIF2LH/HYUm/gNHY7V8T8GgsruenT
	A8U/5hKba2f58vUDRkdLu9xX7dUgXZ+SbTfV5a9c5EjtmW4N5fGtp6YMvyy+quva8o75sD0/RAE
	0U61tOP57mLvhVIrUFyeH4GAPJJVZ1xBQyiCWX0Bp2IkjetV9ucTmHmL9q4W544sGo1a4eUb46e
	QfNWz/oBh4PLVH5n6RnMm0bVGgO5/fonek4GO
X-Google-Smtp-Source: AGHT+IEDAom2o01RiyMlPHt3bYIxRvyaze23uGNfMpTApnouglenk0sA16ZHwEvKSTawukwNZSsQqw==
X-Received: by 2002:a05:6402:354a:b0:629:1c5:808d with SMTP id 4fb4d7f45d1cf-62901c5839amr9541659a12.3.1757517166778;
        Wed, 10 Sep 2025 08:12:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018007casm3385154a12.35.2025.09.10.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:12:46 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:12:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	Simon Horman <horms@kernel.org>, kuba@kernel.org, calvin@wbinvd.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	boqun.feng@gmail.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <aMGVa5kGLQBvTRB9@pathway.suse.cz>
References: <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847by65wfj.fsf@jogness.linutronix.de>

On Wed 2025-09-10 14:28:40, John Ogness wrote:
> (Added CC printk folks since we are now talking about the nbcon API.)
> 
> Hi Breno,
> 
> On 2025-09-09, Breno Leitao <leitao@debian.org> wrote:
> > To summarize the problem:
> >
> > 1) netpoll calls .ndo_start_xmit() with IRQ disabled, which causes the
> > lockdep problem reported in this thread. (current code)
> >
> > 2) moving netconsole to use NBCON will help in the thread context, given
> > that .write_thread() doesn't need to have IRQ disabled. (This requires
> > rework of netconsole target_list_lock)
> 
> Aside from reworking the target_list_lock, be aware that ->device_lock()
> must at least disable migration. The kerneldoc for the ->device_lock()
> callback talks about this.
> 
> > 3) In the atomic context, there is no easy solution so far. The options
> > are not good, but, I will list them here for the sake of getting things
> > clear:
> >
> >   a) Defer the msg as proposed initially.
> >     Pro: If the machine is not crashing, it should simply work (?!)
> >     Cons: It cannot be expected that the workqueue is functional during panic, thus
> >           the messages might be lost
> 
> To be clear, "might be lost" means the message was not printed on the
> netconsole. The message still will have made it into the ringbuffer and
> attempted output to any other consoles as well as being available to
> crash tools.
> 
> My problem with implementing deferring is that is what ->write_thread()
> is already doing.

I agree. Deferring any job in write_atomic() callback does not make
much sense. It is primary called in panic() where the deferred
job would never be done.

And yes, if .write_atomic() callback is not implemented then the console
handling is already automatically deferred to the printk kthread.

> I wonder if we should extend the nbcon interface so that it is possible
> to specify that ->write_atomic() is not safe. Then it would only be used
> as a last resort in panic context.
> 
> @pmladek: We could introduce a new console flag (NBCON_ATOMIC_UNSAFE) so
> that the callback is only used by nbcon_atomic_flush_unsafe().

This might be an acceptable compromise. It would try to emit messages
only at the very end of panic() as the last desperate attempt.

Just to be sure, what do you mean with unsafe?

    + taking IRQ unsafe locks?
    + using trylock and ignoring result (keep using oops_in_progress check?)
    + ???

Note that write_atomic() might get serialized against other operations
using the nbcon_context locking. But it might require adding wrappers
which would take both netconsole-specific lock and nbcon_context at
the same time, similar to uart_port_*lock*() API, see
include/linux/serial_core.h

It might also require adding support for a nested nbcon_context locking.

And there is a risk that nbcon_context lock might become another big
kernel lock.


> >   b) Send the message anyway (and hope for the best)
> >     Cons: Netpoll will continue to call IRQ unsafe locks from IRQ safe
> >           context (lockdep will continue to be unhappy)
> >     Pro: This is how it works today already, so, it is not making the problem worse.
> >          In fact, it is narrowing the problem to only .write_atomic().
> 
> Two concerns here:
> 
> 1. ->write_atomic() is also used during normal operation
> 
> 2. It is expected that ->write_atomic() callbacks are implemented
>    safely. The other nbcon citizens are doing this. Having an nbcon
>    driver with an unsafe ->write_atomic() puts all nbcon drivers at risk
>    of not functioning during panic.
> 
> This could be combined with (a) so that ->write_atomic() implements its
> own deferred queue of messages to print and only when
> @legacy_allow_panic_sync is true, will it try to send immediately and
> hope for the best. @legacy_allow_panic_sync is set after all nbcon
> drivers have had a chance to flush their buffers safely and then the
> kernel starts to allow less safe drivers to flush.

I think that the important trick is adding the NBCON_ATOMIC_UNSAFE
flag. The practice will show where such callbacks might be
allowed (risk vs. gain).

> Although I would prefer the NBCON_ATOMIC_UNSAFE approach instead.

Yes, I would start with allowing unsafe write_atomic() only
in nbcon_atomic_flush_unsafe() and see if it is enough.


> >   c) Not implementing .write_atomic
> >     Cons: we lose the most important messages of the boot.
> >
> >   Any other option I am not seeing?
> 
> d) Not implementing ->write_atomic() and instead implement a kmsg_dumper
>    for netconsole. This registers a callback that is called during
>    panic.
> 
>    Con: The kmsg_dumper interface has nothing to do with consoles, so it
>         would require some effort coordinating with the console drivers.
> 
>    Pro: There is absolute freedom for the dumper to implement its own
>         panic-only solution to get messages out.

I guess that the dumper would use similar tricks as an "unsafe"
write_atomic() callback.

I would personally try the appraoch with the "unsafe" write_atomic()
callback first, IMHO, it would allow more flexibility than adding
a special kmsg_dumper.

> e) Involve support from the underlying network drivers to implement true
>    atomic sending. Thomas Gleixner talked [0] very briefly about how
>    this could be implemented for netconsole during the 2022
>    proof-of-concept presentation of the nbcon API.
> 
>    Cons: It most likely requires new API callbacks for the network
>          drivers to implement hardware-specific solutions. Many (most?)
>          drivers would not be able to support it.
> 
>    Pro: True reliable atomic printing via network.

Yeah, that is the dream solution :-)

Best Regards,
Petr

