Return-Path: <netdev+bounces-141887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBBA9BC99F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52633B2362B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C91D0E3A;
	Tue,  5 Nov 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVInRM6H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1681CEEB4
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800369; cv=none; b=comyMdx8bGiQKdRvKwrqw5vhKhcn7jq1Ef189d7dT9Gs6X6LBKnZZ4hTGko81dv6bKmLUvhW9K/e36gG+Ux9h0MGcVRMP9B57y7SRpVSXsQaX+395M3jcXsCzsiEBkR9MAGjnMSjeSIYWmXcTuFNrd5A++meEew5d9HgnaKJr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800369; c=relaxed/simple;
	bh=QNIrwhadNif68dVff17QnahTUQKNU8HNUfA6xYNEZQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTJo6FqJjALvb/StWWfcYHC95OtGwt2AHDSmq3a65ImU8dXv6hYv0dBk6PQPGk/hbzeL0t/UfDhGl4r2h94D3zHkgF4KYek0gc8Iv7As1G/dNGVDg8sOADt5wv6aPzGY/CURVBvw6pLWV4PWov7xniJr6fRx5u56BCk8ZKWRHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVInRM6H; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso6831417a12.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730800366; x=1731405166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5i34kIJfNNRCtgcy3ZNg46rlRxERG959AeGUzU8geQ=;
        b=bVInRM6Hp2gPsX0Ma/s4y+WMXHyInWHzUjODoIeLvTrVsOgeOtb33f2lANfedjPUx5
         yZgEU/wtqmC7qG4zDT41D4o5hVaNkE4F08ZDeI7FdqVuTVue4jNqJfnN55ljx6iZsRae
         NTk+oYv0e5sIj8lqwGXezBBYI3suDBUUKI7cPRfcejsuYhswuW+3SKkLvN5kWRfMDU5E
         SdkDgbR/nuE6O89lnEnSPb2rc9powlLDQHhObBwkhEmFTQ8YWlL5S3sTeOzEgfCtFSW7
         fMElKBFM8cUNmwu3r69ezS+cwmEd6zncdsANXLQFmL+goWSk22rF4kXDpeCo6rsBc4PQ
         0CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800366; x=1731405166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5i34kIJfNNRCtgcy3ZNg46rlRxERG959AeGUzU8geQ=;
        b=pgkpYJg0icH8ZL9uNIid/yk7fF5IEIcrHE/w+foMAa7UGUZS97X7plgj6f54wLuXFz
         8ykJEy5jTej68IMNPCjecSSLVd7POyPWW5cJlt4ixtNCkcLMhqfsCUwnAXLGmhhJTgAJ
         8rbOns+Lh95wMtMKPPd6wsxDLBbIgDxSZAxJDvixE+aAPIbBBFeZgQxB/k7mAI0VcB2l
         ilTY9Fagv9RIB/ydKCRfKaKV1eSxsp4xrbGidNu3b0XpWtkZ7mXx8Rl44Ppy55G/N95b
         K1dxvUcB1VNTgnf4FsLAlQpkkyiAKLk9Y5ZM9i6xV9GDAqS8LqJaAvgJmdwg4HNv5CSq
         0Atw==
X-Forwarded-Encrypted: i=1; AJvYcCV9zARk4wgsgwbWhVuHnR2SY0Fit2MSt1IkAd2aNiwah1MUFlJMpJobpbM1rZpabNvcTLFiAk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3E89fUlaWb10U6rjdge5EnBcFWiTqxOisuxyFn8VxTFfCPxR
	hyG+B3gNeaUYCPXzivtiHSLD0TAqAWA3+rWius8hUGehlRjTZlNsDAa0C9lp65FEX/tsFTxiS8k
	sPuVnG2CGRBXFk03C2G0Z4pzEGTscD1iin+X9
X-Google-Smtp-Source: AGHT+IHmfC8lmwEAlAyKzmgyIPP2LQmgV5ugfdamIPylT6XF1ZoR/MZRVtscO9C8VO6NKQ5mQsGScrz4SU2+dz/KS1w=
X-Received: by 2002:a05:6402:50cc:b0:5cb:7877:a633 with SMTP id
 4fb4d7f45d1cf-5ceb9383c7dmr8802354a12.33.1730800365881; Tue, 05 Nov 2024
 01:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105080305.717508-1-wangliang74@huawei.com>
In-Reply-To: <20241105080305.717508-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 10:52:34 +0100
Message-ID: <CANn89iJ8mOqtOkMvrn6c892XrA_m3uf5FabmDWzA_pk-tTMCzw@mail.gmail.com>
Subject: Re: [RFC PATCH net v2] net: fix data-races around sk->sk_forward_alloc
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@amazon.com, luoxuanqiang@kylinos.cn, 
	kernelxing@tencent.com, kirjanov@gmail.com, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:46=E2=80=AFAM Wang Liang <wangliang74@huawei.com> =
wrote:
>
> Syzkaller reported this warning:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1=
c5/0x1e0
>  Modules linked in:
>  CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
>  RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>  Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 =
e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0=
f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>  RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>  RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>  RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>  RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>  R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>  R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>  FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x88/0x130
>   ? inet_sock_destruct+0x1c5/0x1e0
>   ? report_bug+0x18e/0x1a0
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? inet_sock_destruct+0x1c5/0x1e0
>   __sk_destruct+0x2a/0x200
>   rcu_do_batch+0x1aa/0x530
>   ? rcu_do_batch+0x13b/0x530
>   rcu_core+0x159/0x2f0
>   handle_softirqs+0xd3/0x2b0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   run_ksoftirqd+0x25/0x30
>   smpboot_thread_fn+0xdd/0x1d0
>   kthread+0xd3/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>
> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
> concurrently when sk->sk_state =3D=3D TCP_LISTEN with sk->sk_lock unlocke=
d,
> which triggers a data-race around sk->sk_forward_alloc:
> tcp_v6_rcv
>     tcp_v6_do_rcv
>         skb_clone_and_charge_r
>             sk_rmem_schedule
>                 __sk_mem_schedule
>                     sk_forward_alloc_add()
>             skb_set_owner_r
>                 sk_mem_charge
>                     sk_forward_alloc_add()
>         __kfree_skb
>             skb_release_all
>                 skb_release_head_state
>                     sock_rfree
>                         sk_mem_uncharge
>                             sk_forward_alloc_add()
>                             sk_mem_reclaim
>                                 // set local var reclaimable
>                                 __sk_mem_reclaim
>                                     sk_forward_alloc_add()
>
> In this syzkaller testcase, two threads call
> tcp_v6_do_rcv() with skb->truesize=3D768, the sk_forward_alloc changes li=
ke
> this:
>  (cpu 1)             | (cpu 2)             | sk_forward_alloc
>  ...                 | ...                 | 0
>  __sk_mem_schedule() |                     | +4096 =3D 4096
>                      | __sk_mem_schedule() | +4096 =3D 8192
>  sk_mem_charge()     |                     | -768  =3D 7424
>                      | sk_mem_charge()     | -768  =3D 6656
>  ...                 |    ...              |
>  sk_mem_uncharge()   |                     | +768  =3D 7424
>  reclaimable=3D7424    |                     |
>                      | sk_mem_uncharge()   | +768  =3D 8192
>                      | reclaimable=3D8192    |
>  __sk_mem_reclaim()  |                     | -4096 =3D 4096
>                      | __sk_mem_reclaim()  | -8192 =3D -4096 !=3D 0
>
> The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
> sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
> Fix the same issue in dccp_v6_do_rcv().
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

