Return-Path: <netdev+bounces-110008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4192AAC6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA931F214FE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C414D435;
	Mon,  8 Jul 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vbSjz6A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DA38FA5
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472017; cv=none; b=re4yNRlAUU2FbjVnI+9mnrWp91NnEq2IkFCycTkw9cAVe+585xCgJzSdbarNmrhcjtAx2intvmkSQkdMs2KvmH2zUbNvNC00xsIrWN2CedHCJz3tN8rHJC+9uz37g3qqsXlq+7Bm8HmgLnck4QoARjqxb8tHHdpVDYZgGV7JJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472017; c=relaxed/simple;
	bh=ocjADVUWVPl7uJvP9siX3rLYCmLxg6lXBfaNA0yZCDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4OVD62Yh0XyOc8HGjJ8+CFM28DGFc42TXYpeI30uHN513tqipydbFaAq5bV+7EWi56oYcOVeU9AKXt+tCiSJUlD+tIoLHpapWjZnVK3ux0M3+09WeYcoGiJwfOJqKVszE3Ywq/Xj8JrbSSzUZ4JBOyf+Ad14AhfCbgqAxWqsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vbSjz6A; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so1467a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720472014; x=1721076814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o/VFJE9viE8RFNSBOtY7P5WVTGXG54GLMUU+ZvtDxU=;
        b=0vbSjz6Ar7uZOcJye3UIVg+37Y7RNjYzHjy+s7OA/YbuLpFyWlef7YJ6HfHCpmcV7Z
         cDCeu5RhKzMzJeyLYoGHC4MRPKz8Y7M7PGBwo70zmgWyqPK3ceA8J+Z1YLfKIBxLL0Pb
         FW7Yfoix/TXalTZzn8KQIdnK2BbHCqsVRrAYAI777KOZnELjreEH2zfMIJ8OSWV6Rwl5
         +9zYoxcrxxNudAQ41v20svVHfLIKn/UY9mXxQlLFEaBq0NSJ4BbONxGRtdkSyU58Xl6e
         a9QVjTn6o2PPGJjoYSSPZU8vT76xq+tWoG2pfo27OFJZmClkifKmv04F/zq3rhF98XOk
         NkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472014; x=1721076814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o/VFJE9viE8RFNSBOtY7P5WVTGXG54GLMUU+ZvtDxU=;
        b=e41C4Aw8B99+b38YPJCqcWtVDwhCAbIA2kNN/QaCIJavzRaIyOS9V/PZFa7lwQb9UM
         ScRpXt4MeTJ9biV13Ahtl4iFIyHFQH0h/dMKSl6YGUHt6RJ5ldwFcPXN59s5A+3gvdJv
         XGMU3JElxMCSgYWTe8dGc7qnAVBeN0YwHUSo5nEw2Xy9xNurCtr31FdG9/v80zLaqUJX
         i4vF7NvAhuJkdaoIM1xP5mm0sx3OQCa5KMcVNADX5LxfItGA7fqOUM+MznX4lk3kqAn8
         8IPzwbaBgPDPZ10XfARbcKTqcGPBhMshqLbv3ypiVny7qf/2oAArz2aP62YhS+hD3nI9
         Bj6A==
X-Forwarded-Encrypted: i=1; AJvYcCX2m0XE3a6mVeoF6Q6Ium/C/EgVfJnegzv8qvLNdkp+gDOdee0uzxGbs+gg42yi3m8++UMBanfjqrA4JCHYbJXNOfsKycDM
X-Gm-Message-State: AOJu0Yz9G485rGF9BnidrNIXIF/+U14hsvJwL2B44I5H6Xtr0D+ESzbR
	6swdjZt4BeFVqBWhSYk4Yzipi/lmdd85xx4vnXqFC6LaxUfahAVP/vDnpHgWOKTGwLMxwZADcqN
	plkLd6J2BMWOKj44GuIWWOeMe49rJkCHK/X1x
X-Google-Smtp-Source: AGHT+IEM8fylOUuo9xHH9y+mm15Ya3Rn9Xy5f23CNFGHMmUMNwua4lAkyUoMXYAFqsUn3iN5ZcF3/JHhbuqrX8nZuKk=
X-Received: by 2002:a50:9fc1:0:b0:58b:21f2:74e6 with SMTP id
 4fb4d7f45d1cf-594cf64511dmr61852a12.0.1720472013983; Mon, 08 Jul 2024
 13:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKMDDzRox+KC4dGGBCL+VgBSR2S8NoKYcLHR3TS4r_XqQ@mail.gmail.com>
 <20240708192034.99704-1-kuniyu@amazon.com>
In-Reply-To: <20240708192034.99704-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jul 2024 13:53:19 -0700
Message-ID: <CANn89iLmhzrbuWu0xp-+yhy64UVbO9fN45y3D-D-OMWnB-+OEQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Mon, 8 Jul 2024 12:07:56 -0700
> > On Mon, Jul 8, 2024 at 11:55=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Eric Dumazet <edumazet@google.com>
> > > Date: Mon, 8 Jul 2024 11:38:41 -0700
> > > > On Mon, Jul 8, 2024 at 11:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@a=
mazon.com> wrote:
> > > > >
> > > > > syzkaller triggered the warning [0] in udp_v4_early_demux().
> > > > >
> > > > > In udp_v4_early_demux(), we do not touch the refcount of the look=
ed-up
> > > > > sk and use sock_pfree() as skb->destructor, so we check SOCK_RCU_=
FREE
> > > > > to ensure that the sk is safe to access during the RCU grace peri=
od.
> > > > >
> > > > > Currently, SOCK_RCU_FREE is flagged for a bound socket after bein=
g put
> > > > > into the hash table.  Moreover, the SOCK_RCU_FREE check is done t=
oo
> > > > > early in udp_v4_early_demux(), so there could be a small race win=
dow:
> > > > >
> > > > >   CPU1                                 CPU2
> > > > >   ----                                 ----
> > > > >   udp_v4_early_demux()                 udp_lib_get_port()
> > > > >   |                                    |- hlist_add_head_rcu()
> > > > >   |- sk =3D __udp4_lib_demux_lookup()    |
> > > > >   |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
> > > > >                                        `- sock_set_flag(sk, SOCK_=
RCU_FREE)
> > > > >
> > > > > In practice, sock_pfree() is called much later, when SOCK_RCU_FRE=
E
> > > > > is most likely propagated for other CPUs; otherwise, we will see
> > > > > another warning of sk refcount underflow, but at least I didn't.
> > > > >
> > > > > Technically, moving sock_set_flag(sk, SOCK_RCU_FREE) before
> > > > > hlist_add_{head,tail}_rcu() does not guarantee the order, and we
> > > > > must put smp_mb() between them, or smp_wmb() there and smp_rmb()
> > > > > in udp_v4_early_demux().
> > > > >
> > > > > But it's overkill in the real scenario, so I just put smp_mb() on=
ly under
> > > > > CONFIG_DEBUG_NET to silence the splat.  When we see the refcount =
underflow
> > > > > warning, we can remove the config guard.
> > > > >
> > > > > Another option would be to remove DEBUG_NET_WARN_ON_ONCE(), but t=
his could
> > > > > make future debugging harder without the hints in udp_v4_early_de=
mux() and
> > > > > udp_lib_get_port().
> > > > >
> > > > > [0]:
> > > > >
> > > > > Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early=
 demux")
> > > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > ---
> > > > >  net/ipv4/udp.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index 189c9113fe9a..1a05cc3d2b4f 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -326,6 +326,12 @@ int udp_lib_get_port(struct sock *sk, unsign=
ed short snum,
> > > > >                         goto fail_unlock;
> > > > >                 }
> > > > >
> > > > > +               sock_set_flag(sk, SOCK_RCU_FREE);
> > > >
> > > > Nice catch.
> > > >
> > > > > +
> > > > > +               if (IS_ENABLED(CONFIG_DEBUG_NET))
> > > > > +                       /* for DEBUG_NET_WARN_ON_ONCE() in udp_v4=
_early_demux(). */
> > > > > +                       smp_mb();
> > > > > +
> > > >
> > > > I do not think this smp_mb() is needed. If this was, many other RCU
> > > > operations would need it,
> > > >
> > > > RCU rules mandate that all memory writes must be committed before t=
he
> > > > object can be seen
> > > > by other cpus in the hash table.
> > > >
> > > > This includes the setting of the SOCK_RCU_FREE flag.
> > > >
> > > > For instance, hlist_add_head_rcu() does a
> > > > rcu_assign_pointer(hlist_first_rcu(h), n);
> > >
> > > Ah, I was thinking spinlock will not prevent reordering, but
> > > now I see, rcu_assign_pointer() had necessary barrier. :)
> > >
> > >   /**
> > >    * rcu_assign_pointer() - assign to RCU-protected pointer
> > >    ...
> > >    * Assigns the specified value to the specified RCU-protected
> > >    * pointer, ensuring that any concurrent RCU readers will see
> > >    * any prior initialization.
> > >
> > > will remove smp_mb() and update the changelog in v2.
> > >
> >
> > A similar commit was
> >
> > commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
> > Author: Stanislav Fomichev <sdf@fomichev.me>
> > Date:   Wed Nov 8 13:13:25 2023 -0800
> >
> >     net: set SOCK_RCU_FREE before inserting socket into hashtable
> >
> > So I wonder if the bug could be older...
>
> If we focus on the ordering, the Fixes tag would be
>
> Fixes: ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
>
> But, at that time, we had atomic_inc_not_zero_hint() and used
> sock_efree(), which were removed later in 08842c43d016.
>
> Which one should I use as Fixes: ?

I think the older issue might only surface with eBPF users.

commit 6acc9b432e6714d72d7d77ec7c27f6f8358d0c71
Author: Joe Stringer <joe@wand.net.nz>
Date:   Tue Oct 2 13:35:36 2018 -0700

    bpf: Add helper to retrieve socket in BPF

The effect of the bug would be an UDP socket leak (because an
atomic_inc_not_zero_hint() could be used
before SOCK_RCU_FREE has been set. Then the refcount decrement would
be avoided if the SOCK_RCU_FREE was set before it)

08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
added a DEBUG_NET_WARN_ON_ONCE()
which made the bug visible.

