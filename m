Return-Path: <netdev+bounces-249041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB2D1315D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959953090DEC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065225A642;
	Mon, 12 Jan 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5fH+uCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521B24E4D4
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227451; cv=none; b=g3IPJhFiBjsLKunAZ9lC+4Fcbm3zt9FB3gyQfzF0O5yEGYvPNWpZEJBs0bXtaJ6U7VkoHrAyhY67xkjWU2j36e1Y9cveEB1vkj2UHECfAEjN5TkkkS6NHxtsgd3JZWbaYcmOIBe74zeXFB3uzka9jP01Auc97wm8B//TYj5xw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227451; c=relaxed/simple;
	bh=S3eCKmlsl1Udsf17BakkVb+/rk1BD2/5rrtVbW/vcME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFFdECUzSsKmLc3Wwq2s6NAv4V5U8EIEfXbwjfoHdhctBDzc/6SuqP4LDaRrjwHyxhyszsgsi5yIOSjmiZT6xzgtGAfQ4AhFfujTGlZ61DaJJkbOsEdROIkYNL/xdP7r266psAoZf6CtNsaN1CnWWGcHa/DL6k8nLjxYVuoixuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5fH+uCf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb2314f52so3406932f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768227448; x=1768832248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8owfCCztoFWeCmMti+i4DvWjMHDGb0L/qJYHP/8TCkU=;
        b=S5fH+uCfKHLjkYtuulbeji+ZqeQhlko6tIVdKuEcDOMrN3qNMU0/JIjhUGSvJyC+8E
         FSggtdWWgK+wphY5GJWxX5b5M1qJAmAq6qEt5VQNVUH2qnvI3dutn4Awqrq1qYswlamg
         FOBiWQjvumTBmi0s0q21xyS+GVncZIXlUs7oAcqEcfeoEt1EBuNUVwntrJK8xInh0k0l
         nkjqn2tyJDnPa0l/ZFrIv+uG+5KBhW8m50CiOOQImy3owEyqXfraA4NkFPogiX4nHXOf
         3+82+1gnq3NviKEvKyPjihP2e02DzOtaKUFrFFeyUBZ20dkN5Jep41DQ+nbrsXDlqJKf
         xVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227448; x=1768832248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8owfCCztoFWeCmMti+i4DvWjMHDGb0L/qJYHP/8TCkU=;
        b=gPeFlP+i6g9EH/BCPlSV7fOid5A8jqijqtUH9bhj87J9gXzsCgj78QEPWtzrtKTFjI
         KSPJ5oWSgVM6VIWFOB90i307lskwQPH+gzDTYu+kCTdUc+hdbT+MivkR0QPtULUZWCd3
         Uc8djjEfREHUg+yTErmIxNL42fNpNNl9wiTDOhH385yS6Z6EGe6yhvTXgqLtXpxaGYbs
         Hyup1geLJurLedRmZj38q/BuoHr2B0loaENMqY3nM6UytfzJAiDllfu5i5Z0X0Z4TSJf
         WxgCmvnv78FU3YgSyBjTdJDUfHGlHfgaY5esy3NpC1aYVrnXkPsvtfwY2h5a6FOnabs3
         IZaw==
X-Forwarded-Encrypted: i=1; AJvYcCWi5rxnrqUDYIzq9z0IKCh/GSEdOISO4D/bNWzmVl7jZjxT8W3OKzqwSujGO0kOdJksYO3ZDJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrr2s9sxUyKGZ2bC1q8gyze+7lZkHfHCP+WM4xqzhiaxZhebj
	ciawkyC8hFh2IrRnANWd2YuKPQThis1ow4LOpSPdQkRv/20Fn0EbrEp4sN2mEXsyTMw=
X-Gm-Gg: AY/fxX68zNmUVGQBy6G5x6zK602jK7yyaGLBbHJkwPbn/LAr8DA171IJ2ls7EgXMdrF
	hrKmqU61v+FiQzLV7rSdzHH2vCr4kDGwGkxqBAYNkJaMjFZ5FkMjJPce1uSqUIakarFjrwrQzYT
	vFu9swVxEAlHUsIDBEn3xA9k+Ka2bSwgSsRa6xyBbboEI370l9o/Q85xFW3qVCpLcmInDOjAqzL
	t8dZgfgdZmWT84hfTPZE3df2KwyuhYR7GlRZQZSfBmukXMEcByIhSLJO02c6eMZQMHLo9yb7/Z2
	f6ES/82B1+gxL+EQ2HZem0nnPqHAiqmgNLSqaSVQ8Xms9uToCBUEh0F73OMmCAuY3akX+CJCJLa
	PeHm7VQzEZSp1hB7Gn1EuwVDBaDTL4aTcm+ycxXH3qsBKq2tGVkmAGROhQQXTYhf0ypFk6eJNfW
	exVQVWn7KFHE7X7MaU1pt70KEe
X-Google-Smtp-Source: AGHT+IGYCsvPH9Ehg4CgfJb24N/qOVRt8IYsy4rCCAs8OG3ED1AAKxOQKguVhegXUXtyqemFRXt4Rw==
X-Received: by 2002:a05:6000:2511:b0:429:ba48:4d8 with SMTP id ffacd0b85a97d-432c377c5c5mr20771078f8f.25.1768227447565;
        Mon, 12 Jan 2026 06:17:27 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacdcsm38366323f8f.1.2026.01.12.06.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:17:27 -0800 (PST)
Date: Mon, 12 Jan 2026 15:17:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Breno Leitao <leitao@debian.org>, mpdesouza@suse.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com,
	calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <aWUCc73o4UeYtz-z@pathway.suse.cz>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x9a6cpw.fsf@jogness.linutronix.de>

On Fri 2026-01-09 16:19:31, John Ogness wrote:
> On 2026-01-09, Petr Mladek <pmladek@suse.com> wrote:
> > If we were adding this info, I would add it for all users, definitely.
> > We are going to touch the internal printk ringbuffer format anyway.
> 
> Which could mean we are going to need a round of updating crash/dump
> tools. So we should choose wisely.

Exactly :-)

> > Now, the main question is how far we want to go.
> >
> > I see the following possibilities:
> >
> > A) caller_id -> pid + cpu + atomic/task context bit
> > ===================================================
> >
> > Replace the current .caller_id and always save both PID and CPU
> > number. Something like:
> >
> > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > index 4ef81349d9fb..3c7635ada6dd 100644
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -9,6 +9,12 @@
> >  #include <linux/stddef.h>
> >  #include <linux/types.h>
> >  
> > +
> > +struct printk_caller {
> > +	pid_t	pid;	/* caller pid */
> > +	int	cpu;	/* caller CPU number */
> > +};
> > +
> >  /*
> >   * Meta information about each stored message.
> >   *
> > @@ -22,8 +29,8 @@ struct printk_info {
> >  	u8	facility;	/* syslog facility */
> >  	u8	flags:5;	/* internal record flags */
> >  	u8	level:3;	/* syslog level */
> > -	u32	caller_id;	/* thread id or processor id */
> >  
> > +	struct printk_caller caller;
> >  	struct dev_printk_info	dev_info;
> >  };
> >
> > Plus the task/interrupt bit might be stored either as the highest bit
> > in .pid or by adding LOG_CALLER_IN_TASK bit into "enum printk_info_flags".
> 
> The thing I find attractive about this solution is that it could be done
> such that crash/dump tools must not be changed. We could leave the
> semantics for @caller_id as is and simply add @cpu:
>
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -23,6 +23,7 @@ struct printk_info {
>  	u8	flags:5;	/* internal record flags */
>  	u8	level:3;	/* syslog level */
>  	u32	caller_id;	/* thread id or processor id */
> +	u32	cpu;	/* processor id */
>  
>  	struct dev_printk_info	dev_info;
>  };
> 
> After all, if the caller is not in_task() then the new @pid would be
> meaningless anyway.

Or we could use:

	u32	caller_id2;	/* processor id or thread id,

, where .caller_id2 is a complement to caller_id which is backward
compatible. The highest bit in @caller_id would define what
is stored where.

We could create helpers to encode/decode it:

	set_printk_info_cpu(struct printk_info *info, int cpu);
	get_printk_info_cpu(struct printk_info *info);
	...

It is a bit ugly. But storing CPU twice is kind of ugly as well.
And it will provide all information for netconsole.


> If we are willing to accept printer-resolution of task names, then this
> simple addition would be good enough for netconsole, while not requiring
> any crash/dump tool updates. This would buy us time to think more
> seriously about a significant overhaul.

I am just a bit afraid that this might stay quite a long time
until anyone gets motivation and time to clean it.


> > B) caller_id -> pid + cpu + contex
> > ==================================
> >
> > Same as above but the caller context info is stored separately and
> > might allow to distinguish more types. Something like:
> >
> > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > index 4ef81349d9fb..44aa60a3f84c 100644
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -9,6 +9,19 @@
> >  #include <linux/stddef.h>
> >  #include <linux/types.h>
> >  
> > +#define PRINTK_CALLER_CTXT_PREEMPT_BIT		1
> > +#define PRINTK_CALLER_CTXT_SOFTIRQ_BIT		2
> > +#define PRINTK_CALLER_CTXT_HARDIRQ_BIT		3
> > +#define PRINTK_CALLER_CTXT_NMI			4
> > +/* This is not supported on all platforms, see irqs_disabled() */
> > +#define PRINTK_CALLER_CTXT_IRQS_DISABLED	5
> > +
> > +struct printk_caller {
> > +	u8	ctxt;	/* caller context: task, irq, ... */
> > +	pid_t	pid;	/* caller pid */
> > +	int	cpu;	/* caller CPU number */
> > +};
> > +
> >  /*
> >   * Meta information about each stored message.
> >   *
> > @@ -22,8 +35,8 @@ struct printk_info {
> >  	u8	facility;	/* syslog facility */
> >  	u8	flags:5;	/* internal record flags */
> >  	u8	level:3;	/* syslog level */
> > -	u32	caller_id;	/* thread id or processor id */
> >  
> > +	struct printk_caller caller;
> >  	struct dev_printk_info	dev_info;
> >  };
> 
> Just as with A, here we could also preserve @caller_id semantics
> (instead of introducing @pid) to avoid crash/dump tool updates.
> 
> A new @ctxt field is only useful if it can be seen. I am not sure how
> you plan on showing this. By extending the prefix like caller_id does?

I am afraid that we would need to come up with another format.
I wanted to get some inspiration from lockdep. And check other
subystems which might already show this (backtrace, ftrace, ...)

> Would it be a new kernel config or just use CONFIG_PRINTK_CALLER? Either
> way, we are talking about extending visible log data, which is something
> that needs a discussion on its own.

Sure. We should think twice about it.

> > C) caller_id -> pid + cpu + comm + atomic/task context bit
> > ==========================================================
> >
> > Similar to A and B but add also
> >
> > 	char comm[TASK_COMM_LEN];
> >
> > into struct printk_caller.
> 
> Just as with A and B, we could preserve @caller_id semantics.
> 
> This is the simplest solution since the printer would not need to
> perform any resolution at all and it would be 100% accurate (when
> in_task).
> 
> > D) caller_id -> pid + cpu + comm + atomic/task context bit
> >    and move printk_caller + printk_dev_info into text buffer
> >    as suggested as mentioned at
> >    https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de
> > ====================================================================
> >
> >    There are many possibilities how to do it. And it involves two
> >    problems:
> >
> >       a) how to store the data into data buffer
> >       b) how to integrate this in the ring buffer API
> >
> >     I thought about several approaches and realized that it still
> >     would make sense to keep:
> >
> >        + binary data (pid, cpu, ctxt) in desc ring
> >        + text data (comm, subsystem, device) in text_data buffer
> >
> >     Something like:
> >
> > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > index 4ef81349d9fb..41232bf2919d 100644
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -9,6 +9,27 @@
> >  #include <linux/stddef.h>
> >  #include <linux/types.h>
> >  
> > +#define PRINTK_CALLER_CTXT_PREEMPT_BIT		0
> > +#define PRINTK_CALLER_CTXT_SOFTIRQ_BIT		1
> > +#define PRINTK_CALLER_CTXT_HARDIRQ_BIT		2
> > +#define PRINTK_CALLER_CTXT_NMI			3
> > +/* This is not supported on all platforms, see irqs_disabled() */
> > +#define PRINTK_CALLER_CTXT_IRQS_DISABLED	4
> > +
> > +struct printk_caller {
> > +	u8	ctxt;	/* caller context: task, irq, ... */
> > +	pid_t	pid;	/* caller pid */
> > +	int	cpu;	/* caller CPU number */
> > +};
> > +
> > +/*
> > + * Describe which text information about the caller
> > + * is stored in text_data_ring
> > + */
> > +#define PRINTK_CALLER_BITS_COMM_BIT		0
> > +#define PRINTK_CALLER_BITS_SUBSYSTEM_BIT	1
> > +#define PRINTK_CALLER_BITS_DEVICE_BIT		2
> > +
> >  /*
> >   * Meta information about each stored message.
> >   *
> > @@ -22,9 +43,8 @@ struct printk_info {
> >  	u8	facility;	/* syslog facility */
> >  	u8	flags:5;	/* internal record flags */
> >  	u8	level:3;	/* syslog level */
> > -	u32	caller_id;	/* thread id or processor id */
> > -
> > -	struct dev_printk_info	dev_info;
> > +	u8	caller_bits_size; /* size of the caller info in data buffer */
> > +	u8	caller_bits;	/* bits describing caller in data buffer */
> >  };
> >  
> >  /*
> >
> > The text would be stored in the test_data_ring in the following
> > format:
> >
> > 	[<comm>\0][<subsystem>\0][<device\0]<text>\0
> 
> I would prefer:
> 
> <text>\0[<subsystem>\0][<device>\0][<comm>\0]

We could discuss this when there is some code. IMHO, we should keep
the ordering similar to the console output. It might help when
when people see plain memory dump of the data_ring buffer.

> > My opinion:
> > ===========
> >
> > I personally think that the approach B) is the best compromise for now
> > because:
> 
> My ordered preferences for right now would be:
> 
> 1. keeping @caller_id semantics + adding @cpu + adding @comm (similar to
> your C)

I am fine with this if the crash tools are really able to handle it
out of box.

> 2. keeping @caller_id semantics + adding @cpu (similar to your A)
> 
> These additions would be purely to support netconsole and the additions
> would be under CONFIG_NETCONSOLE_DYNAMIC. No crash/dump tools should be
> changed due to this.
>
> For the long term I would like to move all strings into the
> text_data_ring. We could use that opportunity to add context bits, time
> stamps, etc. and then appropriately update the major crash/dump tools.

That would be great.

Best Regards,
Petr

