Return-Path: <netdev+bounces-71732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C8854DD1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3FE281412
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A95FDD1;
	Wed, 14 Feb 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+Vse8S+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E725FDAC
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927190; cv=none; b=nbcpEE4wuhOpfnkEIddEsj5UzYff8f973GpD7M2+TH4DB8BAxH/wy9qCzcRWOf9qgfzGSDf5ehcEkqLu2/nFlLdkeQoQiI0DhmMKqCU1xtzDP8wZRogo70REG6ctPqigTMNmfWD0eihcb3O18jVqt615d0ZFZXqeJCnMFhjkBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927190; c=relaxed/simple;
	bh=zvAF82k8O/KXPUb8REbRkHwsgb0iVH0S92JZsfCAT7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exyOyyNECaPXCkwRhVkWjtbuOGR0CyJoE3VIkxvK6NRdbtMgoogBItmWQdG4ajvXlQtPk/u0IVXwZkhFuzkS0dHdlcuuJojlKYTFns4x09C5uE/a2SN5eVexx7VFi7nCktR25LZn4bNxZSbeYIvnVra26e9QCzYZXvv3/FA8DaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+Vse8S+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707927187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg012SthvSNAvLyRq8Vb5Hgl2UceVv6l801GSSZJ2rU=;
	b=b+Vse8S+LIcsAX0oIJ445pzId+KVG+0FC3kni5AmpCGwYYGnESFh+PoLBZmHRd+4mUBomM
	3xQSmQVUL1Qj6Kin/7pHpRC7Ka9zLlvO9ttbIK2GWegf2SjHw8DSwINDNCiWrhg0kUjCJq
	pEP1D+g65rDV+g3gR+lrSYowcdAOSv0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-73CUld3hM1yooY03vzkp1Q-1; Wed, 14 Feb 2024 11:13:06 -0500
X-MC-Unique: 73CUld3hM1yooY03vzkp1Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5611e1da4c6so3807520a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927185; x=1708531985;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qg012SthvSNAvLyRq8Vb5Hgl2UceVv6l801GSSZJ2rU=;
        b=IC8v9jlYiarA5mXW5wMsLmkbi+zcVV1Qv+nZiHkX1CLzrVYpId2m+MkalC6uB93j4a
         bhhXJkgTPdTQQet0RYi2j+Z6EszPGiDzO38YPtVQ/WsE3hNYieVW6Wx9c/15+e7MfIdn
         VLu8IwZvcJEfPtmPdV0+3TbK7ElOeWyiNOVR8HoGtr5jjLjLy2J+K6lSXTel+PPxkioU
         GOYXuK2JcvAwqSF9HBH8KCEAPAOuFHqzbvnfnd/CGPuZjaKzCxu1VM65RAm3492lDQEZ
         x2MvV8QKVspOg0BfJm5TygczTsS6kJ0gt5ea0c7NK9F3mCiLaNZbwBVli9N5nRdne46Q
         07sA==
X-Forwarded-Encrypted: i=1; AJvYcCWgRNauNtj3tE28f2aX375EX2hPv86M662669ympfUltpKBFFm+mwSgx2qupkxyu9Y1Pv1T+aOfjXqPdZ9wTwOrncA9OT3s
X-Gm-Message-State: AOJu0YyiF/HEV3ISwUlhT4nyGrghkfA773P1KS69eN5zCt+O+g9raOZx
	jDbX9+l7eywZRDtQaIL39MHCsRnZ6VRmZLnyE3Zj4OUsjFgICaPz07AOqvhmBojA4669c62Oj4s
	sH34Dv4kq0dlKdLaXYg3ncaFwQFujFZwdGCQt6zvzUwm2L50/PhFXzg==
X-Received: by 2002:a05:6402:35c1:b0:563:2069:9555 with SMTP id z1-20020a05640235c100b0056320699555mr2380351edc.35.1707927184920;
        Wed, 14 Feb 2024 08:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE7VFiwPVMQPPB+3QwjbT+YDJNosDKqsi0KjM+5ABUdILFrkMoXzaFU6MuzHW91CprIYmaVQ==
X-Received: by 2002:a05:6402:35c1:b0:563:2069:9555 with SMTP id z1-20020a05640235c100b0056320699555mr2380322edc.35.1707927184608;
        Wed, 14 Feb 2024 08:13:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd0bGtKCMWr8nWasnN2GmlD5wcqpU3qVkgdpCSws/54CSpwO3BvQzSc4Q+MFxtSLOHI3sfPrpghPCqPiAdROw4WuZCt1a0WPnFLYDSFWdrb5M5pKvAwKgcVk3w1O2LqrXvdyh8NTboni1r0pAvYZBikwUcCxnDRuvj+WLsz9G5W8ZocGTn6ZjSlmDTPCPxkkki8wwlt70fu45JLg2XqoVDmzXYsfumhRxwrnGh972lFGUiLJmgpHCNHpNVlmoL4AxyHCeFUvB2yveT7zp+0j1/lkE95aZ++sPvLku/Nuk8lXzpEiCDiy8oBPshkDRyzB10Jvqiea2CbRSw/r/1Fy2m7BgnlmTi8lpT0O8JSU0mw8aI2OtMCRg/AY2zNqqLJPZ/KLFwqB0jUZzMiL/ustALw+shMAjbO4DGwOMfmZJ5egk+qUIzmQ1UrlvLwyJRAjJxizJ+AtjdJUrf9Rx6kIYZEJBvaOA47tljz5t5cYuj4rPXXYIleTUx1EPQXsZi+foYzrASnFg+lheagA3piPwilPVrQXjdxcgW6p6QkuEMd0pVw4TLFSeCksrHqJFYlDohJ31wP9odq76JOfpbAKpPWh7GTdWEhVP4NEWiKuzoiyZMTkHJ5aGbSc7yBOyUY6+TbHP9LcRuNMjlKSreQ6d54zJ+0n8Wjbl2PEjT6AQCBEtjIdDcfcZTK0tjOUzYAmztZAk=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b005607825b11bsm4756968edb.12.2024.02.14.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:13:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9CA4810F57E7; Wed, 14 Feb 2024 17:13:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
 <edumazet@google.com>, Hao Luo <haoluo@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240213145923.2552753-2-bigeasy@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Feb 2024 17:13:03 +0100
Message-ID: <87il2rdnxs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
>
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
>
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
>
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking to avoid corruption if preemption occurs.
>
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided and data corruption is also avoided.
>
> Create a struct bpf_xdp_storage which contains struct bpf_redirect_info.
> Define the variable on stack, use xdp_storage_set() to set a pointer to
> it in task_struct of the current task. Use the __free() annotation to
> automatically reset the pointer once function returns. Use a pointer which can
> be used by the __free() annotation to avoid invoking the callback the pointer
> is NULL. This helps the compiler to optimize the code.
> The xdp_storage_set() can nest. For instance local_bh_enable() in
> bpf_test_run_xdp_live() may run NET_RX_SOFTIRQ/ net_rx_action() which
> also uses xdp_storage_set(). Therefore only the first invocations
> updates the per-task pointer.
> Use xdp_storage_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
>
> This is only done on PREEMPT_RT. The !PREEMPT_RT builds keep using the
> per-CPU variable instead. This should also work for !PREEMPT_RT but
> isn't needed.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index de362d5f26559..c3f7d2a6b6134 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3988,11 +3988,15 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>  		   struct net_device *orig_dev, bool *another)
>  {
>  	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
> +	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) = NULL;
>  	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
> +	struct bpf_xdp_storage __xdp_store;
>  	int sch_ret;
>  
>  	if (!entry)
>  		return skb;
> +
> +	xdp_store = xdp_storage_set(&__xdp_store);
>  	if (*pt_prev) {
>  		*ret = deliver_skb(skb, *pt_prev, orig_dev);
>  		*pt_prev = NULL;
> @@ -4044,12 +4048,16 @@ static __always_inline struct sk_buff *
>  sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
>  {
>  	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
> +	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) = NULL;
>  	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
> +	struct bpf_xdp_storage __xdp_store;
>  	int sch_ret;
>  
>  	if (!entry)
>  		return skb;
>  
> +	xdp_store = xdp_storage_set(&__xdp_store);
> +
>  	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
>  	 * already set by the caller.
>  	 */


These, and the LWT code, don't actually have anything to do with XDP,
which indicates that the 'xdp_storage' name misleading. Maybe
'bpf_net_context' or something along those lines? Or maybe we could just
move the flush lists into bpf_redirect_info itself and just keep that as
the top-level name?

-Toke


