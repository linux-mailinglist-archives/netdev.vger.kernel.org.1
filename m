Return-Path: <netdev+bounces-248537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F852D0AD48
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B2A301FB65
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D0331A547;
	Fri,  9 Jan 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2a0GKbxy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxiEBXEV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50112D21B;
	Fri,  9 Jan 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971615; cv=none; b=TFUJeDzgpzSh9Rt1/cWQsyeZXoJE5OLEwaqaRk1g+uYcN2Vebo6eC1X//2vZ/uGyRlqDi2WC/unPZBVny9M2JWDpyWbtLvmMbM4hHpXGS5GjBPqrf9f3f/yMFVPdlEHyIGoEIp5M1GnmJsSwCpXpLHRAIwTqiBjsv69+b5nH0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971615; c=relaxed/simple;
	bh=J2CZaM1UhMy1P6h7NmVr/tvqWJDIyumGwGfGZg0KkvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/gDYilxnvhmLWUpIUMAnW69LjNc9yMtrXMRU/fz/fLovgXxP2K+QAQBuXCCBc3rqVLk2cr92/vR0X2MnLqDk7M6K7+ElcFtaZoEwkNDCADOp9D/rhsN9l0e3ubHy4emIOcuqvmdHfHsSjv94eB5rLE5KHvEGaQHkJDuzwhKkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2a0GKbxy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxiEBXEV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767971612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3U/BxbZ57ZSCnDxIqYMpvtU5V5Jb7J5vxyA95YCvzw=;
	b=2a0GKbxycr9RluomLAR+TuHwG8E/usoGTPxXnWNcr9SNZNhGe1APjc9o9n5wPs8MoXc6X9
	U3ZpXos70D2YSMWthkQANDbcU5vTR3/U5zieo+bIyUVmW+5GbLKI/dZMevaQ2sLdBiaT8d
	8YLnZc6ivhlZmXAkoMITsrmWgiXiPqs1WI3R/gFFGH6MsFX8HLt5OtaLhj0Y79vzmlPo+k
	P/0qkh4dr8AxiVVpujXW5wDFUTLDPQIX/RnEmAeNfWaXIxj3oOG75yBZam4z4cpGgD0zIK
	M6dJwF6LDhtbe+2nmUzm5l5HBAPllbhaFaRPt9bYv/12u7BSjtIsObj3G9z3ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767971612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3U/BxbZ57ZSCnDxIqYMpvtU5V5Jb7J5vxyA95YCvzw=;
	b=cxiEBXEVKLDr15TSIJcPKFBqk7iumd9AgtBbVSxYqxa+m88Lp03ifZQQyv1F3KvLBRf9Tb
	3JsGzwd0nloAfnAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Breno Leitao <leitao@debian.org>, mpdesouza@suse.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com,
 efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
In-Reply-To: <aWECzkapsFFPFKNP@pathway.suse.cz>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de> <aWECzkapsFFPFKNP@pathway.suse.cz>
Date: Fri, 09 Jan 2026 16:19:31 +0106
Message-ID: <875x9a6cpw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-01-09, Petr Mladek <pmladek@suse.com> wrote:
> If we were adding this info, I would add it for all users, definitely.
> We are going to touch the internal printk ringbuffer format anyway.

Which could mean we are going to need a round of updating crash/dump
tools. So we should choose wisely.

> Now, the main question is how far we want to go.
>
> I see the following possibilities:
>
> A) caller_id -> pid + cpu + atomic/task context bit
> ===================================================
>
> Replace the current .caller_id and always save both PID and CPU
> number. Something like:
>
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 4ef81349d9fb..3c7635ada6dd 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -9,6 +9,12 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  
> +
> +struct printk_caller {
> +	pid_t	pid;	/* caller pid */
> +	int	cpu;	/* caller CPU number */
> +};
> +
>  /*
>   * Meta information about each stored message.
>   *
> @@ -22,8 +29,8 @@ struct printk_info {
>  	u8	facility;	/* syslog facility */
>  	u8	flags:5;	/* internal record flags */
>  	u8	level:3;	/* syslog level */
> -	u32	caller_id;	/* thread id or processor id */
>  
> +	struct printk_caller caller;
>  	struct dev_printk_info	dev_info;
>  };
>
> Plus the task/interrupt bit might be stored either as the highest bit
> in .pid or by adding LOG_CALLER_IN_TASK bit into "enum printk_info_flags".

The thing I find attractive about this solution is that it could be done
such that crash/dump tools must not be changed. We could leave the
semantics for @caller_id as is and simply add @cpu:

--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -23,6 +23,7 @@ struct printk_info {
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
+	u32	cpu;	/* processor id */
 
 	struct dev_printk_info	dev_info;
 };

After all, if the caller is not in_task() then the new @pid would be
meaningless anyway.

If we are willing to accept printer-resolution of task names, then this
simple addition would be good enough for netconsole, while not requiring
any crash/dump tool updates. This would buy us time to think more
seriously about a significant overhaul.

> B) caller_id -> pid + cpu + contex
> ==================================
>
> Same as above but the caller context info is stored separately and
> might allow to distinguish more types. Something like:
>
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 4ef81349d9fb..44aa60a3f84c 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -9,6 +9,19 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  
> +#define PRINTK_CALLER_CTXT_PREEMPT_BIT		1
> +#define PRINTK_CALLER_CTXT_SOFTIRQ_BIT		2
> +#define PRINTK_CALLER_CTXT_HARDIRQ_BIT		3
> +#define PRINTK_CALLER_CTXT_NMI			4
> +/* This is not supported on all platforms, see irqs_disabled() */
> +#define PRINTK_CALLER_CTXT_IRQS_DISABLED	5
> +
> +struct printk_caller {
> +	u8	ctxt;	/* caller context: task, irq, ... */
> +	pid_t	pid;	/* caller pid */
> +	int	cpu;	/* caller CPU number */
> +};
> +
>  /*
>   * Meta information about each stored message.
>   *
> @@ -22,8 +35,8 @@ struct printk_info {
>  	u8	facility;	/* syslog facility */
>  	u8	flags:5;	/* internal record flags */
>  	u8	level:3;	/* syslog level */
> -	u32	caller_id;	/* thread id or processor id */
>  
> +	struct printk_caller caller;
>  	struct dev_printk_info	dev_info;
>  };

Just as with A, here we could also preserve @caller_id semantics
(instead of introducing @pid) to avoid crash/dump tool updates.

A new @ctxt field is only useful if it can be seen. I am not sure how
you plan on showing this. By extending the prefix like caller_id does?
Would it be a new kernel config or just use CONFIG_PRINTK_CALLER? Either
way, we are talking about extending visible log data, which is something
that needs a discussion on its own.

> C) caller_id -> pid + cpu + comm + atomic/task context bit
> ==========================================================
>
> Similar to A and B but add also
>
> 	char comm[TASK_COMM_LEN];
>
> into struct printk_caller.

Just as with A and B, we could preserve @caller_id semantics.

This is the simplest solution since the printer would not need to
perform any resolution at all and it would be 100% accurate (when
in_task).

> D) caller_id -> pid + cpu + comm + atomic/task context bit
>    and move printk_caller + printk_dev_info into text buffer
>    as suggested as mentioned at
>    https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de
> ====================================================================
>
>    There are many possibilities how to do it. And it involves two
>    problems:
>
>       a) how to store the data into data buffer
>       b) how to integrate this in the ring buffer API
>
>     I thought about several approaches and realized that it still
>     would make sense to keep:
>
>        + binary data (pid, cpu, ctxt) in desc ring
>        + text data (comm, subsystem, device) in text_data buffer
>
>     Something like:
>
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 4ef81349d9fb..41232bf2919d 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -9,6 +9,27 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  
> +#define PRINTK_CALLER_CTXT_PREEMPT_BIT		0
> +#define PRINTK_CALLER_CTXT_SOFTIRQ_BIT		1
> +#define PRINTK_CALLER_CTXT_HARDIRQ_BIT		2
> +#define PRINTK_CALLER_CTXT_NMI			3
> +/* This is not supported on all platforms, see irqs_disabled() */
> +#define PRINTK_CALLER_CTXT_IRQS_DISABLED	4
> +
> +struct printk_caller {
> +	u8	ctxt;	/* caller context: task, irq, ... */
> +	pid_t	pid;	/* caller pid */
> +	int	cpu;	/* caller CPU number */
> +};
> +
> +/*
> + * Describe which text information about the caller
> + * is stored in text_data_ring
> + */
> +#define PRINTK_CALLER_BITS_COMM_BIT		0
> +#define PRINTK_CALLER_BITS_SUBSYSTEM_BIT	1
> +#define PRINTK_CALLER_BITS_DEVICE_BIT		2
> +
>  /*
>   * Meta information about each stored message.
>   *
> @@ -22,9 +43,8 @@ struct printk_info {
>  	u8	facility;	/* syslog facility */
>  	u8	flags:5;	/* internal record flags */
>  	u8	level:3;	/* syslog level */
> -	u32	caller_id;	/* thread id or processor id */
> -
> -	struct dev_printk_info	dev_info;
> +	u8	caller_bits_size; /* size of the caller info in data buffer */
> +	u8	caller_bits;	/* bits describing caller in data buffer */
>  };
>  
>  /*
>
> The text would be stored in the test_data_ring in the following
> format:
>
> 	[<comm>\0][<subsystem>\0][<device\0]<text>\0

I would prefer:

<text>\0[<subsystem>\0][<device>\0][<comm>\0]

Crash/dump tools that are not updated would at least continue to print
the text at the beginning of the line. Here are a few projects that I
track and how they would react (unmodified):

makedumpfile
- https://github.com/makedumpfile/makedumpfile/blob/master/printk.c#L134
- will print "\x00" between the fields

vmcore-dmesg
- https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c?h=main#n904
- will print "\x00" between the fields

crash
- https://github.com/crash-utility/crash/blob/master/printk.c#L210
- will print "." between the fields

> aka, strings separated by '\0'. The information about the caller
> would be optional where:
>
>    + .caller_bits_size would contain the size of the optional
>      pieces, including the trailing '\0's.

I do not know if we would need this. @text_len could include the caller
area as well.

>    + .caller_bits number would define which particular pieces
>      are there. It would be even somehow extensible. The crash
>      tool could ignore parts which are not supported.

Yes, this works well.

> My opinion:
> ===========
>
> I personally think that the approach B) is the best compromise for now
> because:
>
> 1. We really should distinguish task/interrupt context. IMHO, it is
>    a very useful information provided by the caller_id now.
>
>    The approach A) stores the context a hacky way. The approach B)
>    is cleaner and provides even more precise info.
>
>
> 2. The mapping between PID and COMM might get lost if we do not store it.
>    But it should not be problem most of the time because we try
>    to flush consoles ASAP.
>
>    I would keep it simple for now. We could add it later when it
>    becomes a problem in practice.
>
>    BTW: I think that we could detect when the mapping is valid
> 	by comparing task->start_time with current time...
>
>    Devil advocate: Adding comm[TASK_COMM_LEN] into struct printk_info
> 		might be acceptable. It is "just" 16 bytes in compare
> 		with 64 bytes for dev_printk.

I am OK with A, B, or C if we can keep the @caller_id semantics. This
would not require any changes to the LOG_CONT implementation or any
other exists buffer preparation code and it would not require and
changes do crash/dump tools. I.e. it would simply be making new fields
available for netconsole.

I can accept that we want to avoid C for now until we solve the
efficient space issue.

(My official preference list is below...)

> 3. It would be nice to optimize the memory usage and store the
>    optional and variable strings (comm, subsystem, device) into
>    data buffer. But it looks like a non-trivial work.
>
>    I would do this only when there is a real demand. And I haven't
>    heard about that the current approach was not acceptable yet.

Well, the whole reason the topic came up is because of a complaint from
Geert. And I think if people knew just how much space was being wasted,
they might speak up. For example, on my Debian distro kernel, I have a
256KB text_data_ring and an 896KB desc_ring. I expect that the total
usage would cut in half if we packed the dev_printk_info data into the
text_data_ring. I can prototype some tests (just to satisfy my
curiousity).

I do not think it would be much work. Whether the strings are copied
from text_data arrays or dev_printk_info structs does not make much
difference. There is only a slightly larger overhead to identify their
existance and offsets. (Currently it is a single memcpy() of
dev_printk_info.)

But we would need to update the crash/dump tools. So I am not in a rush
to implement D right now.

My ordered preferences for right now would be:

1. keeping @caller_id semantics + adding @cpu + adding @comm (similar to
your C)

2. keeping @caller_id semantics + adding @cpu (similar to your A)

These additions would be purely to support netconsole and the additions
would be under CONFIG_NETCONSOLE_DYNAMIC. No crash/dump tools should be
changed due to this.

For the long term I would like to move all strings into the
text_data_ring. We could use that opportunity to add context bits, time
stamps, etc. and then appropriately update the major crash/dump tools.

John

