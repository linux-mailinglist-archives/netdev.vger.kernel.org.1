Return-Path: <netdev+bounces-111785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08A9329C8
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B9A1C20884
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EB01990D7;
	Tue, 16 Jul 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZyFvzIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDF1420B6
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141660; cv=none; b=UrA//lZP0dajPaHrbSKurquxXsX8Ptkfh2AKb7O0eRunOVRj+OZ2q0sQgCM0Ni2EFKghQYLSbTDcto5bjnPMwpa89k/z50TLBL2lrh2fsyQdshKNsVIpAK6tVto/Gtj6dJhQ9OYonmQvSwdG1ixpkgcfAn3cZzdupdrQ2vLXKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141660; c=relaxed/simple;
	bh=8Bh6guIhZQVTnYNJwSnBOzgjlVjsEuz8MT5Z+AaE31s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQMCrWRpDbH94oBcrJ9vHfHCWBRRXeZIMacy0cUDzPh/b0QMCcMt78KPpVmiPkLicHgo1kkdySRPEGCrKwAeyGFtGNOG3nlJsc6Bpym8mKj+mZBF2sunVTvjvx3LnxzN9/MorTLbk7tTaFKP9PFm6Y1jyTvTqmD3rl8rNYsuxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZyFvzIC; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so146395ab.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721141658; x=1721746458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv+rvFn1x/U1DFPm5AX9SGRIgB+cdcVraNVGv0+q5no=;
        b=EZyFvzICSJTPyW/bdQBeyzNLrglMnS04yqsGnQga4ekxiYhpOUWBCoadouYpY5hUnz
         MyKWNWYES4qrU8TYurFOU7L4VS8n4qX+wWjGmVGoJWQoNBMCH+RhADTtk7ViX++KTIRM
         n45O9F8r0OWQ7yGea3b+YczXJhB2DvkxAsCTqRXynfXDv620BO4xKeWQUB0kOeK8ORPm
         1FxZ1pRTUS7jyL4ncLkkbT22rx2YuqYQbhx5OXmcYqioUFdffOGvzcaJ4NGAv1JGlX4G
         pp+TAFop5iyA3M7AacoooCyRZXZ9PwQ84vGyNCeo1eW8KWu8Xs2xTyWBaaYrrOhy1gZe
         aEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721141658; x=1721746458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv+rvFn1x/U1DFPm5AX9SGRIgB+cdcVraNVGv0+q5no=;
        b=wag40Wb+1K5ngceH39pGjzTh7ymll+g10y9VGqMfBA9ahui94xTRSBCFRCiYxuiyOq
         bB7Z3szk7ETUuFqmQJOFqXK7N4xX24X83MDgOA8A9oP+PyTMbs8/BgqnXo9t6O0qI8fd
         zjtZ0UhAH/E8vTzo0KEO/GnlM4X0fDpW4901vvyerevU6ioea0rEkNLQb1GR085gLN39
         dC3vyx52ac2I8g/uhn1IoltPVzEC1oNrU8w1q1afVSxx4uBv0nA+kPc0lORIvwSS5Bx3
         pwqDt5zldH0Q6FHHjmYkYgcdduLv9of0wbyNcfIzoiLo+zxwPRGW+7Ly87afawGQ53Cf
         qzSA==
X-Forwarded-Encrypted: i=1; AJvYcCV6jkqfVuFJ6I7dL9YdiQ/0QUP6t7pZVjbgmxRclNoIHvJW9D2nk6AY6uOHdxy369jGW6DsEa72OvRNXsMWIKN5hyWWbu8h
X-Gm-Message-State: AOJu0YzUGcqGzjQ/1MN4tNeoIYphEPFW668r/8Oc2sTYdSVs92hdXkW3
	umTTYbyLl0me3rARlmKm4DuMX3Os6UBY4ayHrWKuzBEINR/WfnXn7s+bVbqQeWuGnaklfTN4G7b
	90UDHAbXVWkKWpuOOyUfwIN+CD6l0kT8GCqrE
X-Google-Smtp-Source: AGHT+IEOhZKFncPOlx3bgVqvrSyoX8tV4isXtb7+LhHviIXxu2OBtWnGPIoOexXBZzILdhdEZ4iKmB1sjgFRmofa/uQ=
X-Received: by 2002:a05:6e02:1b08:b0:375:cd76:1602 with SMTP id
 e9e14a558f8ab-393c1e1f3a7mr3190755ab.28.1721141658176; Tue, 16 Jul 2024
 07:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e1609a061d5330ce@google.com> <5e4905d7-32e1-4359-9720-a32330aec424@redhat.com>
 <87wmll7i9n.fsf@cloudflare.com>
In-Reply-To: <87wmll7i9n.fsf@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jul 2024 07:54:00 -0700
Message-ID: <CANn89iKa8fyD2s1VdHJ2SQAUUzm-iPEXoKOGF6wvuqxofC4Frw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in skb_warn_bad_offload (5)
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	syzbot <syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com>, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, soheil@google.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:17=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jul 16, 2024 at 12:04 PM +02, Paolo Abeni wrote:
> > On 7/16/24 03:23, syzbot wrote:
> >> syzbot found the following issue on:
> >> HEAD commit:    80ab5445da62 Merge tag 'wireless-next-2024-07-11' of g=
it:/..
> >> git tree:       net-next
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D175fb82198=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2dbcdd8641=
c4638f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3De15b7e15b8a7=
51a91d9a
> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D172bf566=
980000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12fff53598=
0000
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/184da3869c30/=
disk-80ab5445.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/85bfe9b60f21/vml=
inux-80ab5445.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/06064623a94=
8/bzImage-80ab5445.xz
> >> The issue was bisected to:
> >> commit 10154dbded6d6a2fecaebdfda206609de0f121a9
> >> Author: Jakub Sitnicki <jakub@cloudflare.com>
> >> Date:   Wed Jun 26 17:51:26 2024 +0000
> >>      udp: Allow GSO transmit from devices with no checksum offload
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D142ccbe=
d980000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D162ccbe=
d980000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D122ccbed98=
0000
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
> >> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no che=
cksum offload")
> >> skb frag:     00000080: 62 3f 77 e4 0e 82 0d 2f 85 cc 44 ea 25 5a 99 7=
6
> >> skb frag:     00000090: f2 53
> >> ------------[ cut here ]------------
> >> ip6tnl0: caps=3D(0x00000006401d7869, 0x00000006401d7869)
> >> WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+=
0x166/0x1a0 net/core/dev.c:3291
> >> Modules linked in:
> >> CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkalle=
r-01603-g80ab5445da62 #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 06/07/2024
> >> RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
> >> Code: e8 5f 94 a3 f8 49 8b 04 24 48 8d 88 a0 03 00 00 48 85 c0 48 0f 4=
4 cd 48 c7 c7 00 cc c5 8c 4c 89 f6 48 89 da e8 fb 92 ff f7 90 <0f> 0b 90 90=
 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 44 89 f9
> >> RSP: 0018:ffffc900034bedc8 EFLAGS: 00010246
> >> RAX: 7d287cad4185da00 RBX: ffff888040cdc0b8 RCX: ffff888023d1bc00
> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >> RBP: ffffffff8cc5cbc0 R08: ffffffff815857b2 R09: fffffbfff1c39994
> >> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff888022880518
> >> R13: dffffc0000000000 R14: ffff888040cdc130 R15: ffff888040cdc130
> >> FS:  000055556e9e9380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000020001180 CR3: 000000007c876000 CR4: 00000000003506f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>   <TASK>
> >>   __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
> >>   skb_gso_segment include/net/gso.h:83 [inline]
> >>   validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
> >>   __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
> >>   neigh_output include/net/neighbour.h:542 [inline]
> >>   ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
> >>   ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
> >>   ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
> >>   udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
> >>   udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
> >>   sock_sendmsg_nosec net/socket.c:730 [inline]
> >>   __sock_sendmsg+0xef/0x270 net/socket.c:745
> >>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> >>   ___sys_sendmsg net/socket.c:2639 [inline]
> >>   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
> >>   __do_sys_sendmmsg net/socket.c:2754 [inline]
> >>   __se_sys_sendmmsg net/socket.c:2751 [inline]
> >>   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
> >>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> RIP: 0033:0x7f04f688fe89
> >> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 8=
9 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0=
 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007ffeebc526e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> >> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04f688fe89
> >> RDX: 0000000000000001 RSI: 0000000020003cc0 RDI: 0000000000000003
> >> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeebc52740
> >> R13: 00007f04f68dd406 R14: 0000000000000003 R15: 00007ffeebc52720
> >>   </TASK>
> >
> > Looking at the console log, the the relevant GSO packet is an UFO one w=
ith
> > CSUM_NONE. commit 10154dbded6d6a2fecaebdfda206609de0f121a9 only adjust =
the skb
> > csum for USO packets. @Jakub S. could you please have a look?
>
> Will do. Thanks for the hint.

The trigger for the bug is the following :

setsockopt(3, SOL_IPV6, IPV6_HOPOPTS,
"\0\3\0\0\0\0\0\0\5\2\0\0\0\1\0\302\4\200\0\0\0\5\2\0\6\302\4\0\0\0\1\302".=
..,
40) =3D 0

Some random IPV6_HOPTS, with multiple IPV6_TLV_JUMBO options

Non GSO path sends a malformed packet just fine, but GSO complains loudly.

(flowlabel 0x754ca, hlim 64, next-header Options (0) payload length:
186) localhost > localhost: HBH
(pad1)(pad1)(pad1)(pad1)(pad1)(pad1)(rtalert: 0x0000)
(pad1)(padn)(jumbo: 2147483648 - payload len !=3D 0) (rtalert: 0x0006)
(jumbo: 1 - already seen)  [|hbhopt]

