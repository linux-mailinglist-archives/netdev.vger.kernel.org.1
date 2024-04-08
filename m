Return-Path: <netdev+bounces-85826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F889C72C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A9AB212BB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3813D8B6;
	Mon,  8 Apr 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgyU+xTs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B8127B54
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586884; cv=none; b=hMelZ3YzGaGok5mUBzoeelHoCT0H4XF5R3zz2ovXqo1sxWhVMfoRek9TB7MRmx5EmK40+BoAJ8E3ZjTnsIm+I/jLbvO/w2OugFSUVZG+vpwjyMj8qoK4Ys/9T7ZiFTSJDbbWmikdMRqNrjO6JjYUdiQeX1JCbLbKN7WIIgdUNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586884; c=relaxed/simple;
	bh=wps10wbVBLS1YyiedPXz/sC54Vibob6J7I+k54suVU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnnIwIUklC030/8QZ/JUliRRTY55XPhwWZIIeXnDjzg7jcFmPbXmttRMeTJu/lMXAvCSGQKjRzi5AuOL7yxIsyPkuOcl6/dMsPd0YzPmSup6Jn/hSksCXyLF2FygU/dfQ6XxINNcJgGy5GsMV7SkKDSMav79t7rrDXT3Uu3UhYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgyU+xTs; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a2667fdaeso97155ab.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712586882; x=1713191682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvAni71W+S1T0SWOUTqINdRjmFX8w3VSsK/A0qMF/70=;
        b=wgyU+xTsI6IdM+A4jkiPh9M+GM+0+v9XhaamLDYMD6iqnGg829+Qusq3hmTBHNHfd2
         d1T37uEVXz0v5X+MnwVRVrUoOfaG1CbXOijwAuwg5NNhHwgDw1NDxx6+Q+R6kqAV0+Xd
         PR+vk5nJwI0mng6YXcQDFpbbucrPmdErGgdNZIrhSr9kJzrnCHagPIo8CKGOr6+cYw4L
         VtIt0pY17iEYmcHy8i3yh7g1d4l1uU2lBg4Sjk0XxLFYrP0/nqJT3/c918tdajzpc8fB
         +oK2SVrhQ/b8/khilcOh0MSLpzftn+baynMbc+8KveEw3GvNhzOtJ0zC3JzpLVBI+s7l
         2FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586882; x=1713191682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvAni71W+S1T0SWOUTqINdRjmFX8w3VSsK/A0qMF/70=;
        b=ht+cKMcxwo4KhVMFGDsSqz1OjXvYPTkNfchvYkoipFP51Oh32IclAGxxpmvdxuRbE5
         Rdwc1CDDeShEA+aZ+rqt6klZy77knMHpkC4YtrszcVSjzM0aHDVlgK/0bVh9ClLbb9gG
         gDKjzyyLCev8N2vsSEQUDXscGFeV1bZU8Do602d1XQVeoUmBt+czUkVdVDqka+U/NBs0
         a0v45ugm2oJsz0Xv4EyfnfJFM1UfkTb4PUStuN4/HYzB24jPt60EZNxPd7kEhq37dPG2
         IgUHAQJY8WHlt3cBr+K8+hzHY2DpuWYdzF67DX1NMNq9obCeq2tm144V6ine1AxvIWuD
         /eUw==
X-Forwarded-Encrypted: i=1; AJvYcCWi/onaYHUPh/WBeA8a9UuQfCjlSgNF7kwhHfpHwhntqwlWRs73m/F02HNQcIg/mcXOySaKmma/ljnOX+lRvx9avFjV4eS9
X-Gm-Message-State: AOJu0Yw/+/dTlyTW8xgWfMQ3ZLQ62clXqW/e4ZEDuIS5owqIvuHGQmvS
	mSf9IBEJwXdH5+jM/AD5SvvPT1kmHkesTREzZ0F417BvRuJLqiZgeq51w+e5CBN6VCUXaHEwpil
	Vastwlwv/SdXDbLDKEdzBHYZMxqSsRaHGlVRN
X-Google-Smtp-Source: AGHT+IEa5hLIapkPLT6rHEF3Lp47MBBj9T2C/EmidL4mNfzESYUglls6/rLpdTj4cDsUhRa16CvdaLI+kB+5ORnqm8Y=
X-Received: by 2002:a05:6e02:1a45:b0:36a:1201:c733 with SMTP id
 u5-20020a056e021a4500b0036a1201c733mr552312ilv.11.1712586882178; Mon, 08 Apr
 2024 07:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219141220.908047-1-edumazet@google.com> <20240408143029.157864-1-aha310510@gmail.com>
In-Reply-To: <20240408143029.157864-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 16:34:30 +0200
Message-ID: <CANn89iLzbwg+5sYzCCt7dWzZ0p94Sh-AYAMyLnGUzSeT7R8zAg@mail.gmail.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
To: Jeongjun Park <aha310510@gmail.com>
Cc: daan.j.demeyer@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	eric.dumazet@gmail.com, kuba@kernel.org, kuniyu@amazon.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:30=E2=80=AFPM Jeongjun Park <aha310510@gmail.com> =
wrote:
>
> Eric Dumazet wrote:
> > syzbot reported a lockdep violation [1] involving af_unix
> > support of SO_PEEK_OFF.
> >
> > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> > sk_peek_off field), there is really no point to enforce a pointless
> > thread safety in the kernel.
> >
> > After this patch :
> >
> > - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> >
> > - skb_consume_udp() no longer has to acquire the socket lock.
> >
> > - af_unix no longer needs a special version of sk_set_peek_off(),
> >   because it does not lock u->iolock anymore.
>
> The method employed in this patch, which avoids locking u->iolock in
> SO_PEEK_OFF, appears to have effectively remedied the immediate vulnerabi=
lity,
> and the patch itself seems robust.
>
> However, if a future scenario arises where mutex_lock(&u->iolock) is requ=
ired
> after sk_setsockopt(sk), this patch would become ineffective.
>
> In practical testing within my environment, I observed that reintroducing
> mutex_lock(&u->iolock) within sk_setsockopt() triggered the vulnerability=
 once again.
>
> Therefore, I believe it's crucial to address the fundamental cause trigge=
ring this vulnerability
> alongside the current patch.
>
> [   30.537400] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   30.537765] WARNING: possible circular locking dependency detected
> [   30.538237] 6.9.0-rc1-00058-g4076fa161217-dirty #8 Not tainted
> [   30.538541] ------------------------------------------------------
> [   30.538791] poc/209 is trying to acquire lock:
> [   30.539008] ffff888007a8cd58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: __unix=
_dgram_recvmsg+0x37e/0x550
> [   30.540060]
> [   30.540060] but task is already holding lock:
> [   30.540482] ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgra=
m_recvmsg+0xec/0x550
> [   30.540871]
> [   30.540871] which lock already depends on the new lock.
> [   30.540871]
> [   30.541341]
> [   30.541341] the existing dependency chain (in reverse order) is:
> [   30.541816]
> [   30.541816] -> #1 (&u->iolock){+.+.}-{3:3}:
> [   30.542411]        lock_acquire+0xc0/0x2e0
> [   30.542650]        __mutex_lock+0x91/0x4b0
> [   30.542830]        sk_setsockopt+0xae2/0x1510
> [   30.543009]        do_sock_setsockopt+0x14e/0x180
> [   30.543443]        __sys_setsockopt+0x73/0xc0
> [   30.543635]        __x64_sys_setsockopt+0x1a/0x30
> [   30.543859]        do_syscall_64+0xc9/0x1e0
> [   30.544057]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> [   30.544652]
> [   30.544652] -> #0 (sk_lock-AF_UNIX){+.+.}-{0:0}:
> [   30.544987]        check_prev_add+0xeb/0xa20
> [   30.545174]        __lock_acquire+0x12fb/0x1740
> [   30.545516]        lock_acquire+0xc0/0x2e0
> [   30.545692]        lock_sock_nested+0x2d/0x80
> [   30.545871]        __unix_dgram_recvmsg+0x37e/0x550
> [   30.546066]        sock_recvmsg+0xbf/0xd0
> [   30.546419]        ____sys_recvmsg+0x85/0x1d0
> [   30.546653]        ___sys_recvmsg+0x77/0xc0
> [   30.546971]        __sys_recvmsg+0x55/0xa0
> [   30.547149]        do_syscall_64+0xc9/0x1e0
> [   30.547428]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> [   30.547740]
> [   30.547740] other info that might help us debug this:
> [   30.547740]
> [   30.548217]  Possible unsafe locking scenario:
> [   30.548217]
> [   30.548502]        CPU0                    CPU1
> [   30.548713]        ----                    ----
> [   30.548926]   lock(&u->iolock);
> [   30.549234]                                lock(sk_lock-AF_UNIX);
> [   30.549535]                                lock(&u->iolock);
> [   30.549798]   lock(sk_lock-AF_UNIX);
> [   30.549970]
> [   30.549970]  *** DEADLOCK ***
> [   30.549970]
> [   30.550504] 1 lock held by poc/209:
> [   30.550681]  #0: ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix=
_dgram_recvmsg+0xec/0x550
> [   30.551100]
> [   30.551100] stack backtrace:
> [   30.551532] CPU: 1 PID: 209 Comm: poc Not tainted 6.9.0-rc1-00058-g407=
6fa161217-dirty #8
> [   30.551910] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.15.0-1 04/01/2014
> [   30.552539] Call Trace:
> [   30.552788]  <TASK>
> [   30.552987]  dump_stack_lvl+0x68/0xa0
> [   30.553429]  check_noncircular+0x135/0x150
> [   30.553626]  check_prev_add+0xeb/0xa20
> [   30.553811]  __lock_acquire+0x12fb/0x1740
> [   30.553993]  lock_acquire+0xc0/0x2e0
> [   30.554234]  ? __unix_dgram_recvmsg+0x37e/0x550
> [   30.554543]  ? __skb_try_recv_datagram+0xb2/0x190
> [   30.554752]  lock_sock_nested+0x2d/0x80
> [   30.554912]  ? __unix_dgram_recvmsg+0x37e/0x550
> [   30.555097]  __unix_dgram_recvmsg+0x37e/0x550
> [   30.555498]  sock_recvmsg+0xbf/0xd0
> [   30.555661]  ____sys_recvmsg+0x85/0x1d0
> [   30.555826]  ? __import_iovec+0x177/0x1d0
> [   30.555998]  ? import_iovec+0x1a/0x20
> [   30.556401]  ? copy_msghdr_from_user+0x68/0xa0
> [   30.556676]  ___sys_recvmsg+0x77/0xc0
> [   30.556856]  ? __fget_files+0xc8/0x1a0
> [   30.557612]  ? lock_release+0xbd/0x290
> [   30.557799]  ? __fget_files+0xcd/0x1a0
> [   30.557969]  __sys_recvmsg+0x55/0xa0
> [   30.558284]  do_syscall_64+0xc9/0x1e0
> [   30.558455]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> [   30.558740] RIP: 0033:0x7f3c14632dad
> [   30.559329] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a ef f=
f ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2f 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 9e ef f8
> [   30.560156] RSP: 002b:00007f3c12c43e60 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000002f
> [   30.560582] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3c1=
4632dad
> [   30.560933] RDX: 0000000000000000 RSI: 00007f3c12c44eb0 RDI: 000000000=
0000005
> [   30.562935] RBP: 00007f3c12c44ef0 R08: 0000000000000000 R09: 00007f3c1=
2c45700
> [   30.565833] R10: fffffffffffff648 R11: 0000000000000293 R12: 00007ffe9=
3a2bfde
> [   30.566161] R13: 00007ffe93a2bfdf R14: 00007f3c12c44fc0 R15: 000000000=
0802000
> [   30.569456]  </TASK>
>
>
>
>
> What are your thoughts on this?

You are talking about some unreleased code ?

I can not comment, obviously.

