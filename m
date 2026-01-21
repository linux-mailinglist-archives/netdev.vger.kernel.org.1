Return-Path: <netdev+bounces-251697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIFCMYEzcGkSXAAAu9opvQ
	(envelope-from <netdev+bounces-251697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:01:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 795674F727
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 105F6A22AC3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6928725B;
	Wed, 21 Jan 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="klmVfD7h"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC530F958
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960732; cv=none; b=SNkIRoRInKbT5uu40oFJCvJCSBgUS3OHLEkYU3iNdDXYN7KM1Sv4GGPfwTSfYDVsCGrdYGKLrmGMNw7+CfPoZSTpnWS3hN1LRSaBl5DiLSZh1oHRsHcufjYzX3Hmohi3EyBOV8r/4gT0GQ/P2y1SnNgal5MPsi+mtW/G/mYfnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960732; c=relaxed/simple;
	bh=gabIErv/E1Rb7QtBy94Tqbe+/t907giAN6VxJO94nKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GE1XtsexEAF3zYEoZ5boDBi2tVEHvuYSi6PTjeTnDWe7V6gSdN6MpC0eGhUcdgeCe+t++BjRnUtaq+Px7HQB2VUcSbpH4i2vzLM7K2uzF9N+ZAJiU/jAcEC15tWRsm6p/BJMuQVMZ3iOvjS3NGQiUo/gRZFy0GgrwppvEZ9fhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=klmVfD7h; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768960709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt6JVh/bNlIu9YiX08XBN5Tby/ie4vqkYxZCDOk9QD8=;
	b=klmVfD7hfdxSK+7a3sfq5EYjS7vt5rZOhK+AlrfzBA8WM/PaA0z9d4QDwFqA+dCG72/3Dw
	cpt9hY9q7OMZMVLjnkOI/sJaWBGoW+PfN18aGC4L3e/YOD1Y7mmVshemlrFZ++ZZ9Iiise
	P+Z4sQlbPJrpTmDlwVBSyjK7wiU0zf8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net,
 dsahern@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 1/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Wed, 21 Jan 2026 09:58:10 +0800
Message-ID: <10788751.nUPlyArG6x@7940hx>
In-Reply-To:
 <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
References:
 <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn>
 <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251697-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,linux.dev:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 795674F727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/1/21 09:23 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> > v5:
> > - don't support the !CONFIG_SMP case
> >
> > v4:
> > - handle the !CONFIG_SMP case
> >
> > v3:
> > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
> >   x86_64 JIT.
> > ---
> >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struc=
t bpf_verifier_env *env, s32 imm)
> >         switch (imm) {
> >  #ifdef CONFIG_X86_64
> >         case BPF_FUNC_get_smp_processor_id:
> > +#ifdef CONFIG_SMP
> > +       case BPF_FUNC_get_current_task_btf:
> > +       case BPF_FUNC_get_current_task:
> > +#endif
>=20
> Does this have to be x86-64 specific inlining? With verifier inlining
> and per_cpu instruction support it should theoretically work across
> all architectures that do support per-cpu instruction, no?
>=20
> Eduard pointed out [0] to me for why we have that x86-64 specific
> check. But looking at do_misc_fixups(), we have that early
> bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
> performant inlining implementation, we will just do that.
>=20
> So it seems like we can just drop all that x86-64 specific logic and
> claim all three of these functions as inlinable, no?
>=20
> And even more. We can drop rather confusing
> verifier_inlines_helper_call() that duplicates the decision of which
> helpers can be inlined or not, and have:

The verifier_inlines_helper_call() is confusing, but I think we can't
remove the x86-64 checking. For example, some architecture
don't support BPF_FUNC_get_current_task both in
bpf_jit_inlines_helper_call() and verifier_inlines_helper_call(), which
means it can't be inline.

>=20
> if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
>     switch (insn->imm) {
>     case BPF_FUNC_get_smp_processor_id:
>         ...
>         break;
>     case BPF_FUNC_get_current_task_btf:
>     case BPF_FUNC_get_current_task_btf:
>         ...
>         break;
>     default:
> }
>=20
> And the decision about inlining will live in one place.
>=20
> Or am I missing some complications?

As Alexei said, the implement of "current" is architecture specific,
and the per-cpu variable "current_task" only exist on x86_64.

>=20
> And with all that, should we mark get_current_task and
> get_current_task_btf as __bpf_fastcall?

I think it make sense, and the I saw bpf_get_smp_processor_id does
such operation:

const struct bpf_func_proto bpf_get_smp_processor_id_proto =3D {
	[...]
	.allow_fastcall	=3D true,
};

PS: I'm a little confused about the fast call. We inline many helper,
but it seems that bpf_get_smp_processor_id is the only one that
use the "allow_fastcall". Why? I'd better study harder.

Thanks!
Menglong Dong

>=20
>=20
>   [0] https://lore.kernel.org/all/20240722233844.1406874-4-eddyz87@gmail.=
com/
>=20
> >                 return env->prog->jit_requested && bpf_jit_supports_per=
cpu_insn();
> >  #endif
> >         default:
> > @@ -23319,6 +23323,24 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         insn      =3D new_prog->insnsi + i + delta;
> >                         goto next_insn;
> >                 }
> > +
> > +               /* Implement bpf_get_current_task() and bpf_get_current=
_task_btf() inline. */
> > +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn=
=2D>imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> > +                   verifier_inlines_helper_call(env, insn->imm)) {
> > +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(=
unsigned long)&current_task);
> > +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0,=
 BPF_REG_0);
> > +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_0, 0);
> > +                       cnt =3D 3;
> > +
> > +                       new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +
> > +                       delta    +=3D cnt - 1;
> > +                       env->prog =3D prog =3D new_prog;
> > +                       insn      =3D new_prog->insnsi + i + delta;
> > +                       goto next_insn;
> > +               }
> >  #endif
> >                 /* Implement bpf_get_func_arg inline. */
> >                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> > --
> > 2.52.0
> >
>=20





