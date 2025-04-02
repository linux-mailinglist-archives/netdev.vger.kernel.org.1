Return-Path: <netdev+bounces-178913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E17A7987F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942DB18950EB
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DDB1F4C8F;
	Wed,  2 Apr 2025 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiptNRSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B8FBA42;
	Wed,  2 Apr 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743635035; cv=none; b=GQe9YWJz5FDLwr5vb/Pkl6vHi27GmMQ2wyPCyWx52JpAEPjXyleOB90+WECn0mxecjHc8eXtykxI/WCSOHvKOltg+ApPpS+oWK9n9mHVf7B+pbcK/uScLKDxZcy1U+QXNUxooz7e5CcE2RxjsQSvUVdtyMCZuNButkMin12Qebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743635035; c=relaxed/simple;
	bh=e/05RUv8AFU4dIy1XvhGvLAyFV/EJL8Ki9qGalUyCzM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=de8155amd0Pg/AeCJQftt5L5CNpT0CWA3I8n2ifxXg1fuIsjS0k0EOGasBSH6C+3eSo8Nu59j3asagMTBv+6em0R22zBnYSlPr/f3a/3GsHioR1kPLJn63TsncfbFx08PduhAonTLS1p/YTeMas92oTUYDT/H/2k3Atzl/Wr9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiptNRSY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so312425b3a.2;
        Wed, 02 Apr 2025 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743635033; x=1744239833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjqEkgGdsJS2o6GYEk8m8GjTaU9yqigmQiAw5VcYXfo=;
        b=MiptNRSYZ9Oz554Z4NjEph93KuM3NK/tukGznzl4gCUtB5YmBByG/YzNT2EAWHO0/S
         hDP1HjNCSyxTq4A3Hmrq+JzfOMJTGurLIS22Ht1guNDbztll7SKh3XDUpcPmZHDk9KHi
         cXDxtPtWRR1Z6hHLAi6U4KOn6mJg/qjxT1LdOB65FqWsc6RGx6h/CSm2rkEhZbJWr3tK
         vxbLgW6awt/HVx/hyMmtX4ZyiDVrQ/G37/bn1iBfoNq1iqgWjcbIWBkLmQpn9muVPO8W
         XMgmkp+gpcGpum4dkYEfs57M87IyOGdBbMONaBBFZEiG86x916Yey34LxCZppbSdGH1+
         kd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743635033; x=1744239833;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FjqEkgGdsJS2o6GYEk8m8GjTaU9yqigmQiAw5VcYXfo=;
        b=Xk8Sd8uI4BCYCk+SGjUTuVmK3bgScYkK49fMZmnQEGFS+tdJ2tSIpeQtA0Q/8vaeua
         t/cMXxBNILzpqbVaR/v80hIzjpI16MJhNGZNzS2T6jkXuWbu79CnW7rmtU3XHa3BUYHr
         WLbpQ6JJ9XopoveVvJiQqtXUK7JA9DY+PxNqw0TdK0yEqAgrx48jHfQo0OCJ6ifI6Nd8
         bWFNpPmjgUWtSCQHxfhi/aaEExOjOgXiuAyEL906YrPGOw10USGu1EmIKDbQqkoVxIG/
         SnZ7XBEkytjUfATK0/62dANLduRLPwegEYDKHdDl5AbtgVdApfQrVHNxz4ZvgzJM01/S
         6g3w==
X-Forwarded-Encrypted: i=1; AJvYcCVMRL6Z+ItFwsR2Oe8lN6CHe5o8iM7IggD9KRKX7ZCTfuQMH3ImqQae0uyxQvXTV3RbQ+ojK4XXzsT6phw=@vger.kernel.org, AJvYcCWH/6ZhJisTZt5zE6j+BUTuPhsWiP2EiFXWiVbtzUQS3/G/t3BSGpRh2zERMyAg3RJkgHRj6++E@vger.kernel.org, AJvYcCWOjqMzHwAnw5DBFIN1pyrD5HswFP6ZdWA78TYHcmzsRShLRx5XFjWzJxFWR54brgTmEOscfQx/umlpm/EOSWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNt2rY8p6HtEvuJmXFYeFzjs2afubKcxWrj5+boj5aLasizHVy
	8/8TO7npv/WPAU88F2NoXU6AohzfJG0+CLfY4oYWpHGRTsmwQldBBxiMhUBu
X-Gm-Gg: ASbGncu1VYGOWGUu1E5454M0Nd48Wd4os+nBtfXNKCsLKm96jy2rQOqdjXWiGkKxuBJ
	9uvV6Z4w20opgBx1vaRNx+XclCdpuT2P+0BpcHTIpyKdhttvRjqq68TLnqYrgSy+d8ytkU5TqT2
	sLQOpZw81r1popHOMbTti7y5zgfa6cVjD0T7802k8SsJY/gbIgimk+4qqE05CDjJ8AuCbvgLYgC
	udoe/qiaOciG25JGWtD9KEtMG76SrdRRvZg4CjK20DwbtLkKuN0u6txmnwUgKNC1zegvrwqLXl1
	Tz+IfpjJVckQ03iWw+jxPDyivGLoeM/Jxb7THkUYjKBPuSonyfKubAOb/tIe6K/JUGDdph3ycL2
	OPHYU5euKbfKpnpP0JE/d1b7Mqxk=
X-Google-Smtp-Source: AGHT+IHSc2S/uyQv9O6KgtwrCS7DVP9GlM5QpujLsHZ45HEvH7TRy9mH1ugW5RtLrE1HYBM9UiS+/w==
X-Received: by 2002:a05:6a00:1397:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-73980387936mr27344481b3a.6.1743635032445;
        Wed, 02 Apr 2025 16:03:52 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea097asm62228b3a.90.2025.04.02.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:03:52 -0700 (PDT)
Date: Thu, 03 Apr 2025 08:03:34 +0900 (JST)
Message-Id: <20250403.080334.1462587538453396496.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z-1l3mgsOi4y4N_c@boqun-archlinux>
References: <Z-qgo5gl6Qly-Wur@Mac.home>
	<20250402.231627.270393242231849699.fujita.tomonori@gmail.com>
	<Z-1l3mgsOi4y4N_c@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 09:29:18 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Wed, Apr 02, 2025 at 11:16:27PM +0900, FUJITA Tomonori wrote:
>> On Mon, 31 Mar 2025 07:03:15 -0700
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> >> My recommendation would be to take all of `rust/kernel/time` under one
>> >> entry for now. I suggest the following, folding in the hrtimer entry as
>> >> well:
>> >> 
>> >> DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>> >> M:	Andreas Hindborg <a.hindborg@kernel.org>
>> > 
>> > Given you're the one who would handle the patches, I think this make
>> > more sense.
>> > 
>> >> R:	Boqun Feng <boqun.feng@gmail.com>
>> >> R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>> > 
>> > Tomo, does this look good to you?
>> 
>> Fine by me.
>> 
>> So a single entry for all the Rust time stuff, which isn't aligned
>> with C's MAINTAINERS entries. It's just for now?
>> 
> 
> Given Andreas is the one who's going to handle the PRs, and he will put
> all the things in one branch. I think it's fine even for long term, and
> we got all relevant reviewers covered. If the Rust timekeeping + hrtimer
> community expands in the future, we can also add more entries. We don't
> necessarily need to copy all maintainer structures from C ;-)

It seems I was mistaken. I had thought that the ideal goal was for the
same team to maintain both the C code and the corresponding Rust code.


>> >> I assume patch 1 will go through the sched/core tree, and then Miguel
>> >> can pick 7.
>> >> 
>> > 
>> > Patch 1 & 7 probably should go together, but we can decide it later.
>> 
>> Since nothing has moved forward for quite a while, maybe it's time to
>> drop patch 1.
> 
> No, I think we should keep it. Because otherwise we will use a macro

Yeah, I know. the first version of this uses a macro.


> version of read_poll_timeout(), which is strictly worse. I'm happy to
> collect patch #1 and the cpu_relax() patch of patch #7, and send an PR
> to tip. Could you split them a bit:
> 
> * Move the Rust might_sleep() in patch #7 to patch #1 and put it at
>   kernel::task, also if we EXPORT_SYMBOL(__might_sleep_precision), we
>   don't need the rust_helper for it.
> 
> * Have a separate containing the cpu_relax() bit.
> 
> * Also you may want to put #[inline] at cpu_relax() and might_resched().
> 
> and we can start from there. Sounds good?

I can do whatever but I don't think these matters. The problem is that
we haven't received a response from the scheduler maintainers for a
long time. We don't even know if the implementation is actually an
issue.




