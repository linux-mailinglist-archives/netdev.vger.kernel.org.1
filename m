Return-Path: <netdev+bounces-266667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O0DLCuBsWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228D265B92
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35E9630A5CD5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA83D6462;
	Wed, 11 Mar 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzdMeCjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635A3D5236
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240468; cv=none; b=pg6YUPHJnRBS0XHQ2I8PB6Xw7bDIa16Y1cz1zBQDf1IcmAbQ8m20zNhUU3pKKHw3vB3sGsY++oqtFI3/T9MGVtHl+MTA9m8aW6ehrarCK3keFz7swBNKGlSM290W9UsF2nF5+2Hu0rNz4CiFVB7ly9VCXTczIvnu7z5cHgsmunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240468; c=relaxed/simple;
	bh=M0M513xG9QJd0xlU03Fihqwn8kUOVJm+JuiFoPZVfPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VTDGghdsri0EgqOfF9evOgar+/qN631wwZyghvUgjv1YOHubvwzaIS50Iea+7R0pH4VOUOQe1Y1BbqDs1d8cZFWhB6z+oN17xqvj+f6hNiRHZ0fRdaaOrkWwREyrYBuNqwTXnkdDbPOEe0byAfMphgHz17hmBpH/rPFI85rZq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzdMeCjd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b6d9c981so1053f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773240463; x=1773845263; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OcgCVoXpwmk9jK46IQdFKL4LgjvcP8o4RT8R4WmikQ=;
        b=RzdMeCjdRBSLy/nEidWIdmWX33QoHiOoIBtG5yCc/W+1jKl2zPJPmBaqytW0Ji4ywh
         MXKN8XSrFkqiGXwnD6QzghV39GTDYMM0svwQmybhpsBAV4GbdBrWYV26fhE0A56bh2AM
         MZRXlN2aASCvMT1bf20MJtnFrKsYCVVugHngRNg+1Fxz5sDu/c72/bsnEBZACTw4HyTg
         lmBmzBBwCYy0dw3Rc9wHWPJutVBK/CAl25K4el7kT5x9cbCZefSi2eqjQC4P7igRrLO9
         Fl4F7vwhWfsCysxv8Yjn+VR5sVDGZr6E0qt97SsGlBwI08UhKScvs2s3xPONZ7WK6ctK
         4I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240463; x=1773845263;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OcgCVoXpwmk9jK46IQdFKL4LgjvcP8o4RT8R4WmikQ=;
        b=GlnMIMbRTKyrrUzVoq3LSks4atUBIzt5JZkswYoIIBH7G4lmP2zn4e5rjc+ZBG4x10
         4NQ79I82nTe/Hwxh0yvrMr7tNvyIgd3SDvC4H6dFBh4xHpGpr4aCbBnSh2bnnnjsjoGQ
         46vDYAJaDp37XXLQNH0hLW8lKBJ6duC6HpZZuCbtN4jLoK7f4VzS88NSqynYaU4Pn/OW
         9uHn9YgTMaLI/vT662QGhn703fVPrVd2yo4lmNjMD8kPDLzW7ebbG/+AAK1CVRfWPE4t
         uI2Oq0vGajpgP92EnFrSbni0hSXm9ujSLpzSZUlfTC+VPHoC+zPKFDDmunKACkBJHSnU
         Q7lg==
X-Gm-Message-State: AOJu0Ywg62Z4l+JAvxRKqOTEeo4kRFrJSal74agyulf/iF+sQQWQLbcd
	+Nx4CgibaJYCGbtbbrkD/2z6Y9g5yEYaoNi83JAZq8zSjJ1pxq/AJFqS
X-Gm-Gg: ATEYQzw7RgMxR3SNijxbTM90qSEsME7QlL6HmbfDqzXSULMsVerpWmh7VXJsGq2D/WQ
	Uofw630TWZJYQb/QJdi9OkfqJOJZnu8IhEQdexFGitmhs6sHCqcJe01Y4cqwbC1kWDOSnVI3vN/
	cap/spBgKlwozEH5uGjHRCpNz9sIY9fSCKllDnuU1nrn9e7cXSRp1p2TrYo0C58K50ytYgWMg04
	L3r7pjAfclggkkdRlUn1OHcxjXgZCX3UQ0dTMtt+4PLwuDtFUG7+PUjjb+FtzHfrzplXHjrvNew
	G+abZ4qkJevh2ibj8ryb28HCbhS1p7Fc5I1SmAUhlAQm+5broLIT5G+IqH8lNWx3EqmApt/5KA/
	lhjbfob1vJKyREDM2dFznpDYr8aKxUclFLtsgSEsqduU/37/59M9WM3zLa0D55t6IceTKu0KZ49
	WT1XGGgCFdlrS3bHWhaOoEbwfNhW5v2uTl/h4Ciw==
X-Received: by 2002:a05:6000:2dc1:b0:439:936b:c006 with SMTP id ffacd0b85a97d-439eff5ecebmr13646536f8f.20.1773240463156;
        Wed, 11 Mar 2026 07:47:43 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a0480sm7127501f8f.12.2026.03.11.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:47:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type
 flag based on prototype
In-Reply-To: <20260307064439.3247440-2-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
 <20260307064439.3247440-2-ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 14:47:42 +0000
Message-ID: <87o6kutoc1.fsf@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-266667-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3228D265B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Amery Hung <ameryhung@gmail.com> writes:

> The verifier should decide whether a dynptr argument is read-only
> based on if the type is "const struct bpf_dynptr *", not the type of
> the register passed to the kfunc. This currently does not cause issues
> because existing kfuncs that mutate struct bpf_dynptr are constructors
> (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> additional check in process_dynptr_func() to make sure the stack slot
> does not contain initialized dynptr. Nonetheless, this should still be
> fixed to avoid future issues when there is a non-constructor dynptr
> kfunc that can mutate dynptr. This is also a small step toward unifying
> kfunc and helper handling in the verifier, where the first step is to
> generate kfunc prototype similar to bpf_func_proto before the main
> verification loop.
>
> We also need to correctly mark some kfunc arguments as "const struct
> bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> argument and to not break their usage. Adding const qualifier does
> not break backward compatibility.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  fs/verity/measure.c                            |  2 +-
>  include/linux/bpf.h                            |  8 ++++----
>  kernel/bpf/helpers.c                           | 10 +++++-----
>  kernel/bpf/verifier.c                          | 18 +++++++++++++++++-
>  kernel/trace/bpf_trace.c                       | 18 +++++++++---------
>  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
>  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
>  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
>  8 files changed, 43 insertions(+), 32 deletions(-)
>
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index 6a35623ebdf0..3840436e4510 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
>   *
>   * Return: 0 on success, a negative value on error.
>   */
> -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_p)
> +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynptr *digest_p)
>  {
>  	struct bpf_dynptr_kern *digest_ptr = (struct bpf_dynptr_kern *)digest_p;
>  	const struct inode *inode = file_inode(file);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b78b53198a2e..946a37b951f7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3621,8 +3621,8 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
>  struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
>  struct bpf_key *bpf_lookup_system_key(u64 id);
>  void bpf_key_put(struct bpf_key *bkey);
> -int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> -			       struct bpf_dynptr *sig_p,
> +int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> +			       const struct bpf_dynptr *sig_p,
>  			       struct bpf_key *trusted_keyring);
>  
>  #else
> @@ -3640,8 +3640,8 @@ static inline void bpf_key_put(struct bpf_key *bkey)
>  {
>  }
>  
> -static inline int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> -					     struct bpf_dynptr *sig_p,
> +static inline int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> +					     const struct bpf_dynptr *sig_p,
>  					     struct bpf_key *trusted_keyring)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6eb6c82ed2ee..3d44896587ac 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
>   * Copies data from source dynptr to destination dynptr.
>   * Returns 0 on success; negative error, otherwise.
>   */
> -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
> -				struct bpf_dynptr *src_ptr, u64 src_off, u64 size)
> +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
> +				const struct bpf_dynptr *src_ptr, u64 src_off, u64 size)
>  {
>  	struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
>  	struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
> @@ -3055,7 +3055,7 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
>   * at @offset with the constant byte @val.
>   * Returns 0 on success; negative error, otherwise.
>   */
> -__bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u64 offset, u64 size, u8 val)
> +__bpf_kfunc int bpf_dynptr_memset(const struct bpf_dynptr *p, u64 offset, u64 size, u8 val)
>  {
>  	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
>  	u64 chunk_sz, write_off;
> @@ -4069,8 +4069,8 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
>   *
>   * Return: 0 on success, a negative value on error.
>   */
> -__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> -			       struct bpf_dynptr *sig_p,
> +__bpf_kfunc int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> +			       const struct bpf_dynptr *sig_p,
>  			       struct bpf_key *trusted_keyring)
>  {
>  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1153a828ce8d..0f77c4c5b510 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12276,6 +12276,22 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf, const struct btf_param *a
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_DYNPTR_ID);
>  }
>  
> +static bool is_kfunc_arg_const_ptr(const struct btf *btf, const struct btf_param *arg)
> +{
> +	const struct btf_type *t, *resolved_t;
> +
> +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	if (!t || !btf_type_is_ptr(t))
> +		return false;
> +
> +	resolved_t = btf_type_skip_modifiers(btf, t->type, NULL);
nit: t is ptr type, maybe we can do t = btf_type_by_id(btf, t->type)
before the loop starts, as we know the result of the first iteration.
> +	for (; t != resolved_t; t = btf_type_by_id(btf, t->type))
> +		if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
nit: btf_kind() is a bit shorter than BTF_KIND_INFO()
> +			return true;
> +
> +	return false;
> +}
The logic in this function looks correct to me. The refactoring makes
sense as well (although I'm not 100% sure how this is relevant to this
patch series)
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> +
>  static bool is_kfunc_arg_list_head(const struct btf *btf, const struct btf_param *arg)
>  {
>  	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_HEAD_ID);
> @@ -13509,7 +13525,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
>  			int clone_ref_obj_id = 0;
>  
> -			if (reg->type == CONST_PTR_TO_DYNPTR)
> +			if (is_kfunc_arg_const_ptr(btf, &args[i]))
>  				dynptr_arg_type |= MEM_RDONLY;
>  
>  			if (is_kfunc_arg_uninit(btf, &args[i]))
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9bc0dfd235af..127c317376be 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3391,7 +3391,7 @@ typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struc
>   * direct calls into all the specific callback implementations
>   * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
>   */
> -static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u64 doff, u64 size,
> +static __always_inline int __bpf_dynptr_copy_str(const struct bpf_dynptr *dptr, u64 doff, u64 size,
>  						 const void *unsafe_src,
>  						 copy_fn_t str_copy_fn,
>  						 struct task_struct *tsk)
> @@ -3533,49 +3533,49 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
>  	return bpf_send_signal_common(sig, type, task, value);
>  }
>  
> -__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  					   u64 size, const void __user *unsafe_ptr__ign)
>  {
>  	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>  				 copy_user_data_nofault, NULL);
>  }
>  
> -__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  					     u64 size, const void *unsafe_ptr__ign)
>  {
>  	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
>  				 copy_kernel_data_nofault, NULL);
>  }
>  
> -__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_user_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  					       u64 size, const void __user *unsafe_ptr__ign)
>  {
>  	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>  				     copy_user_str_nofault, NULL);
>  }
>  
> -__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  						 u64 size, const void *unsafe_ptr__ign)
>  {
>  	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
>  				     copy_kernel_str_nofault, NULL);
>  }
>  
> -__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  					  u64 size, const void __user *unsafe_ptr__ign)
>  {
>  	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>  				 copy_user_data_sleepable, NULL);
>  }
>  
> -__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  					      u64 size, const void __user *unsafe_ptr__ign)
>  {
>  	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
>  				     copy_user_str_sleepable, NULL);
>  }
>  
> -__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_task_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  					       u64 size, const void __user *unsafe_ptr__ign,
>  					       struct task_struct *tsk)
>  {
> @@ -3583,7 +3583,7 @@ __bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
>  				 copy_user_data_sleepable, tsk);
>  }
>  
> -__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64 off,
> +__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
>  						   u64 size, const void __user *unsafe_ptr__ign,
>  						   struct task_struct *tsk)
>  {
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> index 7dad01439391..ffb9bc1cace0 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -70,13 +70,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
>  
>  extern int bpf_get_file_xattr(struct file *file, const char *name,
>  			      struct bpf_dynptr *value_ptr) __ksym;
> -extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_ptr) __ksym;
> +extern int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynptr *digest_ptr) __ksym;
>  
>  extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __ksym;
>  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
>  extern void bpf_key_put(struct bpf_key *key) __ksym;
> -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> -				      struct bpf_dynptr *sig_ptr,
> +extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_ptr,
> +				      const struct bpf_dynptr *sig_ptr,
>  				      struct bpf_key *trusted_keyring) __ksym;
>  
>  struct dentry;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index e0d672d93adf..e0745b6e467e 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -914,7 +914,7 @@ void *user_ptr;
>  char expected_str[384];
>  __u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
>  
> -typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u64 off,
> +typedef int (*bpf_read_dynptr_fn_t)(const struct bpf_dynptr *dptr, u64 off,
>  				    u64 size, const void *unsafe_ptr);
>  
>  /* Returns the offset just before the end of the maximum sized xdp fragment.
> @@ -1106,7 +1106,7 @@ int test_copy_from_user_str_dynptr(void *ctx)
>  	return 0;
>  }
>  
> -static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
> +static int bpf_copy_data_from_user_task(const struct bpf_dynptr *dptr, u64 off,
>  					u64 size, const void *unsafe_ptr)
>  {
>  	struct task_struct *task = bpf_get_current_task_btf();
> @@ -1114,7 +1114,7 @@ static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
>  	return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr, task);
>  }
>  
> -static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u64 off,
> +static int bpf_copy_data_from_user_task_str(const struct bpf_dynptr *dptr, u64 off,
>  					    u64 size, const void *unsafe_ptr)
>  {
>  	struct task_struct *task = bpf_get_current_task_btf();
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index d249113ed657..c3631fd41977 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -11,12 +11,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
> -
> -extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> -extern void bpf_key_put(struct bpf_key *key) __ksym;
> -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> -				      struct bpf_dynptr *sig_ptr,
> -				      struct bpf_key *trusted_keyring) __ksym;
> +#include "bpf_kfuncs.h"
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_RINGBUF);
> -- 
> 2.47.3

