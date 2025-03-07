Return-Path: <netdev+bounces-173106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02124A575CB
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAE1772A0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9420258CEB;
	Fri,  7 Mar 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzCipdkK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EB258CD8;
	Fri,  7 Mar 2025 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389014; cv=none; b=doJ8DXQZde2Z8P7qALF3jYxqVJ16WfBlyASWjj91rIJPcYGb659o2uC7zr4rLjJS//npjh4fa+Jwmhdgb5Gn90uNUlX+xXITXXcS9KwwzWHGYpiBQGtzZUgWN62Ogbsc08i3lq56kqUtpwMaQSy4ABwGVwyiia4UsTEqLAgM4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389014; c=relaxed/simple;
	bh=GrFpt57Xx7USOU2GNzt22S+rLNLTMrt6HBQMHOCeu6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSWn5QooFm/+NNqC5AFY6wZ6Agi3Jr/OJX3jl9TpNphgX0/PwixfV49pYEHbL77VQwogKR3jd/7f8d2nxrsGDPGN6ESRKWdneKhdoy9PKnORstBZfakuj0IAVdaoRC6lWisAbz791dtwebB0HlqWNWarM0b8fLAapI4j3oF8HEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzCipdkK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4750c3b0097so20626051cf.0;
        Fri, 07 Mar 2025 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741389012; x=1741993812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFIrIXVY4U2+XLcq170BNirGCbrx75xgMFuGmKL3d2A=;
        b=kzCipdkKsW8lwBOjbuRh7pfxBW58fExPf6aRmUzOGAi5R0iK5fmbF5ypclMxyDahAA
         fkNQpd0TdW4NHbxJKv/zncKQoudFfkuXZK2WBhU6WvMuaGHabC002+LgLxASZvmStQ9Z
         wpNlq6SB7mEP6zGxn+E/Aktn2tH7HvllaG2WzA/LxxNDSOIVd9JJZqSMxqlCDz38a/iB
         +jHdv5F2/0KsqzyHcW/686wSpjEOj/6dtvHKg4dW2W2eenQ1SHD58mJwDe9oUT183jM9
         iUwONWSCT/+GP9P6GIsHEioKGHkAs80QlSp0os4d3+rwMMNEpXZpgw3v0OyevS8bJqVg
         VVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741389012; x=1741993812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFIrIXVY4U2+XLcq170BNirGCbrx75xgMFuGmKL3d2A=;
        b=HVmYr/MXgql1kckEcmOxTCVWBIuTQpNw0Cm88DUQbmHoE5lvcYxBOsWPT+dsJ3CD00
         FjeYnZEK+j0t1Q7T4R7jedhQbR9z+EzpoKbAmcmif6i3g0Ly+mdq4g43eHdti/OE0NO7
         xA6y8S8HrwsiQsUGcynNGd9JwEWVYEY4zM50T0/9xgiw6uKDFM2Tdx55eH1CGD1nkYZx
         /Q66a0LcapFvPJwZR3zrM6KI8wb/2bl9UYp4dPhVLudg6taIBHzzhTcn8FmtIF0o0GZX
         wSGjSARqFpGPJ7DqWPGaMuxPbG1HgTJkck8QZuFJ6sKPVDjR9R0xEIPYzH9bfDxAfL7N
         APnA==
X-Forwarded-Encrypted: i=1; AJvYcCU+7EhsF4dxFW6H0N7pjURDTYB/Rmq7XP5yAhUq9JYEx4n/ha2g2CMLa3kJr0B1zHtqbZ88foP7JY4OfwU=@vger.kernel.org, AJvYcCXuQgdGbhkuYkrUcbjwcKzjmMRiaZTui9kXvYyymbh7cBMtfr9junASbJoT2SwMMvoB9JOPbwcd@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVY804mrIzFI49KdUyktCf4vha2wRhRwrXcHdQu5GGKpRxbqa
	5OJkNZCkZv+cuK9ZkvJgg4RPlcKc+Mleu1vcdHq8W8oDWpH542XF
X-Gm-Gg: ASbGncvw+K7Au5RchBUGDQhjnJ3xZTOpF4fIVxSgFPwa2N+t3pR9bGSIevth7KaicW9
	oIjowYS0miP+gIMA3woR4yifictD0720NRE3+nncT+Zrh1iTJFR9jREc7Xysh83pgisxd160NA1
	lFxK3UpRsQbHUdKJ1oGn1j56ZQXs836lnc3O/YU8CeG7vaeBK7Co9AY9cMexB0mnvsf2xYaxIRx
	U49mo1pji9nDxBqiD6VLe0e0RDEFruOAGp2e9X90P9KVWMUu6i4dWqDOdCdH9GaHiGM2AqjZdzk
	YUxsbtiUJ2SHwh8YkL2uz5x5mWBAiHYlU49p/k5wgCRZOC7QWkQSCTmBr/K9oYhpdURZCKa7k4X
	FT/AHxJWcnoUuRHu9FPvL+Uz4wD3jU8Kle/Q=
X-Google-Smtp-Source: AGHT+IEugrRBxIho9xIiWq0vB/+YN93yf2Mere88kc3qzeF0Q6vtoo1+TGPraoWjGTWlD3ETwx2/vQ==
X-Received: by 2002:a05:6214:20c4:b0:6e1:f40c:b558 with SMTP id 6a1803df08f44-6e9006ae131mr70746666d6.44.1741389011569;
        Fri, 07 Mar 2025 15:10:11 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b52csm24439536d6.71.2025.03.07.15.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:10:11 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id BA3521200066;
	Fri,  7 Mar 2025 18:10:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Mar 2025 18:10:10 -0500
X-ME-Sender: <xms:0nzLZ-KjcH97iJ1BkVYn4YZJfQdpeHIyXazUaQKgy3N3GlNpE2Ro6g>
    <xme:0nzLZ2LvgM7VRPT_JqPg50ktqh_DPRoffhT6vFXFanYKcBGFk1PIei2GWjsZODCis
    ZTd3eA5SMja2wHkWw>
X-ME-Received: <xmr:0nzLZ-tQsGWvNqBf5RWFS0z5b0o1AeP4KQpoWq1xeB3KHB0xdT_AHx2825s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhihohhtkhhkrhelkeesghhmrghilhdrtghomhdprhgtphhtthhopegsphesrghl
    ihgvnhekrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehh
    ohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0nzLZzYCTVzPaQYCRMNzXOTE5ZELiV7m02T5KaPkPar9PK12z8UOtw>
    <xmx:0nzLZ1Y50pZNvxEu2OApPQ-rVX06R7n-3y-Id4_vqoUZvB1xKgm3Mg>
    <xmx:0nzLZ_BJNAeAGqnBPS02v-TTv8nkHCvjq5twN7y1TNrBez7T8gA6Xw>
    <xmx:0nzLZ7asjsccSDfvLbfM8Fz8GfgCx5FDG2Hg6_Pgrl-uZn7vjBW1qg>
    <xmx:0nzLZ1raYzs5hNaP5RDKHA0crUuzyedteoP9ubmb9PU3CD74U1Y1uQmy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:10:09 -0500 (EST)
Date: Fri, 7 Mar 2025 15:08:58 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bp@alien8.de, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, peterz@infradead.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: request_irq() with local bh disabled
Message-ID: <Z8t8imzJVhWyDvhC@boqun-archlinux>
References: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
 <20250307133946.64685-1-ryotkkr98@gmail.com>
 <Z8sXdDFJTjYbpAcq@tardis>
 <Z8s8AG3oIxerZHjG@boqun-archlinux>
 <Z8tJAJKQP3gtF7EY@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tJAJKQP3gtF7EY@boqun-archlinux>

On Fri, Mar 07, 2025 at 11:29:04AM -0800, Boqun Feng wrote:
> On Fri, Mar 07, 2025 at 10:33:36AM -0800, Boqun Feng wrote:
> > On Fri, Mar 07, 2025 at 07:57:40AM -0800, Boqun Feng wrote:
> > > On Fri, Mar 07, 2025 at 10:39:46PM +0900, Ryo Takakura wrote:
> > > > Hi Boris,
> > > > 
> > > > On Fri, 7 Mar 2025 14:13:19 +0100, Borislav Petkov wrote:
> > > > >On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
> > > > >> I'm so sorry that the commit caused this problem...
> > > > >> Please let me know if there is anything that I should do.
> > > > >
> > > > >It is gone from the tip tree so you can take your time and try to do it right.
> > > > >
> > > > >Peter and/or I could help you reproduce the issue and try to figure out what
> > > > >needs to change there.
> > > > >
> > > > >HTH.
> > > > 
> > > > Thank you so much for this. I really appreciate it.
> > > > I'll once again take a look and try to fix the problem.
> > > > 
> > > 
> > > Looks like we missed cases where
> > > 
> > > acquire the lock:
> > > 
> > > 	netif_addr_lock_bh():
> > > 	  local_bh_disable();
> > > 	  spin_lock_nested();
> > > 
> > > release the lock:
> > > 
> > > 	netif_addr_unlock_bh():
> > > 	  spin_unlock_bh(); // <- calling __local_bh_disable_ip() directly
> > > 
> > > means we should do the following on top of your changes.
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > ------------------->8
> > > diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> > > index 0640a147becd..7553309cbed4 100644
> > > --- a/include/linux/bottom_half.h
> > > +++ b/include/linux/bottom_half.h
> > > @@ -22,7 +22,6 @@ extern struct lockdep_map bh_lock_map;
> > >  
> > >  static inline void local_bh_disable(void)
> > >  {
> > > -	lock_map_acquire_read(&bh_lock_map);
> > >  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> > >  }
> > >  
> > > @@ -31,13 +30,11 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> > >  
> > >  static inline void local_bh_enable_ip(unsigned long ip)
> > >  {
> > > -	lock_map_release(&bh_lock_map);
> > >  	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> > >  }
> > >  
> > >  static inline void local_bh_enable(void)
> > >  {
> > > -	lock_map_release(&bh_lock_map);
> > >  	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> > >  }
> > >  
> > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > index e864f9ce1dfe..782d5e9753f6 100644
> > > --- a/kernel/softirq.c
> > > +++ b/kernel/softirq.c
> > > @@ -175,6 +175,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> > >  		lockdep_softirqs_off(ip);
> > >  		raw_local_irq_restore(flags);
> > >  	}
> > > +
> > > +	lock_map_acquire_read(&bh_lock_map);
> > >  }
> > >  EXPORT_SYMBOL(__local_bh_disable_ip);
> > >  
> > > @@ -183,6 +185,8 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
> > >  	unsigned long flags;
> > >  	int newcnt;
> > >  
> > > +	lock_map_release(&bh_lock_map);
> > > +
> > >  	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
> > >  			    this_cpu_read(softirq_ctrl.cnt));
> > >  
> > > @@ -208,6 +212,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> > >  	u32 pending;
> > >  	int curcnt;
> > >  
> > > +	lock_map_release(&bh_lock_map);
> > > +
> > 
> > Ok, this is not needed because __local_bh_enable() will be called by
> > __local_bh_enable_ip().
> > 
> 
> Hmm.. it's a bit complicated than that because __local_bh_enable() is
> called twice. We need to remain the lock_map_release() in
> __local_bh_enable_ip(), remove the lock_map_release() and add another
> one in ksoftirq_run_end().
> 
> Let me think and test more on this.
> 

So what I have came up so far is as follow:

1. I moved bh_lock_map to only for PREEMPT_RT (since for non-RT we have
   current softirq context tracking).
2. I moved lock_map_acquire_read() and lock_map_release() into
   PREEMPT_RT version of __local_bh_{disable,enable}_ip().
3. I added a lock_map_release() in ksoftirq_run_end() to release the
   conceptual bh_lock_map lock.

Let me know how you think about this. Given 2 & 3 needs some reviews
from PREEMPT_RT, and it's -rc5 already, so I'm going to postpone this
into 6.16 (I will resend this patch if it looks good to you). Sounds
good?

Regards,
Boqun
------------------------------------------------->8
Subject: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT

Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
PREEMPT_RT."), the wait context test for mutex usage within
"in softirq context" fails as it references @softirq_context.

[    0.184549]   | wait context tests |
[    0.184549]   --------------------------------------------------------------------------
[    0.184549]                                  | rcu  | raw  | spin |mutex |
[    0.184549]   --------------------------------------------------------------------------
[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|

As a fix, add lockdep map for BH disabled section. This fixes the
issue by letting us catch cases when local_bh_disable() gets called
with preemption disabled where local_lock doesn't get acquired.
In the case of "in softirq context" selftest, local_bh_disable() was
being called with preemption disable as it's early in the boot.

[boqun: Move the lockdep annotations into __local_bh_*() to avoid false
positives because of unpaired local_bh_disable() reported by Borislav
Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
PREEMPT_RT]

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
---
 kernel/softirq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4dae6ac2e83f..3ce136bdcbfe 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -126,6 +126,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name = "local_bh",
+	.key = &bh_lock_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type = LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -148,6 +160,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	WARN_ON_ONCE(in_hardirq());
 
+	lock_map_acquire_read(&bh_lock_map);
+
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
@@ -211,6 +225,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
+	lock_map_release(&bh_lock_map);
+
 	local_irq_save(flags);
 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
@@ -261,6 +277,8 @@ static inline void ksoftirqd_run_begin(void)
 /* Counterpart to ksoftirqd_run_begin() */
 static inline void ksoftirqd_run_end(void)
 {
+	/* pairs with the lock_map_acquire_read() in ksoftirqd_run_begin() */
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable(SOFTIRQ_OFFSET, true);
 	WARN_ON_ONCE(in_interrupt());
 	local_irq_enable();
-- 
2.47.1


