Return-Path: <netdev+bounces-210669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10498B143F6
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1EF18863A7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC8275867;
	Mon, 28 Jul 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="078DiFob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966F22FE11
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738912; cv=none; b=TGyMBKXehjmifES/qjNPs9GZkR2c4AMQFj4ZxgdkQxETM1z2i/I+6YO31t1n1JfEH8WQFq1rzpu4RPksB/2hk4f+EMwWLsFMWw+2vpNc/F25BWE7PuPhNLHx03ED9YtZolv/mAU4ohvpz0V6MiYq3+vDvMe7n7KXyunw4Q4Gzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738912; c=relaxed/simple;
	bh=cKa9XYPyv9x8EKIl5TmQMosM4oot37RX8i54E7VzJyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEG0HfK6dxVevpAxIPHV+3XKdFhF0pUHXgJiIub08nG5TmXjkcsRZI9U0ug9nvawRk818lm84zGj2G27iFJ90TDRKD84OGSJlESh/an3yb6V6V4z34R+moOzLh61ioBo7cSLCYiBw9BclZoG27vrRNPm00lIZq4CVPqlLYr23KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=078DiFob; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34a71d9208so3606930a12.3
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753738910; x=1754343710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUAStNjqHbOFii/5P+u4/wZKuq2iUR2hGxINlcM8q3o=;
        b=078DiFobEvvQlKZ8yEu1x9iVeIhMlAOPb/CK/9B1o6nBNx3JYXYZmNEBTwu+jeVEdl
         9Ki7Z3+/TrKcC9xFqAYdHNBDCrDj/Mv1pXtl1p0K5w9sSEACcw6253N3XFYkIPoj8Pms
         /3SXhzVAX8ZAzro2o9tMHNg3fDOWGRerTCBdkOM7xfUqF3iNb74eOEVWTR6P4e3eNs3v
         IvW6CBVGA/k5hJGcOTSqOWtB0l/RGqxAHzoTylzacejja73/s9eKNvkgfMJpFla6RjDf
         zMC8DUL2bR7YzIw9wRbiyNO2fWh1RoFJWvC4kizJBBgdPL8KT2JasJhZnjYb518d90a+
         dXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738910; x=1754343710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUAStNjqHbOFii/5P+u4/wZKuq2iUR2hGxINlcM8q3o=;
        b=LygC4nz1iL3dlpAHQLanyE/Kki4NU+EM1S9LDXnyTUPScG28F7Eutp2MrfUaB5rg+s
         dy+CRQMWL0/PMrL3kEhzXoiKkW3Hz4WEHrU47WEH8XIDJ+c8c0ywY/8rOCfcIebVirdR
         g0XwAc42VGH+mHZyiz287jI3pgGreMO7h1zfbjULctd88P5HuNeVVKWQTTUTDZICPWmD
         2zQ73miMQqqLE8sIdMQLzRI1JQwFCcBkCskKob1xiv1RbgmqW/lCcZBC92+KWZNK37L1
         JwM7a4PPFBWYPWg3yjXdIOw3seSFg+kUfnAMh1I1JOHSHc84dWLv02Cg0ggdHvQ8yjb/
         WBjw==
X-Forwarded-Encrypted: i=1; AJvYcCVTxQJDjwljitEikbAFfYr1/2xcrrhKfohihrLktNWXz3prAIAQaIlFcoLlvla6DK0J4HEQeGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPntluVS7BoXonBGAFAcvsVrfl6CvW1U+fow2yuP5Ew8yel3u
	B/AHzhV3aS50tyjAgczRTgdd4ijfrJ0XGp+0GintSR+Wh8ullEU1rGjGQZwxED/mnusrUUHu5Vi
	zcpQjvLHyZ2qRNL1MP8RH5USeXZL0GQGQUn4tn+mB
X-Gm-Gg: ASbGncu85KDFZ9Fy/c4T2j0Jj939sVaSuBH3WaBFLClkmbXxfNmCv7C6l0dhEKq7NUg
	4yy1gtGnfrPwgvl4Z5XQbQwfBqpwKUAeq2PkyMTzDcX03KkLitTFd5N0agNxaRP6440meWDHAUy
	TSWbXY5uY0gooV5S4OIO57QNPcZlYJPzqHNfw+wiExiUlLt0ajJI2K26N0rg7xu8hZK0W48rZBv
	MA4omne5kN/dPaDwP+5cP/BuWMthq0QoYWvNDVP
X-Google-Smtp-Source: AGHT+IEOGwzp8WL8Q8zkHDQhkD+Y1vauphLStdSB+fJ+ZXlleLTi+x8oG5ddB2+iE4U4lYOfWltk1Hl2Bj7BLkm2VMk=
X-Received: by 2002:a17:90b:58cb:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-31e77867c38mr20558782a91.12.1753738909472; Mon, 28 Jul 2025
 14:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <20250728160737.GE54289@cmpxchg.org>
In-Reply-To: <20250728160737.GE54289@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 28 Jul 2025 14:41:38 -0700
X-Gm-Features: Ac12FXzCNlmLcbIv9fmqumLLgswVMcQm_-d98NXQVOA-rLpKXIlVokMyihIY7Fs
Message-ID: <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as sock in memory.stat.
> >
> > Even when memory usage is controlled by memcg, sockets using such proto=
cols
> > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and a single workload
> > that opts out of memcg can consume memory up to the global limit,
> > becoming a noisy neighbour.
>
> Yes, an uncontrolled cgroup can consume all of a shared resource and
> thereby become a noisy neighbor. Why is network memory special?
>
> I assume you have some other mechanisms for curbing things like
> filesystem caches, anon memory, swap etc. of such otherwise
> uncontrolled groups, and this just happens to be your missing piece.

I think that's the tcp_mem[] knob, limiting tcp mem globally for
the "uncontrolled" cgroup.  But we can't use it because the
"controlled" cgroup is also limited by this knob.

If we want to properly control the "controlled" cgroup by its feature
only, we must disable the global limit completely on the host,
meaning we lose the "missing piece".

Currently, there are only two poor choices

1) Use tcp_mem[] but memory allocation could fail even if the
   cgroup has available memory

2) Disable tcp_mem[] but uncontrolled cgroup lose seatbelt and
   can consume memory up to system limit

but what we really need is

3) Uncontrolled cgroup is limited by tcp_mem[],
   AND
   for controlled cgroup, memory allocation won't fail if
   it has available memory regardless of tcp_mem[]


>
> But at this point, you're operating so far out of the cgroup resource
> management model that I don't think it can be reasonably supported.

I think it's rather operated under the normal cgroup management
model, relying on the configured memory limit for each cgroup.

What's wrong here is we had to set tcp_mem[] to UINT_MAX and
get rid of the seatbelt for uncontrolled cgroup for the management
model.

But this is just because cgroup mem is also charged globally
to TCP, which should not be.


>
> I hate to say this, but can't you carry this out of tree until the
> transition is complete?
>
> I just don't think it makes any sense to have this as a permanent
> fixture in a general-purpose container management interface.

I understand that, and we should eventually fix "1) or 2)" to
just 3), but introducing this change without a knob will break
assumptions in userspace and trigger regression.

cgroup v2 is now widely enabled by major distro, and systemd
creates many processes under non-root cgroups but without
memory limits.

If we had no knob, such processes would suddenly lose the
tcp_mem[] seatbelt and could consume memory up to system
limit.

How about adding the knob's deprecation plan by pr_warn_once()
or something and letting users configure the max properly by
that ?

