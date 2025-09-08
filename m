Return-Path: <netdev+bounces-220701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D42B48374
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 06:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476D93BEE87
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 04:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03322172D;
	Mon,  8 Sep 2025 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N51seYOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DF1386C9
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307388; cv=none; b=YaFQoxvcHBPk6vf0BhLhKwGi5xltihRaNk6kDinb7Vm74il6YDA3iR4mn2j0k8OdxOzRz8JYfMx99GBWRiT+hlUCqxEbLTfXPAlTDV/WqtbA9bk3Bw2/Je5NowstCJbNytYIuu+8qW8yN+dtPWnPreb7V193nropYNCKHYCjwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307388; c=relaxed/simple;
	bh=nmJGrpsFfjUmBS9R7+BX0Dcuub2rPayVOJerbTUc82M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR8MUTITb/9p4jcySVgwFMlwJyS79BJzBBIpCipm8KAWzHAFinUAzWlPjiBExscofX5zyUS9YPuwz12P2br9+p+vZGt2IQPOi383T/trQ34DiWwySoO6aHnETO65KVhz3+hu1BOkSNbZ7oFaAngo+7FHcOKPF/L/z200lPcY3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N51seYOA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6aef1a7dso4146697e87.0
        for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 21:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757307384; x=1757912184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqAocCOY1yppSeB6hQiiLEHs4CzSJgmGLy5GgW8EMYI=;
        b=N51seYOAM6/UoqGa1xIn+g3q+lmPnnMJGRlOl8i0tXBAGGWDZ28Qw6Y4Pa+8jpcmxq
         KQ9ah8D04VLJTY2+TXoXu1kAak4vqibZLzHyVSrplyn0SeNnaI8y4gGnHjV2ErIQHxW/
         thuz0XlxwdPVvUCRCrFwla5ZOzeYqIU42Uo/LzvyGTQdnFIQLDILaXGCrc2phV8c8vJL
         v0zpGERV9PdfQ24rzIv3BNFfHObK6UuVHrD5XBcpri3e3hWEqelFlrix2HgItA6nTnlR
         dWoDWaGkCrHbXJ/poUNUGJNcwFh98oat+xxn9gxzpcAY5LXSojPQleqGzdGGqMjuIupE
         IYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757307384; x=1757912184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqAocCOY1yppSeB6hQiiLEHs4CzSJgmGLy5GgW8EMYI=;
        b=rBUzisHUvQKzMSwlCPidZP9x1bSaQPOmJl3HGtS8H7st+xeeoCyNjjoK8yI07XCmVn
         l2V8bRvHyibQl14MJSzht58TuDjWXEOnZQ+OWeICt5oyuhlkzZcH+wp8h9cuiVJa+2Ci
         xVehUZ7NxNSqijAX4V9qLtRvj6SOf//XIdJuq6N0Qdk7JfhjXu4wxVlyp1x6f8muCWA7
         kMSuUg0R97PUqIqt2J5WPiQpsNX+Js25xD3B8nB5RlVaER03AdHfa17bzUThfs4ZrddJ
         vO0fL3lmt9PPMubtUJOts5wCZibOT2BJrENLHVGP8uj6AuKjh76OAsZBg9oYLqzIWb6d
         E1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVUKM75Nwkny33rzir2l6RdvnwLpjZkDZaWjaeieujm/PDg5oPhkEL3VGojCyuV0153qlIfyU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUOJSAo+IU5DL6z95q8SMsP0CpFfgFg2K66uPeRB8NuOeX6qI9
	Bmh0wt6wAGhp0gUNR3oBaDoICK1kttNfw5ud3pATsyBWrpO7eo/t7i+crne7SgpB4BAxDrYLTXl
	mTIKznG4dJ97S3QaUbneDHBcHSYvnUz1+85poTPvk0A==
X-Gm-Gg: ASbGnctoXl9ZLg0R/WJAqN9NLsRJPRuZDD8OhAV/0OVPvTKbLESlwUdNG+nxTL5JGck
	uykHW3qz/EqF8R0NA4rO6RwxnaUCLUc7AGXqZ6I4Ef5/9v0NLE2SptJI9f7vyPrLgoAEYQDI4cJ
	9Fonut7MzZZydUzpE//krNBPecShjA9Rne0xZaPLxMWLc+Z7glxJHx4tkBBYgdF2JFe8J97Kfx2
	DGeCSjmnywDyBS8uu/j
X-Google-Smtp-Source: AGHT+IEt+cLcCjEJ73PaZoZMn1SEdp50vHQ9D6RvYjXuFsmgAHrUIvazlHgUgKr4khjLizzh1GnJEM2PpTC9XWuWSqo=
X-Received: by 2002:a05:6512:61b3:b0:55f:4c1d:47f3 with SMTP id
 2adb3069b0e04-56261219bc1mr1861809e87.28.1757307384347; Sun, 07 Sep 2025
 21:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905051814.291254-1-hoyeon.lee@suse.com> <3pevfugpcd2j44b2wkrjhspn2a2ta627nhnqxc6ty7dxy3nt3v@qhytbn7lmqum>
 <CAEf4BzbsLP-_GkWaW5t4vM61m=qXEBOeOEJKShmB8_T5Ab8puw@mail.gmail.com>
In-Reply-To: <CAEf4BzbsLP-_GkWaW5t4vM61m=qXEBOeOEJKShmB8_T5Ab8puw@mail.gmail.com>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Mon, 8 Sep 2025 13:56:07 +0900
X-Gm-Features: AS18NWD51T7-IUPAZ5Oxyky9cDiUDtt7hwVi4UUu9hMYZmzwHN1XXhmlpyGxSug
Message-ID: <CAK7-dKZc8JOyjwiAG0rj=F+gfe_M1rsH0AqaB6Nq5iGz==vmAg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 0/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 3:57=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 5, 2025 at 1:42=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
> >
> > Adding some context that I think was miss per off-list discussion with
> > Hoyeon.
> >
> > On Fri, Sep 05, 2025 at 02:18:11PM +0900, Hoyeon Lee wrote:
> > > This RFC adds a compile-time check to bpf_tail_call_static() to warn
> > > when a constant slot(index) is >=3D map->max_entries. This uses a sma=
ll
> > > BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.
> >
> > This is an attempt to see if it is possible to warn user of out-of-boun=
d
> > tail calls, with the assumption being that with bpf_tail_call_static()
> > users would not be intentionally calling with an index that is superior
> > to the number of entries.
> >
> > However, there concerns with the current implementation, so this is
> > being sent as RFC to gather feedback, and to see if it can be better
> > done. Currently the concerns are:
> > - use macro to override bpf_tail_call_static()
> > - only works for Clang and not GCC
> > - uncertain whether this fit into libbpf conventions
>
> - map definition's max_entries can be set from user space at runtime
> making this check actively wrong
>
>
> This diagnose_if attribute seems very useful, but I'm not sure we
> should do this for anything map-related because statically provided
> map attributes are all overridable from user space when loading BPF
> object.
>

Thanks for pointing this out.

I hadn=E2=80=99t thought about map->max_entries being changed from user
space. That does make a compile-time check misleading, so I don=E2=80=99t
plan to take this RFC further. I=E2=80=99ve left some of the build workarou=
nds
in the other thread in case they are useful.

Thanks to everyone for the time and thoughtful feedback, always
much appreciated.

> >
> > > Clang front-end keeps the map type with a '(*max_entries)[N]' field,
> > > so the expression
> > >
> > >     sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)
> > >
> > > is resolved to N entirely at compile time. This allows diagnose_if()
> > > to emit a warning when a constant slot index is out of range.
> > >
> > > Example:
> > >
> > >     struct { /* BPF_MAP_TYPE_PROG_ARRAY =3D 3 */
> > >         __uint(type, 3);             // int (*type)[3];
> > >         __uint(max_entries, 100);    // int (*max_entries)[100];
> > >         __type(key, __u32);          // typeof(__u32) *key;
> > >         __type(value, __u32);        // typeof(__u32) *value;
> > >     } progs SEC(".maps");
> > >
> > >     bpf_tail_call_static(ctx, &progs, 111);
> > >
> > > produces:
> > >
> > >     bound.bpf.c:26:9: warning: bpf_tail_call: slot >=3D max_entries [=
-Wuser-defined-warnings]
> > >        26 |         bpf_tail_call_static(ctx, &progs, 111);
> > >           |         ^
> > >     /usr/local/include/bpf/bpf_helpers.h:190:54: note: expanded from =
macro 'bpf_tail_call_static'
> > >       190 |          __bpf_tail_call_warn(__slot >=3D BPF_MAP_ENTRIES=
(map));                  \
> > >           |                                                          =
   ^
> > >     /usr/local/include/bpf/bpf_helpers.h:183:20: note: from 'diagnose=
_if' attribute on '__bpf_tail_call_warn':
> > >       183 |     __attribute__((diagnose_if(oob, "bpf_tail_call: slot =
>=3D max_entries", "warning")));
> > >           |                    ^           ~~~
> > >
> > > Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
> > > compile-time warning can help developers detect mistakes earlier. The
> > > check is currently limited to Clang (due to diagnose_if) and constant
> > > indices, but should catch common errors.
> > ...

