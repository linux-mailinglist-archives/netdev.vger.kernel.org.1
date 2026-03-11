Return-Path: <netdev+bounces-266785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDpuODHrsWmSHAAAu9opvQ
	(envelope-from <netdev+bounces-266785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:22:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECC26ADC8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35AA3047044
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D37D390982;
	Wed, 11 Mar 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II7Q1saU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD7375AC2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267755; cv=none; b=EgNjISrlJ0KkDL8H/JQwvSYJeebpCi5Ju2c6xlfSRck5o/Ml5jGPFdMzRM9PK9jeoBedMRoh8A2mCQg7bniM8Bpekac1kdg/OEQJCHzzfIHBez/WzqGbi03OyabrSi8Z5uI0Y3gwWFUdOj8xE2XXpLlMOkSfsnyBAG7NYXjCX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267755; c=relaxed/simple;
	bh=CA90DK9vt0CLZgmpFQOB969rTeLGHzNoz7cWC1yNZGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEDrTIBHHkEcGPstrNcsKb7D40Y5vd2tq8A9UpHk20uWCW0b99U55x7PcjNgIKQy0DiPwTyceJUpVoabu5K9FWLnSWsqoEobI9cZtuVX5yAMxgaRSNC1lbpQ0U8Xqaw3vKnqgO+B+GcMQY2p6vTNEsUD32P5LhZDw9yRq/mFCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II7Q1saU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-662bf05f7a4so415562a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773267751; x=1773872551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcRLQPxXxCXufHQUO8PZm7e9uqRix9ai8DPCFFhMsKs=;
        b=II7Q1saUKf2CmuOm9O2bLKfzXtdxHh/tLsEAM7DNOX1N9N1fur0dnlIzVemudZMzkP
         hsFQDjlt++DnzsE5+zGckyS21YgwyyzzOrdrqhCKDfqX4/8/IlB3GR9Uk1zACpf0OPkY
         hR4t5LeZBBpqSNmmRbQxShBSd3eXLkjKAAlSh9f8R2ed900JsfO3fjtr48YHXN2wiz/C
         Z4pXeJuoDZurBfu1g4J8y6m9EJxtcrma7x0ZbaedYOvmwgaJ4YR+kCTjYqmfjun3V6KI
         AIu0fK/G0VLpjah2bmRR46GJxFxtMyY4yJgERoZ8Dzf+7sJa697CU72l4A7yDMwhYHL/
         nivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773267751; x=1773872551;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QcRLQPxXxCXufHQUO8PZm7e9uqRix9ai8DPCFFhMsKs=;
        b=qxIPaTgAL6270iMv1k5I4dEdRqZ0ZPbNXrj4vjF6L3v0VrBh51AW3NKK0nDC7G87x1
         ztLidzoY21i78KLEEkssoSMfZIXZYbhIh6defOYdwt0hx2deE1ETRLEE+MvW4k5hc6Aj
         RHFQkHrHcd+QwAfQP05H4eoejgZ1gwTJFhQKOf6LQevaZVZg3jx5GzrzNO6xmaza4kBv
         670BcaY82iE9avCy8xMosvtoL++IBhNc671f5U1y2nXfWrzoxz83fSLiIoExnWtfsr31
         LlzUr+w6hg+57wgY3pcRlTRiq9WXc75FQQnaNYbkuhgfyC5g3zVW9nb1tcYYqjIVYkNs
         AnBg==
X-Forwarded-Encrypted: i=1; AJvYcCXJEpIeBCO4enOf6bVtgG7h7QhEUmIevbh840Pc61o2Wiak0v2RcoKH1y1YpFNqZRhf6N3DapI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLAIYq0W50nJ4OXmpCUETWpgc5LHoHTbW0i9nzPnEDJEbr4kj
	BpaPcD7B73BLu885GkIHbCwCQ6Dh0Cpv3oDPF2nHtMz5PySEzp6IR8/a
X-Gm-Gg: ATEYQzz2SfvvnBmzymLuPNx7i9pQJX/JUlVs2fHPVK7+bZXuJRckDqmtKwvqU2DVK6q
	IXsSTfhCKc9qBhbrhLpVHFdvsxQmXy7vZrE/KJ1Cmlz0jMdTsr/j18FClK/gXgGdbc9dRWKIESE
	JX3xiG+jrpBAGI4/SAQ0R37N1Nc5Z1zH4l0GzklKgRGZECnfmAXp4jIVmKgzJH/jufNidn5AHvB
	KQ3Bua6wHTd5DI+6HYzMvCEApM9mCJRLUkb4wofV+FfuiU8F+LhpY3/oRJ+3AYd+VktzWX5ZFEl
	Dw4CT3KfpFo96iOKKtiZTA/Ma8h/HwY03droTWyN0twdqjRxv6JHnc7WWfuSubOM3Q3dIhjQSZn
	rFrb03vdPPZAnen1APgxUlvYfrlRh0emnH8p3a5z+42LLT3VQqd3Yt6j0uWKeGWUIKhZZyns1lV
	R3mCN4vW0+wlTnglrc4gq1R+rpIGK2svKRy4wQQw==
X-Received: by 2002:a05:6402:3583:b0:663:5b00:ff49 with SMTP id 4fb4d7f45d1cf-6635b01054dmr386339a12.21.1773267750458;
        Wed, 11 Mar 2026 15:22:30 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6635088fa23sm198194a12.16.2026.03.11.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:22:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the
 verifier
In-Reply-To: <CAMB2axOuQGzb0ekbS6-5K_cTcDta+sUk3NjZtzSaYvbXT1EOcw@mail.gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
 <20260307064439.3247440-4-ameryhung@gmail.com> <87ikb2tkta.fsf@gmail.com>
 <CAMB2axOuQGzb0ekbS6-5K_cTcDta+sUk3NjZtzSaYvbXT1EOcw@mail.gmail.com>
Date: Wed, 11 Mar 2026 22:22:24 +0000
Message-ID: <87fr66t3a7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266785-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84ECC26ADC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Amery Hung <ameryhung@gmail.com> writes:

> On Wed, Mar 11, 2026 at 9:03=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Amery Hung <ameryhung@gmail.com> writes:
>>
>> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
>> > initialized dynptr in process_dynptr_func() so that we can easily
>> > retrieve the information for verification later.
>> >
>> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>> > ---
>> >  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
>> >  1 file changed, 36 insertions(+), 143 deletions(-)
>> >
>> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > index 0f77c4c5b510..d52780962adb 100644
>> > --- a/kernel/bpf/verifier.c
>> > +++ b/kernel/bpf/verifier.c
>> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
>> >       int uid;
>> >  };
>> >
>> > +struct bpf_dynptr_desc {
>> > +     enum bpf_dynptr_type type;
>> > +     u32 id;
>> > +     u32 ref_obj_id;
>> nit: let's add a comment here explaining what this field is for.
>
> We are about to change the meaning of id and ref_obj_id. I can add
> comments explaining id, ref_obj_id and parent_id in the refactor patch
> (#6). That said, the meaning of these fields will apply to all objects
> tracked by the verifier, not just limited to dynptr, and is already
> documented when we define bpf_reg_state in
> include/linux/bpf_verifier.h. Can you share a bit what info you are
> looking for?
>
>
the description from commit message would help:
/* id of the referenced object; objects with same ref_obj_id have the same =
lifetime */

Oftentimes when I work on verifier, it's difficult to understand what
some data field is for. It's easier now with the AI, but still I see a
lot of value to have that inline. Essentially ref_obj_id does not have
obvious meaning (at least to me).=20=20
>> > +};
>> > +
>> >  struct bpf_call_arg_meta {
>> >       struct bpf_map_desc map;
>> > +     struct bpf_dynptr_desc initialized_dynptr;
>> >       bool raw_mode;
>> >       bool pkt_access;
>> >       u8 release_regno;
>> > @@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
>> >       int mem_size;
>> >       u64 msize_max_value;
>> >       int ref_obj_id;
>> > -     int dynptr_id;
>> >       int func_id;
>> >       struct btf *btf;
>> >       u32 btf_id;
>> > @@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
>> >       struct {
>> >               struct btf_field *field;
>> >       } arg_rbtree_root;
>> > -     struct {
>> > -             enum bpf_dynptr_type type;
>> > -             u32 id;
>> > -             u32 ref_obj_id;
>> > -     } initialized_dynptr;
>> >       struct {
>> >               u8 spi;
>> >               u8 frameno;
>> >       } iter;
>> >       struct bpf_map_desc map;
>> > +     struct bpf_dynptr_desc initialized_dynptr;
>> >       u64 mem_size;
>> >  };
>> >
>> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id=
 func_id)
>> >               func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
>> >  }
>> >
>> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
>> > -{
>> > -     return func_id =3D=3D BPF_FUNC_dynptr_data;
>> > -}
>> > -
>> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
>> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
>> >  static bool is_callback_calling_kfunc(u32 btf_id);
>> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_f=
unc_id func_id,
>> >               ref_obj_uses++;
>> >       if (is_acquire_function(func_id, map))
>> >               ref_obj_uses++;
>> > -     if (is_dynptr_ref_function(func_id))
>> > -             ref_obj_uses++;
>> >
>> >       return ref_obj_uses > 1;
>> >  }
>> > @@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifier=
_env *env, int regno,
>> >   * type, and declare it as 'const struct bpf_dynptr *' in their proto=
type.
>> >   */
>> >  static int process_dynptr_func(struct bpf_verifier_env *env, int regn=
o, int insn_idx,
>> > -                            enum bpf_arg_type arg_type, int clone_ref=
_obj_id)
>> > +                            enum bpf_arg_type arg_type, int clone_ref=
_obj_id,
>> > +                            struct bpf_dynptr_desc *initialized_dynpt=
r)
>> >  {
>> >       struct bpf_reg_state *reg =3D reg_state(env, regno);
>> >       int err;
>> > @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verif=
ier_env *env, int regno, int insn
>> >               }
>> >
>> >               err =3D mark_dynptr_read(env, reg);
>> > +
>> > +             if (initialized_dynptr) {
>> > +                     struct bpf_func_state *state =3D func(env, reg);
>> state is only used if reg->type !=3D CONST_PTR_TO_DYNPTR, does it make
>> sense to move state =3D func(env, reg); to the corresponding if block?
>
> I think this is fine. It looks less cluttered this way.
>
>> > +                     int spi;
>> > +
>> > +                     if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
>> > +                             spi =3D dynptr_get_spi(env, reg);
>> looking at the deleted dynptr_id() and dynptr_ref_obj_id() spi can be
>> negative, what changed here that we no longer need this check?
>
> is_dynptr_reg_valid_init() above already makes sure reg points to a
> valid dynptr so we don't need to check it again.
>
>> > +                             reg =3D &state->stack[spi].spilled_ptr;
>> > +                     }
>> > +
>> > +                     initialized_dynptr->id =3D reg->id;
>> > +                     initialized_dynptr->type =3D reg->dynptr.type;
>> > +                     initialized_dynptr->ref_obj_id =3D reg->ref_obj_=
id;
>> > +             }
>> >       }
>> >       return err;
>> >  }
>> > @@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_ve=
rifier_env *env,
>> >       }
>> >  }
>> >
>> > -static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_e=
nv *env,
>> > -                                             const struct bpf_func_pr=
oto *fn,
>> > -                                             struct bpf_reg_state *re=
gs)
>> > -{
>> > -     struct bpf_reg_state *state =3D NULL;
>> > -     int i;
>> > -
>> > -     for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
>> > -             if (arg_type_is_dynptr(fn->arg_type[i])) {
>> > -                     if (state) {
>> > -                             verbose(env, "verifier internal error: m=
ultiple dynptr args\n");
>> > -                             return NULL;
>> > -                     }
>> > -                     state =3D &regs[BPF_REG_1 + i];
>> > -             }
>> > -
>> > -     if (!state)
>> > -             verbose(env, "verifier internal error: no dynptr arg fou=
nd\n");
>> > -
>> > -     return state;
>> > -}
>> > -
>> > -static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_sta=
te *reg)
>> > -{
>> > -     struct bpf_func_state *state =3D func(env, reg);
>> > -     int spi;
>> > -
>> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
>> > -             return reg->id;
>> > -     spi =3D dynptr_get_spi(env, reg);
>> > -     if (spi < 0)
>> > -             return spi;
>> > -     return state->stack[spi].spilled_ptr.id;
>> > -}
>> > -
>> > -static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf=
_reg_state *reg)
>> > -{
>> > -     struct bpf_func_state *state =3D func(env, reg);
>> > -     int spi;
>> > -
>> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
>> > -             return reg->ref_obj_id;
>> > -     spi =3D dynptr_get_spi(env, reg);
>> > -     if (spi < 0)
>> > -             return spi;
>> > -     return state->stack[spi].spilled_ptr.ref_obj_id;
>> > -}
>> > -
>> > -static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *=
env,
>> > -                                         struct bpf_reg_state *reg)
>> > -{
>> > -     struct bpf_func_state *state =3D func(env, reg);
>> > -     int spi;
>> > -
>> > -     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
>> > -             return reg->dynptr.type;
>> > -
>> > -     spi =3D __get_spi(reg->var_off.value);
>> > -     if (spi < 0) {
>> > -             verbose(env, "verifier internal error: invalid spi when =
querying dynptr type\n");
>> > -             return BPF_DYNPTR_TYPE_INVALID;
>> > -     }
>> > -
>> > -     return state->stack[spi].spilled_ptr.dynptr.type;
>> > -}
>> > -
>> >  static int check_reg_const_str(struct bpf_verifier_env *env,
>> >                              struct bpf_reg_state *reg, u32 regno)
>> >  {
>> > @@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
>> >                                        true, meta);
>> >               break;
>> >       case ARG_PTR_TO_DYNPTR:
>> > -             err =3D process_dynptr_func(env, regno, insn_idx, arg_ty=
pe, 0);
>> > +             err =3D process_dynptr_func(env, regno, insn_idx, arg_ty=
pe, 0,
>> > +                                       &meta->initialized_dynptr);
>> >               if (err)
>> >                       return err;
>> >               break;
>> > @@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct bpf=
_verifier_env *env, int subprog,
>> >                       if (ret)
>> >                               return ret;
>> >
>> > -                     ret =3D process_dynptr_func(env, regno, -1, arg-=
>arg_type, 0);
>> > +                     ret =3D process_dynptr_func(env, regno, -1, arg-=
>arg_type, 0, NULL);
>> >                       if (ret)
>> >                               return ret;
>> >               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BT=
F_ID) {
>> > @@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_veri=
fier_env *env, struct bpf_insn *insn
>> >                       }
>> >               }
>> >               break;
>> > -     case BPF_FUNC_dynptr_data:
>> > -     {
>> > -             struct bpf_reg_state *reg;
>> > -             int id, ref_obj_id;
>> > -
>> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
>> > -             if (!reg)
>> > -                     return -EFAULT;
>> > -
>> > -
>> > -             if (meta.dynptr_id) {
>> > -                     verifier_bug(env, "meta.dynptr_id already set");
>> > -                     return -EFAULT;
>> > -             }
>> > -             if (meta.ref_obj_id) {
>> > -                     verifier_bug(env, "meta.ref_obj_id already set");
>> > -                     return -EFAULT;
>> > -             }
>> > -
>> > -             id =3D dynptr_id(env, reg);
>> > -             if (id < 0) {
>> > -                     verifier_bug(env, "failed to obtain dynptr id");
>> > -                     return id;
>> > -             }
>> > -
>> > -             ref_obj_id =3D dynptr_ref_obj_id(env, reg);
>> > -             if (ref_obj_id < 0) {
>> > -                     verifier_bug(env, "failed to obtain dynptr ref_o=
bj_id");
>> > -                     return ref_obj_id;
>> > -             }
>> > -
>> > -             meta.dynptr_id =3D id;
>> > -             meta.ref_obj_id =3D ref_obj_id;
>> > -
>> > -             break;
>> > -     }
>> >       case BPF_FUNC_dynptr_write:
>> >       {
>> > -             enum bpf_dynptr_type dynptr_type;
>> > -             struct bpf_reg_state *reg;
>> > -
>> > -             reg =3D get_dynptr_arg_reg(env, fn, regs);
>> > -             if (!reg)
>> > -                     return -EFAULT;
>> > +             enum bpf_dynptr_type dynptr_type =3D meta.initialized_dy=
nptr.type;
>> >
>> > -             dynptr_type =3D dynptr_get_type(env, reg);
>> >               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
>> >                       return -EFAULT;
>> >
>> > @@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
>> >               return -EFAULT;
>> >       }
>> >
>> > -     if (is_dynptr_ref_function(func_id))
>> > -             regs[BPF_REG_0].dynptr_id =3D meta.dynptr_id;
>> > -
>> > -     if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func=
_id)) {
>> > +     if (is_ptr_cast_function(func_id)) {
>> >               /* For release_reference() */
>> >               regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
>> >       } else if (is_acquire_function(func_id, meta.map.ptr)) {
>> > @@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
>> >               regs[BPF_REG_0].ref_obj_id =3D id;
>> >       }
>> >
>> > +     if (func_id =3D=3D BPF_FUNC_dynptr_data) {
>> > +             regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.id;
>> > +             regs[BPF_REG_0].ref_obj_id =3D meta.initialized_dynptr.r=
ef_obj_id;
>> > +     }
>> > +
>> >       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id,=
 &meta);
>> >       if (err)
>> >               return err;
>> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verif=
ier_env *env, struct bpf_kfunc_call_
>> >                               }
>> >                       }
>> >
>> > -                     ret =3D process_dynptr_func(env, regno, insn_idx=
, dynptr_arg_type, clone_ref_obj_id);
>> > +                     ret =3D process_dynptr_func(env, regno, insn_idx=
, dynptr_arg_type, clone_ref_obj_id,
>> > +                                               &meta->initialized_dyn=
ptr);
>> >                       if (ret < 0)
>> >                               return ret;
>> > -
>> > -                     if (!(dynptr_arg_type & MEM_UNINIT)) {
>> > -                             int id =3D dynptr_id(env, reg);
>> > -
>> > -                             if (id < 0) {
>> > -                                     verifier_bug(env, "failed to obt=
ain dynptr id");
>> > -                                     return id;
>> > -                             }
>> > -                             meta->initialized_dynptr.id =3D id;
>> > -                             meta->initialized_dynptr.type =3D dynptr=
_get_type(env, reg);
>> > -                             meta->initialized_dynptr.ref_obj_id =3D =
dynptr_ref_obj_id(env, reg);
>> > -                     }
>> > -
>> >                       break;
>> >               }
>> >               case KF_ARG_PTR_TO_ITER:
>> > --
>> > 2.47.3

