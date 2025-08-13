Return-Path: <netdev+bounces-213469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E04B252E5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 20:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6BA628171
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB32D542A;
	Wed, 13 Aug 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liAQh+XH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E01DD9AC
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109185; cv=none; b=hX8ICPpUX7w9zJLdY6HLpIHiZgWD2awyB3ve/x8905TS4QXmJZFGQs2B5fjE5uVB2ZY87vlnfcF4ZoggKUIdhNDn5tD9NGxRvyDF4forNJh5mWTLHE78y2sbjsrZ/8BmYiGJynW3KGoDjKMEFwvkzXES23RH2rHqxYEImRvBU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109185; c=relaxed/simple;
	bh=fw5JApDG6E7HdeFzFi4vjxwW75IQ4aLteld4LCnG/oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGhV9VbdjWQz9YVv7jv4tqwu7ch51Ajz3xyMw/gXBqIfMR5VrSG61inFuwFwfeFvhT6MTQVWdgQYpIYpRjNiZzVvuOoLqT2tz+oe9uN9zYbePJbxwq9M6lwcYDYoFfzji/3SMxtSqaMTEtu8/7qm+hC4S1sw2ODK8vqBoYZNTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liAQh+XH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f47492so489165ad.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755109183; x=1755713983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rspvbHj5HBwP8PT/Z2YHbQFfZn6hZPQOR0l2xh5UztM=;
        b=liAQh+XHHkSVjbXr1lt8tGaAcISsuLLYholSPb9Y6g3ogsUQevEfJm5eAlfJbk2o4L
         SzECRdqac1AGtmUGHUOi70EFIlMf5/Tu/X/4Cd08XzthXzZ/8k8DXmVF7pJbHrN7xMJu
         ymkr0d07r7w49AM1gZLcdgQDrOPmpxhI2uoh98yhH6z7Hg0axRVr04tlupM2vM9ipsiQ
         pgVGhM86q5Q0c6PGfts1U2/9J04P3gf4EBelW/lztloIQZikV7dhNEKYUBqPRAq94djr
         E3gQTLsoJF24Esj6327vRDdedQoSKlAQ7Oi8TVn9iQ3lHPCOS+MHUlowSmQUIITbqO6w
         fsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109183; x=1755713983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rspvbHj5HBwP8PT/Z2YHbQFfZn6hZPQOR0l2xh5UztM=;
        b=q7oBnSaNsSW55AkNF8EvhlZPwkW+jkYDwHf+DvPo0tq7cK2G8kxfvGxFr3pGFrImFo
         1hjL/z3Cr68Gk+HDvpqGtFUiiIm7zxrHFqgWiZTCkKbcABLm+aZnjDTeYckP0UxrpjOt
         6wkgkfkiTKTcRTWzc8WSJLg3hjfdP+hT/rVy85ggeCpZMnnQHz32HQI7y/X/z8Ak2G5W
         bSN7+A5+39JIXD9imiEA83SUUDU+OjzFHvmpKnR1xVC6UkryipPdujO/fm9dNTqjv+OV
         njCHttd/zCLkLupJZkx2xyb2Jcn6J9SVAPH5ZMablNPrWWCpwgP41KKcu5m/LDfl10JB
         VKvw==
X-Forwarded-Encrypted: i=1; AJvYcCVKKbk9y1EAcgvaTb0B5HT3kjZQaWqKcdNc/jH2uoTeChiu+m6XsvgjF84AKKx3z2zMLWv6Kh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qFT2eINwYo48fuaSOGAuW8Ti4hcSNTI/r5wm6zEIDNdbnj4m
	QAvne/qY55+tfuRGLEh7YzqlYV8omfmRrreGDCDsOImWTd1ZYM+aY6Fam3uVSBwYxHnOxXuOraJ
	Ww69eWbjhkMERKCNBzwyW1L6uO7ZF08FuoAGPNepu
X-Gm-Gg: ASbGncs1ID4r5B0TY82lZel6e7HfjD8y69/JqL+y3CKa3Nw/eAhcTnwwNomYjspZbaM
	wArBxUKlykGFMeLrlGDb+ZttX86A5LyCm7MD3UCGwkhixlvLleKX/Twst/xsXneRMTmdSoeCtgw
	5umoKvWOCa3U4JsGkmzWeSo13NlsoxUcvP+mnhoyx1pIZProO3P9YQbPFgsLZ56RW2W3CqU0wvq
	NporM/E2YSUMjpGaf40bISA24g0iUEkCA61EMJBOJ/X7IuR8Ec=
X-Google-Smtp-Source: AGHT+IGBb76+41F2pHvydMm/JGXdMlN/mBnhrFNW+ic56J+9RYUnTBwRHsVejTU0pmtbS8GUNrvPI/xlIhdPGk+iHk0=
X-Received: by 2002:a17:903:ac7:b0:240:e9d:6c54 with SMTP id
 d9443c01a7336-244586d44bcmr733595ad.48.1755109182900; Wed, 13 Aug 2025
 11:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
In-Reply-To: <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 11:19:31 -0700
X-Gm-Features: Ac12FXzLogDC6UGMQNMWDnDL9De9KnuUUW31y0FBm57RPEyjApbQulTgV6dTnyM
Message-ID: <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:11=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as "sock" in memory.stat.
> >
> > Even when a memcg controls memory usage, sockets of such protocols are
> > still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes that
> > belong to the root cgroup or opt out of memcg can consume memory up to
> > the global limit, becoming a noisy neighbour.
>
> Processes running in root memcg (I am not sure what does 'opt out of
> memcg means')

Sorry, I should've clarified memory.max=3D=3Dmax (and same
up to all ancestors as you pointed out below) as opt-out,
where memcg works but has no effect.


> means admin has intentionally allowed scenarios where

Not really intentionally, but rather reluctantly because the admin
cannot guarantee memory.max solely without tcp_mem=3DUINT_MAX.
We should not disregard the cause that the two mem accounting are
coupled now.


> noisy neighbour situation can happen, so I am not really following your
> argument here.

So basically here I meant with tcp_mem=3DUINT_MAX any process
can be noisy neighbour unnecessarily.


>
> >
> > Let's decouple memcg from the global per-protocol memory accounting if
> > it has a finite memory.max (!=3D "max").
>
> Why decouple only for some? (Also if you really want to check memcg
> limits, you need to check limits for all ancestors and not just the
> given memcg).

Oh, I assumed memory.max will be inherited to descendants.


>
> Why not start with just two global options (maybe start with boot
> parameter)?
>
> Option 1: Existing behavior where memcg and global TCP accounting are
> coupled.
>
> Option 2: Completely decouple memcg and global TCP accounting i.e. use
> mem_cgroup_sockets_enabled to either do global TCP accounting or memcg
> accounting.
>
> Keep the option 1 default.
>
> I assume you want third option where a mix of these options can happen
> i.e. some sockets are only accounted to a memcg and some are accounted
> to both memcg and global TCP.

Yes because usually not all memcg have memory.max configured
and we do not want to allow unlimited TCP memory for them.

Option 2 works for processes in the root cgroup but doesn't for
processes in non-root cgroup with memory.max =3D=3D max.

A good example is system processes managed by systemd where
we do not want to specify memory.max but want a global seatbelt.

Note this is how it works _now_, and we want to _preserve_ the case.
Does this make sense  ? > why decouple only for some


> I would recommend to make that a followup
> patch series. Keep this series simple and non-controversial.

I can separate the series, but I'd like to make sure the
Option 2 is a must for you or Meta configured memory.max
for all cgroups ?  I didn't think it's likely but if there's a real
use case, I'm happy to add a boot param.

The only diff would be boot param addition and the condition
change in patch 11 so simplicity won't change.

