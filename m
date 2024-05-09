Return-Path: <netdev+bounces-95054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB438C1539
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6939C1F22B61
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB37F484;
	Thu,  9 May 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HhPg85s/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DC653
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282031; cv=none; b=MsihbmJ6YwLwhVrRNcrVwyTC4m9tgS6qxNf8E+V3KEdsykr9WitvmggPfrfcFkjmkSZNX+nDb1eJK8ZnrX9H/wN4LVMfsXyl4NtDBGwA1GENoIDIEB3nRaeG8ecjlXdK69fp9INlACCRmF4z+w26dL3XnyExKdlRYSF8euTl0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282031; c=relaxed/simple;
	bh=1G0QDR8JUJFyxaGNVbL1UI3DtGhHUGbyrMYHlnXXzhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7cBFcv7gt0S+AZiVGAqDXCn0kW70DQ4uKqDCxj9HwKsQaeCdQ7K2WnuOsnTYhF8rULqaAvURBO0Vy0JjVwXbYkSalKiYDsQkvNqPAW7V/GQrpoxDc2xL5ks1kPVO16cLR0I8Fq2MnkABektFHxVYgiwlaRfLJasKPcl1j7a3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HhPg85s/; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-620390308e5so11074787b3.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715282027; x=1715886827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5+CpfPTydUeT3vKTfUos21UxKzlhAl+5pqEA8g6EMk=;
        b=HhPg85s/v6Htcvh2B2b1drMbpAeC4qjPAA6iOVP+p25cuKi5Ty4uiBb2rzA4ONOb4A
         dRMdG71gWQek6x0b9arUEuiUAakh2nfTV+YPcbhd6DGk8kDi73XEnzrAIkGyxHPnHztT
         1wyXrHNmXDWOyYwfLU1/g+5EEhNkPZYM7ssrC7O7tk2sZpQuSvwCzH030tL61Fgu3zdh
         BiwXGTq6CUYu4IE51Sp4g/UUYAyGOzia1JACLf82EkmrJRi3/MnskyEE9XLe0TArZRDH
         WnuXHHzGLjAP91P5dtNTo+P0bhIIi1LGmSnGxr2pMm6cizkkPd8H7pF4cnw7jgS4lUud
         Dumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282027; x=1715886827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5+CpfPTydUeT3vKTfUos21UxKzlhAl+5pqEA8g6EMk=;
        b=rciUxetVfMmpVcTtVnkeeul+j1SX7+yS91dqa+90o9p+yCisRsCXoHEKmhQBFXpfWU
         f27aJJ8MSseauZJgbN24IjBbpbVOsFUUlMmZeNG62mX1lHhi6jaOtwKXJWjIqOxYSvzk
         P+NHksXgH8sJJn+CQGiH4vAN770GaGySjHoxRQLUjXkNCxPBzLXNxnzhks2vF/UBTMPz
         XQtB5euvsFaO48r/OaH7Wu2MpwanZ2cg530axYC6D+TPk15dYBVMkodyVokvggE9FAeb
         AROzXMj566Zktbl2Ix+iuiuHsPmokHPObeG4pwtoO7OGjwDuNmlo+RqFqrXJX06nHEst
         m4HQ==
X-Gm-Message-State: AOJu0YzJHRCns/ucmfW12GeAqt6UvYHTAVpaoerKD3PIoYD1TG6C3HMS
	EhY6me0e6jKUWUNa4ZOLMPH314KMOqpD97f7oe+R6hEW9U+gk3OOW9Wb+nhwZy2dfnsKz+20mNN
	fI//jtJhRh0nVcCyBdXy0mNS/PJTfLspR/QZkJVfTM6H/OSk=
X-Google-Smtp-Source: AGHT+IHUWBa+ghPEnr1ieJmvlpKHqw0gEV0F6yX4442fyzIAt9aMggaDcKmU/XZYYhXknN1mpz1tA24TgG24v/jaGhg=
X-Received: by 2002:a05:690c:b1b:b0:61b:e62e:8fad with SMTP id
 00721157ae682-622affb59b1mr5628747b3.21.1715282027468; Thu, 09 May 2024
 12:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <262f71a207e8cedd388bd89d17ef16155eb2acee.1715248275.git.dcaratti@redhat.com>
In-Reply-To: <262f71a207e8cedd388bd89d17ef16155eb2acee.1715248275.git.dcaratti@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 15:13:36 -0400
Message-ID: <CAHC9VhQEa+6BQs-9jT4JR64nDGio8FbAG5smPaq8E3gi=H1SLg@mail.gmail.com>
Subject: Re: [PATCH net v4] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, casey@schaufler-ca.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-security-module@vger.kernel.org, 
	pabeni@redhat.com, xmu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:36=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> Xiumei reports the following splat when netlabel and TCP socket are used:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.9.0-rc2+ #637 Not tainted
>  -----------------------------
>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
>
>  other info that might help us debug this:
>
>  rcu_scheduler_active =3D 2, debug_locks =3D 1
>  1 lock held by ncat/23333:
>   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setat=
tr+0x25/0x1b0
>
>  stack backtrace:
>  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  =
07/26/2013
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xa9/0xc0
>   lockdep_rcu_suspicious+0x117/0x190
>   cipso_v4_sock_setattr+0x1ab/0x1b0
>   netlbl_sock_setattr+0x13e/0x1b0
>   selinux_netlbl_socket_post_create+0x3f/0x80
>   selinux_socket_post_create+0x1a0/0x460
>   security_socket_post_create+0x42/0x60
>   __sock_create+0x342/0x3a0
>   __sys_socket_create.part.22+0x42/0x70
>   __sys_socket+0x37/0xb0
>   __x64_sys_socket+0x16/0x20
>   do_syscall_64+0x96/0x180
>   ? do_user_addr_fault+0x68d/0xa30
>   ? exc_page_fault+0x171/0x280
>   ? asm_exc_page_fault+0x22/0x30
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>  RIP: 0033:0x7fbc0ca3fc1b
>  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e =
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
>  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
>  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
>
> R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>   </TASK>
>
> The current implementation of cipso_v4_sock_setattr() replaces IP options
> under the assumption that the caller holds the socket lock; however, such
> assumption is not true, nor needed, in selinux_socket_post_create() hook.
>
> Let all callers of cipso_v4_sock_setattr() specify the "socket lock held"
> condition, except selinux_socket_post_create() _ where such condition can
> safely be set as true even without holding the socket lock.
>
> v4:
>  - fix build when CONFIG_LOCKDEP is unset (thanks kernel test robot)
>
> v3:
>  - rename variable to 'sk_locked' (thanks Paul Moore)
>  - keep rcu_replace_pointer() open-coded and re-add NULL check of 'old',
>    these two changes will be posted in another patch (thanks Paul Moore)
>
> v2:
>  - pass lockdep_sock_is_held() through a boolean variable in the stack
>    (thanks Eric Dumazet, Paul Moore, Casey Schaufler)
>  - use rcu_replace_pointer() instead of rcu_dereference_protected() +
>    rcu_assign_pointer()
>  - remove NULL check of 'old' before kfree_rcu()
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/net/cipso_ipv4.h     |  6 ++++--
>  include/net/netlabel.h       | 12 ++++++++++--
>  net/ipv4/cipso_ipv4.c        |  7 ++++---
>  net/netlabel/netlabel_kapi.c | 26 +++++++++++++++++++++++---
>  security/selinux/netlabel.c  |  5 ++++-
>  security/smack/smack_lsm.c   |  3 ++-
>  6 files changed, 47 insertions(+), 12 deletions(-)

...

> +/**
> + * netlbl_sk_lock_check - Check if the socket lock has been acquired.
> + * @sk: the socket to check
> + *
> + * Description: check if @sk is locked. Returns true if socket @sk is lo=
cked
> + * or if lock debugging is disabled at runtime or compile-time
> + *
> + */
> +bool netlbl_sk_lock_check(struct sock *sk)
> +{
> +#ifdef CONFIG_LOCKDEP
> +       if (debug_locks)
> +               return lockdep_sock_is_held(sk);
> +#endif
> +       return true;
> +}

It might be cleaner to do this:

#ifdef CONFIG_LOCKDEP
bool netlbl_sk_lock_check(sk)
{
  if (debug_locks)
    return lockdep_sock_is_held(sk);
  return true;
}
#else
bool netlbl_sk_lock_check(sk)
{
  return true;
}
#endif

--=20
paul-moore.com

