Return-Path: <netdev+bounces-89014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83D8A93E3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29268B224BE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7843C473;
	Thu, 18 Apr 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6wtcoUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA93B785
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424774; cv=none; b=gZHw4OE690LoeMi5LVjwk5oMHlw8mcAjiBACy8syHLhXRC9pleTGMovj/kyDePOSXfszaL+ZsaiLYFQn/KwfIKa1zN3Y3UVY/gwMLaCZ6PPLd7895DJ7I3SRTzCpetbXSmbQCV+DRBFQpumwlc3EulcdtDfquwtl1bQVpEhMFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424774; c=relaxed/simple;
	bh=L8YcdhZ/929GJYDUi4hFOO7VbGjn7TQv+DgPXFh5bD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+jB0CwkX61v1gQIjyxZlq+ukdAUfR71qumaEcxW/7e3QboQ3fZE0gaEeseWT5v+RLZ7BAL8xzQyVPW3rdSEZrpG3BFp0gRTNZ2J/X8Gb2vM6/94nBl3ywM81Rx/0KrpqkOuNzXxCxQ3uLadI/4KMs6Y9y6VIUo5diwIwRY+66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6wtcoUd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so6187a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713424771; x=1714029571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1JFw8F2RcMdPuXEEbrnNPIszl7+mNiCG8ijru9o5tQ=;
        b=T6wtcoUdLfIlmJXjyKDq5PZowIpVsUNfJPcCpamNHSGuIo2AhRBLjyS9FHauHjh4nP
         +7l47PcLXX2NTLKqxWa3gkOD/iZ8vpgQdjv9rnMD83WoeszpTVbzfJyaAgt2JYIjor2R
         iyIWybpX+xY4AKfAG3svi2pRR+ypzd0Y1DZkV17AVaNx1iErWC/Z/khu8Wn5wCzuk6F2
         3loMSx6+Lwnt1mUIIOPfSqi1naMAJsHx9L/CNDZvMjfrMTZ5SBSE3jLLHMKb4gJ4hYo3
         30/MwY5oSeaqPm+7KJ1X7+/KjN6CinVgvszQY5wTy3LTDu3bT8RilQHazVV6WBoVXsCz
         nDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424771; x=1714029571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1JFw8F2RcMdPuXEEbrnNPIszl7+mNiCG8ijru9o5tQ=;
        b=UKxucUf8OimaUpAH0GuqSkkKADhZQ9eZbuWTnDeSj12B5knjlq69UeHjiIQplvyrLc
         OFX0VAUgUL4yndIPwnuq0zr/BPbt6ozyiy7zKy94X4ySzu7tuRXJb/ROKoIDeK2OZ/lR
         JKW/DdUF8+/v6eCp72ePSY9rxYk/K5DawKez0x0ut5c6sLBvaLZ71lfkZY3noWQkJyhO
         nGRRBfwdgi78O3JQyuYHRbJkgUlyysTgosm2JY+0df9dRa8Zt2WbBl2hPLSt40LyjwZr
         C1tbq08X0JoXN+wOSdPbX72JTYS9J3PiitIZv/+yYFG+WvH5q3KZqotW+T21v3PkAK5g
         z7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDWJDwhV7ZXLv6tTGo92ZViX8Fa4KNouEtmiZAI52vh3iwryrwZQdNz1VzZNmQL9q2j0CU86JdM6tHv1oyX5xCo73SBqRS
X-Gm-Message-State: AOJu0YxcZcP7K68VvyHTXXd/1FE5dP6t6e6JzFfEaD8z99QydAP94oyT
	mQRsmIaWly4Ox1jObYaUhPXb4WLYpXmXM+KeSHhTS74EYzLAZFI70l10PZHjKJY/vKCvpb0paCP
	IVn/6feQnvxuUJMfU5SO0lOYZRqLVMBQzKUhu
X-Google-Smtp-Source: AGHT+IF9fOVv7EGsuXDUTMgM5+Tp2PO5VRf8PPpim6/XYhspGBOYwWn2u84X8Lcz0t4zKmykbgfsdzbm/koVfY8VENI=
X-Received: by 2002:a05:6402:34d5:b0:571:b8c4:bcc with SMTP id
 w21-20020a05640234d500b00571b8c40bccmr104621edc.6.1713424771112; Thu, 18 Apr
 2024 00:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003420e806165998ae@google.com>
In-Reply-To: <0000000000003420e806165998ae@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 09:19:20 +0200
Message-ID: <CANn89iLFjPiWdLw170ng2=9juwMnN8TxrKd1D1MntWPhWRxt-g@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipvlan_queue_xmit (2)
To: syzbot <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:05=E2=80=AFAM syzbot
<syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ke=
r..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D144a8d4a18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1b015d5670584=
72
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D42a0dc856239de4=
de60e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D149caa54180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10bb8e2218000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0dabc03369d1/dis=
k-f2e367d6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/240ca250d398/vmlinu=
x-f2e367d6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cc38bcdb48c9/b=
zImage-f2e367d6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in ipvlan_process_outbound drivers/net/ipvlan/ip=
vlan_core.c:524 [inline]
> BUG: KMSAN: uninit-value in ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan=
_core.c:602 [inline]
> BUG: KMSAN: uninit-value in ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ip=
vlan/ipvlan_core.c:668
>  ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
>  ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
>  ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
>  ipvlan_start_xmit+0x5c/0x1a0 drivers/net/ipvlan/ipvlan_main.c:222
>  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
>  xmit_one net/core/dev.c:3547 [inline]
>  dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
>  __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3819 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  __do_kmalloc_node mm/slub.c:3980 [inline]
>  __kmalloc_node_track_caller+0x705/0x1000 mm/slub.c:4001
>  kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
>  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
>  skb_segment+0x20aa/0x7080 net/core/skbuff.c:4647
>  udp6_ufo_fragment+0xcab/0x1150 net/ipv6/udp_offload.c:109
>  ipv6_gso_segment+0x14be/0x2ca0 net/ipv6/ip6_offload.c:152
>  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
>  nsh_gso_segment+0x6f4/0xf70 net/nsh/nsh.c:108
>  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
>  __skb_gso_segment+0x4b0/0x730 net/core/gso.c:124
>  skb_gso_segment include/net/gso.h:83 [inline]
>  validate_xmit_skb+0x107f/0x1930 net/core/dev.c:3628
>  __dev_queue_xmit+0x1f28/0x51c0 net/core/dev.c:4343
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> CPU: 1 PID: 5101 Comm: syz-executor421 Not tainted 6.8.0-rc5-syzkaller-00=
297-gf2e367d6ad3b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
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

Cc Kuniyuki Iwashima

This is the syzbot bug I mentioned earlier to you.

Thanks !

