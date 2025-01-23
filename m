Return-Path: <netdev+bounces-160634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83DA1A9E5
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD718876A7
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8713D882;
	Thu, 23 Jan 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+cF81AG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7E84A30
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658925; cv=none; b=UqWh9dOKo+3/MaQR59+zmmDZCgm0YcmRSjNDE4jGvUjYzVR2folR6kenDhj026jRWoEag4rj3VJ7e82Z9+ZBcUw92ZTARGxrkHNbHw4C+tk091TUN4vadnLvkvrzAp157FBcnjS3ODLPfG7Q7RuPVHkLCMpbVqwH2ydgVieci6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658925; c=relaxed/simple;
	bh=G9apLtpHGIxiKMzwtubHnUEWDirDN0HBkEDSQodyMcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOzvNJUY3IEGFBNJMnLuzZkHZ40qswfBRxNhzuCOeu9F1mpA1UPYVkqCynOvCGbbsDGiEU22gbbNfFdM5A4G14Z4TmOXgjfP8YvkExoAlv9Yh5NGhn2C7QYBRF6MhipSuk70cwRp+60lY3Y/ZJ4Asy1HZEhl+WvbdhVGtTPVr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+cF81AG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737658922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mPNvJfGh64nZZjsCz85JqzEt3F3mFMWV7vxnP+GsFI=;
	b=L+cF81AG1rX1sy9oqc1NZddbJCb4lp1j4MZ/gZHDMsm4V8yvwiz/5ChEfur7nT2YPh6bk4
	lIsjME+CfzNjwbyQnhpJYCfjtXNG0v99XUXu8pqTyOn1b5vL83zENW8W6rckTucjST2BMv
	WSpd+XRVrFrnGWRBKoQLOO8GY+krG+Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Eo6VGKnQMOiInNhG8JlSDA-1; Thu, 23 Jan 2025 14:02:00 -0500
X-MC-Unique: Eo6VGKnQMOiInNhG8JlSDA-1
X-Mimecast-MFC-AGG-ID: Eo6VGKnQMOiInNhG8JlSDA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43646b453bcso6373715e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737658919; x=1738263719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mPNvJfGh64nZZjsCz85JqzEt3F3mFMWV7vxnP+GsFI=;
        b=R9zdPiYkc2up6tVxDvJ8Rg2mBxm0C8bNEWfPFuZ2ltxaAjircaA7xjvu443T1v/6W2
         +r4bJJJbQwL9R16nBza8sLfObgSmnEO8SbNrdBHgUyiKUoVDsAy2Z7LOJyZqZNHSOR1e
         osXBc82MAQmJZ5MYZCFl0+AlyDBTdUdQNyyFeCKOutnsvdsGRhzUrY9Ty5V8/O1MBRhC
         nSCQ34JhjMaZAftFr1aG9ZmrXns4M97BCwbUQET+LPvmRjLySOraIqKv5tf4fSyGIsaT
         abX7mnvadpt/pl2rSthgLZAnGctKneJw6JWDSMWbUE9zDf4ojQDe3BAHdBj/sxrQx8Jy
         LFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU2LSLGRZgqjjcA868QUrh1YtXSSMuYNuEiEtPrVttc/KQK1UdIZyq7tzxhsBi7zJGFKnSRqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwlbzrxmvCb29pH7TYkSYGLFoRJzYgA0dXg6lI2eyohC64PFN
	3ZBF5bsc80PpVRG+B8tmtIvR3etiOjx50EQAkY7t72nheP4Dm3rBEyvlVqyIg4ksgu8jQ9w8ha0
	9efZ/eC+ddU6S78o6XE4vvU0uu5foH/ctiVIJQ9DBm9BSsSXP7Cn0Tg==
X-Gm-Gg: ASbGncsLb7WY8jLAnlMphEMEE1A/c0oHSxSbsr4zU8pCha3a717vUaB8PU/JBZp2Ucd
	voGdV57naXOp5tLwI2CaAPuzb0rTnVWQfhPVTmuA+XP27MFbINvVXr4DaaI+4DMf7lmkRV32ZoS
	laaYl4JBEiUVa4IvDBiVS/HYyDclwlmtONCSKC9yZg48T2ZHt3XOQuxzD2Ss2crqM4mn0Vm0lK8
	8YiwQOcORbzFTDUDqT+IbpRnt99jP4kwCJMak+56UW7IOkEu7yu+T+BrXa3ysVA1qbAyyjTPeDw
	qMizQgJ+q6EJHnTA/PqbEHRv
X-Received: by 2002:a05:600c:3149:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4389144e70fmr262727275e9.29.1737658919254;
        Thu, 23 Jan 2025 11:01:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMmO3GYwTRN8UifA7ysj1drxx2yP0mFSuDTSsplzxqFIrQcUEF5/U2i1Vk78i5MThheNfsVA==
X-Received: by 2002:a05:600c:3149:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4389144e70fmr262726855e9.29.1737658918849;
        Thu, 23 Jan 2025 11:01:58 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48a145sm1234265e9.16.2025.01.23.11.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:01:58 -0800 (PST)
Message-ID: <028f492f-41db-4c70-9527-cf0db03da4df@redhat.com>
Date: Thu, 23 Jan 2025 20:01:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and
 homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-8-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-8-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> +	spin_unlock_bh(&socktab->write_lock);
> +
> +	return homa_socktab_next(scan);
> +}
> +
> +/**
> + * homa_socktab_next() - Return the next socket in an iteration over a socktab.
> + * @scan:      State of the scan.
> + *
> + * Return:     The next socket in the table, or NULL if the iteration has
> + *             returned all of the sockets in the table. Sockets are not
> + *             returned in any particular order. It's possible that the
> + *             returned socket has been destroyed.
> + */
> +struct homa_sock *homa_socktab_next(struct homa_socktab_scan *scan)
> +{
> +	struct homa_socktab_links *links;
> +	struct homa_sock *hsk;
> +
> +	while (1) {
> +		while (!scan->next) {
> +			struct hlist_head *bucket;
> +
> +			scan->current_bucket++;
> +			if (scan->current_bucket >= HOMA_SOCKTAB_BUCKETS)
> +				return NULL;
> +			bucket = &scan->socktab->buckets[scan->current_bucket];
> +			scan->next = (struct homa_socktab_links *)
> +				      rcu_dereference(hlist_first_rcu(bucket));

The only caller for this function so far is not under RCU lock: you
should see a splat here if you build and run this code with:

CONFIG_LOCKDEP=y

(which in turn is highly encouraged)

> +		}
> +		links = scan->next;
> +		hsk = links->sock;
> +		scan->next = (struct homa_socktab_links *)
> +				rcu_dereference(hlist_next_rcu(&links->hash_links));

homa_socktab_links is embedded into the home sock; if the RCU protection
is released and re-acquired after a homa_socktab_next() call, there is
no guarantee links/hsk are still around and the above statement could
cause UaF.

This homa_socktab things looks quite complex. A simpler implementation
could use a simple RCU list _and_ acquire a reference to the hsk before
releasing the RCU lock.

> +		return hsk;
> +	}
> +}
> +
> +/**
> + * homa_socktab_end_scan() - Must be invoked on completion of each scan
> + * to clean up state associated with the scan.
> + * @scan:      State of the scan.
> + */
> +void homa_socktab_end_scan(struct homa_socktab_scan *scan)
> +{
> +	spin_lock_bh(&scan->socktab->write_lock);
> +	list_del(&scan->scan_links);
> +	spin_unlock_bh(&scan->socktab->write_lock);
> +}
> +
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
> +	int starting_port;
> +	int result = 0;
> +	int i;
> +
> +	spin_lock_bh(&socktab->write_lock);

A single contended lock for the whole homa sock table? Why don't you use
per bucket locks?

[...]
> +struct homa_rpc_bucket {
> +	/**
> +	 * @lock: serves as a lock both for this bucket (e.g., when
> +	 * adding and removing RPCs) and also for all of the RPCs in
> +	 * the bucket. Must be held whenever manipulating an RPC in
> +	 * this bucket. This dual purpose permits clean and safe
> +	 * deletion and garbage collection of RPCs.
> +	 */
> +	spinlock_t lock;
> +
> +	/** @rpcs: list of RPCs that hash to this bucket. */
> +	struct hlist_head rpcs;
> +
> +	/**
> +	 * @id: identifier for this bucket, used in error messages etc.
> +	 * It's the index of the bucket within its hash table bucket
> +	 * array, with an additional offset to separate server and
> +	 * client RPCs.
> +	 */
> +	int id;

On 64 bit arches this struct will have 2 4-bytes holes. If you reorder
the field:
	spinlock_t lock;
	int id;
	struct hlist_head rpcs;

the struct size will decrease by 8 bytes.

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

Why adding this union? Just
	struct inet_sock inet;
would do.

/P


