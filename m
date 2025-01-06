Return-Path: <netdev+bounces-155552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10749A02F50
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EB51641D0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63302198832;
	Mon,  6 Jan 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="M0MBuM3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2CE574
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185799; cv=none; b=hZ2K8xyDe0sRzFZE4ca81EU08DF3uWofhCb6hsQgJNhwRdyioimonnoL3NMCZtDJfkXVXQ2oZ7+l5YazchnMYBWyW2vzqcPaRwWc+gu4qGuV72zPizeDLXmXbzwMyN2frMKl5pf3mR/AxX6Sxm8/WHrZZOycPq0UGwfJRIf2lVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185799; c=relaxed/simple;
	bh=6fVhLpe7YkMEwQLXkQGg5YrbtcfpbJxSDOU6l6IHp3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ4V0qsNKhrKeXiFha2kGIROqcMBfmQ1uZL7u8sGM6FFGiljr6YiwgfGl0VUARs6/r9M9rfFJwy2p8UtjMAP1+HgYQERx0fWZnD2lEcScLOs3DKC+vBGxF6MngUPnz+B2282TRyw5SFyxTRXpeG2CNsIWXY9268lDu0UXxMoXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=M0MBuM3Q; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h+Wo5pjlAec1dqs9IdIsj75ouyAkSewnJM6WeOl2q6k=; t=1736185797; x=1737049797; 
	b=M0MBuM3QnvMMQQnmU4ff1r4djYQNEp5eCuCF9xtJyv7yynE7FhYLGbK7UKvKZ1rOdFoevyDMUi8
	8q1+iKZcxS61ctIb0CDTjjWkBFXt6vUHAzrk1eROfJy41JEALlsvBByctiX33CoFDfLXlxL4TrlAg
	iTZw+g61+SDim9dSUAYojNH0QC9NO9Voq3aHVTt/E50vxbmsQcniLYBWNOFs2lLrSxDxZJhBBC0uy
	6hO4pIdpNyF5Vkgl0Q8zjyp/nBXvih2FpCp9p1YbWi4GbzIYZAwAglKXw6inQbj+vkgKxNEXseKy1
	pgzhosyvpbmIAbpQHrY86NFQ4tiIuaz3I8nA==;
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43060)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tUqtU-0003o0-RM
	for netdev@vger.kernel.org; Mon, 06 Jan 2025 09:28:03 -0800
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb8accbde3so7583712b6e.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 09:28:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmd9hupwMUIefaMlMSzvXrnwXsDY5tQ+vkQBKOtb2l+M9AGQcip2Iak4h5As+zxRj5CckGe5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMvr6lX6Pmmsb+nvm6CUawvJxKMD+p9s1F/mtPYPbAh+tU+ei
	ZUoLzVmzawIFMUYB3n6E2Szok6TccPJlv8Rs5XxW7IG3NYeBTJ4fUjUbZhWHfDha9xt/3WewWRm
	VcpjhPwHMPDbiGA+c7LR1VzCMix8=
X-Google-Smtp-Source: AGHT+IEcWuQKC7ECdLpls4+VkWHjnbQNX8Puiabwf9yiEDmUX27JAp96DTBkJmJHjhyCKyh9knun4EiiI/m+anvQzP8=
X-Received: by 2002:a05:6871:a008:b0:29f:99de:4330 with SMTP id
 586e51a60fabf-2a9eaa0cc86mr99054fac.4.1736184480162; Mon, 06 Jan 2025
 09:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-13-ouster@cs.stanford.edu> <202412251044.574ee2c0-lkp@intel.com>
In-Reply-To: <202412251044.574ee2c0-lkp@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 6 Jan 2025 09:27:24 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>
Message-ID: <CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: d419784c47c095b08cbe302b66275b1c

I have pored over this message for a while and can't figure out how
Homa code could participate in this deadlock, other than by calling
hrtimer_init (which is done without holding any locks). If anyone else
can figure out exactly what this message means and how it relates to
Homa, I'd love to hear it. Otherwise I'm going to assume it's either a
false positive or a problem elsewhere in the Linux kernel.

-John-


On Tue, Dec 24, 2024 at 6:27=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_d=
etected" on:
>
> commit: 087197983ce53b12680eedd496208567f189fbb6 ("[PATCH net-next v4 12/=
12] net: homa: create Makefile and Kconfig")
> url: https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/inet-=
homa-define-user-visible-API-for-Homa/20241217-081126
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git bc6=
a5efe3dcd9ada8d76eeb69039a11a86add39b
> patch link: https://lore.kernel.org/all/20241217000626.2958-13-ouster@cs.=
stanford.edu/
> patch subject: [PATCH net-next v4 12/12] net: homa: create Makefile and K=
config
>
> in testcase: trinity
> version:
> with following parameters:
>
>         runtime: 600s
>
>
>
> config: x86_64-randconfig-075-20241223
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------+------------+------------+
> |                                                                        =
                                                                           =
                 | 3a0d944318 | 087197983c |
> +------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------+------------+------------+
> | WARNING:possible_circular_locking_dependency_detected                  =
                                                                           =
                 | 0          | 21         |
> | WARNING:possible_circular_locking_dependency_detected_homa_timer_is_try=
ing_to_acquire_lock:at:down_trylock_but_task_is_already_holding_lock:at:__d=
ebug_object_init | 0          | 21         |
> | WARNING:at_lib/debugobjects.c:#lookup_object_or_alloc                  =
                                                                           =
                 | 0          | 21         |
> | RIP:lookup_object_or_alloc                                             =
                                                                           =
                 | 0          | 21         |
> +------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412251044.574ee2c0-lkp@intel.=
com
>
>
> [   11.584244][  T133] WARNING: possible circular locking dependency dete=
cted
> [   11.584248][  T133] 6.13.0-rc2-00436-g087197983ce5 #1 Not tainted
> [   11.584253][  T133] --------------------------------------------------=
----
> [   11.584256][  T133] homa_timer/133 is trying to acquire lock:
> [ 11.584261][ T133] ffffffff8c9b9318 ((console_sem).lock){-...}-{2:2}, at=
: down_trylock (kernel/locking/semaphore.c:140)
> [   11.585197][  T133]
> [   11.585197][  T133] but task is already holding lock:
> [ 11.585197][ T133] ffffffff9165dbb0 (&obj_hash[i].lock){-.-.}-{2:2}, at:=
 __debug_object_init (lib/debugobjects.c:662 lib/debugobjects.c:743)
> [   11.585197][  T133]
> [   11.585197][  T133] which lock already depends on the new lock.
> [   11.585197][  T133]
> [   11.585197][  T133] the existing dependency chain (in reverse order) i=
s:
> [   11.585197][  T133]
> [   11.585197][  T133] -> #3 (&obj_hash[i].lock){-.-.}-{2:2}:
> [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/loc=
king/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_sm=
p.h:111 kernel/locking/spinlock.c:162)
> [ 11.585197][ T133] debug_object_assert_init (lib/debugobjects.c:1007)
> [ 11.585197][ T133] __mod_timer (kernel/time/timer.c:1078)
> [ 11.585197][ T133] add_timer_global (kernel/time/timer.c:1330)
> [ 11.585197][ T133] __queue_delayed_work (kernel/workqueue.c:2527)
> [ 11.585197][ T133] queue_delayed_work_on (kernel/workqueue.c:2553)
> [ 11.585197][ T133] psi_task_change (kernel/sched/psi.c:913 (discriminato=
r 1))
> [ 11.585197][ T133] enqueue_task (kernel/sched/core.c:2070)
> [ 11.585197][ T133] wake_up_new_task (kernel/sched/core.c:2110 kernel/sch=
ed/core.c:4870)
> [ 11.585197][ T133] kernel_clone (kernel/fork.c:2841)
> [ 11.585197][ T133] user_mode_thread (kernel/fork.c:2876)
> [ 11.585197][ T133] rest_init (init/main.c:712)
> [ 11.585197][ T133] start_kernel (init/main.c:1052 (discriminator 1))
> [ 11.585197][ T133] x86_64_start_reservations (arch/x86/kernel/head64.c:4=
95)
> [ 11.585197][ T133] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (di=
scriminator 17))
> [ 11.585197][ T133] common_startup_64 (arch/x86/kernel/head_64.S:415)
> [   11.585197][  T133]
> [   11.585197][  T133] -> #2 (&rq->__lock){-.-.}-{2:2}:
> [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/loc=
king/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [ 11.585197][ T133] _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
> [ 11.585197][ T133] raw_spin_rq_lock_nested (arch/x86/include/asm/preempt=
.h:84 kernel/sched/core.c:600)
> [ 11.585197][ T133] task_rq_lock (kernel/sched/core.c:718)
> [ 11.585197][ T133] cgroup_move_task (kernel/sched/psi.c:1187)
> [ 11.585197][ T133] css_set_move_task (kernel/cgroup/cgroup.c:899 (discri=
minator 3))
> [ 11.585197][ T133] cgroup_post_fork (kernel/cgroup/cgroup.c:6697)
> [ 11.585197][ T133] copy_process (kernel/fork.c:2622)
> [ 11.585197][ T133] kernel_clone (include/linux/random.h:26 kernel/fork.c=
:2808)
> [ 11.585197][ T133] user_mode_thread (kernel/fork.c:2876)
> [ 11.585197][ T133] rest_init (init/main.c:712)
> [ 11.585197][ T133] start_kernel (init/main.c:1052 (discriminator 1))
> [ 11.585197][ T133] x86_64_start_reservations (arch/x86/kernel/head64.c:4=
95)
> [ 11.585197][ T133] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (di=
scriminator 17))
> [ 11.585197][ T133] common_startup_64 (arch/x86/kernel/head_64.S:415)
> [   11.585197][  T133]
> [   11.585197][  T133] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/loc=
king/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_sm=
p.h:111 kernel/locking/spinlock.c:162)
> [ 11.585197][ T133] try_to_wake_up (kernel/sched/core.c:2197 kernel/sched=
/core.c:4025 kernel/sched/core.c:4207)
> [ 11.585197][ T133] up (kernel/locking/semaphore.c:191)
> [ 11.585197][ T133] __up_console_sem (kernel/printk/printk.c:344 (discrim=
inator 1))
> [ 11.585197][ T133] console_unlock (kernel/printk/printk.c:2870 kernel/pr=
intk/printk.c:3271 kernel/printk/printk.c:3309)
> [ 11.585197][ T133] vga_remove_vgacon (drivers/pci/vgaarb.c:188 drivers/p=
ci/vgaarb.c:167)
> [ 11.585197][ T133] aperture_remove_conflicting_pci_devices (drivers/vide=
o/aperture.c:331 drivers/video/aperture.c:369)
> [ 11.585197][ T133] bochs_pci_probe (drivers/gpu/drm/tiny/bochs.c:724)
> [ 11.585197][ T133] local_pci_probe (drivers/pci/pci-driver.c:325)
> [ 11.585197][ T133] pci_call_probe (drivers/pci/pci-driver.c:392)
> [ 11.585197][ T133] pci_device_probe (drivers/pci/pci-driver.c:452)
> [ 11.585197][ T133] really_probe (drivers/base/dd.c:579 drivers/base/dd.c=
:658)
> [ 11.585197][ T133] __driver_probe_device (drivers/base/dd.c:800)
> [ 11.585197][ T133] driver_probe_device (drivers/base/dd.c:831)
> [ 11.585197][ T133] __driver_attach (drivers/base/dd.c:1217)
> [ 11.585197][ T133] bus_for_each_dev (drivers/base/bus.c:369)
> [ 11.585197][ T133] bus_add_driver (drivers/base/bus.c:676)
> [ 11.585197][ T133] driver_register (drivers/base/driver.c:247)
> [ 11.585197][ T133] bochs_pci_driver_init (include/drm/drm_module.h:69 dr=
ivers/gpu/drm/tiny/bochs.c:806)
> [ 11.585197][ T133] do_one_initcall (init/main.c:1267)
> [ 11.585197][ T133] do_initcalls (init/main.c:1327 init/main.c:1344)
> [ 11.585197][ T133] kernel_init_freeable (init/main.c:1581)
> [ 11.585197][ T133] kernel_init (init/main.c:1468)
> [ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)
> [   11.585197][  T133]
> [   11.585197][  T133] -> #0 ((console_sem).lock){-...}-{2:2}:
> [ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
> [ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 kernel/=
locking/lockdep.c:3904)
> [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/loc=
king/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_sm=
p.h:111 kernel/locking/spinlock.c:162)
> [ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
> [ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.c:32=
6)
> [ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:2852=
 kernel/printk/printk.c:2009)
> [ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/prin=
tk/printk.c:2378)
> [ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
> [ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
> [ 11.585197][ T133] lookup_object_or_alloc+0x3d4/0x590
> [ 11.585197][ T133] __debug_object_init (lib/debugobjects.c:744)
> [ 11.585197][ T133] hrtimer_init (kernel/time/hrtimer.c:456 kernel/time/h=
rtimer.c:1606)
> [ 11.585197][ T133] homa_timer_main (net/homa/homa_plumbing.c:971)
> [ 11.585197][ T133] kthread (kernel/kthread.c:389)
> [ 11.585197][ T133] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 11.585197][ T133] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)
> [   11.585197][  T133]
> [   11.585197][  T133] other info that might help us debug this:
> [   11.585197][  T133]
> [   11.585197][  T133] Chain exists of:
> [   11.585197][  T133]   (console_sem).lock --> &rq->__lock --> &obj_hash=
[i].lock
> [   11.585197][  T133]
> [   11.585197][  T133]  Possible unsafe locking scenario:
> [   11.585197][  T133]
> [   11.585197][  T133]        CPU0                    CPU1
> [   11.585197][  T133]        ----                    ----
> [   11.585197][  T133]   lock(&obj_hash[i].lock);
> [   11.585197][  T133]                                lock(&rq->__lock);
> [   11.585197][  T133]                                lock(&obj_hash[i].l=
ock);
> [   11.585197][  T133]   lock((console_sem).lock);
> [   11.585197][  T133]
> [   11.585197][  T133]  *** DEADLOCK ***
> [   11.585197][  T133]
> [   11.585197][  T133] 1 lock held by homa_timer/133:
> [ 11.585197][ T133] #0: ffffffff9165dbb0 (&obj_hash[i].lock){-.-.}-{2:2},=
 at: __debug_object_init (lib/debugobjects.c:662 lib/debugobjects.c:743)
> [   11.585197][  T133]
> [   11.585197][  T133] stack backtrace:
> [   11.585197][  T133] CPU: 0 UID: 0 PID: 133 Comm: homa_timer Not tainte=
d 6.13.0-rc2-00436-g087197983ce5 #1
> [   11.585197][  T133] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   11.585197][  T133] Call Trace:
> [   11.585197][  T133]  <TASK>
> [ 11.585197][ T133] dump_stack_lvl (lib/dump_stack.c:123)
> [ 11.585197][ T133] print_circular_bug (kernel/locking/lockdep.c:2077)
> [ 11.585197][ T133] check_noncircular (kernel/locking/lockdep.c:2206)
> [ 11.585197][ T133] ? print_circular_bug (kernel/locking/lockdep.c:2182)
> [ 11.585197][ T133] ? prb_read (kernel/printk/printk_ringbuffer.c:1909)
> [ 11.585197][ T133] ? alloc_chain_hlocks (kernel/locking/lockdep.c:3528)
> [ 11.585197][ T133] check_prev_add (kernel/locking/lockdep.c:3162)
> [ 11.585197][ T133] ? lockdep_lock (arch/x86/include/asm/atomic.h:107 (di=
scriminator 13) include/linux/atomic/atomic-arch-fallback.h:2170 (discrimin=
ator 13) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 13)=
 include/asm-generic/qspinlock.h:111 (discriminator 13) kernel/locking/lock=
dep.c:144 (discriminator 13))
> [ 11.585197][ T133] validate_chain (kernel/locking/lockdep.c:3281 kernel/=
locking/lockdep.c:3904)
> [ 11.585197][ T133] ? check_prev_add (kernel/locking/lockdep.c:3860)
> [ 11.585197][ T133] ? mark_lock (kernel/locking/lockdep.c:4727 (discrimin=
ator 3))
> [ 11.585197][ T133] __lock_acquire (kernel/locking/lockdep.c:5226)
> [ 11.585197][ T133] lock_acquire (kernel/locking/lockdep.c:467 kernel/loc=
king/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [ 11.585197][ T133] ? down_trylock (kernel/locking/semaphore.c:140)
> [ 11.585197][ T133] ? lock_sync (kernel/locking/lockdep.c:5817)
> [ 11.585197][ T133] ? validate_chain (kernel/locking/lockdep.c:3797 kerne=
l/locking/lockdep.c:3817 kernel/locking/lockdep.c:3872)
> [ 11.585197][ T133] _raw_spin_lock_irqsave (include/linux/spinlock_api_sm=
p.h:111 kernel/locking/spinlock.c:162)
> [ 11.585197][ T133] ? down_trylock (kernel/locking/semaphore.c:140)
> [ 11.585197][ T133] ? vprintk_emit (kernel/printk/printk.c:2431 kernel/pr=
intk/printk.c:2378)
> [ 11.585197][ T133] down_trylock (kernel/locking/semaphore.c:140)
> [ 11.585197][ T133] __down_trylock_console_sem (kernel/printk/printk.c:32=
6)
> [ 11.585197][ T133] console_trylock_spinning (kernel/printk/printk.c:2852=
 kernel/printk/printk.c:2009)
> [ 11.585197][ T133] vprintk_emit (kernel/printk/printk.c:2431 kernel/prin=
tk/printk.c:2378)
> [ 11.585197][ T133] ? wake_up_klogd_work_func (kernel/printk/printk.c:238=
1)
> [ 11.585197][ T133] vprintk (kernel/printk/printk_safe.c:86)
> [ 11.585197][ T133] _printk (kernel/printk/printk.c:2452)
> [ 11.585197][ T133] ? printk_get_console_flush_type (kernel/printk/printk=
.c:2452)
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241225/202412251044.574ee2c0-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

