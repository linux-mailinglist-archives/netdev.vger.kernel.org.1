Return-Path: <netdev+bounces-245545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A83CD104F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E300B307E88F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39225A659;
	Fri, 19 Dec 2025 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLIgSqX5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580071D5CD4
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163344; cv=none; b=TGC43ohU9VCgu04G/1LD5xW7FzupcqfspG0xdytT7M1xYJqQHj5sKn3ksFkBwfWg7XS8gVQ4J7H9/f+X9HpZS6RQisUfJ2hOfta+j6Jn2ZjG4vppqxLfEdPjVN7OP6hEQHCGTM/cc1pKobLVvzIKOoMgmdhDkoUm3WWZUDqMnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163344; c=relaxed/simple;
	bh=naYYjEpDVnEnlanhdCcUjLXcakiSrSLQfYF2vGnDLDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zkchgv/dWWr2NJp458WYb9YRIXOjZ5d7RAQb7GHnjTDwGg8upv3BRn6d3lE8X4a8mXbjRxhuwvaIRMYyCczGsT3RNovowTjpuHfluBiGOr5R8o9gLoy8+qLRrjtrPF2IdhGmn03I1mkdmfoVWBsKln51Mf73XmQH+OVWTgevLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLIgSqX5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so1567656a91.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766163341; x=1766768141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/m9bl3+id8FFKP1tjyQYifsuv5DnEIJszKpIoUcLq4=;
        b=SLIgSqX5TWf16UeA1EG9IlAC8HMVYUQanOhWBpsan07VynDKyhIMnXcrtQxAh+A6fT
         ctRkf0wIbBOjqd87FKa2SK/iCc8bJRADYEb0AfWz3g/B06JzKgugX+Na5ILv+w3tQMQN
         xuC4+PgJpVWHgqlmxd6tC7d0rxLwDIZQM8s3sqgK8pJ28xpubX4KgFeXqzymL9LsSvc/
         xfOhVyZMVt+oipa7Gemm1CW//5v42/a3ZtCZhSBA53ySvUB1LM6qqlqX0CuL08IoY2bh
         2s6C/bdyi2m2LhMRxGX38YKAaxvbJvRS6yF1dYFa0Cya/vDb2gOyvt99BMaM9+++6f7N
         dhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163341; x=1766768141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/m9bl3+id8FFKP1tjyQYifsuv5DnEIJszKpIoUcLq4=;
        b=Bdri+zwUX4n7CTaSu1TjO/GWiuDSZ7EJ3h9o5xf84NYYkAmEdZNcasdPJ56bzaf6j4
         1j5+GKc56QY18g7+BvrTvpF4Qq+8Y5hLhkqy3tFvYyIzBite8Fr0irq8q0BT4Red1C8D
         vrtHIBS5+jzEQSOZ6pduuBnqnh3g9kjHreSfGuyuEIomXXc2+0Ydi5zhdt+dsghnLxfV
         rlCbtglsdpZdRtUkAJlo9m+YZNTv9cqfQgQFP9fIA3+UvSc1nmGpTFLE6pUxuhcGnxnH
         izkdUoedj4KOtYBiwP4ULATYpkIByKAJP3XkmGKgyBPT+s1T8uw19afqgoASOfylYJZB
         uuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkcY1EjYaN3HmYNbvUqc32Hu8iprGQZ2AOJxboocldaCVkebDWvnCs9fnbD88VIVmvN9nOvLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9sR0eqnXqpEtqQINYu2wj4MVOIvOvwCgvom+XW3v4jVpRcNf
	kCsPKnnecj3IKMxtMuMOODj26Wn8E+oXN7X8sh3vQfP5f7NDfm0mZlMuC4UZMi1WgA2/+NxXE7Y
	ecnsAdOHar2CVYHWTE4lI6C2e0naqepk=
X-Gm-Gg: AY/fxX6Z35b8bGs9WKX8dusxoUA+9AwOCkTNJQFpEHQr23fQ7dn2XTNzWw9T1JYUOcY
	/tkYFEUkQvrlkOnUfHXGIpeGzf2GRfyc4yvtgOTB7W5ebLFgxEk2LiGI9gikhtAqRQCXfcTbd3M
	wtwUMhLbioA2Tv/JzfrTYxYyrTm+JF5jIs45E+030aZ8Pr1EzFvBIJSnZbAKLY3lFdJiNk4FZlr
	Rzrh1Mno2VWmcoCbS8MTZm+8mjwItSENBFu1Lws+zEk8TvGFycsgJx4oFa4m06PcsnLGq8=
X-Google-Smtp-Source: AGHT+IG3638nESoTxZZIK+5Ngpy1Vch9F8+A0wRhuOjEh5XN1nXWsGW+9gpYbM5R2XljGarfQrz5E+PmCc07Nml/3+o=
X-Received: by 2002:a17:90b:1c12:b0:340:bc27:97b8 with SMTP id
 98e67ed59e1d1-34e92144716mr3071702a91.10.1766163340446; Fri, 19 Dec 2025
 08:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <CAEf4Bzb8oooWbxctuVhNPsziRBd1Fv9Y11-5TiEML8ckjrCt+g@mail.gmail.com> <1943128.tdWV9SEqCh@7940hx>
In-Reply-To: <1943128.tdWV9SEqCh@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 08:55:28 -0800
X-Gm-Features: AQt7F2qg8hG7rC9CAjNFTDh6U-baXB1VwgZ7_nPvNWPtFQqGtj759DxAW5AYHoY
Message-ID: <CAEf4BzYm3=zzmCRg3zr1F99sBkxEZ_pDgjtKMBurb9LGu6JJKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:18=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Wed, Dec 17, 2025 at 1:54=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Hi, all.
> > >
> > > In this version, I combined Alexei and Andrii's advice, which makes t=
he
> > > architecture specific code much simpler.
> > >
> > > Sometimes, we need to hook both the entry and exit of a function with
> > > TRACING. Therefore, we need define a FENTRY and a FEXIT for the targe=
t
> > > function, which is not convenient.
> > >
> > > Therefore, we add a tracing session support for TRACING. Generally
> > > speaking, it's similar to kprobe session, which can hook both the ent=
ry
> > > and exit of a function with a single BPF program. Session cookie is a=
lso
> > > supported with the kfunc bpf_fsession_cookie(). In order to limit the
> > > stack usage, we limit the maximum number of cookies to 4.
> > >
> > > The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are both
> > > inlined in the verifier.
> >
> > We have generic bpf_session_is_return() and bpf_session_cookie() (that
> > currently works for ksession), can't you just implement them for the
> > newly added program type instead of adding type-specific kfuncs?
>
> Hi, Andrii. I tried and found that it's a little hard to reuse them. The
> bpf_session_is_return() and bpf_session_cookie() are defined as kfunc, wh=
ich
> makes we can't implement different functions for different attach type, l=
ike
> what bpf helper does.

Are you sure? We certainly support kfunc implementation specialization
for sleepable vs non-sleepable BPF programs. Check specialize_kfunc()
in verifier.c

>
> The way we store "is_return" and "cookie" in fsession is different with
> ksession. For ksession, it store the "is_return" in struct bpf_session_ru=
n_ctx.
> Even if we move the "nr_regs" from stack to struct bpf_tramp_run_ctx,
> it's still hard to reuse the bpf_session_is_return() or bpf_session_cooki=
e(),
> as the way of storing the "is_return" and "cookie" in fsession and ksessi=
on
> is different, and it's a little difficult and complex to unify them.

I'm not saying we should unify the implementation, you have to
implement different version of logically the same kfunc, of course.

>
> What's more, we will lose the advantage of inline bpf_fsession_is_return
> and bpf_fsession_cookie in verifier.
>

I'd double check that either. BPF verifier and JIT do know program
type, so you can pick how to inline
bpf_session_is_return()/bpf_session_cookie() based on that.

> I'll check more to see if there is a more simple way to reuse them.
>
> Thanks!
> Menglong Dong
>
> >
> > >
> > > We allow the usage of bpf_get_func_ret() to get the return value in t=
he
> > > fentry of the tracing session, as it will always get "0", which is sa=
fe
> > > enough and is OK. Maybe we can prohibit the usage of bpf_get_func_ret=
()
> > > in the fentry in verifier, which can make the architecture specific c=
ode
> > > simpler.
> > >
> > > The fsession stuff is arch related, so the -EOPNOTSUPP will be return=
ed if
> > > it is not supported yet by the arch. In this series, we only support
> > > x86_64. And later, other arch will be implemented.
> > >
> > > Changes since v3:
> > > * instead of adding a new hlist to progs_hlist in trampoline, add the=
 bpf
> > >   program to both the fentry hlist and the fexit hlist.
> > > * introduce the 2nd patch to reuse the nr_args field in the stack to
> > >   store all the information we need(except the session cookies).
> > > * limit the maximum number of cookies to 4.
> > > * remove the logic to skip fexit if the fentry return non-zero.
> > >
> > > Changes since v2:
> > > * squeeze some patches:
> > >   - the 2 patches for the kfunc bpf_tracing_is_exit() and
> > >     bpf_fsession_cookie() are merged into the second patch.
> > >   - the testcases for fsession are also squeezed.
> > >
> > > * fix the CI error by move the testcase for bpf_get_func_ip to
> > >   fsession_test.c
> > >
> > > Changes since v1:
> > > * session cookie support.
> > >   In this version, session cookie is implemented, and the kfunc
> > >   bpf_fsession_cookie() is added.
> > >
> > > * restructure the layout of the stack.
> > >   In this version, the session stuff that stored in the stack is chan=
ged,
> > >   and we locate them after the return value to not break
> > >   bpf_get_func_ip().
> > >
> > > * testcase enhancement.
> > >   Some nits in the testcase that suggested by Jiri is fixed. Meanwhil=
e,
> > >   the testcase for get_func_ip and session cookie is added too.
> > >
> > > Menglong Dong (9):
> > >   bpf: add tracing session support
> > >   bpf: use last 8-bits for the nr_args in trampoline
> > >   bpf: add the kfunc bpf_fsession_is_return
> > >   bpf: add the kfunc bpf_fsession_cookie
> > >   bpf,x86: introduce emit_st_r0_imm64() for trampoline
> > >   bpf,x86: add tracing session supporting for x86_64
> > >   libbpf: add support for tracing session
> > >   selftests/bpf: add testcases for tracing session
> > >   selftests/bpf: test fsession mixed with fentry and fexit
> > >
> > >  arch/x86/net/bpf_jit_comp.c                   |  47 +++-
> > >  include/linux/bpf.h                           |  39 +++
> > >  include/uapi/linux/bpf.h                      |   1 +
> > >  kernel/bpf/btf.c                              |   2 +
> > >  kernel/bpf/syscall.c                          |  18 +-
> > >  kernel/bpf/trampoline.c                       |  50 +++-
> > >  kernel/bpf/verifier.c                         |  75 ++++--
> > >  kernel/trace/bpf_trace.c                      |  56 ++++-
> > >  net/bpf/test_run.c                            |   1 +
> > >  net/core/bpf_sk_storage.c                     |   1 +
> > >  tools/bpf/bpftool/common.c                    |   1 +
> > >  tools/include/uapi/linux/bpf.h                |   1 +
> > >  tools/lib/bpf/bpf.c                           |   2 +
> > >  tools/lib/bpf/libbpf.c                        |   3 +
> > >  .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++
> > >  .../bpf/prog_tests/tracing_failure.c          |   2 +-
> > >  .../selftests/bpf/progs/fsession_test.c       | 226 ++++++++++++++++=
++
> > >  17 files changed, 571 insertions(+), 44 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_t=
est.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> > >
> > > --
> > > 2.52.0
> > >
> >
>
>
>
>

