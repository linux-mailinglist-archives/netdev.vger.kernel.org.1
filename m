Return-Path: <netdev+bounces-143510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C19C2B6E
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 10:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF98281D7D
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF133143725;
	Sat,  9 Nov 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBEujbZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED9288D1;
	Sat,  9 Nov 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145104; cv=none; b=uZPVMrbbEXDD/GaM7mgBaLw2tyBmHq9HO7uzFVeFa8uVOCMDp0YT3FAPc/8a0GM9I0hRbJ95v+II/bbtVcYhUNHsVxaztuYeruHNRoLBZlxEWXPIsSXkuwxkCnHCZIUPYrF42ZACdHR4GEQxI86VpxHlpkKrL2DvG1RKXId94is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145104; c=relaxed/simple;
	bh=NzLYZgHOP2wvSoqFT7gXCPc7qie0SoqvKtxmE5X/Gh0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UowJ+OrRro3YqnD5ydmQylS2qIFt0t/Meg/ljkOcFngp3zj/NQVVP0wMFHWQe86YqgEVxzyAJPQKL6a4m2a6tIRj+Q/WqJdrz1lU3lIMCv5ysFF+Rd1lrougmyxeThJNoz2g26uO68eQc3tSIqnZFYMH2dj0D17c6aRWylvgnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBEujbZr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c805a0753so30731615ad.0;
        Sat, 09 Nov 2024 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731145103; x=1731749903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZB1H1cH3EcvDDGyOT3paa5uE/WHAGoFKm0TvWQ2nMs=;
        b=LBEujbZrpRbS4sKLaEU4GkWhKmiFujf7DOMAOHLlfyedEGzrA4d1VWcLhk2y2fqcVI
         pONtQQ7NPdYhabaSEKNgaqhkFzcokMQHuZf3m8DgGQnnLZiLV++isFPBvinTkvJXuQe3
         w/saVefmYLgzfRvZuadbUtF5an8vBx1dLhO/pGbscgqWaX7W/EMllPEBees4YGhpv+aW
         9fQU+ydbU0/hPTmE+6gvyQm0g+UeeN68v+WASSCC+EQQ1/ADZIxtmBOyKitdUeMEZ+T3
         hF5WVVGx7CxJqX4HePUsnrsexvNigSxlcL/KfNniNTpMZyEs5T/Us7OGqV/3STMtEPbt
         eU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731145103; x=1731749903;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZB1H1cH3EcvDDGyOT3paa5uE/WHAGoFKm0TvWQ2nMs=;
        b=jWUNUR0V7KrVacVeKbfPx58WfBnaXNoxsI88NKVv6h9wXiJni9JG4G6H38lIMy6Id7
         xG6KQ7kLMw5aKyDB6QPgR1c3mECG12mmj3+NetcoTZMxQJoqeAJ88fEceU0JbG42O4Kg
         2TFv8oAfGBMWfMKCyYcMm/uXA4w4LNt7uRpX222bHHoAMoRtFQstg/8Z8E+iAJf5R6OS
         q2LGz3QkzwyPBffKej2sedPOpwDJJkglpiVsjHAOWrQU0abYrGqy7+EREHitU/I7Fijp
         WiZiECatLXHqknyYn0yJnmsSvEjgGAFUhoW7bzQrAHKSOZxthbcv9VjSW3fXvy34L6Sf
         1Xjg==
X-Forwarded-Encrypted: i=1; AJvYcCWkRB8QELWJjecxbtwV2Crufh//bkQY0SnNGYdajx3dkkrgmuCNLCzB4qHNNzc9zBWNG7UsTg1X@vger.kernel.org, AJvYcCX3/kxWThQyOPWVlx+4qIhKnTgdzP7OCf0nedLHmtHbBbEuIVzhLfqbqeJuXvVg7W699fbjROuOm00Q5WQ=@vger.kernel.org, AJvYcCXTfVg+yOoRM9+x0Vnu9p4OXx+7Xw2HJ/mthlGWLet0ti1FalGd9el6nLa2E922oZhdzAYsklQXBPlpdHheH+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoh3dTEgjP9SWQVFZsRifA6q4ks8F5HhsgsX/L8TyuCKkYCntE
	DyDeryXIHFOGkEj1HnIo1qxa60OicfyyvljPisP9dodHy9nVF0WI
X-Google-Smtp-Source: AGHT+IGyu0wK/UVWfHZUgP6+I416M2F1Dfaw3qijtJse7yfF4DWnr1CdFwG155TvFYjg79oO0OUVvQ==
X-Received: by 2002:a17:902:c411:b0:20c:9d79:cf85 with SMTP id d9443c01a7336-21183e5ee46mr66346325ad.54.1731145102562;
        Sat, 09 Nov 2024 01:38:22 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f642bedsm4822452a12.67.2024.11.09.01.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 01:38:22 -0800 (PST)
Date: Sat, 09 Nov 2024 18:38:04 +0900 (JST)
Message-Id: <20241109.183804.1515599584405139212.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
 pmladek@suse.com, rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk, senozhatsky@chromium.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZyvhDbNAhPTqIoVi@boqun-archlinux>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
	<20241101010121.69221-7-fujita.tomonori@gmail.com>
	<ZyvhDbNAhPTqIoVi@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 13:35:09 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Fri, Nov 01, 2024 at 10:01:20AM +0900, FUJITA Tomonori wrote:
>> Add read_poll_timeout functions which poll periodically until a
>> condition is met or a timeout is reached.
>> 
>> C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
>> and a simple wrapper for Rust doesn't work. So this implements the
>> same functionality in Rust.
>> 
>> The C version uses usleep_range() while the Rust version uses
>> fsleep(), which uses the best sleep method so it works with spans that
>> usleep_range() doesn't work nicely with.
>> 
>> Unlike the C version, __might_sleep() is used instead of might_sleep()
>> to show proper debug info; the file name and line
>> number. might_resched() could be added to match what the C version
>> does but this function works without it.
>> 
>> The sleep_before_read argument isn't supported since there is no user
>> for now. It's rarely used in the C version.
>> 
>> For the proper debug info, readx_poll_timeout() and __might_sleep()
>> are implemented as a macro. We could implement them as a normal
>> function if there is a clean way to get a null-terminated string
>> without allocation from core::panic::Location::file().
>> 
> 
> So printk() actually support printing a string with a precison value,
> that is: a format string "%.*s" would take two inputs, one for the length
> and the other for the pointer to the string, for example you can do:
> 
> 	char *msg = "hello";
> 
> 	printk("%.*s\n", 5, msg);
> 
> This is similar to printf() in glibc [1].
> 
> If we add another __might_sleep_precision() which accepts a file name
> length:
> 
> 	void __might_sleep_precision(const char *file, int len, int line)
> 
> then we don't need to use macro here, I've attached a diff based
> on your whole patchset, and it seems working.

Ah, I didn't know this.

> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index be2e8c0a187e..b405b0d19bac 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -87,6 +87,8 @@ extern int dynamic_might_resched(void);
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  extern void __might_resched(const char *file, int line, unsigned int offsets);
>  extern void __might_sleep(const char *file, int line);
> +extern void __might_resched_precision(const char *file, int len, int line, unsigned int offsets);
> +extern void __might_sleep_precision(const char *file, int len, int line);
>  extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  extern void __cant_migrate(const char *file, int line);
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..f872aa18eaf0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8543,7 +8543,7 @@ void __init sched_init(void)
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  
> -void __might_sleep(const char *file, int line)
> +void __might_sleep_precision(const char *file, int len, int line)
>  {
>  	unsigned int state = get_current_state();
>  	/*
> @@ -8557,7 +8557,14 @@ void __might_sleep(const char *file, int line)
>  			(void *)current->task_state_change,
>  			(void *)current->task_state_change);
>  
> -	__might_resched(file, line, 0);
> +	__might_resched_precision(file, len, line, 0);
> +}
> +
> +void __might_sleep(const char *file, int line)
> +{
> +	long len = strlen(file);
> +
> +	__might_sleep_precision(file, len, line);
>  }
>  EXPORT_SYMBOL(__might_sleep);
>  
> @@ -8582,7 +8589,7 @@ static inline bool resched_offsets_ok(unsigned int offsets)
>  	return nested == offsets;
>  }
>  
> -void __might_resched(const char *file, int line, unsigned int offsets)
> +void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
>  {
>  	/* Ratelimiting timestamp: */
>  	static unsigned long prev_jiffy;
> @@ -8605,8 +8612,8 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>  	/* Save this before calling printk(), since that will clobber it: */
>  	preempt_disable_ip = get_preempt_disable_ip(current);
>  
> -	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
> -	       file, line);
> +	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
> +	       len, file, line);
>  	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
>  	       in_atomic(), irqs_disabled(), current->non_block_count,
>  	       current->pid, current->comm);
> @@ -8631,6 +8638,13 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>  	dump_stack();
>  	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>  }
> +
> +void __might_resched(const char *file, int line, unsigned int offsets)
> +{
> +	long len = strlen(file);
> +
> +	__might_resched_precision(file, len, line, offsets);
> +}
>  EXPORT_SYMBOL(__might_resched);
>  
>  void __cant_sleep(const char *file, int line, int preempt_offset)

Cc scheduler people to ask if they would accept the above change for
Rust or prefer that Rust itself handles the null-terminated string
issue.

