Return-Path: <netdev+bounces-63232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08182BE82
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6983728F89E
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71155DF0D;
	Fri, 12 Jan 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeLrG4wP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C25EE73
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso6454a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705054863; x=1705659663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebQPfqGhQXhZ/yqtWfCFcVWbHmSK422dE5OxMGjeNoc=;
        b=WeLrG4wPv6+QtjukvvzyYXAhZsjI6xWrcIF2MfKwhKxRWY5WwJAJSMGNOH8GtwpVon
         C36XC4u6yzVKAbo7+/iAQosmpP7aIBJtX2eb+ylJUw6yJz+BrK1CxMLmhByvqdlQWq/x
         BpNSyFEhqu8tXdVngggn+2pftmKoIPB44bh/UMgBjhTNqo25LO5dQ2Bh7LWCl7XM7OVp
         Q/v6Vr/fDivOjviWo5tWR8mlepvovHp03+7JkAyJVQAc0AvxOOMybq2J2nACOuKv/N0C
         pn4yeYabUYsJfanKN1nSvmh32MkLLrTp2kYasNKVpx2T9viNRBvaznjxGBpmf9oIAjT0
         7MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054863; x=1705659663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebQPfqGhQXhZ/yqtWfCFcVWbHmSK422dE5OxMGjeNoc=;
        b=gz0eJXLCSa01tuJI7vAYze3DqttwABG/lsiWBtZ1+zeo06OL/pwNBoPSpH+1sRXTP6
         Wt9yhr/yRlYDvo0lgzcALCRmK3pQ1Vc2NCjDdoSH/qSYurmcLmBSJJQdSztzu1VRFReM
         HGddfWlu0E19Y8QGqnAEYRWhbSwHSBzMs9Gk/BMEydzpKiXpAABWPrPBWuHHsToRyOsJ
         2Bbi/Y+IHnwykQb8Zj2pgpA0Ke8hMBYWKScQgbm90u8VUPvBBOfzF4DRW2UGdNtvPfEP
         5AWIW4ZRUisn5SDdce6sM2iNSR8WpAnWm/ymtvYKYCmTcYLZZ79H8KKK1A8x5hHisEbw
         lv8w==
X-Gm-Message-State: AOJu0YxN5ekrGvdHJH2DTWYTZTQjxLGaiMZHqlexEMxTiji0U4AgmDgO
	yqjOMkwGOGt52ExTDliX4aM+EsDIpc7UzU18jLVRZsyEjTt/
X-Google-Smtp-Source: AGHT+IEwfEZ45RhlAnRJiWyNCM3Z8ctMp9AJZ7V0OYpqaKOIlC0QXJBMeyinjznbE0S7OxAfO84FWwGTLVIexHPIddA=
X-Received: by 2002:a05:6402:34c4:b0:554:2501:cc8e with SMTP id
 w4-20020a05640234c400b005542501cc8emr276108edc.6.1705054862918; Fri, 12 Jan
 2024 02:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009e46c3060ebcdffd@google.com>
In-Reply-To: <0000000000009e46c3060ebcdffd@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jan 2024 11:20:49 +0100
Message-ID: <CANn89iJsn4WY025VeThuQ25Vwn=51HJ+f-N7qw0VD4huHk0YeA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg (6)
To: syzbot <syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:10=E2=80=AFAM syzbot
<syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0dd3ee311255 Linux 6.7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1713a06de8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1bb2daade28c9=
0a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8d482d0e407f665=
d9d10
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b3bdaecbc4f5/dis=
k-0dd3ee31.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6656b77ef58a/vmlinu=
x-0dd3ee31.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/85fa7f08c720/b=
zImage-0dd3ee31.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg
>
> write to 0xffff88814e5eadf0 of 4 bytes by task 15547 on cpu 1:
>  udpv6_sendmsg+0x1405/0x1530 net/ipv6/udp.c:1596
>  inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x257/0x310 net/socket.c:2192
>  __do_sys_sendto net/socket.c:2204 [inline]
>  __se_sys_sendto net/socket.c:2200 [inline]
>  __x64_sys_sendto+0x78/0x90 net/socket.c:2200
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> read to 0xffff88814e5eadf0 of 4 bytes by task 15551 on cpu 0:
>  udpv6_sendmsg+0x22c/0x1530 net/ipv6/udp.c:1373
>  inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2586
>  ___sys_sendmsg net/socket.c:2640 [inline]
>  __sys_sendmmsg+0x269/0x500 net/socket.c:2726
>  __do_sys_sendmmsg net/socket.c:2755 [inline]
>  __se_sys_sendmmsg net/socket.c:2752 [inline]
>  __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2752
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> value changed: 0x00000000 -> 0x0000000a
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 15551 Comm: syz-executor.1 Tainted: G        W          6.7.0=
-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Hmm, I thought I already sent a patch for this issue, let me find it
in my trees.

