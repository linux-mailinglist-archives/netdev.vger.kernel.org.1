Return-Path: <netdev+bounces-145413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17BB9CF693
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B856B2B278
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A91E2835;
	Fri, 15 Nov 2024 21:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93751E2605
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704743; cv=none; b=Apab0hc78T09ISIc9Q1s59CG/w80NsUGyBOhEz4C1XOQyNYXvS6yaXBFF88C0osds+Qeua0tR4f54K7fJhL0/UxkDdKljnaSm/2+ibqlvg6EzlEwDqwBfF5g+FJ+0Rs0JPBb7AW01DRNUy9+ubqL2mGqd4pQtp2qy3nD2mPNKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704743; c=relaxed/simple;
	bh=t7Shf2W40c0vMfGShaTckrM/onShicQX3QBbfNNI1eU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IAef1643hoyT3ftCrfwdq9Vns+59GQ0JpMWJTgxNw6RqonILTUkmu5k3hggYR2zEEEX45j/QlJE6bift2E9ZRetLQxx5CajxgZY3R4+6Gzh1AE4U4X+AKGoTO1itVQeKf8QH6/D8EaD24Lx0q2MyGl5w8wPKKpzGSkFPNaI49xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ac79525b8so212128239f.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 13:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704739; x=1732309539;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFPvOF8Hd8JRqV8xE2Dh6av8Zbj2KHnyeLK3X4e7WJ4=;
        b=pGO/+fc++7PmPnLxVnYkyUkJQXp7w8nNVD1rbeVgV+agR9jLF4XVou5tubR7igokBH
         O1OLM7Rsk1tt2Igq4XOWL9BDoCGL2zlpLfmjSQrNPyAWyyfKDpFG8NWZIHkvpjmIlwFB
         42elWwgD3QUy4lfeDXJhAwlmeQk4C6utRfkfuXMdchUHVSBuD4gVMQ1b8q6V6Xgsq/Cz
         LBR78KFsFcMQiZ6gNDf4vALLxOijhJXDBMpbxwYjRLnhj8zaEb5+wl65q5zylOt48f5z
         WPKIjAC+ccnzjIPh+ttRzO50HaRJBclPr/DpazhZaL0O/mIClVnYhi0OuojReozdPJYA
         i5kg==
X-Forwarded-Encrypted: i=1; AJvYcCVBEAKLOCnrik+4IJvUQRVOGIsD8xUlIuToYCdHUyCw23XpC5V/B/uKGj4DwQYgLSMCOnHlT4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Z/HG2v3xF9KFH0H08Kp7/nmJmWcjMYBmHyDmUchYoFAEH800
	69rmQ3yaXV46igU0lW6wjvD2tG7p0xS7G0nAE0CsalW1D/IMtu16IrvxRKPYZt7CRrCR6q+IXoO
	tPzHS3jjdGN6AW/4/0HMOOAmhnX7FQRt6ILS5nfMVKUEUSfb9Q566M1c=
X-Google-Smtp-Source: AGHT+IFOjKaRnZ4sVjY0/ooGeEBB+bZg/L0lYo2LocI6byDn19V0TdrTXYpM3q+caHORvZSGDRY8BD7cl5G9e3gi5L/wXRtJjQoA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:3a5:e57c:58d4 with SMTP id
 e9e14a558f8ab-3a74808ea4dmr47776405ab.20.1731704738630; Fri, 15 Nov 2024
 13:05:38 -0800 (PST)
Date: Fri, 15 Nov 2024 13:05:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6737b7a2.050a0220.85a0.0004.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in on
From: syzbot <syzbot+917bd189260e9ec185fc@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1120d35f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D327b6119dd928cb=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D917bd189260e9ec18=
5fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bbbfa50cb5f/vmlinux-=
2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5bcdede1c8a/bzI=
mage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+917bd189260e9ec185fc@syzkaller.appspotmail.com

ce
Nov 11 21:02[   96.032192][    C1] bridge0: topology change detected, propa=
gating
:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL de[   96.0356=
15][ T6232]=20
vice
Nov 11 21:[   96.036689][ T6232] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
02:32 syzkaller [   96.038573][ T6232] WARNING: suspicious RCU usage
daemon.err dhcpc[   96.038591][ T6232] 6.12.0-rc7-syzkaller #0 Not tainted
d[5661]: libudev[   96.038621][ T6232] -----------------------------
: received NULL [   96.038627][ T6232] net/sched/sch_generic.c:1256 suspici=
ous rcu_dereference_protected() usage!
device
Nov 11 2[   96.049502][ T6232]=20
1:02:32 syzkalle[   96.053504][ T6232]=20
r daemon.err dhc[   96.053520][ T6232] 3 locks held by kworker/u32:32/6232:
pcd[5661]: libud[   96.053532][ T6232]  #0: ffff88804b8f2948 ((wq_completio=
n)bond0#3){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue=
.c:3204
ev: received NUL[   96.061723][ T6232]  #1: ffffc900033c7d80 ((work_complet=
ion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1=
ba0 kernel/workqueue.c:3205
L device
Nov 11 21:02:32 syzkal[   96.066284][ T6232]  #2: ffffffff8e1b8340 (rcu_rea=
d_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inl=
ine]
Nov 11 21:02:32 syzkal[   96.066284][ T6232]  #2: ffffffff8e1b8340 (rcu_rea=
d_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline=
]
Nov 11 21:02:32 syzkal[   96.066284][ T6232]  #2: ffffffff8e1b8340 (rcu_rea=
d_lock){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/=
bond_main.c:2937
ler daemon.err d[   96.070840][ T6232]=20
hcpcd[5661]: lib[   96.070871][ T6232] Hardware name: QEMU Standard PC (Q35=
 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
udev: received N[   96.070884][ T6232] Workqueue: bond0 bond_mii_monitor
ULL device
Nov [   96.082763][ T6232] Call Trace:
11 21:02:32 syzkaller daemon.errNov 11 21:02:32 syzkaller daemon.err dhcpcd=
[5661]: libudev: receNov 11 21:02:32 [   96.088151][ T6232]  __dump_stack l=
ib/dump_stack.c:94 [inline]
11 21:02:32 syzkaller daemon.errNov 11 21:02:32 syzkaller daemon.err dhcpcd=
[5661]: libudev: receNov 11 21:02:32 [   96.088151][ T6232]  dump_stack_lvl=
+0x16c/0x1f0 lib/dump_stack.c:120
syzkaller daemon[   96.090269][ T6232]  lockdep_rcu_suspicious+0x210/0x3c0 =
kernel/locking/lockdep.c:6821
.err dhcpcd[5661[   96.092560][ T6232]  dev_activate+0x457/0x12b0 net/sched=
/sch_generic.c:1256
]: libudev: rece[   96.094641][ T6232]  ? spin_unlock_irqrestore include/li=
nux/spinlock.h:406 [inline]
]: libudev: rece[   96.094641][ T6232]  ? linkwatch_sync_dev+0x179/0x210 ne=
t/core/link_watch.c:261
ived NULL device[   96.096940][ T6232]  ? __pfx_lock_release+0x10/0x10 kern=
el/locking/lockdep.c:5346

Nov 11 21:02:3[   96.096954][ T6232]  ? __pfx_dev_activate+0x10/0x10 net/sc=
hed/sch_generic.c:1016
2 syzkaller daem[   96.102894][ T6232]  linkwatch_do_dev+0x13d/0x160 net/co=
re/link_watch.c:173
on.err dhcpcd[56[   96.104843][ T6232]  linkwatch_sync_dev+0x181/0x210 net/=
core/link_watch.c:263
61]: libudev: re[   96.107045][ T6232]  ? __pfx_ethtool_op_get_link+0x10/0x=
10 net/ethtool/ioctl.c:2712
ceived NULL devi[   96.111265][ T6232]  bond_check_dev_link+0x197/0x490 dri=
vers/net/bonding/bond_main.c:873
ce
Nov 11 21:02[   96.113653][ T6232]  ? __pfx_bond_check_dev_link+0x10/0x10 d=
rivers/net/bonding/bond_main.c:4594
:32 syzkaller da[   96.113678][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
:32 syzkaller da[   96.113678][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
emon.err dhcpcd[[   96.117725][ T6232]  bond_miimon_inspect drivers/net/bon=
ding/bond_main.c:2717 [inline]
emon.err dhcpcd[[   96.117725][ T6232]  bond_mii_monitor+0x3c1/0x2d90 drive=
rs/net/bonding/bond_main.c:2939
5661]: libudev: [   96.119909][ T6232]  ? __pfx_bond_mii_monitor+0x10/0x10 =
drivers/net/bonding/bond_main.c:2806
received NULL de[   96.122254][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
received NULL de[   96.122254][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
vice
Nov 11 21:[   96.124595][ T6232]  ? trace_lock_acquire+0x14a/0x1d0 include/=
trace/events/lock.h:24
02:32 syzkaller [   96.124617][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205
daemon.err dhcpc[   96.130226][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205
d[5661]: libudev[   96.132210][ T6232]  process_one_work+0x9c5/0x1ba0 kerne=
l/workqueue.c:3229
: received NULL [   96.134128][ T6232]  ? __pfx_macvlan_process_broadcast+0=
x10/0x10 drivers/net/macvlan.c:309
device
Nov 11 2[   96.134151][ T6232]  ? __pfx_process_one_work+0x10/0x10 include/=
linux/list.h:153
1:02:32 syzkalle[   96.139713][ T6232]  process_scheduled_works kernel/work=
queue.c:3310 [inline]
1:02:32 syzkalle[   96.139713][ T6232]  worker_thread+0x6c8/0xf00 kernel/wo=
rkqueue.c:3391
r daemon.err dhc[   96.142406][ T6232]  kthread+0x2c1/0x3a0 kernel/kthread.=
c:389
pcd[5661]: libudev: received NULL device
Nov 11 21:02:32 syzkal[   96.145163][ T6232]  ? __pfx_kthread+0x10/0x10 inc=
lude/linux/list.h:373
ler daemon.err d[   96.145178][ T6232]  ret_from_fork+0x45/0x80 arch/x86/ke=
rnel/process.c:147
hcpcd[5661]: lib[   96.145188][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
udev: received N[   96.145219][ T6232]  </TASK>
ULL device
Nov [   96.145391][ T6232] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
11 21:02:32 syzk[   96.145405][ T6232] -----------------------------
aller daemon.err[   96.145416][ T6232]=20
 dhcpcd[5661]: l[   96.145420][ T6232]=20
ibudev: received[   96.145426][ T6232] 3 locks held by kworker/u32:32/6232:
 NULL device
No[   96.145433][ T6232]  #0: ffff88804b8f2948 ((wq_completion)bond0#3){+.+=
.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
v 11 21:02:32 sy[   96.145466][ T6232]  #1: ffffc900033c7d80 ((work_complet=
ion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1=
ba0 kernel/workqueue.c:3205
zkaller daemon.e[   96.145562][ T6232]=20
rr dhcpcd[5661]:[   96.145566][ T6232] CPU: 2 UID: 0 PID: 6232 Comm: kworke=
r/u32:32 Not tainted 6.12.0-rc7-syzkaller #0
 libudev: receiv[   96.145577][ T6232] Hardware name: QEMU Standard PC (Q35=
 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
ed NULL device
Nov 11 21:02:32 [   96.145598][ T6232] Call Trace:
syzkaller daemon[   96.145601][ T6232]  <TASK>
.err dhcpcd[5661[   96.145605][ T6232]  __dump_stack lib/dump_stack.c:94 [i=
nline]
.err dhcpcd[5661[   96.145605][ T6232]  dump_stack_lvl+0x16c/0x1f0 lib/dump=
_stack.c:120
]: libudev: rece[   96.145617][ T6232]  lockdep_rcu_suspicious+0x210/0x3c0 =
kernel/locking/lockdep.c:6821
ived NULL device[   96.145633][ T6232]  transition_one_qdisc+0x1d4/0x210 ne=
t/sched/sch_generic.c:1234

Nov 11 21:02:3[   96.145647][ T6232]  netdev_for_each_tx_queue include/linu=
x/netdevice.h:2504 [inline]
Nov 11 21:02:3[   96.145647][ T6232]  dev_activate+0x211/0x12b0 net/sched/s=
ch_generic.c:1264
2 syzkaller daem[   96.145661][ T6232]  ? __pfx_lock_release+0x10/0x10 kern=
el/locking/lockdep.c:5346
on.err dhcpcd[56[   96.145671][ T6232]  ? __pfx_dev_activate+0x10/0x10 net/=
sched/sch_generic.c:1016
61]: libudev: re[   96.145684][ T6232]  ? __sanitizer_cov_trace_switch+0x54=
/0x90 kernel/kcov.c:351
ceived NULL devi[   96.145701][ T6232]  linkwatch_do_dev+0x13d/0x160 net/co=
re/link_watch.c:173
ce
Nov 11 21:02[   96.145714][ T6232]  linkwatch_sync_dev+0x181/0x210 net/core=
/link_watch.c:263
:32 syzkaller da[   96.145727][ T6232]  ? __pfx_ethtool_op_get_link+0x10/0x=
10 net/ethtool/ioctl.c:2712
emon.err dhcpcd[[   96.145737][ T6232]  ethtool_op_get_link+0x1d/0x70 net/e=
thtool/ioctl.c:62
5661]: libudev: [   96.145746][ T6232]  bond_check_dev_link+0x197/0x490 dri=
vers/net/bonding/bond_main.c:873
received NULL de[   96.145758][ T6232]  ? __pfx_bond_check_dev_link+0x10/0x=
10 drivers/net/bonding/bond_main.c:4594
vice
Nov 11 21:[   96.145769][ T6232]  ? rcu_is_watching_curr_cpu include/linux/=
context_tracking.h:128 [inline]
Nov 11 21:[   96.145769][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tr=
ee.c:737
02:32 syzkaller [   96.145787][ T6232]  bond_miimon_inspect drivers/net/bon=
ding/bond_main.c:2717 [inline]
02:32 syzkaller [   96.145787][ T6232]  bond_mii_monitor+0x3c1/0x2d90 drive=
rs/net/bonding/bond_main.c:2939
daemon.err dhcpc[   96.145803][ T6232]  ? __pfx_bond_mii_monitor+0x10/0x10 =
drivers/net/bonding/bond_main.c:2806
d[5661]: libudev[   96.145816][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
d[5661]: libudev[   96.145816][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
: received NULL [   96.145827][ T6232]  ? trace_lock_acquire+0x14a/0x1d0 in=
clude/trace/events/lock.h:24
device
Nov 11 2[   96.145839][ T6232]  ? process_one_work+0x921/0x1ba0 kernel/work=
queue.c:3205
1:02:32 syzkalle[   96.145850][ T6232]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5796
r daemon.err dhc[   96.145858][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205
pcd[5661]: libud[   96.145869][ T6232]  process_one_work+0x9c5/0x1ba0 kerne=
l/workqueue.c:3229
ev: received NUL[   96.145882][ T6232]  ? __pfx_macvlan_process_broadcast+0=
x10/0x10 drivers/net/macvlan.c:309
L device
Nov 11[   96.145894][ T6232]  ? __pfx_process_one_work+0x10/0x10 include/li=
nux/list.h:153
 21:02:32 syzkal[   96.145907][ T6232]  ? assign_work+0x1a0/0x250 kernel/wo=
rkqueue.c:1200
ler daemon.err d[   96.145922][ T6232]  process_scheduled_works kernel/work=
queue.c:3310 [inline]
ler daemon.err d[   96.145922][ T6232]  worker_thread+0x6c8/0xf00 kernel/wo=
rkqueue.c:3391
hcpcd[5661]: lib[   96.145937][ T6232]  ? __pfx_worker_thread+0x10/0x10 inc=
lude/linux/list.h:183
udev: received N[   96.145946][ T6232]  kthread+0x2c1/0x3a0 kernel/kthread.=
c:389
ULL device
Nov [   96.145957][ T6232]  ? __raw_spin_unlock_irq include/linux/spinlock_=
api_smp.h:159 [inline]
Nov [   96.145957][ T6232]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking=
/spinlock.c:202
11 21:02:32 syzk[   96.145969][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
aller daemon.err[   96.145981][ T6232]  ret_from_fork+0x45/0x80 arch/x86/ke=
rnel/process.c:147
 dhcpcd[5661]: l[   96.145990][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
ibudev: received[   96.146001][ T6232]  ret_from_fork_asm+0x1a/0x30 arch/x8=
6/entry/entry_64.S:244
 NULL device
No[   96.146020][ T6232]  </TASK>
v 11 21:02:32 sy[   96.146025][ T6232]=20
zkaller daemon.e[   96.146028][ T6232] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rr dhcpcd[5661]:[   96.146031][ T6232] WARNING: suspicious RCU usage
 libudev: receiv[   96.146034][ T6232] 6.12.0-rc7-syzkaller #0 Not tainted
ed NULL device
Nov 11 21:02:32 [   96.146043][ T6232] include/linux/rtnetlink.h:100 suspic=
ious rcu_dereference_protected() usage!
syzkaller daemon[   96.146050][ T6232]=20
.err dhcpcd[5661[   96.146053][ T6232]=20
]: libudev: rece[   96.146060][ T6232] 3 locks held by kworker/u32:32/6232:
ived NULL device[   96.146066][ T6232]  #0: ffff88804b8f2948 ((wq_completio=
n)bond0#3){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue=
.c:3204

Nov 11 21:02:3[   96.146095][ T6232]  #1: ffffc900033c7d80 ((work_completio=
n)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba=
0 kernel/workqueue.c:3205
2 syzkaller daem[   96.146122][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
2 syzkaller daem[   96.146122][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
2 syzkaller daem[   96.146122][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_m=
ain.c:2937
on.err dhcpcd[56[   96.146151][ T6232]=20
61]: libudev: re[   96.146155][ T6232] CPU: 2 UID: 0 PID: 6232 Comm: kworke=
r/u32:32 Not tainted 6.12.0-rc7-syzkaller #0
ceived NULL devi[   96.146165][ T6232] Hardware name: QEMU Standard PC (Q35=
 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
ce
Nov 11 21:02[   96.146171][ T6232] Workqueue: bond0 bond_mii_monitor
:32 syzkaller da[   96.146184][ T6232] Call Trace:
emon.err dhcpcd[[   96.146187][ T6232]  <TASK>
5661]: libudev: [   96.146191][ T6232]  __dump_stack lib/dump_stack.c:94 [i=
nline]
5661]: libudev: [   96.146191][ T6232]  dump_stack_lvl+0x16c/0x1f0 lib/dump=
_stack.c:120
received NULL de[   96.146201][ T6232]  lockdep_rcu_suspicious+0x210/0x3c0 =
kernel/locking/lockdep.c:6821
vice
Nov 11 21:[   96.146216][ T6232]  dev_ingress_queue include/linux/rtnetlink=
.h:100 [inline]
Nov 11 21:[   96.146216][ T6232]  dev_activate+0x7eb/0x12b0 net/sched/sch_g=
eneric.c:1265
02:32 syzkaller [   96.146230][ T6232]  ? __pfx_lock_release+0x10/0x10 kern=
el/locking/lockdep.c:5346
daemon.err dhcpc[   96.146239][ T6232]  ? __pfx_dev_activate+0x10/0x10 net/=
sched/sch_generic.c:1016
d[5661]: libudev[   96.146253][ T6232]  ? __sanitizer_cov_trace_switch+0x54=
/0x90 kernel/kcov.c:351
: received NULL [   96.146270][ T6232]  linkwatch_do_dev+0x13d/0x160 net/co=
re/link_watch.c:173
device
Nov 11 2[   96.146282][ T6232]  linkwatch_sync_dev+0x181/0x210 net/core/lin=
k_watch.c:263
1:02:32 syzkalle[   96.146295][ T6232]  ? __pfx_ethtool_op_get_link+0x10/0x=
10 net/ethtool/ioctl.c:2712
r daemon.err dhc[   96.146304][ T6232]  ethtool_op_get_link+0x1d/0x70 net/e=
thtool/ioctl.c:62
pcd[5661]: libud[   96.146313][ T6232]  bond_check_dev_link+0x197/0x490 dri=
vers/net/bonding/bond_main.c:873
ev: received NUL[   96.146325][ T6232]  ? __pfx_bond_check_dev_link+0x10/0x=
10 drivers/net/bonding/bond_main.c:4594
L device
Nov 11[   96.146336][ T6232]  ? rcu_is_watching_curr_cpu include/linux/cont=
ext_tracking.h:128 [inline]
Nov 11[   96.146336][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c=
:737
 21:02:32 syzkal[   96.146352][ T6232]  bond_miimon_inspect drivers/net/bon=
ding/bond_main.c:2717 [inline]
 21:02:32 syzkal[   96.146352][ T6232]  bond_mii_monitor+0x3c1/0x2d90 drive=
rs/net/bonding/bond_main.c:2939
ler daemon.err d[   96.146369][ T6232]  ? __pfx_bond_mii_monitor+0x10/0x10 =
drivers/net/bonding/bond_main.c:2806
hcpcd[5661]: lib[   96.146385][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
hcpcd[5661]: lib[   96.146385][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
udev: received N[   96.146396][ T6232]  ? trace_lock_acquire+0x14a/0x1d0 in=
clude/trace/events/lock.h:24
ULL device
Nov [   96.146408][ T6232]  ? process_one_work+0x921/0x1ba0 kernel/workqueu=
e.c:3205
11 21:02:32 syzk[   96.146418][ T6232]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5796
aller daemon.err[   96.146427][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205
 dhcpcd[5661]: l[   96.146437][ T6232]  process_one_work+0x9c5/0x1ba0 kerne=
l/workqueue.c:3229
ibudev: received[   96.146451][ T6232]  ? __pfx_macvlan_process_broadcast+0=
x10/0x10 drivers/net/macvlan.c:309
 NULL device
No[   96.146461][ T6232]  ? __pfx_process_one_work+0x10/0x10 include/linux/=
list.h:153
v 11 21:02:32 sy[   96.146474][ T6232]  ? assign_work+0x1a0/0x250 kernel/wo=
rkqueue.c:1200
zkaller daemon.e[   96.146489][ T6232]  process_scheduled_works kernel/work=
queue.c:3310 [inline]
zkaller daemon.e[   96.146489][ T6232]  worker_thread+0x6c8/0xf00 kernel/wo=
rkqueue.c:3391
rr dhcpcd[5661]:[   96.146503][ T6232]  ? __pfx_worker_thread+0x10/0x10 inc=
lude/linux/list.h:183
 libudev: receiv[   96.146513][ T6232]  kthread+0x2c1/0x3a0 kernel/kthread.=
c:389
ed NULL device
Nov 11 21:02:32 [   96.146536][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
syzkaller daemon[   96.146547][ T6232]  ret_from_fork+0x45/0x80 arch/x86/ke=
rnel/process.c:147
.err dhcpcd[5661[   96.146555][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
]: libudev: rece[   96.146567][ T6232]  ret_from_fork_asm+0x1a/0x30 arch/x8=
6/entry/entry_64.S:244
ived NULL device[   96.146585][ T6232]  </TASK>

Nov 11 21:02:32 syzkaller daem[   96.333328][ T6232] BUG: sleeping function=
 called from invalid context at kernel/locking/rwsem.c:1523
on.err dhcpcd[56[   96.335759][ T6232] in_atomic(): 0, irqs_disabled(): 0, =
non_block: 0, pid: 6232, name: kworker/u32:32
61]: libudev: re[   96.338277][ T6232] preempt_count: 0, expected: 0
ceived NULL devi[   96.339800][ T6232] RCU nest depth: 1, expected: 0
ce
Nov 11 21:02[   96.341338][ T6232] 3 locks held by kworker/u32:32/6232:
:32 syzkaller da[   96.342995][ T6232]  #0: ffff88804b8f2948 ((wq_completio=
n)bond0#3){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue=
.c:3204
emon.err dhcpcd[[   96.345823][ T6232]  #1: ffffc900033c7d80 ((work_complet=
ion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1=
ba0 kernel/workqueue.c:3205
5661]: libudev: [   96.348943][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
5661]: libudev: [   96.348943][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
5661]: libudev: [   96.348943][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_m=
ain.c:2937
received NULL de[   96.351636][ T6232] CPU: 2 UID: 0 PID: 6232 Comm: kworke=
r/u32:32 Not tainted 6.12.0-rc7-syzkaller #0
vice
Nov 11 21:[   96.354069][ T6232] Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
02:32 syzkaller [   96.356965][ T6232] Workqueue: bond0 bond_mii_monitor
daemon.err dhcpc[   96.359016][ T6232] Call Trace:
d[5661]: libudev[   96.360510][ T6232]  <TASK>
: received NULL [   96.361644][ T6232]  __dump_stack lib/dump_stack.c:94 [i=
nline]
: received NULL [   96.361644][ T6232]  dump_stack_lvl+0x16c/0x1f0 lib/dump=
_stack.c:120
device
Nov 11 2[   96.363142][ T6232]  __might_resched+0x3c0/0x5e0 kernel/sched/co=
re.c:8653
1:02:32 syzkalle[   96.364728][ T6232]  ? __pfx___might_resched+0x10/0x10 k=
ernel/sched/core.c:5828
r daemon.err dhc[   96.366340][ T6232]  down_read+0x73/0x330 kernel/locking=
/rwsem.c:1523
pcd[5661]: libud[   96.367925][ T6232]  ? __pfx_down_read+0x10/0x10
ev: received NUL[   96.369905][ T6232]  ? dev_map_notification+0x6a/0xaf0 k=
ernel/bpf/devmap.c:1153
L device
Nov 11[   96.371941][ T6232]  ? __sanitizer_cov_trace_switch+0x54/0x90 kern=
el/kcov.c:351
 21:02:32 syzkal[   96.373845][ T6232]  wireless_nlevent_flush+0x1b/0x100 n=
et/wireless/wext-core.c:351
ler daemon.err d[   96.375498][ T6232]  wext_netdev_notifier_call+0xe/0x20 =
net/wireless/wext-core.c:371
hcpcd[5661]: lib[   96.377128][ T6232]  notifier_call_chain+0xb9/0x410 kern=
el/notifier.c:93
udev: received N[   96.378697][ T6232]  ? __pfx_wext_netdev_notifier_call+0=
x10/0x10 net/wireless/wext-core.c:352
ULL device
Nov [   96.380780][ T6232]  call_netdevice_notifiers_info+0xbe/0x140 net/co=
re/dev.c:1996
11 21:02:32 syzk[   96.382471][ T6232]  netdev_state_change net/core/dev.c:=
1378 [inline]
11 21:02:32 syzk[   96.382471][ T6232]  netdev_state_change+0x115/0x150 net=
/core/dev.c:1371
aller daemon.err[   96.383984][ T6232]  ? __pfx_netdev_state_change+0x10/0x=
10 include/net/net_namespace.h:383
 dhcpcd[5661]: l[   96.385693][ T6232]  ? __sanitizer_cov_trace_switch+0x54=
/0x90 kernel/kcov.c:351
ibudev: received[   96.387526][ T6232]  linkwatch_do_dev+0x12b/0x160 net/co=
re/link_watch.c:177
 NULL device
No[   96.389577][ T6232]  linkwatch_sync_dev+0x181/0x210 net/core/link_watc=
h.c:263
v 11 21:02:32 sy[   96.391355][ T6232]  ? __pfx_ethtool_op_get_link+0x10/0x=
10 net/ethtool/ioctl.c:2712
zkaller daemon.e[   96.393047][ T6232]  ethtool_op_get_link+0x1d/0x70 net/e=
thtool/ioctl.c:62
rr dhcpcd[5661]:[   96.394857][ T6232]  bond_check_dev_link+0x197/0x490 dri=
vers/net/bonding/bond_main.c:873
 libudev: receiv[   96.396472][ T6232]  ? __pfx_bond_check_dev_link+0x10/0x=
10 drivers/net/bonding/bond_main.c:4594
ed NULL device
Nov 11 21:02:32 [   96.399965][ T6232]  bond_miimon_inspect drivers/net/bon=
ding/bond_main.c:2717 [inline]
Nov 11 21:02:32 [   96.399965][ T6232]  bond_mii_monitor+0x3c1/0x2d90 drive=
rs/net/bonding/bond_main.c:2939
syzkaller daemon[   96.401543][ T6232]  ? __pfx_bond_mii_monitor+0x10/0x10 =
drivers/net/bonding/bond_main.c:2806
.err dhcpcd[5661[   96.403142][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
.err dhcpcd[5661[   96.403142][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
]: libudev: rece[   96.404629][ T6232]  ? trace_lock_acquire+0x14a/0x1d0 in=
clude/trace/events/lock.h:24
ived NULL device[   96.406212][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205

Nov 11 21:02:3[   96.407857][ T6232]  ? lock_acquire+0x2f/0xb0 kernel/locki=
ng/lockdep.c:5796
2 syzkaller daem[   96.409307][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205
on.err dhcpcd[56[   96.410910][ T6232]  process_one_work+0x9c5/0x1ba0 kerne=
l/workqueue.c:3229
61]: libudev: re[   96.412468][ T6232]  ? __pfx_macvlan_process_broadcast+0=
x10/0x10 drivers/net/macvlan.c:309
ceived NULL devi[   96.414179][ T6232]  ? __pfx_process_one_work+0x10/0x10 =
include/linux/list.h:153
ce
Nov 11 21:02[   96.415769][ T6232]  ? assign_work+0x1a0/0x250 kernel/workqu=
eue.c:1200
:32 syzkaller da[   96.417321][ T6232]  process_scheduled_works kernel/work=
queue.c:3310 [inline]
:32 syzkaller da[   96.417321][ T6232]  worker_thread+0x6c8/0xf00 kernel/wo=
rkqueue.c:3391
emon.err dhcpcd[[   96.418756][ T6232]  ? __pfx_worker_thread+0x10/0x10 inc=
lude/linux/list.h:183
5661]: libudev: [   96.420279][ T6232]  kthread+0x2c1/0x3a0 kernel/kthread.=
c:389
received NULL de[   96.421514][ T6232]  ? __raw_spin_unlock_irq include/lin=
ux/spinlock_api_smp.h:159 [inline]
received NULL de[   96.421514][ T6232]  ? _raw_spin_unlock_irq+0x23/0x50 ke=
rnel/locking/spinlock.c:202
vice
Nov 11 21:[   96.423050][ T6232]  ? __pfx_kthread+0x10/0x10 include/linux/l=
ist.h:373
02:32 syzkaller [   96.424425][ T6232]  ret_from_fork+0x45/0x80 arch/x86/ke=
rnel/process.c:147
daemon.err dhcpc[   96.425840][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
d[5661]: libudev[   96.427212][ T6232]  ret_from_fork_asm+0x1a/0x30 arch/x8=
6/entry/entry_64.S:244
: received NULL [   96.428635][ T6232]  </TASK>
device
Nov 11 2[   96.429829][ T6232]=20
1:02:32 syzkalle[   96.430587][ T6232] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
r daemon.err dhc[   96.432112][ T6232] [ BUG: Invalid wait context ]
pcd[5661]: libud[   96.433560][ T6232] 6.12.0-rc7-syzkaller #0 Tainted: G  =
      W        =20
ev: received NUL[   96.435434][ T6232] -----------------------------
L device
Nov 11[   96.436843][ T6232] kworker/u32:32/6232 is trying to lock:
 21:02:32 syzkal[   96.438550][ T6232] ffffffff8fecdad0 (net_rwsem){++++}-{=
3:3}, at: wireless_nlevent_flush+0x1b/0x100 net/wireless/wext-core.c:351
ler daemon.err d[   96.440935][ T6232] other info that might help us debug =
this:
hcpcd[5661]: lib[   96.442701][ T6232] context-{4:4}
udev: received N[   96.443914][ T6232] 3 locks held by kworker/u32:32/6232:
ULL device
Nov [   96.445534][ T6232]  #0: ffff88804b8f2948 ((wq_completion)bond0#3){+=
.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
11 21:02:32 syzk[   96.448198][ T6232]  #1: ffffc900033c7d80 ((work_complet=
ion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1=
ba0 kernel/workqueue.c:3205
aller daemon.err[   96.451227][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
aller daemon.err[   96.451227][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
aller daemon.err[   96.451227][ T6232]  #2: ffffffff8e1b8340 (rcu_read_lock=
){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_m=
ain.c:2937
 dhcpcd[5661]: l[   96.453823][ T6232] stack backtrace:
ibudev: received[   96.455014][ T6232] CPU: 2 UID: 0 PID: 6232 Comm: kworke=
r/u32:32 Tainted: G        W          6.12.0-rc7-syzkaller #0
 NULL device
No[   96.457827][ T6232] Tainted: [W]=3DWARN
v 11 21:02:32 sy[   96.459117][ T6232] Hardware name: QEMU Standard PC (Q35=
 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
zkaller daemon.e[   96.461987][ T6232] Workqueue: bond0 bond_mii_monitor
rr dhcpcd[5661]:[   96.463607][ T6232] Call Trace:
 libudev: receiv[   96.464778][ T6232]  <TASK>
ed NULL device
Nov 11 21:02:32 [   96.467375][ T6232]  print_lock_invalid_wait_context ker=
nel/locking/lockdep.c:4802 [inline]
Nov 11 21:02:32 [   96.467375][ T6232]  check_wait_context kernel/locking/l=
ockdep.c:4874 [inline]
Nov 11 21:02:32 [   96.467375][ T6232]  __lock_acquire+0x13db/0x3ce0 kernel=
/locking/lockdep.c:5152
syzkaller daemon[   96.468900][ T6232]  ? mark_held_locks+0x9f/0xe0 kernel/=
locking/lockdep.c:4321
.err dhcpcd[5661[   96.470608][ T6232]  ? __pfx___lock_acquire+0x10/0x10 ke=
rnel/locking/lockdep.c:4387
]: libudev: rece[   96.472353][ T6232]  ? irqentry_exit+0x3b/0x90 kernel/en=
try/common.c:357
ived NULL device[   96.473939][ T6232]  ? lockdep_hardirqs_on+0x7c/0x110 ke=
rnel/locking/lockdep.c:4468

Nov 11 21:02:3[   96.475727][ T6232]  lock_acquire.part.0+0x11b/0x380 kerne=
l/locking/lockdep.c:5825
2 syzkaller daem[   96.477482][ T6232]  ? wireless_nlevent_flush+0x1b/0x100=
 net/wireless/wext-core.c:351
on.err dhcpcd[56[   96.479319][ T6232]  ? __pfx_lock_acquire.part.0+0x10/0x=
10 kernel/locking/lockdep.c:122
61]: libudev: re[   96.481159][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
61]: libudev: re[   96.481159][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
ceived NULL devi[   96.482838][ T6232]  ? trace_lock_acquire+0x14a/0x1d0 in=
clude/trace/events/lock.h:24
ce
Nov 11 21:02[   96.484636][ T6232]  ? __might_resched+0x3cc/0x5e0 kernel/sc=
hed/core.c:8654
:32 syzkaller da[   96.486190][ T6232]  ? wireless_nlevent_flush+0x1b/0x100=
 net/wireless/wext-core.c:351
emon.err dhcpcd[[   96.487877][ T6232]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5796
5661]: libudev: [   96.489445][ T6232]  ? wireless_nlevent_flush+0x1b/0x100=
 net/wireless/wext-core.c:351
received NULL de[   96.491234][ T6232]  down_read+0x9a/0x330 kernel/locking=
/rwsem.c:1524
vice
Nov 11 21:[   96.492596][ T6232]  ? wireless_nlevent_flush+0x1b/0x100 net/w=
ireless/wext-core.c:351
02:32 syzkaller [   96.494426][ T6232]  ? __pfx_down_read+0x10/0x10
daemon.err dhcpc[   96.496124][ T6232]  ? dev_map_notification+0x6a/0xaf0 k=
ernel/bpf/devmap.c:1153
d[5661]: libudev[   96.498338][ T6232]  ? __sanitizer_cov_trace_switch+0x54=
/0x90 kernel/kcov.c:351
: received NULL [   96.500581][ T6232]  wireless_nlevent_flush+0x1b/0x100 n=
et/wireless/wext-core.c:351
device
Nov 11 2[   96.502354][ T6232]  wext_netdev_notifier_call+0xe/0x20 net/wire=
less/wext-core.c:371
1:02:32 syzkalle[   96.504180][ T6232]  notifier_call_chain+0xb9/0x410 kern=
el/notifier.c:93
r daemon.err dhc[   96.505918][ T6232]  ? __pfx_wext_netdev_notifier_call+0=
x10/0x10 net/wireless/wext-core.c:352
pcd[5661]: libud[   96.508156][ T6232]  call_netdevice_notifiers_info+0xbe/=
0x140 net/core/dev.c:1996
ev: received NUL[   96.510059][ T6232]  netdev_state_change net/core/dev.c:=
1378 [inline]
ev: received NUL[   96.510059][ T6232]  netdev_state_change+0x115/0x150 net=
/core/dev.c:1371
L device
Nov 11[   96.511811][ T6232]  ? __pfx_netdev_state_change+0x10/0x10 include=
/net/net_namespace.h:383
 21:02:32 syzkal[   96.513492][ T6232]  ? __sanitizer_cov_trace_switch+0x54=
/0x90 kernel/kcov.c:351
ler daemon.err d[   96.515426][ T6232]  linkwatch_do_dev+0x12b/0x160 net/co=
re/link_watch.c:177
hcpcd[5661]: lib[   96.517111][ T6232]  linkwatch_sync_dev+0x181/0x210 net/=
core/link_watch.c:263
udev: received N[   96.518862][ T6232]  ? __pfx_ethtool_op_get_link+0x10/0x=
10 net/ethtool/ioctl.c:2712
ULL device
Nov [   96.520713][ T6232]  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl=
.c:62
11 21:02:32 syzk[   96.522257][ T6232]  bond_check_dev_link+0x197/0x490 dri=
vers/net/bonding/bond_main.c:873
aller daemon.err[   96.523862][ T6232]  ? __pfx_bond_check_dev_link+0x10/0x=
10 drivers/net/bonding/bond_main.c:4594
 dhcpcd[5661]: l[   96.525553][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
 dhcpcd[5661]: l[   96.525553][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
ibudev: received[   96.527071][ T6232]  bond_miimon_inspect drivers/net/bon=
ding/bond_main.c:2717 [inline]
ibudev: received[   96.527071][ T6232]  bond_mii_monitor+0x3c1/0x2d90 drive=
rs/net/bonding/bond_main.c:2939
 NULL device
No[   96.528841][ T6232]  ? __pfx_bond_mii_monitor+0x10/0x10 drivers/net/bo=
nding/bond_main.c:2806
v 11 21:02:32 sy[   96.530573][ T6232]  ? rcu_is_watching_curr_cpu include/=
linux/context_tracking.h:128 [inline]
v 11 21:02:32 sy[   96.530573][ T6232]  ? rcu_is_watching+0x12/0xc0 kernel/=
rcu/tree.c:737
zkaller daemon.e[   96.532252][ T6232]  ? trace_lock_acquire+0x14a/0x1d0 in=
clude/trace/events/lock.h:24
rr dhcpcd[5661]:[   96.533854][ T6232]  ? process_one_work+0x921/0x1ba0 ker=
nel/workqueue.c:3205
 libudev: receiv[   96.535566][ T6232]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5796
ed NULL device
Nov 11 21:02:32 [   96.538918][ T6232]  process_one_work+0x9c5/0x1ba0 kerne=
l/workqueue.c:3229
syzkaller daemon[   96.540589][ T6232]  ? __pfx_macvlan_process_broadcast+0=
x10/0x10 drivers/net/macvlan.c:309
.err dhcpcd[5661[   96.542543][ T6232]  ? __pfx_process_one_work+0x10/0x10 =
include/linux/list.h:153
]: libudev: rece[   96.544227][ T6232]  ? assign_work+0x1a0/0x250 kernel/wo=
rkqueue.c:1200
ived NULL device[   96.545695][ T6232]  process_scheduled_works kernel/work=
queue.c:3310 [inline]
ived NULL device[   96.545695][ T6232]  worker_thread+0x6c8/0xf00 kernel/wo=
rkqueue.c:3391

Nov 11 21:02:3[   96.547183][ T6232]  ? __pfx_worker_thread+0x10/0x10 inclu=
de/linux/list.h:183
2 syzkaller daem[   96.548759][ T6232]  kthread+0x2c1/0x3a0 kernel/kthread.=
c:389
on.err dhcpcd[56[   96.550159][ T6232]  ? __raw_spin_unlock_irq include/lin=
ux/spinlock_api_smp.h:159 [inline]
on.err dhcpcd[56[   96.550159][ T6232]  ? _raw_spin_unlock_irq+0x23/0x50 ke=
rnel/locking/spinlock.c:202
61]: libudev: re[   96.551902][ T6232]  ? __pfx_kthread+0x10/0x10 include/l=
inux/list.h:373
ceived NULL devi[   96.553553][ T6232]  ret_from_fork+0x45/0x80 arch/x86/ke=
rnel/process.c:147
ce
Nov 11 21:02[   96.555156][ T6232]  ? __pfx_kthread+0x10/0x10 include/linux=
/list.h:373
:32 syzkaller da[   96.556740][ T6232]  ret_from_fork_asm+0x1a/0x30 arch/x8=
6/entry/entry_64.S:244
emon.err dhcpcd[[   96.558272][ T6232]  </TASK>
5661]: libudev: received NULL device
Nov 11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov [   96.567245][ T6232] bond0: (slave bridge0): link status up, enabling=
 it in 4 ms
11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL devic=
e
Nov 11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:32 syzkaller kern.info kernel: [   96.025634][    C1] bridge0:=
 port 2(bridge_slave_1) entered forwarding state
Nov 11 21:02:32 syzkaller kern.info kernel: [   96.027878][    C1] bridge0:=
 topology change detected, propagating
Nov 11 21:02:32 syzkaller kern.info kernel: [   96.030078][    C1] bridge0:=
 port[   96.585912][ T6232] bond0: (slave bridge0): link status up, enablin=
g it in 4 ms
 1(bridge_slave_0) entered forwarding state
Nov 11 21:02:32 syzkaller kern.info kernel: [   96.032192][    C1] bridge0:=
 topology change detected, propagating
Nov 11 21:02:32 syzkaller kern.warn kernel: [   96.035615][ T6232]=20
Nov 11 21:02:32 syzkaller kern.warn kernel: [   96.036689][ T6232] =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Nov 11 21:02:32 syzkaller kern.warn kernel: [   96.038573][ T6232] WARNING:=
 suspicious RCU usage
Nov 11 21:02:32 syzkaller kern.warn kernel: [   96.038591][ T6232] 6.12.0-r=
c7-syzkaller[   96.605864][ T6232] bond0: (slave bridge0): link status up, =
enabling it in 4 ms
 #0 Not tainted
Nov 11 21:02:32 syzkaller kern.warn kernel: [   96.038621][ T6232] --------=
---------------------
Nov 11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:32 syzkaller kern.warn kernel: [   96.038627][ T6232] net/sche=
d/sch_generic.c:1256 suspicious rcu_dereference_protected() usage!
Nov 11 21:02:32 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.049502][ T6232]=20
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.049502][ T6232] other in=
fo that might help us debug this:
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.049502][ T6232]=20
Nov 11 [   96.625731][ T1133] bond0: (slave bridge0): link status up, enabl=
ing it in 4 ms
21:02:33 syzkaller kern.warn kernel: [   96.053504][ T6232]=20
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.053504][ T6232] rcu_sche=
duler_active =3D 2, debug_locks =3D 1
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.053520][ T6232] 3 locks =
held by kworker/u32:32/6232:
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.053532][ T6232]  #0: fff=
f88804b8f2948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work+0x=
129b/0x1ba0 kernel/workqueue.c:3204
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.061723][ T6232]  #1: fff=
fc900033c7d80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at=
: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.066284][ T6232]  #2: fff=
fffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/lin=
ux/rcupdate.h:337 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.066284][ T6232]  #2: fff=
fffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/=
rcupdate.h:849 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.066284][ T6232]  #2: fff=
fffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d9=
0 drivers/net/bonding/bond_main.c:2937
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.070840][ T6232]=20
Nov 11 21:02:33[   96.662826][   T77] bond0: (slave bridge0): link status u=
p, enabling it in 4 ms
 syzkaller kern.warn kernel: [   96.070840][ T6232] stack backtrace:
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.070852][ T6232] CPU: 2 U=
ID: 0 PID: 6232 Comm: kworker/u32:32 Not tainted 6.12.0-rc7-syzkaller #0
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.070871][ T6232] Hardware=
 name: QEMU Standard PC (Q[   96.675998][   T77] bond0: (slave bridge0): li=
nk status up, enabling it in 4 ms
35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.070884][ T6232] Workqueu=
e: bond0 bond_mii_monitor
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.082763][ T6232] Call Tra=
ce:
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.084507][ T6232]  <TASK>
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.088151][ T6232]  __dump_=
stack lib/dump_stack.c:94 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.088151][ T6232]  dump_st=
ack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.090269][ T6232]  lockdep=
_rcu_suspicious+0[   96.695552][   T77] bond0: (slave bridge0): link status=
 up, enabling it in 4 ms
x210/0x3c0
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.092560][ T6232]  dev_act=
ivate+0x457/0x12b0 net/sched/sch_generic.c:1256
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.094641][ T6232]  ? spin_=
unlock_irqrestore include/linux/spinlock.h:406 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.094641][ T6232]  ? linkw=
atch_sync_dev+0x179/0x210 net/core/link_watch.c:261
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.096940][ T6232]  ? __pfx=
_lock_release+0x10/0x10 kernel/locking/lockdep.c:5346
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.096954][ T6232]  ? __pfx=
_dev_activate+0x10/0x10 net/sched/sch_generic.c:1016
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.096969][ T6232]  ? __san=
itizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.102894][ T6232]  linkw[ =
  96.715869][   T77] bond0: (slave bridge0): link status up, enabling it in=
 4 ms
atch_do_dev+0x13d/0x160
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.104843][ T6232]  linkwat=
ch_sync_dev+0x181/0x210 net/core/link_watch.c:263
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.107045][ T6232]  ? __pfx=
_ethtool_op_get_link+0x10/0x10 net/ethtool/ioctl.c:2712
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.109510][ T6232]  ethtool=
_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.111265][ T6232]  bond_ch=
eck_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.113653][ T6232]  ? __pfx=
_bond_check_dev_link+0x10/0x10 drivers/net/bonding/bond_main.c:4594
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.113678][ T6232]  ? rcu_i=
s_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.113678][ T6232]  ? rcu_i=
s_watching+0x12/0xc0 kernel/rcu/tree.c:737
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.117725][ T6232]  bond_mi=
imon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.117725][ T6232]  bond_mi=
i_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2939
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.119909][ T6232]  ? __pfx=
_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2806
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.122254][ T6232]  ? rcu_i=
s_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.122254][ T6232]  ? rcu_i=
s_watching+0x12/0xc0 kernel/rcu/tree.c:737
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.124595][ T6232]  ? trace=
_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.124617][ T6232]  ? proce=
ss_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.124632][ T6232]  ? lock_=
acquire+0x2f/0xb0 kernel/locking/lockdep.c:5796
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.130226][ T6232]  ? proce=
ss_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.132210][ T6232]  process=
_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.134128][ T6232]  ? __pfx=
_macvlan_process_broadcast+0x10/0x10 drivers/net/macvlan.c:309
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.134151][ T6232]  ? __pfx=
_process_one_work+0x10/0x10 include/linux/list.h:153
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.134181][ T6232]  ? assig=
n_work+0x1a0/0x250 kernel/workqueue.c:1200
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.139713][ T6232]  process=
_scheduled_works kernel/workqueue.c:3310 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.139713][ T6232]  worker_=
thread+0x6c8/0xf00 kernel/workqueue.c:3391
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.141162][ T6232]  ? __pfx=
_worker_thread+0x10/0x10 include/linux/list.h:183
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.142406][ T6232]  kthread=
+0x2c1/0x3a0 kernel/kthread.c:389
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.143917][ T6232]  ? __raw=
_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.143917][ T6232]  ? _raw_=
spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145163][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145178][ T6232]  ret_fro=
m_fork+0x45/0x80 arch/x86/kernel/process.c:147
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145188][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145199][ T6232]  ret_fro=
m_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145219][ T6232]  </TASK>
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145386][ T6232]=20
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145391][ T6232] =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145395][ T6232] WARNING:=
 suspicious RCU usage
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145399][ T6232] 6.12.0-r=
c7-syzkalleNov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 =
Nov 11 21:02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 Nov 11 21:0=
2:33 syzkaller kern.wNov 11 21:02:33 syzkaller kern.warn kernel: [   96.145=
433][ T6232]  #0: ffff88804b8f2948 ((wq_completion)bond0#3){+.+.}-{0:0}, at=
: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
Nov 11 21:02:33 syzkaller kerNov 11 21:02:33 Nov 11 21:02:33 syzkaller kern=
.warn kernel: [   Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21=
:02:33 Nov 11 21:02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzk=
aller kern.warn kernel: [   96.145605][ T623Nov 11 21:02:33 syzkaller kern.=
wNov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:=
02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 Nov 11 21:02:33 syzka=
ller kern.wNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller kern.w=
Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller kern.wNov 11 21:0=
2:33 syzkaller kern.wNov 11 21:02:33 [   96.829369][ T6232] bond0: (slave b=
ridge0): link status up, enabling it in 4 ms
syzkaller kern.warn kernel: [   96.145803][ T6232]  ? __pfx_bond_mii_monito=
r+0x10/0x10 drivers/net/bonding/bond_main.c:2806
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145816][ T6232]  ? rcu_i=
s_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145816][ T6232]  ? rcu_i=
s_watching+0x12/0xc0 kernel/rcu/tree.c:737
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145827][ T6232]  ? trace=
_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145839][ T6232]  ? proce=
ss_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145850][ T6232]  ? lock_=
acquire+0x2f/0xb0 kernel/locking/lockdep.c:5796
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145858][ T6232]  ? proce=
ss_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145869][ T6232]  process=
_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145882][ T6232]  ? __pfx=
_macvlan_process_broadcast+0x10/0x10 drivers/net/macvlan.c:309
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145894][ T6232]  ? __pfx=
_process_one_work+0x10/0x10 include/linux/list.h:153
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145907][ T6232]  ? assig=
n_work+0x1a0/0x250 kernel/workqueue.c:1200
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145922][ T6232]  process=
_scheduled_works kernel/workqueue.c:3310 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145922][ T6232]  worker_=
thread+0x6c8/0xf00 kernel/workqueue.c:3391
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145937][ T6232]  ? __pfx=
_worker_thread+0x10/0x10 include/linux/list.h:183
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[9035]: ps_bpf_start_bpf: bpf_op=
en: Invalid argument
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[9035]: ps_root_recvmsg: Invalid=
 argument
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145946][ T6232]  kthread=
+0x2c1/0x3a0 kernel/kthread.c:389
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[9030]: ps_bpf_start_bpf: bpf_op=
en: Invalid argument
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145957][ T6232]  ? __raw=
_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145957][ T6232]  ? _raw_=
spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[9030]: ps_root_recvmsg: Invalid=
 argument
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145969][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145981][ T6232]  ret_fro=
m_fork+0x45/0x80 arch/x86/kernel/process.c:147
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.145990][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146001][ T6232]  ret_fro=
m_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146020][ T6232]  </TASK>
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146025][ T6232]=20
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146028][ T6232] =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146031][ T6232] WARNING:=
 suspicious RCU usage
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146034][ T6232] 6.12.0-r=
c7-syzkaller #0 Not tainted
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146040][ T6232] --------=
---------------------
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146043][ T6232] include/=
linux/rtnetlink.h:100 suspicious rcu_dereference_protected() usage!
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146050][ T6232]=20
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146050][ T6232] other in=
fo that might help us debug this:
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146050][ T6232]=20
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146053][ T6232]=20
Nov 11 21:02:33 syzkaller daemon.err dhcNov 11 21:02:33 syzkaller kern.wNov=
 11 21:02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daem=
onNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21=
:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzk=
aller kern.wNov 11 21:02:33 Nov 11 21:02:33 syzkaller kern.warn kernel: [  =
 96.146151][ T623Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev=
: receNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 1=
1 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 =
syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller k=
ern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.warn ke=
rnel: [   Nov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wN=
ov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02=
:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkall=
er daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNo=
v 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:=
33 syzkaller kern.wNov 11 21:02:33 syzkaller daemon.err dhcpcd[5661Nov 11 2=
1:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemon.err dhcpcd[5661Nov=
 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:3=
3 Nov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wNov 11 21=
:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzk=
aller daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemo=
nNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemon.err dhcpc=
d[5661]: libudev: receNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 Nov 1=
1 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 =
syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller k=
ern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.warn ke=
rnel: [   96.146396][ T6232]  ? trace_lockNov 11 21:02:33 syzkaller daemonN=
ov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02=
:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkall=
er kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wNo=
v 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02:=
33 syzkaller daemonNov 11 21:02:33 syzkaller kern.warn kernel: [   96.14646=
1][ T6232]  ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:153
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146474][ T6232]  ? assig=
n_work+0x1a0/0x250 kernel/workqueue.c:1200
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146489][ T6232]  process=
_scheduled_works kernel/workqueue.c:3310 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146489][ T6232]  worker_=
thread+0x6c8/0xf00 kernel/workqueue.c:3391
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146503][ T6232]  ? __pfx=
_worker_thread+0x10/0x10 include/linux/list.h:183
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146513][ T6232]  kthread=
+0x2c1/0x3a0 kernel/kthread.c:389
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146523][ T6232]  ? __raw=
_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146523][ T6232]  ? _raw_=
spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146536][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146547][ T6232]  ret_fro=
m_fork+0x45/0x80 arch/x86/kernel/process.c:147
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146555][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146567][ T6232]  ret_fro=
m_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.146585][ T6232]  </TASK>
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.err kernel: [   96.333328][ T6232] BUG: slee=
ping function called from invalid context at kernel/locking/rwsem.c:1523
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.err kernel: [   96.335759][ T6232] in_atomic=
(): 0, irqs_disabled(): 0, non_block: 0, pid: 6232, name: kworker/u32:32
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.err kernel: [   96.338277][ T6232] preempt_c=
ount: 0, expected: 0
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.err kernel: [   96.339800][ T6232] RCU nest =
depth: 1, expected: 0
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.341338][ T6232] 3 locks =
held by kworker/u32:32/6232:
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.342995][ T6232]  #0: fff=
f88804b8f2948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work+0x=
129b/0x1ba0 kernel/workqueue.c:3204
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.345823][ T6232]  #1: fff=
fc900033c7d80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at=
: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.348943][ T6232]  #Nov 11=
 21:02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 Nov 11 21:02:33 N=
ov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 syzkaller daemonNov 11 21:02=
:33 syzkaller kern.wNov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 =
21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 No=
v 11 21:02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller dae=
mon.err dhcpcd[5661Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 syzkalle=
r kern.wNov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov=
 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 syzkaller daem=
onNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21=
:02:33 Nov 11 21:02:33 Nov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 Nov =
11 21:02:33 syzkaller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33=
 syzkaller kern.wNov 11 21:02:33 Nov 11 21:02:33 Nov 11 21:02:33 syzkaller =
daemonNov 11 21:02:33 syzkaller kern.wNov 11 21:02:33 Nov 11 21:02:33 syzka=
ller kern.wNov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.w=
Nov 11 21:02:33 syzkaller daemonNov 11 21:02:33 syzkaller kern.warn kernel:=
 [   96.391355][ T6232]  ? __pfx_ethtool_op_get_link+0x10/0x10 net/ethtool/=
ioctl.c:2712
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.393047][ T6232]  ethtool=
_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.394857][ T6232]  bond_ch=
eck_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.396472][ T6232]  ? __pfx=
_bond_check_dev_link+0x10/0x10 drivers/net/bonding/bond_main.c:4594
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.398445][ T6232]  ? rcu_i=
s_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.398445][ T6232]  ? rcu_i=
s_watching+0x12/0xc0 kernel/rcu/tree.c:737
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.399965][ T6232]  bond_mi=
imon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.399965][ T6232]  bond_mi=
i_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2939
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.401543][ T6232]  ? __pfx=
_bond_mii_monitor+0x10/0x10 drivers/net/bonding/bond_main.c:2806
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.403142][ T6232]  ? rcu_i=
s_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.403142][ T6232]  ? rcu_i=
s_watching+0x12/0xc0 kernel/rcu/tree.c:737
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.404629][ T6232]  ? trace=
_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.406212][ T6232]  ? proce=
ss_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.407857][ T6232]  ? lock_=
acquire+0x2f/0xb0 kernel/locking/lockdep.c:5796
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.409307][ T6232]  ? proce=
ss_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.410910][ T6232]  process=
_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.412468][ T6232]  ? __pfx=
_macvlan_process_broadcast+0x10/0x10 drivers/net/macvlan.c:309
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.414179][ T6232]  ? __pfx=
_process_one_work+0x10/0x10 include/linux/list.h:153
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.415769][ T6232]  ? assig=
n_work+0x1a0/0x250 kernel/workqueue.c:1200
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.417321][ T6232]  process=
_scheduled_works kernel/workqueue.c:3310 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.417321][ T6232]  worker_=
thread+0x6c8/0xf00 kernel/workqueue.c:3391
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.418756][ T6232]  ? __pfx=
_worker_thread+0x10/0x10 include/linux/list.h:183
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.420279][ T6232]  kthread=
+0x2c1/0x3a0 kernel/kthread.c:389
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.421514][ T6232]  ? __raw=
_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.421514][ T6232]  ? _raw_=
spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.423050][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.424425][ T6232]  ret_fro=
m_fork+0x45/0x80 arch/x86/kernel/process.c:147
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.425840][ T6232]  ? __pfx=
_kthread+0x10/0x10 include/linux/list.h:373
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.427212][ T6232]  ret_fro=
m_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.428635][ T6232]  </TASK>
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.429829][ T6232]=20
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.430587][ T6232] =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Nov 11 21:02:33 syzkaller daemon.err dhcpcd[5661]: libudev: received NULL d=
evice
Nov 11 21:02:33 syzkaller kern.warn kernel: [   96.4

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

