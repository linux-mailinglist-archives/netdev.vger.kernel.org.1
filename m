Return-Path: <netdev+bounces-246604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA101CEEF51
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D3A3029D1B
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815C2BDC23;
	Fri,  2 Jan 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RC6OrM7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6F29E0E6
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370759; cv=pass; b=k+uz8pxrJWtLeGvlo+kxW1R9cqNJqC9YIbHzhp7pu2TF/xd7xEkfezL+n//CfOMNgEwXLNa9Q4nVr61zl4R90I5d2a4tbuVfGfFDDx/wJ7Ar2W5XAqXewZmOlLNr9i6B0Hlp1MSrELnjOf2LA9X0RuSMZdchRZF1/HFSa7va1UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370759; c=relaxed/simple;
	bh=3zUPHsmFXLRLRWZxrqxoS8IggoZhxzhMACoAYfeLcu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7PVn9x4mR3Rt8m4aL54KpuQM5DDhMm+ofc7NwsP5jDN3UsZMZsbXMMqpR205wbexGdxrp73OYX9lDgggq0sJK4mcszCgbmumkiQbb1TMJ7U5GsOnPUy58swfQK4tf03mcLUS2dM5cFTQsc1JeEwqHX2+xre5adofc8WexvxAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RC6OrM7O; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a2bff5f774so29533455ad.2
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 08:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767370756; cv=none;
        d=google.com; s=arc-20240605;
        b=czKqmXFd3SIT+jZpdq+Qsp1ML/5ZPkCxDizNX7LbvkLAzLGTEVruNXWalZLJJRm1DT
         LRHBeqTY5FQzN30kWXBD518u8oM8Sp1B4vXI56j4fYTD1qKfTqq0h9YXkWfvpkbLDauf
         n68m+zcTK4Tvd9lpRMW3UcgthD/3wf+9hIRh23VTy/bv6GMJdP6t0vfWn7XRkEeIXiFF
         InpcD7RXpG4dpsiFPu5+KOa3Ism4NO5FSa40Z8EYVmjrk5Y1w3uoNKS/fvmesPWDgPSb
         kt4BLcbTkwKWU7Jqm4rRFR7+SvVUQsQRHTsF2MPNVBs/hCDMXlQZFgQZ82ogu/I1zSKl
         7JSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        fh=7b3/MjkTTiqK277kV55ZFnRvqZHR1KyTzzCJbLto50Q=;
        b=KvUHT4fm+7gFpZJMBxSoJ3DCbNzEl8f3s8FYI91NbTDhe6hPuPKceZDjGInTfsVBbA
         /fujHTuIm615uZm63kg/KSc2qQ4zVSgYt22g9fJws80u/xAjygF2STENeHofQX+y8TcG
         mRUeyhBm2alUe0vlZn8kX8LLiqD7IrvSrhBUE+JGMb4wNHeDpVmNfZdOy0QDMbUAkn0n
         CVozKHykZFhlLLZnc+Uuq4JLivrNJ/n2La+o0dunfYHNwLvrQ4ceuk1sq4essYkJJofZ
         hmCnZL1siTYaX1IJ+oeqSnNqr6kAg5K3aGg6D/slRVn4RnzkBXca593XRiv7JFvvGTWu
         ewvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767370756; x=1767975556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        b=RC6OrM7O0cVMQCXffp7Y+tRu3KxyP//w1wjt29LedET926XUxE99AlK58/Y9l6s5RX
         tfZhN08MGiYvxmwh7ivaAwr/YzDhtnOSkAeNdL4CpRI1iSnUREFY/qCii2U5MhE3U6ru
         8SeY5SpByufn07hJLrwMSgQVqWkL4KElX6wcBt6NKYHHMK06eVR5NTpBfI3TrymzaqIZ
         TX/S3suwPgQqMM8HrEE4oXLab9RgnrKSh2ZavkJY54tlvvtaBTWBqdGLB1zgUMhkQpds
         fDs9neGR/7x+bttUhqouOuP+Jod6O3o+loQQ8FwuaPXetu6Xh6OJ+qnMLLq8RJXzSxy+
         9Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370756; x=1767975556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        b=e/QQfVsdDDQ3rZBflKDBdWWp6JWLKzhu3lg2JBL5H2y33qPlrOSoUX1VQBuO57x6KC
         0xD7ns9Q7PsTMaAcRzfF7KRWh6QYlaUt3HCQsepWxdq8g+ZdfZb5heVOpCpHP2GLhjPx
         xRAt3XON/f7MbbYnTmsR9G3RQq2SnES3qyylYPGVJO0M2jyViZS9XEtTOlIICacLWLeM
         A+sSHWSPgZrFcn2+7LexAPXOJL131pCdxV/zICdWMxp/AaZZIKudw2eqRhAZMP/eJJiQ
         QmTFbyuZR/T4N9t0GQt0kCdzSKTgs/XMlyrV5udJ/V4D6mHn5XXBnwKa2XnAWIaLs3RX
         mphA==
X-Forwarded-Encrypted: i=1; AJvYcCWtM6n2IfyUM8MYW+gKuazs2/KsqjHj2yt2lT8GNvaEsWeaLxhB7lwdYavdCSnOn5mofYVUkJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnC4cFFlP7J9WnfDCphDJgZRbzG0FoK2nHHrZKqSV2FMsrR4dX
	XiwUPpNCNubCbt6SWnpi0IL8uShpSE9LFPmq/zPrArTyfPYuCVHPD1D3AY/5JUl4SwN3IXOKF5P
	GKXRuxQ6moAXY6NcTuUklLd9Dj7gvKADdUHrlG3uwSA==
X-Gm-Gg: AY/fxX6rqEney9D7CjYmGxisruYFQWieZkCDNa4A+kElVgCQ5K4+iw6y5aBllYlnfCl
	Tr1AIba5zPkizNcnk07uD0jaKWU1dJPzJKGtB8rTwgQ8zJU2/ie2xKHyPrEulYZZaxWHsPk4wI+
	LHzX0rWLG2rJ5WDFo3EafGJ051dWYWwInVPICZJZSQ0dl3JeUYXB9lXG5PdM7AMdJQdZLZUKrex
	D0Yap5jwZfJ4CHZ/ff+rKylhyNWKv694bWxuc8E7alv4TR5pS3X1nvS6al5t8TU/6XlrWG1
X-Google-Smtp-Source: AGHT+IF/IKaol6q06drc0jUZGfDObMCMgUc7sJGF0Pzcwx7Y3zyiL6BNsG9paslEQz3RmfOfMLaSPRZ7OEsv3ldvgtU=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr21225084c88.2.1767370755580; Fri, 02 Jan 2026
 08:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
 <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
 <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com> <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
In-Reply-To: <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 2 Jan 2026 11:19:02 -0500
X-Gm-Features: AQt7F2oEXplVk5UGATVc_njCcDbZ0oTjVxxZL8Y_v3dZVS7iVDarJ5ogQAkD16Y
Message-ID: <CADUfDZppy2CQjZ9La=RcBL5XeKY66Eq7Rr1JD6byuip_GPrMEg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, Tony Lu <tonylu@linux.alibaba.com>, guwen@linux.alibaba.com, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 4:28=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
> > > <csander@purestorage.com> wrote:
> > > >
> > > > On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wr=
ote:
> > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod=
.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > > > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int=
 dummy, struct task_struct *task__ref,
> > > > > >       return NULL;
> > > > > >  }
> > > > > >
> > > > > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > >       .test_1 =3D bpf_testmod_test_1,
> > > > > >       .test_2 =3D bpf_testmod_test_2,
> > > > >
> > > > > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_i=
nit(),
> > > > > this struct is modified at runtime:
> > > > >
> > > > >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> > > > >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> > > > >         *tramp++ =3D bpf_testmod_tramp;
> > > > >
> > > > > Writing to a const-qualified object is undefined behavior and may=
 cause a
> > > > > protection fault when the compiler places this in read-only memor=
y. Would
> > > > > the module fail to load on systems where .rodata is actually read=
-only?
> > > >
> > > > Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> > > > init time, I'll leave __bpf_testmod_ops as mutable.
> > >
> > > No. You're missing the point. The whole patch set is no go.
> > > The pointer to cfi stub can be updated just as well.
> >
> > Do you mean the BPF core code would modify the struct pointed to by
> > cfi_stubs? Or some BPF struct_ops implementation (like this one in
> > bpf_testmod.c) would modify it? If you're talking about the BPF core
> > code, could you point out where this happens? I couldn't find it when
> > looking through the handful of uses of cfi_stubs (see patch 1/5). Or
> > are you talking about some hypothetical future code that would write
> > through the cfi_stubs pointer? If you're talking about a struct_ops
> > implementation, I certainly agree it could modify the struct pointed
> > to by cfi_stubs (before calling register_bpf_struct_ops()). But then
> > the struct_ops implementation doesn't have to declare the global
> > variable as const. A non-const pointer is allowed anywhere a const
> > pointer is expected.
>
> You're saying that void const * cfi_stubs; pointing to non-const
> __bpf_testmod_ops is somehow ok? No. This right into undefined behavior.
> Not going to allow that.

How is that undefined behavior? Wouldn't the following be UB by the
same reasoning?

void takes_const(const int *x);

void f(void)
{
        int not_const =3D 123;
        takes_const(&not_const);
}

A const-qualified pointer type just prevents that pointer from being
used to mutate the memory it points to. It doesn't guarantee that the
memory it points to is marked readonly.

