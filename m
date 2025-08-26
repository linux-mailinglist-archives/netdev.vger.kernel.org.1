Return-Path: <netdev+bounces-216870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2322BB359DA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CCB3BC809
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE331813A;
	Tue, 26 Aug 2025 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxG5qk9T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C7296BD7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203068; cv=none; b=CedU/FlWAWMXDBEMUy8E12dLaIBsZ3T5vS7+wRrTSFA7aZS5Tnl1bx/7fKn5AAGP45SVZJNlNX9gQqfjW7iV3gBtAP9ON9V4TwAg9Ejicvq6J6Lq5o5dLo3QPJlG+YiNb81bnRXsJmLsp4gOf00RDNtOpJ0HxhCkE4wxaMuEy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203068; c=relaxed/simple;
	bh=qZL19LWMVGxytad1dq5xm6Fva2/GIMkcgBBlkS8gGxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d15cmrz/7LOLBhd6HykB/GzlLPfm48X2HU4zfq5QLH/k7tlkXL+AlDnAhHaJzpeV4peGiQ1Jn0g0NChCNW3Y+NQM/k1uiKZgeXcSVftqDFAZvxdRHubonaH5Q1NgPjXBG/jMIgmUDULiFX+i8Okrggp/mn8tQ0vJOyAJtGe4ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxG5qk9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756203060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DN/MjeWtlro5wRMbUJ5K7tN7WH1gj3Ruk+dZHoE3dQ=;
	b=gxG5qk9TPwG/bWzaB0EaYWcYxto6DdMuJly8fyk2eFxRpNpFyu5UNzGRmwWz1Z2bXJtp6e
	J8+wFSNcJp7Oz3apfSFRG/YAdwzKMrtW0ek+P7bD4dUziuRDZf3WqMRMRIW63jD7MGW3cK
	g9sUGIEI0QZ0LvFCOpmupJQH5B5Mk8c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Wx7Gv1-KM6qd0O5eIPILIg-1; Tue, 26 Aug 2025 06:10:59 -0400
X-MC-Unique: Wx7Gv1-KM6qd0O5eIPILIg-1
X-Mimecast-MFC-AGG-ID: Wx7Gv1-KM6qd0O5eIPILIg_1756203059
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109ad4998so210532811cf.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 03:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203059; x=1756807859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DN/MjeWtlro5wRMbUJ5K7tN7WH1gj3Ruk+dZHoE3dQ=;
        b=WNzE0pNRbEuf7+j/QDiJhDrDLuR3Bs8gmgIilegdplnSncRmnrxT7FpaZ6qVa1NBA1
         oFI0svhGoeQw2nU7Pfa2ivz5S/iKeVocY1KORQ2CkyDCf0duej1ff3vLr4oZD5l68bPz
         J4GFUYK76M8RGFI7r/C7M0bv+hFu3Fpl3V5JWwPqtOrnZw53lt5tOQuFGTbh+3x0yRlM
         C9Ppdd0eoU7YY7XprleP9If2N8doV3t4sQefnReN19KlSuFXKLcO0flHdKp4WSrzXh9W
         dhGrRH0DxvRJeaUQ19uer98P1zStZfV5ljs8Tk2DSu3SCJDSmcOUydRSFG5QssdmNjX9
         mftg==
X-Forwarded-Encrypted: i=1; AJvYcCW2LAOplJnTtB/rPCVfa6dcubz4TS8FRyj7FRFyOAOlRDNQrzm0hAXnZ+mmX6GUPJswKnz76Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJoxJk6DtdhMfHmAUc89+YXrCyP8KOkRx5GpjomoMW8clJMB7
	p0Mqcd0tRxSrbKmrAJQszgIxen4sYkk7D/v7QmiaUNZOIL37wpaDsCd0fhFjedLsuaWdgABQ2Ry
	MboPihajbSoruFL9KjSgXbanMHiSE855+PG/RGfqu++OybRCGJ/4wSufY2A==
X-Gm-Gg: ASbGncuRqwlq4FNzLwgnhoMaMnM5lMcWbinNlR+LARe1kna50TvvdRAbU+xsZUSV5xN
	FBX3lo5JP/URM1b65sXSAm1zS7a2TqnzcmojWsdFGWSymAMOcGJvOa9H+FIW5Qh9ObhIg6cLcJ6
	iynr+44sllHh/fQdeXDifQRqtW6HpPMrOFLoj3hosyUEnQnzkeNswxmWyw+kxs8HDzs8TgkxITz
	LSbNQUFa7Jn6haPy61snTl3njdoYt/uofa0SrC9hGiWzWLAX8RTsOpi3CfLgzcro1abcCBznQ/4
	nHv4XRaZm35AD+Evp9616bhDEtAdx5mufMoCL+8pteI8OyepZXB+kcfFOMIxMgr3VHyW4XhrDXb
	sJaamhzReR2E=
X-Received: by 2002:ac8:7d50:0:b0:4b0:7a69:7280 with SMTP id d75a77b69052e-4b2aab0d13fmr171564111cf.45.1756203058656;
        Tue, 26 Aug 2025 03:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVoRKEqCZrbD8vTbi/A+f7AJxiyGDZmNtRE7wKIUdb7WvUftLSS0CxV4L28BPc/LvSrTXXw==
X-Received: by 2002:ac8:7d50:0:b0:4b0:7a69:7280 with SMTP id d75a77b69052e-4b2aab0d13fmr171563821cf.45.1756203057897;
        Tue, 26 Aug 2025 03:10:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e2060csm69559591cf.44.2025.08.26.03.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 03:10:57 -0700 (PDT)
Message-ID: <180be553-8297-4802-972f-d73f30da365a@redhat.com>
Date: Tue, 26 Aug 2025 12:10:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 06/15] net: homa: create homa_sock.h and
 homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-7-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-7-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * homa_socktab_next() - Return the next socket in an iteration over a socktab.
> + * @scan:      State of the scan.
> + *
> + * Return:     The next socket in the table, or NULL if the iteration has
> + *             returned all of the sockets in the table.  If non-NULL, a
> + *             reference is held on the socket to prevent its deletion.
> + *             Sockets are not returned in any particular order. It's
> + *             possible that the returned socket has been destroyed.
> + */
> +struct homa_sock *homa_socktab_next(struct homa_socktab_scan *scan)
> +{
> +	struct hlist_head *bucket;
> +	struct hlist_node *next;
> +
> +	rcu_read_lock();
> +	if (scan->hsk) {
> +		sock_put(&scan->hsk->sock);
> +		next = rcu_dereference(hlist_next_rcu(&scan->hsk->socktab_links));
> +		if (next)
> +			goto success;
> +	}
> +	for (scan->current_bucket++;
> +	     scan->current_bucket < HOMA_SOCKTAB_BUCKETS;
> +	     scan->current_bucket++) {
> +		bucket = &scan->socktab->buckets[scan->current_bucket];
> +		next = rcu_dereference(hlist_first_rcu(bucket));
> +		if (next)
> +			goto success;
> +	}
> +	scan->hsk = NULL;
> +	rcu_read_unlock();
> +	return NULL;
> +
> +success:
> +	scan->hsk =  hlist_entry(next, struct homa_sock, socktab_links);

Minor nit: double space above.

> +	sock_hold(&scan->hsk->sock);
> +	rcu_read_unlock();
> +	return scan->hsk;
> +}
> +
> +/**
> + * homa_socktab_end_scan() - Must be invoked on completion of each scan
> + * to clean up state associated with the scan.
> + * @scan:      State of the scan.
> + */
> +void homa_socktab_end_scan(struct homa_socktab_scan *scan)
> +{
> +	if (scan->hsk) {
> +		sock_put(&scan->hsk->sock);
> +		scan->hsk = NULL;
> +	}
> +}
> +
> +/**
> + * homa_sock_init() - Constructor for homa_sock objects. This function
> + * initializes only the parts of the socket that are owned by Homa.
> + * @hsk:    Object to initialize. The Homa-specific parts must have been
> + *          initialized to zeroes by the caller.
> + *
> + * Return: 0 for success, otherwise a negative errno.
> + */
> +int homa_sock_init(struct homa_sock *hsk)
> +{
> +	struct homa_pool *buffer_pool;
> +	struct homa_socktab *socktab;
> +	struct homa_sock *other;
> +	struct homa_net *hnet;
> +	struct homa *homa;
> +	int starting_port;
> +	int result = 0;
> +	int i;
> +
> +	hnet = (struct homa_net *)net_generic(sock_net(&hsk->sock),
> +					      homa_net_id);
> +	homa = hnet->homa;
> +	socktab = homa->socktab;
> +
> +	/* Initialize fields outside the Homa part. */
> +	hsk->sock.sk_sndbuf = homa->wmem_max;
> +	sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);
> +
> +	/* Do things requiring memory allocation before locking the socket,
> +	 * so that GFP_ATOMIC is not needed.
> +	 */
> +	buffer_pool = homa_pool_alloc(hsk);
> +	if (IS_ERR(buffer_pool))
> +		return PTR_ERR(buffer_pool);
> +
> +	/* Initialize Homa-specific fields. */
> +	hsk->homa = homa;
> +	hsk->hnet = hnet;
> +	hsk->buffer_pool = buffer_pool;
> +
> +	/* Pick a default port. Must keep the socktab locked from now
> +	 * until the new socket is added to the socktab, to ensure that
> +	 * no other socket chooses the same port.
> +	 */
> +	spin_lock_bh(&socktab->write_lock);
> +	starting_port = hnet->prev_default_port;
> +	while (1) {
> +		hnet->prev_default_port++;
> +		if (hnet->prev_default_port < HOMA_MIN_DEFAULT_PORT)
> +			hnet->prev_default_port = HOMA_MIN_DEFAULT_PORT;
> +		other = homa_sock_find(hnet, hnet->prev_default_port);
> +		if (!other)
> +			break;
> +		sock_put(&other->sock);
> +		if (hnet->prev_default_port == starting_port) {
> +			spin_unlock_bh(&socktab->write_lock);
> +			hsk->shutdown = true;
> +			hsk->homa = NULL;
> +			result = -EADDRNOTAVAIL;
> +			goto error;
> +		}

You likely need to add a cond_resched here (releasing and re-acquiring
the lock as needed)

> +	}
> +	hsk->port = hnet->prev_default_port;
> +	hsk->inet.inet_num = hsk->port;
> +	hsk->inet.inet_sport = htons(hsk->port);
> +
> +	hsk->is_server = false;
> +	hsk->shutdown = false;
> +	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET) ?
> +				sizeof(struct iphdr) : sizeof(struct ipv6hdr);
> +	spin_lock_init(&hsk->lock);
> +	atomic_set(&hsk->protect_count, 0);
> +	INIT_LIST_HEAD(&hsk->active_rpcs);
> +	INIT_LIST_HEAD(&hsk->dead_rpcs);
> +	hsk->dead_skbs = 0;
> +	INIT_LIST_HEAD(&hsk->waiting_for_bufs);
> +	INIT_LIST_HEAD(&hsk->ready_rpcs);
> +	INIT_LIST_HEAD(&hsk->interests);
> +	for (i = 0; i < HOMA_CLIENT_RPC_BUCKETS; i++) {
> +		struct homa_rpc_bucket *bucket = &hsk->client_rpc_buckets[i];
> +
> +		spin_lock_init(&bucket->lock);
> +		bucket->id = i;
> +		INIT_HLIST_HEAD(&bucket->rpcs);
> +	}
> +	for (i = 0; i < HOMA_SERVER_RPC_BUCKETS; i++) {
> +		struct homa_rpc_bucket *bucket = &hsk->server_rpc_buckets[i];
> +
> +		spin_lock_init(&bucket->lock);
> +		bucket->id = i + 1000000;
> +		INIT_HLIST_HEAD(&bucket->rpcs);
> +	}

Do all the above initialization steps need to be done under the socktab
lock?

> +/**
> + * homa_sock_bind() - Associates a server port with a socket; if there
> + * was a previous server port assignment for @hsk, it is abandoned.
> + * @hnet:      Network namespace with which port is associated.
> + * @hsk:       Homa socket.
> + * @port:      Desired server port for @hsk. If 0, then this call
> + *             becomes a no-op: the socket will continue to use
> + *             its randomly assigned client port.
> + *
> + * Return:  0 for success, otherwise a negative errno.
> + */
> +int homa_sock_bind(struct homa_net *hnet, struct homa_sock *hsk,
> +		   u16 port)
> +{
> +	struct homa_socktab *socktab = hnet->homa->socktab;
> +	struct homa_sock *owner;
> +	int result = 0;
> +
> +	if (port == 0)
> +		return result;
> +	if (port >= HOMA_MIN_DEFAULT_PORT)
> +		return -EINVAL;
> +	homa_sock_lock(hsk);
> +	spin_lock_bh(&socktab->write_lock);
> +	if (hsk->shutdown) {
> +		result = -ESHUTDOWN;
> +		goto done;
> +	}
> +
> +	owner = homa_sock_find(hnet, port);
> +	if (owner) {
> +		sock_put(&owner->sock);

homa_sock_find() is used is multiple places to check for port usage. I
think it would be useful to add a variant of such helper not
incremention the socket refcount.

> +		if (owner != hsk)
> +			result = -EADDRINUSE;
> +		goto done;
> +	}
> +	hlist_del_rcu(&hsk->socktab_links);
> +	hsk->port = port;
> +	hsk->inet.inet_num = port;
> +	hsk->inet.inet_sport = htons(hsk->port);
> +	hlist_add_head_rcu(&hsk->socktab_links,
> +			   &socktab->buckets[homa_socktab_bucket(hnet, port)]);
> +	hsk->is_server = true;
> +done:
> +	spin_unlock_bh(&socktab->write_lock);
> +	homa_sock_unlock(hsk);
> +	return result;
> +}


> +/**
> + * homa_sock_wait_wmem() - Block the thread until @hsk's usage of tx
> + * packet memory drops below the socket's limit.
> + * @hsk:          Socket of interest.
> + * @nonblocking:  If there's not enough memory, return -EWOLDBLOCK instead
> + *                of blocking.
> + * Return: 0 for success, otherwise a negative errno.
> + */
> +int homa_sock_wait_wmem(struct homa_sock *hsk, int nonblocking)
> +{
> +	long timeo = hsk->sock.sk_sndtimeo;
> +	int result;
> +
> +	if (nonblocking)
> +		timeo = 0;
> +	set_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
> +	result = wait_event_interruptible_timeout(*sk_sleep(&hsk->sock),
> +				homa_sock_wmem_avl(hsk) || hsk->shutdown,
> +				timeo);
> +	if (signal_pending(current))
> +		return -EINTR;
> +	if (result == 0)
> +		return -EWOULDBLOCK;
> +	return 0;
> +}

Perhaps you could use sock_wait_for_wmem() ?

> diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h
> new file mode 100644
> index 000000000000..1f649c1da628
> --- /dev/null
> +++ b/net/homa/homa_sock.h
> @@ -0,0 +1,408 @@
> +/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ */
> +
> +/* This file defines structs and other things related to Homa sockets.  */
> +
> +#ifndef _HOMA_SOCK_H
> +#define _HOMA_SOCK_H
> +
> +/* Forward declarations. */
> +struct homa;
> +struct homa_pool;
> +
> +/* Number of hash buckets in a homa_socktab. Must be a power of 2. */
> +#define HOMA_SOCKTAB_BUCKET_BITS 10
> +#define HOMA_SOCKTAB_BUCKETS BIT(HOMA_SOCKTAB_BUCKET_BITS)
> +
> +/**
> + * struct homa_socktab - A hash table that maps from port numbers (either
> + * client or server) to homa_sock objects.
> + *
> + * This table is managed exclusively by homa_socktab.c, using RCU to
> + * minimize synchronization during lookups.
> + */
> +struct homa_socktab {
> +	/**
> +	 * @write_lock: Controls all modifications to this object; not needed
> +	 * for socket lookups (RCU is used instead). Also used to
> +	 * synchronize port allocation.
> +	 */
> +	spinlock_t write_lock;
> +
> +	/**
> +	 * @buckets: Heads of chains for hash table buckets. Chains
> +	 * consist of homa_sock objects.
> +	 */
> +	struct hlist_head buckets[HOMA_SOCKTAB_BUCKETS];
> +};
> +
> +/**
> + * struct homa_socktab_scan - Records the state of an iteration over all
> + * the entries in a homa_socktab, in a way that is safe against concurrent
> + * reclamation of sockets.
> + */
> +struct homa_socktab_scan {
> +	/** @socktab: The table that is being scanned. */
> +	struct homa_socktab *socktab;
> +
> +	/**
> +	 * @hsk: Points to the current socket in the iteration, or NULL if
> +	 * we're at the beginning or end of the iteration. If non-NULL then
> +	 * we are holding a reference to this socket.
> +	 */
> +	struct homa_sock *hsk;
> +
> +	/**
> +	 * @current_bucket: The index of the bucket in socktab->buckets
> +	 * currently being scanned (-1 if @hsk == NULL).
> +	 */
> +	int current_bucket;
> +};
> +
> +/**
> + * struct homa_rpc_bucket - One bucket in a hash table of RPCs.
> + */
> +
> +struct homa_rpc_bucket {
> +	/**
> +	 * @lock: serves as a lock both for this bucket (e.g., when
> +	 * adding and removing RPCs) and also for all of the RPCs in
> +	 * the bucket. Must be held whenever looking up an RPC in
> +	 * this bucket or manipulating an RPC in the bucket. This approach
> +	 * has the following properties:
> +	 * 1. An RPC can be looked up and locked (a common operation) with
> +	 *    a single lock acquisition.
> +	 * 2. Looking up and locking are atomic: there is no window of
> +	 *    vulnerability where someone else could delete an RPC after
> +	 *    it has been looked up and before it has been locked.
> +	 * 3. The lookup mechanism does not use RCU.  This is important because
> +	 *    RPCs are created rapidly and typically live only a few tens of
> +	 *    microseconds.  As of May 2027 RCU introduces a lag of about

I'm unable to make prediction about the next week, I have no idea what
will happen in 2y...

> +	 *    25 ms before objects can be deleted; for RPCs this would result
> +	 *    in hundreds or thousands of RPCs accumulating before RCU allows
> +	 *    them to be deleted.
> +	 * This approach has the disadvantage that RPCs within a bucket share
> +	 * locks and thus may not be able to work concurrently, but there are
> +	 * enough buckets in the table to make such colllisions rare.
> +	 *
> +	 * See "Homa Locking Strategy" in homa_impl.h for more info about
> +	 * locking.
> +	 */
> +	spinlock_t lock;
> +
> +	/**
> +	 * @id: identifier for this bucket, used in error messages etc.
> +	 * It's the index of the bucket within its hash table bucket
> +	 * array, with an additional offset to separate server and
> +	 * client RPCs.
> +	 */
> +	int id;
> +
> +	/** @rpcs: list of RPCs that hash to this bucket. */
> +	struct hlist_head rpcs;
> +};
> +
> +/**
> + * define HOMA_CLIENT_RPC_BUCKETS - Number of buckets in hash tables for
> + * client RPCs. Must be a power of 2.
> + */
> +#define HOMA_CLIENT_RPC_BUCKETS 1024
> +
> +/**
> + * define HOMA_SERVER_RPC_BUCKETS - Number of buckets in hash tables for
> + * server RPCs. Must be a power of 2.
> + */
> +#define HOMA_SERVER_RPC_BUCKETS 1024
> +
> +/**
> + * struct homa_sock - Information about an open socket.
> + */
> +struct homa_sock {
> +	/* Info for other network layers. Note: IPv6 info (struct ipv6_pinfo
> +	 * comes at the very end of the struct, *after* Homa's data, if this
> +	 * socket uses IPv6).
> +	 */
> +	union {
> +		/** @sock: generic socket data; must be the first field. */
> +		struct sock sock;
> +
> +		/**
> +		 * @inet: generic Internet socket data; must also be the
> +		 first field (contains sock as its first member).
> +		 */
> +		struct inet_sock inet;
> +	};
> +
> +	/**
> +	 * @homa: Overall state about the Homa implementation. NULL
> +	 * means this socket was never initialized or has been deleted.
> +	 */
> +	struct homa *homa;
> +
> +	/**
> +	 * @hnet: Overall state specific to the network namespace for
> +	 * this socket.
> +	 */
> +	struct homa_net *hnet;

Both the above should likely be removed

> +
> +	/**
> +	 * @buffer_pool: used to allocate buffer space for incoming messages.
> +	 * Storage is dynamically allocated.
> +	 */
> +	struct homa_pool *buffer_pool;
> +
> +	/**
> +	 * @port: Port number: identifies this socket uniquely among all
> +	 * those on this node.
> +	 */
> +	u16 port;
> +
> +	/**
> +	 * @is_server: True means that this socket can act as both client
> +	 * and server; false means the socket is client-only.
> +	 */
> +	bool is_server;
> +
> +	/**
> +	 * @shutdown: True means the socket is no longer usable (either
> +	 * shutdown has already been invoked, or the socket was never
> +	 * properly initialized).
> +	 */
> +	bool shutdown;
> +
> +	/**
> +	 * @ip_header_length: Length of IP headers for this socket (depends
> +	 * on IPv4 vs. IPv6).
> +	 */
> +	int ip_header_length;
> +
> +	/** @socktab_links: Links this socket into a homa_socktab bucket. */
> +	struct hlist_node socktab_links;
> +
> +	/* Information above is (almost) never modified; start a new
> +	 * cache line below for info that is modified frequently.
> +	 */
> +
> +	/**
> +	 * @lock: Must be held when modifying fields such as interests
> +	 * and lists of RPCs. This lock is used in place of sk->sk_lock
> +	 * because it's used differently (it's always used as a simple
> +	 * spin lock).  See "Homa Locking Strategy" in homa_impl.h
> +	 * for more on Homa's synchronization strategy.
> +	 */
> +	spinlock_t lock ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @protect_count: counts the number of calls to homa_protect_rpcs
> +	 * for which there have not yet been calls to homa_unprotect_rpcs.
> +	 */
> +	atomic_t protect_count;
> +
> +	/**
> +	 * @active_rpcs: List of all existing RPCs related to this socket,
> +	 * including both client and server RPCs. This list isn't strictly
> +	 * needed, since RPCs are already in one of the hash tables below,
> +	 * but it's more efficient for homa_timer to have this list
> +	 * (so it doesn't have to scan large numbers of hash buckets).
> +	 * The list is sorted, with the oldest RPC first. Manipulate with
> +	 * RCU so timer can access without locking.
> +	 */
> +	struct list_head active_rpcs;
> +
> +	/**
> +	 * @dead_rpcs: Contains RPCs for which homa_rpc_end has been
> +	 * called, but their packet buffers haven't yet been freed.
> +	 */
> +	struct list_head dead_rpcs;
> +
> +	/** @dead_skbs: Total number of socket buffers in RPCs on dead_rpcs. */
> +	int dead_skbs;
> +
> +	/**
> +	 * @waiting_for_bufs: Contains RPCs that are blocked because there
> +	 * wasn't enough space in the buffer pool region for their incoming
> +	 * messages. Sorted in increasing order of message length.
> +	 */
> +	struct list_head waiting_for_bufs;
> +
> +	/**
> +	 * @ready_rpcs: List of all RPCs that are ready for attention from
> +	 * an application thread.
> +	 */
> +	struct list_head ready_rpcs;
> +
> +	/**
> +	 * @interests: List of threads that are currently waiting for
> +	 * incoming messages via homa_wait_shared.
> +	 */
> +	struct list_head interests;
> +
> +	/**
> +	 * @client_rpc_buckets: Hash table for fast lookup of client RPCs.
> +	 * Modifications are synchronized with bucket locks, not
> +	 * the socket lock.
> +	 */
> +	struct homa_rpc_bucket client_rpc_buckets[HOMA_CLIENT_RPC_BUCKETS];
> +
> +	/**
> +	 * @server_rpc_buckets: Hash table for fast lookup of server RPCs.
> +	 * Modifications are synchronized with bucket locks, not
> +	 * the socket lock.
> +	 */
> +	struct homa_rpc_bucket server_rpc_buckets[HOMA_SERVER_RPC_BUCKETS];

The above 2 array are quite large, and should be probably allocated
separately.

> +/**
> + * homa_client_rpc_bucket() - Find the bucket containing a given
> + * client RPC.
> + * @hsk:      Socket associated with the RPC.
> + * @id:       Id of the desired RPC.
> + *
> + * Return:    The bucket in which this RPC will appear, if the RPC exists.
> + */
> +static inline struct homa_rpc_bucket
> +		*homa_client_rpc_bucket(struct homa_sock *hsk, u64 id)
> +{
> +	/* We can use a really simple hash function here because RPC ids
> +	 * are allocated sequentially.
> +	 */
> +	return &hsk->client_rpc_buckets[(id >> 1)
> +			& (HOMA_CLIENT_RPC_BUCKETS - 1)];

Minor nit: '&' should be on the provious line, and please fix the alignment.

> +/**
> + * homa_sock_wakeup_wmem() - Invoked when tx packet memory has been freed;
> + * if memory usage is below the limit and there are tasks waiting for memory,
> + * wake them up.
> + * @hsk:   Socket of interest.
> + */
> +static inline void homa_sock_wakeup_wmem(struct homa_sock *hsk)
> +{
> +	if (test_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags) &&
> +	    homa_sock_wmem_avl(hsk)) {
> +		clear_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
> +		wake_up_interruptible_poll(sk_sleep(&hsk->sock), EPOLLOUT);

Can hsk be orphaned at this point? I think so.

/P


