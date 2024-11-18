Return-Path: <netdev+bounces-145774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3D9D0B30
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730BFB211C4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0615445D;
	Mon, 18 Nov 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDToG+ZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918271474AF;
	Mon, 18 Nov 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919654; cv=none; b=onIiwX3ynNXCvBfs9FBbyQfhsjoucm8zwWPmp7QgKC8zFY3N5m5iCEmuClFtpUWOfx5UxRl4lo8yoHIFLsDqJCz6OmPwTcvgWXwDV/L9N8MVsFDXM+wa8VxNUus7Sxs9JzKN76z6yNn2u4C0mnO7nznyGPiEgbPkoxhuXSAIuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919654; c=relaxed/simple;
	bh=HIxQdLKHK2KBtygcudShQH3Y3Cm2vL4IumisKw6gJ90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbXFzbP4yWOQYjQuqZnX+LtyG38ZwxU+A1BNqVo9fiyJz0qbF5Q5KuONjbuTTunWhOKjv9C5/ybAGU4Q64d3WDop/9IL4XNz+v1UnWswr1JJXAluP299dZ/O+HkIV+Vmq76HWmzVC0bp6jWE4dGPwrFiLba05haW8z9wLvK45nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDToG+ZV; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e3882273bc8so1237643276.1;
        Mon, 18 Nov 2024 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731919651; x=1732524451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHDcvcXxYQNDdvQE9ir6v04HMrCuKIbKEebzXvcPvmA=;
        b=PDToG+ZVFazeQoxCZrPet5YnZSxujCwWjzeSz6HHiqPE7BVugUwfWiXYEX49gO32ld
         RkAzZiGEbCc1qt2T7yl+GY/8vNO7CHQLvGQ5ScsyH0WOqLD8zGx8GY3sbWij6q/q/GlY
         r5lpcs6kUCShctp9iyjnpBfXnVcwaWPwI5UpkZJvG+dbLxBn7yKK23GWrlUa21+ra2st
         91GACc4hSaNm88D/sGPX/KNZVq8x+Kx+Fawc+coMKI4p/hjwKW6zch8ZUyigKoeo/M0u
         LcSAHGshwYmTaS6Nk8VDlK0CS7377aDcYyK+OWsYhjZ7LufLcC7bBxX6gi+UpJfMXaK9
         dE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731919651; x=1732524451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHDcvcXxYQNDdvQE9ir6v04HMrCuKIbKEebzXvcPvmA=;
        b=n6qnrNPCC/TZGTP1u5mUa7jMj4SxLmw6b0AEg/UCRTAZtJVc2X/fZcbtoKbyp620vA
         YM6uwgwhePVODZ+s/jE2wQz1H/MbRXGLz7n1rP2pP7FNd6HCUM00eOyps21d+ne3gb3U
         Dvg5gycHjeg3N1QglZHQEPrns9g4QGpcSrdQOIbgFjptFQ6F3/NFc96kBcE1ZQnv6Miw
         xpR9lad/iOWIkUZbV/EcBqz30nunezAdIA03S1JIqr1j1o+OVBHDR3aucik3gOWLdIaB
         UEOcR9qxwJeaOPlGJZstkiNEwJNXJ0+i0YKwNDTOL6ArrVXn9I/qO76yY2RLKzmHH9G4
         5O2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQvtbm73uwtImx52G7GfvylXgxB8FW+iWn7bXLTUOoVUwXygOh0OlEb8psa7wK2lmFwlpExbGHiZlDHXA=@vger.kernel.org, AJvYcCWp8qcd2HPvTy3s8qs6OcDxVrRbtoHUQdG+O3nsDU2BCjsPKwtHBJjM7U7NS30IntbLRi4Legee@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kaevlkPEsJ94uVKbii0fNbAgXkcBuvVOm9y+t0TYNQPXVl0I
	bBqL3/QWFYFlIOnjeS/E7CRtwJudCG4/ts3xHxecUynNh9QpLHxLdHpE3d05mAqme12PA4SoZw0
	pZzGhVMvFQMX8gln8Un7u2bkRuHw=
X-Google-Smtp-Source: AGHT+IH1LiDxZ/bJpt+WicYx678dqN3zLJoxAziLvUwzZW5jAGbgVDtAIAKJe2W271zpEajKDlBBOMsfmTQUWrDmiEE=
X-Received: by 2002:a05:6902:2208:b0:e38:87bf:8e65 with SMTP id
 3f1490d57ef6-e3887bf9531mr4521701276.0.1731919651487; Mon, 18 Nov 2024
 00:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6738e539.050a0220.e1c64.0002.GAE@google.com> <6cbc88fa-1479-4e44-950a-6d3881197520@redhat.com>
In-Reply-To: <6cbc88fa-1479-4e44-950a-6d3881197520@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 18 Nov 2024 16:47:56 +0800
Message-ID: <CADxym3YsBfQ7sbongiXhrF6KfZ9sr-6GwQkCGB=4_y2Au5V33A@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in sk_skb_reason_drop
To: Paolo Abeni <pabeni@redhat.com>
Cc: dongml2@chinatelecom.cn, 
	syzbot <syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com>, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/16/24 19:32, syzbot wrote:
> > HEAD commit:    a58f00ed24b8 net: sched: cls_api: improve the error mes=
sag..
> > git tree:       net-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D140a735f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D47cb6c16bf9=
12470
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D52fbd90f02078=
8ec7709
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D132804c05=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14f481a7980=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d28dcea68102/d=
isk-a58f00ed.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8ec032ea06c6/vmli=
nux-a58f00ed.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/da9b8f80c783=
/bzImage-a58f00ed.xz
> >
> > The issue was bisected to:
> >
> > commit 82d9983ebeb871cb5abd27c12a950c14c68772e1
> > Author: Menglong Dong <menglong8.dong@gmail.com>
> > Date:   Thu Nov 7 12:55:58 2024 +0000
> >
> >     net: ip: make ip_route_input_noref() return drop reasons
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10ae41a7=
980000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12ae41a7=
980000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ae41a7980=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
> > Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop =
reasons")
> >
> > netlink: 'syz-executor371': attribute type 4 has an invalid length.
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 __sk_skb_reason_dro=
p net/core/skbuff.c:1216 [inline]
> > WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 sk_skb_reason_drop+=
0x87/0x380 net/core/skbuff.c:1241
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5842 Comm: syz-executor371 Not tainted 6.12.0-rc6-sy=
zkaller-01362-ga58f00ed24b8 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/30/2024
> > RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> > RIP: 0010:sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> > Code: 00 00 00 fc ff df 41 8d 9e 00 00 fc ff bf 01 00 fc ff 89 de e8 ea=
 9f 08 f8 81 fb 00 00 fc ff 77 3a 4c 89 e5 e8 9a 9b 08 f8 90 <0f> 0b 90 eb =
5e bf 01 00 00 00 89 ee e8 c8 9f 08 f8 85 ed 0f 8e 49
> > RSP: 0018:ffffc90003d57078 EFLAGS: 00010293
> > RAX: ffffffff898c3ec6 RBX: 00000000fffbffea RCX: ffff8880347a5a00
> > RDX: 0000000000000000 RSI: 00000000fffbffea RDI: 00000000fffc0001
> > RBP: dffffc0000000000 R08: ffffffff898c3eb6 R09: 1ffff110023eb7d4
> > R10: dffffc0000000000 R11: ffffed10023eb7d5 R12: dffffc0000000000
> > R13: ffff888011f5bdc0 R14: 00000000ffffffea R15: 0000000000000000
> > FS:  000055557d41e380(0000) GS:ffff8880b8600000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000056519d31d608 CR3: 000000007854e000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
> >  ip_rcv_finish_core+0xfde/0x1b50 net/ipv4/ip_input.c:424
> >  ip_list_rcv_finish net/ipv4/ip_input.c:610 [inline]
> >  ip_sublist_rcv+0x3b1/0xab0 net/ipv4/ip_input.c:636
> >  ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:670
> >  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
> >  __netif_receive_skb_list_core+0x94e/0x980 net/core/dev.c:5762
> >  __netif_receive_skb_list net/core/dev.c:5814 [inline]
> >  netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
> >  netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5957
> >  xdp_recv_frames net/bpf/test_run.c:280 [inline]
> >  xdp_test_run_batch net/bpf/test_run.c:361 [inline]
> >  bpf_test_run_xdp_live+0x1b5e/0x21b0 net/bpf/test_run.c:390
> >  bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1318
> >  bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4266
> >  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5671
> >  __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f18af25a8e9
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffee4090af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18af25a8e9
> > RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
>
> @Menglong Dong: could you please have a look? The repro looks
> deterministic, so it should be doable to pin-point the actual, bad
> drop_reason and why/which function is triggering it. My wild guess is
> that an ERRNO is type-casted to drop reason instead of being converted.
>

You are right, I have figured out that the "-EINVAL" is returned
by mistake in fib_validate_source().

Sorry for that, and I'm sending a fix for it.

Thanks!
Menglong Dong

> Cheers,
>
> Paolo
>

