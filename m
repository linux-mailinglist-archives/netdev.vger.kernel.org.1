Return-Path: <netdev+bounces-112924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD093BE2B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42891C21021
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3D196438;
	Thu, 25 Jul 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYFtCv/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF7172BAF;
	Thu, 25 Jul 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897420; cv=none; b=McjbvH77BrSr7F/+eQnJqGttvOLu1Q2shbsTUsewTNgJOZcditFsmugTy0wFV+kKJ7WDtuP2MlS60upUENe1gWf3ZpFQQ32S8YhlXmeoq2Ki+GsoNlbS+XADDxnmHdLc/rn1MIb5vUVPWeddzGmCO7VxUwiEw9I9Zsnbx8UyqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897420; c=relaxed/simple;
	bh=jC5zAnmHCIGU30jUjfy72ch01ORGPhCX551H1DKuOV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8+83DSjdAK0+4KDFz32UussOjde7+UOdhbRwXsa3XrG8VDf4t+IuXbd2OMPpUfEFBlkQcG9y7MLTiVpQmDwW0c1GvzNy22e0GDHhniZoWuFhLIBtsamBP6CwA8LE0s2PvThABvBwZf5hCpYNsC0+tA1dGO/WLvnyOIEGVh1LHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYFtCv/x; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7928d2abe0aso1322352a12.0;
        Thu, 25 Jul 2024 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721897418; x=1722502218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyACZrVQiZSUQdlMAIG1RTd+aJxmaLi0svwv16Sq6Ck=;
        b=EYFtCv/xs00auxG8mloooAXNGbpOrETLK9/AaZmJh46w+0Sny4oH9kiGyUIfhG6c3v
         KH+2FUxy28YbxdDiDgfeHENzaXCtA7HRJQOLd4tG2cVDZb2y+51RYyr8I5ES52+YR+IH
         GIDCQNTH1HRsdMuBNdMEXijJZnYWgmNx8kVeaeywBXd5ddxZ3yjoHiAS0btACZuVUS7E
         dE5PPmtDu9OmCjawIXMTfUCMxZ1K7GPC1Tpj8bEkDQixnIbF1yTzsaMM4RN6G1tClwrG
         8iDPKXqrVMpP+r8A//ykNqIvmbEDGww9jhQSrTcBtAWjbc7Bz9baZnHQMTyUtw3e/x81
         uqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721897418; x=1722502218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyACZrVQiZSUQdlMAIG1RTd+aJxmaLi0svwv16Sq6Ck=;
        b=GIjwTWsoqTyLiZc/Nz2QWInb7XcNtQ9m8dAjXY8r6YzKGOLJQVnaDXdh+vbomxq1n8
         YzEeqHjNGw2BZKMVmPR2dxKlsCqPTt5tZV3ieaynyTNO4YzkxoU2iZeap9dAePQU3Yca
         Wq2tziGFd37R4xjl/9MVqaTeQC87LyqPcIPTuHHzSrw5dLd/FeiDPYds4BXQAq5aTBbf
         pfvFsYH9jht70dWAjFyPuKUjjdpNHYdhXYGFoX0LPw1PEnipwD2rlrrthuYrQfiBlHCo
         I8o9+IxkFO9LrAIWAt7pHmaRmOZBigJfpmyEA1H27psxPXurEPnKsNaJxziHltru8EAo
         zHFw==
X-Forwarded-Encrypted: i=1; AJvYcCVXS2b4bYAEUEIC1LVTQ3L03YmyWPalSYlLByIJBFZfLn22mmelREyYqhwHXo9dnXI2jFaFDHJYFOqDrKWbbtg3XF4Uu26sZwFg8KbdONAHRIO5Z7vMJIz1HBu7jgd9XPijexjG
X-Gm-Message-State: AOJu0YzVO+VkYVO9DgDULxaE/y6hy9qaBFYZzENHnvMv0/i6rTbb8Aw/
	Pm3YTdFDLTa3+wDQQkqpJlJCgnNsQvFhzKXDLo33DvN1657BdfdBWQkNyRsL97OEqwS0J22Pqsp
	3cMtG2UG0CNdgWp877DREdwj1yeI=
X-Google-Smtp-Source: AGHT+IFw/Zn8rdKu6jDCYJzn+POlVVRXerbX99pI6ynnLFLegmSEQv6BJkKH0aZCPEroS4MHh9Ph5JQKtXKVAsPNBCo=
X-Received: by 2002:a17:90b:4a8f:b0:2cb:56bd:5d7 with SMTP id
 98e67ed59e1d1-2cdb9387aabmr7530216a91.5.1721897418407; Thu, 25 Jul 2024
 01:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-tcp-ao-static-branch-rcu-v1-1-021d009beebf@gmail.com> <CANn89iLAhXWKkA5xZoZPDj--=hD7RxOTkAPVf31_xLU8L-qyjQ@mail.gmail.com>
In-Reply-To: <CANn89iLAhXWKkA5xZoZPDj--=hD7RxOTkAPVf31_xLU8L-qyjQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 25 Jul 2024 09:50:06 +0100
Message-ID: <CAJwJo6byPNeA_K3kgx-xtEpNMNja3+GrfwzhxtAxE4QE4S6-OA@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp: Disable TCP-AO static key after RCU grace period
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric, thanks for looking into this,

On Thu, 25 Jul 2024 at 08:48, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Jul 25, 2024 at 7:00=E2=80=AFAM Dmitry Safonov via B4 Relay
> <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> >
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > The lifetime of TCP-AO static_key is the same as the last
> > tcp_ao_info. On the socket destruction tcp_ao_info ceases to be
> > with RCU grace period, while tcp-ao static branch is currently deferred
> > destructed. The static key definition is
> > : DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
> >
> > which means that if RCU grace period is delayed by more than a second
> > and tcp_ao_needed is in the process of disablement, other CPUs may
> > yet see tcp_ao_info which atent dead, but soon-to-be.
>
> > And that breaks the assumption of static_key_fast_inc_not_disabled().
>
> I am afraid I do not understand this changelog at all.
>
> What is "the assumption of static_key_fast_inc_not_disabled()"  you
> are referring to ?
>
> I think it would help to provide more details.

Sorry, my bad, I'm referring here to the comment/description for the functi=
on:

 * static_key_fast_inc_not_disabled - adds a user for a static key
 * @key: static key that must be already enabled
 *
 * The caller must make sure that the static key can't get disabled while
 * in this function. It doesn't patch jump labels, only adds a user to
 * an already enabled static key.

Originally it was introduced in commit eb8c507296f6 ("jump_label:
Prevent key->enabled int overflow"), which is needed for the atomic
contexts, one of which would be the creation of a full socket from a
request socket. In that atomic context, we know by the presence of the
key (md5/ao) that the static branch is already enabled. So, we can
just increment the ref counter for that static branch instead of
holding the proper mutex. static_key_fast_inc_not_disabled() is just a
helper for that usage case. But it must not be used if the static
branch could get disabled in parallel as it's not protected by
jump_label_mutex and as a result, races with jump_label_update()
implementation details.

Specifically, from the log in [1], I see that jump_label_type()
wrongly tells arch_jump_label_transform_queue() to enable the
static_brach, when the caller was, in fact,
__static_key_slow_dec_cpuslocked() - requesting to disable that. And
then, the x86-specific code produces:
: jump_label: Fatal kernel bug, unexpected op at
tcp_inbound_hash+0x1a7/0x870 [ffffffffa8c4e9b7] (eb 50 0f 1f 44 !=3D 66
90 0f 1f 00)) size:2 type:1

when it tries to enable the static key; but the op-code is not no-op,
it's 2-byte jump. The reason for that of course is that intended
operation was to disable the branch, but it has raced with this
increment helper.

Hopefully, that clarifies somewhat the situation here.

Thankfully, for TCP-MD5 I did a better job: tcp_md5sig_info_free_rcu()
and tcp_md5_twsk_free_rcu() are RCU callbacks.

Also, please note that I intentionally call
static_branch_slow_dec_deferred() variant in the RCU callback, rather
than synchronous. The reason for that:

 * When the control is directly exposed to userspace, it is prudent to dela=
y the
 * decrement to avoid high frequency code modifications which can (and do)
 * cause significant performance degradation. Struct static_key_deferred an=
d
 * static_key_slow_dec_deferred() provide for this.

>
> >
> > Happened on netdev test-bot[1], so not a theoretical issue:
> >
> > [] jump_label: Fatal kernel bug, unexpected op at tcp_inbound_hash+0x1a=
7/0x870 [ffffffffa8c4e9b7] (eb 50 0f 1f 44 !=3D 66 90 0f 1f 00)) size:2 typ=
e:1
> > [] ------------[ cut here ]------------
> > [] kernel BUG at arch/x86/kernel/jump_label.c:73!
> > [] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > [] CPU: 3 PID: 243 Comm: kworker/3:3 Not tainted 6.10.0-virtme #1
> > [] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16=
.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [] Workqueue: events jump_label_update_timeout
> > [] RIP: 0010:__jump_label_patch+0x2f6/0x350
> > ...
> > [] Call Trace:
> > []  <TASK>
> > []  arch_jump_label_transform_queue+0x6c/0x110
> > []  __jump_label_update+0xef/0x350
> > []  __static_key_slow_dec_cpuslocked.part.0+0x3c/0x60
> > []  jump_label_update_timeout+0x2c/0x40
> > []  process_one_work+0xe3b/0x1670
> > []  worker_thread+0x587/0xce0
> > []  kthread+0x28a/0x350
> > []  ret_from_fork+0x31/0x70
> > []  ret_from_fork_asm+0x1a/0x30
> > []  </TASK>
> > [] Modules linked in: veth
> > [] ---[ end trace 0000000000000000 ]---
> > [] RIP: 0010:__jump_label_patch+0x2f6/0x350
> >
> > [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/696681/5=
-connect-deny-ipv6/stderr
> >
> > Cc: stable@kernel.org
> > Fixes: 67fa83f7c86a ("net/tcp: Add static_key for TCP-AO")
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> > ---
> > ---
> >  net/ipv4/tcp_ao.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index 85531437890c..5ce914d3e3db 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -267,6 +267,14 @@ static void tcp_ao_key_free_rcu(struct rcu_head *h=
ead)
> >         kfree_sensitive(key);
> >  }
> >
> > +static void tcp_ao_info_free_rcu(struct rcu_head *head)
> > +{
> > +       struct tcp_ao_info *ao =3D container_of(head, struct tcp_ao_inf=
o, rcu);
> > +
> > +       kfree(ao);
> > +       static_branch_slow_dec_deferred(&tcp_ao_needed);
> > +}
> > +
> >  void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
> >  {
> >         struct tcp_ao_info *ao;
> > @@ -290,9 +298,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk=
)
> >                         atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem=
_alloc);
> >                 call_rcu(&key->rcu, tcp_ao_key_free_rcu);
> >         }
> > -
> > -       kfree_rcu(ao, rcu);
> > -       static_branch_slow_dec_deferred(&tcp_ao_needed);
> > +       call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
> >  }
> >
> >  void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock=
 *tp)
> >
> > ---
> > base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
> > change-id: 20240725-tcp-ao-static-branch-rcu-85ede7b3a1a5
> >
> > Best regards,
> > --
> > Dmitry Safonov <0x7f454c46@gmail.com>
> >
> >


Thanks,
             Dmitry

