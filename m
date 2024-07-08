Return-Path: <netdev+bounces-109989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04192A993
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D7B211AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22114D43E;
	Mon,  8 Jul 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="se2IInBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D91474AF
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465691; cv=none; b=Sa+I157hxYPUDaYCF8l1Wbm8pOUtrJBoCUqgsZ2NaCWwjzc/kqAt0Re3iPem++gu3K5Ic6SIkSC/aFiN4nkVRHMmEd1P82kto0wrHSiKUAdiEc70WtwPT4VHOYm5WuNxVLHeqVHnkhNPzPFfVklSEEPe9KjSxTSl2JknK9edRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465691; c=relaxed/simple;
	bh=bboE7vcv+2dn34c2Xrct6AS6OnHKyghfnYgCNKCqmzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GO9x/IsAlQZayh7XRUc1B6zqnpum6rTIEm5tc3bnZd733WY/OyisfFIDx5x5u8pcyTOdFgqcv8vJY/KKeOeKTKax9bHmIs8XIlXwlItsLZaExo7TqdJqL8/NOESPQEOCU0LpO6VWf73OLAMJeUbku2OsR80qYzgl0mJfFbUwrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=se2IInBr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so2810a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720465688; x=1721070488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gh71l/RVnGhrjG6aJOcgFxmIcTp7hZ3m2TbvGhEQ68=;
        b=se2IInBrLFlD236J0NVXnTBUoPozA0Iy8tOVh/2VDPWUTpEKKajVGlmk8439B/Zgpu
         v3mVvI+LzD5nW/+/DJEBEezsAQUwXyRy1o1IAdNlQd4uXBp8O3eqwNjvDX/S9RL7FhCw
         2FoDmH2IFtBDvRmBfoVRxqSbfxXtJDgY0ltj3K4ykM86HCh55udADiqiwNXrJlVZUwsr
         ezFtYoOQT1jIuf/hUtWq13KUzR/Bqptj9G3YCdiU58uzn3edRxTmdhWmm65ly96bgwTi
         gboJRJEvWSR11NhcjsyP6Y8rlHA6mAmUK+KjkIbTfLgwtDfEPBPfhAgXWlwkbHz8Rb9o
         IO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720465688; x=1721070488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gh71l/RVnGhrjG6aJOcgFxmIcTp7hZ3m2TbvGhEQ68=;
        b=xBABjjJcCW1X7aySH5jhvbKKUU1M2AaZE9UPqSNUIUQAXFcHv3gg7FC3Qw8P0vBQGp
         /kSVr9M+79OhE6DtAneq0tBfgvvNetplo4MlDQQEDt3e1WGW6RNOcrDOkAKmZpSF6UFC
         /WepAQ9wFVyFfx65G6E5QqsI/uJwDg0//LFrdWr39UHx4DSek+y4j5L44zX7wuJkqIgp
         NurCeh0Oadl6mtwsqHpWx2tbnFOxnCsxtD4xnak+KUfmOZUGF312JHdzyMaYxKeCxy13
         QSOz98MANJHt7u7suo34xvx92lL6OD5/nLhBQZWfS/dBNWix4yDRCsNeXAgc+eL35sKR
         c5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmRN004k7/a304GfM0zRqziM6M54Ol+pDRl7/St6oNn0sc/Rgk83y+6tg8cTM5B/+KrRXZrB6vPAMq2Y8wEc7/iFo8b4iv
X-Gm-Message-State: AOJu0YxJhpz84bMD5VUQ1YXedFSNb9R9L3p4aGlV9CMtmBZAfQzinLdK
	sq+RusfMBe9EDr1cYXANs2CNuKgiaKGHxApF+DIXhu0Iopsz5Q2Vy0Iaih1cwwsvAyMbKePLb3l
	z39VrM0iaUb1Qk4NIsfdEfWwHVoAgaY5HAq+x
X-Google-Smtp-Source: AGHT+IFtzist5mYLYCWtIVxlYiS90O3SMEYg/FUGH+WI4IJHJqSPty56Yp+fEV2RI7YqowB2D8o16zd6Z/trlCNhBNc=
X-Received: by 2002:a50:bb27:0:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-594d42d7edbmr32870a12.1.1720465687245; Mon, 08 Jul 2024
 12:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJF4X+zFFFfhHdDWcYxTO0J_TZ-oN=X_8_FuQqxsCWJCQ@mail.gmail.com>
 <20240708185535.96845-1-kuniyu@amazon.com>
In-Reply-To: <20240708185535.96845-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jul 2024 12:07:56 -0700
Message-ID: <CANn89iKMDDzRox+KC4dGGBCL+VgBSR2S8NoKYcLHR3TS4r_XqQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:55=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Mon, 8 Jul 2024 11:38:41 -0700
> > On Mon, Jul 8, 2024 at 11:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > syzkaller triggered the warning [0] in udp_v4_early_demux().
> > >
> > > In udp_v4_early_demux(), we do not touch the refcount of the looked-u=
p
> > > sk and use sock_pfree() as skb->destructor, so we check SOCK_RCU_FREE
> > > to ensure that the sk is safe to access during the RCU grace period.
> > >
> > > Currently, SOCK_RCU_FREE is flagged for a bound socket after being pu=
t
> > > into the hash table.  Moreover, the SOCK_RCU_FREE check is done too
> > > early in udp_v4_early_demux(), so there could be a small race window:
> > >
> > >   CPU1                                 CPU2
> > >   ----                                 ----
> > >   udp_v4_early_demux()                 udp_lib_get_port()
> > >   |                                    |- hlist_add_head_rcu()
> > >   |- sk =3D __udp4_lib_demux_lookup()    |
> > >   |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
> > >                                        `- sock_set_flag(sk, SOCK_RCU_=
FREE)
> > >
> > > In practice, sock_pfree() is called much later, when SOCK_RCU_FREE
> > > is most likely propagated for other CPUs; otherwise, we will see
> > > another warning of sk refcount underflow, but at least I didn't.
> > >
> > > Technically, moving sock_set_flag(sk, SOCK_RCU_FREE) before
> > > hlist_add_{head,tail}_rcu() does not guarantee the order, and we
> > > must put smp_mb() between them, or smp_wmb() there and smp_rmb()
> > > in udp_v4_early_demux().
> > >
> > > But it's overkill in the real scenario, so I just put smp_mb() only u=
nder
> > > CONFIG_DEBUG_NET to silence the splat.  When we see the refcount unde=
rflow
> > > warning, we can remove the config guard.
> > >
> > > Another option would be to remove DEBUG_NET_WARN_ON_ONCE(), but this =
could
> > > make future debugging harder without the hints in udp_v4_early_demux(=
) and
> > > udp_lib_get_port().
> > >
> > > [0]:
> > >
> > > Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early dem=
ux")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/ipv4/udp.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 189c9113fe9a..1a05cc3d2b4f 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -326,6 +326,12 @@ int udp_lib_get_port(struct sock *sk, unsigned s=
hort snum,
> > >                         goto fail_unlock;
> > >                 }
> > >
> > > +               sock_set_flag(sk, SOCK_RCU_FREE);
> >
> > Nice catch.
> >
> > > +
> > > +               if (IS_ENABLED(CONFIG_DEBUG_NET))
> > > +                       /* for DEBUG_NET_WARN_ON_ONCE() in udp_v4_ear=
ly_demux(). */
> > > +                       smp_mb();
> > > +
> >
> > I do not think this smp_mb() is needed. If this was, many other RCU
> > operations would need it,
> >
> > RCU rules mandate that all memory writes must be committed before the
> > object can be seen
> > by other cpus in the hash table.
> >
> > This includes the setting of the SOCK_RCU_FREE flag.
> >
> > For instance, hlist_add_head_rcu() does a
> > rcu_assign_pointer(hlist_first_rcu(h), n);
>
> Ah, I was thinking spinlock will not prevent reordering, but
> now I see, rcu_assign_pointer() had necessary barrier. :)
>
>   /**
>    * rcu_assign_pointer() - assign to RCU-protected pointer
>    ...
>    * Assigns the specified value to the specified RCU-protected
>    * pointer, ensuring that any concurrent RCU readers will see
>    * any prior initialization.
>
> will remove smp_mb() and update the changelog in v2.
>

A similar commit was

commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Wed Nov 8 13:13:25 2023 -0800

    net: set SOCK_RCU_FREE before inserting socket into hashtable

So I wonder if the bug could be older...

