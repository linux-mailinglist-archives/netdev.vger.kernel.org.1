Return-Path: <netdev+bounces-244175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94632CB149E
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1DC33019AE7
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7C2E7653;
	Tue,  9 Dec 2025 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH6dBYvp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5E2E6CCB
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319216; cv=none; b=qoNO6cCuFujbASPhrjGqhkRSm6X00JFppvQkulEbAukjLDK0MwFoAR+nio/+z7j20jjp9hnOWF/SpOhQaJhk+T1k4DQfnf48HzUx9jWnSb6vnBIK1I6N+NJNW7Jr2pyHrfgM6UdXTknOp71cbpVQQPd1r/QEcwkdwlTWvowTt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319216; c=relaxed/simple;
	bh=10VAC1N73wacy8D1w2hsobSndy9eBFNyF2FecfRRvOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwlyjhTerSARL8mUpTBqA0VLC7pO9Le2hFZE6ac8wiUoDZuK1PI2V49NChtHM5X3zFfOrGZhanmteKeCpHDAMJVtMDitgKcjt50LtNeUpxhWue6V0NDT/Ouv680VGzrj2cpURIscA8xDkfMMGC8H8dfV9LUpMNXHotjKlkiEQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH6dBYvp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso9710606b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 14:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765319214; x=1765924014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZsb5M3SmYcvND6sxqyzVYod44VeYH/htOxxHGwUWis=;
        b=TH6dBYvp+4IJ/9F11Ki6PEtg+kePEF+xni2JppR5K+8JEsZGprPFryeqldbOMSwdjf
         Wtl94y1qIL4ZvkhIce+iJuCP+WpGonerpay0tiuicdz4CyUJW7b/aiY9klm98QYpoS8Y
         D9bBSSzTJgIu/XTAzfmg+sJuYd/baLxQbZHXfAiW0/rYyYh6UjkhhH7mX2hatnQ3W9a4
         2oIcL1jIWzfVGNqb0cirKiBgaNPkyfQN+kKMYWz7JWDFTTQWiBRn56Gf6lrBuM0So6eP
         GFy1TXTFR2rXJvWjvferS/zh/O1w8qn97djstn0YsY0l2yasJ4b0/+C/b9kulSn95jO3
         Ba8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765319214; x=1765924014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZsb5M3SmYcvND6sxqyzVYod44VeYH/htOxxHGwUWis=;
        b=XGOTDBQJJvshQrws7jlyL8dZbhSLsAHuv+gj/ZYDaKwv3X/gHcm2yrjv8j6Nv9hGxo
         h2RtHYAuRcD/xXDiyOX8exQ25RZ+4z04+A/fNQH7OlL51QvBycoc7+6ADdTy2nS+NSup
         qcSx34v8GUp//1dhQAlrYxxhfDERXk2SuUkdKDCK3V9HSgnoktk4VH5CvrMGHPg0A/bB
         gxVHQZERaT5QhMCCP+9U2vZne25DriRnGbkBYcwtPhONgJRKq0eVKa1VzTbsSrAO5h+P
         awIlRiCxE+P99qu28FakUaxXEU1ZrVGPP8XfoyXKwvyBR8DAMolgwFI3n9LT44rP0Dqc
         8cVw==
X-Forwarded-Encrypted: i=1; AJvYcCWvxq2nSYhnG1uVZIznqlEfxRTfbGQQ5JRauisHX/Zu9ajOoScFNG6Zrzqk0XrSMDqr1oO1y0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhM7mszAuv+A2M6E3OdcovIuuGuz/eHmzVKfV9c9BLjCSyZdQ9
	8DXa/XOhowY0fNIb6qfXrkA6O+jYJ8yhtUkhLUl420WQFIAr5EyyeHJp/JRPoYbvRnFcX+bFetn
	Q0r7I7+N+s7DyNxeOe+/NCsmBNrw8nU2kVhITxcU=
X-Gm-Gg: ASbGnctbV4oc6NqGSxqfhr3IYtkKmDwm3VeyETBb46To1HwGWk60YIVpLwOJ4Dd8C+O
	ANSDrbo68Qo1QLe+/p8YlDVs9aUWue6F074TBnCO8VNIYO8MmTrJTMS3a/ydvdW4D1wW1XYPfqR
	VYAkHBjHZCQ6oH/ZExNc6H/H6L3ZdVpUbqG3sW9jCzA852igAKhxf+k4XbabzNNB5pYMTNApRdO
	nOvhtxkWooO4dbQpy9nawN4O+mlU7r3gy3QwlzRc23bLDtl4vEqe12geRCQWVRVIdm3PylWRfuh
	8ganCTUN
X-Google-Smtp-Source: AGHT+IEPmfdUfYCRqMmX58KFF6y+LItlJrMaXwezuRWhqXj0XxKmePVmj8nyjyhJXyJPXOMfw9sjJw8FLMYua5F2JbM=
X-Received: by 2002:a05:6a00:2d28:b0:7e1:7a1c:68bb with SMTP id
 d2e1a72fcca58-7f22ce1cb4amr235372b3a.16.1765319214246; Tue, 09 Dec 2025
 14:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208133728.157648-1-kuniyu@google.com> <20251208133728.157648-3-kuniyu@google.com>
In-Reply-To: <20251208133728.157648-3-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 9 Dec 2025 17:26:42 -0500
X-Gm-Features: AQt7F2qKuz2XKwqKmkYjPpmjXWS6ipyld6zsWdlrGmMpyzCKNdpIzmaV2JLrnMs
Message-ID: <CADvbK_dEk5a1M0tO8MULiBMwcyYV99zVCdhNC+mfOkv=RQauHA@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] sctp: Clear pktoptions and rxpmtu in sctp_v6_copy_ip_options().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 8:37=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> syzbot reported the splat below. [0]
>
> Since the cited commit, the child socket inherits all fields
> of its parent socket unless explicitly cleared.
>
> sctp_v6_copy_ip_options() only clones np->opt.
>
> So, leaving pktoptions and rxpmtu results in double-free.
>
> Let's clear the two fields in sctp_v6_copy_ip_options().
>
Hi Kuniyuki,

The call trace below seems all about ipv4 options, could you explain a bit =
more?

Thanks.

> [0]:
> BUG: KASAN: double-free in inet_sock_destruct+0x538/0x740 net/ipv4/af_ine=
t.c:159
> Free of addr ffff8880304b6d40 by task ksoftirqd/0/15
>
> CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(=
full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x240 mm/kasan/report.c:482
>  kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
>  check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
>  kasan_slab_pre_free include/linux/kasan.h:198 [inline]
>  slab_free_hook mm/slub.c:2484 [inline]
>  slab_free mm/slub.c:6630 [inline]
>  kfree+0x148/0x6d0 mm/slub.c:6837
>  inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
>  __sk_destruct+0x89/0x660 net/core/sock.c:2350
>  sock_put include/net/sock.h:1991 [inline]
>  sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
>  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>  rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
>  handle_softirqs+0x286/0x870 kernel/softirq.c:622
>  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
>  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> Allocated by task 6003:
>  kasan_save_stack mm/kasan/common.c:56 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
>  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
>  kasan_kmalloc include/linux/kasan.h:262 [inline]
>  __do_kmalloc_node mm/slub.c:5642 [inline]
>  __kmalloc_noprof+0x411/0x7f0 mm/slub.c:5654
>  kmalloc_noprof include/linux/slab.h:961 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  ip_options_get+0x51/0x4c0 net/ipv4/ip_options.c:517
>  do_ip_setsockopt+0x1d9b/0x2d00 net/ipv4/ip_sockglue.c:1087
>  ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
>  do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
>  __sys_setsockopt net/socket.c:2385 [inline]
>  __do_sys_setsockopt net/socket.c:2391 [inline]
>  __se_sys_setsockopt net/socket.c:2388 [inline]
>  __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 15:
>  kasan_save_stack mm/kasan/common.c:56 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
>  __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
>  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
>  poison_slab_object mm/kasan/common.c:252 [inline]
>  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
>  kasan_slab_free include/linux/kasan.h:234 [inline]
>  slab_free_hook mm/slub.c:2539 [inline]
>  slab_free mm/slub.c:6630 [inline]
>  kfree+0x19a/0x6d0 mm/slub.c:6837
>  inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
>  __sk_destruct+0x89/0x660 net/core/sock.c:2350
>  sock_put include/net/sock.h:1991 [inline]
>  sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
>  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>  rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
>  handle_softirqs+0x286/0x870 kernel/softirq.c:622
>  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
>  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Fixes: 16942cf4d3e31 ("sctp: Use sk_clone() in sctp_accept().")
> Reported-by: syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6936d112.a70a0220.38f243.00a8.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/sctp/ipv6.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index 069b7e45d8bda..32f877ccd1380 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -493,6 +493,8 @@ static void sctp_v6_copy_ip_options(struct sock *sk, =
struct sock *newsk)
>         struct ipv6_txoptions *opt;
>
>         newnp =3D inet6_sk(newsk);
> +       newnp->pktoptions =3D NULL;
> +       newnp->rxpmtu =3D NULL;
>
>         rcu_read_lock();
>         opt =3D rcu_dereference(np->opt);
> --
> 2.52.0.223.gf5cc29aaa4-goog
>

