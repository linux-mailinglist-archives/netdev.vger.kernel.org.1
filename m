Return-Path: <netdev+bounces-154563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9389FEA1D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 19:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1137188201D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C907189F39;
	Mon, 30 Dec 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVYxl3OJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844042AAF;
	Mon, 30 Dec 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735584269; cv=none; b=qWIuUYLNb4jEYTxf8lR34MX4bMqpdUsSLu2z52tqxVCh9lexvXQo4iSdps5DW9SuSAApAH6fVOH/sQqxi41Y7rMtCdzxNdWnT0xmOUkjqnIKLzN8EshE5Ifl73DpFT6zM21Hi23dgauoTC9rCPR+8RkdFOsWmtQQ3lRx5tZMne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735584269; c=relaxed/simple;
	bh=hVKDeOnTGaj27THS3GMhJy4QhPsbvl6FMA27rhPZdeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMzMKvO+L081Ad03CAtQMYQLEN5v1avBumcElfIGFB/+k/Am4pVP9J0QdVwIqhbDyB0rj7tOIhrdlb6yUeg/tx9kTD4Wa7QErbkr5VxwJ+hnzF07qbDWqkhntdQG943/wSI/48dHn34/7QOLPNKC+6w3X67RSWo6aHPJDjkU1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVYxl3OJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8f916b40bso126423926d6.3;
        Mon, 30 Dec 2024 10:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735584266; x=1736189066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu+87PAPhLKyHWYj89Ks2smAvC2kAf/8czCWJnZdWGc=;
        b=eVYxl3OJGbm2rzG3hMj0rSAHxh5zze7EPf9uCdcOgOqY4SmvTkcLKWxQRBt4LbARW7
         V+ui0Vk2qMybGrYNNogZvhFc+VamEY5nOSBNw5rGah+TQIG68CiA/VVB+NU9fIWLSBs3
         9ELRuK+FJDHUid1ppCiGL0Q81iP5cFZbeqa79rg9UPlcFPOzRRcEyHcSHCcRtNYsZ+9R
         PuqgoFJqTEYNB5b7I8o6pibeDrmEinEd9wq9lmpYvPRXtHQNPcx7B4Qb4bB+9HLTXJ0P
         uvvkIHovxg5UcqxVkZVKpEYUkzMIfoX7urhmEWpOKLcK9zC20ywlaeqPwr4IzyBZhU1T
         O43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735584266; x=1736189066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu+87PAPhLKyHWYj89Ks2smAvC2kAf/8czCWJnZdWGc=;
        b=Du9gpKERAorJHYypk65ZKac08IPCoDWdcv3ONPvhJjYYsWoim62mmncexaawTe1VzP
         jMU4NRmpTtKfr8ISV96TLn03bRqkX0JbkdTNJS0tU67Zw/ZKk6xBYedA88CWubfScSht
         lu2F6/Csvn4GEv4Ery4xkujWqLDUin/VWqBX/mHprQZKFFUhRUTQIpcotI7oqjt8oHP0
         CxKI5a7+DPW8r/3AfIeR0V/ilGyLuQJDDGDyClnCaZ9KP8k8QXITSmsutOM6GZbOdHV7
         f58tqHiFOPVEkhkEPejxUviCmfhokL5q7ZkMqeSszhHlccYU+5maujsiK4rJgGWugE86
         dv4g==
X-Forwarded-Encrypted: i=1; AJvYcCWeTnDMCZDLaisP4/9vJ3nu0txxEMGa9WygQSqHnna1H7IkHo6q2z5gFNzgelGxHJoOpglZl6I=@vger.kernel.org, AJvYcCXgHjMIi+LagtgJSyJqTEJcBGFioLSnbNadz7B8Gt3x3GtjjWLpW1l0qGAi8ySeRB2mvT5Wi1RYsA8lualW2ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqjfXULYy6EAuhOC1nhVzvFxthfDMJaZum+IgP8GwNkUGFOoC
	1WyPlY4QUgrQyKmU6M6seL8nIrq75+qc23qP6tM9ADT1jM2SWHqC
X-Gm-Gg: ASbGncvLMQA7dUDY7PahsRzPppbcBeiU4lhQPjWJ6nhTIt1tqubsmiSSrk7LVpSnOfN
	vZnlzotbSazv63Uh7sWpVbOZHWjHnSYKeii8fbeSOH5DdnaYKBWuqXwaTaSqyhxH5Nv2JhnWgVm
	6hXeg+yXgAWTZteBtE6PTvUfjJXoCmCgS6u0m4sQmaTrWfVO8QPppZGOU3p8fEkKHEZoT5Y/S1w
	Ah7BLgmcvhrKeGcrJN/KcxU8An/njSIG7H4WLwSRiwS56XuNJwrVM2NSAggaeSErp3EZX9IHAAK
	I86CPxbIuxyDX++oNl5dp1LGz08lV121gS3Ej2EbpdRA7YI=
X-Google-Smtp-Source: AGHT+IGnf7AbXa9M2OSB/ScRSH1wb1b8nm77upNy9FIaW7DJJWSmfa53y+UzZH27D/Af2FyTI1aDXg==
X-Received: by 2002:a05:6214:4002:b0:6dd:cbe:a1b6 with SMTP id 6a1803df08f44-6dd233a224bmr674780796d6.47.1735584265559;
        Mon, 30 Dec 2024 10:44:25 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea757sm104726546d6.22.2024.12.30.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 10:44:25 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 717C01200075;
	Mon, 30 Dec 2024 13:44:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 30 Dec 2024 13:44:24 -0500
X-ME-Sender: <xms:COpyZzZNZNvmamnFEBoGV1a-c0S3E8jEv4FHOPzEBE91Xh2B-d8-Fg>
    <xme:COpyZyaA0dADUf7dfu_uofo0Fux5xNfY2SW7DGCoXEFSlelYDlwWIGUpC7_mbTac4
    NtM0BOmdTtwHB1w6Q>
X-ME-Received: <xmr:COpyZ18MvjAViYavWvWYtoiMvQ9jMpcy2M9SFQyFIhmPGjlzbB17KR0_zlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephffhlefgueeuheetuddtveeffedtieehieeh
    geeihfdtffdvgfeigfetheffjeehnecuffhomhgrihhnpehruhhsthdqfhhorhdqlhhinh
    hugidrtghomhdpfhhilhgvrdgrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehg
    mhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedtpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthht
    ohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhroh
    hsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:COpyZ5oKgI4_Ct3CjK7bevkcpCqvNzQZgfdgkJlczg5gY-v_OCkBQA>
    <xmx:COpyZ-qjRkSqcVaEfIMugj428JrwZQvEcgFv3pH2Qtg2lEgaL_XYyQ>
    <xmx:COpyZ_Si9hFQZ6KOCzaToX0lQT9ucpnm44kyaM7q8FsAGAxUmtJnNg>
    <xmx:COpyZ2or-H_s5t5Hn9s7eQ8Z-yxkjxQTGGTrtF501rdvkMBLcj6k6w>
    <xmx:COpyZ_6EFG6LJgqZp486_cNaziQLFnrHNVdDEpdq46GZhs7ZtGLbYZmS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 13:44:23 -0500 (EST)
Date: Mon, 30 Dec 2024 10:43:52 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH v7 6/7] rust: Add read_poll_timeout functions
Message-ID: <Z3Lp6Ce0YJa5yEYZ@boqun-archlinux>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
 <20241220061853.2782878-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220061853.2782878-7-fujita.tomonori@gmail.com>

On Fri, Dec 20, 2024 at 03:18:52PM +0900, FUJITA Tomonori wrote:
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
> 
> C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> and a simple wrapper for Rust doesn't work. So this implements the
> same functionality in Rust.
> 
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
> 
> Unlike the C version, __might_sleep() is used instead of might_sleep()
> to show proper debug info; the file name and line
> number. might_resched() could be added to match what the C version
> does but this function works without it.
> 
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
> 
> core::panic::Location::file() doesn't provide a null-terminated string
> so add __might_sleep_precision() helper function, which takes a
> pointer to a string with its length.
> 
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  include/linux/kernel.h |  2 +
>  kernel/sched/core.c    | 27 +++++++++++---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/kernel.c  | 13 +++++++
>  rust/kernel/cpu.rs     | 13 +++++++
>  rust/kernel/error.rs   |  1 +
>  rust/kernel/io.rs      |  5 +++
>  rust/kernel/io/poll.rs | 84 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  2 +
>  9 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io.rs
>  create mode 100644 rust/kernel/io/poll.rs
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
> index 3e5a6bf587f9..6ed70c801172 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8670,7 +8670,10 @@ void __init sched_init(void)
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  
> -void __might_sleep(const char *file, int line)
> +extern inline void __might_resched_precision(const char *file, int len,
> +					     int line, unsigned int offsets);

Instead of declaring this as an "extern inline" I think you can just
make it a static inline and move the function body up here. It should
resolve the sparse warning.

Regards,
Boqun

> +
> +void __might_sleep_precision(const char *file, int len, int line)
>  {
>  	unsigned int state = get_current_state();
>  	/*
> @@ -8684,7 +8687,14 @@ void __might_sleep(const char *file, int line)
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
> @@ -8709,7 +8719,7 @@ static inline bool resched_offsets_ok(unsigned int offsets)
>  	return nested == offsets;
>  }
>  
> -void __might_resched(const char *file, int line, unsigned int offsets)
> +void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
>  {
>  	/* Ratelimiting timestamp: */
>  	static unsigned long prev_jiffy;
> @@ -8732,8 +8742,8 @@ void __might_resched(const char *file, int line, unsigned int offsets)
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
> @@ -8758,6 +8768,13 @@ void __might_resched(const char *file, int line, unsigned int offsets)
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
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index d16aeda7a558..7ab71a6d4603 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>  #include "build_bug.c"
>  #include "cred.c"
>  #include "err.c"
> +#include "kernel.c"
>  #include "fs.c"
>  #include "jump_label.c"
>  #include "kunit.c"
> diff --git a/rust/helpers/kernel.c b/rust/helpers/kernel.c
> new file mode 100644
> index 000000000000..9dff28f4618e
> --- /dev/null
> +++ b/rust/helpers/kernel.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +
> +void rust_helper_cpu_relax(void)
> +{
> +	cpu_relax();
> +}
> +
> +void rust_helper___might_sleep_precision(const char *file, int len, int line)
> +{
> +	__might_sleep_precision(file, len, line);
> +}
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> new file mode 100644
> index 000000000000..eeeff4be84fa
> --- /dev/null
> +++ b/rust/kernel/cpu.rs
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Processor related primitives.
> +//!
> +//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h).
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
> +///
> +/// It also happens to serve as a compiler barrier.
> +pub fn cpu_relax() {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::cpu_relax() }
> +}
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 914e8dec1abd..b5016083a115 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -63,6 +63,7 @@ macro_rules! declare_err {
>      declare_err!(EPIPE, "Broken pipe.");
>      declare_err!(EDOM, "Math argument out of domain of func.");
>      declare_err!(ERANGE, "Math result not representable.");
> +    declare_err!(ETIMEDOUT, "Connection timed out.");
>      declare_err!(ERESTARTSYS, "Restart the system call.");
>      declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
>      declare_err!(ERESTARTNOHAND, "Restart if no handler.");
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> new file mode 100644
> index 000000000000..033f3c4e4adf
> --- /dev/null
> +++ b/rust/kernel/io.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Input and Output.
> +
> +pub mod poll;
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..da8e975d8e50
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IO polling.
> +//!
> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
> +
> +use crate::{
> +    cpu::cpu_relax,
> +    error::{code::*, Result},
> +    time::{delay::fsleep, Delta, Instant},
> +};
> +
> +use core::panic::Location;
> +
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// Public but hidden since it should only be used from public macros.
> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
> +/// let g = lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Delta::from_micros(42));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> +    mut op: Op,
> +    cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: Fn(T) -> bool,
> +{
> +    let start = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
> +    let timeout = !timeout_delta.is_zero();
> +
> +    might_sleep(Location::caller());
> +
> +    let val = loop {
> +        let val = op()?;
> +        if cond(val) {
> +            // Unlike the C version, we immediately return.
> +            // We know a condition is met so we don't need to check again.
> +            return Ok(val);
> +        }
> +        if timeout && start.elapsed() > timeout_delta {
> +            // Should we return Err(ETIMEDOUT) here instead of call op() again
> +            // without a sleep between? But we follow the C version. op() could
> +            // take some time so might be worth checking again.
> +            break op()?;
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
> +        cpu_relax();
> +    };
> +
> +    if cond(val) {
> +        Ok(val)
> +    } else {
> +        Err(ETIMEDOUT)
> +    }
> +}
> +
> +fn might_sleep(loc: &Location<'_>) {
> +    // SAFETY: FFI call.
> +    unsafe {
> +        crate::bindings::__might_sleep_precision(
> +            loc.file().as_ptr().cast(),
> +            loc.file().len() as i32,
> +            loc.line() as i32,
> +        )
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e1065a7551a3..2e9722f980bd 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -33,6 +33,7 @@
>  #[cfg(CONFIG_BLOCK)]
>  pub mod block;
>  mod build_assert;
> +pub mod cpu;
>  pub mod cred;
>  pub mod device;
>  pub mod error;
> @@ -40,6 +41,7 @@
>  pub mod firmware;
>  pub mod fs;
>  pub mod init;
> +pub mod io;
>  pub mod ioctl;
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
> -- 
> 2.43.0
> 
> 

