Return-Path: <netdev+bounces-286932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE6JDF6QAmryuQEAu9opvQ
	(envelope-from <netdev+bounces-286932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF25518F44
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44BBB301CFE9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3F35837E;
	Tue, 12 May 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozeWx6tb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708335F5E1
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552924; cv=none; b=OcELbAn9cfkW/lu/jnYjzGQezveuA2RbWWVE28XrI/6cgKuNN/I7o3y4ZW1kwcfkD49+sSHAjjimP0PT8Z7mNnta7pZaPmKEnDgYBie66mqnnXFVGhzKWHzWJ6xcBxLle2IMD0dRrXgeBM/spMkY8c5OOawLsNuRhHFHLpGnhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552924; c=relaxed/simple;
	bh=yvgC1FnjjoMtlutF/hjAmwuqu5sE1LUXUBLSbX5eXkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MpKgdn8KMDCA6cNbYNQG1rOr44HBk7FzBQ5PqEzmpsyxakCt1z/zgaU6ocqbNLDODpJGpTNx6XawV0hUvGCVblMmKfb8jDCChfIMm0mtc2/TwHgMX7AksVmE7GeoVZ69nymJlMN+N7f9KcmOomBxKZcYYXpDOXnP5Rc4zVUjc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozeWx6tb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bab82d75fdso27075005ad.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778552922; x=1779157722; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ayM4rO9yjDKyVwkABXp8ERuvhdOetbMp4rrjg9pQj5Q=;
        b=ozeWx6tbkXLcXIXkt7N7Z5A8bcCXA3SUMOp+qpgBewVA1HwMxRQE1C4QSZNXmKeDMF
         vzESa6GkBpNEDAhvpj7M7QCGUYVSVyoKnb4g9NW01qLpABlE/3Mq08KeqRw+wIMC4lQD
         MfLP/MZ9wxkXQk59xsg89Nt/qalGM/w1mvHbmXYWGIyX5kQkieLz4UsV3qMhUXm1GlMp
         gUEtTHEHE99qFJVvjZYiyx7hzrqM3j8xmDbiNB42xpeAsItL7Xqm40mxy+1f4cmkj7Zl
         8+Bi7uugpU2/Go5zR3uXZgb3SB5LW7YFKQGwrC9IbUOwofQoMASTS7eV7I96jfY+tn0+
         As0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778552922; x=1779157722;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ayM4rO9yjDKyVwkABXp8ERuvhdOetbMp4rrjg9pQj5Q=;
        b=dCimZI8WpYQtNoOMf/h1CDGSzRaJNPscX3SXCKPnrEGs44zkx5Za77f+58uPb+Z+PY
         Lamz8yNBVuLUfUMdllB09HHZsqFuPPjIztUXI0thLmXhV1Bora5prVUn5cXPfNYGGITS
         dzytQuMHvbQiTKacMBgEPqhn8Q4rHYZGsc77NG9D3WM6KKu374nWksbicOj/WyMdSNZJ
         smIeVxA3pMjET6xayh72gMuhJPKQEWpVLWdUNE2CC0z96TdCsgOEiqTOCu/9rQhNC8H+
         0iMLRSRa+zPp/dcL3F2AUTImozluKTClErnmpxGaC4tgVdR6sIk32nicSqAUJloNpq2q
         l4BA==
X-Gm-Message-State: AOJu0YzIh6l6hXCR8d7KC2aDIkcT52t5x/XsScrF4Hrp9qhtqzpJmXzE
	EVneic5y1zwq33lGGuwiVLYotMg9P8DsNbn9Dxq6QEN+iYDcc4++STlx
X-Gm-Gg: Acq92OESWyCrz9NoVdPEJdJFDCyHuDesaEJ1JHoGHREfMEx8jlTi1YdJocDjO27pnE1
	9yC45ccMt1B+rS6yvEJk4pNcm18jx7QTpdeh0LTTDvQK6ONdh8c2x1mux6Y1u4BENUXvUlvwrf0
	dgARvHhhq8qa4C4dPZx54Hwf2n4i8kGtP3Dq40aIjx5LtVa2QOuj96M5YDhvu5fOGyv7rN6+xMq
	7BU6VRczCCRl+HWjKMMzxP86A299zZNCRe61rUVoWHtjxILYROQvA99oj6YF4i6AEUg4cofb+1n
	7Dr+vCvf3d6JzpTxVBh3jyvL5Pd0pNem6k4Oev1AYstKcu9iz+XsoKbhw8pHCjf61EbCtsTDib3
	eLt5Mmn3efXRVCwnAiXDeVc6scttnqR2kANbybvKwavc7w0NP/bV+pqX259hBa6T0lj2pgi4DjH
	Wq6lDhwCQE3d1b/2Vao7cWDqtsTjdae1PEnPEsr+2UnUgWQKtIFn9H
X-Received: by 2002:a17:903:196d:b0:2b9:ecb4:a3dd with SMTP id d9443c01a7336-2bc7ac55031mr122095205ad.34.1778552919943;
        Mon, 11 May 2026 19:28:39 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e8df57sm120681275ad.64.2026.05.11.19.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:28:39 -0700 (PDT)
Message-ID: <ae5f8053bfc94fb02abdf78d5a452a7baae5c35e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 19:28:06 -0700
In-Reply-To: <20260506142709.2298255-6-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-6-ameryhung@gmail.com>
Content-Type: multipart/mixed; boundary="=-Pv11CFF05eTOwbwEw9lY"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9AF25518F44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286932-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--=-Pv11CFF05eTOwbwEw9lY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:

[...]

> +/* Release id and objects referencing the id iteratively in a DFS manner=
 */
> +static int release_reference(struct bpf_verifier_env *env, int id)
> +{
> +	u32 mask =3D (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
>  	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	struct bpf_idmap *idstack =3D &env->idmap_scratch;
> +	struct bpf_stack_state *stack;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> -	int err;
> +	int root_id =3D id, err;
> =20
> -	err =3D release_reference_nomark(vstate, ref_obj_id);
> -	if (err)
> -		return err;
> +	idstack->cnt =3D 0;
> +	idstack_push(idstack, id);
> =20
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->ref_obj_id =3D=3D ref_obj_id)
> -			mark_reg_invalid(env, reg);
> -	}));
> +	if (find_reference_state(vstate, id))
> +		WARN_ON_ONCE(release_reference_nomark(vstate, id));
> +
> +	while ((id =3D idstack_pop(idstack))) {
> +		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
> +			int ref_obj_cnt =3D 1;
> +
> +			if (reg->id !=3D id && reg->parent_id !=3D id && reg->ref_obj_id !=3D=
 id)
> +				continue;
> +
> +			/*
> +			 * A referenced dynptr can be overwritten only if there is at
> +			 * least one other dynptr sharing the same ref_obj_id,
> +			 * ensuring the reference can still be properly released.
> +			 */
> +			if (stack && stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_DYNPTR &=
&
> +			    dynptr_type_referenced(reg->dynptr.type))
> +				ref_obj_cnt =3D dynptr_get_refcnt(state, reg->ref_obj_id);

Note that dynptr_get_refcnt() only looks for objects in the state's frame,
dynptrs in other frames are ignored. This can lead to false rejections,
as in the attached test cases, which verifier refuses to load with the
following error message:

; *(volatile __u8 *)&clone =3D 0; @ dynptr_fail.c:2160
19: (73) *(u8 *)(r10 -16) =3D r1
Leaking reference id=3D2 alloc_insn=3D7. Release it first.
processed 14 insns (limit 1000000) max_states_per_insn 1 total_states 1 pea=
k_states 1 mark_read 0

> +
> +			if (reg->ref_obj_id && reg->ref_obj_id !=3D root_id && ref_obj_cnt <=
=3D 1) {
> +				struct bpf_reference_state *ref_state;
> +
> +				ref_state =3D find_reference_state(env->cur_state, reg->ref_obj_id);
> +				verbose(env, "Leaking reference id=3D%d alloc_insn=3D%d. Release it =
first.\n",
> +					ref_state->id, ref_state->insn_idx);
> +				return -EINVAL;
> +			}
> +
> +			/* Free objects derived from the current object */
> +			if (reg->id !=3D id) {
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
> =20
>  	return 0;
>  }

[...]

--=-Pv11CFF05eTOwbwEw9lY
Content-Disposition: attachment; filename="false-positivie-test.patch"
Content-Type: text/x-patch; name="false-positivie-test.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy9keW5wdHJfZmFp
bC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2R5bnB0cl9mYWlsLmMKaW5k
ZXggMzE5NjIyMzNiZWExLi5lMzA4YjA0MDk1MzAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9ncy9keW5wdHJfZmFpbC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9ncy9keW5wdHJfZmFpbC5jCkBAIC0yMTUwLDMgKzIxNTAsMzMgQEAgaW50
IGR5bnB0cl9vdmVyd3JpdGVfcmVmX2Nsb25lX3NsaWNlX3ZhbGlkKHZvaWQgKmN0eCkKIAogCXJl
dHVybiAwOwogfQorCitzdGF0aWMgX19ub2lubGluZSB2b2lkIG92ZXJ3cml0ZV9jbG9uZV9pbl9j
YWxsZWUoc3RydWN0IGJwZl9keW5wdHIgKnBhcmVudCkKK3sKKwlzdHJ1Y3QgYnBmX2R5bnB0ciBj
bG9uZTsKKworCWJwZl9keW5wdHJfY2xvbmUocGFyZW50LCAmY2xvbmUpOworCS8qIE92ZXJ3cml0
ZSB0aGUgY2xvbmUgLSBwYXJlbnQgaW4gY2FsbGVyIGZyYW1lIHN0aWxsIGhvbGRzIHRoZSByZWYg
Ki8KKwkqKHZvbGF0aWxlIF9fdTggKikmY2xvbmUgPSAwOworfQorCisvKgorICogT3ZlcndyaXRp
bmcgYSBjbG9uZSBpbiBhIGNhbGxlZSBmcmFtZSBzaG91bGQgYmUgYWxsb3dlZCB3aGVuIHRoZSBw
YXJlbnQKKyAqIGluIHRoZSBjYWxsZXIgZnJhbWUgc3RpbGwgaG9sZHMgdGhlIHJlZi4gZHlucHRy
X2dldF9yZWZjbnQoKSBjdXJyZW50bHkKKyAqIG9ubHkgY291bnRzIGR5bnB0cnMgaW4gdGhlIGN1
cnJlbnQgZnJhbWUsIG1pc3NpbmcgdGhlIHBhcmVudCBpbiB0aGUKKyAqIGNhbGxlciBmcmFtZS4K
KyAqLworU0VDKCI/cmF3X3RwIikKK19fc3VjY2VzcworaW50IGR5bnB0cl9vdmVyd3JpdGVfY2xv
bmVfY3Jvc3NfZnJhbWUodm9pZCAqY3R4KQoreworCXN0cnVjdCBicGZfZHlucHRyIHB0cjsKKwor
CWJwZl9yaW5nYnVmX3Jlc2VydmVfZHlucHRyKCZyaW5nYnVmLCA2NCwgMCwgJnB0cik7CisKKwlv
dmVyd3JpdGVfY2xvbmVfaW5fY2FsbGVlKCZwdHIpOworCisJYnBmX3JpbmdidWZfZGlzY2FyZF9k
eW5wdHIoJnB0ciwgMCk7CisKKwlyZXR1cm4gMDsKK30K


--=-Pv11CFF05eTOwbwEw9lY--

