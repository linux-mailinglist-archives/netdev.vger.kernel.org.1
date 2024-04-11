Return-Path: <netdev+bounces-87078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7D8A1B42
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791EF1C22066
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34266AF88;
	Thu, 11 Apr 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GucYRKEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD66996A
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851026; cv=none; b=DypIx61d3UeLbZBDUdUBfayxcQT6IdYIDFUv7Qs3Ssh0OZWU/hYti51tFzfYvz5wo43aFic7gOVddI0RGw9UAQ+cMtwMLO4QZXfk17teXXLFgdYDw7ZXVtLm+IrSEaqAoCq0DKmH2pPpOIalq3uTnEp42FoQCWPMfYXH6vyYbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851026; c=relaxed/simple;
	bh=tp5g9J9sSGb4etk/9peN011duHbDTw2nIQr9fyh0Wnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7wE+CQyONNudCvOUtBotIlwDHY8tF0BHIZPiEixGAh9GWoX1RoQFbRArfLDuwtVRFufOZ7Y6Vs6aoQbDDsdDknWL338WjlEgKn8BVhg1fUQcvPoICqK6twwBVxmINfm8+TTQWotnynbStqsQ7hTLlJklXJNkFXxuKJPFRSFbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GucYRKEz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so11766a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712851023; x=1713455823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GwjlRn+rh7R3T0HrEqsZg4/0N2XQx94YD4CIxtdHTg=;
        b=GucYRKEzp7b/6dBoAT5W5fDwbZ5i6xlyrSgI1xrGrR/BHERcvrPi4qorh3sBpn2Rp3
         LcUgB6WbIYppzkQGz2jKhNfpyD/uYzb6k6Zxz7p247in2LTwPkYuy1bNtAlJGTCK5etZ
         2RH3DAmzEN/DeQHYmFW6ZoCNaVFByUSqiQgalsIlbQCWCcoECl1wFZ50yVsw1/vE8tLy
         tERgzLjv2Z1m1l2lUhCjbz6Ykb+eCihUbGRRTWIxDOr3yTGJvFTtsm/lw03z8BhN7W6A
         tUIHlTACY4zzpkIY2nkmgAmiQ4nAn7z2TWsXBulmtwQbylZE5dfJyry5+oUcsWwK6Luz
         5DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851023; x=1713455823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GwjlRn+rh7R3T0HrEqsZg4/0N2XQx94YD4CIxtdHTg=;
        b=Eq9TMj18Mob5U+Rgmh20Y2XOmcUMURhfyrwUhXLiBgt73nWGXJ6y8cr1UHoZADr2b8
         IyUHIhiQ66TKil+r4GsUIsWdYDNuQwGooK1s5da3tOdRQJGNXVeE6FQQsXOzufoyoBlK
         75zyLWOzO3zK626RfITOORGjZjwuzhJGJYN/MrsEYP8FujTTUXgPRIaZhPy/vCXZZ0fs
         fDi2waAqRxTrQ9JqyBkG1feAZcas9v4LEUzv8le4WGyQhFsOH/LuFYb125zECYGO8e12
         aHItO7M81Jx6l3LwHSmgsLJpuG3i9xVnvORQG9617cLoMg5nqGLYJO45xWNRzaOWBsgp
         EJfA==
X-Forwarded-Encrypted: i=1; AJvYcCV+n/PSamqZZYHeAjR2hDjXJgiktkIy4lLuzed2FVfhfWKzsoVAKTlgNIF96gIco37+BKYaBjMATq4ReY7u8Sn93K9GYfrE
X-Gm-Message-State: AOJu0Yx9Y+N99PKWExXEKiuIQkJ41Jz7x+7GgkrmJIaqZdAj/heYmQQ9
	X0ojFLE+LIlxfBliGGd82eJ4dDWyRdPZQEFuUc2TV9+j53IfDCb6TrYMfRah7qd7tQAipi6+Ig6
	bzuhs+ssDummLtBToHq2C2YDiNHf8fsOZ0WnB
X-Google-Smtp-Source: AGHT+IGVnr8MUvFdZpdUV3ucWBYfaJMHycS9OOq/3JixgySI3dllBKGJNVIofMxE106s/doTuNlrcxq5a/15OreENOw=
X-Received: by 2002:a05:6402:4304:b0:56f:d6ef:b61 with SMTP id
 m4-20020a056402430400b0056fd6ef0b61mr167211edc.5.1712851023198; Thu, 11 Apr
 2024 08:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
In-Reply-To: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Apr 2024 17:56:48 +0200
Message-ID: <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com>
Subject: Re: [PATCH net] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, xmu@redhat.com, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:44=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
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
>  R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>   </TASK>
>
> The current implementation of cipso_v4_sock_setattr() replaces IP options
> under the assumption that the caller holds the socket lock; however, such
> assumption is not true, nor needed, in selinux_socket_post_create() hook.
>
> Using rcu_dereference_check() instead of rcu_dereference_protected() will
> avoid the reported splat for the netlbl_sock_setattr() case, and preserve
> the legitimate check when the caller is netlbl_conn_setattr().
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/ipv4/cipso_ipv4.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 8b17d83e5fde..1d0c2a905078 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1876,8 +1876,10 @@ int cipso_v4_sock_setattr(struct sock *sk,
>
>         sk_inet =3D inet_sk(sk);
>
> -       old =3D rcu_dereference_protected(sk_inet->inet_opt,
> -                                       lockdep_sock_is_held(sk));
> +       /* caller either holds rcu_read_lock() (on socket creation)
> +        * or socket lock (in all other cases). */
> +       old =3D rcu_dereference_check(sk_inet->inet_opt,
> +                                   lockdep_sock_is_held(sk));
>         if (inet_test_bit(IS_ICSK, sk)) {
>                 sk_conn =3D inet_csk(sk);
>                 if (old)
> --
> 2.44.0
>

OK, but rcu_read_lock() being held (incidentally by the caller) here
is not protecting the write operation,
so this looks wrong IMO.

Whenever we can not ensure a mutex/spinlock is held, we usually use
rcu_dereference_protected(XXX, 1),
and a comment might simply explain the reason we assert it is protected.

(We also could add a new boolean parameter, set to true or false
depending on the caller)

old =3D rcu_dereference_protected(sk_inet->inet_opt, from_socket_creation |=
|

            lockdep_sock_is_held(sk));

