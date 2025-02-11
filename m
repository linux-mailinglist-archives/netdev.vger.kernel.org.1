Return-Path: <netdev+bounces-165203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A611A30F09
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2370165C67
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34A1FAC5D;
	Tue, 11 Feb 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtMCALep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DA17C91;
	Tue, 11 Feb 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286129; cv=none; b=TAdPnoM6pWxMk3NnH7xXckr/7wJUylg0mDHb7Zc9gKuXsL0tDkvvm6oH+bIaprWdNUZSKvPDuofpch3nilDcVjJqQzlDoaGejlH845XvN2VrjBiDfukzf/dnLiAGmFoLldz3tt18/t9SVZbXAU7NC5enjm8HG01HBRpDr0h6asM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286129; c=relaxed/simple;
	bh=NJrnNissa9VtChrtfIQicfGI0gqVDx4S851Ho4mvxao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIIn04Bc44MIZgBRu4bShVdI4s5tOL/aHmVVXWpSYMOaFFbX7+XzbzpE+qcMzn7kEdKhx6YtHHSFCQqpUHrqqDn/hi6Vf+v5q8oOIj3+BiwrnK8oiP/n0qlME+pM4fuMD6RZn6IA0ezUZlUHtX05b9QPSuioPwYK2W0gHHTUwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtMCALep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCECDC4CEE7;
	Tue, 11 Feb 2025 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739286128;
	bh=NJrnNissa9VtChrtfIQicfGI0gqVDx4S851Ho4mvxao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtMCALepGKOl5gqAXES2uJ8GTWxB9LvAebovV4W8TkyeSZDr/2c6LGfjo7t/drubi
	 gFJAoypbz8Uegh+vvUKY1meiwkSMUOHzxmf1C87GdM7IDCDooUILviqJMq7PyBeRWN
	 i1ubLMrrY5ghFPM0VCmnGy1Ffe8XyEad/1u4gaY/A1v+uKIykRp7YnrNs9T9BLPoNg
	 5qbAYkod9qTldl2T6X8Z5uEWnl0Knhq6bVNfQfI0FJXyv6DCd+vUvC1Y4uwf2Ik6zy
	 lelJ27tr1xQuQ00pordUKZduYMqGxWWLjknMF+eorhEySDM2eXl3eeQMUvFJYuW3rQ
	 b2qLTIbJamAEA==
Date: Tue, 11 Feb 2025 16:02:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>,
	anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mingo@kernel.org, tglx@linutronix.de,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hayes Wang <hayeswang@realtek.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
Message-ID: <Z6tmbdl646D_UjrY@localhost.localdomain>
References: <20250210124551.3687ae51@foxbook>
 <b0d55f4c-a078-42a0-a0fe-5823700f2837@molgen.mpg.de>
 <Z6n-dWDSxNCjROYV@localhost.localdomain>
 <10de7289-653f-43b1-ad46-2e8a0cd42724@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10de7289-653f-43b1-ad46-2e8a0cd42724@molgen.mpg.de>

Le Tue, Feb 11, 2025 at 12:57:33PM +0100, Paul Menzel a écrit :
> Dear Frederic,
> 
> 
> Thank you for your reply.
> 
> 
> Am 10.02.25 um 14:26 schrieb Frederic Weisbecker:
> > Le Mon, Feb 10, 2025 at 12:59:42PM +0100, Paul Menzel a écrit :
> 
> > > Am 10.02.25 um 12:45 schrieb Michał Pecio:
> > > 
> > > > > > > > > > > On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux
> > > > > > > > > > > 6.9-rc2+
> > > > 
> > > > > Just for the record, I am still seeing this with 6.14.0-rc1
> > > > 
> > > > Is this a regression? If so, which versions were not affected?
> > > 
> > > Unfortunately, I do not know. Right now, my logs go back until September
> > > 2024.
> > > 
> > >      Sep 22 13:08:04 abreu kernel: Linux version 6.11.0-07273-g1e7530883cd2 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-5) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #12 SMP PREEMPT_DYNAMIC Sun Sep 22 09:57:36 CEST 2024
> > > 
> > > > How hard to reproduce? Wasn't it during resume from hibernation?
> > > 
> > > It’s not easy to reproduce, and I believe it’s not related with resuming
> > > from hibernation (which I do not use) or ACPI S3 suspend. I think, I can
> > > force it more, when having the USB-C adapter with only the network cable
> > > plugged into it, and then running `sudo powertop --auto-tune`. But sometimes
> > > it seems unrelated.
> > > 
> > > > IRQ isuses may be a red herring, this code here is a busy wait under
> > > > spinlock. There are a few of those, they cause various problems.
> > > > 
> > > >                   if (xhci_handshake(&xhci->op_regs->status,
> > > >                                 STS_RESTORE, 0, 100 * 1000)) {
> > > >                           xhci_warn(xhci, "WARN: xHC restore state timeout\n");
> > > > 			spin_unlock_irq(&xhci->lock);
> > > >                           return -ETIMEDOUT;
> > > >                   }
> > > > 
> > > > This thing timing out may be close to the root cause of everything.
> > > 
> > > Interesting. Hopefully the USB folks have an idea.
> > 
> > Handler #08 is NET_RX. So something raised the NET_RX on some non-appropriate
> > place, perhaps...
> > 
> > Can I ask you one more trace dump?
> > 
> > I need:
> > 
> > echo 1 > /sys/kernel/tracing/events/irq/softirq_raise/enable
> > echo 1 > /sys/kernel/tracing/options/stacktrace
> > 
> > Unfortunately this will also involve a small patch:
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index fa058510af9c..accd2eb8c927 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -1159,6 +1159,9 @@ static bool report_idle_softirq(void)
> >   	if (local_bh_blocked())
> >   		return false;
> > +	trace_printk("STOP\n");
> > +	trace_dump_stack(0);
> > +	tracing_off();
> >   	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
> >   		pending);
> >   	ratelimit++;
> 
> Thank you for your help. I applied the patch on top of 6.14-rc2, and was
> able to reproduce the issue. Please find the Linux messages attached, and
> the trace can be downloaded [1].

So here is the offender:

 => __raise_softirq_irqoff
 => __napi_schedule
 => rtl8152_runtime_resume.isra.0
 => rtl8152_resume
 => usb_resume_interface.isra.0
 => usb_resume_both
 => __rpm_callback
 => rpm_callback
 => rpm_resume
 => __pm_runtime_resume
 => usb_autoresume_device
 => usb_remote_wakeup
 => hub_event
 => process_one_work
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm

It is calling napi_schedule() from a non-interrupt. And since
____napi_schedule() assumes to be called from an interrupt, it
raises the softirq accordingly without waking up ksoftirqd.

Can you try the following fix (untested, sorry...) ?

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 468c73974046..8f6ea4e7685c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8537,8 +8537,11 @@ static int rtl8152_runtime_resume(struct r8152 *tp)
 		clear_bit(SELECTIVE_SUSPEND, &tp->flags);
 		smp_mb__after_atomic();
 
-		if (!list_empty(&tp->rx_done))
+		if (!list_empty(&tp->rx_done)) {
+			local_bh_disable();
 			napi_schedule(&tp->napi);
+			local_bh_enable();
+		}
 
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	} else {
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db95..1bd730b881f0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -619,6 +619,17 @@ do {									\
 		     (!in_softirq() || in_irq() || in_nmi()));		\
 } while (0)
 
+/*
+ * Assert to be either in hardirq or in serving softirq or with
+ * softirqs disabled. Verifies a safe context to queue a softirq
+ * with __raise_softirq_irqoff().
+ */
+#define lockdep_assert_in_interrupt()				\
+do {								\
+	WARN_ON_ONCE(__lockdep_enabled && !in_interrupt());	\
+} while (0)
+
+
 extern void lockdep_assert_in_softirq_func(void);
 
 #else
@@ -634,6 +645,7 @@ extern void lockdep_assert_in_softirq_func(void);
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
+# define lockdep_assert_in_interrupt() do { } while (0)
 # define lockdep_assert_in_softirq_func() do { } while (0)
 #endif
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..80e415ccf2c8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4666,6 +4666,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	struct task_struct *thread;
 
 	lockdep_assert_irqs_disabled();
+	lockdep_assert_in_interrupt();
 
 	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
 		/* Paired with smp_mb__before_atomic() in

