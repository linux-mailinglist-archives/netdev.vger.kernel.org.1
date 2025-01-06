Return-Path: <netdev+bounces-155510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FEA029E2
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029DD1886297
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651921607AA;
	Mon,  6 Jan 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4NTay/ZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5B14900B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177238; cv=none; b=KBKemyIYZigpE0/nydxHB2omi6Cx2UlD2LVvXlEsHyf92LOdQkTQOMW6RTdmo0np29YjXNHGGUrjcfnt+JGJLn2LZmwKgP1GlElFkqxIhp7GEqxwLDYNxreGhprn2CtToRBIr28AgRW2/zeJtImXc8yfmZZ5+WE2dsHlK70oFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177238; c=relaxed/simple;
	bh=OJ9aSXhxa0+AZfLZemWnPUPfqzzJJWgjjrJBdTnM0IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWL1l3GUmMAru/zbRS8gtvwi8C64ffMR4di0MsjdJhZ7ygq40J1F6AHyBX6lOUyNrzPODMgI404OIxVgehCKK/U2B+APZlrsBzEwmcYiRJyGkqiI5VNUgwQa/RVMqpJSY9LsDwawy7i6Ran684f/BGYLnaXb7xhiUjAY9dPI4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4NTay/ZC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso23049417a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736177234; x=1736782034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q2gwAuEkHZrt09qYHWpAtV1PiWOnnS0lxwU8et7qLI=;
        b=4NTay/ZCuEd3UnUNOa2BT2AfffQOroIn532246B5MDwNdQFag7JFGJByWtEyYllGKq
         gYjC1CFDgfCbTGUL68XVOfMqgZr3NCJvlZ0rsBCigEkPrk+551tb1nDenGrGMo4qHYKB
         E4PjxPfYfM5aB+RzyTnWAnIUEdvUdaytRr8l4uMqx7oF6DNyD8GMSLFZFBGAE8rdytjN
         gJx9oXYk4bTQ+EC00Ja3EOn+Me1Po0ESzaj1/ILgLyvwRgtSuMEUtM5OG0+XnJgJIEpe
         XPuG8BtS8/CLo4PznDDC8p13w8rP8dA7X7nCQskwx9JN6vlGaoSKjwRQ2UARGTixfZ6n
         xafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177234; x=1736782034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0q2gwAuEkHZrt09qYHWpAtV1PiWOnnS0lxwU8et7qLI=;
        b=D07DHA1b17KDOJ9ejUwiy+to2Zy2s049yekNQ9srG7usMSKVOlnVMEnCtyUcONBbkd
         gQN8zDQtQWIva+/w+1i4v+qxsu2ChJUSVSN9DwJXtT1Hur+XjzyQSMhmM5n81oz5aGMm
         F+0P/QtJSR3gaA0KUv9YSOEEXa7R+uy1GSt5e7DhXRgKZpbBkuqPWY04KBAePTejffpF
         xWMKKJLEwsGuJEFd8u+VohpgYrP0Hy4wY7de08tcPSxY/zbem0xFQ1PZLT0tAmw13Kvc
         pXe0k4KjST0QmeORXyMO/TLfmFhR1nJme9JJhe5n2AhqEaj+Q2rKqiMiyXFp51MAQ9wM
         JQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV8JVMDm4W1x9h1U06ofUPJH6zIwOVF/5plvt0Pz+lEffgeTca4/LXhpxU0YWaD08klxh3YHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrQqzWo0lYwq4X5maP67J28vbtOA3yWha4d8GNMZ5qA09Uhav
	2vc/U4IxfDKf0Jzj6qS58wXLSDS6uh9Te/JE6p+x0sUEN+oL7bS6M8EFFecZtD3TIxpOe97sN3c
	+1iTDXBrENm+saDr1fvm3wPNS8Ggt9REBSv3J
X-Gm-Gg: ASbGncv9TvzinJIipHSyL3pIJVv0Acv67G0F4uKA7/4Ji8O4MRqEv+yckWJxymoKY/9
	nhdwHst5VpqAFil6j6kr4sizi3hVRjl9NDbj+
X-Google-Smtp-Source: AGHT+IFhuowlWyK0vnA34CtHiSyLgwOKnmkEMeJ7Ib5a7g8XNg8W7b1FV+lKiWDMTfukU7R3GC27H3cFLirDBJPjPNs=
X-Received: by 2002:a05:6402:2150:b0:5d9:a5a:e54e with SMTP id
 4fb4d7f45d1cf-5d90a5ae56fmr10804860a12.0.1736177234123; Mon, 06 Jan 2025
 07:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com> <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org> <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <7927eae8-4d26-4340-852a-b93fcf1eba89@kernel.org> <fewptpw6r5rspq3seygym7v5y2h2htomongyxbxio2x27cngac@ituf5et5db2b>
 <2b0bcf38-5408-4268-bb69-cbea2b250521@kernel.org>
In-Reply-To: <2b0bcf38-5408-4268-bb69-cbea2b250521@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 16:27:03 +0100
Message-ID: <CANn89i+1gPTc7wmTgdbwyB19tKAk7j8ZR6j6z7hVhtwAXXD8-A@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	davem@davemloft.net, geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 3:27=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Joel, Eric, Al,
>
> On 06/01/2025 14:32, Joel Granados wrote:
> > On Sat, Jan 04, 2025 at 08:11:52PM +0100, Matthieu Baerts wrote:
> >> Hi Eric,
> >>
> >> (+cc Joel)
> >>
> >> Thank you for your reply!
> >>
> >> On 04/01/2025 19:53, Eric Dumazet wrote:
> >>> On Sat, Jan 4, 2025 at 7:38=E2=80=AFPM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>>>
> >>>> Hi Eric,
> >>>>
> >>>> Thank you for the bug report!
> >>>>
> >>>> On 02/01/2025 16:21, Eric Dumazet wrote:
> >>>>> On Thu, Jan 2, 2025 at 3:12=E2=80=AFPM syzbot
> >>>>> <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13=
-4' of g..
> >>>>>> git tree:       upstream
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D128f6a=
c4580000
> >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D86dd15=
278dbfe19f
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3De364f774=
c6f57f2c86d1
> >>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutil=
s for Debian) 2.40
> >>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1245=
eaf8580000
> >>>>>>
> >>>>>> Downloadable assets:
> >>>>>> disk image: https://storage.googleapis.com/syzbot-assets/d24eb225c=
ff7/disk-ccb98cce.raw.xz
> >>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240=
/vmlinux-ccb98cce.xz
> >>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4=
bbf40/bzImage-ccb98cce.xz
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to t=
he commit:
> >>>>>> Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
> >>>>>>
> >>>>>> Oops: general protection fault, probably for non-canonical address=
 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> >>>>>> KASAN: null-ptr-deref in range [0x0000000000000028-0x0000000000000=
02f]
> >>>>>> CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-=
syzkaller-00004-gccb98ccef0e5 #0
> >>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,=
 BIOS Google 09/13/2024
> >>>>>> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> >>>>>> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 =
48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 0=
2 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> >>>>>> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> >>>>>>
> >>>>>> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> >>>>>> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> >>>>>> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> >>>>>> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> >>>>>> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> >>>>>> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:000000=
0000000000
> >>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> >>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>> Call Trace:
> >>>>>>  <TASK>
> >>>>>>  proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
> >>>>>>  __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
> >>>>>>  __kernel_write+0xf6/0x140 fs/read_write.c:632
> >>>>>>  do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
> >>>>>>  acct_pin_kill+0x2d/0x100 kernel/acct.c:192
> >>>>>>  pin_kill+0x194/0x7c0 fs/fs_pin.c:44
> >>>>>>  mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
> >>>>>>  cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
> >>>>>>  task_work_run+0x14e/0x250 kernel/task_work.c:239
> >>>>>>  exit_task_work include/linux/task_work.h:43 [inline]
> >>>>>>  do_exit+0xad8/0x2d70 kernel/exit.c:938
> >>>>>>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
> >>>>>>  get_signal+0x2576/0x2610 kernel/signal.c:3017
> >>>>>>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
> >>>>>>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >>>>>>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inlin=
e]
> >>>>>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inlin=
e]
> >>>>>>  syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
> >>>>>>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
> >>>>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>>> RIP: 0033:0x7fee3cb87a6a
> >>>>>> Code: Unable to access opcode bytes at 0x7fee3cb87a40.
> >>>>>> RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0037
> >>>>>> RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
> >>>>>> RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
> >>>>>> RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
> >>>>>> R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
> >>>>>> R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
> >>>>>>  </TASK>
> >>>>>> Modules linked in:
> >>>>>> ---[ end trace 0000000000000000 ]---
> >>>>>> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> >>>>>> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 =
48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 0=
2 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> >>>>>> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> >>>>>> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> >>>>>> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> >>>>>> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> >>>>>> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> >>>>>> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> >>>>>> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:000000=
0000000000
> >>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> >>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>> ----------------
> >>>>>> Code disassembly (best guess), 1 bytes skipped:
> >>>>>>    0:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
> >>>>>>    5:   0f 85 fe 02 00 00       jne    0x309
> >>>>>>    b:   4d 8b a4 24 08 09 00    mov    0x908(%r12),%r12
> >>>>>>   12:   00
> >>>>>>   13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >>>>>>   1a:   fc ff df
> >>>>>>   1d:   49 8d 7c 24 28          lea    0x28(%r12),%rdi
> >>>>>>   22:   48 89 fa                mov    %rdi,%rdx
> >>>>>>   25:   48 c1 ea 03             shr    $0x3,%rdx
> >>>>>> * 29:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trap=
ping instruction
> >>>>>>   2d:   0f 85 cc 02 00 00       jne    0x2ff
> >>>>>>   33:   4d 8b 7c 24 28          mov    0x28(%r12),%r15
> >>>>>>   38:   48                      rex.W
> >>>>>>   39:   8d                      .byte 0x8d
> >>>>>>   3a:   84 24 c8                test   %ah,(%rax,%rcx,8)
> >>>>
> >>>> (...)
> >>>>
> >>>>> I thought acct(2) was only allowing regular files.
> >>>>>
> >>>>> acct_on() indeed has :
> >>>>>
> >>>>> if (!S_ISREG(file_inode(file)->i_mode)) {
> >>>>>     kfree(acct);
> >>>>>     filp_close(file, NULL);
> >>>>>     return -EACCES;
> >>>>> }
> >>>>>
> >>>>> It seems there are other ways to call do_acct_process() targeting a=
 sysfs file ?
> > If this is the case, can you point me to the place where this happens?
> >
> >>>>
> >>>> Just to be sure I'm not misunderstanding your comment: do you mean t=
hat
> >>>> here, the issue is *not* in MPTCP code where we get the 'struct net'
> >>>> pointer via 'current->nsproxy->net_ns', but in the FS part, right?
> >>>>
> >>>> Here, we have an issue because 'current->nsproxy' is NULL, but is it
> >>>> normal? Or should we simply exit with an error if it is the case bec=
ause
> >>>> we are in an exiting phase?
> >>>>
> >>>> I'm just a bit confused, because it looks like 'net' is retrieved fr=
om
> >>>> different places elsewhere when dealing with sysfs: some get it from
> >>>> 'current' like us, some assign 'net' to 'table->extra2', others get =
it
> >>>> from 'table->data' (via a container_of()), etc. Maybe we should not =
use
> >>>> 'current->nsproxy->net_ns' here then?
> >>>
> >>> I do think this is a bug in process accounting, not in networking.
> >>>
> >>> It might make sense to output a record on a regular file, but probabl=
y
> >>> not on any other files.
> > It for sure does not make sense to output a record on a sysctl file tha=
t
> > has a maxlen of just 3*sizeof(int) (kernel/acct.c:79).
> >
> >>>
> >>> diff --git a/kernel/acct.c b/kernel/acct.c
> >>> index 179848ad33e978a557ce695a0d6020aa169177c6..a211305cb930f6860d02d=
e7f45ebd260ae03a604
> >>> 100644
> >>> --- a/kernel/acct.c
> >>> +++ b/kernel/acct.c
> >>> @@ -495,6 +495,9 @@ static void do_acct_process(struct bsd_acct_struc=
t *acct)
> >>>         const struct cred *orig_cred;
> >>>         struct file *file =3D acct->file;
> >>>
> >>> +       if (S_ISREG(file_inode(file)->i_mode))
> >>> +               return;
> >>> +
> > This seems like it does not handle the actual culprit which is. Why is
> > the sysctl file being used for the accounting.
> >
> >>>         /*
> >>>          * Accounting records are not subject to resource limits.
> >>>          */
> >>
> >> OK, thank you, that's clearer.
> >>
> >> So this is then more a question for Joel, right?
> >>
> >> Do you plan to send this patch to him?
> >>
> >> #syz set subsystems: fs
> >>
> >> Cheers,
> >> Matt
> >> --
> >> Sponsored by the NGI0 Core fund.
> >>
> >
> > So what is happening is that:
> > 1. The accounting file is set to a non-sysctl file.
> > 2. And when accounting tries to write to this file, you get the
> >    behaviour explained in this mail?
> >
> > Please correct me if I have miss-read the situation.
>
> @Joel: Thank you for your reply!
>
> I'm sorry, I'm not sure whether I can help here. I hope Eric and/or Al
> can jump in.
>
> What I can say is that the original issue has been found by syzbot, and
> the reproducer [1] shows that 3 syscalls have been used:
> - openat('/proc/sys/net/mptcp/scheduler')
> - mprotect()
> - acct()
>
> Please also note that the conversation continued in a sub-tread where
> you are not in the Cc list, see [2]. In short, Eric suggested another
> patch only for sysfs, and Al recommended dropping the use of
> 'current->nsproxy'.
>
> On my side, I'm looking at dropping the use of 'current->nsproxy' in
> sysctl callbacks. I guess such patches will be seen as fixes, except if
> Eric's new patch is enough for stable?

It might be less risky in terms of backports to patch mptcp and others.

Ie just use Al suggestion.

Thanks !

