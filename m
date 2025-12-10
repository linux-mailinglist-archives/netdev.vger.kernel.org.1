Return-Path: <netdev+bounces-244287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2744CB3DEA
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 20:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866173064BC1
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7112C0278;
	Wed, 10 Dec 2025 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maaCV9kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098C18C2C
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395138; cv=none; b=nPNZ2XYpxpyTeHHcSNbqTsfSxnHkx0iOKZaIq5mS0vqsulr5AataA5ybsZzwI6C+GSWKl9EpaUWsp4IkTtgn2baKZMY0ScxX9yBI+BhvNrit7XTPpWFDZCnEeoJqBBQ6BraSXk0k+Z56vf7u+HHBwJVzT43f7J+G9wQLL0B9bZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395138; c=relaxed/simple;
	bh=BSH/qJlvZM8yPKeC7ZinuKJuuiMgVAnnjk9CnWPf8Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH/H5Us+AFR2EdHrXHAY4lLVLmcmhzEZhIEIBH6yoAQZz4kqViibGa+hk1FSw1qzsMgwMR6qcXuRR19RcQsyiFN1K9/5s3b8QfZFd4dAcQgJ78xhKkkTxlFj6sVlI3NZxY+yU5uhpLHtplslSOa/pCb6/OeH4+JwAwGdwk7y1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maaCV9kk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29d7b8bd6b0so1275805ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 11:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395136; x=1765999936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0stRGz6XUcS6X9RFrFCP4tQx+b1NUw7Kk6ncH4x7qk=;
        b=maaCV9kkWM+Abq5mRDun/W6hrbKuXHs6xOz4PVpSMsWZ19n9y8dEsaWC8X37NQRPop
         wMWYk57Hzy+dngdzolOG1i1oNHX8qhmurKSMpc184y/8Ax4DieDqN4v5HlgKm19WVjCv
         6b5PIDPu2dg6nlPxpEadKiT0AmiGdM+m5rm4azqrVBWmCNtBS2Rs4/zm6Ai2KyLCdsvZ
         FLD5SK20Ho+/ZJXG4Z5GJlFkg5W5980NQ4Zgdyc6I2FGhzPoJZzDBKZyjUbNzBZFTpD0
         MdzPfPAGpLz7s0TAJG9HK5M4tD3XaWGgFssZznO9O5q7FDvkkLsWUvkWjkV6bWc+AvM8
         oLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395136; x=1765999936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0stRGz6XUcS6X9RFrFCP4tQx+b1NUw7Kk6ncH4x7qk=;
        b=W47vVAu8DEr+nMg80K69E7djnu4HmIkf990giXmqRiMl9VVlV9hm1662ncNoirHpc4
         sehWnXpBtpUjzmWDxojkN9sss2n4d68ZM2qNluqeptVg6HzGmNsuQvLAp/l5/Jnlgg+k
         MfbUUjDNuH36vrWAy96D0C1CF2a5b8EvYwT9AE/fCnchnNPQk+dmLhUVzBwm0cippTDo
         ZNVxe2e94QJ3603lgTFggDJWDl8Wa4FnaQKlI9fP8NyBhE4o3nkjGTqXDctTUTWFoWDn
         GKTSf/sWvLby31wzhkzIHzYeoVM7ytqGZDz8BbX8fyBUFZOmmBmE/IokGB2CGWMGKhO/
         +a6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6y/cB7ZmSZZSe/5VNbs8LWwlRcTQmm7nL50uYhDGQp2yaexVVSQ4aXgwbdgmDOZRQ+e+4Q8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NCNru+zQHAWf219huC0urPDIzXOAzjGVTbc6gDEENJQJQhIt
	JD/8rEEDPobbRHc18oboz0Svk6Rvhwo/5OKKLp8oXD19Ue6JnHvts/0qP+JM3rEu25X1iE0V9+z
	oNCDgVtHbFX+wlwgmhaZL86/PVxq0Xo0=
X-Gm-Gg: AY/fxX6fc8maz6kOucgD910b3FQ9CGyEKHIZ9MsTv9mi7/SY7mZ2l0dyVQSbiIXzU2C
	ojfN45WixyEJOydBoqCyUn0rAdxynirlhvHjncx5GhWJhziIPAIp6w78+OEWlyS+KtRT1cKdTwb
	gwktl3ylGFRcr1xFUM3fYsi6U2Df4ITdGg96x8HF+crtdawgr34kOE7tgqT1FzYylu/i8fRjU0X
	jFql0TUKrGU+45LNTzKlfLZMX6+lCEUuaNqYdRka98ehqkQfvtIMGqkLGyKtejGUwdfLDg=
X-Google-Smtp-Source: AGHT+IFbIhJa60MvSofoFGrdJreL80JxO5MPqtY1spBsiimiELZUFOuQ/H9EX0cmRBSFvYlS+8c6FHhtlqrneYe3DVQ=
X-Received: by 2002:a17:903:4410:b0:29e:d5ad:4e98 with SMTP id
 d9443c01a7336-29ee787fed1mr6324855ad.13.1765395135838; Wed, 10 Dec 2025
 11:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210081206.1141086-1-kuniyu@google.com> <20251210081206.1141086-3-kuniyu@google.com>
In-Reply-To: <20251210081206.1141086-3-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 10 Dec 2025 14:32:04 -0500
X-Gm-Features: AQt7F2paCp0LAMYhwH4i7VC3-P9YE4C6dTI2UTrZz7UKGcXzn9U_dEKWOH1RwlY
Message-ID: <CADvbK_fhSZGLcKb_UPCoP55ODmggvQn0jg53BKihLxO9xwt7+g@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] sctp: Clear inet_opt in sctp_v6_copy_ip_options().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 3:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported the splat below. [0]
>
> Since the cited commit, the child socket inherits all fields
> of its parent socket unless explicitly cleared.
>
> syzbot set IP_OPTIONS to AF_INET6 socket and created a child
> socket inheriting inet_sk(sk)->inet_opt.
>
> sctp_v6_copy_ip_options() only clones np->opt, and leaving
> inet_opt results in double-free.
>
> Let's clear inet_opt in sctp_v6_copy_ip_options().
>
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
> index 069b7e45d8bda..531cb0690007a 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -492,6 +492,8 @@ static void sctp_v6_copy_ip_options(struct sock *sk, =
struct sock *newsk)
>         struct ipv6_pinfo *newnp, *np =3D inet6_sk(sk);
>         struct ipv6_txoptions *opt;
>
> +       inet_sk(newsk)->inet_opt =3D NULL;
> +
newinet->pinet6 =3D inet6_sk_generic(newsk);
newinet->ipv6_fl_list =3D NULL;
newinet->inet_opt =3D NULL;

newnp->ipv6_mc_list =3D NULL;
newnp->ipv6_ac_list =3D NULL;

I noticed these fields are reset after sk_clone() for both SCTP and TCP.
I believe the same applies to MPTCP.

If that's the case, is it possible to move their initialization up into
sk_clone()? Doing so would address both issues in this patchset.

Also, memcpy(newnp, inet6_sk(sk), sizeof(struct ipv6_pinfo)) might be
redundant, since sock_copy() already copies this with prot->obj_size.

Thanks.

