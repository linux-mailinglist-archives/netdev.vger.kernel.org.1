Return-Path: <netdev+bounces-187775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B47AA999E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D657A9951
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61081A8F60;
	Mon,  5 May 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT1su3Sr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDC2580F1
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463572; cv=none; b=OsDQE5tPGp5TDxiDvTxfScrSjO7SmtjSNhCfXEI6Y2hvHW1TePRj9UsJYwyc5pzUCl2/wKtDROIvAmVAHHlcSQQrn8C3EoMTz0xxYQJmrQcNQ+Qg1PvoI3FFpXXBT/ViUx6oO7KOuYWXG/BUTBxDxzCT8zr8yc3dJFRHF35c85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463572; c=relaxed/simple;
	bh=pvnDGMu83F6jrVzujvkkH/C/mX9OdBnQNaUMJQ18XrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjoKtDgVZpYA609ARApXO6vYIEabriApuQ5ZB3JfW6gDd++WEEx2ZxVNx7jgD7pO38/eQDz2pLTQd6SomUkAXHUVluWf33hRSdBrxQu5JtREkuwwGJLTsN+tvC61h2YNnMyFsa3fD/Pjsw2uzujZamj0AdjS99Jv+2huFZWEsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT1su3Sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746463568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KegTXDQEmyxoKKfidO2BlJeB/vp2DL8URK42vTXrLYs=;
	b=dT1su3SryhLQHl1b2HI1PSTwzzj39BmivmGS6R0GCSCdkjtcfNCRoQJDk+qpsrcEO8dZyt
	apP2UuSmdTCIG2W8QPRUJxtfXCLxWKa8UJEi+Z8vWdWR2aZz4qwcXg2qlRU6OxpUUejf9Q
	xoJfRnE0NQkxt7VpwmypRiCd8iamUr4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578--As7u7XOOQikpB9UmaqKBw-1; Mon, 05 May 2025 12:46:07 -0400
X-MC-Unique: -As7u7XOOQikpB9UmaqKBw-1
X-Mimecast-MFC-AGG-ID: -As7u7XOOQikpB9UmaqKBw_1746463566
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c1b1c0969so2791348f8f.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 09:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463566; x=1747068366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KegTXDQEmyxoKKfidO2BlJeB/vp2DL8URK42vTXrLYs=;
        b=SUVOWPP/dvJ3f4EZnTYlo1jAe2C6+kaBUOErvAZZCJOeRtezjQNMKnpYKrWImSnKN9
         btPdD54KPbYAenMZXcFNdpPxH1vCsbbM/I2lP4WNsElJxrl6nTCHfi9DuchJwU/7R3jL
         gDWaD8uzGBEci2+8Ek1a+FzK36R8c5yYPiu3MGMIZNHHZ+BpyvPiPBQ/2j02BXaZ0XZF
         qizcyDZg4M32yNQmcgmtFwcszOlswz90s8khedm5Nl/A7RrmNVqf2Drwk5xrqZeavnj0
         NMre6Rc9wDHZ7wCczjg5XDW2kuE7ITiQ/cY3N78AKuyksi+THAQp4KzqeUeiE/zBZqaf
         Pl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzZ9YYmqbqLhHPcqN1eQW2SO6fpffzjY5gu6GYRiimlo/BSVeZ8ZqoNhB1WBDabrUllqMrSwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cRwNlSVwyJPd52hsES30PbmTMWyWW7Ha11MKQ2ygft7bIwHs
	UXCsu0bN72NW03sOPwe32gGk0tYGGXYxztPPqeDHFkyZEK4SgzhnuftDPo2Z9ZPJEzI0BzOVl88
	ljLquGc/yijCouiSmikg9LINR5/aowzcLVDpaFnvZYDc4TQNo7yhd6g==
X-Gm-Gg: ASbGncvs4x+Nr9RETqFP0n3i6QoZvZNW/73zd+XIvqO4uqXWk4UsuZOa1g4H7WRsITe
	vE79IUPUn/nt5vaiaxOtHLTG7MP5PVdw7ElKtGcUk1krEsjEm4Wn0EhdXa4QA4QaklMBI5cI+Ck
	+rdo+BxjOj8kXTFDY9H6/+OE4ghig9cMyHH9aeRxm6t/mOuTdMP5KHZTlLWsFpasS6DGtv1z6G9
	a1cB+dCVYo8AcsTiGbEY9Oqwof8T4sa2BHzIiQ3lBF990xfPd+eFMOlfV08+m9hIE9+YepoDL9P
	iIA/9TEE6SuyohEnCVU=
X-Received: by 2002:a05:6000:1848:b0:39e:cbde:8889 with SMTP id ffacd0b85a97d-3a09fd6de50mr5913988f8f.6.1746463565996;
        Mon, 05 May 2025 09:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+9WyyntVyWm1nOJhgf05yF1r3qkTmVaEyRTN4KRN/Yt3DgFYNd66gDia0gUIjfr2eZ6z4Q==
X-Received: by 2002:a05:6000:1848:b0:39e:cbde:8889 with SMTP id ffacd0b85a97d-3a09fd6de50mr5913965f8f.6.1746463565562;
        Mon, 05 May 2025 09:46:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010::f39? ([2a0d:3344:2706:e010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0d3csm10727858f8f.3.2025.05.05.09.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 09:46:05 -0700 (PDT)
Message-ID: <bd93f644-1d95-4b32-b4ef-9ee65256dcf4@redhat.com>
Date: Mon, 5 May 2025 18:46:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/15] net: homa: create homa_sock.h and
 homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-7-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-7-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
[...]
> +/**
> + * homa_sock_init() - Constructor for homa_sock objects. This function
> + * initializes only the parts of the socket that are owned by Homa.
> + * @hsk:    Object to initialize.
> + * @homa:   Homa implementation that will manage the socket.
> + *
> + * Return: 0 for success, otherwise a negative errno.
> + */
> +int homa_sock_init(struct homa_sock *hsk, struct homa *homa)
> +{
> +	struct homa_socktab *socktab = homa->port_map;
> +	struct homa_sock *other;
> +	int starting_port;
> +	int result = 0;
> +	int i;
> +
> +	/* Initialize fields outside the Homa part. */
> +	hsk->sock.sk_sndbuf = homa->wmem_max;
> +
> +	/* Initialize Homa-specific fields. */
> +	spin_lock_bh(&socktab->write_lock);
> +	atomic_set(&hsk->protect_count, 0);
> +	spin_lock_init(&hsk->lock);
> +	atomic_set(&hsk->protect_count, 0);

Duplicate 'atomic_set(&hsk->protect_count, 0);' statement above

> +	hsk->homa = homa;
> +	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET)
> +			? HOMA_IPV4_HEADER_LENGTH : HOMA_IPV6_HEADER_LENGTH;
> +	hsk->is_server = false;
> +	hsk->shutdown = false;
> +	starting_port = homa->prev_default_port;
> +	while (1) {
> +		homa->prev_default_port++;
> +		if (homa->prev_default_port < HOMA_MIN_DEFAULT_PORT)
> +			homa->prev_default_port = HOMA_MIN_DEFAULT_PORT;
> +		other = homa_sock_find(socktab, homa->prev_default_port);
> +		if (!other)
> +			break;
> +		sock_put(&other->sock);
> +		if (homa->prev_default_port == starting_port) {
> +			spin_unlock_bh(&socktab->write_lock);
> +			hsk->shutdown = true;
> +			return -EADDRNOTAVAIL;
> +		}
> +	}
> +	hsk->port = homa->prev_default_port;
> +	hsk->inet.inet_num = hsk->port;
> +	hsk->inet.inet_sport = htons(hsk->port);

The above code looks like a bind() operation, but it's unclear why it's
peformend at init time.

> +	hlist_add_head_rcu(&hsk->socktab_links,
> +			   &socktab->buckets[homa_port_hash(hsk->port)]);
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

I'm under the impression that using rhashtable for both the client and
the server rpcs will deliver both more efficient memory usage and better
performances.

> +	hsk->buffer_pool = homa_pool_new(hsk);
> +	if (IS_ERR(hsk->buffer_pool)) {
> +		result = PTR_ERR(hsk->buffer_pool);
> +		hsk->buffer_pool = NULL;
> +	}
> +	spin_unlock_bh(&socktab->write_lock);
> +	return result;
> +}
> +
> +/*
> + * homa_sock_unlink() - Unlinks a socket from its socktab and does
> + * related cleanups. Once this method returns, the socket will not be
> + * discoverable through the socktab.
> + * @hsk:  Socket to unlink.
> + */
> +void homa_sock_unlink(struct homa_sock *hsk)
> +{
> +	struct homa_socktab *socktab = hsk->homa->port_map;
> +
> +	spin_lock_bh(&socktab->write_lock);
> +	hlist_del_rcu(&hsk->socktab_links);
> +	spin_unlock_bh(&socktab->write_lock);
> +}
> +
> +/**
> + * homa_sock_shutdown() - Disable a socket so that it can no longer
> + * be used for either sending or receiving messages. Any system calls
> + * currently waiting to send or receive messages will be aborted.
> + * @hsk:       Socket to shut down.
> + */
> +void homa_sock_shutdown(struct homa_sock *hsk)
> +{
> +	struct homa_interest *interest;
> +	struct homa_rpc *rpc;
> +	u64 tx_memory;
> +
> +	homa_sock_lock(hsk);
> +	if (hsk->shutdown) {
> +		homa_sock_unlock(hsk);
> +		return;
> +	}
> +
> +	/* The order of cleanup is very important, because there could be
> +	 * active operations that hold RPC locks but not the socket lock.
> +	 * 1. Set @shutdown; this ensures that no new RPCs will be created for
> +	 *    this socket (though some creations might already be in progress).
> +	 * 2. Remove the socket from its socktab: this ensures that
> +	 *    incoming packets for the socket will be dropped.
> +	 * 3. Go through all of the RPCs and delete them; this will
> +	 *    synchronize with any operations in progress.
> +	 * 4. Perform other socket cleanup: at this point we know that
> +	 *    there will be no concurrent activities on individual RPCs.
> +	 * 5. Don't delete the buffer pool until after all of the RPCs
> +	 *    have been reaped.
> +	 * See sync.txt for additional information about locking.
> +	 */
> +	hsk->shutdown = true;
> +	homa_sock_unlink(hsk);
> +	homa_sock_unlock(hsk);
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
> +		homa_rpc_lock(rpc);
> +		homa_rpc_end(rpc);
> +		homa_rpc_unlock(rpc);
> +	}
> +	rcu_read_unlock();
> +
> +	homa_sock_lock(hsk);
> +	while (!list_empty(&hsk->interests)) {
> +		interest = list_first_entry(&hsk->interests,
> +					    struct homa_interest, links);
> +		__list_del_entry(&interest->links);
> +		atomic_set_release(&interest->ready, 1);
> +		wake_up(&interest->wait_queue);
> +	}
> +	homa_sock_unlock(hsk);
> +
> +	while (!list_empty(&hsk->dead_rpcs))
> +		homa_rpc_reap(hsk, 1000);
> +
> +	tx_memory = refcount_read(&hsk->sock.sk_wmem_alloc);
> +	if (tx_memory != 1) {
> +		pr_err("%s found sk_wmem_alloc %llu bytes, port %d\n",
> +			__func__, tx_memory, hsk->port);
> +	}

Just:
	WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc) != 1);

> +
> +	if (hsk->buffer_pool) {
> +		homa_pool_destroy(hsk->buffer_pool);
> +		hsk->buffer_pool = NULL;
> +	}
> +}
> +
> +/**
> + * homa_sock_destroy() - Destructor for homa_sock objects. This function
> + * only cleans up the parts of the object that are owned by Homa.
> + * @hsk:       Socket to destroy.
> + */
> +void homa_sock_destroy(struct homa_sock *hsk)
> +{
> +	homa_sock_shutdown(hsk);
> +	sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);

Why the flag is set only now and not at creation time?

[...]
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

This is probably a bit too large to be unconditionally allocated for
each netns. You are probably better off with a global hash table, with
the lookup key including the netns itself.

[...]
> +/**
> + * homa_sock_lock() - Acquire the lock for a socket.
> + * @hsk:     Socket to lock.
> + */
> +static inline void homa_sock_lock(struct homa_sock *hsk)
> +	__acquires(&hsk->lock)
> +{
> +	spin_lock_bh(&hsk->lock);

I was wondering how the hsk socket lock could be nested under a
spinlock... The above can't work, unless you prevent any core and
inet-related operations on hsk sockets. That in turn means duplicate
entirely a lot of code or preventing a lot of basic stuff from working
on homa sockets.

Home sockets are still inet ones. It's expected that SOL_SOCKET and
SOL_IP[V6] socket options work on them (or at least could be implemented).

I think this point is very critical.

Somewhat related: the patch order makes IMHO the review complex, because
I often need to look to the following patches to get needed context.

/P


