Return-Path: <netdev+bounces-112919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26793BD50
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3327A283D6A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78F171E64;
	Thu, 25 Jul 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCK1M23F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78447171E40
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893683; cv=none; b=BOHuK8GC3SVhAWvDaGc8SUMK5OevE/JpnJone0ftH9B7X4JOpfkXsw7IjWF3vX9fCi/s/os7wrf1Oph5azUX8aLcBdlhMvpt4p1t5Q85qB+L4dEUhiTdtNolIpSWiUeM9I0BZtLM3vEBlTQ3lNer0z7kJdREFyXwEaWLmj5sdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893683; c=relaxed/simple;
	bh=Un3ywfhMAKXc1GXVQ6ZW/heu5eZHJL0vPtfHPNGqZ5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFxztv8/GlVc4w374ZzLFEMr/3A5O2tsyFzkxus+RxCkYxaGKtI/K3diUSPudR5U3+/MRGgyiTyiz3BuAbgZLJbgqoFtQ8sbtIiw4HmHe26HsKl/7XMOGgeqW0p0s6b9/5OqbjSaPtyAaHZPXFbdyq40SzeV5R+6xsTF9cxlfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCK1M23F; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso9752a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721893680; x=1722498480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCGWKjrWoshl6H68F9lar6GO9FnrLS6GdyfH/s87qJQ=;
        b=kCK1M23FWsGPCg7jqnzBfpz18i4Wg3Eb1+UoMLtN1Z1UqSQ0MgrkIVUaBfxWhwhPU8
         87ahBAD+za1Jp34biPaqdnlB9kMbkj6VIx7bp2+pQ7M9aO00nfEi3Lr17ZGPpPgKYtt4
         2F5QpEoY+evm/MZL44wcWZEdiV5sZB30weotFhMXE7AfsGeqtt8sg6NKoCMa2J5+v2wl
         E6eU9e7rtlrveA7lO2KvS5VYkdo6QduWC8F6jB/Q1JL0pmlaM05dpiNaVEXVjpBG6dPk
         mZAuunucmuUW9B1n09PAOOW6WhbqfBFPHm3/4Vw4hJZ6x8bLZsVA0QpXKrD1dxy05qLb
         /ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893680; x=1722498480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCGWKjrWoshl6H68F9lar6GO9FnrLS6GdyfH/s87qJQ=;
        b=SzmyWt8fbh7D15G0ujG3af6Afyk9Bb/y2AMI6DAzt8bcAPtJsXFAFJSYA/pre1rr9z
         paw0ulYdUxYdPtPdYU2ZFmP1KPcVV3kZLee0TI92K6GC1DBaJgHhG1VFvJU2HdjKrdQH
         CcoIyvNfzco0mD2Q1DoeOj5V7rhvFAlNZSB+n6BtYJfs2xcaO9ClPgSkqRG6pTHhBVFN
         3K7cKxAnhYeDi20/SqO9QUmwxg6OOc25DJG0TKfM8G1JckXc1NoNffkf5ST7uFKXBdsq
         n1u99AdsIgKKRR4+W5c6ZqxSWEvqAokmiSGsL2WIv+TfeJOa2BbcEt5W96tWVrZNlnAD
         qKag==
X-Forwarded-Encrypted: i=1; AJvYcCWKmZLxFLOOvwZkngO6pA7ib+Gn1kZ7+FDK3vw5USbR28ZK0sv5UKPRz1RoK68j2NW+dnUyCdQzVLk6hfoO7Y6jJA8Tslyt
X-Gm-Message-State: AOJu0YwSmR8oOGPvXN0pFGBoWV0el+fWAKg/KcQRo+G7+Apr8YlJXdfo
	3br3qA5iXmPO8UPusl7wG4dd4pEZPhPsIn2/+F0cBnNGvJ/GHoDHFr9QKT+3aSps4dCU9vrtkiJ
	pZOBpSmdh+MTfnxrnYJipLiO6MUCX0xxjwt7+
X-Google-Smtp-Source: AGHT+IGK9sBoV+zYaXMaYO7SSthTraaty8ZITM3xNb9OcjQAMZpJ4rMAC3af5DduNRkmMYDH5MoVzNoi2Dyn7SuON94=
X-Received: by 2002:a05:6402:40d5:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5ac2d052975mr156449a12.7.1721893679261; Thu, 25 Jul 2024
 00:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com>
In-Reply-To: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 09:47:47 +0200
Message-ID: <CANn89iLAhXWKkA5xZoZPDj--=hD7RxOTkAPVf31_xLU8L-qyjQ@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp: Disable TCP-AO static key after RCU grace period
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:00=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> The lifetime of TCP-AO static_key is the same as the last
> tcp_ao_info. On the socket destruction tcp_ao_info ceases to be
> with RCU grace period, while tcp-ao static branch is currently deferred
> destructed. The static key definition is
> : DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
>
> which means that if RCU grace period is delayed by more than a second
> and tcp_ao_needed is in the process of disablement, other CPUs may
> yet see tcp_ao_info which atent dead, but soon-to-be.

> And that breaks the assumption of static_key_fast_inc_not_disabled().

I am afraid I do not understand this changelog at all.

What is "the assumption of static_key_fast_inc_not_disabled()"  you
are referring to ?

I think it would help to provide more details.

>
> Happened on netdev test-bot[1], so not a theoretical issue:
>
> [] jump_label: Fatal kernel bug, unexpected op at tcp_inbound_hash+0x1a7/=
0x870 [ffffffffa8c4e9b7] (eb 50 0f 1f 44 !=3D 66 90 0f 1f 00)) size:2 type:=
1
> [] ------------[ cut here ]------------
> [] kernel BUG at arch/x86/kernel/jump_label.c:73!
> [] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [] CPU: 3 PID: 243 Comm: kworker/3:3 Not tainted 6.10.0-virtme #1
> [] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3=
-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [] Workqueue: events jump_label_update_timeout
> [] RIP: 0010:__jump_label_patch+0x2f6/0x350
> ...
> [] Call Trace:
> []  <TASK>
> []  arch_jump_label_transform_queue+0x6c/0x110
> []  __jump_label_update+0xef/0x350
> []  __static_key_slow_dec_cpuslocked.part.0+0x3c/0x60
> []  jump_label_update_timeout+0x2c/0x40
> []  process_one_work+0xe3b/0x1670
> []  worker_thread+0x587/0xce0
> []  kthread+0x28a/0x350
> []  ret_from_fork+0x31/0x70
> []  ret_from_fork_asm+0x1a/0x30
> []  </TASK>
> [] Modules linked in: veth
> [] ---[ end trace 0000000000000000 ]---
> [] RIP: 0010:__jump_label_patch+0x2f6/0x350
>
> [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/696681/5-c=
onnect-deny-ipv6/stderr
>
> Cc: stable@kernel.org
> Fixes: 67fa83f7c86a ("net/tcp: Add static_key for TCP-AO")
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
> ---
>  net/ipv4/tcp_ao.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 85531437890c..5ce914d3e3db 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -267,6 +267,14 @@ static void tcp_ao_key_free_rcu(struct rcu_head *hea=
d)
>         kfree_sensitive(key);
>  }
>
> +static void tcp_ao_info_free_rcu(struct rcu_head *head)
> +{
> +       struct tcp_ao_info *ao =3D container_of(head, struct tcp_ao_info,=
 rcu);
> +
> +       kfree(ao);
> +       static_branch_slow_dec_deferred(&tcp_ao_needed);
> +}
> +
>  void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
>  {
>         struct tcp_ao_info *ao;
> @@ -290,9 +298,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
>                         atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_a=
lloc);
>                 call_rcu(&key->rcu, tcp_ao_key_free_rcu);
>         }
> -
> -       kfree_rcu(ao, rcu);
> -       static_branch_slow_dec_deferred(&tcp_ao_needed);
> +       call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
>  }
>
>  void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *=
tp)
>
> ---
> base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
> change-id: 20240725-tcp-ao-static-branch-rcu-85ede7b3a1a5
>
> Best regards,
> --
> Dmitry Safonov <0x7f454c46@gmail.com>
>
>

