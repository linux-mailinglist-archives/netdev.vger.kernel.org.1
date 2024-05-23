Return-Path: <netdev+bounces-97703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0D8CCCE8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BBC1C21AD0
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948013CA81;
	Thu, 23 May 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKMFIRxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1A3B29D
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448772; cv=none; b=dUHoRDpXJMWfErCve+fhzkG2kyVTcS7SewVlwFFXDXCrx61hPwUkMzlN8bejCi23IKV/d2e1bj6ZzTq4LV4x2uf/LpEn66mZfkeNfNVqSR8br2/8gW78QX6MmA8VWWRr7SXkMVBIg9c1gaA1ddiiIp9yc0w67xsh8KdGA9vycF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448772; c=relaxed/simple;
	bh=72+TkwMAsCajDH567dbzWg+sRaHNzsPBqqGPiOGn3zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsBhHwlz2l2fKurBeGcvdgR18QVFlS+Z3q+neLiSX6YKB/JRFxXrahDHvd2rnZevz0RJ3K2Jb+YEPsE3aZs/nSGvVpWYcKZInR1Yv/Pn3e5KvFVmvEQ/hWOz9wREc843Pg+TRdCryPRLs0Q6fGiauVjtuvuD2PO64H1U4AP2iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKMFIRxV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so35595e9.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716448768; x=1717053568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSEkqCu/pEBgdew3T6+nkUjZJSZvHB7RfkbZGjTqM3s=;
        b=GKMFIRxVJRSLU2jHrfxD1SPOBOIKIzV7uMIpQ4m3Xp7ty51Cp5kNZBX+E0eCMzx5ac
         ihuBYfkBgSTE/B+MWeRbZ15Zz0ZLaudWidzYtJpfL4dbxjvSd3GtvlTo4Qe9r/q47Po5
         vRsYwyLXWySiFpAvDNhcRAj+VNRb1w/ebgJpNsFvjmj6KmL0CKe3HA3r99QSHAex1jSq
         onIzKIh3XblYbtXJLd2/u7kU0VqQ3FJngwBvF4biDvvJ40cDVofCN5k5FzDw/PhnhFUd
         aGWAgQei7JT5ZoocizHt99Q5qzYpORxNqQt6f9X7vlV7g/ra97IEdXIaBrykTr/gVMHF
         bDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716448768; x=1717053568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSEkqCu/pEBgdew3T6+nkUjZJSZvHB7RfkbZGjTqM3s=;
        b=U3q2EgHDw2uHYbNT6na4BtuEy3KPlwM1Tive+EyeIHvfXysGJWXdH4bN9vFyGknNz5
         87n8XhQWd2Ze68xe1YULp/HuncADy/Mp2ELf76FyR6byqUWbrKFcXz367CnHVm0BgNek
         aN08vGOoGSa4BMdwhmaR+jZfssMmLPT3hFU9J6kUF4mQkCCLNeOZOYJaoEfiec7VeOic
         A27REL3zlQEIYA5QmSvhFQBqCRfJopeun3DZQ9c7Ji8o7M5uSjGAxkwMFwzPSa5O+0u+
         1TQdngcgtZDlKIXbfYco1FyJLMXVaCD81ICNu9z83NIAgfW0fC+ds+l4/0oGx1jo5RrH
         oR9g==
X-Forwarded-Encrypted: i=1; AJvYcCUJTgotIx3S87Z+kNBhihHp+wGHTsShNge2rmwDtus5KucCWVQmFJRoUvksduJfCOlr0+/NZCuCtZijtkL2/3x7bpYQEOC0
X-Gm-Message-State: AOJu0YxfJLYyZ3Z9tpXbgnsX70WWFcJHk/i8VyeHIj7b4Go2m2DIEnEw
	MjUKN9KI0NHJtJ5AOywr/mImbF/1SYKdmNUBzGl+LtzUQqr/+uVbmpFiv7hs+EnD3FlivdX9Tiz
	bVnwZCD5kftVoekTpPoRh+X4Wvwee6ijnsM3D
X-Google-Smtp-Source: AGHT+IEYq4J2CSsA+bifPOFq8gro1VGR5Nnmsupnjtfp1u9pokU1DR+YZ8cJeTcVLeLXI0kNWNREyJvZ4M93kVIhH3I=
X-Received: by 2002:a05:600c:1da7:b0:41c:a1b:2476 with SMTP id
 5b1f17b1804b1-421016291fcmr1109075e9.6.1716448768250; Thu, 23 May 2024
 00:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523050357.43941-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240523050357.43941-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 May 2024 09:19:13 +0200
Message-ID: <CANn89i+y32YsDyUSyAvVswZTUaYTNjA=zGYmV5JXrCqa5EEHJA@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: fix a race when purging the netns and
 allocating tw socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 7:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Syzbot[1] reported the drecrement of reference count hits leaking memory.
>
> Race condition:
>    CPU 0                      CPU 1
>    -----                      -----
> inet_twsk_purge            tcp_time_wait
> inet_twsk_deschedule_put   __inet_twsk_schedule
>                            mod_timer(tw_timer...
> del_timer_sync
> inet_twsk_kill
> refcount_dec(tw_refcount)[1]
>                            refcount_inc(tw_refcount)[2]
>
> Race case happens because [1] decrements refcount first before [2].
>
> After we reorder the mod_timer() and refcount_inc() in the initialization
> phase, we can use the status of timer as an indicator to test if we want
> to destroy the tw socket in inet_twsk_purge() or postpone it to
> tw_timer_handler().
>
> After this patch applied, we get four possible cases:
> 1) if we can see the armed timer during the initialization phase
>    CPU 0                      CPU 1
>    -----                      -----
> inet_twsk_purge            tcp_time_wait
> inet_twsk_deschedule_put   __inet_twsk_schedule
>                            refcount_inc(tw_refcount)
>                            mod_timer(tw_timer...
> test if the timer is queued
> //timer is queued
> del_timer_sync
> inet_twsk_kill
> refcount_dec(tw_refcount)
> Note: we finish it up in the purge process.
>
> 2) if we fail to see the armed timer during the initialization phase
>    CPU 0                      CPU 1
>    -----                      -----
> inet_twsk_purge            tcp_time_wait
> inet_twsk_deschedule_put   __inet_twsk_schedule
>                            refcount_inc(tw_refcount)
> test if the timer is queued
> //timer isn't queued
> postpone
>                            mod_timer(tw_timer...
> Note: later, in another context, expired timer will finish up tw socket
>
> 3) if we're seeing a running timer after the initialization phase
>    CPU 0                      CPU 1                    CPU 2
>    -----                      -----                    -----
>                            tcp_time_wait
>                            __inet_twsk_schedule
>                            refcount_inc(tw_refcount)
>                            mod_timer(tw_timer...
>                            ...(around 1 min)...
> inet_twsk_purge
> inet_twsk_deschedule_put
> test if the timer is queued
> // timer is running
> skip                                              tw_timer_handler
> Note: CPU 2 is destroying the timewait socket
>
> 4) if we're seeing a pending timer after the initialization phase
>    CPU 0                      CPU 1
>    -----                      -----
>                            tcp_time_wait
>                            __inet_twsk_schedule
>                            refcount_inc(tw_refcount)
>                            mod_timer(tw_timer...
>                            ...(< 1 min)...
> inet_twsk_purge
> inet_twsk_deschedule_put
> test if the timer is queued
> // timer is queued
> del_timer_sync
> inet_twsk_kill
>
> Therefore, only making sure that we either call inet_twsk_purge() or
> call tw_timer_handler() to destroy the timewait socket, we can
> handle all the cases as above.
>
> [1]
> refcount_t: decrement hit 0; leaking memory.
> WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1=
ed/0x210 lib/refcount.c:31
> Modules linked in:
> CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g=
33e02dc69afb #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
> RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
> RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
> R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
> FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  __refcount_dec include/linux/refcount.h:336 [inline]
>  refcount_dec include/linux/refcount.h:351 [inline]
>  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
>  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
>  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
>  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
>  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
>  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
>  setup_net+0x714/0xb40 net/core/net_namespace.c:375
>  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
>  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
>  ksys_unshare+0x419/0x970 kernel/fork.c:3323
>  __do_sys_unshare kernel/fork.c:3394 [inline]
>  __se_sys_unshare kernel/fork.c:3392 [inline]
>  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f56d7c7cee9
>
> Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqsk_timer_=
handler().")
> Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2eca27bdcb48ed330251
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20240521144930.23805-1-kerneljasonxing@=
gmail.com/
> 1. Use timer as a flag to test if we can safely destroy the timewait sock=
et
> based on top of the patch Eric wrote.
> 2. change the title and add more explanation into body message.
> ---
>  net/ipv4/inet_timewait_sock.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index e28075f0006e..b890d1c280a1 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct inet_timewait_sock *=
tw, int timeo, bool rearm)
>
>                 __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKI=
LLED :
>                                                      LINUX_MIB_TIMEWAITED=
);
> -               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>                 refcount_inc(&tw->tw_dr->tw_refcount);
> +               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>         } else {
>                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
>         }
> @@ -301,7 +301,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
>                         rcu_read_unlock();
>                         local_bh_disable();
>                         if (state =3D=3D TCP_TIME_WAIT) {
> -                               inet_twsk_deschedule_put(inet_twsk(sk));
> +                               struct inet_timewait_sock *tw =3D inet_tw=
sk(sk);
> +
> +                               /* If the timer is armed, we can safely d=
estroy
> +                                * it, or else we postpone the process of=
 destruction
> +                                * to tw_timer_handler().
> +                                */
> +                               if (timer_pending(&tw->tw_timer))
> +                                       inet_twsk_deschedule_put(tw);


This patch is not needed, and a timer_pending() would be racy anywau.

As already explained, del_timer_sync() takes care of this with proper locki=
ng.

inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
{
  if (del_timer_sync(&tw->tw_timer))
     inet_twsk_kill(tw);
  inet_twsk_put(tw);
}

