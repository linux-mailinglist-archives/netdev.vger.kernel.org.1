Return-Path: <netdev+bounces-217074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9D5B37467
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD163B9744
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E52F99AD;
	Tue, 26 Aug 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAMkZsph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385C2DF6EA
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243493; cv=none; b=blqo0fGYZuLksP/winvhNGDBn52owIeV4RipbqG+9nSBmOzgKDvN8fNgYxj1KdEHu8kbBbEPv56J7dSTIOf57pBMbG7+g+GAXfTa6Fr+L1qwuf4T+Yo4wGX6CQ7DaWFruvKVoDzafbkScPjDdkPD/aNaGJ8yN4XUp965pG485pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243493; c=relaxed/simple;
	bh=VIiyrSqLG+vgF73thMJ1FZqyyfPAKoDCgtbBzE29VtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/rNO9/yQV1qNlXJy+2H4LcD7yiDAxSFSrEiIz2DWR4Lrmsz5OcCtWBW+vnj6inA3t4wYbrStgQAe1oWeTuWHecytA6oZd2uQIT4/gQhPIk5QDJuAqE8wn9kT33j2tzDOlGOK8RLjVqf4wQkQ9N/XrwL+ZGC3fijod+VeVJBxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAMkZsph; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2469e32f7c1so22719745ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756243491; x=1756848291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B1276hphs7ULbe2JVDIArBKHCuzM07N66UKV8tf9VA=;
        b=cAMkZsphPBTJVAXWNFOed6eLXkliXPB+GrOvoRO6NsCsGM6bGGNv4H4aZDtoVC1gKJ
         +0zFejcTE1nuRdqV+8CtLKBsVdnrfNK9uT08bbK7V52OH/I6ZlwnKAqVpPAVS2w8FOYP
         xbdyzG/KtBYGrPDmwACVrrk7xT9c5O8dBN3LgP+KjO/0ZGv6J9AMvObmSxH7Z5jnK5Br
         ZGdFklt79nCOB3EPMOIbXnKOUMa/eTEt0/NY+WZDr3jTuECzNrEkwVaj2J5W8x+SXThe
         8ljXREKm2V0c1m1latDLSLMZjjE1Ixyzqlt4J8A/I+W6LvTA67+pwZTrKhDYhk8lgjuw
         e1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243491; x=1756848291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B1276hphs7ULbe2JVDIArBKHCuzM07N66UKV8tf9VA=;
        b=li5avJnz5BcZ1MUBoSQaRm2Z5vTjEVEmVHkyYBtiVqg24XKzIH263KozwU8pOohPKD
         1x+JdLPboLktyHV0+3vB8RbEvwvdV+uRdtjOWeWlOar9MvMRZki2iph+O4Q0Y5SxoYi9
         AnQqxatRIFL8imV9I6C8VkXR/iQFUz4WKwQTaX2oPeLTV3oO7i6HfCPlOcoNEio+OLMY
         aj+Npf5Uzpd+hhKHqnbWZ06CdwlTKRmJEA6N80hdi/nRSKf6K9hRCYIZUq0lofbngeQM
         jhg4bnmHGawzin4NikpoBVNT4jbvB2ZYpnsV0WfF11Rk6SclfJP3P4BTD4bnJydOEtia
         HIMw==
X-Forwarded-Encrypted: i=1; AJvYcCXNw8crvPz0p1jyQiwQT1qc03rP7J/cwHlhrh4bkzV0xfA4hy90OkXjSmEUWd3TAnbzSYf9aJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKS3G1fd7Yh1IRQyi9ijKOSBXzrcK4Gsid/OLSSr/1P88WcXs
	i1QkcYULsJEaXQsYtaSjuWkQ9G6FM39Ic/egTq+91++2Mc7Elz2qy2YGtLpPmV4lR1Qge6J3mHH
	C+NPev2AClln22CNYylYtEiY7/QjOhmA8Xg+sgl3p
X-Gm-Gg: ASbGncsc8/+HgIeS0pyKI0++GvL8RZLEFb9buy/76a2L2g4Kjh+NUYTRBldS3AKFX9o
	aiaVOU0WrHvOPvOWUC4FGaS5shZjIDcAa60utc1FIzV6cjW0CjWMW8kZBsCi7Db2v07l5YFXAPZ
	uv2rtspW9Df/R80NAYqJQFyE5SLr/kawSX/JgzLFGOUb0ksyuOa4KXsEI2zg7bxRQmKP2KoQCXC
	x3U7pJcICB8qcq75dzsIL3u1zUmvYFACMO8b0aXY3t14mqdQDEqrVDSnUjYaZIBtqlT/ng0X6c=
X-Google-Smtp-Source: AGHT+IHLq1gemrW5FOQ8J+SVgDRvPZuS0+b2YwjoTLEqHXZr1nwf9zJN1MoCpZ8aamhKtFNsfhiLrSrW21/GXm2U0hI=
X-Received: by 2002:a17:902:f707:b0:246:115a:e5e6 with SMTP id
 d9443c01a7336-2462ef4962cmr239367055ad.42.1756243491292; Tue, 26 Aug 2025
 14:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-3-kuniyu@google.com>
 <aK4g640zGakSxlD9@mini-arch>
In-Reply-To: <aK4g640zGakSxlD9@mini-arch>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 14:24:40 -0700
X-Gm-Features: Ac12FXxWrzjfG9SW-BvA8V57F_LVNX5ynmGN74H44sYRyRW6GLwLkog3Eu0eOUc
Message-ID: <CAAVpQUARxRTbmFiNE5GuO03qQAikddhT=BLcTWJVHvwK_Yq=Pg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:02=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 08/26, Kuniyuki Iwashima wrote:
> > We will store a flag in sk->sk_memcg by bpf_setsockopt() during
> > socket() or before sk->sk_memcg is set in accept().
> >
> > BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
> > that passes a pointer to struct sock to the bpf prog as void *ctx.
> >
> > But there are no bpf_func_proto for bpf_setsockopt() that receives
> > the ctx as a pointer to struct sock.
> >
> > Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREAT=
E.
>
> [..]
>
> > Note that inet_create() is not under lock_sock().
>
> Does anything prevent us from grabbing the lock before running
> SOCK_CREATE progs? This is not the fast path, so should be ok?
> Will make it easier to reason about socket options (where all paths
> are locked). We do similar things for sock_addr progs in
> BPF_CGROUP_RUN_SA_PROG_LOCK.

We can do that, but the reasoning here is exactly same with
how we allow unlocked setsockopt() for LSM hooks.  Also, SA_
prog actually needs lock_sock() to prevent sk->{addr fields} from
being changed concurrently.

---8<---
/* List of LSM hooks that trigger while the socket is _not_ locked,
 * but it's ok to call bpf_{g,s}etsockopt because the socket is still
 * in the early init phase.
 */
BTF_SET_START(bpf_lsm_unlocked_sockopt_hooks)
#ifdef CONFIG_SECURITY_NETWORK
BTF_ID(func, bpf_lsm_socket_post_create)
BTF_ID(func, bpf_lsm_socket_socketpair)
#endif
BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
---8<---

