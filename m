Return-Path: <netdev+bounces-209078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F002BB0E35A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212F2547032
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3DA281356;
	Tue, 22 Jul 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/dLrefV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5E280A5C
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208335; cv=none; b=ot6UorpBu6NQlhEOqMqyRw/IiGP0hOGyvF8Pw37klCnREV2zRyitbLcjOF0X0gP//RooILnsXV+Pc9Bw+9DUJghZHIqTPQtAH3ELWX3t+qzR+t6qC2mgg6S5lh0ekG12aGNN8J6lxMUysSRZnZcyWKPz5EQAX9OZgujrlQKWO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208335; c=relaxed/simple;
	bh=wMPyc3xg/v1/2MZcFZfv3REvzTQgytthyXxvlrsEu5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6i6wVUqbzHq7RKjWQjbGrTaC6xwWGsGqY3kATbip6m2UABjcFIVmGMLhsprrooyy7NwEEAcoTzJTqXjiN6Xxq3iaUcIdkRXzo7NWf/VEmG9vqne/xdAukxWmxhwyfGw8oV3uh0mU+ODUXv6zlwWrPg3laGtOyWQC6ifjftGaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/dLrefV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4720611a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208333; x=1753813133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMYTSLLBkiKddq/FquIPU9bbzQYOdbjhg+lBLqMyOag=;
        b=c/dLrefVFioxbu7PMKkoe8yRELHJY7XNZB8BEPnmFTPYkD8mzedunEze721dKzHKwm
         5gKfN8vDQUuWpFFnH87zsXAsOjC1kSgBPH/+AMq8PbNeV9Z1wWZg67HP3n4YRONW9rL+
         OH2vd8zhrSOE/vX+YKhy79WFb1qt93mY945B9lV/DjhDd8iNZHIn7V+3mLHItSolAFkz
         B0dAFuvQKGp324ylgzdcZuKYqwqYhnkc2ndyNbdXnx6Y4RQBhS8hwZ70wbU2mAx53+CO
         czKo/WM5XeU9xcWhHKu7/OsTpANa4y6k1vrL28NeIZJCsBHRJyD/M9fI+VM1+wFacuKO
         xc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208333; x=1753813133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMYTSLLBkiKddq/FquIPU9bbzQYOdbjhg+lBLqMyOag=;
        b=kttBxyqD0gL/C7UHWNIZItMhdCaEnoRmB3msG1KLvSgmWnWEQ2f4bYOO6xKGPbNFQ1
         QEzUg/aOnmjS2iLJHFheXcFzPj0qlvWD6wXSsrPFS++U0Nwe3l2oBBYPnGrGvr3JCWtw
         JmCsCvaczdCj+ESz80oeR0cudvFlCoaMTrGk7Majw8toG+11Yw3XNc8LNC1epnrt8z/I
         9pno8rbTI1L/RvNk107awJTa+tsmyN54XGfZ/gsemg1B6UyhroFgnUe7mZTPqMjDVmm6
         +9KrD75XYcRbWFBro1nhqfSX7PxnByc02WrYVFz0nk5lUPnb6VykVXGxLQosBCbyOz/k
         0rQA==
X-Forwarded-Encrypted: i=1; AJvYcCUAwnQdWArK6gRkmMN/aipBsnUZcL4IDEBd25sXgOC3Y3Q1VZeeWa3FvwbAEQ9OJDouGWGGUyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdk+0bW6hH1p/DCwiy0IH4/hBJReEkwAyruQaXkU7L/GrFcKM
	YjqH1zIPAXRzKn0DfYAMJr2qBlWt4oYExgIAE6YthRRoMSw4NsVrFU8jqysJOM9DXtunqoXOpD/
	ys+ZIs/M0zK7qwihC9WllsJukUcIcKzNXfHI7Xko4
X-Gm-Gg: ASbGncuqkMqG0Fhi20qp8hIN3PUcoRR1nk8dmgYW/Mi1H/Vzlnu14oPrGdNkKUZ0VKj
	PoS/2o7YHZpgTgz8haRsyGzCiPTFrYERHBwqjM504q+sZc+hsL2JxoJi03xgno9y/KllV28mrc2
	hjTwKJSClP7JgJX+jXT6jWAvtfIYzhyqUEIYyEM9MCc9kX2EYUSGj+YE2BZC6aHJcWXfzTMdKyu
	nz4PGw0iedIqFHqLg+id7EnEIGS9V0KuoNGeg==
X-Google-Smtp-Source: AGHT+IElD1kikSWPb5qZUh/ZHziKPEue1huHVJC1qTZlxH2csGDvjAg3/+9RMCHo3B1QUGheaFDPmjpYlxgxHDS4A9I=
X-Received: by 2002:a17:90b:2f8b:b0:312:db8:dbd2 with SMTP id
 98e67ed59e1d1-31e507c49c4mr448802a91.19.1753208332393; Tue, 22 Jul 2025
 11:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com> <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
In-Reply-To: <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 11:18:40 -0700
X-Gm-Features: Ac12FXzC5_as3QVdk60aGP4lct3yePOviOeUXVs_xi0EDMGbnYX0I8xvyKuP3Lc
Message-ID: <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 8:52=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jul 22, 2025 at 08:24:23AM -0700, Eric Dumazet wrote:
> > On Tue, Jul 22, 2025 at 8:14=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > > Some protocols (e.g., TCP, UDP) implement memory accounting for soc=
ket
> > > > buffers and charge memory to per-protocol global counters pointed t=
o by
> > > > sk->sk_proto->memory_allocated.
> > > >
> > > > When running under a non-root cgroup, this memory is also charged t=
o the
> > > > memcg as sock in memory.stat.
> > > >
> > > > Even when memory usage is controlled by memcg, sockets using such p=
rotocols
> > > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_me=
m).
> > > >
> > > > This makes it difficult to accurately estimate and configure approp=
riate
> > > > global limits, especially in multi-tenant environments.
> > > >
> > > > If all workloads were guaranteed to be controlled under memcg, the =
issue
> > > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > > >
> > > > In reality, this assumption does not always hold, and a single work=
load
> > > > that opts out of memcg can consume memory up to the global limit,
> > > > becoming a noisy neighbour.
> > > >
> > >
> > > Sorry but the above is not reasonable. On a multi-tenant system no
> > > workload should be able to opt out of memcg accounting if isolation i=
s
> > > needed. If a workload can opt out then there is no guarantee.
> >
> > Deployment issue ?
> >
> > In a multi-tenant system you can not suddenly force all workloads to
> > be TCP memcg charged. This has caused many OMG.
>
> Let's discuss the above at the end.
>
> >
> > Also, the current situation of maintaining two limits (memcg one, plus
> > global tcp_memory_allocated) is very inefficient.
>
> Agree.
>
> >
> > If we trust memcg, then why have an expensive safety belt ?
> >
> > With this series, we can finally use one or the other limit. This
> > should have been done from day-0 really.
>
> Same, I agree.
>
> >
> > >
> > > In addition please avoid adding a per-memcg knob. Why not have system
> > > level setting for the decoupling. I would say start with a build time
> > > config setting or boot parameter then if really needed we can discuss=
 if
> > > system level setting is needed which can be toggled at runtime though
> > > there might be challenges there.
> >
> > Built time or boot parameter ? I fail to see how it can be more conveni=
ent.
>
> I think we agree on decoupling the global and memcg accounting of
> network memory. I am still not clear on the need of per-memcg knob. From
> the earlier comment, it seems like you want mix of jobs with memcg
> limited network memory accounting and with global network accounting
> running concurrently on a system. Is that correct?

Correct.


>
> I expect this state of jobs with different network accounting config
> running concurrently is temporary while the migrationg from one to other
> is happening. Please correct me if I am wrong.

We need to migrate workload gradually and the system-wide config
does not work at all.  AFAIU, there are already years of effort spent
on the migration but it's not yet completed at Google.  So, I don't think
the need is temporary.

>
> My main concern with the memcg knob is that it is permanent and it
> requires a hierarchical semantics. No need to add a permanent interface
> for a temporary need and I don't see a clear hierarchical semantic for
> this interface.

I don't see merits of having hierarchical semantics for this knob.
Regardless of this knob, hierarchical semantics is guaranteed
by other knobs.  I think such semantics for this knob just complicates
the code with no gain.


>
> I am wondering if alternative approches for per-workload settings are
> explore starting with BPF.
>
>
>

