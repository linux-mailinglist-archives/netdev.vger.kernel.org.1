Return-Path: <netdev+bounces-307264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z9SSFfs1VWrzlQAAu9opvQ
	(envelope-from <netdev+bounces-307264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:01:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE674EA19
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b="Su0MyR4/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307264-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307264-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C3D73042271
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F8A2E8DEB;
	Mon, 13 Jul 2026 19:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BA28DC4
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 19:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969272; cv=none; b=VuY6aufBnsk9sZ/c8KaF3+IQyyiPHSfBjvJXelgfM2gHRwSUEdd4MIgKG6x0SMWjB2tbx4+4Oe7RQeQb1kiGdEu0m9SVOKsvxXaQukf6FgO6yWk62XNqXhatFpEu0AvPqS8thNmlPPiFor1Z5EG9hJOiD+Cx2sj9WMJOFqLaMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969272; c=relaxed/simple;
	bh=keB0QlMp0KvxU7I46dLXT8uUdep8rMfKLdyK7+9q1IA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NmHy7OWiICFZfG5Dno4Z9ea3/WsUb4JNNYg8uLjMDwbk+7JuA8ZXLX0rftQcSi7LH8LE5XE2fmXw7MOEPUJzONY5f1jjyq9mP7LqNWXCIgGahNTumJDQSXJNo5bKNs+ZZPS8ghSxKcWGK6nrgdYV+DPDerOYtPB//bU8N8+dcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Su0MyR4/; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e08baf860so953110a91.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783969270; x=1784574070; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VJARKbZxQw+5xLSwPuHaI/jl5Lgqh19eFRVAg6BGDE0=;
        b=Su0MyR4/Td1dbX30PfVtcVJlega3yJRbvdpYlT9DAaoMEP9UhmTAs12DRzMcN18dLW
         imF/vnKnS+CRq8jQ+sZkDa1DrGG886SVJon4B8hCX1o+QSz1gEeo2yKWKd/gsFWGXofa
         6/VBwdo3Gj1ovzmYjGaxFix38XOcqStBBkcBBcZT4pg4VuzJ4e3OWqiyoq5Kbe/ZsW8d
         LeuBvUa6x9UEUAl5Rb2XptfmSqlUBbZ4wHPRMAgTwSZLNfggAFQWP2O5SfhON+sGU27L
         lLKzgXKKuj3LKnTXXSkV02z4+o40OkXYLa8CgTuC++HM9UnbDsv27MZpQxm3KZleqW+i
         lhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969270; x=1784574070;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJARKbZxQw+5xLSwPuHaI/jl5Lgqh19eFRVAg6BGDE0=;
        b=CEbwsTkKQ14yegcwQeIzzJfryBM2GvPrghD+I6yau7UAKb24b6SFxEtNUCr0PjxXws
         WU11BRRd7EC+ExStRKDRLJ5/7Ni0fsogL/hg7Rb3AGhVYqD6B9YZbxY2BJbZqzZUMeRt
         K/P8yDlepfjxzF43AydroG2M2/T79qzQrliL4tsjhyGDl1hSFUWicUnsGhpfmc0P2Uvu
         07u0Q/Ho53r01UPyxxcMGS7lkMot1hUy8g2lM6XAdS8l2/YetTtnQtSSAEfZA+elnFou
         5iTtOdofqQue8Cm5zMPGHTBWXfCGlJwCtOQuCFtei1yjQSR4D25X+mW5q+jXK8PTGnpu
         77Eg==
X-Gm-Message-State: AOJu0YxKaecUKEOdVUuj2EVYZAxLuLZk3XdEdYVHiP0sU1Ux44fvXvXH
	qbYzPXOTkXDbTWWQRyHU/cA1x8sa7I/nKATWJl60TXr4VoEhxxi4+0/PczBs6iK4VTHucICpwsO
	ZB1P6LiI=
X-Gm-Gg: AfdE7cmoamXh1OaTDCyFOVzOoETdzKa2U8v0K8RN/J4bZdoEIDEVLX1GAZpvbvRhCPN
	0OiOwSGfulNi7YkBEXkuLIgU6NPzaF3q+a/+k+BsN2Jxqxp93oWhyvyiGYE1tJpk96bmiXb0hgJ
	FRISpR17u8Z245zyiFNkuzAuITKS97nwAXffjLLz2dPrY8gcbSfhtEX+7e2eBGaXK/Dht6kDJNf
	FNx4vgh/fsmIaI+1gFrsEUK513wmTaKGzbGNqCjEW+XoFe2d/xmgt2Fis2YHIEv371N9pNPoHE7
	bJ57ajMQ5Qy2yaja5MUadsdBoocY4dMw0cot7YWtlUJUCyHaw4IfZikUI5Fuzf/88r0okfjbo0i
	Qj3B/MOw5zH8OlXiGHhUmuyyeyH9A6a2Imf8d2zle+U1BvZ2lrCHmuSJ49Ybc12eSckeSA3hiIT
	sROGilEVj0SUrd/R5qOcHSavZ8WmLeP3Shm66k3qfc5w==
X-Received: by 2002:a17:90b:554d:b0:381:cef1:11b0 with SMTP id 98e67ed59e1d1-38dc77a4517mr9473576a91.33.1783969269613;
        Mon, 13 Jul 2026 12:01:09 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38deea72fc3sm1146162a91.2.2026.07.13.12.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 15:01:08 -0400
Message-Id: <DJXOBRV3S89L.3OLMFO3UY0WS8@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 02/15] bpf: Make struct_ops tasks_rcu grace
 period optional
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-3-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-3-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60BE674EA19

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf_struct_ops_map_free() currently waits for both a regular RCU grace
> period and a tasks RCU grace period for every struct_ops map through
> synchronize_rcu_mult(call_rcu, call_rcu_tasks).
>
> A regular RCU grace period is still required for all struct_ops maps
> because the struct_ops trampoline ksyms requires a rcu grace period
> (take a look at the list_del_rcu in __bpf_ksym_del).
> Add a map_free_pre_rcu() callback so the struct_ops map can remove
> ksyms before bpf_map_put() wait for the regular rcu grace period.
>
> The tasks RCU grace period is only needed by tcp_congestion_ops.
> Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
> of the bpf_map.
>
> When CONFIG_TASKS_RCU=3Dn, synchronize_rcu_tasks() is the same as
> synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
> grace period before bpf_struct_ops_map_free() runs, skip the extra
> synchronize_rcu_tasks() call in this case.
>
> This cleanup prepares for a later patch that needs to support
> free_after_mult_rcu_gp.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The Sashiko issue looks spurious to me. bpf_prog_dissoc_progs() is not
related to the availability of the struct_ops methods. It is valid for
it to be after the end of the grace period.

> ---
>  include/linux/bpf.h         |  7 +++++++
>  kernel/bpf/bpf_struct_ops.c | 31 +++++++++++++------------------
>  kernel/bpf/syscall.c        |  3 +++
>  net/ipv4/bpf_tcp_ca.c       | 16 ++++++++++++++++
>  4 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..7ac8873839f4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -90,6 +90,7 @@ struct bpf_map_ops {
>  	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
>  	void (*map_release)(struct bpf_map *map, struct file *map_file);
>  	void (*map_free)(struct bpf_map *map);
> +	void (*map_free_pre_rcu)(struct bpf_map *map);
>  	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key)=
;
>  	void (*map_release_uref)(struct bpf_map *map);
>  	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
> @@ -2099,6 +2100,11 @@ struct btf_member;
>   *	   unloaded while in use.
>   * @name: The name of the struct bpf_struct_ops object.
>   * @func_models: Func models
> + * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to wai=
t for
> + *                           a tasks_rcu gp before freeing the struct_op=
s map
> + *                           and its progs. It is unnecessary if the @un=
reg
> + *                           has waited for the correct rcu gp or the @u=
nreg
> + *                           has ensured all struct_ops prog has finishe=
d running.
>   */
>  struct bpf_struct_ops {
>  	const struct bpf_verifier_ops *verifier_ops;
> @@ -2117,6 +2123,7 @@ struct bpf_struct_ops {
>  	struct module *owner;
>  	const char *name;
>  	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
> +	bool free_after_tasks_rcu_gp;
>  };
> =20
>  /* Every member of a struct_ops type has an instance even a member is no=
t
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index d06b3d9bcc13..c422ce41873e 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -984,9 +984,18 @@ static void __bpf_struct_ops_map_free(struct bpf_map=
 *map)
>  	bpf_map_area_free(st_map);
>  }
> =20
> +static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
> +
> +	bpf_struct_ops_map_del_ksyms(st_map);
> +}
> +
>  static void bpf_struct_ops_map_free(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
> +	struct bpf_struct_ops *st_ops =3D st_map->st_ops_desc->st_ops;
> +	bool tasks_rcu =3D st_ops->free_after_tasks_rcu_gp;
> =20
>  	/* st_ops->owner was acquired during map_alloc to implicitly holds
>  	 * the btf's refcnt. The acquire was only done when btf_is_module()
> @@ -997,24 +1006,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);
> =20
> -	bpf_struct_ops_map_del_ksyms(st_map);
> -
> -	/* The struct_ops's function may switch to another struct_ops.
> -	 *
> -	 * For example, bpf_tcp_cc_x->init() may switch to
> -	 * another tcp_cc_y by calling
> -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -	 * and its refcount may reach 0 which then free its
> -	 * trampoline image while tcp_cc_x is still running.
> -	 *
> -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -	 * to finish. bpf-tcp-cc prog is non sleepable.
> -	 * A rcu_tasks gp is to wait for the last few insn
> -	 * in the tramopline image to finish before releasing
> -	 * the trampoline image.
> -	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> +		synchronize_rcu_tasks();
> =20
>  	__bpf_struct_ops_map_free(map);
>  }
> @@ -1123,6 +1116,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
> =20
>  	mutex_init(&st_map->lock);
>  	bpf_map_init_from_attr(map, attr);
> +	map->free_after_rcu_gp =3D true;
> =20
>  	return map;
> =20
> @@ -1155,6 +1149,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D=
 {
>  	.map_alloc_check =3D bpf_struct_ops_map_alloc_check,
>  	.map_alloc =3D bpf_struct_ops_map_alloc,
>  	.map_free =3D bpf_struct_ops_map_free,
> +	.map_free_pre_rcu =3D bpf_struct_ops_map_free_pre_rcu,
>  	.map_get_next_key =3D bpf_struct_ops_map_get_next_key,
>  	.map_lookup_elem =3D bpf_struct_ops_map_lookup_elem,
>  	.map_delete_elem =3D bpf_struct_ops_map_delete_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..b07acf37ad1d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -956,6 +956,9 @@ void bpf_map_put(struct bpf_map *map)
>  		/* bpf_map_free_id() must be called first */
>  		bpf_map_free_id(map);
> =20
> +		if (map->ops->map_free_pre_rcu)
> +			map->ops->map_free_pre_rcu(map);
> +
>  		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
>  		/* RCU tasks trace grace period implies RCU grace period. */
>  		if (READ_ONCE(map->free_after_mult_rcu_gp))
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 791e15063237..e224ecafbd69 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -339,6 +339,22 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops =
=3D {
>  	.validate =3D bpf_tcp_ca_validate,
>  	.name =3D "tcp_congestion_ops",
>  	.cfi_stubs =3D &__bpf_ops_tcp_congestion_ops,
> +	/* The struct_ops's function may switch to another struct_ops.
> +	 *
> +	 * For example, bpf_tcp_cc_x->init() may switch to
> +	 * another tcp_cc_y by calling
> +	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> +	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> +	 * and its refcount may reach 0 which then free its
> +	 * trampoline image while tcp_cc_x is still running.
> +	 *
> +	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> +	 * to finish. bpf-tcp-cc prog is non sleepable.
> +	 * A rcu_tasks gp is to wait for the last few insn
> +	 * in the tramopline image to finish before releasing
> +	 * the trampoline image.
> +	 */
> +	.free_after_tasks_rcu_gp =3D true,
>  	.owner =3D THIS_MODULE,
>  };
> =20


