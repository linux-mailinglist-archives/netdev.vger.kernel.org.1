Return-Path: <netdev+bounces-281678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGD2Aqdc8GlJSQEAu9opvQ
	(envelope-from <netdev+bounces-281678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:07:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8747E78B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13466300B440
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C511391E64;
	Tue, 28 Apr 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snQhJN9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC960279DC2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359961; cv=none; b=aroWX+pTFY5Ijjt84bXQ6QckV8jU1mRBEEb6Tw+913WUlTXAgizpAhYK2pAtpJGmwq3d4DMPOsp0LmyeZ3C4yqGpDwmbWyj/XH+d1tMJWhA8QCMxQ8niWc6VRVwKGzrRD5D8yaLscH74PJwVL0UJLn/PjCEb5N+b5/14NuAj9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359961; c=relaxed/simple;
	bh=tACCu/RrLVvZC//dKCwwbhTR6SIl2MeUDsZQJWY4aCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neaFwtF5nY/LlvgrOF6b1alwDpPXIbENC+mEyal8H+gDjRXkNZ3JCgRclGxXHwUsjjSWbLrcmOkDuQcbyrnDGW9IPYMiJ1ooaXvoMNBzGBZyU8PnychusUFTXF+N4o7DqGqDlwz0KbP+1Up7p3upC4tYjZni4AaDxNiSnpUBDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snQhJN9q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso116660955e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777359958; x=1777964758; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghYH9B96BjOnUVsotLaVY0NUZVw8cYbfQ/KArJKrvpM=;
        b=snQhJN9qa2uOoOMMuUpxTqcCPpxy4Tvyz6axATUz9N9pNf24FmSRk6Kftd4/zArydW
         RTxlm0JY4cqZEKgnPznzGvys9UfKChngS0vA5OhVq1c/J+6VCcmdoKKm7WHyIMnkOXCn
         0Fe7T2nEoILCkNC+mDeCfrFS6JFzgUeiiXsog7hc2q6sunT7DPmOELShjezpuAHlo6ix
         s9m6mdjZgSqSQJOVXWJ3kQhkMPiYjX+GcP8qdx0Fi1usWKxWWB1DKNJ6sCkryUeaITyv
         ZnmhBMTchyy3at54VbAkGB2tpugQRAziq6QI3FD+8s+r9SlqjD7NnnPAMzlpSRLTWH1p
         zjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359958; x=1777964758;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghYH9B96BjOnUVsotLaVY0NUZVw8cYbfQ/KArJKrvpM=;
        b=hOgUwvqqoKzWjr45ZzjYmhlJjIAqe0zFO7KtYHDFGzRA1YDqr4cX3muWtfJMJu2qgL
         /V0ZlC+Euea+7/4EV4EPhpNTO3YpKLyIIaYqDnSjtmXlzgj8VrqfvQarTgMATCxPChhN
         05xujaqL0yDcbkMwpdiC+CUMASrfBadA4UpVE2z5R2HZM+k+YEdD5NqP/l5ITZzaLw8p
         Dli7SBX8yemAijsCztbwr3+FJon0r7dXcUln/HSq6Rk/ELveVK9FSxMi+zKUbSiEY1jU
         SOEezdxdcFv05J2LhfeIkEzc2xRFTOdKAyMBXhtRkXqLXi14iSQMwGMz3TRAr1Gebt0x
         097Q==
X-Forwarded-Encrypted: i=1; AFNElJ8dBNxYU26EkWoFRoY7Xex6TEgGlLMCtEub5U+knJjS039DOgTSpcidjr5ax8sKhX4kzyzyPT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8yVLXsIJk1tWhzpFQl0SpjIxzJc1ap72Lmx8SPmcOsjgOtIZ
	Elqg76faN64wj6amrExni8FmgMX2ikdE0skQujn1h+KygDG0WF1T5kYJ
X-Gm-Gg: AeBDietya0KTts0/O2zkWZk6qW8BlqTx+wRvacKB1ILctSkTCC9amkN33PffOuZuSSa
	K4St3IS/FfGt/CiyM3RqePHnq4d3XO5VW0WtRJSEs3JYb+orVTKT8HQSHjxrbNmu42HNRU4tnMA
	DYc3tn5HRadCUgp9yZ43aZ0DbguPiVYokEGbdPAg+D5l6hLOOykzH/5beRdpmA/YzxkXvDejmmn
	7CG89KVQpscmTsQ5r4l10Lt8mwAWErU7BDm0I99lhtfzyLAQ/h+yiE+2/AYZd0eZ7Z6KC1ME51q
	4qb9yt85ZEnZFWUReyY1D5FRn8VDrHslcuGyIF1fKfeEMeZf/GdaqgDgRa0Q6GmC5X1vjPBlpWU
	QN62jKH3n+1IMlOTP4MPHr1rsW5UEF4bIPu7nbTA1pskV1pc/FJrPiFdmYnqi9Zl9yNHs98e+aD
	+6p87mM908mWabweX478IXgSD7Gj/1vmLncLMyFIu1eReBFn2pf2aNNwA9q0ruqodjFux68wku2
	aXj/ltxEg+6z9mfCA==
X-Received: by 2002:a05:600c:8b8b:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48a77aed44bmr29091265e9.8.1777359958027;
        Tue, 28 Apr 2026 00:05:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:b8d:4d94:5e6c:7b79? ([2620:10d:c092:500::5:add7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775ebb83sm12333835e9.23.2026.04.28.00.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:05:56 -0700 (PDT)
Message-ID: <4386cf7de9b7fa5a03191bf97d7f5fda1f39de34.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 28 Apr 2026 00:05:55 -0700
In-Reply-To: <CAMB2axPaDEG_oKLxhcRmivv+YK_ExxNVY_KpSf1vvgLiPq1tvg@mail.gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
	 <20260421221016.2967924-5-ameryhung@gmail.com>
	 <02dbf08511c72ea0c1a5caa33ed400f4a3e3c3c9.camel@gmail.com>
	 <CAMB2axPaDEG_oKLxhcRmivv+YK_ExxNVY_KpSf1vvgLiPq1tvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4FA8747E78B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-281678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 2026-04-27 at 13:21 -0700, Amery Hung wrote:
> On Fri, Apr 24, 2026 at 3:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> >=20
> > Tbh, I find current state of affairs with id/ref_obj_id/parent_id hard
> > to follow. The release_reference() is an improvement, but the means by
> > which the fields are propagated to bpf_reg_state objects are convoluted=
.
> > I wonder if having a separate "object table" in bpf_verifier_state and
> > having bpf_reg_state->id refer to objects within this table would make
> > things more straight forward.
>=20
> I think this is a good idea in the long term. First, we need to make
> id a stable and unique object identifier (i.e., always assign id to
> objects; different objects have different ids). Then, we can create
> the object table indexed by id and each entry contains the ref_obj_id
> and parent_id moved from bpf_reg_state. Then, there will be helpers
> managing the lifetime, relationship (e.g., bpf_obj_create,
> bpf_obj_release, bpf_obj_clone) with clear semantics to centralize how
> id,parent_id,ref_obj_id are manipulated.
>=20
> If this makes sense, I can send this as a follow up patchset.

I'd play with it a bit, might make sense if we move a lot of objects
into this table. E.g. forgo find_good_pkt_pointers() and keep packet
info as one of the objects, etc.  On the other hand, dynptr and iters
are inherently stack allocated objects, so it might be the case that
the final implementation would be an over-complication.

[...]

> > >  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg,
> > > -                                enum bpf_arg_type arg_type, int insn=
_idx, int clone_ref_obj_id)
> > > +                                enum bpf_arg_type arg_type, int insn=
_idx, int parent_id,
> > > +                                struct bpf_dynptr_desc *dynptr)
> >=20
> > Having both parent_id and dynptr->parent_id as parameters of this
> > function is very confusing, but I don't have a suggestion on how to
> > better deal with it.
>=20
> Does tweaking the argument name and reorder the if-else block make it
> more obvious how these two arguments are used?

Idk, let's go with your original code, maybe?  The eventual goal is to
have a unified handling for both helpers and kfuncs, right?
Meaning that these would be packed into some common arg_info_meta,
with some comments on the structure fields should look ok.

[...]

> > > +/* Release id and objects referencing the id iteratively in a DFS ma=
nner */
> > > +static int release_reference(struct bpf_verifier_env *env, int id)
> > > +{
> > > +     u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> > >       struct bpf_verifier_state *vstate =3D env->cur_state;
> > > +     struct bpf_idmap *idstack =3D &env->idmap_scratch;
> > > +     struct bpf_stack_state *stack;
> > >       struct bpf_func_state *state;
> > >       struct bpf_reg_state *reg;
> > > -     int err;
> > > +     int root_id =3D id, err;
> > >=20
> > > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > > -     if (err)
> > > -             return err;
> > > +     idstack->cnt =3D 0;
> > > +     idstack_push(idstack, id);
> > >=20
> > > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > > -                     mark_reg_invalid(env, reg);
> > > -     }));
> > > +     if (find_reference_state(vstate, id))
> > > +             WARN_ON_ONCE(release_reference_nomark(vstate, id));
> > > +
> > > +     while ((id =3D idstack_pop(idstack))) {
> > > +             bpf_for_each_reg_in_vstate_mask(vstate, state, reg, sta=
ck, mask, ({
> > > +                     if (reg->id !=3D id && reg->parent_id !=3D id &=
& reg->ref_obj_id !=3D id)
> > > +                             continue;
> > > +
> > > +                     if (reg->ref_obj_id && id !=3D root_id) {
> > > +                             struct bpf_reference_state *ref_state;
> > > +
> > > +                             ref_state =3D find_reference_state(env-=
>cur_state, reg->ref_obj_id);
> > > +                             verbose(env, "Unreleased reference id=
=3D%d alloc_insn=3D%d when releasing id=3D%d\n",
> > > +                                     ref_state->id, ref_state->insn_=
idx, root_id);
> > > +                             return -EINVAL;
> > > +                     }
> > > +
> > > +                     if (reg->id !=3D id) {
> > > +                             err =3D idstack_push(idstack, reg->id);
> > > +                             if (err)
> > > +                                     return err;
> > > +                     }
> > > +
> > > +                     if (!stack || stack->slot_type[BPF_REG_SIZE - 1=
] =3D=3D STACK_SPILL)
> > > +                             mark_reg_invalid(env, reg);
> > > +                     else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=
=3D STACK_DYNPTR)
> > > +                             invalidate_dynptr(env, state, stack);
> >=20
> > invalidate_dynptr() rewrites to stack slots, can it be the case that
> > this body of bpf_for_each_reg_in_vstate_mask() is computed for first
> > and second dynptr stack slots, hence triggering invalidate_dynptr() to
> > rewrite three slots instead of two?
>=20
> invalidate_dynptr() will mark the two stack slots as STACK_INVALID so
> I didn't bother to check whether it is the first slot or not. Am I
> missing anything?

Oh, right, the =3D=3D STACK_DYNPTR won't fire for the second slot.
Sorry for the noise.

[...]

