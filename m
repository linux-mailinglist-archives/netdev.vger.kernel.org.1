Return-Path: <netdev+bounces-267232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CBlNW1Ns2kZUgAAu9opvQ
	(envelope-from <netdev+bounces-267232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:34:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D127B482
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 175593069055
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738893FFAC1;
	Thu, 12 Mar 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7vOkI5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573B3FFABE
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773358437; cv=none; b=IbJa3jl6beWPwhgPNauy5GHlseluiYa3whH4PuvGUfyj0RUluLiGGv/9+QwqtfFoHLd0Zvh8MTPCG2BZaejb3Zipm/Hc8E+Y6WiSizldTdxrHEck0idUsqZ+BiLGzVf/OsyWCriqXv3Gb2x/jbcysTHeq+cvHxtw43EW5oQObOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773358437; c=relaxed/simple;
	bh=cQn35uiUNHy86w5DdrZtUAXuqXxYbzT64OzPvHkPT8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLONTdVffk3Rp6RSzKjBqU3pkjGSsWlwcnHFw8Cp7ovcK62KmtuSROE50rrnxut9QH637QvBuEp//W4EMJlaq6cKRwaCjtR/R7GIB9kalpk7bT1eq9SmX2faAHUX68QhgQOZopDHgcw9TNB3gdD2DaG4V33R40NbHJpCUfzwR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7vOkI5Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so13708835e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773358432; x=1773963232; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2RMCipP/61cyMC8QFkknbtbVKos9LtKe4Ertlj1Vo8=;
        b=R7vOkI5Q89vvNvWoWD7hKG0sa6Qg2PhN5fNKOfZgCWiAEXlWPfdeuCCDbTWOW/8TCF
         nueSsmbbahf0ywqTwGwRrBaV1l3MWRutNJKGnABDPQAH2+Cf49Hiht6+EL7alrATRvaJ
         EiIgxGOVhqRryxjDaEISoubVjyRoAPSlNPxOCjg+Ae4ytXFI7JfFEO6pRAahjfCttc3q
         GBejspU385ASGFPEAKCKfYsqYePAV0TcsPFOEQXnSwks+X6QFwiObtPZ0I4WgI4/B8ck
         fuP0OywNldZ0nkZzQNES/HrTdDYJkYXm/CAUhYOoa+qYJ/fT7c5+woUP0euCKATXMqvA
         W3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773358432; x=1773963232;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2RMCipP/61cyMC8QFkknbtbVKos9LtKe4Ertlj1Vo8=;
        b=jwo02QYdpsmYSlvJLJmnvw0XfnCykmvW+xpygFDlTOh1OvcXEuIB2Htjaf4IuYcoBU
         J9CaceyLLfOD00dh17ZpEATIi0DtNBJxeHqStPQMumx8HJhe8CDWmYbJDhPY+GWncPMf
         VacZuZPaOlzbpi2KmBRsdRaoBpL7Z+orounE5ZSuzRWu+nuWhXYpnP2+bJdWI0EoeF19
         P4R2RtE6fqXfDH9BGxznyM6Q+EA/EY+3iwTtqlLLNOZ+5A22zAnLTph3ZvLF7R/xN8FZ
         LALGXwriKNadou2MslL6oig786QT2Aq2FaOTa/ExejDlMrzScBFk4yjMqN7u2ZkPmQY+
         7NIg==
X-Gm-Message-State: AOJu0YzQemz1HVZxFiDQjA7rAllFfdlPxJGFo1DVbs6ansEF0EGrdjy6
	RI+6IDxB0RpFuicxX8MbPGGXnzWC6dLTCKNkA8oQHi06xSu7yPNTOy4D
X-Gm-Gg: ATEYQzyJzkQDKF4tdnoFQloUm3AG3Q1aPqm7be9qiVLyVlmsYi6IEyE4ReEAzEWnor0
	OjBE6D9zfn0NSDRsflQlUb202oHlyH2NFeMM/sFKaAJERu6n2hXfHawmt/dGn6NF7hb+I2zPs64
	rFC8uw0MxJVLdPD610nmZDDZKPVFSyN29UNFEuJPf+SRJ+5U922trq+R8xTd14IKa76b9LKQOMr
	/4bYGX8ZPPzkWHJwyIah3kpLAgSLjK/aTRuyThwYJr/QtlHnkrE06/2L06IHJmgCh+BjLs+mSGV
	EWd1ggRCBBKkiK6GT8daZDx8xOvea/PWOvcXVITpuWk3E5r0BbABjW89R2SfbLnxISYcMnP5ENB
	R/43s9vyr6zuIo/CnI+hnxN4aNoYp1hvcZi2Vr2qGvc6zBqgwT1qIFfgF9ck6rUpdTXJbhERQdc
	9NtkA30781n0tD0BzsORpzjvk0BPnv4i/t/g==
X-Received: by 2002:a05:600d:6451:10b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48556705319mr13270795e9.25.1773358431310;
        Thu, 12 Mar 2026 16:33:51 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bb90sm12897215f8f.19.2026.03.12.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 16:33:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next v2 06/11] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
In-Reply-To: <20260307064439.3247440-7-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
 <20260307064439.3247440-7-ameryhung@gmail.com>
Date: Thu, 12 Mar 2026 23:33:49 +0000
Message-ID: <87cy18tyg2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-267232-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 717D127B482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Amery Hung <ameryhung@gmail.com> writes:

> Refactor object relationship tracking in the verifier by removing
> dynptr_id and using parent_id to track the parent object. Then, track
> the referenced parent object for the dynptr when calling a dynptr
> constructor. This fixes a use-after-free bug. For dynptr that has
> referenced parent object (skb dynptr in BPF qdisc or file dynptr),
> the dynptr or derived slices need to be invalidated when the parent
> object is released.
>
> First, add parent_id to bpf_reg_state to be able to precisely track
> objects' child-parent relationship. A child object will use parent_id
> to track the parent object's id. This replaces dynptr slice specific
> dynptr_id.
>
> Then, when calling dynptr constructors (i.e., process_dynptr_func() with
> MEM_UNINIT argument), track the parent's id if parent is an referenced
> object. This only applies to file dynptr and skb dynptr, so only pass
> parent reg->id to kfunc constructors.
>
> For release_reference(), this mean when invalidating an object, it needs
> to also invalidate all dependent objects by traversing the subtree. This
> is done using stack-based DFS to avoid recursive call chain of
> release_reference() -> unmark_stack_slots_dynptr() ->
> release_reference(). Note that, referenced objects cannot be released
> when traversing the tree if it is not the object id initially passed to
> release_reference() as they would actually require helper call to
> release the acquired resources.
>
> While the new design changes how object relationships are being tracked
> in the verifier, it does NOT change the verifier's behavior. Here is
> the implication of the new design for dynptr, ptr casting and
> owning/non-owning references.
>
> Dynptr:
>
> When initializing a dynptr, referenced dynptr will acquire an reference
> for ref_obj_id. If the dynptr has a referenced parent, the parent_id
> will be used to track the its id. When cloning dynptr, ref_obj_id and
> parent_id of the clone are copied directly from the original dynptr.
> This means, when releasing a dynptr, if it is a referenced dynptr,
> release_reference(ref_obj_id) will release all clones and the original
> and derived slices. For non-referenced dynptr, only the specific dynptr
> being released and its children slices will be invalidated.
>
> Pointer casting:
>
> Referenced socket pointer and the casted pointers should share the same
> lifetime, while having difference nullness. Therefore, they will have
> different id but the same ref_obj_id.
>
> When converting owning references to non-owning:
>
> After converting a reference from owning to non-owning by clearing the
> object's ref_reg_id. (e.g., object(id=1, ref_obj_id=1) -> object(id=1,
> ref_obj_id=0)), the verifier only needs to release the reference state
> instead of releasing registers that have the id, so call
> release_reference_nomark() instead of release_reference().
>
> CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  14 +-
>  kernel/bpf/log.c             |   4 +-
>  kernel/bpf/verifier.c        | 274 ++++++++++++++++++-----------------
>  3 files changed, 154 insertions(+), 138 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c1e30096ea7b..e987a48f511a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -65,7 +65,6 @@ struct bpf_reg_state {
>  
>  		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
>  			u32 mem_size;
> -			u32 dynptr_id; /* for dynptr slices */
>  		};
>  
>  		/* For dynptr stack slots */
> @@ -193,6 +192,13 @@ struct bpf_reg_state {
>  	 * allowed and has the same effect as bpf_sk_release(sk).
>  	 */
>  	u32 ref_obj_id;
> +	/* Tracks the parent object this register was derived from.
> +	 * Used for cascading invalidation: when the parent object is
> +	 * released or invalidated, all registers with matching parent_id
> +	 * are also invalidated. For example, a slice from bpf_dynptr_data()
> +	 * gets parent_id set to the dynptr's id.
> +	 */
> +	u32 parent_id;
>  	/* Inside the callee two registers can be both PTR_TO_STACK like
>  	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
>  	 * while another to the caller's stack. To differentiate them 'frameno'
> @@ -707,6 +713,11 @@ struct bpf_idset {
>  	} entries[BPF_ID_MAP_SIZE];
>  };
>  
> +struct bpf_idstack {
> +	int cnt;
> +	u32 ids[BPF_ID_MAP_SIZE];
> +};
> +
>  /* see verifier.c:compute_scc_callchain() */
>  struct bpf_scc_callchain {
>  	/* call sites from bpf_verifier_state->frame[*]->callsite leading to this SCC */
> @@ -789,6 +800,7 @@ struct bpf_verifier_env {
>  	union {
>  		struct bpf_idmap idmap_scratch;
>  		struct bpf_idset idset_scratch;
> +		struct bpf_idstack idstack_scratch;
>  	};
>  	struct {
>  		int *insn_state;
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 37d72b052192..cb4129b8b2a1 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -707,6 +707,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
>  		verbose(env, "%+d", reg->delta);
>  	if (reg->ref_obj_id)
>  		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
> +	if (reg->parent_id)
> +		verbose_a("parent_id=%d", reg->parent_id);
>  	if (type_is_non_owning_ref(reg->type))
>  		verbose_a("%s", "non_own_ref");
>  	if (type_is_map_ptr(t)) {
> @@ -810,8 +812,6 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
>  				verbose_a("id=%d", reg->id);
>  			if (reg->ref_obj_id)
>  				verbose_a("ref_id=%d", reg->ref_obj_id);
> -			if (reg->dynptr_id)
> -				verbose_a("dynptr_id=%d", reg->dynptr_id);
>  			verbose(env, ")");
>  			break;
>  		case STACK_ITER:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f9e28901bc4..0436fc4d9107 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -204,7 +204,7 @@ struct bpf_verifier_stack_elem {
>  
>  static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
>  static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
> +static int release_reference(struct bpf_verifier_env *env, int id);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
> @@ -281,6 +281,7 @@ struct bpf_dynptr_desc {
>  	enum bpf_dynptr_type type;
>  	u32 id;
>  	u32 ref_obj_id;
> +	u32 parent_id;
>  };
>  
>  struct bpf_call_arg_meta {
> @@ -294,6 +295,7 @@ struct bpf_call_arg_meta {
>  	int mem_size;
>  	u64 msize_max_value;
>  	int ref_obj_id;
> +	u32 id;
>  	int func_id;
>  	struct btf *btf;
>  	u32 btf_id;
> @@ -321,6 +323,7 @@ struct bpf_kfunc_call_arg_meta {
>  	const char *func_name;
>  	/* Out parameters */
>  	u32 ref_obj_id;
> +	u32 id;
>  	u8 release_regno;
>  	bool r0_rdonly;
>  	u32 ret_btf_id;
> @@ -721,14 +724,14 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
>  	}
>  }
>  
> -static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
> +static bool dynptr_type_referenced(enum bpf_dynptr_type type)
>  {
>  	return type == BPF_DYNPTR_TYPE_RINGBUF || type == BPF_DYNPTR_TYPE_FILE;
>  }
>  
>  static void __mark_dynptr_reg(struct bpf_reg_state *reg,
>  			      enum bpf_dynptr_type type,
> -			      bool first_slot, int dynptr_id);
> +			      bool first_slot, int id);
>  
>  static void __mark_reg_not_init(const struct bpf_verifier_env *env,
>  				struct bpf_reg_state *reg);
> @@ -755,11 +758,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  				        struct bpf_func_state *state, int spi);
>  
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
> +				   enum bpf_arg_type arg_type, int insn_idx, int parent_id,
> +				   struct bpf_dynptr_desc *initialized_dynptr)
>  {
>  	struct bpf_func_state *state = func(env, reg);
> +	int spi, i, err, ref_obj_id = 0;
>  	enum bpf_dynptr_type type;
> -	int spi, i, err;
>  
>  	spi = dynptr_get_spi(env, reg);
>  	if (spi < 0)
> @@ -793,22 +797,28 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>  	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
>  			       &state->stack[spi - 1].spilled_ptr, type);
>  
> -	if (dynptr_type_refcounted(type)) {
> -		/* The id is used to track proper releasing */
> -		int id;
> -
> -		if (clone_ref_obj_id)
> -			id = clone_ref_obj_id;
> -		else
> -			id = acquire_reference(env, insn_idx);
> -
> -		if (id < 0)
> -			return id;
> -
> -		state->stack[spi].spilled_ptr.ref_obj_id = id;
> -		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
> +	if (initialized_dynptr->type == BPF_DYNPTR_TYPE_INVALID) {
> +		if (dynptr_type_referenced(type)) {
> +			ref_obj_id = acquire_reference(env, insn_idx);
> +			if (ref_obj_id < 0)
> +				return ref_obj_id;
> +		}
> +	} else {
> +		/*
> +		 * Referenced dynptr clones have the same lifetime as the original dynptr
> +		 * since bpf_dynptr_clone() does not initialize the clones like the
> +		 * constructor does. If any of the dynptrs is invalidated, the rest will
> +		 * also need to invalidated. Thus, they all share the same non-zero ref_obj_id.
> +		 */
> +		ref_obj_id = initialized_dynptr->ref_obj_id;
> +		parent_id = initialized_dynptr->parent_id;
>  	}
>  
> +	state->stack[spi].spilled_ptr.ref_obj_id = ref_obj_id;
> +	state->stack[spi - 1].spilled_ptr.ref_obj_id = ref_obj_id;
> +	state->stack[spi].spilled_ptr.parent_id = parent_id;
> +	state->stack[spi - 1].spilled_ptr.parent_id = parent_id;
> +
>  	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
>  
>  	return 0;
> @@ -832,7 +842,7 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
>  static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>  	struct bpf_func_state *state = func(env, reg);
> -	int spi, ref_obj_id, i;
> +	int spi;
>  
>  	/*
>  	 * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> @@ -843,45 +853,19 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
>  		verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
>  		return -EFAULT;
>  	}
> +
>  	spi = dynptr_get_spi(env, reg);
>  	if (spi < 0)
>  		return spi;
>  
> -	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> -		invalidate_dynptr(env, state, spi);
> -		return 0;
> -	}
> -
> -	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
> -
> -	/* If the dynptr has a ref_obj_id, then we need to invalidate
> -	 * two things:
> -	 *
> -	 * 1) Any dynptrs with a matching ref_obj_id (clones)
> -	 * 2) Any slices derived from this dynptr.
> +	/*
> +	 * For referenced dynptr, the clones share the same ref_obj_id and will be
> +	 * invalidated too. For non-referenced dynptr, only the dynptr and slices
> +	 * derived from it will be invalidated.
>  	 */
> -
> -	/* Invalidate any slices associated with this dynptr */
> -	WARN_ON_ONCE(release_reference(env, ref_obj_id));
> -
> -	/* Invalidate any dynptr clones */
> -	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> -		if (state->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
> -			continue;
> -
> -		/* it should always be the case that if the ref obj id
> -		 * matches then the stack slot also belongs to a
> -		 * dynptr
> -		 */
> -		if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
> -			verifier_bug(env, "misconfigured ref_obj_id");
> -			return -EFAULT;
> -		}
> -		if (state->stack[i].spilled_ptr.dynptr.first_slot)
> -			invalidate_dynptr(env, state, i);
> -	}
> -
> -	return 0;
> +	reg = &state->stack[spi].spilled_ptr;
> +	return release_reference(env, dynptr_type_referenced(reg->dynptr.type) ?
> +				      reg->ref_obj_id : reg->id);
>  }
>  
>  static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> @@ -898,10 +882,6 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  				        struct bpf_func_state *state, int spi)
>  {
> -	struct bpf_func_state *fstate;
> -	struct bpf_reg_state *dreg;
> -	int i, dynptr_id;
> -
>  	/* We always ensure that STACK_DYNPTR is never set partially,
>  	 * hence just checking for slot_type[0] is enough. This is
>  	 * different for STACK_SPILL, where it may be only set for
> @@ -914,7 +894,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
>  		spi = spi + 1;
>  
> -	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> +	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
>  		verbose(env, "cannot overwrite referenced dynptr\n");
>  		return -EINVAL;
>  	}
> @@ -922,31 +902,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  	mark_stack_slot_scratched(env, spi);
>  	mark_stack_slot_scratched(env, spi - 1);
>  
> -	/* Writing partially to one dynptr stack slot destroys both. */
> -	for (i = 0; i < BPF_REG_SIZE; i++) {
> -		state->stack[spi].slot_type[i] = STACK_INVALID;
> -		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> -	}
> -
> -	dynptr_id = state->stack[spi].spilled_ptr.id;
> -	/* Invalidate any slices associated with this dynptr */
> -	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> -		/* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
> -		if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
> -			continue;
> -		if (dreg->dynptr_id == dynptr_id)
> -			mark_reg_invalid(env, dreg);
> -	}));
> -
> -	/* Do not release reference state, we are destroying dynptr on stack,
> -	 * not using some helper to release it. Just reset register.
> -	 */
> -	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> -	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> -
> -	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
> -
> -	return 0;
> +	/* Invalidate the dynptr and any derived slices */
> +	return release_reference(env, state->stack[spi].spilled_ptr.id);
>  }
>  
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> @@ -1583,15 +1540,15 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
>  	return;
>  }
>  
> -static bool find_reference_state(struct bpf_verifier_state *state, int ptr_id)
> +static struct bpf_reference_state *find_reference_state(struct bpf_verifier_state *state, int ptr_id)
>  {
>  	int i;
>  
>  	for (i = 0; i < state->acquired_refs; i++)
>  		if (state->refs[i].id == ptr_id)
> -			return true;
> +			return &state->refs[i];
>  
> -	return false;
> +	return NULL;
>  }
>  
>  static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
> @@ -2186,6 +2143,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>  	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
>  	reg->id = 0;
>  	reg->ref_obj_id = 0;
> +	reg->parent_id = 0;
>  	___mark_reg_known(reg, imm);
>  }
>  
> @@ -2230,7 +2188,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
>  }
>  
>  static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
> -			      bool first_slot, int dynptr_id)
> +			      bool first_slot, int id)
>  {
>  	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
>  	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
> @@ -2239,7 +2197,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
>  	__mark_reg_known_zero(reg);
>  	reg->type = CONST_PTR_TO_DYNPTR;
>  	/* Give each dynptr a unique id to uniquely associate slices to it. */
> -	reg->id = dynptr_id;
> +	reg->id = id;
>  	reg->dynptr.type = type;
>  	reg->dynptr.first_slot = first_slot;
>  }
> @@ -2801,6 +2759,7 @@ static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
>  	reg->type = SCALAR_VALUE;
>  	reg->id = 0;
>  	reg->ref_obj_id = 0;
> +	reg->parent_id = 0;
>  	reg->var_off = tnum_unknown;
>  	reg->frameno = 0;
>  	reg->precise = false;
> @@ -8746,7 +8705,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>   * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
>   */
>  static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
> -			       enum bpf_arg_type arg_type, int clone_ref_obj_id,
> +			       enum bpf_arg_type arg_type, int parent_id,
>  			       struct bpf_dynptr_desc *initialized_dynptr)
>  {
>  	struct bpf_reg_state *reg = reg_state(env, regno);
> @@ -8798,7 +8757,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
>  				return err;
>  		}
>  
> -		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
> +		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, parent_id,
> +					      initialized_dynptr);
>  	} else /* MEM_RDONLY and None case from above */ {
>  		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
>  		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
> @@ -8835,6 +8795,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
>  			initialized_dynptr->id = reg->id;
>  			initialized_dynptr->type = reg->dynptr.type;
>  			initialized_dynptr->ref_obj_id = reg->ref_obj_id;
> +			initialized_dynptr->parent_id = reg->parent_id;
>  		}
>  	}
>  	return err;
> @@ -9787,7 +9748,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			 */
>  			if (reg->type == PTR_TO_STACK) {
>  				spi = dynptr_get_spi(env, reg);
> -				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
> +				if (spi < 0 || !state->stack[spi].spilled_ptr.id) {
>  					verbose(env, "arg %d is an unacquired reference\n", regno);
>  					return -EINVAL;
>  				}
> @@ -9815,6 +9776,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			return -EACCES;
>  		}
>  		meta->ref_obj_id = reg->ref_obj_id;
> +		meta->id = reg->id;
>  	}
>  
>  	switch (base_type(arg_type)) {
> @@ -10438,26 +10400,82 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob
>  	return -EINVAL;
>  }
>  
> -/* The pointer with the specified id has released its reference to kernel
> - * resources. Identify all copies of the same pointer and clear the reference.
> - *
> - * This is the release function corresponding to acquire_reference(). Idempotent.
> - */
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
> +static void idstack_reset(struct bpf_idstack *idstack)
> +{
> +	idstack->cnt = 0;
> +}
> +
I agree with Andrii, maybe new bpf_idstack is not really worth adding,
Since the total number of reg_states is bounded, the idstack could be
replaced with a simpler approach using bpf_idset: store                                            
discovered IDs in a flat array and keep a cursor to the first                                                
unprocessed entry. IDs before the cursor are already visited, IDs at
and after it are pending. "Popping" becomes just advancing the cursor,
and deduplication comes naturally by searching the full array (both
visited and pending) before inserting a new ID.

This avoids the possibility of pushing the same child ID multiple times.
> +static void idstack_push(struct bpf_idstack *idstack, u32 id)
> +{
> +	if (WARN_ON_ONCE(idstack->cnt >= BPF_ID_MAP_SIZE))
> +		return;
> +
> +	idstack->ids[idstack->cnt++] = id;
> +}
> +
> +static u32 idstack_pop(struct bpf_idstack *idstack)
> +{
> +	return idstack->cnt > 0 ? idstack->ids[--idstack->cnt] : 0;
> +}
> +
> +static int release_reg_check(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +			     int id, int root_id, struct bpf_idstack *idstack)
>  {
> +	struct bpf_reference_state *ref_state;
> +
> +	if (reg->id == id || reg->parent_id == id || reg->ref_obj_id == id) {
> +		/* Cannot indirectly release a referenced id */
> +		if (reg->ref_obj_id && id != root_id) {
> +			ref_state = find_reference_state(env->cur_state, reg->ref_obj_id);
> +			verbose(env, "Unreleased reference id=%d alloc_insn=%d when releasing id=%d\n",
> +				ref_state->id, ref_state->insn_idx, root_id);
> +			return -EINVAL;
> +		}
> +
> +		if (reg->id && reg->id != id)
> +			idstack_push(idstack, reg->id);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int release_reference(struct bpf_verifier_env *env, int id)
> +{
> +	struct bpf_idstack *idstack = &env->idstack_scratch;
>  	struct bpf_verifier_state *vstate = env->cur_state;
> +	int spi, fi, root_id = id, err = 0;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> -	int err;
>  
> -	err = release_reference_nomark(vstate, ref_obj_id);
> -	if (err)
> -		return err;
> +	idstack_reset(idstack);
> +	idstack_push(idstack, id);
>  
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->ref_obj_id == ref_obj_id)
> -			mark_reg_invalid(env, reg);
> -	}));
> +	if (find_reference_state(vstate, id))
> +		WARN_ON_ONCE(release_reference_nomark(vstate, id));
> +
> +	while ((id = idstack_pop(idstack))) {
> +		bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> +			err = release_reg_check(env, reg, id, root_id, idstack);
> +			if (err < 0)
> +				return err;
> +			if (err == 1)
> +				mark_reg_invalid(env, reg);
> +		}));
> +
> +		for (fi = 0; fi <= vstate->curframe; fi++) {
> +			state = vstate->frame[fi];
> +			bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
> +				if (!reg || !reg->dynptr.first_slot)
> +					continue;
> +				err = release_reg_check(env, reg, id, root_id, idstack);
> +				if (err < 0)
> +					return err;
> +				if (err == 1)
> +					invalidate_dynptr(env, state, spi);
> +			}
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -11643,11 +11661,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			 */
>  			err = 0;
>  		}
> -		if (err) {
> -			verbose(env, "func %s#%d reference has not been acquired before\n",
> -				func_id_name(func_id), func_id);
> +		if (err)
>  			return err;
> -		}
>  	}
>  
>  	switch (func_id) {
> @@ -11925,10 +11940,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		regs[BPF_REG_0].ref_obj_id = id;
>  	}
>  
> -	if (func_id == BPF_FUNC_dynptr_data) {
> -		regs[BPF_REG_0].dynptr_id = meta.initialized_dynptr.id;
> -		regs[BPF_REG_0].ref_obj_id = meta.initialized_dynptr.ref_obj_id;
> -	}
> +	if (func_id == BPF_FUNC_dynptr_data)
> +		regs[BPF_REG_0].parent_id = meta.initialized_dynptr.id;
>  
>  	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
>  	if (err)
> @@ -13295,6 +13308,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				return -EFAULT;
>  			}
>  			meta->ref_obj_id = reg->ref_obj_id;
> +			meta->id = reg->id;
>  			if (is_kfunc_release(meta))
>  				meta->release_regno = regno;
>  		}
> @@ -13429,7 +13443,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_DYNPTR:
>  		{
>  			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
> -			int clone_ref_obj_id = 0;
>  
>  			if (is_kfunc_arg_const_ptr(btf, &args[i]))
>  				dynptr_arg_type |= MEM_RDONLY;
> @@ -13458,14 +13471,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				}
>  
>  				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
> -				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
> -				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
> -					verifier_bug(env, "missing ref obj id for parent of clone");
> -					return -EFAULT;
> -				}
>  			}
>  
> -			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id,
> +			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type,
> +						  meta->ref_obj_id ? meta->id : 0,
>  						  &meta->initialized_dynptr);
>  			if (ret < 0)
>  				return ret;
> @@ -13913,12 +13922,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
>  			verifier_bug(env, "no dynptr id");
>  			return -EFAULT;
>  		}
> -		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
> -
> -		/* we don't need to set BPF_REG_0's ref obj id
> -		 * because packet slices are not refcounted (see
> -		 * dynptr_type_refcounted)
> -		 */
> +		regs[BPF_REG_0].parent_id = meta->initialized_dynptr.id;
>  	} else {
>  		return 0;
>  	}
> @@ -14113,9 +14117,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			err = unmark_stack_slots_dynptr(env, reg);
>  		} else {
>  			err = release_reference(env, reg->ref_obj_id);
> -			if (err)
> -				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
> -					func_name, meta.func_id);
>  		}
>  		if (err)
>  			return err;
> @@ -14134,7 +14135,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			return err;
>  		}
>  
> -		err = release_reference(env, release_ref_obj_id);
> +		err = release_reference_nomark(env->cur_state, release_ref_obj_id);
>  		if (err) {
>  			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
>  				func_name, meta.func_id);
> @@ -14225,7 +14226,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  			/* Ensures we don't access the memory after a release_reference() */
>  			if (meta.ref_obj_id)
> -				regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> +				regs[BPF_REG_0].parent_id = meta.ref_obj_id;
>  
>  			if (is_kfunc_rcu_protected(&meta))
>  				regs[BPF_REG_0].type |= MEM_RCU;
> @@ -19575,7 +19576,8 @@ static bool regs_exact(const struct bpf_reg_state *rold,
>  {
>  	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>  	       check_ids(rold->id, rcur->id, idmap) &&
> -	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> +	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> +	       check_ids(rold->parent_id, rcur->parent_id, idmap);
>  }
>  
>  enum exact_level {
> @@ -19697,7 +19699,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		       range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off) &&
>  		       check_ids(rold->id, rcur->id, idmap) &&
> -		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> +		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
> +		       check_ids(rold->parent_id, rcur->parent_id, idmap);
>  	case PTR_TO_PACKET_META:
>  	case PTR_TO_PACKET:
>  		/* We must have at least as much range as the old ptr
> @@ -19852,7 +19855,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>  			cur_reg = &cur->stack[spi].spilled_ptr;
>  			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
>  			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
> -			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
> +			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
> +			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
>  				return false;
>  			break;
>  		case STACK_ITER:
> -- 
> 2.47.3

