Return-Path: <netdev+bounces-90866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D58B0897
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5481C230F0
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9A115A49E;
	Wed, 24 Apr 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1EUzRWB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4815AAA2
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959187; cv=none; b=Rx4xvw2UuMIIMj6uHwXMcAtR5wWfcgAAfaiOZ+ci2O5SYevC/7wAKoFfBdPnqOh7g1r848vqKG7/3dBZNRHD3Mz69b7PdLJPoRHkiSqsVu6UNNVedOzjCn0QXav+LEA17elANt0ceX6pEbXDlQPbdhABiNB0+7BZwdoiDDiaWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959187; c=relaxed/simple;
	bh=YNYJi6cEqOvVVMQDDQJtskAvgY9bs2fWlkzj7uBfRwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdryZ9heZw0e/Pr5QJCcMIIlKhubiHs4j1wauwzUWGDZWVS8toPYm6pcxJquFKkA8RS2akwFcGcCZnrJf57fZ7xiruUtcu8kqvqSU6M5w8oGIxxKaItg/AnjQz/kOn47sPuauueOB8x/1UmflUTVVA8fJoq9VT0xHZglEvb5xkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1EUzRWB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5188f5dd62dso2225e87.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713959183; x=1714563983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stF6XQXPOK3syxR2hB6fALhgrM3p/9SOTzxAeUPiNCU=;
        b=z1EUzRWBiZrIP0VB85aj/b1THFdxiThUiMxIgFhGKm8FSbs63UJlZHgW/AGaVceO/G
         PwxF8GdmIeiE4G72Mvg2LCe1UsEj51JP3zifFubjFdjRHNpogl9LVRSNCUlJq4V7tiYK
         HfLZurhacW709oGqYDxR36tyMI9K5EFcMH3qwT0uBlD+PvLZQRtPHHOQ99KKv883brbN
         mXKYB8T38DEy3Om++hok3k8efpks733CLcSOqT4gn3vANpYPw7Mq1zHrkONvf34qMtzM
         OuDX6K1zaBpZ3xb3GRRVrjYu+5OZhPvCg3nQtRd7xKp56w5D6ISheZLMofL7aQqZAP9J
         uq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959183; x=1714563983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stF6XQXPOK3syxR2hB6fALhgrM3p/9SOTzxAeUPiNCU=;
        b=F4ewTWvBMRFTUuyJPrrqXPutAJvjw+FlpfWd33uuIVayBnh9CtiwFkNpE3bHGE+pTN
         W1CNkxP+WkekVKaqRZv5Jg4fdb/7Uzc9MJTeARPEv/TNUDkyCR85AeEJgdj4Wk1UP8tO
         mUcR6d3xfRXjf5cUR3g5AO05kuzoMqRVUV+1+u9X5OjFJTdbsI5Vm3pUrpBJC5IV2FEw
         A3+StMSNR8zxsABMRDP66+iwwJCi9eS0eQahNtTCFuLC57z/LROTiIsJX97ff6YUipZm
         kWaLVKppEfr93uWRGpt1LllI4kyJCuIWWandSjzeak0sN4+5QvdYcytfGGC2Y3f25Fc4
         O9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVnD5X+dgT7JaHhK18XzQhv3CUWbBFcCxA49LbuT+L+q4CIUl++yYvZRG9013xVJmqq6EAPcexNLeIEcjswGU+Sm0VKppba
X-Gm-Message-State: AOJu0Ywubh2Ji//eJp3CDmiO+RNfeggQp9eG90RcjGmc35EEbopP3VO6
	0VICIeu/tcnN5UsJ6SEoZpjdm/nBSqgayoIAopUl3rccmb8OToDk6LGAtrdlfszP8qXjJX0ccEs
	WjT4DX/430rmFUM0nocuhtBx9C3829cs0jz5g
X-Google-Smtp-Source: AGHT+IHTzyX92JLumyY9q0YZs37nZQqBdG6mEnJhIbHcpxJ/E0tNGWoRe/Iv+8fHq6Ti4r6tURwlLC+Zz8pkXqyHSKs=
X-Received: by 2002:a19:9151:0:b0:51b:7ff1:49d9 with SMTP id
 y17-20020a199151000000b0051b7ff149d9mr122472lfj.6.1713959183151; Wed, 24 Apr
 2024 04:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421184326.1704930-1-edumazet@google.com> <3a6412ee6a4faf6f6107217c67ef5aad9532f89a.camel@redhat.com>
In-Reply-To: <3a6412ee6a4faf6f6107217c67ef5aad9532f89a.camel@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 24 Apr 2024 13:46:07 +0200
Message-ID: <CACT4Y+aK-F2YDsxQKd5F0ROO3EGiMykERV43UFgtGnbjJSMNvQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: check for NULL idev in ip_route_use_hint()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 15:57, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Sun, 2024-04-21 at 18:43 +0000, Eric Dumazet wrote:
> > syzbot was able to trigger a NULL deref in fib_validate_source()
> > in an old tree [1].
> >
> > It appears the bug exists in latest trees.
> >
> > All calls to __in_dev_get_rcu() must be checked for a NULL result.
> >
> > [1]
> > general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 2 PID: 3257 Comm: syz-executor.3 Not tainted 5.10.0-syzkaller #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> >  RIP: 0010:fib_validate_source+0xbf/0x15a0 net/ipv4/fib_frontend.c:425
> > Code: 18 f2 f2 f2 f2 42 c7 44 20 23 f3 f3 f3 f3 48 89 44 24 78 42 c6 44 20 27 f3 e8 5d 88 48 fc 4c 89 e8 48 c1 e8 03 48 89 44 24 18 <42> 80 3c 20 00 74 08 4c 89 ef e8 d2 15 98 fc 48 89 5c 24 10 41 bf
> > RSP: 0018:ffffc900015fee40 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffff88800f7a4000 RCX: ffff88800f4f90c0
> > RDX: 0000000000000000 RSI: 0000000004001eac RDI: ffff8880160c64c0
> > RBP: ffffc900015ff060 R08: 0000000000000000 R09: ffff88800f7a4000
> > R10: 0000000000000002 R11: ffff88800f4f90c0 R12: dffffc0000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800f7a4000
> > FS:  00007f938acfe6c0(0000) GS:ffff888058c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f938acddd58 CR3: 000000001248e000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   ip_route_use_hint+0x410/0x9b0 net/ipv4/route.c:2231
> >   ip_rcv_finish_core+0x2c4/0x1a30 net/ipv4/ip_input.c:327
> >   ip_list_rcv_finish net/ipv4/ip_input.c:612 [inline]
> >   ip_sublist_rcv+0x3ed/0xe50 net/ipv4/ip_input.c:638
> >   ip_list_rcv+0x422/0x470 net/ipv4/ip_input.c:673
> >   __netif_receive_skb_list_ptype net/core/dev.c:5572 [inline]
> >   __netif_receive_skb_list_core+0x6b1/0x890 net/core/dev.c:5620
> >   __netif_receive_skb_list net/core/dev.c:5672 [inline]
> >   netif_receive_skb_list_internal+0x9f9/0xdc0 net/core/dev.c:5764
> >   netif_receive_skb_list+0x55/0x3e0 net/core/dev.c:5816
> >   xdp_recv_frames net/bpf/test_run.c:257 [inline]
> >   xdp_test_run_batch net/bpf/test_run.c:335 [inline]
> >   bpf_test_run_xdp_live+0x1818/0x1d00 net/bpf/test_run.c:363
> >   bpf_prog_test_run_xdp+0x81f/0x1170 net/bpf/test_run.c:1376
> >   bpf_prog_test_run+0x349/0x3c0 kernel/bpf/syscall.c:3736
> >   __sys_bpf+0x45c/0x710 kernel/bpf/syscall.c:5115
> >   __do_sys_bpf kernel/bpf/syscall.c:5201 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5199 [inline]
> >   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5199
> >
> > Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Thanks for fixing it!
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>
> syzbot took surprisingly long to spot this, I guess the race window is
> very tiny? (or syzbot learned new tricks...)

From the stack it looks like this requires creating a non-trivial
valid BPF program, this may still be challenging for the fuzzer.

