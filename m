Return-Path: <netdev+bounces-173161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A13A5791F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 09:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B71D170FFA
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49D192D68;
	Sat,  8 Mar 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpuDRgQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE414A627;
	Sat,  8 Mar 2025 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741421419; cv=none; b=IkKm7uVLPwj9T4pb/12VoRdoih69xSbCvbf+vvX41D5/9nRwrT/YAFpVj7AmTIccCL3PnxwqH0Tgfoc8MQ+IoUhWz9QePHp3nEXRUC2Pq5Vv1YD6i7MGFLLFTy2gl2jRQFv+BQfUim2pAb/XPrkguadolPmbflsOJas+/RfN0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741421419; c=relaxed/simple;
	bh=chpw5mOCqhdaulsI9rU+yap84EtolFeEXcuYZq1Qdiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbNQhToOiDmWo9CCcmioONIp1kEymF5F3jeqj9j1JNg3HVVgSPiOcUrRILMiwfscEBYtanXkYT3dg/ZL2BSA2+Vc9IXAcC4c55E7LYYJebMpqO7U9UYNYUVFi+fBrMdFX7W11DiQPpB144J2+POqaN00F+mRcIH3X0qsU8OOW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpuDRgQB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22401f4d35aso49958385ad.2;
        Sat, 08 Mar 2025 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741421416; x=1742026216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPfMHrUfIyTeVauZfw7Vd2QUp41Iswo+4/Xq/oJCsFY=;
        b=HpuDRgQB1EAg6f+2qpjd7BG9wQ16qPzxzcK6pXUgoZqIANm8rOzLbZ80PQhBtbpl91
         15hjORoXcTpvLj/KKYpf5HSo5eIL7jYWphVQoPPYRDfnVTbS9q9D+OtUrOouvlP8ZKFo
         u4AO5pFGryjyIlR0gsXUwV7DuuZZesoJerkRa/4gKRWa0DpE1dNm46MF8VnMjyNhHk5z
         maSQMJr/XAQeQ91GSK2PpYtHM1G3hvdL8IublYR4XMZRrisDYEso+/gqTKO2ydvZVWT1
         0xadBhsuvYJ4PcCLHZ7IhxQP0pQQkDn6UPD7WH7jCtpk6Gz3rkD/h9ojJuZvg8266Ups
         da1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741421416; x=1742026216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPfMHrUfIyTeVauZfw7Vd2QUp41Iswo+4/Xq/oJCsFY=;
        b=dzRJyG3Xx35J/iIqhApPBgkIiTjZ6RV8y0dJP1986yzHf3UdJGvaJ1mNZeffD1uyoL
         MhQqO3Q94IiDCV9wcAVBYL0AE0NH8a20J+SrNySGYlQ22JQZJKHf/CeN1skvmUVlm1Dh
         vzV9iZdFUSOMpOU/ezgDWIe/hnL0Nb19JJJOBc33WsGKMs1j766Ou8whrJ/iXoKNHW6u
         UrUTH12lg8+FHR8i4N24ZBx09J+oB3j/lp+nsCxRzsOqlYv1mK7tuBisuz9ShTvYI2+8
         DOPyYd1XKCmW7SMLXqPUxHI4b4yEh0/Mws+QgBr1zaTLRPFmNgXpuiFfG9AXfFIPkgKb
         0FsA==
X-Forwarded-Encrypted: i=1; AJvYcCUu6DBPAHw/RvsjgS+ePERCbgf7y6iaOQqf1dF9IwHKGcKfZgzyZ3pvTkMAQ0+cpi3S4MBaAepwcKcgLas=@vger.kernel.org, AJvYcCWe3WCjHtiEjcrUj1f1C3Jh++NZYdcR0sPqMCIeZwOkS6Z+ThIKbFxQWEvpz2LC0/oFbGj+g1sM@vger.kernel.org
X-Gm-Message-State: AOJu0YweJvj3e7Vet1+pO7Mw3xLh6wVFbb7Qoc+aiPz295Kyo6Uzo/Rj
	Pkdn5UraPTYwV6QStGpMRsy1Nw6uBAM8yfsgH9sFrbGWX4HESVh7
X-Gm-Gg: ASbGncsdNk6fcqTgpJqpba7w+8VBz3ePmYVffBARyqTnNwkiCCIv9I79EKpihBgF1Ie
	gqtXDujWKQc+y5LQDBNrfPC6np8y7CTZOsfSi/wAwVMF5dj3VIO9bObnpoqeM9hPbt67kqZXllc
	6ISxRl9PzOT95a+uLX0JITqr5Z+jvPvrqRn0cTWVPw6BGbzNyU4PDgCOw1a6pjWEO/3t+2Stgmb
	RZ/0aCpLZ08YuHK07PA2jOcmRBmj6qfnn0DT2XF8DXIj0ct6XSfQbFSdlHEWH9RUoE/vNrB1/3J
	jy2p9LAlzMH3tI2+513PZ96StodG6ZD05jf3+B3LQ4VwUPFeWBuHeSL86tIVE3AL1QXS4rtgTN7
	32xkRA9xm6tdmr0upHDDOw0v3c/208cU=
X-Google-Smtp-Source: AGHT+IExQxxzidZsRZvPCkyyUusE5M+qCGYL1MbJaKyQy9hpVDIjFSPVSubIvS0tuRZ2CTYvwEaU5g==
X-Received: by 2002:a17:903:19ce:b0:223:58ff:c722 with SMTP id d9443c01a7336-22428a96b0emr125049715ad.28.1741421416199;
        Sat, 08 Mar 2025 00:10:16 -0800 (PST)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a9dfbfsm42108365ad.209.2025.03.08.00.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 00:10:15 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: boqun.feng@gmail.com
Cc: bp@alien8.de,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peterz@infradead.org,
	ryotkkr98@gmail.com,
	x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Date: Sat,  8 Mar 2025 17:09:51 +0900
Message-Id: <20250308080951.345854-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8t8imzJVhWyDvhC@boqun-archlinux>
References: <Z8t8imzJVhWyDvhC@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Boqun,

Thanks for looking into it.

On Fri, 7 Mar 2025 15:08:58 -0800, Boqun Feng wrote:
>On Fri, Mar 07, 2025 at 11:29:04AM -0800, Boqun Feng wrote:
>> On Fri, Mar 07, 2025 at 10:33:36AM -0800, Boqun Feng wrote:
>> > On Fri, Mar 07, 2025 at 07:57:40AM -0800, Boqun Feng wrote:
>> > > On Fri, Mar 07, 2025 at 10:39:46PM +0900, Ryo Takakura wrote:
>> > > > Hi Boris,
>> > > > 
>> > > > On Fri, 7 Mar 2025 14:13:19 +0100, Borislav Petkov wrote:
>> > > > >On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
>> > > > >> I'm so sorry that the commit caused this problem...
>> > > > >> Please let me know if there is anything that I should do.
>> > > > >
>> > > > >It is gone from the tip tree so you can take your time and try to do it right.
>> > > > >
>> > > > >Peter and/or I could help you reproduce the issue and try to figure out what
>> > > > >needs to change there.
>> > > > >
>> > > > >HTH.
>> > > > 
>> > > > Thank you so much for this. I really appreciate it.
>> > > > I'll once again take a look and try to fix the problem.
>> > > > 
>> > > 
>> > > Looks like we missed cases where
>> > > 
>> > > acquire the lock:
>> > > 
>> > > 	netif_addr_lock_bh():
>> > > 	  local_bh_disable();
>> > > 	  spin_lock_nested();
>> > > 
>> > > release the lock:
>> > > 
>> > > 	netif_addr_unlock_bh():
>> > > 	  spin_unlock_bh(); // <- calling __local_bh_disable_ip() directly

I see! I wasn't aware of !PREEMPT_RT differing from PREEMPT_RT 
where spin_unlock_bh() calls __local_bh_disable_ip() instead of
local_bh_disable().

>> > > means we should do the following on top of your changes.
>> > > 
>> > > Regards,
>> > > Boqun
>> > > 
>> > > ------------------->8
>> > > diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>> > > index 0640a147becd..7553309cbed4 100644
>> > > --- a/include/linux/bottom_half.h
>> > > +++ b/include/linux/bottom_half.h
>> > > @@ -22,7 +22,6 @@ extern struct lockdep_map bh_lock_map;
>> > >  
>> > >  static inline void local_bh_disable(void)
>> > >  {
>> > > -	lock_map_acquire_read(&bh_lock_map);
>> > >  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>> > >  }
>> > >  
>> > > @@ -31,13 +30,11 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
>> > >  
>> > >  static inline void local_bh_enable_ip(unsigned long ip)
>> > >  {
>> > > -	lock_map_release(&bh_lock_map);
>> > >  	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
>> > >  }
>> > >  
>> > >  static inline void local_bh_enable(void)
>> > >  {
>> > > -	lock_map_release(&bh_lock_map);
>> > >  	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>> > >  }
>> > >  
>> > > diff --git a/kernel/softirq.c b/kernel/softirq.c
>> > > index e864f9ce1dfe..782d5e9753f6 100644
>> > > --- a/kernel/softirq.c
>> > > +++ b/kernel/softirq.c
>> > > @@ -175,6 +175,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>> > >  		lockdep_softirqs_off(ip);
>> > >  		raw_local_irq_restore(flags);
>> > >  	}
>> > > +
>> > > +	lock_map_acquire_read(&bh_lock_map);
>> > >  }
>> > >  EXPORT_SYMBOL(__local_bh_disable_ip);
>> > >  
>> > > @@ -183,6 +185,8 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
>> > >  	unsigned long flags;
>> > >  	int newcnt;
>> > >  
>> > > +	lock_map_release(&bh_lock_map);
>> > > +
>> > >  	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
>> > >  			    this_cpu_read(softirq_ctrl.cnt));
>> > >  
>> > > @@ -208,6 +212,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>> > >  	u32 pending;
>> > >  	int curcnt;
>> > >  
>> > > +	lock_map_release(&bh_lock_map);
>> > > +
>> > 
>> > Ok, this is not needed because __local_bh_enable() will be called by
>> > __local_bh_enable_ip().
>> > 
>> 
>> Hmm.. it's a bit complicated than that because __local_bh_enable() is
>> called twice. We need to remain the lock_map_release() in
>> __local_bh_enable_ip(), remove the lock_map_release() and add another
>> one in ksoftirq_run_end().
>> 
>> Let me think and test more on this.
>> 
>
>So what I have came up so far is as follow:
>
>1. I moved bh_lock_map to only for PREEMPT_RT (since for non-RT we have
>   current softirq context tracking).

Sounds good to me.

>2. I moved lock_map_acquire_read() and lock_map_release() into
>   PREEMPT_RT version of __local_bh_{disable,enable}_ip().
>3. I added a lock_map_release() in ksoftirq_run_end() to release the
>   conceptual bh_lock_map lock.

I see that __local_bh_enable_ip() and ksoftirq_run_end()
are the only call sites of __local_bh_enable() on PREEMPT_RT,  
so this looks good to me as well.

>Let me know how you think about this. Given 2 & 3 needs some reviews
>from PREEMPT_RT, and it's -rc5 already, so I'm going to postpone this
>into 6.16 (I will resend this patch if it looks good to you). Sounds
>good?

Sounds good, Thanks!

Sincerely,
Ryo Takakura

>Regards,
>Boqun
>------------------------------------------------->8
>Subject: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
>
>Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
>PREEMPT_RT."), the wait context test for mutex usage within
>"in softirq context" fails as it references @softirq_context.
>
>[    0.184549]   | wait context tests |
>[    0.184549]   --------------------------------------------------------------------------
>[    0.184549]                                  | rcu  | raw  | spin |mutex |
>[    0.184549]   --------------------------------------------------------------------------
>[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
>[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
>[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
>
>As a fix, add lockdep map for BH disabled section. This fixes the
>issue by letting us catch cases when local_bh_disable() gets called
>with preemption disabled where local_lock doesn't get acquired.
>In the case of "in softirq context" selftest, local_bh_disable() was
>being called with preemption disable as it's early in the boot.
>
>[boqun: Move the lockdep annotations into __local_bh_*() to avoid false
>positives because of unpaired local_bh_disable() reported by Borislav
>Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
>PREEMPT_RT]
>
>Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
>Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
>Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
>---
> kernel/softirq.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/kernel/softirq.c b/kernel/softirq.c
>index 4dae6ac2e83f..3ce136bdcbfe 100644
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -126,6 +126,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
> 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
> };
> 
>+#ifdef CONFIG_DEBUG_LOCK_ALLOC
>+static struct lock_class_key bh_lock_key;
>+struct lockdep_map bh_lock_map = {
>+	.name = "local_bh",
>+	.key = &bh_lock_key,
>+	.wait_type_outer = LD_WAIT_FREE,
>+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>+	.lock_type = LD_LOCK_PERCPU,
>+};
>+EXPORT_SYMBOL_GPL(bh_lock_map);
>+#endif
>+
> /**
>  * local_bh_blocked() - Check for idle whether BH processing is blocked
>  *
>@@ -148,6 +160,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> 
> 	WARN_ON_ONCE(in_hardirq());
> 
>+	lock_map_acquire_read(&bh_lock_map);
>+
> 	/* First entry of a task into a BH disabled section? */
> 	if (!current->softirq_disable_cnt) {
> 		if (preemptible()) {
>@@ -211,6 +225,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> 	WARN_ON_ONCE(in_hardirq());
> 	lockdep_assert_irqs_enabled();
> 
>+	lock_map_release(&bh_lock_map);
>+
> 	local_irq_save(flags);
> 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
> 
>@@ -261,6 +277,8 @@ static inline void ksoftirqd_run_begin(void)
> /* Counterpart to ksoftirqd_run_begin() */
> static inline void ksoftirqd_run_end(void)
> {
>+	/* pairs with the lock_map_acquire_read() in ksoftirqd_run_begin() */
>+	lock_map_release(&bh_lock_map);
> 	__local_bh_enable(SOFTIRQ_OFFSET, true);
> 	WARN_ON_ONCE(in_interrupt());
> 	local_irq_enable();
>-- 
>2.47.1

