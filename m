Return-Path: <netdev+bounces-133171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35D99532A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24BB28816A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C331DFE2A;
	Tue,  8 Oct 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQ0ppgVu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDK3cqiu"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4475B1FB;
	Tue,  8 Oct 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400688; cv=none; b=ayho6zTo34iE8AvYH/5WLkvFViB+7cLkaxmUdnao2DEv5sWhT7NaJhaoC31CbA66mR+9TloehLBFfoOHZWT7wSidQNZXdtx+BhBRLj3XyYzVT/iLRSZoR5NCIue9mBcM4G6lslmxsy9qnO/qB284+08i5RaiUI9pMeXzYStYFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400688; c=relaxed/simple;
	bh=nGjB7oXWchp3d4x4wVM7HDVN77xzBHezzIhqJR/PWU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c2p3ZWoS4TRjrl++IXRCaW+46R1v+Ogo+ptKkcRRY0OJeDOocpl80MXnX5spmmqT1kD3JKg6AieHzHOBVwNoFa0k8VO5hxNfKG3Weppyi6NY44bzO1G1I75vRXGrA7r9op+POc9dQXhdpE5/vTUOndJ+KW88uyPNJeWOmPD8ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQ0ppgVu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDK3cqiu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728400685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgHNgZ7Lv8TsBA3deZP3mh7SKeKs0mAoGrC4a2a8YU4=;
	b=uQ0ppgVu3/sV/Gm78x/SJKO2+d7WyFtrUIjCc0JLpmXGBwZwB1aUdM5cBJUYWxd6jkwZex
	beGght0vQXLMVIooB/vkcg6Mz0dr7Co9ITqEr0T5t+jtxLXeNT6y47SpWa1elbVHEiJgOy
	szbpZb6TIzT+t7VVcGgUIMwnbrhZzEAlEPi617Ojmmq4nngu67sRzC5v8Zc0VM4nWhqYht
	3rCGF6APVCKpuQmUkG11hUFWoDA0eWVXtawmzQ6XJD2N6727JjLEppfACKbnvoqE+4pJlF
	j2ojL0Op5wld/pL27QYGN+2qpzswamFawZkxYc0Je2eb/M26heOXnoiS16qjew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728400685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgHNgZ7Lv8TsBA3deZP3mh7SKeKs0mAoGrC4a2a8YU4=;
	b=gDK3cqiuKWv063xejb/51LZ5wkI4v1qmG5N39LB+VtgUqTXMvCm325NgmORo9cYDEuGrcf
	yztojqA3zwvY3RDw==
To: Petr Mladek <pmladek@suse.com>, Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk, Breno
 Leitao <leitao@debian.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
In-Reply-To: <Zv_IR9LAecB2FKNz@pathway.suse.cz>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
 <20241003153231.GV5594@noisy.programming.kicks-ass.net>
 <20241003-mahogany-quail-of-reading-eeee7e@leitao>
 <20241004-blazing-rousing-lynx-8c4dc9@leitao>
 <Zv_IR9LAecB2FKNz@pathway.suse.cz>
Date: Tue, 08 Oct 2024 17:24:04 +0206
Message-ID: <8434l6sjwz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-04, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2024-10-04 02:08:52, Breno Leitao wrote:
>> 	 =====================================================
>> 	 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>> 	 6.12.0-rc1-kbuilder-virtme-00033-gd4ac164bde7a #50 Not tainted
>> 	 -----------------------------------------------------
>> 	 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>> 	 ff1100010a260518 (_xmit_ETHER#2){+.-.}-{2:2}, at: virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
>> 
>> 	and this task is already holding:
>> 	 ffffffff86f2b5b8 (target_list_lock){....}-{2:2}, at: write_ext_msg (drivers/net/netconsole.c:?) 
>> 	 which would create a new lock dependency:
>> 	  (target_list_lock){....}-{2:2} -> (_xmit_ETHER#2){+.-.}-{2:2}
>> 
>> 	but this new dependency connects a HARDIRQ-irq-safe lock:
>> 	  (console_owner){-...}-{0:0}

...

>> 	to a HARDIRQ-irq-unsafe lock:
>> 	  (_xmit_ETHER#2){+.-.}-{2:2}

...

>> 	other info that might help us debug this:
>> 
>> 	 Chain exists of:
>> 	console_owner --> target_list_lock --> _xmit_ETHER#2
>> 
>> 	  Possible interrupt unsafe locking scenario:
>> 
>> 		CPU0                    CPU1
>> 		----                    ----
>> 	   lock(_xmit_ETHER#2);
>> 					local_irq_disable();
>> 					lock(console_owner);
>> 					lock(target_list_lock);
>> 	   <Interrupt>
>> 	     lock(console_owner);

I can trigger this lockdep splat on v6.11 as well.

It only requires a printk() call within any interrupt handler, sometime
after the netconsole is initialized and has had at least one run from
softirq context.

> My understanding is that the fix is to always take "_xmit_ETHER#2"
> lock with interrupts disabled.

That seems to be one possible solution. But maybe there is reasoning why
that should not be done. (??) Right now it is clearly a spinlock that is
being taken from both interrupt and softirq contexts and does not
disable interrupts.

I will check if there is some previous kernel release where this problem
does not exist.

John Ogness

