Return-Path: <netdev+bounces-126403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E4971123
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A66F1F243C0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F91B14E6;
	Mon,  9 Sep 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dI3X6XmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BC1B1432
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868994; cv=none; b=ai15nAoeB+xoWujXmwQ7ZCFCWJudELCDXSjjMbem1X81baMSzZV+2TIh/cVEGfY/AFPXx/fmYONpX9DYkQGrJchsypKMgG2EWmDGKiivHAujR/LYS0Tk0FDplpVOvCTaJCJiE/0AtmjlmuQ1Vl7OkT+OYGUruv1rbYP9TDuraTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868994; c=relaxed/simple;
	bh=L0hohc3csRPqlhpsA/7CFpXamY61LYCnBD2Jby731mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1oCfibYYT3Z23kGJ+GfJsIQqq6JYb1vs4bp2GrEp2K5upBBWQY6O7ZWmDzhKVCnI19TrwgK5AZhdoFgwry5yTDHn8zbmMTXAs9tfBWr8j6spf3/4TaqnuhVgnqF7PPovGTiFwXD1soOeIKV7Xef2sjKO6yzPpfv6kess4dMCZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dI3X6XmA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5356ab89665so4674122e87.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725868991; x=1726473791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPPk0TDYYzm2xt2bFl0UC0M7dNTFBvwSqsGyjtReLrc=;
        b=dI3X6XmAdzp+Lxkstzwo9dSBvi4wNtLm515/IFiDU2qqys2Vur4euvxh/MpSQitLgj
         8ZeNIPYn7milRcBe8F+iu0yUYxqUzRYt3zOG1YC9hHrBc4q7bKn0cz1djM4vYaNXHU0d
         in0aZZoOKzFs/TX1Ftoh4g8rQVn95qxMEdy+h5b+FTvGo76XZrrACawr/btyAH4+ILYb
         3dnrfrGTzJR35FZjaOwYuLEtAhqitKh9BgnTo03WH57JsepmCekQ99HDuM4G0t2qZ+PR
         Dfh6T9+8jZ4F4uzvvtyATn286t9NfDlfG8xuJOL0pNaWb801sARg9rXfI224S2dLNBk1
         ZWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868991; x=1726473791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPPk0TDYYzm2xt2bFl0UC0M7dNTFBvwSqsGyjtReLrc=;
        b=G73JR0BwAO8n5wLaFh26s8pAP9TQhGIKjY/eBCA9CO0M7YRBEgrYZUYb1m2CZ/rdPh
         CEq21v/25HBSX7F0IQ6SYIOj7+zN6klyrChvF+N/Tki/Wi+MGY4pziznBer22pcG+N2t
         g6V0KpsaTdGxqSVArbkada4xzhqhVRlLlRlyvfBiHufU5hA+hxygIL/q/1M9/PbX7IFF
         PSvMz0faFHCRxVCgpeJbASeztw4IU9N91Tyj8TM+CMRMAAcbR6G3qz/Gdtnt7yye1IXL
         62zTLeb72OMJllluWoJYHDtLMsl26lQ+NL8XbzIpvdPriKlusNRH/Z8ith+hMFqizDFz
         p1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX8rVCklBaaznGh0FsLLqovhgmHspYf6U4iFi++YCoqcxsP2+cEVtMNU0kPVNx9GoQmCBMIfZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtWhSE3XRpbdnr/NP5rhv/qTqfsoM3+wyX/BCQqhMUugVvNOD
	N+ANYFInzwsJD5mdXzATC0wPyuPVOEbvHrIpNnyKVEyPWMIKg8e1Kbt/sIFNcagi2rxPe/pk12f
	YCoadnOwW6Lr05DnD2agCOl5Jd1Vil6izbEQd
X-Google-Smtp-Source: AGHT+IGevTrumeB14D+HR+GB884L8lvx1LTcCsqiv+IlGdkhOr28skbKiW0TNF4r7PfBeqFHvoec35w/kiJOOJ296TE=
X-Received: by 2002:a05:6512:239d:b0:535:67d9:c4b3 with SMTP id
 2adb3069b0e04-536587aa4dfmr5077214e87.11.1725868989987; Mon, 09 Sep 2024
 01:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000311430620013217@google.com> <0000000000005d1b320621973380@google.com>
In-Reply-To: <0000000000005d1b320621973380@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 10:02:59 +0200
Message-ID: <CANn89iJGw2EVw0V5HUs9-CY4f8FucYNgQyjNXThE6LLkiKRqUA@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
To: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Dust Li <dust.li@linux.alibaba.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 10:12=E2=80=AFAM syzbot
<syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into for-kernel=
ci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12bdabc798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddde5a5ba8d41e=
e9e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D51cf7cc5f9ffc10=
06ef2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1798589f980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10a30e0058000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/dis=
k-df54f4a1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinu=
x-df54f4a1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/99816271407d/I=
mage-df54f4a1.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0 Not tainted
> ------------------------------------------------------
> syz-executor272/6388 is trying to acquire lock:
> ffff8000923b6ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x2c net/co=
re/rtnetlink.c:79
>
> but task is already holding lock:
> ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsoc=
kopt+0x178/0x10fc net/smc/af_smc.c:3064
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
>        __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>        __mutex_lock kernel/locking/mutex.c:752 [inline]
>        mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>        smc_switch_to_fallback+0x48/0xa80 net/smc/af_smc.c:902
>        smc_sendmsg+0xfc/0x9f8 net/smc/af_smc.c:2779
>        sock_sendmsg_nosec net/socket.c:730 [inline]
>        __sock_sendmsg net/socket.c:745 [inline]
>        __sys_sendto+0x374/0x4f4 net/socket.c:2204
>        __do_sys_sendto net/socket.c:2216 [inline]
>        __se_sys_sendto net/socket.c:2212 [inline]
>        __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2212
>        __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>        invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>        el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>        do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>        el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>        el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:73=
0
>        el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
> -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
>        lock_sock_nested net/core/sock.c:3543 [inline]
>        lock_sock include/net/sock.h:1607 [inline]
>        sockopt_lock_sock+0x88/0x148 net/core/sock.c:1061
>        do_ip_setsockopt+0x1438/0x346c net/ipv4/ip_sockglue.c:1078
>        ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
>        raw_setsockopt+0x100/0x294 net/ipv4/raw.c:845
>        sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
>        do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
>        __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
>        __do_sys_setsockopt net/socket.c:2356 [inline]
>        __se_sys_setsockopt net/socket.c:2353 [inline]
>        __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
>        __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>        invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>        el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>        do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>        el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>        el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:73=
0
>        el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
> -> #0 (rtnl_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3133 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>        validate_chain kernel/locking/lockdep.c:3868 [inline]
>        __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
>        lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
>        __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>        __mutex_lock kernel/locking/mutex.c:752 [inline]
>        mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>        rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
>        do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
>        ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
>        tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
>        sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
>        smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
>        do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
>        __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
>        __do_sys_setsockopt net/socket.c:2356 [inline]
>        __se_sys_setsockopt net/socket.c:2353 [inline]
>        __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
>        __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>        invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>        el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>        do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>        el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>        el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:73=
0
>        el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
> other info that might help us debug this:
>
> Chain exists of:
>   rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&smc->clcsock_release_lock);
>                                lock(sk_lock-AF_INET);
>                                lock(&smc->clcsock_release_lock);
>   lock(rtnl_mutex);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor272/6388:
>  #0: ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_s=
etsockopt+0x178/0x10fc net/smc/af_smc.c:3064
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 6388 Comm: syz-executor272 Not tainted 6.11.0-rc5-syzk=
aller-gdf54f4a16f82 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
>  dump_stack+0x1c/0x28 lib/dump_stack.c:128
>  print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2059
>  check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2186
>  check_prev_add kernel/locking/lockdep.c:3133 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>  validate_chain kernel/locking/lockdep.c:3868 [inline]
>  __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
>  lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
>  __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>  __mutex_lock kernel/locking/mutex.c:752 [inline]
>  mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>  rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
>  do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
>  ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
>  tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
>  sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
>  smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
>  do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
>  __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
>  __do_sys_setsockopt net/socket.c:2356 [inline]
>  __se_sys_setsockopt net/socket.c:2353 [inline]
>  __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

Please SMC folks, can you take a look ?

