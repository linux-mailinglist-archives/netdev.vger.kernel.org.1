Return-Path: <netdev+bounces-247273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D1DCF65F4
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5813040206
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E2218AAB;
	Tue,  6 Jan 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QsAQJZU/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF722192F9
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664376; cv=none; b=lNYdTjDkAXElAn0zhp/Q9qSxJ1PUlEdQ2baJUbpNVV2b1iUidryeQEiEvP3RTFCEt0vpU+k1LFeJxZFjYXXpqDltDEyAjmZaG0LfqS7NaEI1kj8+0JwWirpg9OYpk9UvXxGoJmD56wZnbCaOaS1zCLNoHUwpnY0sXLLzFDC5EQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664376; c=relaxed/simple;
	bh=MxNi18oFfGWIR3WK/bPI0Wpox/Z9QZRv3iY5fr9FkKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+7NLdsmJgTbeOhnG1awQ8gZOiM5zMF7FGAZobu3XHXUp1HkvDlKnFJkq4Ri+g64cRS3TygBrKc/CsDeh8hrsp623ompfJeoZT5pe37evV4Ra2hAZzOHhg9jCxm+HOaDdC0ND+jMzZputR3nG/hk5aS7aSyyGWI9Z0suqGJMoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QsAQJZU/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767664371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeGhi5aTkDk5xxEn6CfPFyG4+bpqRGst8/Zg5BXu19s=;
	b=QsAQJZU/+vjVsDS24NoxT3brvhAib3O/pRYvjf74hbj8mavUhScgrj7pYq2dHR9r39X/RU
	pfP8DVksAE/e26aAr3e9pcRnYXyt8uPxaAu2j9gZPYyCz1E4UGGaBDVpiwPgSY9FzGg3hs
	0e6LIeYnrNhCjX/1tAsVTI/ISpv93I0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Tue, 06 Jan 2026 09:52:36 +0800
Message-ID: <6226983.lOV4Wx5bFT@7940hx>
In-Reply-To:
 <CAADnVQLrV+0RB8REtcN9x+ub_S-DCrRqTj4s+QtX_ROrA=OwBw@mail.gmail.com>
References:
 <20260104131635.27621-1-dongml2@chinatelecom.cn>
 <20260104131635.27621-2-dongml2@chinatelecom.cn>
 <CAADnVQLrV+0RB8REtcN9x+ub_S-DCrRqTj4s+QtX_ROrA=OwBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/6 02:04 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Sun, Jan 4, 2026 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance. The instruction we use here is:
> >
> >   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
> > - remove the usage of const_current_task
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index e3b1c4b1d550..f5ff7c77aad7 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u3=
2 dst_reg, int off, int imm)
> >         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
> >  }
> >
> > +static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
> > +{
> > +       u8 *prog =3D *pprog;
> > +
> > +       /* mov rax, gs:[ptr] */
> > +       EMIT2(0x65, 0x48);
> > +       EMIT2(0x8B, 0x04);
> > +       EMIT1(0x25);
> > +       EMIT((u32)ptr, 4);
> > +
> > +       *pprog =3D prog;
> > +}
>=20
> Why asm?
> Let's use BPF_MOV64_PERCPU_REG() similar to the way
> BPF_FUNC_get_smp_processor_id inlining is handled.

Ah, this is a good point. I didn't know the existing of
BPF_MOV64_PERCPU_REG :/

So we can inline it directly in the verifier instead of the
arch.

I'll use it in the next version.

Thanks!
Menglong Dong

>=20
> pw-bot: cr
>=20





