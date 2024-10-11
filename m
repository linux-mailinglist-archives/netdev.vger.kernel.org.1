Return-Path: <netdev+bounces-134564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00099A284
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DE528305D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57CE215023;
	Fri, 11 Oct 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggeiNJxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A017D2
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645201; cv=none; b=oEXbVHvc01hsZ9a5xz436O8mcQTtJcnJeS4u94y+YCD6nI0dnpG/gXG5kKtvHZM5gU0tlf8/Taw4cK9eUKAXw8lSZMpGQd9aAtgYQACF+p2Bp46gT1zKCw0pX+0ug9oIIMOA241oZN4P5lPdk+Munf+nMuprejCrVrScW+ChbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645201; c=relaxed/simple;
	bh=nS4faFlSiUDqrBE/RgDmN12VcZfAlUNv0bX4T1C9apM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GniKiIng3/BDCu/AwtrJaNqDPhJrRtuC+PRtKwORMYbwGsCyNDTsjvq6sZ3KezwyxX3uUKQ5zIuR1eYCq16gCHTbzyrX0f7Z4HtI04zauFXsfi4WgU3Fb0/Y6e4kN4spDGduIdGWUy2JKbHHOtlm6x88BruiJ+NQtOSsH0EDQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggeiNJxk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so2519827a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728645197; x=1729249997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI5iC8dm73D3LZ+RFta2UnjsQ3/rJ2IOcAI5wCq7cgw=;
        b=ggeiNJxkF5o0H+1UinumYGrISIjAWeq1kXTb0SsIJBEQ7bxGpVSi6YCuiCfrw1GmNj
         GZwl5POrnwii55CaryFReKzSGdNX1QleW9UmuAVHCBtIZZb1zG4KB+b47wq3eGSmhJhV
         DMvcIldoVZ1Y+2jThDMbz1wT8pquECeLOS+nclWf5kOAgr+JoKsqvpai4Pm4Sbeirs8Z
         gKqJu47+bqFs9p/tX0OvLjGexH+Rdlwq6Puq6ES2JJAXQrSqhOOdMGwtHKWL7hCLWAne
         6b2NUdDmzywZnpI29N3kkH4fMvCztwzm82qW5yIEdZYIQwDRBa+6erPGqAMnUDEzAKyl
         Lh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728645197; x=1729249997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI5iC8dm73D3LZ+RFta2UnjsQ3/rJ2IOcAI5wCq7cgw=;
        b=soEjTRvny41iDgyEdl4ybH0Wzux3PTXu9AbrgUi4Q1rxZhNjEPpZ6x6PwEwQB8YVqL
         lDOUMRh8FRZ1SdgVxi6ihVaE2pmDKNvAZJAomNRaMNwpzLkXjqqHqRBNohwxyBPB7hEH
         pUzTDvjAck9StzJcRHCGTjrZldSzlaeqCKilgQM5HBrk/0d67G+tAJCBAzwbjUPnzthU
         LzAPB8uOqU45cyxYEDskRq3ykdAnr2vFGsG1j8mI6iNylGJ2ySq14Atss9Y0o9hO/6uE
         ctZP5K1BcW79vztlvDJxolOte48Jpt4rS7ztSUwDLSPLAgBtXxx66XCAgAe+8UvMYv86
         LKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiY26RACWhwL2PAMRfQhruk+TjmL8AOvVxmMYvA6FKgqFaBACLeoU+W24jbpw3f/Dmy3t4+cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfCb0ql2Y3dr4f4b20jF72EkZS/wGM7g6jSm9ArtLOS48MZ95
	j77dxw+M4sgXtF8trxXHrQVEmFE8n3Lp+CAqlRO0mLyaPQJ/exNCfl2B5dd7DbqE0gny7/bjLr5
	SaBl65SYGl3l7JxT5x4Q2On2bpkvYtK5IuIDn
X-Google-Smtp-Source: AGHT+IF58r+qWw4r4Z1TRy24lZ4hMVAwi3YpVnwO7v841ug2Ui4qG0NhwF1IBtRJPOYn+9D9A5p6rpKwRSQn9h2lY9s=
X-Received: by 2002:a05:6402:3487:b0:5c9:4548:db8a with SMTP id
 4fb4d7f45d1cf-5c948cc7d30mr1768545a12.16.1728645196914; Fri, 11 Oct 2024
 04:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
In-Reply-To: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 13:13:03 +0200
Message-ID: <CANn89iKFB=T94_wRyND_Z_fGp-Wd9u0EHF_DXg-scQye_tb-Bw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] Lock RCU before calling ip6mr_get_table()
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:48=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Lock RCU before calling ip6mr_get_table() in several ip6mr functions.
>
> v4:
>   - mention in commit message that ip6mr_vif_seq_stop() would be called
>     in case ip6mr_vif_seq_start() returns an error
>   - fix unitialised use of mrt variable
>   - revert commit b6dd5acde3f1 ("ipv6: Fix suspicious RCU usage warning
>     in ip6mr")

Hi Stefan. I think a v5 is needed :)

Please double check your syslog

[   18.149447] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   18.149471] WARNING: suspicious RCU usage
[   18.149649] 6.12.0-rc2-virtme #1155 Not tainted
[   18.149726] -----------------------------
[   18.149747] net/ipv6/ip6mr.c:131 RCU-list traversed in non-reader sectio=
n!!
[   18.149792]
other info that might help us debug this:

[   18.149824]
rcu_scheduler_active =3D 2, debug_locks =3D 1
[   18.150050] 1 lock held by swapper/0/1:
[   18.150090] #0: ffffffff95b36390 (pernet_ops_rwsem){+.+.}-{3:3},
at: register_pernet_subsys (net/core/net_namespace.c:1356)
[   18.151482]
stack backtrace:
[   18.151716] CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.12.0-rc2-virtme #1155
[   18.151809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   18.151982] Call Trace:
[   18.152122]  <TASK>
[   18.152411] dump_stack_lvl (lib/dump_stack.c:123)
[   18.152411] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
[   18.152411] ip6mr_get_table (net/ipv6/ip6mr.c:131 (discriminator 9))
[   18.152411] ip6mr_net_init (net/ipv6/ip6mr.c:384
net/ipv6/ip6mr.c:238 net/ipv6/ip6mr.c:1317 net/ipv6/ip6mr.c:1309)
[   18.152411] ops_init (net/core/net_namespace.c:139)
[   18.152411] register_pernet_operations
(net/core/net_namespace.c:1239 net/core/net_namespace.c:1315)
[   18.152411] register_pernet_subsys (net/core/net_namespace.c:1357)
[   18.152411] ip6_mr_init (net/ipv6/ip6mr.c:1379)
[   18.152411] inet6_init (net/ipv6/af_inet6.c:1137)
[   18.152411] ? __pfx_inet6_init (net/ipv6/af_inet6.c:1076)
[   18.152411] do_one_initcall (init/main.c:1269)
[   18.152411] ? _raw_spin_unlock_irqrestore
(./arch/x86/include/asm/irqflags.h:42
./arch/x86/include/asm/irqflags.h:97
./arch/x86/include/asm/irqflags.h:155
./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[   18.152411] kernel_init_freeable (init/main.c:1330 (discriminator
1) init/main.c:1347 (discriminator 1) init/main.c:1366 (discriminator
1) init/main.c:1580 (discriminator 1))
[   18.152411] ? __pfx_kernel_init (init/main.c:1461)
[   18.152411] kernel_init (init/main.c:1471)
[   18.152411] ret_from_fork (arch/x86/kernel/process.c:153)
[   18.152411] ? __pfx_kernel_init (init/main.c:1461)
[   18.152411] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[   18.152411]  </TASK>

Thank you.

