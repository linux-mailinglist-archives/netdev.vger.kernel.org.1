Return-Path: <netdev+bounces-290118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDI3H9JDDmrV9QUAu9opvQ
	(envelope-from <netdev+bounces-290118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D219659CC18
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82797332C2F7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4438911E;
	Wed, 20 May 2026 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa9Y3b+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41F37BE87
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313669; cv=none; b=TTx53wa0TLL4OS8cIr2v2A+P2S3kSBi/mCLAMzgBYzGhuHjiUdtTzcqCZywbPJthzuxCzE5UURJybsFrH0/FOjpGgehCViZUqRmN9+k96/1GUdpyIOB0Hw2EnpjkXO4m/H3YisasMbM+HEG2/CscjMWOm3ztI/XvaTBiu+D1vWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313669; c=relaxed/simple;
	bh=ARzvYXH+T8zBstiJIjJ9AsHEOipATDfcwN6hoPtaBAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7s+0iCE+qCYm/hA6haHwL9YUVba6kUdp37h1oBtOLYkbymjvbu0U+rOG5PnVTthvZmAP+GmQCWHhJt2kbOnlp6cc2LUDo9lxJ5F5FtX6QViUoKTJM/1TeEEhvfJZy0T8IEbE+85gPu/h5N8hDEJqRKcc2NzsqIxZczkpVXUnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa9Y3b+J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so54600505ad.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313668; x=1779918468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YpTjOC7sOkfHmwRe7c7VQheaDmyv43bs1AM8pVSpDtA=;
        b=Oa9Y3b+JilogU186oCv1BFBFSrGnSZ5YbRZd8mFL9YQGlMRHo0V0ldsZ2PRlL3qJNV
         oQEQQfZ+u7i9HL2yjj2SxL5L4JTskw4ViVpYXTUi2Pw6T6ab/c7N9/10369hq5h8TVTa
         nMzs6IT2USgMzgMILSasBlpkC7FWnBMabzavxo60VphsN0CWM0lnPbUfyemGfuPp1HpB
         5VH74iHlVp67rQ7rBIdtFmmc7HEAc2pzUbFbAXmdaBWtQbzger1R5b4vtY5AD0pe2xr8
         hNJ89GeHL4FMZ2biQWSIFaG8iiySTNmrP325ghQ4ACy003Jj3C2Fe/UP/zDIVO5YtFCJ
         La6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313668; x=1779918468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpTjOC7sOkfHmwRe7c7VQheaDmyv43bs1AM8pVSpDtA=;
        b=DW0lS2Cymv6L6z4i9ozaGjj0RCRvzyKh0aekSEEMDH3fRZWW801wQMgIx8uJTbKleQ
         5QcuO5iSbZz4oQ8nXCCM8qZvvu32zF/UJ2r5ecgA2nQtzKKFhSzAafE1g39cz1sowEcD
         MLXn4zzWyiBef3YBcj0Av3H8fyCTwXcZ3curHl0bw+ZYeWM1dBtx51Ffulj5s2g36w4U
         FiGwxzAnaHBbZn6c47QBSjPsq+DoxKHdvfi80ynqtay/UvUzDfTTAqA6eloljK8JsKdd
         TdazSZyiG7tps2LqHBZ0zYajUEF4ycQAdnTlsUIIuTORnYMeQl2/0nzCcEJb8o6/QIwO
         TeHA==
X-Gm-Message-State: AOJu0YyrhWkxhFcFdYi+qIkFYQwXDAIz8Cb4dG7GwQmc4y62wA+CexQu
	+THWnY4jMq3FKx8ZzLBk+ylGqkfFyagzYgP8+QhtIiJhF6MKpCs1IKAq
X-Gm-Gg: Acq92OHCZxJaOS0ioxWNerqi5SnqmDXdcRgfBx9uUaxdKYCek8qHS8gCXdda4t4Qhic
	6pebBZxogMaFQtnBVlw4olQxhiuYhyX+ojt7u6AubDwWkO0AGmby8LkKf5MHLc7yvEeaDRqL8mA
	SNlpLMJ5w8FQzlt+2NQOXtGTYpay4bBAemXGBOUxd7T5FGzMR4GK4eis6XGByBOxnO47G552VAI
	NEucpE39b3RJ/ahqkq28067Y/fRLZ9Cnq8FPCnKBcpca9+tcQH4mmPFl75OqgnG2ZfPVLiCB5Up
	EXsl/NCEPM1nkentoR9k+oRAAw8bhbf4f+Kt5Es7ud87WPheAN7n5UC+cgK7QaJ+vc3LjV6eBmo
	2BGFWKtaGZJBT+5NN84niMf4PTt0LvZT8xKiP8gcJ9sIXsu8p8KlwAf3f1lb93N9ECvBUT3d4qL
	OAyvJeNMYozescZtyAnXFcd4SIK4L8yBKDN5/ltkvIysGlWLLzm8ng
X-Received: by 2002:a17:902:d5d0:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2bd7e97a6c2mr170998335ad.41.1779313667710;
        Wed, 20 May 2026 14:47:47 -0700 (PDT)
Received: from [192.168.0.161] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f27csm226191215ad.25.2026.05.20.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:47:47 -0700 (PDT)
Message-ID: <02e6bb8e8b5e9e21e5b5f81adb9f440d556c83ed.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 20 May 2026 14:47:44 -0700
In-Reply-To: <20260519181314.2731658-6-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290118-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D219659CC18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 753681b0a987..89c219df6591 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -202,7 +202,7 @@ struct bpf_verifier_stack_elem {
> =C2=A0
> =C2=A0static int acquire_reference(struct bpf_verifier_env *env, int insn=
_idx);
> =C2=A0static int release_reference_nomark(struct bpf_verifier_state *stat=
e, int ref_obj_id);
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
> +static int release_reference(struct bpf_verifier_env *env, int id);
> =C2=A0static void invalidate_non_owning_refs(struct bpf_verifier_env *env=
);
> =C2=A0static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env=
);
> =C2=A0static int ref_set_non_owning(struct bpf_verifier_env *env,
> @@ -242,6 +242,7 @@ struct bpf_call_arg_meta {
> =C2=A0	int mem_size;
> =C2=A0	u64 msize_max_value;
> =C2=A0	int ref_obj_id;
> +	u32 id;

Is this one used anywhere?

> =C2=A0	int func_id;
> =C2=A0	struct btf *btf;
> =C2=A0	u32 btf_id;

[...]

> @@ -839,34 +806,20 @@ static int destroy_if_dynptr_stack_slot(struct bpf_=
verifier_env *env,
> =C2=A0			verbose(env, "cannot overwrite referenced dynptr\n");
> =C2=A0			return -EINVAL;
> =C2=A0		}
> -	}
> =C2=A0
> -	mark_stack_slot_scratched(env, spi);
> -	mark_stack_slot_scratched(env, spi - 1);

Nit: no need to move mark_stack_slot_scratched().

> =C2=A0
> -	/* Writing partially to one dynptr stack slot destroys both. */
> -	for (i =3D 0; i < BPF_REG_SIZE; i++) {
> -		state->stack[spi].slot_type[i] =3D STACK_INVALID;
> -		state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
> +		invalidate_dynptr(env, &state->stack[spi - 1]);
> +	} else {
> +		/* Invalidate the dynptr and any derived slices */
> +		err =3D release_reference(env, state->stack[spi].spilled_ptr.id);
> =C2=A0	}
> =C2=A0
> -	dynptr_id =3D state->stack[spi].spilled_ptr.id;
> -	/* Invalidate any slices associated with this dynptr */
> -	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> -		/* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
> -		if (dreg->type !=3D (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type !=3D P=
TR_TO_MEM)
> -			continue;
> -		if (dreg->dynptr_id =3D=3D dynptr_id)
> -			mark_reg_invalid(env, dreg);
> -	}));
> -
> -	/* Do not release reference state, we are destroying dynptr on stack,
> -	 * not using some helper to release it. Just reset register.
> -	 */
> -	bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> -	bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> +	if (!err) {
> +		mark_stack_slot_scratched(env, spi);
> +		mark_stack_slot_scratched(env, spi - 1);
> +	}
> =C2=A0
> -	return 0;
> +	return err;
> =C2=A0}
> =C2=A0
> =C2=A0static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env=
, struct bpf_reg_state *reg)

[...]

> @@ -8908,26 +8870,76 @@ static int release_reference_nomark(struct bpf_ve=
rifier_state *state, int ref_ob
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> -/* The pointer with the specified id has released its reference to kerne=
l
> - * resources. Identify all copies of the same pointer and clear the refe=
rence.
> - *
> - * This is the release function corresponding to acquire_reference(). Id=
empotent.
> - */
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d)
> +static int idstack_push(struct bpf_idmap *idmap, u32 id)
> +{
> +	int i;
> +
> +	if (!id)
> +		return 0;
> +
> +	for (i =3D 0; i < idmap->cnt; i++)
> +		if (idmap->map[i].old =3D=3D id)
> +			return 0;
> +
> +	if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
> +		return -EFAULT;
> +
> +	idmap->map[idmap->cnt++].old =3D id;
> +	return 0;
> +}
> +
> +static int idstack_pop(struct bpf_idmap *idmap)
> =C2=A0{
> +	if (!idmap->cnt)
> +		return 0;
> +
> +	return idmap->map[--idmap->cnt].old;
> +}
> +
> +/* Release id and objects referencing the id iteratively in a DFS manner=
 */
> +static int release_reference(struct bpf_verifier_env *env, int id)
> +{
> +	u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
> =C2=A0	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	struct bpf_idmap *idstack =3D &env->idmap_scratch;
> +	struct bpf_stack_state *stack;
> =C2=A0	struct bpf_func_state *state;
> =C2=A0	struct bpf_reg_state *reg;
> -	int err;
> +	int root_id =3D id, err;
> =C2=A0
> -	err =3D release_reference_nomark(vstate, ref_obj_id);
> -	if (err)
> -		return err;
> +	idstack->cnt =3D 0;
> +	idstack_push(idstack, id);

Nit: check error code or drop error path from idstack_push?

> =C2=A0
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->ref_obj_id =3D=3D ref_obj_id)
> -			mark_reg_invalid(env, reg);
> -	}));
> +	if (find_reference_state(vstate, id))
> +		WARN_ON_ONCE(release_reference_nomark(vstate, id));
> +
> +	while ((id =3D idstack_pop(idstack))) {
> +		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
> +			if (reg->id !=3D id && reg->parent_id !=3D id && reg->ref_obj_id !=3D=
 id)
> +				continue;
> +
> +			if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id) {
> +				struct bpf_reference_state *ref_state;
> +
> +				ref_state =3D find_reference_state(env->cur_state, reg->ref_obj_id);
> +				verbose(env, "Leaking reference id=3D%d alloc_insn=3D%d. Release it =
first.\n",
> +					ref_state->id, ref_state->insn_idx);
> +				return -EINVAL;

Thinking some more about it, the mere presence of dangling objects
with the same lifetime is not an error. The error would happen if such
objects are accessed. Should the verifier invalidate such dangling
objects instead of signaling an error immediately?

> +			}
> +
> +			/* Free objects derived from the current object */
> +			if (reg->id !=3D id) {

I think this should be changed to `reg->parent_id =3D=3D id`,
otherwise the reader has to infer that from the logical expression:

  !(reg->id !=3D id && reg->parent_id !=3D id && reg->ref_obj_id !=3D id) &=
&
  !(reg->ref_obj_id && reg->ref_obj_id !=3D root_id) &&
  (reg->id !=3D id)

> +				err =3D idstack_push(idstack, reg->id);
> +				if (err)
> +					return err;
> +			}
> +
> +			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
> +				mark_reg_invalid(env, reg);
> +			else if (stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR)
> +				invalidate_dynptr(env, stack);
> +		}));
> +	}
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}

[...]

