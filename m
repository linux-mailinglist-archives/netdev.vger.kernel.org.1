Return-Path: <netdev+bounces-222127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7123DB53359
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3323D3B12E8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E337322DAC;
	Thu, 11 Sep 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwhyprMN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMs5BdlM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9925322A3E;
	Thu, 11 Sep 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596437; cv=none; b=kexmzFDkgWPwywiTyYbKKbODWTBZBRSPJvcf5H7nM+WSSfhCGjt0vWQ7IOUbfGhd6qIqGNPqXAHEb5AqJcLMvnqT0dsYFX6exSMnPhWLdKJAxrAGSBMUSkNC+oKRfoBpY4VGo2fap2ousFSbjGS1mwy/K9jquOYvriwcHQtLa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596437; c=relaxed/simple;
	bh=73iFDOiXCdvBY18nxzbc6eGmunQplWXFUz3cd2PJnKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUC+m9S7AyubLHykrQyObZ6RbxdIyEwbSskgFALR+pLjDn6yxeIkBtG0rNlZtX9UhDG/25OGbLpks9qK+SIndVbheXq+05P9iqIMzHcSTJsCk/XxaesK2YcU6wbxm90pqE4tsAUDoh2rSSv3lur5Xo+WwRITN7zul/SM+Q8KZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwhyprMN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMs5BdlM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757596434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKIj5kDbTyAEjfbreZnJcy5S7eAGhbm+kpBtmsNVvJs=;
	b=YwhyprMNVk57f+Oc68D5wFyfwuwwwKm195k9ihL7SPD6PF0I0atIGbMHryHrWjOxalLODQ
	oF4jkMFAD4nN77NIV9JOQ3OXJnJmMhF6L7Jt65SlGNAIpYVmWKTWKHLyhmeztadZu4/1md
	gWToVbiyBRnDpG1CoJR0YbCVRT0RKg+oBuTIJmZ91RG8tQF/JqcCcuM/KEAze6rCDpFDzl
	NDnHXcExaRSUDzvYt4bP0SObLizlHrncrrJane/UuC+GZ1Gn9B5r4JbSMcukXYICKAq1C1
	gQ5AbZyzh4+H3p7vOo25D02cVt6j965bqSVfEGkn1V9SA4fJ+MWYbPeHJModBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757596434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKIj5kDbTyAEjfbreZnJcy5S7eAGhbm+kpBtmsNVvJs=;
	b=DMs5BdlMWyO1rxZPEsqWhZH//6ROEFekjl1NQEXqq9/SwNZpNYJu1uvi4QL0EOpBsTeeiI
	0HcMpAwmJ/UPOVBg==
To: Breno Leitao <leitao@debian.org>
Cc: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>,
 kuba@kernel.org, calvin@wbinvd.org, Pavel Begunkov
 <asml.silence@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
In-Reply-To: <cbvfyefqdyy6py2fswqp3licm3ynrsmc3jclgnbubp72elmai7@kwvks5yhkybc>
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
 <cbvfyefqdyy6py2fswqp3licm3ynrsmc3jclgnbubp72elmai7@kwvks5yhkybc>
Date: Thu, 11 Sep 2025 15:19:53 +0206
Message-ID: <84ecsdxhbi.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-10, Breno Leitao <leitao@debian.org> wrote:
>> d) Not implementing ->write_atomic() and instead implement a kmsg_dumper
>>    for netconsole. This registers a callback that is called during
>>    panic.
>> 
>>    Con: The kmsg_dumper interface has nothing to do with consoles, so it
>>         would require some effort coordinating with the console drivers.
>
> I am looking at kmsg_dumper interface, and it doesn't have the buffers
> that need to be dumper.
>
> So, if I understand corect, my kmsg_dumper callback needs to handle loop
> into the messages buffer and print the remaining messages, right?

Correct.

> In other words, do I need to track what messages were sent in
> netconsole, and then iterate in the kmsgs buffer 
> to find messages that hasn't been sent, and send from there?

Yes, right now it would not even be possible to do the proper tracking
since the sequence numbers are not exposed to the console printers and
they are not part of kmsg_dump interface.

As it is right now, the kmsg_dumper would just print what is available
in the ringbuffer, even if most of the messages have already been
printed during runtime. Certainly not optimal.

>>    Pro: There is absolute freedom for the dumper to implement its own
>>         panic-only solution to get messages out.
>
> What about calls to .write_atomic() calls that are not called during
> panic? Will those be lost in this approach?

In this approach you would not implement ->write_atomic(), so there
would be no such calls. All printing would be deferred to the dedicated
printing kthread.

Anyway, it looks like we have agreed to allow unsafe ->write_atomic()
callbacks.

John

