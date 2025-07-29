Return-Path: <netdev+bounces-210882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00AFB153B7
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C763A189D0E7
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0DF2512C3;
	Tue, 29 Jul 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1igSNIgu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869623F405
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818076; cv=none; b=Uo0Ieh/t9dHVHYo7ZmDzNPOz3tg6Uk9X9bXsqUAv6TAUdJHCQhKGuPvvoCeRPWKe/VyahJYlNMowqmOpAKhhRzDK+ZWcwr82SRK+tKfMCBdJ+gBCdMAOkh4tRRK/UC6VaUScXEn12pXoaqbLgdG6Ng8rZ9xYQnTCogFdiXLRCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818076; c=relaxed/simple;
	bh=8ILIxFhPqV6sWJ6sNqcz7HYLvW2rtv0z1EwnknIclp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNhexBhC/K84A1XqBkJMxjSGUlpZWnDnfwatwWjsRaDlgWSDpoZDLrY++14/zOtFghASC8GlCZyRkmXeP9oHbKA0wmSeur0L3LR2YHxzLset6GqWUHfb6L+bSFYAPzYPJRhNFXo/nPssPff9jyIrmSbwzI3WJIB0Kc2WepeEaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1igSNIgu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso1656481a91.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753818074; x=1754422874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m37FqMDYXmj2Dv7ygO9Vcvff4CeQGMY//ilXkgwqiPk=;
        b=1igSNIgutLUx2Bmv8hXMkUndgJ0gDj1nc99mV6c3XQkepGWNP8YiO4GTro7d4rhN09
         J4FaH6/NT2idJG6jgvC4lLRA8RO9hsTH3lu7nrUWwsfz6XSU+qQUtGkcuvx1pj+8CLhl
         Sw4ic45gCqlKNTU4HH6b1jhGlZdVX/uOOGliOVbYGrNIrXs4CBsea2HhIj2s5VhBRzis
         9YBvHcpyuesBbksAq+o0hHFftC9hi6J4N5LCYIi9dFB7eL6KgMmwAW8mS2BJIhrk6+Bo
         ic2EYhI/w5pxT73iCjvprM0peu80X2+xzxN9YLTJ0m3VGJ5dHkefDhh1arG0w9No8Ead
         A+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753818074; x=1754422874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m37FqMDYXmj2Dv7ygO9Vcvff4CeQGMY//ilXkgwqiPk=;
        b=QD+XZ9DOSsy2Qz5iYFTT70XdWfi3sQgm9z3KLPRH3KRZlh/Wwn+omTvz9FOTkBxdTs
         rcu6HdY8VnH+TeMi4GDYn6W00xg1LtFS7lu1aTh10ubqbdyPO4dTxpkJ+C1yDgAbxWbQ
         xXxKgMTKkexVhqXOSsEJQ3HRbxADu3eYqNHhVWBngq2hSObChVdqLT/qFRmELRG8Msjf
         YOMl48khnJ/pMR1WrE+VqcevQE4YCnam7z2xUVpxSxCFsX2DcPzDLguhtVFRs4LlqwlF
         H6yw3esel5DgzMqjc/fQ/VRYRuRPcGj3pcGIxq4p9rVA0ILw4vvVk2djxSDUYagAsjay
         OY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUU00BLUyIv1asVVLKkTIDdS09hRf67tZnn6YJDDxMdQtih524cdBW87zXRAmrdYcI4eAWPmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpvJPIslW8w21jUzY/6kIZnZ2pVpS2jhVlkdq2oAxFHC09E3J
	7VlUeIgZpWHxAnUp9FUAGiGOv0UtFypacXWW6JCGmke8A7PyQ/GnscgIiJxTLfRg5zEdyh5JNT5
	4jlOG/cEyKxXCLj2rlRssGfKyGzIoAU/4CZJqeZ1D
X-Gm-Gg: ASbGncu5vpdsBR4TVlokccH6IWhd4eFru3K1aAdMKMOo55533KWD+7tDQLYTPskAZx3
	oKA72Z3kRvpb7s9HMjf+jezVlgYF0jIuPr585RNmTHK9jtfWWYqvhTDCQHXaJBWFvMdJOQCRJdN
	2ncD8v3ROXTDqQOD+YMGGaw0wr6t7eXphO8sX8mGv3Ny0iHblwgwG2ePTcRvP8U/7nHwqY/Tsb5
	0hN0nyVCCRm9CSvDDXQ/79e6pVgs87NRzQszg==
X-Google-Smtp-Source: AGHT+IFHi+K2rngfQJNaDXh6Q/65dPesMfdw/U4rG+5b3JOuqTwCXpXEA1k+tUMK8fVxHUmx8u+LcYENLMSlBCx6eI4=
X-Received: by 2002:a17:90b:3c8c:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-31f5de7ba65mr947421a91.33.1753818073104; Tue, 29 Jul 2025
 12:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <20250728160737.GE54289@cmpxchg.org> <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>
 <20250729142246.GF54289@cmpxchg.org>
In-Reply-To: <20250729142246.GF54289@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 29 Jul 2025 12:41:01 -0700
X-Gm-Features: Ac12FXzISgl-tZJ7iKnC87dk4hDowx1goc7Bk3yppQBdjG6RkAfnE8zuKgCifMo
Message-ID: <CAAVpQUDRccLyZyaz1iKABHNaw5rHfTBHtrOypmHheOJSaVORLQ@mail.gmail.com>
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

On Tue, Jul 29, 2025 at 7:22=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jul 28, 2025 at 02:41:38PM -0700, Kuniyuki Iwashima wrote:
> > On Mon, Jul 28, 2025 at 9:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
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
> > >
> > > Yes, an uncontrolled cgroup can consume all of a shared resource and
> > > thereby become a noisy neighbor. Why is network memory special?
> > >
> > > I assume you have some other mechanisms for curbing things like
> > > filesystem caches, anon memory, swap etc. of such otherwise
> > > uncontrolled groups, and this just happens to be your missing piece.
> >
> > I think that's the tcp_mem[] knob, limiting tcp mem globally for
> > the "uncontrolled" cgroup.  But we can't use it because the
> > "controlled" cgroup is also limited by this knob.
>
> No, I was really asking what you do about other types of memory
> consumed by such uncontrolled cgroups.
>
> You can't have uncontrolled groups and complain about their resource
> consumption.

Only 10% of physical memory is allowed to be used globally for TCP.
How is it supposed to work if we don't enforce limits on uncontrolled
cgroups ?

