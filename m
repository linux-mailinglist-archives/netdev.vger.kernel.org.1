Return-Path: <netdev+bounces-209182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6053B0E8B4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE066AA0EFB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102819C54E;
	Wed, 23 Jul 2025 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H16dAWD3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F02EB10
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238166; cv=none; b=nPdhE1CkTThKVOPV0r8Kj0Y/zVrWVJ3wnMx/Fn5sKeweckouX5xXLrqrwFWaW5kr6DlmcDdh/GVzUFt8P8rsE3e8HssP1A6SooSAd0Z0AbQTXhTNox7VL7RE+w8QKzGGUBkprEA2+hC8HigxoX2IYsD3+Dish0FQ0BfZ97BlUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238166; c=relaxed/simple;
	bh=M/4kD6413DMz6XJoOp3REQlYY8Xl9JVVZp6ylcL0uJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYmS83pP0uEGxUzZpkH4WPl295lUF5iBatNiem9DYfdghtuj/W7R3B6x2D9rLQb/R34PuviEFUIAJ7nnLs9HALnObCzQmWrU0KA32E8HUnR1/Aj1mnskTpe6sZD02NAsBy17k7JTfB9DOVvFnIT15dG8Xcz4SxMPUBs+Ykx+bZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H16dAWD3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4598746a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753238164; x=1753842964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6IlyFOsklORK9gDxVwJBZ59bc5C+izWBIvmcxqDgPc=;
        b=H16dAWD3YNOw6UeuIx3enf9m9EeMEImwAO8/zJLPJ0jrwzb2LRMteAXgHmCeVRL/r9
         wZpod8+aYxr+zpzjejaos1mEAZKQldCsyLjg+zFf/uL/v8Vlt94iL/QcYafSdesIjEgH
         mHKNugAVNFnOQVf3Nlg/aXsWDcMJSI0ksy9biOnT0nJry7l/ZlvYRJ4ubERtwmIpF9Px
         5cilG7fllAD64p+EqdYnPY+01m2tgqwZurOA0kwd5loAkSgJFwNgmVDE0F2HyIM3sjNZ
         WNi0dXT3tfcIkIHZY8zA4r5s6eK9w+TB1sTuqBbh+Cmo8oqUMi922zur1TzavtqHag9X
         6oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238164; x=1753842964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6IlyFOsklORK9gDxVwJBZ59bc5C+izWBIvmcxqDgPc=;
        b=dco+wN8tFUl3MFHFWkDp1RpJjFE+NUV7BAs+hTsRlfnGGnglme0ASwv9+5ECCAOolm
         MW2YX1wdTioITcyr8k9SahlP3J+ABl3PS+g2baxWi98RdVb9Hn9mH4TP8Tc45lCNhAFY
         srICteAQl/QN+PaKHymb1lb04pimOyd9wQJ6aiN5PDz/fkiB3IHpZ1LsecIoX77d066l
         zGPGg+j5PicmAKxQpx4/y86gHjcOTMckthgx8494DDg3tACz+sDX9wLBQ9tMGJ3a9Mw+
         6UquE+Qq4fH8/E6B4x6304ROpqGXCmwnuRvpOah4xQVLM73nICyP5ztNlhx/GCtW1bcQ
         aogw==
X-Forwarded-Encrypted: i=1; AJvYcCX+H0Xyj5fH6YMl0F+cdMLkWRGfTbYjGjHugLFiwQkywQZyt7DRWQpdCEhxlqqYsDEY7gQFeuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHBHbMgM0fpptF8VJnH5wdZT8dFGuCBrwCXhn6dxpFv9TaMg4
	RmLBk/XH1nzr7QmNhXyLznSLTZxzpdGyE0PWpBMSf7YTVjyGUloVp6RkPHzGxvLWaVz8a25npMr
	JvEx5r7Q6tC0ghn6CYv2FNMbH2N31xGHAz0qeCxkT
X-Gm-Gg: ASbGnctoL+bhHfkrsaDE+KF9cUjwNpVZ7R8N+x1QoaYu3aHMK7RHjMp85F4BbMnTqeL
	cFfyV3ViHZQdeXtJyfpSgKGkI2KANZThXZypopGN6TBMg35RDjimmerw47WygdtYZP+4bGRqaGO
	NSWY0UJdG+zXhewJQsmzeL/gEz9Z4SVq8TV8H4Um/Cj1OqXuAqqpqDMi/wf2Id4d9vLvqvRjp9a
	+Vv6shjU5Q3WgN2H7hKZoPnLy9olq6U+CigGzPL
X-Google-Smtp-Source: AGHT+IE/TvRzCIs9asOKjtXzPvSStPkY4vcjrq1vIuSRcDBkm4TXvsIuOsDApjUEP3e2xctvHjG7Ts5ac40QWu8hWJ0=
X-Received: by 2002:a17:90a:e183:b0:316:d69d:49fb with SMTP id
 98e67ed59e1d1-31e5076a6f7mr2538202a91.14.1753238163400; Tue, 22 Jul 2025
 19:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
 <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
 <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com> <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
In-Reply-To: <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 19:35:52 -0700
X-Gm-Features: Ac12FXwhtXeBUII0bX8ILz_qr1B1fIfpOOkBNseRwEy-StMeZ8GsbYQQA6nLq7M
Message-ID: <CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 5:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jul 22, 2025 at 02:59:33PM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 12:56=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Jul 22, 2025 at 12:03:48PM -0700, Kuniyuki Iwashima wrote:
> > > > On Tue, Jul 22, 2025 at 11:48=E2=80=AFAM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > > > On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote=
:
> > > > > > >
> > > > > > > I expect this state of jobs with different network accounting=
 config
> > > > > > > running concurrently is temporary while the migrationg from o=
ne to other
> > > > > > > is happening. Please correct me if I am wrong.
> > > > > >
> > > > > > We need to migrate workload gradually and the system-wide confi=
g
> > > > > > does not work at all.  AFAIU, there are already years of effort=
 spent
> > > > > > on the migration but it's not yet completed at Google.  So, I d=
on't think
> > > > > > the need is temporary.
> > > > > >
> > > > >
> > > > > From what I remembered shared borg had completely moved to memcg
> > > > > accounting of network memory (with sys container as an exception)=
 years
> > > > > ago. Did something change there?
> > > >
> > > > AFAICS, there are some workloads that opted out from memcg and
> > > > consumed too much tcp memory due to tcp_mem=3DUINT_MAX, triggering
> > > > OOM and disrupting other workloads.
> > > >
> > >
> > > What were the reasons behind opting out? We should fix those
> > > instead of a permanent opt-out option.
> > >
>
> Any response to the above?

I'm just checking with internal folks, not sure if I will follow up on
this though, see below.

>
> > > > >
> > > > > > >
> > > > > > > My main concern with the memcg knob is that it is permanent a=
nd it
> > > > > > > requires a hierarchical semantics. No need to add a permanent=
 interface
> > > > > > > for a temporary need and I don't see a clear hierarchical sem=
antic for
> > > > > > > this interface.
> > > > > >
> > > > > > I don't see merits of having hierarchical semantics for this kn=
ob.
> > > > > > Regardless of this knob, hierarchical semantics is guaranteed
> > > > > > by other knobs.  I think such semantics for this knob just comp=
licates
> > > > > > the code with no gain.
> > > > > >
> > > > >
> > > > > Cgroup interfaces are hierarchical and we want to keep it that wa=
y.
> > > > > Putting non-hierarchical interfaces just makes configuration and =
setup
> > > > > hard to reason about.
> > > >
> > > > Actually, I tried that way in the initial draft version, but even i=
f the
> > > > parent's knob is 1 and child one is 0, a harmful scenario didn't co=
me
> > > > to my mind.
> > > >
> > >
> > > It is not just about harmful scenario but more about clear semantics.
> > > Check memory.zswap.writeback semantics.
> >
> > zswap checks all parent cgroups when evaluating the knob, but
> > this is not an option for the networking fast path as we cannot
> > check them for every skb, which will degrade the performance.
>
> That's an implementation detail and you can definitely optimize it. One
> possible way might be caching the state in socket at creation time which
> puts some restrictions like to change the config, workload needs to be
> restarted.
>
> >
> > Also, we don't track which sockets were created with the knob
> > enabled and how many such sockets are still left under the cgroup,
> > there is no way to keep options consistent throughout the hierarchy
> > and no need to try hard to make the option pretend to be consistent
> > if there's no real issue.
> >
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > I am wondering if alternative approches for per-workload sett=
ings are
> > > > > > > explore starting with BPF.
> > > > > > >
> > > > >
> > > > > Any response on the above? Any alternative approaches explored?
> > > >
> > > > Do you mean flagging each socket by BPF at cgroup hook ?
> > >
> > > Not sure. Will it not be very similar to your current approach? Each
> > > socket is associated with a memcg and the at the place where you need=
 to
> > > check which accounting method to use, just check that memcg setting i=
n
> > > bpf and you can cache the result in socket as well.
> >
> > The socket pointer is not writable by default, thus we need to add
> > a bpf helper or kfunc just for flipping a single bit.  As said, this is
> > overkill, and per-memcg knob is much simpler.
> >
>
> Your simple solution is exposing a stable permanent user facing API
> which I suspect is temporary situation. Let's discuss it at the end.
>
> >
> > >
> > > >
> > > > I think it's overkill and we don't need such finer granularity.
> > > >
> > > > Also it sounds way too hacky to use BPF to correct the weird
> > > > behaviour from day0.
> > >
> > > What weird behavior? Two accounting mechanisms. Yes I agree but memcg=
s
> > > with different accounting mechanisms concurrently is also weird.
> >
> > Not that weird given the root cgroup does not allocate sk->sk_memcg
> > and are subject to the global tcp memory accounting.  We already have
> > a mixed set of memcgs.
>
> Running workloads in root cgroup is not normal and comes with a warning
> of no isolation provided.
>
> I looked at the patch again to understand the modes you are introducing.
> Initially, I thought the series introduced multiple modes, including an
> option to exclude network memory from memcg accounting. However, if I
> understand correctly, that is not the case=E2=80=94the opt-out applies on=
ly to
> the global TCP/UDP accounting. That=E2=80=99s a relief, and I apologize f=
or the
> misunderstanding.
>
> If I=E2=80=99m correct, you need a way to exclude a workload from the glo=
bal
> TCP/UDP accounting, and currently, memcg serves as a convenient
> abstraction for the workload. Please let me know if I misunderstood.

Correct.

Currently, memcg by itself cannot guarantee that memory allocation for
socket buffer does not fail even when memory.current < memory.max
due to the global protocol limits.

It means we need to increase the global limits to

(bytes of TCP socket buffer in each cgroup) * (number of cgroup)

, which is hard to predict, and I guess that's the reason why you
or Wei set tcp_mem[] to UINT_MAX so that we can ignore the global
limit.

But we should keep tcp_mem[] within a sane range in the first place.

This series allows us to configure memcg limits only and let memcg
guarantee no failure until it fully consumes memory.max.

The point is that memcg should not be affected by the global limits,
and this is orthogonal with the assumption that every workload should
be running under memcg.


>
> Now memcg is one way to represent the workload. Another more natural, at
> least to me, is the core cgroup. Basically cgroup.something interface.
> BPF is yet another option.
>
> To me cgroup seems preferrable but let's see what other memcg & cgroup
> folks think. Also note that for cgroup and memcg the interface will need
> to be hierarchical.

As the root cgroup doesn't have the knob, these combinations are
considered hierarchical:

(parent, child) =3D (0, 0), (0, 1), (1, 1)

and only the pattern below is not considered hierarchical

(parent, child) =3D (1, 0)

Let's say we lock the knob at the first socket creation like your
idea above.

If a parent and its child' knobs are (0, 0) and the child creates a
socket, the child memcg is locked as 0.  When the parent enables
the knob, we must check all child cgroups as well.  Or, we lock
the all parents' knobs when a socket is created in a child cgroup
with knob=3D0 ?  In any cases we need a global lock.

Well, I understand that the hierarchical semantics is preferable
for cgroup but I think it does not resolve any real issue and rather
churns the code unnecessarily.

