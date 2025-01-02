Return-Path: <netdev+bounces-154756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E316A9FFAE7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11F518829E0
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D41B4120;
	Thu,  2 Jan 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckWZINDe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1D1B3946
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735831319; cv=none; b=izXNSc7gKdD3TgZycjwfscnpCIua1su4kg9Jp/BSsOS9ZTYvTQhGzR4Hd12yK2unKw3U5avMko3b9FBRdT7bK6f6wQuJ30DFgZTrR/mTOO3U9djCW+hWBO8qwGTwqiV5Wrm4PkFlbPEI7A7poPJMPC5orcfgF9ee9HhGkmmbHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735831319; c=relaxed/simple;
	bh=8qYfmW6B+BBMmcdlcdCS0mabOar2zFl1nwTkaVNCw9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wlu0yCKoCyYME8AUl8a2+gwKh2FHeBjJmdHpIrVgBJlOYJHq+w8YXjDTfUjftpaLQcXpJ505hoqJSi7BUt0T9yIYDwX/pyL48NNZDsHWvjxOLBd0BBc41UTLz7QlrgEmQdvUbrH/mzrR7ebQ8TqmIUgJCNEFJxy9x0kIt2JhBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckWZINDe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so20868841a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735831315; x=1736436115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAucWZaKSNN5HO5CiGizZsZdQn7YWw8NX1a9MIhdfrg=;
        b=ckWZINDeENa9n5osUc5LZBsZf054a8+qpS4s5gXw9kf8Mu+JZS9tblfSO2SDu967LN
         nAhm8mQTZM40fTIYh8HN9xsHEQO+GzY5Tbmnb1s6X5xS7NZF9Y39Kqv2XeOVLeA5mkPA
         vZdpmD5i1Us/vx36L1xiEDgGCRHwGx4jlkPrY4Kz1lUXhdWHIp0U47wzaivDWeoio0J9
         CD6k0nlyRRvrqkZ/PDc2B31xycicke3zn1kdTjMTqa49V/RoOCf64PMf4fkWcK2XCDJE
         s7ZoVA3dJ4fB/GPrBTJNR7z6MAU7PP8W6S77imA4GWoljddcU9BU87YvNaJNK1u6BwKt
         C2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735831315; x=1736436115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAucWZaKSNN5HO5CiGizZsZdQn7YWw8NX1a9MIhdfrg=;
        b=LetArwbQvLK0JEgztzGJIfJHLO3sK9wptjFfdx9DisXIBJI+p/Y2IXxB4sThThySIF
         rZ+JnekFSLriWQo9aihLJjnReuibiQ6pLxAY8JmLdogYWtlgLcW3eKd4F6jn2ShvwK7S
         /fhYHutz30YatcOAtTsxMamCI9JiSzhR0GYIKO9fdb+DMUvclDPBnZG5Zabs8P3HQ/Z4
         2IN4tjt9BO5Mh2q3zzY4LtSUWZq5guLW2CGCyxP3PMDlY/Wxk2fD4Wofm2KsUZPX14sU
         ERQrEf20++LcUaTSITYLMfPVZUjx/7h5JjVmNOaLepSyUsCEZCnXu+COE7Z9gYjYtYCo
         +elA==
X-Forwarded-Encrypted: i=1; AJvYcCW7lZ3O+tYJKnTK1k4bu9smd8x6SE5+c/g5cMISkMnXpo4DvNSZCeM2KTzMRTLECPSRkAlSZg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGurBFFID4ZEL/uVgf4OGEAL44QY0tcBeDTa880uMLUY18uurl
	wdQX0EpN5fo3SFKz89zlhk1y5Dw7zzxOOyPjGolr+7sN1UVnbI5NahbsE1IPTTVXnBijaDY4bQA
	/3xgSPzyi/ZKRCkvi1WHOZyd0cncAPtrPzUve
X-Gm-Gg: ASbGncvVMOSsHZZzrZs8SwYXHHW857iwL7wLuMfF3ZIAycntMtpVIsjWEcIdbrGA0lQ
	FEPUnxjp2ZaNKA5/offvr2JlpySxlteHnxSneOA==
X-Google-Smtp-Source: AGHT+IFXe6PqXjdlonBB1QsEkwohZuO0owKLi2NF/aMq8cFkqq4BBBO1gJJmtEk3N5SPAGaMzIjnIocCzLyKYbdSOj4=
X-Received: by 2002:a05:6402:26d1:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5d81de39850mr42172800a12.32.1735831315246; Thu, 02 Jan 2025
 07:21:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
In-Reply-To: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Jan 2025 16:21:44 +0100
Message-ID: <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Cc: davem@davemloft.net, geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 3:12=E2=80=AFPM syzbot
<syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of =
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D128f6ac458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D86dd15278dbfe=
19f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De364f774c6f57f2=
c86d1
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1245eaf8580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/dis=
k-ccb98cce.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vmlinu=
x-ccb98cce.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf40/b=
zImage-ccb98cce.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzkall=
er-00004-gccb98ccef0e5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 0=
0 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
>
> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
>  __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
>  __kernel_write+0xf6/0x140 fs/read_write.c:632
>  do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
>  acct_pin_kill+0x2d/0x100 kernel/acct.c:192
>  pin_kill+0x194/0x7c0 fs/fs_pin.c:44
>  mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
>  cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
>  task_work_run+0x14e/0x250 kernel/task_work.c:239
>  exit_task_work include/linux/task_work.h:43 [inline]
>  do_exit+0xad8/0x2d70 kernel/exit.c:938
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
>  get_signal+0x2576/0x2610 kernel/signal.c:3017
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fee3cb87a6a
> Code: Unable to access opcode bytes at 0x7fee3cb87a40.
> RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
> RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
> RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
> R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
> R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 0=
0 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
>    5:   0f 85 fe 02 00 00       jne    0x309
>    b:   4d 8b a4 24 08 09 00    mov    0x908(%r12),%r12
>   12:   00
>   13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   1a:   fc ff df
>   1d:   49 8d 7c 24 28          lea    0x28(%r12),%rdi
>   22:   48 89 fa                mov    %rdi,%rdx
>   25:   48 c1 ea 03             shr    $0x3,%rdx
> * 29:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping in=
struction
>   2d:   0f 85 cc 02 00 00       jne    0x2ff
>   33:   4d 8b 7c 24 28          mov    0x28(%r12),%r15
>   38:   48                      rex.W
>   39:   8d                      .byte 0x8d
>   3a:   84 24 c8                test   %ah,(%rax,%rcx,8)
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

I thought acct(2) was only allowing regular files.

acct_on() indeed has :

if (!S_ISREG(file_inode(file)->i_mode)) {
    kfree(acct);
    filp_close(file, NULL);
    return -EACCES;
}

It seems there are other ways to call do_acct_process() targeting a sysfs f=
ile ?

