Return-Path: <netdev+bounces-93863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A88BD6B5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B981C20C81
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414715B55F;
	Mon,  6 May 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e5vvRgLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337415B553
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029983; cv=none; b=Fu41VrkegLsRsN1nmjX+2gfYkurDKliNu1KayzuufU05AvMLcDt6t/E2arlnzetlaRfzJjm8TJsSR9nWHfrBggxYtqFcUpAAjqA7kVh9xHfgQA3EAzeWLbWFS0VgAxTJE6ACL4n5lS7wCZqW7+CSIlK7NYsGZybvoD/dDUlhg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029983; c=relaxed/simple;
	bh=SY+8UM6Ya3LN5CVLnLFC3F0TWkfazInPoDky4RbxaSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeKaFfN+1VDHZz1/0YiERFbOD85YflbJaDOUYWYn6B4DuJm3g3GVgKiTnhrbegpEKSr1DAYxvjxgcx9ZzHn7Yirp4utf9dPv6MdB45+oIB3L+ua45R0zloRFEL8G4E8aXnQgQglGQYu+7OKgHY4fFXCCX2D4gidzjnrEHFCBo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e5vvRgLI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61be74097cbso25973947b3.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715029981; x=1715634781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+v8LBEop2fdOZEDDkjilbFKI0qO+TSZpOXL+kjzb20=;
        b=e5vvRgLIwWntAzSHhyagX+HCajeSg8WNU92DzJujuKaM0RoGX4adDgz+o71/KdTaYa
         5YnZyhl6Sjo93/MQa+w1GRA8aOBGtmgiYRh7iHUdeZfQyByUPf/e5HUh1/fhwKfsZHPl
         71nNT2X95/QnCTiIMkUwsmBMMLikhVgj5kMkQoU5kQRDjaxZC+ir9qILT15brr/WcFhe
         SBbYG8Q9ubh9qeHu4lm4T+7JqCp9r7NRsuAclNtvSOB9jugS5rYM1wlaplb1Js2GMtoM
         sViMfchBL517CHZMNjJix1dJKASo5VPmdV1vIPI5CAlRAV/vkMpd3CGsEyPnv954aE+m
         b25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715029981; x=1715634781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+v8LBEop2fdOZEDDkjilbFKI0qO+TSZpOXL+kjzb20=;
        b=GoFPRzsuSsavrMxlqcZoCVPFgiV6cv1hMlpCCHkvd7C5rOeso1C5s4kSNUwT8+3Fil
         0izHhCoPQrmKr/BWL8xoRm96Z3cgCpavgg9bDuYkIO8bpKMkb7ifK1pe+t+gxE98a3YK
         NVWEc5cNs+suk1kTeeDMPstJYlIax+J+MEAZxPTZlUMolT/zmY25K9INWuaxttjSFiNl
         7FhOZ7zhFIGnvTJ7MaK1NvbSJpaFwo3JxAwqZCeFclAcDEFfyCA7tOzrcAqZ1PZvmUVH
         gL7KZM/y5p9oXHnt6tB4Ta8K/wwnmUN/LM5Dh/S0RDyZuAyoLQUEyP1ag7iMcMW2pTmN
         UhIg==
X-Forwarded-Encrypted: i=1; AJvYcCX1ctLNka0bEJ0wnmLyLQ+XyO/dRZYAks5bTwfJS6bKLxP57MITtBoXEqD8PaL94YPk3sJmSYg4P12SH6YFNPhq+fOaPKC/
X-Gm-Message-State: AOJu0YxW5gjI63eQa8pDmBG5ScP9jP61b0l1PcogsHGBIZiRBubvzP/F
	/pi/dtDjSxb5d9vEYHoNd+s2JCYZaCSI2tfOQRJvrhaGQoD5ugC87uD3dhVIo54+uwvnVKEZLUT
	muNf4bita8gH1qNhqN6CGOqzI26A/QBc5jZtf
X-Google-Smtp-Source: AGHT+IFSaqJzaRnYDFR7/BKMMg8f+lw74iFjuNIE8o2jF/QSE2uVjujwEMoDA9VmfqVD0+I5pOnzm67RlrsP7pIWVxw=
X-Received: by 2002:a81:92c1:0:b0:618:ce10:2fcd with SMTP id
 j184-20020a8192c1000000b00618ce102fcdmr11718174ywg.26.1715029981015; Mon, 06
 May 2024 14:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ce1a2b59831d74cf8395501f1138923bb842dbce.1714992251.git.dcaratti@redhat.com>
In-Reply-To: <ce1a2b59831d74cf8395501f1138923bb842dbce.1714992251.git.dcaratti@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 May 2024 17:12:50 -0400
Message-ID: <CAHC9VhQMr9tinpb=Fsgx6B0JKP0L0VYusdPha_RnMH6EWVpztg@mail.gmail.com>
Subject: Re: [PATCH net v3] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: casey@schaufler-ca.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, xmu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 6:45=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
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
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/net/cipso_ipv4.h     | 6 ++++--
>  include/net/netlabel.h       | 6 ++++--
>  net/ipv4/cipso_ipv4.c        | 7 ++++---
>  net/netlabel/netlabel_kapi.c | 9 ++++++---
>  security/selinux/netlabel.c  | 5 ++++-
>  security/smack/smack_lsm.c   | 3 ++-
>  6 files changed, 24 insertions(+), 12 deletions(-)

Looks good to me, thanks Davide.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

