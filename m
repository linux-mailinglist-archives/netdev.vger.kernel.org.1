Return-Path: <netdev+bounces-305235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UeImIN0zTGq1hgEAu9opvQ
	(envelope-from <netdev+bounces-305235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33871633C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:01:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MaqfLxci;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305235-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305235-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE5433011A59
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A43BBFD7;
	Mon,  6 Jul 2026 23:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F11B4223
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:01:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378905; cv=none; b=hQ+grRQ6Ls7RmE7dRTFubp385bM9Ronpu85esHkyv7qi9s7PQyGOehYCJ7wKQP+AngNwvN555ET+96ge+s/0EP3zmKoZBTwpJh4xQhO6/Sfv2JbDHxsjskNs2hZrEd8aFj28Pm64aFYaZNQH1kvkRb8WWfdgTguIHmTZ6cMOQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378905; c=relaxed/simple;
	bh=2fcJP08/HSUH1wuSTGx+vBhClLrtN4O9zNgxlhnCbX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1Fu8WTF8BAZO6Cpej2aPEn38cH7DGYBi7RARCLvMT33/I9i4KdNtFX3lM5J8G1AntItmnFov4Sm6g5el8W7woRsJBBervNmDquhgkUDxePLUJgirWl4pwqclEQMIpvMcoYIcAvkeA1Wo+sgPswY7Q72a5o5zQcNrulFoSDsu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaqfLxci; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c98136ceff4so6130210a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783378903; x=1783983703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4OKH8nLpRPfbp1hgj6REqr4yMvAGngFItE2YoOJh7A=;
        b=MaqfLxci+7yU4xbgzhJ7Yft+fgtHLcaVKgIDMH/w/QqxbYBpNW6RvvMyUZb6zTGddG
         gsi7pa1dKRhDE0GSR34GWGmvigUjd/OPo/f8v+tAS0NRr07+zOk0OifwzXmm+CmzClek
         f14ZZA4OL96xP+l/o22mvz2cCi44rno0VJvFQYcV5xgrD9m9WdPiT2CwQ4qfJ3eKEIFw
         /FtLCGYICBcJoTeW8LuxNCYel56kyCUFXOW5EAjs+lgymmlZcp0x1heY1VW112487g1p
         1u28O0/G3etokeXBlSNVsBvsUH0DKx1+YzZc87ZvFghLGHFbcpte1tnHgvmGAHZrQByE
         IWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378903; x=1783983703;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4OKH8nLpRPfbp1hgj6REqr4yMvAGngFItE2YoOJh7A=;
        b=OD5/jdwGxqHGzFY/p/sMao2Ut0zwiW0nb2FznySnydse2/X/QT72kpB73rlu6ysMno
         kNsIrUZeuhncwj46LdrcCS9dzjQOrKkJGNo2aH8q2x+9ZXqmwWbxevMliqOFGInEjH/a
         cbZfTt3MnV8h0CLs2LSyhy/mHOoK9VAaIJP2/rQgjTX/UIzNYpfO87lFUcHr1u7GJwO4
         d1HCWdB4QYCw9XUIvF0YKi0ujqtJ4meexkgRCPv2MvbtFuTVGOaVkvYoAjO64KBkUdzz
         sa6hzhPf7SWplM1hS4iCYs1ZB5wJCrb+lxB9oJF4NdYsQXhrmcOZ9hhqPy1EMWiEtAqq
         4/OA==
X-Forwarded-Encrypted: i=1; AHgh+RoiXNLOzgTfQXbdjKuAft1IP2Ta9x3qH7O8joamPgNrXfv4QJoHcTlo4zCqrawsF4KbF3iJmXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoodzAg5Aa97xuOvx6w8xHS8ZeTpsjt+SmDgC8DZN28BCrOlPr
	o00mE/s1sdYacPxJH4LN28ogf4Q2HnDXUjIIMxQZPuRAwnKW0EjQ3RgMdy1af1bGmtT1eN2oqKQ
	swbsi1Q==
X-Received: from pfll10.prod.google.com ([2002:a05:6a00:158a:b0:847:ada8:bf86])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd81:b0:847:8650:69cd
 with SMTP id d2e1a72fcca58-84826dad939mr2513930b3a.33.1783378903005; Mon, 06
 Jul 2026 16:01:43 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:01:27 +0000
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230142.1691146-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
From: Kuniyuki Iwashima <kuniyu@google.com>
To: mahe.tardy@gmail.com
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305235-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:song@kernel.org,m:mahetardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA33871633C

From: Mahe Tardy <mahe.tardy@gmail.com>
Date: Mon,  6 Jul 2026 09:35:21 +0000
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
[...]
> +static bool bpf_ksock_send_enter(struct bpf_ksock_send_guard *guard)

Can we do this better with assigning a single bit to task_struct ?


> +{
> +	struct bpf_ksock_send_guard *entry;
> +	struct hlist_bl_node *pos;
> +	struct bpf_ksock_send_bucket *bucket;
> +
> +	bucket = bpf_ksock_send_bucket(current);
> +	hlist_bl_lock(&bucket->head);
> +	hlist_bl_for_each_entry(entry, pos, &bucket->head, node) {
> +		if (entry->task == current) {
> +			hlist_bl_unlock(&bucket->head);
> +			return false;
> +		}
> +	}
> +
> +	guard->task = current;
> +	INIT_HLIST_BL_NODE(&guard->node);
> +	hlist_bl_add_head(&guard->node, &bucket->head);
> +	hlist_bl_unlock(&bucket->head);
> +	return true;
> +}
> +
> +static void bpf_ksock_send_exit(struct bpf_ksock_send_guard *guard)
> +{
> +	struct bpf_ksock_send_bucket *bucket;
> +
> +	bucket = bpf_ksock_send_bucket(guard->task);
> +	hlist_bl_lock(&bucket->head);
> +	hlist_bl_del(&guard->node);
> +	hlist_bl_unlock(&bucket->head);
> +}
[...]
> +__bpf_kfunc struct bpf_ksock *
> +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> +		 int *err__uninit)
> +{
> +	struct bpf_ksock_create_opts opts_copy;
> +	struct bpf_ksock *ks;
> +	struct net *net;
> +	int err;
> +
> +	/*
> +	 * sock_create() derives the network namespace, credentials, and cgroup
> +	 * from current. Kernel threads, including BPF workqueue callbacks, do
> +	 * not carry the context of the task that invoked the BPF program.
> +	 */
> +	if (!bpf_ksock_has_user_task_context()) {
> +		err = -EOPNOTSUPP;
> +		goto err_out;
> +	}
> +
> +	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	opts_copy = (struct bpf_ksock_create_opts){
> +		.family = READ_ONCE(opts->family),
> +		.type = READ_ONCE(opts->type),
> +		.protocol = READ_ONCE(opts->protocol),
> +		.reserved = READ_ONCE(opts->reserved),
> +	};
> +
> +	if (opts_copy.reserved) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (opts_copy.family != AF_INET && opts_copy.family != AF_INET6) {
> +		err = -EAFNOSUPPORT;
> +		goto err_out;
> +	}
> +
> +	if (opts_copy.type != SOCK_DGRAM) {
> +		err = -EPROTONOSUPPORT;
> +		goto err_out;
> +	}
> +
> +	if (opts_copy.protocol != IPPROTO_UDP && opts_copy.protocol != 0) {
> +		err = -EPROTONOSUPPORT;
> +		goto err_out;
> +	}
> +
> +	ks = kzalloc_obj(*ks);
> +	if (!ks) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	net = current->nsproxy->net_ns;
> +	if (!bpf_ksock_net_try_charge(net)) {
> +		err = -ENOSPC;
> +		goto err_free;
> +	}
> +
> +	/*
> +	 * Use the normal current-task socket path so LSM/cgroup policy,
> +	 * socket labels, and the active netns reference match a socket(2)
> +	 * created by the BPF program's caller.
> +	 */
> +	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
> +			  &ks->sock);

This also triggers LSM in __sock_create() so needs the loop
detection, no ?

Same for __sys_bind_socket() and __sys_connect_socket().


> +	if (err)
> +		goto err_uncharge;
> +
> +	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
> +	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
> +
> +	refcount_set(&ks->usage, 1);
> +	put_unaligned(0, err__uninit);
> +	return ks;
> +
> +err_uncharge:
> +	bpf_ksock_net_uncharge(net);
> +err_free:
> +	kfree(ks);
> +err_out:
> +	put_unaligned(err, err__uninit);
> +	return NULL;
> +}
> +
> +/**
> + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
> + * @ks:		The BPF kernel socket context.
> + * @opts:	Pointer to struct bpf_ksock_addr_opts with local address.
> + * @opts__sz:	Size of the opts struct.
> + *
> + * Binds the socket to the specified local address and port.
> + * This is optional; if not called, the kernel will auto-assign.
> + *
> + * This function may sleep while binding the socket, so it can only be used in
> + * sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> +			       const struct bpf_ksock_addr_opts *opts,
> +			       u32 opts__sz)
> +{
> +	struct sockaddr_storage addr = {};

nit: we don't need to initialise here since bpf_ksock_get_addr() does.


> +	int addrlen;
> +
> +	if (!bpf_ksock_has_user_task_context())
> +		return -EOPNOTSUPP;
> +
> +	addrlen = bpf_ksock_get_addr(opts, opts__sz, &addr);
> +	if (addrlen < 0)
> +		return addrlen;
> +
> +	return __sys_bind_socket(ks->sock, &addr, addrlen);
> +}
> +
> +/**
> + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
> + * @ks:		The BPF kernel socket context.
> + * @opts:	Pointer to struct bpf_ksock_addr_opts with remote address.
> + * @opts__sz:	Size of the opts struct.
> + *
> + * Connects the socket to the specified remote address and port.
> + *
> + * This function may sleep while connecting the socket, so it can only be used
> + * in sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> +				  const struct bpf_ksock_addr_opts *opts,
> +				  u32 opts__sz)
> +{
> +	struct sockaddr_storage addr = {};

Same.

