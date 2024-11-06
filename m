Return-Path: <netdev+bounces-142532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEAC9BF891
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A251F222E3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481720CCE3;
	Wed,  6 Nov 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4ft22hs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8ED20CCDF;
	Wed,  6 Nov 2024 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929002; cv=none; b=CUm7obBo6CH2+oFbBQiSfR7NWCC/WkZT+rhPHc7EoDFDGZmZ0pEbLUAbpXyZpJzaw4WwHVXH+4SS7FFVsq/WIqcXE1vkjJ47SGR56cZ5NdQU8xuQQB/5g0nXq5ftzBRLokLMrHkpkZb1JOcLW1WTwL6Hd5YKgftCmKUzSMun+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929002; c=relaxed/simple;
	bh=3/EOky3XMrdjnFiuMnxm5gADvKbVXb3PivSs8aAfDbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQCIAYD0ZlLca/SKcDv6D8H+8BkINV+Z3rjlBGhT1+MpHNh0wxBsmSie3qZ1PppS0MNNUtovyXg8XD8pYMfGBaa0or5ppSfv6+rBZ5Ux8QuZWzyEUHyz6e95fj7ZSvF+ncBfq0INsrzpqCjc8EaJuJuurnWR84gwK7QgN1+dHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4ft22hs; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so3221846d6.0;
        Wed, 06 Nov 2024 13:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730929000; x=1731533800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vf3Jiqr+9MiGHid0ZZABEa1IykD0oIjPD0P68+pcC4=;
        b=M4ft22hsRf5xOT0sWA+NtgH43pQQHg5tE+xWjz+4jWjG5fsFIjIbteQ93111xcSqtw
         nX1d73h3uzubT26iSZpfSvEAzcE67cyagKS2Z1D/ldO+hTMhk1jRfw1Bp9EXkce5RTGr
         /up/YO491FAHQZ8vvZqI/ojUXlcxWhLCqiDEMV8biKtXrZdqo+EfsvZ8PyyGa7pugi+z
         2ukgMhsJ3YN5VZl67ZtX5CypZ165ayejCmuxOi5fkKfEmWNyrCQSf36YWifg1sjR6NTy
         hnsNiWc2Y9grk4DZGnWO9PUsQR2ESunvcExhI4SpJf5LL+qTrbBXu25pR7z398k4qifm
         gxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929000; x=1731533800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vf3Jiqr+9MiGHid0ZZABEa1IykD0oIjPD0P68+pcC4=;
        b=QR6DURaamr8NsxS5GevR5/HzBsxuZOnRZekZzeO82cMVTDyV1nAe6tpQp+5qQ3LOn3
         rn5+RKCt6tQpROcbRxVEzIOoK6CqO4ZeLx8kJvq3zq2V0XmCBkfpCW/NHhFYILIgN6u5
         UicfGN+yOOsWhnvYYJI5lXQGVSpOqO4QHU648KjTL5s4titUwc67jxtp6PpXW72FIi5d
         eR01gXeKUEBNYAxeQOZQn4h3ymcJAJOVrgydiOicnPrQSO3qURfaBEDUqFSA7s9kQafb
         4ZC1r3Fyhq3Sn9slZrOJu8Y3vZV4sBxpiqzESWTuNlh2UvcI8oouyYpU49S6yMfjgDFX
         /hAw==
X-Forwarded-Encrypted: i=1; AJvYcCUN2YS4jWy/+oYjVfgMB2PJw+WE0ze+WOjWoDxEV+DB2Va3B8lFekNMktlRaNZ/zI0iG3GDe43v@vger.kernel.org, AJvYcCVVoqrECf7FoWRHVNPZCztCaxHAvPXI48ifeqLkXqxDGhRMSPEbK8A6NsGS70qxy/4uSzrlN849RMR2AoL1VlU=@vger.kernel.org, AJvYcCWcjIQq0jp5TIpwDAkvVukLp2XZk2tsee1JOoSR69VAtNfpCgSVACkDwxGXp6prpO6V5i4EfU2uJsvo6xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VqMC8AYVp6dtiyydGfg/6Ut4Wr1VKuz0AXPUNXScU0e2p6mi
	UItt9awZTelTe9DLJrPMLSqj+O2l7zpkXhYDbJEVFUc0MwwMdN7f
X-Google-Smtp-Source: AGHT+IGfr/C+r4mF9vVXUq2wxwriOcCAZzelP4+2uJBIBORt8bvAqz2i/EjJaNRH1XZOA4Qx+mNdbA==
X-Received: by 2002:ad4:5cce:0:b0:6c3:6477:16e7 with SMTP id 6a1803df08f44-6d393c258a1mr12179566d6.11.1730928999657;
        Wed, 06 Nov 2024 13:36:39 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354177e70sm77456876d6.111.2024.11.06.13.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:36:39 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B09E1200043;
	Wed,  6 Nov 2024 16:36:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 06 Nov 2024 16:36:38 -0500
X-ME-Sender: <xms:ZuErZ513arNNdEpbcPjegs07MZ_8AKCGOz1irjt4Hx76A4fjvZx8LA>
    <xme:ZuErZwEYfr6UifPBUZZ3wc0VX2FvK3Udw6HZHTi9PmxRtIjMoydkCBFP4YX6Q1O1M
    n7cVKyLrO7uhTjCqQ>
X-ME-Received: <xmr:ZuErZ552jVuJ0ZXDyLiCocK0VHzRVyQ8AvXJEzppl4gTRwRarQDn1vbqnck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevhfeghfeujefgieethfetfefhueduheffteev
    tdfhtddviefhtdevueduieegheenucffohhmrghinhepghhnuhdrohhrghdprhhushhtqd
    hfohhrqdhlihhnuhigrdgtohhmpdhfihhlvgdrrghsnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhph
    gvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdr
    fhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtth
    hopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhm
    ohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpth
    htohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZuErZ23hWLbCE0yb7JulOc4yOgfWeMUrN8SLeQp3O05ahXa1hUnkoA>
    <xmx:ZuErZ8GtHxHOXaztkS-96UU1tB4Pw-sLLin4eVi6TDCIOllTWROnQQ>
    <xmx:ZuErZ3_9as18fy8rxTAfLLV66Asy32AgBo6jUMgkJojuPIjyqr-L3g>
    <xmx:ZuErZ5ma_9vs8-y1lqO-XZ7QqjKrKPcRr6R93_781nB3GQ6pNMthlA>
    <xmx:ZuErZwEWd4wrFrUnB7P0EefvBEpUsW0CWtjwBoh7khRXuohFI2CVGVdQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 16:36:37 -0500 (EST)
Date: Wed, 6 Nov 2024 13:35:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
Message-ID: <ZyvhDbNAhPTqIoVi@boqun-archlinux>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101010121.69221-7-fujita.tomonori@gmail.com>

On Fri, Nov 01, 2024 at 10:01:20AM +0900, FUJITA Tomonori wrote:
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
> For the proper debug info, readx_poll_timeout() and __might_sleep()
> are implemented as a macro. We could implement them as a normal
> function if there is a clean way to get a null-terminated string
> without allocation from core::panic::Location::file().
> 

So printk() actually support printing a string with a precison value,
that is: a format string "%.*s" would take two inputs, one for the length
and the other for the pointer to the string, for example you can do:

	char *msg = "hello";

	printk("%.*s\n", 5, msg);

This is similar to printf() in glibc [1].

If we add another __might_sleep_precision() which accepts a file name
length:

	void __might_sleep_precision(const char *file, int len, int line)

then we don't need to use macro here, I've attached a diff based
on your whole patchset, and it seems working.

Cc printk folks to if they know any limitation on using precision.

Regards,
Boqun

[1]: https://www.gnu.org/software/libc/manual/html_node/Output-Conversion-Syntax.html#Output-Conversion-Syntax

> readx_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is
> intended that klint [1] or a similar tool will be used to check it
> in the future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

--------------------------------------------->8
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index dabb772c468f..4d368ce80db6 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -18,7 +18,7 @@
     Driver,
 };
 use kernel::prelude::*;
-use kernel::readx_poll_timeout;
+use kernel::read_poll_timeout;
 use kernel::sizes::{SZ_16K, SZ_8K};
 use kernel::time::Delta;
 
@@ -95,7 +95,7 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from SRAM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
 
-        readx_poll_timeout!(
+        read_poll_timeout(
             || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
             |val| val != 0x00 && val != 0x10,
             Delta::from_millis(50),
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index be2e8c0a187e..b405b0d19bac 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -87,6 +87,8 @@ extern int dynamic_might_resched(void);
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
+extern void __might_resched_precision(const char *file, int len, int line, unsigned int offsets);
+extern void __might_sleep_precision(const char *file, int len, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..f872aa18eaf0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8543,7 +8543,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
-void __might_sleep(const char *file, int line)
+void __might_sleep_precision(const char *file, int len, int line)
 {
 	unsigned int state = get_current_state();
 	/*
@@ -8557,7 +8557,14 @@ void __might_sleep(const char *file, int line)
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	__might_resched(file, line, 0);
+	__might_resched_precision(file, len, line, 0);
+}
+
+void __might_sleep(const char *file, int line)
+{
+	long len = strlen(file);
+
+	__might_sleep_precision(file, len, line);
 }
 EXPORT_SYMBOL(__might_sleep);
 
@@ -8582,7 +8589,7 @@ static inline bool resched_offsets_ok(unsigned int offsets)
 	return nested == offsets;
 }
 
-void __might_resched(const char *file, int line, unsigned int offsets)
+void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -8605,8 +8612,8 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
-	       file, line);
+	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
+	       len, file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
@@ -8631,6 +8638,13 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
+
+void __might_resched(const char *file, int line, unsigned int offsets)
+{
+	long len = strlen(file);
+
+	__might_resched_precision(file, len, line, offsets);
+}
 EXPORT_SYMBOL(__might_resched);
 
 void __cant_sleep(const char *file, int line, int preempt_offset)
diff --git a/rust/helpers/kernel.c b/rust/helpers/kernel.c
index da847059260b..9dff28f4618e 100644
--- a/rust/helpers/kernel.c
+++ b/rust/helpers/kernel.c
@@ -7,7 +7,7 @@ void rust_helper_cpu_relax(void)
 	cpu_relax();
 }
 
-void rust_helper___might_sleep(const char *file, int line)
+void rust_helper___might_sleep_precision(const char *file, int len, int line)
 {
-	__might_sleep(file, line);
+	__might_sleep_precision(file, len, line);
 }
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index a8caa08f86f2..d7e5be162b6e 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -10,10 +10,25 @@
     time::{delay::fsleep, Delta, Instant},
 };
 
+use core::panic::Location;
+
 /// Polls periodically until a condition is met or a timeout is reached.
 ///
 /// Public but hidden since it should only be used from public macros.
-#[doc(hidden)]
+///
+/// ```rust
+/// use kernel::io::poll::read_poll_timeout;
+/// use kernel::time::Delta;
+/// use kernel::sync::{SpinLock, new_spinlock};
+///
+/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
+/// let g = lock.lock();
+/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Delta::from_micros(42));
+/// drop(g);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[track_caller]
 pub fn read_poll_timeout<Op, Cond, T: Copy>(
     mut op: Op,
     cond: Cond,
@@ -28,6 +43,8 @@ pub fn read_poll_timeout<Op, Cond, T: Copy>(
     let sleep = !sleep_delta.is_zero();
     let timeout = !timeout_delta.is_zero();
 
+    might_sleep(Location::caller());
+
     let val = loop {
         let val = op()?;
         if cond(val) {
@@ -55,41 +72,13 @@ pub fn read_poll_timeout<Op, Cond, T: Copy>(
     }
 }
 
-/// Print debug information if it's called inside atomic sections.
-///
-/// Equivalent to the kernel's [`__might_sleep`].
-#[macro_export]
-macro_rules! __might_sleep {
-    () => {
-        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
-        // SAFETY: FFI call.
-        unsafe {
-            $crate::bindings::__might_sleep(
-                c_str!(::core::file!()).as_char_ptr(),
-                ::core::line!() as i32,
-            )
-        }
-    };
-}
-
-/// Polls periodically until a condition is met or a timeout is reached.
-///
-/// `op` is called repeatedly until `cond` returns `true` or the timeout is
-///  reached. The return value of `op` is passed to `cond`.
-///
-/// `sleep_delta` is the duration to sleep between calls to `op`.
-/// If `sleep_delta` is less than one microsecond, the function will busy-wait.
-///
-/// `timeout_delta` is the maximum time to wait for `cond` to return `true`.
-///
-/// This macro can only be used in a nonatomic context.
-#[macro_export]
-macro_rules! readx_poll_timeout {
-    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) => {{
-        if !$sleep_delta.is_zero() {
-            $crate::__might_sleep!();
-        }
-
-        $crate::io::poll::read_poll_timeout($op, $cond, $sleep_delta, $timeout_delta)
-    }};
+fn might_sleep(loc: &Location<'_>) {
+    // SAFETY: FFI call.
+    unsafe {
+        crate::bindings::__might_sleep_precision(
+            loc.file().as_ptr().cast(),
+            loc.file().len() as i32,
+            loc.line() as i32,
+        )
+    }
 }

