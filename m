Return-Path: <netdev+bounces-187711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87813AA9184
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D7E18841D9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3581FF1AD;
	Mon,  5 May 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UldacciB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE31F4CA9
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443209; cv=none; b=UFJKSk+aXHHJP8fIXj48TuBrQ7mYPxprf54iNRWSojNbmtT39oqnvRBQzC3XSGv1Acql6g5ixJxl/LG+7AIAAwYT/bLrj6Hmxf9oOntAVA39PkWkF1O7LiH5kGv4Fkn2C1wPWo0NsGhKif1rfHIJdrYYwPPLOWLxn8LqQ/DDnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443209; c=relaxed/simple;
	bh=iv/eRYBIHwjOOaQhymv23NM4jlHCU1g6GSEHi6JOnLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzHw8sXIiJ4vcRxa4a6apd5s1EsGrKmjxN1FvAbrvm7NZckUQTTUB6GUiMKwXCdv96CUMZatgkLoOcc4/do4OROeT5KvQXSjMoePN62F324BVfim63D1KqRCgi5ZSzMsNfmnaTq9R88d6gpXWA0MsHpoVzUmgofizSewNDPZAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UldacciB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746443206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mkgq91PgYNkfx7kaYEEWx+n1fYXclhNChD1pmbxuc7k=;
	b=UldacciBuoHp9mASEZbMtUrxwwQPB4IZs2aW7Yi3dQ/yCm2ofk0H1JftMrmLtCV0DzG9eP
	epX0O0nCmR4H3xxaQfDtzCJ54QvwDo41WMB9y26RyEnkNLsmDctA1W7fbp8AuRh0jXVfe7
	h4KuAAQS8CJ8yF5HKhSiW6cypG5s8G8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-wLL3t_s-OhyR0BiFAi3kDA-1; Mon, 05 May 2025 07:06:45 -0400
X-MC-Unique: wLL3t_s-OhyR0BiFAi3kDA-1
X-Mimecast-MFC-AGG-ID: wLL3t_s-OhyR0BiFAi3kDA_1746443204
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso30483345e9.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 04:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746443204; x=1747048004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mkgq91PgYNkfx7kaYEEWx+n1fYXclhNChD1pmbxuc7k=;
        b=KVwX8nxsrluY97vC5F4a87TfxcX1RxgL+qErgyzzW6zx9RoENfnNm+2DcbeEUmPhhH
         MCdiXRpn3JL21kNLSfyvinak9HhANHgvlA6LHkoBbtBRn3geFWGQ/1cT93j3MkIh3TB4
         m2BTUHlnaYP8w0zdmmz/d7RDa42OXm0lf56gvklTqhRzusolMbRq7ffacJLYU3Wj7AAM
         2ssabMn56uwwcXB/6Fm3f72VdOmilY/6qB2PTZGzOcROJluBjHVniYAktMrKqChJgs5G
         yVamd9oilV04MaTYt40eNHi1/J7Cjk5LzU0XvZoMH5/DZ//A+zHVuWRQp0efQcTQMh10
         tnUg==
X-Forwarded-Encrypted: i=1; AJvYcCWyjcyn1cjVKcW3Fv1ShKEyPzGvFbxqrLzC33GhHZ7xefDHYfcwlFfOPnzYsMcPPxj0jvir1Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9N6EExGRRgSZvvrYgQbWgDZI/Ty4kuou6eECBr5Gumr0QY+/g
	Yo2izg9AVOAyLGcyZUJ2rQVNmfszi9w7wnPPj//Y2EXxuilBEAJJFmF7QcCh3aqIU/ihDMdHdEK
	55BJoZt4dpRMHltAwXlKDgBqwePvOkmZ2ws/kpK/1r1KVkHdJyVARVQ==
X-Gm-Gg: ASbGnctbTf0FDaFaXiwfNUnl9KJQ/J2uebtO3PjLOv6sUbZFyCQ1TippxmVsWO+l4ME
	hSE9QfMTyQLOjSqH3MXuuclnOqZv2Y2NStPAPmg9KC7WojRslKGWEmUJkla0xcmWVurpKoykWrq
	dWnbbi4SRfRNibEOtCiXUHTy0yGjq5nW+xVdD02IX5yQR0L/FMRoxLsQb4CHiNEYu9yYfKIkdEm
	MGqaKhU6ALwSZdAhTFfsAVr8ges7jl7riNJxyq8+8J3kKrd0l+mkWOgx/BBLF/929P3ARnZn/WO
	i7iX50g47HW2povmuJe1EQW37nXh7EXjPVXgDC/x19MALHv+HD1KvvH5DAg=
X-Received: by 2002:a05:6000:18a5:b0:399:737f:4e02 with SMTP id ffacd0b85a97d-3a09fdbe68emr5322935f8f.39.1746443203968;
        Mon, 05 May 2025 04:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+qYro0AVUqEXciacQp2awrtTh3oBuQW9n10CMa03sF1boAjnxNruymZFCZGd7fCUzq98zHw==
X-Received: by 2002:a05:6000:18a5:b0:399:737f:4e02 with SMTP id ffacd0b85a97d-3a09fdbe68emr5322915f8f.39.1746443203526;
        Mon, 05 May 2025 04:06:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffd5sm10101291f8f.70.2025.05.05.04.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 04:06:43 -0700 (PDT)
Message-ID: <4350bd09-9aad-491c-a38d-08249f082b6d@redhat.com>
Date: Mon, 5 May 2025 13:06:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 05/15] net: homa: create homa_peer.h and
 homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-6-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-6-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
[...]
> +{
> +	/* Note: when we return, the object must be initialized so it's
> +	 * safe to call homa_peertab_destroy, even if this function returns
> +	 * an error.
> +	 */
> +	int i;
> +
> +	spin_lock_init(&peertab->write_lock);
> +	INIT_LIST_HEAD(&peertab->dead_dsts);
> +	peertab->buckets = vmalloc(HOMA_PEERTAB_BUCKETS *
> +				   sizeof(*peertab->buckets));

This struct looks way too big to be allocated on per netns basis. You
should use a global table and include the netns in the lookup key.

> +	if (!peertab->buckets)
> +		return -ENOMEM;
> +	for (i = 0; i < HOMA_PEERTAB_BUCKETS; i++)
> +		INIT_HLIST_HEAD(&peertab->buckets[i]);
> +	return 0;
> +}
> +
> +/**
> + * homa_peertab_destroy() - Destructor for homa_peertabs. After this
> + * function returns, it is unsafe to use any results from previous calls
> + * to homa_peer_find, since all existing homa_peer objects will have been
> + * destroyed.
> + * @peertab:  The table to destroy.
> + */
> +void homa_peertab_destroy(struct homa_peertab *peertab)
> +{
> +	struct hlist_node *next;
> +	struct homa_peer *peer;
> +	int i;
> +
> +	if (!peertab->buckets)
> +		return;
> +
> +	spin_lock_bh(&peertab->write_lock);
> +	for (i = 0; i < HOMA_PEERTAB_BUCKETS; i++) {
> +		hlist_for_each_entry_safe(peer, next, &peertab->buckets[i],
> +					  peertab_links) {
> +			dst_release(peer->dst);
> +			kfree(peer);
> +		}
> +	}
> +	vfree(peertab->buckets);
> +	homa_peertab_gc_dsts(peertab, ~0);
> +	spin_unlock_bh(&peertab->write_lock);
> +}
> +
> +/**
> + * homa_peertab_gc_dsts() - Invoked to free unused dst_entries, if it is
> + * safe to do so.
> + * @peertab:       The table in which to free entries.
> + * @now:           Current time, in sched_clock() units; entries with expiration
> + *                 dates no later than this will be freed. Specify ~0 to
> + *                 free all entries.
> + */
> +void homa_peertab_gc_dsts(struct homa_peertab *peertab, u64 now)
> +	__must_hold(&peer_tab->write_lock)
> +{
> +	while (!list_empty(&peertab->dead_dsts)) {
> +		struct homa_dead_dst *dead =
> +			list_first_entry(&peertab->dead_dsts,
> +					 struct homa_dead_dst, dst_links);
> +		if (dead->gc_time > now)
> +			break;
> +		dst_release(dead->dst);
> +		list_del(&dead->dst_links);
> +		kfree(dead);
> +	}
> +}
> +
> +/**
> + * homa_peer_find() - Returns the peer associated with a given host; creates
> + * a new homa_peer if one doesn't already exist.
> + * @peertab:    Peer table in which to perform lookup.
> + * @addr:       Address of the desired host: IPv4 addresses are represented
> + *              as IPv4-mapped IPv6 addresses.
> + * @inet:       Socket that will be used for sending packets.
> + *
> + * Return:      The peer associated with @addr, or a negative errno if an
> + *              error occurred. The caller can retain this pointer
> + *              indefinitely: peer entries are never deleted except in
> + *              homa_peertab_destroy.
> + */
> +struct homa_peer *homa_peer_find(struct homa_peertab *peertab,
> +				 const struct in6_addr *addr,
> +				 struct inet_sock *inet)
> +{
> +	struct homa_peer *peer;
> +	struct dst_entry *dst;
> +
> +	u32 bucket = hash_32((__force u32)addr->in6_u.u6_addr32[0],
> +			       HOMA_PEERTAB_BUCKET_BITS);
> +
> +	bucket ^= hash_32((__force u32)addr->in6_u.u6_addr32[1],
> +			  HOMA_PEERTAB_BUCKET_BITS);
> +	bucket ^= hash_32((__force u32)addr->in6_u.u6_addr32[2],
> +			  HOMA_PEERTAB_BUCKET_BITS);
> +	bucket ^= hash_32((__force u32)addr->in6_u.u6_addr32[3],
> +			  HOMA_PEERTAB_BUCKET_BITS);
> +
> +	/* Use RCU operators to ensure safety even if a concurrent call is
> +	 * adding a new entry. The calls to rcu_read_lock and rcu_read_unlock
> +	 * shouldn't actually be needed, since we don't need to protect
> +	 * against concurrent deletion.
> +	 */
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(peer, &peertab->buckets[bucket],
> +				 peertab_links) {
> +		if (ipv6_addr_equal(&peer->addr, addr)) {
> +			rcu_read_unlock();
> +			return peer;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	/* No existing entry; create a new one.
> +	 *
> +	 * Note: after we acquire the lock, we have to check again to
> +	 * make sure the entry still doesn't exist (it might have been
> +	 * created by a concurrent invocation of this function).
> +	 */
> +	spin_lock_bh(&peertab->write_lock);
> +	hlist_for_each_entry(peer, &peertab->buckets[bucket],
> +			     peertab_links) {
> +		if (ipv6_addr_equal(&peer->addr, addr))
> +			goto done;
> +	}
> +	peer = kmalloc(sizeof(*peer), GFP_ATOMIC | __GFP_ZERO);

Please, move the allocation outside the atomic scope and use GFP_KERNEL.

> +	if (!peer) {
> +		peer = (struct homa_peer *)ERR_PTR(-ENOMEM);
> +		goto done;
> +	}
> +	peer->addr = *addr;
> +	dst = homa_peer_get_dst(peer, inet);
> +	if (IS_ERR(dst)) {
> +		kfree(peer);
> +		peer = (struct homa_peer *)PTR_ERR(dst);
> +		goto done;
> +	}
> +	peer->dst = dst;
> +	hlist_add_head_rcu(&peer->peertab_links, &peertab->buckets[bucket]);

At this point another CPU can lookup 'peer'. Since there are no memory
barriers it could observe a NULL peer->dst.

Also AFAICS new peers are always added when lookup for a different
address fail and deleted only at netns shutdown time (never for the initns).

You need to:
- account the memory used for peer
- enforce an upper bound for the total number of peers (per netns),
eventually freeing existing old ones.

Note that freeing the peer at 'runtime' will require additional changes:
i.e. likely refcounting will be beeded or the at lookup time, after the
rcu unlock the code could hit HaF while accessing the looked-up peer.


> +	peer->current_ticks = -1;
> +	spin_lock_init(&peer->ack_lock);
> +
> +done:
> +	spin_unlock_bh(&peertab->write_lock);
> +	return peer;
> +}
> +
> +/**
> + * homa_dst_refresh() - This method is called when the dst for a peer is
> + * obsolete; it releases that dst and creates a new one.
> + * @peertab:  Table containing the peer.
> + * @peer:     Peer whose dst is obsolete.
> + * @hsk:      Socket that will be used to transmit data to the peer.
> + */
> +void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer *peer,
> +		      struct homa_sock *hsk)
> +{
> +	struct homa_dead_dst *save_dead;
> +	struct dst_entry *dst;
> +	u64 now;
> +
> +	/* Need to keep around the current entry for a while in case
> +	 * someone is using it. If we can't do that, then don't update
> +	 * the entry.
> +	 */
> +	save_dead = kmalloc(sizeof(*save_dead), GFP_ATOMIC);
> +	if (unlikely(!save_dead))
> +		return;
> +
> +	dst = homa_peer_get_dst(peer, &hsk->inet);
> +	if (IS_ERR(dst)) {
> +		kfree(save_dead);
/> +		return;
> +	}
> +
> +	spin_lock_bh(&peertab->write_lock);
> +	now = sched_clock();

Use jiffies instead.

> +	save_dead->dst = peer->dst;
> +	save_dead->gc_time = now + 100000000;   /* 100 ms */
> +	list_add_tail(&save_dead->dst_links, &peertab->dead_dsts);
> +	homa_peertab_gc_dsts(peertab, now);
> +	peer->dst = dst;
> +	spin_unlock_bh(&peertab->write_lock);

It's unclear to me why you need this additional GC layer on top's of the
core one.

[...]
> +static inline struct dst_entry *homa_get_dst(struct homa_peer *peer,
> +					     struct homa_sock *hsk)
> +{
> +	if (unlikely(peer->dst->obsolete > 0))

you need to additionally call dst->ops->check

/P


