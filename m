Return-Path: <netdev+bounces-97369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B490B8CB1AC
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D8A1C209B1
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DBF1482F6;
	Tue, 21 May 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieuxtpa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E7147C71
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306588; cv=none; b=LhPrJYLxJjJQDoDZcxu0/XmEzQ8D6opINcMTj4g5ikzqJQH9FIgWBXC/trl0q0ksmHwEq4M8gv6GwhWGhS82eXqSIeqfsWlTb0HMK0Bfy+6MxLzz9anHa/oxASG70FbB13XYXG/J9/r4bWKXkEKP9cp7FY2KACaJ8ghXgPAihiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306588; c=relaxed/simple;
	bh=okiSyldKTntY7JDszRirmHRczAkXs3bih9jQtQkOTN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvLazE4VJmYB8aHnk8zYXCTt65/QsuqU4YT5Z9jH/ZbUjzg6PB1loSNo+fiqZtpIcDMe1ucLYrz4MXlpfPYrvwMsYYzqKfLtDpBaBfgh0utgFjXMvA/thp4EtbZ2ZDqBw107mClXWHQQ09RLdai9a03L0/fMQcGZKFd7+i9s434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieuxtpa2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso29707a12.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716306584; x=1716911384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhTBM54Haj1bKe2Tr04V5aKqN4hwTV4XYlyou9K5OXI=;
        b=ieuxtpa2c/12708LX77vRbWKlTvU/ilaTa4pivnJ311QDgGnO56ykRegBJMRENykUq
         fpw6Z6xz56UMNE0DP/BFLYXCMlfI4TidzipYHvB64eOzJfSnA0e+qRU6ZBfw+0JBV3Tj
         LuK2h20fpqpIHzzrEuU8HxiHRXPJxYF1lpLMHFOcKkWPa3+D9MPBnaYbzefjiHK3q6Dz
         1+HclXnzmb3rhvnd0j/cZLW0wCv6g+OGdXCBSeyCGRnIGbM9k+m/MSqMEXE0cOMLC8tg
         4xyOLy021pcPBzGZQvfnbZhc/S6vJYYnFDZ9Nsx0BW6Z5Q8eTrWCPOYX0N3l9iHixxh+
         hhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306584; x=1716911384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhTBM54Haj1bKe2Tr04V5aKqN4hwTV4XYlyou9K5OXI=;
        b=DPG1PkD8D2xgrqRz7Su1hcnd+Clph4ZWTbm1u+DQivXabUk/OIJqC6SoXOiXRL3x+T
         mSqRlqdNiMDiMsAE3/5tAUk1DdhdT3gQRM2LxfdIUn28+OFVJDz0DcMEV7a9573FsqXG
         OMUbYsVVkO9/yYF6tb11Fm2Opwtky1Chl0elQSr9OvgfLJdXhnQRxE8mivVlimEqmH6H
         InVZ85e/zT5HtWEFYHYCiI9agk0FMNLAcLo2u3PVcYKZUoARHNqulVsXTPg0w9dIB+1B
         CC6ijrJx+xH/Xlb6t4cXzSMca5c1L4unx737mcB2RXHTuYcaxQbG093OcMW5nZJCQD5S
         jjEg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/sAi73+LEsE0bzy3xqdzqSpBNDdB0l8o/Ii6UEj07dKMk9bxai8R8ZpmDVn3V1/mOcAekgVmoWi7gk4D0LpaTYLcT9kN
X-Gm-Message-State: AOJu0YxI/vP8F4KvXvbMNtZESOo6BgQOEiIgVpU6YcHwAIGNjm9MKxAc
	s427BTJALbMZ0k8DHO+cKDTtq5aT+uj5nuCf88xAKpVPjOciUK3WGCfYkihRbkzTgLNWgMz1tL+
	Y/f9BBapfuiiiVWz6axShYIHPIW+2ihTrtQvR
X-Google-Smtp-Source: AGHT+IE993Ik1fKJJuFef89iNM0+qq14+BzTwocO3kitkNO1xC3pTXpMQ+EIDudsGDNiW2zluhge+3pV1l4Jjeas+Tk=
X-Received: by 2002:a05:6402:150b:b0:572:7c06:9c0 with SMTP id
 4fb4d7f45d1cf-5752a4268cemr623143a12.0.1716306584187; Tue, 21 May 2024
 08:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521144930.23805-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240521144930.23805-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 May 2024 17:49:32 +0200
Message-ID: <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com>
Subject: Re: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.
>
> Syzbot[1] reported the drecrement of reference count hits leaking memory.
>
> If we failed in setup_net() and try to undo the setup process, the
> reference now is 1 which shouldn't be decremented. However, it happened
> actually.
>
> After applying this patch which allows us to check the reference first,
> it will not hit zero anymore in tcp_twsk_purge() without calling
> inet_twsk_purge() one more time.
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
> The reverted patch trying to solve another issue causes unexpected error =
as above. I
> think that issue can be properly analyzed and handled later. So can we re=
vert it first?
> ---
>  net/ipv4/tcp_minisocks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b93619b2384b..46e6f9db4227 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_exit_list)
>                         /* Even if tw_refcount =3D=3D 1, we must clean up=
 kernel reqsk */
>                         inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo)=
;
>                 } else if (!purged_once) {
> +                       /* The last refcount is decremented in tcp_sk_exi=
t_batch() */
> +                       if (refcount_read(&net->ipv4.tcp_death_row.tw_ref=
count) =3D=3D 1)
> +                               continue;
> +
>                         inet_twsk_purge(&tcp_hashinfo);
>                         purged_once =3D true;
>                 }
> --

This can not be a fix for a race condition.

By definition a TW has a refcount on tcp_death_row.tw_refcount   only
if its timer is armed.

And inet_twsk_deschedule_put() does

if (del_timer_sync(&tw->tw_timer))
    inet_twsk_kill(tw);

I think you need to provide a full explanation, instead of a shot in the da=
rk.

Before releasing this syzbot, I thought that maybe the refcount_inc()
was done too late,
but considering other invariants, this should not matter.

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e28075f0006e333897ad379ebc8c87fc3f9643bd..d8f4d93c45331be64d70af96de3=
3f783870e1dcc
100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
inet_timewait_sock *tw, int timeo, bool rearm)

                __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILL=
ED :
                                                     LINUX_MIB_TIMEWAITED);
-               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
                refcount_inc(&tw->tw_dr->tw_refcount);
+               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
        } else {
                mod_timer_pending(&tw->tw_timer, jiffies + timeo);
        }

