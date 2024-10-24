Return-Path: <netdev+bounces-138493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C986E9ADE4A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83795281B54
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 07:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81C1AE001;
	Thu, 24 Oct 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDOjie+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098CB1AAE02
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756416; cv=none; b=Om1IZe/VC99EawC2Xo6Dr2RFLpyOZB1D+xZ5K32dlwWIT6Zz8JP/27KJ3N2f8Pv2I25o5cOyl+hSjKdRnU4Cwdhm1WyiAXb5t7W6bEFHaQ+YXNEjpOsXdNtmtbd3q6Evx+R27onivA+4zs/GsWKq6MXnJxbm+IL8Xj8jp/eOPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756416; c=relaxed/simple;
	bh=vqqKtdA0tuUCI9eeNOtOdcTW4l5A8AJqd/v9gqg7Esw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiT+zKkORzRqAWwR2avGnyyHL0gqGX1ZKuTgN+AoXEE8ip7T/w4NhVEvTmUaNLp93SsZQRXI9ByJwjlkGDlm2nrP3hRkpiO+hnEjBXef1XzS0n859mMHhgfVdT75HZvDnq0I7LyKTIV4JLoCXpaJL1PFuhfZ67SRA1d+l7VZRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDOjie+Q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so694296a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 00:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729756412; x=1730361212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LT6OSfbAPKopxq8i2CNf2bpdH1xpDQ2LLKwCESXDew=;
        b=DDOjie+Q9kF0+Wx5E1QuH8sKMFTCXSGpPkWYDjdeTIIdMrHMRmXgYobvUzauo4uYuL
         RijRRy4Yu9C4uYv1ofjUuHSU5GvxV/2es57gS55ACQ085P/AnYHHELB82RaNFCfe3c2N
         aBJIw6CsztUFpFpTEwG6Oi7tv9mh3ucXCGUtXVNpzO3lZL9J3OTw6ikwGz6HoliYDhZM
         brkt10JXvOR8Yh2Lwvye+n20BsR/ezlsyW/zNsALAgKrQ4fJqf4JGaQxTVZvNmPCo5aF
         Pi2EFVuMaB4m3PiDytx/yTG9KAORxnwXLN3Rv1+ebuiozv0omVI8MLLWJCFLojJEiz08
         tAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756412; x=1730361212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LT6OSfbAPKopxq8i2CNf2bpdH1xpDQ2LLKwCESXDew=;
        b=OHs5ueedc86ebtEzCp6ZDAYyi8CoDT6470m3B5tNOY7kdSJGNgA5h5rA1rOzjChhJ9
         SMfUbYuZl7wSpCdCb5Giwbbenp+NDbJzLtSUOPfzVWe8zd1qqtdrnMxTSM1LXoZUImWL
         KacnENg0NaTLucTRbnkjaxBGlWrSIGhp+iHt0ShORM2ocMXa2pEq/q93tttOLL5vezW/
         hIPQJ+2+NX72rMhw0RmEgtAfG+ET5fbBwplOLyW2o6ckaw9x2vWakSOcIXs+57KA6uw6
         3esv+TPAL+IVYBQA4u9nojhuTOToiUwfxyRyTJFSwrEShIZVs0r2l5Aa7ex88hDUNCPR
         /4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtwoic4nzVWui0uXDQt7KSImzmJBxDZv4QLQnzpJRy5g7ixKRdmlHaxFWaTMLYCAyaL+W6Viw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5I2WvrcQ0Vo/isHcmNUmwAOlDwB0KBNFQkYgxfgGuNio09i14
	zmawMl8sggVv0VjLPZkAljgi93Cw/xdYME/iBC64YBNS/FUAG0uiMOojbfxIbLP85/1TYgynfKq
	SQFDLRHOpPSpFX9/fDBYfQghZW9gT41ldDuRq
X-Google-Smtp-Source: AGHT+IEHUd6iZ1v4/G6dQsAD9v6YuaMj1O/nHgtXRdkvnlnYO4dDHHqi7VG060ksZAcAqnWUz+yAbjuMm7YvDpHORoU=
X-Received: by 2002:a17:906:6a28:b0:a9a:6284:91db with SMTP id
 a640c23a62f3a-a9abf845712mr507193966b.3.1729756412114; Thu, 24 Oct 2024
 00:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+nYHL-ikgZ8CTsaDHjNReTwKCsZL5-Jm_V4NavJ=xGrQ9XQ2g@mail.gmail.com>
 <CA+nYHL-zekOQ-HWc0+7+y6nZi-_6=0mN_KLHfyGw-OJt0c3SyA@mail.gmail.com>
In-Reply-To: <CA+nYHL-zekOQ-HWc0+7+y6nZi-_6=0mN_KLHfyGw-OJt0c3SyA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Oct 2024 09:53:17 +0200
Message-ID: <CANn89iLs5Pb0jqq-+vFK4+obYgcWa=7SjXyLLLQr3hV87VsnNg@mail.gmail.com>
Subject: Re: WARNING: refcount bug in sk_skb_reason_drop
To: Xia Chu <jiangmo9@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:40=E2=80=AFAM Xia Chu <jiangmo9@gmail.com> wrote:
>
> We would like to extend our sincere apologies for the oversight. In our p=
revious email, we neglected to attach the kernel compilation configuration =
file, which we understand is essential for your review.
>
> Enclosed in this email, you will find the kernel configuration file that =
was missing.
>
> Once again, we apologize for any inconvenience this may have caused. If y=
ou require any further information or additional files, please do not hesit=
ate to let us know.
>

It would be nice you do not duplicate existing reports.

https://lore.kernel.org/lkml/66ff39a0.050a0220.49194.03f5.GAE@google.com/T/

Thank you

> Best regards,
> Ditto
>
> Xia Chu <jiangmo9@gmail.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=9B=9B 11:24=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi,
>>
>> We would like to report the following bug which has been found by our mo=
dified version of syzkaller.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> description: WARNING: refcount bug in sk_skb_reason_drop
>> affected file: net/core/skbuff.c
>> kernel version: 6.12.0-rc3
>> kernel commit: 6efbea77b390604a7be7364583e19cd2d6a1291b
>> git tree: upstream
>> kernel config: attached
>> crash reproducer: unattached
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> Crash log:
>> refcount_t: underflow; use-after-free.
>> WARNING: CPU: 1 PID: 8778 at lib/refcount.c:28 refcount_warn_saturate+0x=
10a/0x1a0
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 8778 Comm: syz-executor.4 Not tainted 6.12.0-rc3-0018=
3-g6efbea77b390 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubun=
tu1.1 04/01/2014
>> RIP: 0010:refcount_warn_saturate+0x10a/0x1a0
>> Code: 00 e6 1f 88 e8 87 50 e4 fd 90 0f 0b 90 90 eb d6 e8 1b c8 0d fe c6 =
05 56 47 6f 08 01 90 48 c7 c7 60 e6 1f 88 e8 67 50 e4 fd 90 <0f> 0b 90 90 e=
b b6 e8 fb c7 0d fe c6 05 33 47 6f 08 01 90 48 c7 c7
>> RSP: 0018:ffffc900004d8850 EFLAGS: 00010246
>> RAX: 1e2ad9b498ce2e00 RBX: 0000000000000003 RCX: ffff88804acaa500
>> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffffc900004d8860 R08: ffff88807ee28cd3 R09: 1ffff1100fdc519a
>> R10: dffffc0000000000 R11: ffffed100fdc519b R12: ffff88805167c0e4
>> R13: 0000000000000000 R14: ffff88805167c0e4 R15: 0000000000000000
>> FS:  000000003c279940(0000) GS:ffff88807ee00000(0000) knlGS:000000000000=
0000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000002000f000 CR3: 000000002aff8000 CR4: 0000000000752ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 55555554
>> Call Trace:
>>  <IRQ>
>>  sk_skb_reason_drop+0x141/0x150
>>  j1939_xtp_rx_cts+0x3fe/0x790
>>  j1939_tp_recv+0x65a/0xa40
>>  j1939_can_recv+0x527/0x650
>>  can_rcv_filter+0x22b/0x4d0
>>  can_receive+0x239/0x330
>>  can_rcv+0xf6/0x180
>>  __netif_receive_skb+0x119/0x280
>>  process_backlog+0x4b0/0xe90
>>  __napi_poll+0x7b/0x300
>>  net_rx_action+0x4df/0x930
>>  handle_softirqs+0x21f/0x6c0
>>  __do_softirq+0xf/0x16
>>  do_softirq+0xed/0x190
>>  </IRQ>
>>  <TASK>
>>  __local_bh_enable_ip+0x173/0x190
>>  _raw_spin_unlock_bh+0x33/0x40
>>  igmpv3_del_delrec+0x3c8/0x400
>>  ip_mc_up+0x171/0x260
>>  inetdev_event+0xa5d/0xea0
>>  notifier_call_chain+0x158/0x350
>>  raw_notifier_call_chain+0x31/0x40
>>  call_netdevice_notifiers_info+0xb5/0x100
>>  __dev_notify_flags+0x161/0x240
>>  dev_change_flags+0xb5/0xe0
>>  do_setlink+0x9e2/0x2900
>>  rtnl_newlink+0x1316/0x18d0
>>  rtnetlink_rcv_msg+0x637/0x970
>>  netlink_rcv_skb+0x187/0x2c0
>>  rtnetlink_rcv+0x20/0x30
>>  netlink_unicast+0x52a/0x600
>>  netlink_sendmsg+0x6c7/0x800
>>  __sock_sendmsg+0x14a/0x180
>>  __sys_sendto+0x33f/0x430
>>  __x64_sys_sendto+0x7e/0xa0
>>  x64_sys_call+0x2c2c/0x2ee0
>>  do_syscall_64+0xf6/0x230
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x41778a
>> Code: 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 89 =
ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 f=
f ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
>> RSP: 002b:00007ffc3ce57768 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>> RAX: ffffffffffffffda RBX: 0000000000a82200 RCX: 000000000041778a
>> RDX: 000000000000002c RSI: 0000000000a82250 RDI: 0000000000000003
>> RBP: 0000000000000000 R08: 00007ffc3ce5777c R09: 000000000000000c
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000a82250
>>  </TASK>
>>
>> We found similar bugs in the syzkaller-bugs mailing list (https://groups=
.google.com/g/syzkaller-bugs/c/rrilY4Y0KVQ/m/1Gj749LnAQAJ) and the kernel m=
ailing list (https://lore.kernel.org/lkml/66fec2e2.050a0220.9ec68.0046.GAE@=
google.com/), but they were all discovered on previous kernel versions (v6.=
11.0). We are continuing our efforts to generate a reproducer.
>>
>> Wishing you a nice day!
>>
>> Best regards,
>> Ditto

