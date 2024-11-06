Return-Path: <netdev+bounces-142481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDD9BF4D9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC899B221BA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D109207A22;
	Wed,  6 Nov 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA4oX648"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF71207218
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916573; cv=none; b=Ik8R/hdlZmJVqyK4/yq5JJsqvGJW7Uw5pHs8WuWfoPeBDZqPtqsTDMwWUaQHWuvyhp8CCzGOD6MRJ86NodUE16syNLOeg3oqJVMoTpHnXEMGOl1oTx6ocG7XIrs7t9hukSHaAS8Yq+CuevWYRzjH+3emWRJG/Nuzr9wKXusKNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916573; c=relaxed/simple;
	bh=yITS/CirUTbxr+/UbiO9U44GtlS2l96omfztpUbrt4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaIUIjTRUmB9MiYHojn3kP7ZlKU/9gca0B4Ch27/4ID6M/nYMwRbz8F5vOMEzWIWQ5pOOc1RWvKYPltvJ2RS74oLqQfdDWLZlU1VTSy/vRiELtbOw1N0Fn9CRHqoS7JJR5QgGFK6zVXiDaXBp2FXOOyW+g0gk3ZDPoRJY3bJpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA4oX648; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so23390a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 10:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730916570; x=1731521370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEd3ayDpZTjyYEebgErcbQo4vxDon5fvuouc/CvpOzU=;
        b=vA4oX648VHy+y3GUue4+a80TIQXwlG4GrJxPA9T4hwlN0FTy0I/Rv2IK1p1xl73o51
         N+4CHCtaHsTuxV89J2I15TfQJv7Ab3nUO1UTR79tlPinkPOQglMBdTqdT98BesIqWnjk
         KtwKPpoTga3KJITDZCMvKryrUBQb23WTsDze6DbWrlpHkuWYTS6AyJjz4PVm9gcAYBk7
         V/DboOSMu7SjuyMonOray4hrAo/WzPrqbFNN6kyuDJbBh5te8Q3pErvCtNai2dUeHJaT
         +zVdwM+Q+4mMM9skvD1EkvH96bCXmrKLKCoWNwbvO2tdWrtUGiXKhU4jnSXghsqf/lKE
         VFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916570; x=1731521370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEd3ayDpZTjyYEebgErcbQo4vxDon5fvuouc/CvpOzU=;
        b=T5OniU1IbkANUdqnhjAJ3aafPlfUyZajuJGsUnxDYEibfY8UEWipk7rHTVDzGuQPuF
         NC230OevIMg80ISKPIIGDZNoROMxBKvfjS4G3eszao9FwTioshu8mCpfR+kSZBniI42l
         vwiyHCLHNKF8jH43hOWkRQDZrOE73kocK4fYfgJGkVtaoJekjrorBnT6OmfxaWQX8Oo1
         gz3N56FPEMIjxeZaxbiSzcFXvCYau5P8c9e+vqhcWxl1rVoc2qH4LO3iCKAW2g3lctQI
         JpM7ezpMHFcfXHVyyH75fyh+FxO+0SjzhaoaNUVMmE00xMSdmjKIbQTDboo6p/hRx0yD
         fPjA==
X-Forwarded-Encrypted: i=1; AJvYcCVC7LJmJkwV6FBees57LxtVWpJLiZxha/C4PqNEMsfczejxEdXOcr2YkN1uycxXKE1+vEGazpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUT9gSQLJwhAVO6tYMG1+BQkrjQYgATgE2LZ6B8cE3FpyJU6O
	gH0PzcCUSs4HLjh1pd6TQ87K8sQNtYfkfeLo/PoMVDRFvrLaicYvp6PT9R0+5eEKxCyoJPQNQmN
	tZTNme5REAvCAxuTAWV3yqircxsdC/L+hHn8a
X-Google-Smtp-Source: AGHT+IFDI4yL5sYBFLN9nnhHwUWdXgASYkuHkrUJO5teq5xRHIjQbOabmDsiGZPb+TuAEChP0JdgRUHBoXinzG3Aic4=
X-Received: by 2002:a05:6402:354e:b0:5ce:fbd0:573d with SMTP id
 4fb4d7f45d1cf-5cefbd05990mr436047a12.11.1730916569387; Wed, 06 Nov 2024
 10:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000035941f061932a077@google.com> <672bae42.050a0220.350062.0279.GAE@google.com>
In-Reply-To: <672bae42.050a0220.350062.0279.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 19:09:18 +0100
Message-ID: <CANn89iJptb2gackja+KocyPYwf855EgZM34GSO3km4Z8tcwq1w@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
To: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 6:58=E2=80=AFPM syzbot
<syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ke=
r..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1485dd5f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fdf74cce3772=
23b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d4=
86aee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1685dd5f980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10bfb6a798000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/08456e37db58/dis=
k-2e1b3cc9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cc957f7ba80b/vmlinu=
x-2e1b3cc9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7579fe72ed89/b=
zImage-2e1b3cc9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/inst=
rumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inlin=
e]
> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:30 [=
inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_ite=
r.h:300 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter=
.h:328 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:=
185
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  copy_to_user_iter lib/iov_iter.c:24 [inline]
>  iterate_ubuf include/linux/iov_iter.h:30 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
>  iterate_and_advance include/linux/iov_iter.h:328 [inline]
>  _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
>  copy_to_iter include/linux/uio.h:211 [inline]
>  simple_copy_to_iter net/core/datagram.c:524 [inline]
>  __skb_datagram_iter+0x18d/0x1190 net/core/datagram.c:401
>  skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:538
>  skb_copy_datagram_msg include/linux/skbuff.h:4076 [inline]
>  netlink_recvmsg+0x432/0x1610 net/netlink/af_netlink.c:1958
>  sock_recvmsg_nosec net/socket.c:1051 [inline]
>  sock_recvmsg+0x2c4/0x340 net/socket.c:1073
>  sock_read_iter+0x32d/0x3c0 net/socket.c:1143
>  io_iter_do_read io_uring/rw.c:771 [inline]
>  __io_read+0x8d2/0x20f0 io_uring/rw.c:865
>  io_read+0x3e/0xf0 io_uring/rw.c:943
>  io_issue_sqe+0x429/0x22c0 io_uring/io_uring.c:1739
>  io_queue_sqe io_uring/io_uring.c:1953 [inline]
>  io_req_task_submit+0x104/0x1e0 io_uring/io_uring.c:1373
>  io_poll_task_func+0x12e5/0x1620
>  io_handle_tw_list+0x23a/0x5c0 io_uring/io_uring.c:1063
>  tctx_task_work_run+0xf8/0x3d0 io_uring/io_uring.c:1135
>  tctx_task_work+0x6d/0xc0 io_uring/io_uring.c:1153
>  task_work_run+0x268/0x310 kernel/task_work.c:239
>  ptrace_notify+0x304/0x320 kernel/signal.c:2403
>  ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>  ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>  syscall_exit_work+0x14e/0x3e0 kernel/entry/common.c:173
>  syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>  syscall_exit_to_user_mode+0x13b/0x170 kernel/entry/common.c:218
>  do_syscall_64+0xda/0x1e0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  pskb_expand_head+0x305/0x1a60 net/core/skbuff.c:2283
>  netlink_trim+0x2c2/0x330 net/netlink/af_netlink.c:1313
>  netlink_unicast+0x9f/0x1260 net/netlink/af_netlink.c:1347
>  nlmsg_unicast include/net/netlink.h:1158 [inline]
>  nlmsg_notify+0x21d/0x2f0 net/netlink/af_netlink.c:2602
>  rtnetlink_send+0x73/0x90 net/core/rtnetlink.c:770
>  rtnetlink_maybe_send include/linux/rtnetlink.h:18 [inline]
>  tcf_add_notify net/sched/act_api.c:2068 [inline]
>  tcf_action_add net/sched/act_api.c:2091 [inline]
>  tc_ctl_action+0x146e/0x19d0 net/sched/act_api.c:2139
>  rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6675
>  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2551
>  rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6693
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:744
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2607
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2661
>  __sys_sendmsg net/socket.c:2690 [inline]
>  __do_sys_sendmsg net/socket.c:2699 [inline]
>  __se_sys_sendmsg net/socket.c:2697 [inline]
>  __x64_sys_sendmsg+0x300/0x4a0 net/socket.c:2697
>  x64_sys_call+0x2da0/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  __nla_put lib/nlattr.c:1041 [inline]
>  nla_put+0x1c6/0x230 lib/nlattr.c:1099
>  tcf_ife_dump+0x250/0x10b0 net/sched/act_ife.c:660
>  tcf_action_dump_old net/sched/act_api.c:1190 [inline]
>  tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1226
>  tcf_action_dump+0x1fd/0x460 net/sched/act_api.c:1250
>  tca_get_fill+0x519/0x7a0 net/sched/act_api.c:1648
>  tcf_add_notify_msg net/sched/act_api.c:2043 [inline]
>  tcf_add_notify net/sched/act_api.c:2062 [inline]
>  tcf_action_add net/sched/act_api.c:2091 [inline]
>  tc_ctl_action+0x1365/0x19d0 net/sched/act_api.c:2139
>  rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6675
>  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2551
>  rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6693
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:744
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2607
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2661
>  __sys_sendmsg net/socket.c:2690 [inline]
>  __do_sys_sendmsg net/socket.c:2699 [inline]
>  __se_sys_sendmsg net/socket.c:2697 [inline]
>  __x64_sys_sendmsg+0x300/0x4a0 net/socket.c:2697
>  x64_sys_call+0x2da0/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Local variable opt created at:
>  tcf_ife_dump+0xab/0x10b0 net/sched/act_ife.c:647
>  tcf_action_dump_old net/sched/act_api.c:1190 [inline]
>  tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1226
>
> Bytes 158-159 of 216 are uninitialized
> Memory access of size 216 starts at ffff88811980e280
>
> CPU: 1 UID: 0 PID: 5791 Comm: syz-executor190 Not tainted 6.12.0-rc6-syzk=
aller-00077-g2e1b3cc9d7f7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/include/uapi/linux/tc_act/tc_connmark.h
b/include/uapi/linux/tc_act/tc_connmark.h
index 9f8f6f709feb5cb67decc5fc80c422d9373df930..7089b9466065df074f98b47ffe1=
79baf386600a9
100644
--- a/include/uapi/linux/tc_act/tc_connmark.h
+++ b/include/uapi/linux/tc_act/tc_connmark.h
@@ -8,6 +8,7 @@
 struct tc_connmark {
        tc_gen;
        __u16 zone;
+       __u16 pad;
 };

 enum {
diff --git a/include/uapi/linux/tc_act/tc_ife.h
b/include/uapi/linux/tc_act/tc_ife.h
index 8c401f185675582febc262a8d11bf9598cb8a1f4..6f7f7af20fe9466631cc571f9c0=
0665489cfe91d
100644
--- a/include/uapi/linux/tc_act/tc_ife.h
+++ b/include/uapi/linux/tc_act/tc_ife.h
@@ -13,6 +13,7 @@
 struct tc_ife {
        tc_gen;
        __u16 flags;
+       __u16 pad;
 };

 /*XXX: We need to encode the total number of bytes consumed */
diff --git a/include/uapi/linux/tc_act/tc_pedit.h
b/include/uapi/linux/tc_act/tc_pedit.h
index f5cab7fc96ab1ea1516beeedff20b279c3cfa4d7..28e026dbc1400899a072fdbac68=
72654bea3ab8d
100644
--- a/include/uapi/linux/tc_act/tc_pedit.h
+++ b/include/uapi/linux/tc_act/tc_pedit.h
@@ -62,6 +62,7 @@ struct tc_pedit_sel {
        tc_gen;
        unsigned char           nkeys;
        unsigned char           flags;
+       __u16                                   pad;
        struct tc_pedit_key     keys[] __counted_by(nkeys);
 };

