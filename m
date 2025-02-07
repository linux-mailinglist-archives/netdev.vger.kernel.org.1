Return-Path: <netdev+bounces-164128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D06A2CAED
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BEC16AC42
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4219CD1E;
	Fri,  7 Feb 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7faWZZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63E199EB7;
	Fri,  7 Feb 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951983; cv=none; b=PtbixnsKY2abOTr3EobXZaDnR3AftFcbzILOloFoqPzYV+tpa6z7+ckPWYMkph60qY7wERtGiQZUweHd5mUX2qG33UUXGertEMm84juNLa52bvmhdvJfWL33Xbh/rEkEjAM8fJkEhgM6RDX2luVNc3SYpNHDzJeyKbWw7mjVYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951983; c=relaxed/simple;
	bh=/uqcjveFI+Ohn3TTizoKIDoUauFjbJO6klBGzCaZkzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw9FvER4uyiSeWSbl07kSowCKKgEDb9sKrW7BzpKhT/CC9g3J5qCTy9iNfFcRB+AcAlBSJierJiGIrfmyj+SegeJMN7qO0zhjRsip7Pk/RgKRhuo2CUrBXDX4ew4vbz6vZ0YuV25da7irCaFMgJLeu/JfLlePnAaHHPDgunhqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7faWZZZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dcab4b0e1so783732f8f.0;
        Fri, 07 Feb 2025 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738951980; x=1739556780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpcNUJESxQP4cEYWzq72lineCe5thDI/PST7eW8txNg=;
        b=X7faWZZZm2IaPz78WkIix91hqgQkW6iJy9pIgLxZvHqqQK7rtD7EdwgJB5MqtX9cfq
         SN86ZI5g846Q1sGGBn+iHNUVPepb9ddQF2Ri2ibzpbmZhOXpmnWgVvTV8lDGOG9qaN+5
         E4ZdwoqBLEPpJFECo/rqqjR09KmnGZyUBbBiLpl/iLC4lm3R+Yh1CeuEQdH3iJotnQDO
         X7bFPHgYiKsh0cSqCZxxZFZm8iDl0Qgdq1wSIMEMa9+5MApoF7pFrwdBSzhaD/3svMFo
         Ls7qWMbcX1RXq0bHuSwrGZnphVja1dznR53nsYA4Ei3ou+hcZcs0gmxUtTrPZBzHTeUg
         LqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951980; x=1739556780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpcNUJESxQP4cEYWzq72lineCe5thDI/PST7eW8txNg=;
        b=P4+bSvewSCiSTEB5LLb0BS/HUq3FxNTYY/Yd0e5ghBGzzrUqF+ZE/UE2tRiAS0fr5z
         xUin7qnWml0HytM38JkO/NT02LBPUFxx4UGC69id6ErPunGZ7wrJrZB0s36ixbixdfqr
         BcyaZ+zXMn+Tbttup6h/wOcmuFHNsmVQWt9LMcp0cH4ernadEVrBOYqobn6++BmRuvtQ
         Cf6r1ayt4gK41mRbjdUIfxjD3+Ajvmki77BCWSzBEWex5InO1ARaJGllw0DsbCrynw54
         xRT76DdKbXbp1Vas4X9i9UeaktLzHYuMdJ5mBuQXmjTq6guj1rpLIu4GQFezIhxhcz5w
         sjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFJmedhz+RiEdcAGxuB59a0lHvMzVnrDN9/dmqfu7aFNZsVtrzh/Hsh3RtiljLnTJxhvRE0/eyej3LNpbYXek=@vger.kernel.org, AJvYcCWvtwno071mYmCPP58jIGR3QDb2O6ymGGqSZNBnLAHnb+VrsQFZa2LLNic4RMteCfZdNnNkbBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONO4VyVXM54kLcnxlLrAWoViMT4c3etyw5pvztRMQyI8K5MxC
	caFBvzqe6CZsack9TBKeJnOO3rayhilAegwWiW1ev7ejimk6H6GP
X-Gm-Gg: ASbGncuHsKF07pRgZaEmAThy7zuBlDFff5w4W2fPaiiGwuRjIzGLeC1xoyGEDwYqbDv
	Va3c07nfE10MK/a1/mDHELpIK/MdHcYNGIHBhdkAPy9P6M4uN57D8GXVMUn2okLFDCNYRdRQEOt
	kL3+m+ejSCFJeQzq/HQbO4kVYKU9cyrSI0WBQr8rEbi0Sb01+LMmPkkVTDqD7CpY4yx77dusGBf
	Ag5z/u+Ue/yFCW1GVickNgwJ4slcYYL0l0QOlDJjrIF6DxK85ND2nAK6k+qePuB5jGCKbitrtpL
	M8MOcFLdOCf6T3re3b3t/OFZvNiJSXmBYY21G/43AtAB6rt1LS+mdg==
X-Google-Smtp-Source: AGHT+IH9f/rM0alPOoLvlOp5+ELsH+loKBcYfbYyhZiiWirjT52V0qbJhI8A+/XxbqFtm/iX1rywig==
X-Received: by 2002:a05:6000:2a2:b0:38d:b281:1b24 with SMTP id ffacd0b85a97d-38dc910a550mr3270100f8f.32.1738951979624;
        Fri, 07 Feb 2025 10:12:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc4458d71sm4054254f8f.63.2025.02.07.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:12:59 -0800 (PST)
Date: Fri, 7 Feb 2025 18:12:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, Boqun
 Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 1/8] sched/core: Add __might_sleep_precision()
Message-ID: <20250207181258.233674df@pumpkin>
In-Reply-To: <20250207132623.168854-2-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-2-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 22:26:16 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add __might_sleep_precision(), Rust friendly version of
> __might_sleep(), which takes a pointer to a string with the length
> instead of a null-terminated string.
> 
> Rust's core::panic::Location::file(), which gives the file name of a
> caller, doesn't provide a null-terminated
> string. __might_sleep_precision() uses a precision specifier in the
> printk format, which specifies the length of a string; a string
> doesn't need to be a null-terminated.
> 
> Modify __might_sleep() to call __might_sleep_precision() but the
> impact should be negligible. strlen() isn't called in a normal case;
> it's called only when printing the error (sleeping function called
> from invalid context).
> 
> Note that Location::file() providing a null-terminated string for
> better C interoperability is under discussion [1].
> 
> Link: https://github.com/rust-lang/libs-team/issues/466 [1]
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  include/linux/kernel.h |  2 ++
>  kernel/sched/core.c    | 55 ++++++++++++++++++++++++++----------------
>  2 files changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index be2e8c0a187e..086ee1dc447e 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -87,6 +87,7 @@ extern int dynamic_might_resched(void);
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  extern void __might_resched(const char *file, int line, unsigned int offsets);
>  extern void __might_sleep(const char *file, int line);
> +extern void __might_sleep_precision(const char *file, int len, int line);
>  extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  extern void __cant_migrate(const char *file, int line);
>  
> @@ -145,6 +146,7 @@ extern void __cant_migrate(const char *file, int line);
>    static inline void __might_resched(const char *file, int line,
>  				     unsigned int offsets) { }
>  static inline void __might_sleep(const char *file, int line) { }
> +static inline void __might_sleep_precision(const char *file, int len, int line) { }
>  # define might_sleep() do { might_resched(); } while (0)
>  # define cant_sleep() do { } while (0)
>  # define cant_migrate()		do { } while (0)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 165c90ba64ea..d308f2a8692e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8678,24 +8678,6 @@ void __init sched_init(void)
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  
> -void __might_sleep(const char *file, int line)
> -{
> -	unsigned int state = get_current_state();
> -	/*
> -	 * Blocking primitives will set (and therefore destroy) current->state,
> -	 * since we will exit with TASK_RUNNING make sure we enter with it,
> -	 * otherwise we will destroy state.
> -	 */
> -	WARN_ONCE(state != TASK_RUNNING && current->task_state_change,
> -			"do not call blocking ops when !TASK_RUNNING; "
> -			"state=%x set at [<%p>] %pS\n", state,
> -			(void *)current->task_state_change,
> -			(void *)current->task_state_change);
> -
> -	__might_resched(file, line, 0);
> -}
> -EXPORT_SYMBOL(__might_sleep);
> -
>  static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
>  {
>  	if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
> @@ -8717,7 +8699,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
>  	return nested == offsets;
>  }
>  
> -void __might_resched(const char *file, int line, unsigned int offsets)
> +static void __might_resched_precision(const char *file, int len, int line,

For clarity that ought to be file_len.

> +				      unsigned int offsets)
>  {
>  	/* Ratelimiting timestamp: */
>  	static unsigned long prev_jiffy;
> @@ -8740,8 +8723,10 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>  	/* Save this before calling printk(), since that will clobber it: */
>  	preempt_disable_ip = get_preempt_disable_ip(current);
>  
> -	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
> -	       file, line);
> +	if (len < 0)
> +		len = strlen(file);

No need for strlen(), just use a big number instead of -1.
Anything bigger than a sane upper limit on the filename length will do.

	David

> +	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
> +	       len, file, line);
>  	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
>  	       in_atomic(), irqs_disabled(), current->non_block_count,
>  	       current->pid, current->comm);
> @@ -8766,8 +8751,36 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>  	dump_stack();
>  	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>  }
> +
> +void __might_resched(const char *file, int line, unsigned int offsets)
> +{
> +	__might_resched_precision(file, -1, line, offsets);
> +}
>  EXPORT_SYMBOL(__might_resched);
>  
> +void __might_sleep_precision(const char *file, int len, int line)
> +{
> +	unsigned int state = get_current_state();
> +	/*
> +	 * Blocking primitives will set (and therefore destroy) current->state,
> +	 * since we will exit with TASK_RUNNING make sure we enter with it,
> +	 * otherwise we will destroy state.
> +	 */
> +	WARN_ONCE(state != TASK_RUNNING && current->task_state_change,
> +			"do not call blocking ops when !TASK_RUNNING; "
> +			"state=%x set at [<%p>] %pS\n", state,
> +			(void *)current->task_state_change,
> +			(void *)current->task_state_change);
> +
> +	__might_resched_precision(file, len, line, 0);
> +}
> +
> +void __might_sleep(const char *file, int line)
> +{
> +	__might_sleep_precision(file, -1, line);
> +}
> +EXPORT_SYMBOL(__might_sleep);
> +
>  void __cant_sleep(const char *file, int line, int preempt_offset)
>  {
>  	static unsigned long prev_jiffy;


