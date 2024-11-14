Return-Path: <netdev+bounces-144898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA49C8AC0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55911F247B1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00331FA257;
	Thu, 14 Nov 2024 12:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56841F9A9B
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588568; cv=none; b=A0BLHnKGE5RHzt9BTC8MaY8ksHM7uV9p+rR9cWNlwUUZ09Q3+TfGp2+H/U/oW2ICCNBQDLua9POSqjKCcWZQULS/OE1qSgUCtP13+iHYaX2ROVmtRZ5mpfnpD76vAuKQF26SOB6si/qTjqUHJrcAGydfwGejOkf1bb3S24+4Xaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588568; c=relaxed/simple;
	bh=ELRWhIT9yJfiTWT9hvWHJDjZA63+vmyLwV8YnGYlDgE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qJHwdS8bu6u6jf+HEGexTocPF84jZzJM8ake2eBGzQeb3q+Ul3uwLwiChf7Sqwslx3+ErzcZNWT9ZPJ2t9Ib5Agpo7O7Le+DnPtwjd3BtBUQI96wwb1bjAzv2piEu4+ThxCQ4DhQRJbS0M50HcojuAKEHrmZRPSAAaNxUrZ9Tyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3cb771556so5158575ab.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 04:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731588566; x=1732193366;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWzhVNRA00+eq8Cfx0LuTS7Z8ySa+Jo0rAZR52hvz+E=;
        b=a2+oB0jbkEfFHN7W9qS1w7DMoIVG9xg3TLFIMPym4KcS1wxJnvP+CbpuWbCAb45SUv
         1IgDbA+zu/Rroa+XNU32RVzfTfsSvOmvPicuwjgbMq8DpM2s6kIMAi3Sg7y3bxasAhfy
         2/ZZtzGgqFEDpuZxGlounpUcgktYKQtCpdWK7PEMddUP0GbleEChyjbO8386G1CVzKpK
         H1Ne7zqr8IxJOie3FrjJSZRC/dIF0PgQBrtoDKvoCEANT13vTjz6s8+n0TliJYqByq63
         pOSzb5FtbCSaBXumsmj6dJfgFUxkuE55u4AHZxTnawBnhg9/dPfPngZ7Ae/Ta0YB+2Wi
         1Y7g==
X-Forwarded-Encrypted: i=1; AJvYcCWX37Kb3y7kkNQ2BJF8evtKtjc5iOd0Z7/GSq20kcIblzy53WmAvPwOULuSNis64BxglCNC4iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pTrf8T/JW4rHtkqZfoNASE0o8QG2P4PXj7HRpkpz8CZ+KMjY
	UWcJZIoWSBt9Glqzw7hsG1S+LnFgrZ+j3555xLsyWqIaq/s5wuaeDfQIFWJ53aLeW7k8AD9dMBU
	TtmQHKh9xH8YZaUT3qNf02PEwMkfgRd/lh20DYnq6mpHFXclQrQjDVXc=
X-Google-Smtp-Source: AGHT+IEAj8qeX7GHy6DR/1S424Ov8d5tDTerDypsRu75+TTAB5IQtSgbFYZj+5aBD72i0cNv9fDZsEI2LsJEE+3JQgnOGKLqdyPw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:b0:3a7:1f23:1a42 with SMTP id
 e9e14a558f8ab-3a71fe58e4bmr20499975ab.13.1731588565723; Thu, 14 Nov 2024
 04:49:25 -0800 (PST)
Date: Thu, 14 Nov 2024 04:49:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735f1d5.050a0220.1324f8.0099.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in kern
From: syzbot <syzbot+b212dc1ab9081038fe60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de2f378f2b77 Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160b94e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20d60fe605153ebe
dashboard link: https://syzkaller.appspot.com/bug?extid=b212dc1ab9081038fe60
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2606065a2edc/disk-de2f378f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e0db9d61ce1/vmlinux-de2f378f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86c1e8ceefb5/bzImage-de2f378f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b212dc1ab9081038fe60@syzkaller.appspotmail.com

rn.info kernel: [  288.102240][ T1024] bridge_slave_0: left promiscuous mode
[  288.052032][ [  288.109768][ T1024] bridge0: port 1(bridge_slave_0) entered disabled state
T1024] erspan0: left promiscuous[  288.119638][ T6390] 
 mode
Nov 10 12[  288.122499][ T6390] =============================
:39:03 syzkaller[  288.128669][ T6390] WARNING: suspicious RCU usage
 kern.info kerne[  288.135316][ T6390] 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0 Not tainted
l: [  288.057060[  288.143732][ T6390] -----------------------------
][ T1024] bridge[  288.149741][ T6390] net/sched/sch_generic.c:1290 suspicious rcu_dereference_protected() usage!
0: port 3(erspan[  288.159834][ T6390] 
0) entered disab[  288.159853][ T6390] 
led state
Nov 1[  288.159867][ T6390] 3 locks held by kworker/u8:11/6390:
0 12:39:03 syzka[  288.187464][ T6390]  #0: ffff888068d0d948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
ller kern.info k[  288.199531][ T6390]  #1: ffffc9000b45fd80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
ernel: [  288.07[  288.212948][ T6390]  #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
ernel: [  288.07[  288.212948][ T6390]  #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
ernel: [  288.07[  288.212948][ T6390]  #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2937
1253][ T1024] br[  288.224119][ T6390] 
idge_slave_1: le[  288.231359][ T6390] CPU: 0 UID: 0 PID: 6390 Comm: kworker/u8:11 Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
ft allmulticast [  288.258910][ T6390] Call Trace:
mode
Nov 10 12:[  288.266487][ T6390]  __dump_stack lib/dump_stack.c:94 [inline]
Nov 10 12:[  288.266487][ T6390]  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
39:03 syzkaller [  288.266591][ T6390]  dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
kern.info kernel[  288.294016][ T6390]  ? __pfx_dev_deactivate+0x10/0x10 net/sched/sch_generic.c:1379
: [  288.077767][  288.306524][ T6390]  linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:175
[ T1024] bridge_[  288.317788][ T6390]  ? __pfx_ethtool_op_get_link+0x10/0x10 net/ethtool/ioctl.c:2712
slave_1: left pr[  288.325567][ T6390]  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
omiscuous mode
Nov 10 12:39:03 [  288.343169][ T6390]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
Nov 10 12:39:03 [  288.343169][ T6390]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
syzkaller kern.i[  288.349291][ T6390]  bond_miimon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
syzkaller kern.i[  288.349291][ T6390]  bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2939
nfo kernel: [  2[  288.355597][ T6390]  ? __pfx_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2806
88.084857][ T102[  288.362312][ T6390]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
88.084857][ T102[  288.362312][ T6390]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
4] bridge0: port[  288.368438][ T6390]  ? trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
 2(bridge_slave_[  288.374995][ T6390]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1) entered disab[  288.381473][ T6390]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5796
led state
Nov 1[  288.387339][ T6390]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
0 12:39:03 syzka[  288.393811][ T6390]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
ller kern.info k[  288.400191][ T6390]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
ernel: [  288.09[  288.407177][ T6390]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153
6288][ T1024] br[  288.413903][ T6390]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
idge_slave_0: le[  288.419841][ T6390]  process_scheduled_works kernel/workqueue.c:3310 [inline]
idge_slave_0: le[  288.419841][ T6390]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
ft allmulticast [  288.425789][ T6390]  ? __kthread_parkme+0x148/0x220 kernel/kthread.c:293
mode
Nov 10 12:[  288.432165][ T6390]  ? __pfx_worker_thread+0x10/0x10 include/linux/list.h:183
39:03 syzkaller [  288.438621][ T6390]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
kern.info kernel[  288.444056][ T6390]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
kern.info kernel[  288.444056][ T6390]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
: [  288.102240][  288.450635][ T6390]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
[ T1024] bridge_[  288.456575][ T6390]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
slave_0: left pr[  288.462342][ T6390]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
omiscuous mode
Nov 10 12:39:03 [  288.474403][ T6390]  </TASK>
syzkaller kern.info kernel: [  288.109768][ T1024] bridge0: port 1(bridge_slave_0) entered disabled state
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.119638][ T6390] 
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.122499][ T6390] =============================
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.128669][ T6390] WARNING: suspicious RCU usage
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.135316][ T6390] 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0 Not tainted
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.143732][ T6390] -----------------------------
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.149741][ T6390] net/sched/sch_generic.c:1290 suspicious rcu_dereference_protected() usage!
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.159834][ T6390] 
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.159834][ T6390] other i[  288.554806][ T6390] 
nfo that might h[  288.557452][ T6390] =============================
elp us debug thi[  288.563800][ T6390] WARNING: suspicious RCU usage
s:
Nov 10 12:39[  288.569953][ T6390] 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0 Not tainted
:03 syzkaller ke[  288.578320][ T6390] -----------------------------
rn.warn kernel: [  288.584563][ T6390] include/linux/rtnetlink.h:100 suspicious rcu_dereference_protected() usage!
[  288.159834][ [  288.594829][ T6390] 
T6390] 
Nov 10 [  288.606375][ T6390] 
12:39:03 syzkall[  288.615765][ T6390] 3 locks held by kworker/u8:11/6390:
er kern.warn ker[  288.622477][ T6390]  #0: ffff888068d0d948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
nel: [  288.1598[  288.634359][ T6390]  #1: ffffc9000b45fd80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
53][ T6390] 
No[  288.648370][ T6390]  #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
No[  288.648370][ T6390]  #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
No[  288.648370][ T6390]  #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2937
v 10 12:39:03 sy[  288.659388][ T6390] 
zkaller kern.war[  288.666145][ T6390] CPU: 0 UID: 0 PID: 6390 Comm: kworker/u8:11 Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
n kernel: [  288[  288.678441][ T6390] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
.159853][ T6390][  288.689857][ T6390] Workqueue: bond0 bond_mii_monitor
 rcu_scheduler_a[  288.696447][ T6390] Call Trace:
ctive = 2, debug[  288.701091][ T6390]  <TASK>
_locks = 1
Nov [  288.705382][ T6390]  __dump_stack lib/dump_stack.c:94 [inline]
Nov [  288.705382][ T6390]  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
10 12:39:03 syzk[  288.711414][ T6390]  lockdep_rcu_suspicious+0x210/0x3c0 kernel/locking/lockdep.c:6821
aller kern.warn [  288.718162][ T6390]  dev_ingress_queue include/linux/rtnetlink.h:100 [inline]
aller kern.warn [  288.718162][ T6390]  dev_deactivate_many+0x8af/0xb20 net/sched/sch_generic.c:1365
kernel: [  288.1[  288.724626][ T6390]  dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
59867][ T6390] 3[  288.730563][ T6390]  ? __pfx_dev_deactivate+0x10/0x10 net/sched/sch_generic.c:1379
 locks held by k[  288.737110][ T6390]  ? __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
worker/u8:11/639[  288.744357][ T6390]  linkwatch_do_dev+0x11e/0x160 net/core/link_watch.c:175
0:
Nov 10 12:39[  288.750557][ T6390]  linkwatch_sync_dev+0x181/0x210 net/core/link_watch.c:263
:03 syzkaller ke[  288.757536][ T6390]  ? __pfx_ethtool_op_get_link+0x10/0x10 net/ethtool/ioctl.c:2712
rn.warn kernel: [  288.764514][ T6390]  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
[  288.187464][ [  288.770824][ T6390]  bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
T6390]  #0: ffff[  288.777300][ T6390]  ? __pfx_bond_check_dev_link+0x10/0x10 drivers/net/bonding/bond_main.c:4594
888068d0d948 ((w[  288.784279][ T6390]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
888068d0d948 ((w[  288.784279][ T6390]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
q_completion)bon[  288.790404][ T6390]  bond_miimon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
q_completion)bon[  288.790404][ T6390]  bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2939
d0#2){+.+.}-{0:0[  288.796687][ T6390]  ? __pfx_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2806
}, at: process_o[  288.803415][ T6390]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
}, at: process_o[  288.803415][ T6390]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
ne_work+0x129b/0[  288.809527][ T6390]  ? trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
x1ba0
Nov 10 12[  288.816072][ T6390]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
:39:03 syzkaller[  288.822536][ T6390]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5796
 kern.warn kerne[  288.828383][ T6390]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
l: [  288.199531[  288.834848][ T6390]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
][ T6390]  #1: f[  288.841142][ T6390]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
fffc9000b45fd80 [  288.848115][ T6390]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153
((work_completio[  288.854844][ T6390]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
n)(&(&bond->mii_[  288.860781][ T6390]  process_scheduled_works kernel/workqueue.c:3310 [inline]
n)(&(&bond->mii_[  288.860781][ T6390]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
work)->work)){+.[  288.866722][ T6390]  ? __kthread_parkme+0x148/0x220 kernel/kthread.c:293
+.}-{0:0}, at: p[  288.873091][ T6390]  ? __pfx_worker_thread+0x10/0x10 include/linux/list.h:183
rocess_one_work+[  288.879551][ T6390]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
0x921/0x1ba0
No[  288.884966][ T6390]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
No[  288.884966][ T6390]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
v 10 12:39:03 sy[  288.891513][ T6390]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
zkaller kern.war[  288.897454][ T6390]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
n kernel: [  288[  288.903232][ T6390]  ? __pfx_kthread+0x10/0x10 include/linux/list.h:373
.212948][ T6390][  288.909177][ T6390]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
  #2: ffffffff8e[  288.915298][ T6390]  </TASK>
1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
1b8340 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2937
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.224119][ T6390] 
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.224119][ T6390] stack backtrace:
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.231359][ T6390] CPU: 0 UID: 0 PID: 6390 Comm: kworker/u8:11 Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.243643][ T6390] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.253707][ T6390] Workqueue: bond0 bond_mii_monitor
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.258910][ T6390] Call Trace:
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.263550][ T6390]  <TASK>
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.266487][ T6390]  __dump_stack lib/dump_stack.c:94 [inline]
Nov 10 12:39:03 syzkaller kern.warn kernel: [  288.266487][ T6390]  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
Nov 10 12:39:03 syzkall[  289.005277][ T6390] ==================================================================
er kern.warn ker[  289.083234][ T6390]  ? dev_deactivate_queue+0x17e/0x190 net/sched/sch_generic.c:1290
nel: [  288.2665[  289.083252][ T6390]  dev_deactivate_queue+0x17e/0x190 net/sched/sch_generic.c:1290
09][ T6390]  loc[  289.083269][ T6390]  netdev_for_each_tx_queue include/linux/netdevice.h:2504 [inline]
09][ T6390]  loc[  289.083269][ T6390]  dev_deactivate_many+0xe7/0xb20 net/sched/sch_generic.c:1363


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

