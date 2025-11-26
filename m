Return-Path: <netdev+bounces-242013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A5C8BB24
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D271C3A16A5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83B33D6C7;
	Wed, 26 Nov 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj77uVc4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8D313286
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186398; cv=none; b=VLgxb7jLpFCW/+ifdvWeTNa0S9PVrfSyBpnbnLNrjfw/DrEeGGPq+P+fHRgTaMKOou3vXS77FXSrMfV0ZW/ciDXAbR5F+7UqZKXqzsMAIbYjSSnXWs6SLLbL99bc0nZ7xJIaRrFFii5U+VBiO1AOqU0huasHbdU97+rYauXxzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186398; c=relaxed/simple;
	bh=irdSvN8p3YQiyU1mcrVPjV4TvmyU7tlLo5I/811su7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXFgxzNIt/jEsv4F9SAFsl/sVI6IQnpLffwjlBCt0uNnH/q54fqfxWb7n5C2+nlINaZ7x8uEot44G7JCSklakIV9QZRLjvgY07JAJE6PVw6q7xEN72gxJfje2LB3I7T+2C+MmH8k3GV+cJssc3wBahGvCsBEArWE2Lw2IaBXixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj77uVc4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so82055a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764186396; x=1764791196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM9emwVjFaP8Ns34GcMWOeG3cAT7jXot8heL9Ol9wlQ=;
        b=Kj77uVc4vFzVz8H4EG8w/JjcTbMx0tP58NTrn3IaVTuelgwonhTBkd7Ct6mLjKtfmR
         g01wryVUpklr2sPRz4tFbR362RgewnLmvsOiQglPu6HyzHEvNw6mKYQ0Q5E6COtn9kjW
         z9nrs1KpeyqyRGTf0clSuUwu3Dowp+vOFKfCBMTZKT8p8/MYOzY4yJ9WP7LdFqQvG3gD
         4Z17LroFvPR7RcaWix6QG2rlpTr3ZIJhLwVEYE7dqxTqALzRhm3o7m2HP7o1wSYf2Ria
         U8Nag35giiKK3gCiyk7OMsCIKJGGkfwIsUvwcaefHITaqn9PXvvmfPG/oSIBnneUhRQw
         30Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186396; x=1764791196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wM9emwVjFaP8Ns34GcMWOeG3cAT7jXot8heL9Ol9wlQ=;
        b=wOs4Xg22VJ7PTaiewykWkZheusepaQeuuLOQrQC3RQIWUM03JDzEKZGyySsanZ9thm
         codiPsXhGxbzZCfRvLSkyh7gjvu5WRinrdsHZHg6LLcpvDj5Y2Kkl4OND4b3pVe6HQrF
         f2tzkEuS28dMeEFUw6Fycl7VaWeDIYDpYyTc2xfCFVXNOjduSHtgXHIrQoeODFO1US2i
         9iOO0WvD6bd0ZYmxoH0UwoShDKHbzw6K0z5ONYWQ+/Ow/Hs0NyiHFYPY3ynx+JOjmEPF
         4qes/C5Kuzp6iESxaZ4K+15BHvPyrB469FMg3l2KZ8/iuUqiIYOkNIT/m8G31+Rm8qyU
         C5yw==
X-Forwarded-Encrypted: i=1; AJvYcCX7M/v0Jyu1cwzTM4lj0AKxMnKZgnhrLia77+6itPLQ0oYVMDAQ2EDVyvGL5AGKNNqfygBW/Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWddezO+YfweOR1V8cV9vVgm46qTbZ1hjJ5PoK0B1zP1FQiDn2
	F3R58rv24v2r6blKrWFmlkwYiymXryJj6YUM0HxEqU8prFCa3sEdTf0zyH+sYrO3utG3kV/4R2v
	8DJ1ITZmOtmT/X2B9VCbVtLippdT/Ui0+f/Zzp0UocOwHjhpZO1kPSK1T+ho=
X-Gm-Gg: ASbGnctpj3vztdIcxXIX0H69p4EUYqysanPjWe2WevJHv8cZjFnPBYEwWoD+Y3pVfWF
	MWTr7SPlpoK1fIwxZZIWY++WMjfq27IDiOCd0H1VoLSMFZF6649fl1T1JTM83ERj65dsgUuhaYK
	WmUl25pPU7J8GY0KDQ7D7rRupveEb0ScTrFO/QI30Zx4i0SK+Q/KpYt2zXfzUvmSMqpIh0NjxAX
	zjEvctzk3UUrGmmxf0oscV8WlKL5kseBTryCRRFZB+78GGs+lWCI71zpwYOd9IIzbrgdzWjMOc7
	yAfiS0d/as7DsFGxvBN9H0S1OXsOppNiL93+WDwd4OQiTj3Tt7iYphnVkA==
X-Google-Smtp-Source: AGHT+IG3+tw1osInmsjSD0QyBy+N7qAFiCjoYqj9/jWW2h65Ys+FcevIq1yYaiu32eAr+vyV2K9qgM3gH4+pauXRkTQ=
X-Received: by 2002:a05:693c:8211:b0:2a4:3593:468b with SMTP id
 5a478bee46e88-2a9418bc6c0mr3901206eec.39.1764186395281; Wed, 26 Nov 2025
 11:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125195331.309558-1-kuniyu@google.com> <bd417bb2-212b-4657-a509-e0ed0edb5647@kernel.org>
In-Reply-To: <bd417bb2-212b-4657-a509-e0ed0edb5647@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 26 Nov 2025 11:46:23 -0800
X-Gm-Features: AWmQ_bnIP4IJKRJ-ibS2wKhVbp_zNoX1JN72AlKjF9N-fBhx1Jvn4VelPnOxl0I
Message-ID: <CAAVpQUDqKTmEheVYb31_iGpsePG=CeNLmrpraYFRKu=sE6CpDA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] mptcp: Initialise rcv_mss before calling
 tcp_send_active_reset() in mptcp_do_fastclose().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com, 
	Mat Martineau <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 8:36=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> (+Cc MPTCP ML)
>
> On 25/11/2025 20:53, Kuniyuki Iwashima wrote:
> > syzbot reported divide-by-zero in __tcp_select_window() by
> > MPTCP socket. [0]
>
> Thank you for having released this bug report, and even more for having
> sent the fix!
>
> > We had a similar issue for the bare TCP and fixed in commit
> > 499350a5a6e7 ("tcp: initialize rcv_mss to TCP_MIN_MSS instead
> > of 0").
> >
> > Let's apply the same fix to mptcp_do_fastclose().
> >
> > [0]:
> > Oops: divide error: 0000 [#1] SMP KASAN PTI
> > CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/25/2025
> > RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
> > Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00=
 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c =
41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
> > RSP: 0018:ffffc90003017640 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
> > R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  tcp_select_window net/ipv4/tcp_output.c:281 [inline]
> >  __tcp_transmit_skb+0xbc7/0x3aa0 net/ipv4/tcp_output.c:1568
> >  tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
> >  tcp_send_active_reset+0x2d1/0x5b0 net/ipv4/tcp_output.c:3836
> >  mptcp_do_fastclose+0x27e/0x380 net/mptcp/protocol.c:2793
> >  mptcp_disconnect+0x238/0x710 net/mptcp/protocol.c:3253
> >  mptcp_sendmsg_fastopen+0x2f8/0x580 net/mptcp/protocol.c:1776
>
> Note: arf, sorry, I just noticed my small syzkaller instances found it
> too, and I should have caught it before. I thought this issue was linked
> to another one [1]. It is not: this one here is specific to TFO where
> mptcp_disconnect() is called directly in one error path not cover by the
> selftests.
>
> [1]
> https://lore.kernel.org/20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad21=
65f@kernel.org
>
> >  mptcp_sendmsg+0x1774/0x1980 net/mptcp/protocol.c:1855
> >  sock_sendmsg_nosec net/socket.c:727 [inline]
> >  __sock_sendmsg+0xe5/0x270 net/socket.c:742
> >  __sys_sendto+0x3bd/0x520 net/socket.c:2244
> >  __do_sys_sendto net/socket.c:2251 [inline]
> >  __se_sys_sendto net/socket.c:2247 [inline]
> >  __x64_sys_sendto+0xde/0x100 net/socket.c:2247
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f66e998f749
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffff9acedb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> > RAX: ffffffffffffffda RBX: 00007f66e9be5fa0 RCX: 00007f66e998f749
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
> >  </TASK>
> >
> > Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
>
> I see that this patch targets "net-next". I think it would be better to
> target "net". No need to send a new version, this patch applies on top
> of "net" without conflicts, and Paolo told me he can apply it on top of
> "net".

Ah sorry, I didn't find mptcp_do_fastclose() in my net worktree
and started working on net-next, but my net tree was just stale.

Thank you for the review and sync-up with Paolo!


>
> The patch looks good to me, and can be applied to "net" directly:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
> While at it, just to help me to track the backports:
>
> Cc: stable@vger.kernel.org
>
>
> > Reported-by: syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69260882.a70a0220.d98e3.00b4.GAE=
@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/mptcp/protocol.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 75bb1199bed9..40a8bdd5422a 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2790,6 +2790,12 @@ static void mptcp_do_fastclose(struct sock *sk)
> >                       goto unlock;
> >
> >               subflow->send_fastclose =3D 1;
> > +
> > +             /* Initialize rcv_mss to TCP_MIN_MSS to avoid division by=
 0
> > +              * issue in __tcp_select_window(), see tcp_disconnect().
> > +              */
> > +             inet_csk(ssk)->icsk_ack.rcv_mss =3D TCP_MIN_MSS;
>
>
> I initially thought this should have been set in mptcp_sendmsg_fastopen,
> before calling mptcp_disconnect(), but doing that here is probably safer
> to catch other cases, and it aligns with tcp_disconnect(). So that's
> perfect, no need to change anything!
>
>
> > +
> >               tcp_send_active_reset(ssk, ssk->sk_allocation,
> >                                     SK_RST_REASON_TCP_ABORT_ON_CLOSE);
> >  unlock:
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

