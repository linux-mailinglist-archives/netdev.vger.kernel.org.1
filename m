Return-Path: <netdev+bounces-155190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB0A01676
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 19:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EC47A0FEE
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD011482E3;
	Sat,  4 Jan 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D97rQaxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7D1C548A
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736016817; cv=none; b=gCccIwpx7vCjqe0zBJMvErvQrhNsqYgKfLOkd6Xz8Y/6n/tUzlFij9Zd79uVNrV6OZUsD4BzrjkXQOs1L8W01LJVDRADbJfzXW59/UDe8lT5vxEWfHAMpgLsTAONqIsG20FPjMIvYxrJ9eoopcFcG0NGVJUGYGPby95Ja+12Hs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736016817; c=relaxed/simple;
	bh=o1VT5R21nA4GcnO3gikmuc9uLdzOawSQiprLAHX3t2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0b0M9N/AUgEXv0puda4KCDRSqHgRRA1Zs6ONNtD8uwovSk3G4S3E9CWxjuBqYJgj71WnCc9/KF1HWNSpCXsXqcEEb8m7+E/9kEykZERKxOFayboywel9VQckBmtfDrybV+B7F468ozSntPNgO375JXxfmsZoz0RsDrH5lE94dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D97rQaxT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so23291923a12.0
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736016813; x=1736621613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J+XDLTN8hk8YcExX28sAuR179kk7n7F+Zft6f898uA=;
        b=D97rQaxTvCv2N1WlhsRTya/2ZtN2xsEM2Wc9lido793hEFMmiQDRb1zBuQHdVJ/GJx
         TfYeY9ZdJ+D+Ry9GsDNTvkGJXOp6H0ZkeuqbwZlpwz63XQx4WhMK5N5dAZUTubdfX3JG
         5R7P7XlupiG+mi6L8WY/D34jHX4lyw1olLwfR0UtJgr8bDL8SPglcTNcmLJ2DaguAVRV
         zZcIB/L6f00BzX6jNKQ7QuMqghdPWl2BFojRWkoAExHeBtD7i6PGxHk3S2Yr8QMJj4zQ
         kWqy+KttB1ggZPivYQ1ecvxbEMYLdv4zfe8XjlsXK5X3sTjDd0zelmOOZOXsYCtoIx/d
         kEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736016813; x=1736621613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J+XDLTN8hk8YcExX28sAuR179kk7n7F+Zft6f898uA=;
        b=n15kjd4ckaGvC8Qur3qz9ePyu3k1049OYDZXRh3LP/4xembZaQSOF743eVeVhMTLcr
         Agozb1fJCPgWh5Y7iXjRlWBmh3JrRWPemZUtQMNcjywJBtJTZswU3JGNG2uaqGXpPtzF
         cOxIDOD8xMVxp6HI6rG8FrFAJDfTXKRsO8mjWrDGBKbkzbLqFmaSkYA/H2+N+jsfca7Y
         Aso/2hKy9OQ/R+TulK4E9iqtvcg9KNbdYfuC2qae2F/X5Hd7onYIcObI3KucRy83zcDv
         OfpAPq87f8Z4EA1E3myVoks2hEQRtRdaGAmw5rNmkpEFCqfweb00sm9ojj+zuGUKMdM4
         qkmA==
X-Forwarded-Encrypted: i=1; AJvYcCUNJvvW+QJBqjmBHEtJIqFUcqOmv7Mc6Thu7NQ9SLth+tQYIw2u1SkqSqcRFxKdO24hZv2LtaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZs9TlwZJCXzSUqttcCXN2eHsnYvDby9+r4SbTxOYSIgk2M3w
	WcXZVLiyDFo6nLZGukShHQwzVH0hfcrj5cvR0SJteHn+iwOF50RfRAYLbdUPmU9JXNjTspexrnP
	yp9ZTZIspWrf8FW2880FAcl2CifC0GSU2D8Iw
X-Gm-Gg: ASbGnctKZG98dJEAOc+poffud4IvmO9lEnfCS3fg+dhOfUjDvlLVBIJyeePmBZ1g/iF
	dnOkRcxc5RGEfQI/rlnF0BnYkP/IlXG3M3IBcJw==
X-Google-Smtp-Source: AGHT+IGGGmlcqYZQ816T1ELbWQMxSWqw+aaSkqCtL9U31ymHVy8X6JeV3WDgTEA+mmeVPll3le0M1hbrUHOzXy/G4yY=
X-Received: by 2002:a05:6402:4402:b0:5d6:501c:daef with SMTP id
 4fb4d7f45d1cf-5d81de2e06amr47219802a12.34.1736016813311; Sat, 04 Jan 2025
 10:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com> <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
In-Reply-To: <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 4 Jan 2025 19:53:22 +0100
Message-ID: <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 7:38=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Eric,
>
> Thank you for the bug report!
>
> On 02/01/2025 16:21, Eric Dumazet wrote:
> > On Thu, Jan 2, 2025 at 3:12=E2=80=AFPM syzbot
> > <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' =
of g..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D128f6ac458=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D86dd15278d=
bfe19f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3De364f774c6f5=
7f2c86d1
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils fo=
r Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1245eaf8=
580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/=
disk-ccb98cce.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vml=
inux-ccb98cce.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf4=
0/bzImage-ccb98cce.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
> >>
> >> Oops: general protection fault, probably for non-canonical address 0xd=
ffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> >> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> >> CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzk=
aller-00004-gccb98ccef0e5 #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 09/13/2024
> >> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> >> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b=
8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00=
 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> >> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> >>
> >> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> >> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> >> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> >> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> >> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> >> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  <TASK>
> >>  proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
> >>  __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
> >>  __kernel_write+0xf6/0x140 fs/read_write.c:632
> >>  do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
> >>  acct_pin_kill+0x2d/0x100 kernel/acct.c:192
> >>  pin_kill+0x194/0x7c0 fs/fs_pin.c:44
> >>  mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
> >>  cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
> >>  task_work_run+0x14e/0x250 kernel/task_work.c:239
> >>  exit_task_work include/linux/task_work.h:43 [inline]
> >>  do_exit+0xad8/0x2d70 kernel/exit.c:938
> >>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
> >>  get_signal+0x2576/0x2610 kernel/signal.c:3017
> >>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
> >>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
> >>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >>  syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
> >>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> RIP: 0033:0x7fee3cb87a6a
> >> Code: Unable to access opcode bytes at 0x7fee3cb87a40.
> >> RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
> >> RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
> >> RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
> >> RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
> >> R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
> >> R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
> >>  </TASK>
> >> Modules linked in:
> >> ---[ end trace 0000000000000000 ]---
> >> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> >> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b=
8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00=
 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> >> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> >> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> >> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> >> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> >> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> >> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> >> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> ----------------
> >> Code disassembly (best guess), 1 bytes skipped:
> >>    0:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
> >>    5:   0f 85 fe 02 00 00       jne    0x309
> >>    b:   4d 8b a4 24 08 09 00    mov    0x908(%r12),%r12
> >>   12:   00
> >>   13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >>   1a:   fc ff df
> >>   1d:   49 8d 7c 24 28          lea    0x28(%r12),%rdi
> >>   22:   48 89 fa                mov    %rdi,%rdx
> >>   25:   48 c1 ea 03             shr    $0x3,%rdx
> >> * 29:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping=
 instruction
> >>   2d:   0f 85 cc 02 00 00       jne    0x2ff
> >>   33:   4d 8b 7c 24 28          mov    0x28(%r12),%r15
> >>   38:   48                      rex.W
> >>   39:   8d                      .byte 0x8d
> >>   3a:   84 24 c8                test   %ah,(%rax,%rcx,8)
>
> (...)
>
> > I thought acct(2) was only allowing regular files.
> >
> > acct_on() indeed has :
> >
> > if (!S_ISREG(file_inode(file)->i_mode)) {
> >     kfree(acct);
> >     filp_close(file, NULL);
> >     return -EACCES;
> > }
> >
> > It seems there are other ways to call do_acct_process() targeting a sys=
fs file ?
>
> Just to be sure I'm not misunderstanding your comment: do you mean that
> here, the issue is *not* in MPTCP code where we get the 'struct net'
> pointer via 'current->nsproxy->net_ns', but in the FS part, right?
>
> Here, we have an issue because 'current->nsproxy' is NULL, but is it
> normal? Or should we simply exit with an error if it is the case because
> we are in an exiting phase?
>
> I'm just a bit confused, because it looks like 'net' is retrieved from
> different places elsewhere when dealing with sysfs: some get it from
> 'current' like us, some assign 'net' to 'table->extra2', others get it
> from 'table->data' (via a container_of()), etc. Maybe we should not use
> 'current->nsproxy->net_ns' here then?

I do think this is a bug in process accounting, not in networking.

It might make sense to output a record on a regular file, but probably
not on any other files.

diff --git a/kernel/acct.c b/kernel/acct.c
index 179848ad33e978a557ce695a0d6020aa169177c6..a211305cb930f6860d02de7f45e=
bd260ae03a604
100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -495,6 +495,9 @@ static void do_acct_process(struct bsd_acct_struct *acc=
t)
        const struct cred *orig_cred;
        struct file *file =3D acct->file;

+       if (S_ISREG(file_inode(file)->i_mode))
+               return;
+
        /*
         * Accounting records are not subject to resource limits.
         */

