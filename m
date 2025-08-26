Return-Path: <netdev+bounces-216865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D959B358FC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403663A5ECF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4EF3093BD;
	Tue, 26 Aug 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dh/0Q7YA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAC30BF59
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200786; cv=none; b=NseReJkV8Eh7lkGp5ngMtrzhVfIsyN0GYJmM1bqgL2LrKHYtGs2OWJYfoxeqBw4MX9Z9q7Zb20z8XgDRVVDtep1io6RdrkxN++gEMCB8T43Sr/ZwvSsYsBdD+kFW177KpF+RQVVIH9jRU2E7J3Fhqd0PvtlA4G87yJ6x88m2nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200786; c=relaxed/simple;
	bh=mGY86PTjeHrEveCs3zgwOygyQECOsIxukKv4uTBDR+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9A8dtiQObPo9bG9xpi8hrFCcmruRR0gFax6ItmPHw5ogjXOa56CWmcrQl6S7mDDN43qZe/NLTEYu7JnD3UZ8foOHaPqfS6tIWtlQUYIRWdUGUJBTFpN5GdZA+aEYjBh0A16cHxhSAEe2ctV/0aW58QMWJbc68ju7l4n+KCpmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dh/0Q7YA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756200783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qz3z0geps2Q+wAm2DN9F8ELlUIzHmTTDscjASAdL8H8=;
	b=dh/0Q7YAG+ZKLaclqkwX8a0eve9mXAACRPG/ZqrGB8nhthKcER2YZiQZ5OHBPEi3OujOSD
	HrFEddG1fUXTZdMsxfWOo9qUWulTnn1x/cvnTPyKKzvE3lMGl9/R0UQAuBprl6i0mCT3Q/
	a1b2p5fOhHQFzUCpoz9rsgnQGhfEZDQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-8MfF51YKMgmtjiZ7wmdLLw-1; Tue, 26 Aug 2025 05:33:01 -0400
X-MC-Unique: 8MfF51YKMgmtjiZ7wmdLLw-1
X-Mimecast-MFC-AGG-ID: 8MfF51YKMgmtjiZ7wmdLLw_1756200781
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70db892e7b2so43623006d6.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 02:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200781; x=1756805581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz3z0geps2Q+wAm2DN9F8ELlUIzHmTTDscjASAdL8H8=;
        b=Vm6cHVFKN2Hd91b1AjeToh7nlLPPidP2QLJy6IkM7VA8RnZQYv0Qde/rvyL3UD5Dac
         a745K4zSRoM4DajrQlMhU6QyhVG76dNvyjZGLe2wIf5OQ3LShDJVz9Z8u9qD/v83fnjx
         0x9ZbPg6I8EYOonJlS5FFcKAOEquPk/JhMIKS0ISoF8ch56IbZdual6qk0PXdM4N7z5C
         y6Xw0qOynbUvi0FsQzYWOS66prLlYVO1ekrq4gwpa5yzm66osIxSkXt/f98kUm83GEGj
         G9MfrchN7enp9n2zsTqNV/ttpM5BOXPvbCCNYCT9FdyCBQFz4i3aURnhfrJPzdcNnzkl
         643A==
X-Forwarded-Encrypted: i=1; AJvYcCWOLJ0sN5y+0NOpGYkopN9kzdtAEhpneBr0C9MuHA/4BpMuHaoQZAGAKWWzI4zT3Ziz8ndm9nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4GmlrpSPXu5Q82XYBzEYslkWQMtLDPHOXGOZm3hPGrbx/iVe
	Tmyns3LphZrOufzbuUjWJ8ID2CTo2BLDOyn5IyI6khF+6QgM8+7HKLALu7jB31Xk53uQAlgr/6I
	FYCCuw+vth82no+2XIaomZCe6xrq50EMxnfTVsbwG7q2+RsUwHmbxlJAblw==
X-Gm-Gg: ASbGnctYyh3W67H1rMpfrwGq+RZ1HAJhJnsck2V2UBduzG5sMd2lK+wPgT1N77jvmLy
	/HD+jJNLQduwy7lr48c0d3/fz15VPg6JWN6ScUrfZaqJR1OxG5Y2vyOuNm8ndfvmG1zoWwdAQmL
	DnXDPMO9VhsavdGEtd0FiPS7ATb3ZIoWBLUlWI65ng8QEw5iqwNWmgizzqoHmxlQRjXzO4bAxvl
	eda0E1jLXjnuENsYyqrHPFCKKrt41SF2qoNOxKTzjMj8dvv+tdY538QVWDaINsPJrzZr0EAkcdB
	wmnvOeCTWhVJUdVbhQcQmG8qT1CKVSmMM2mdjbPHJ6xQnHE/oTi1dICEpYEXdcviqSxKKig9WcW
	FfCJBI4BbyAo=
X-Received: by 2002:a05:6214:ac2:b0:70d:c8d6:d9bd with SMTP id 6a1803df08f44-70dc8d6daf7mr41531676d6.35.1756200781102;
        Tue, 26 Aug 2025 02:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7JKnuP/3fzzr7+TVzgn8RBKOn4F7l+eniokudLdrJeMRNzIUge4QWqK50z9G84ORC0AVA8Q==
X-Received: by 2002:a05:6214:ac2:b0:70d:c8d6:d9bd with SMTP id 6a1803df08f44-70dc8d6daf7mr41531486d6.35.1756200780518;
        Tue, 26 Aug 2025 02:33:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72d075bsm63186236d6.65.2025.08.26.02.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:32:59 -0700 (PDT)
Message-ID: <66dff631-3f6d-4a7c-b0f2-627c25c49967@redhat.com>
Date: Tue, 26 Aug 2025 11:32:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 05/15] net: homa: create homa_peer.h and
 homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-6-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-6-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * homa_peer_rcu_callback() - This function is invoked as the callback
> + * for an invocation of call_rcu. It just marks a peertab to indicate that
> + * it was invoked.
> + * @head:    Contains information used to locate the peertab.
> + */
> +void homa_peer_rcu_callback(struct rcu_head *head)
> +{
> +	struct homa_peertab *peertab;
> +
> +	peertab = container_of(head, struct homa_peertab, rcu_head);
> +	atomic_set(&peertab->call_rcu_pending, 0);
> +}

The free schema is quite convoluted and different from the usual RCU
handling. Why don't you simply call_rcu() on the given peer once that
the refcount reaches zero?

> +
> +/**
> + * homa_peer_free_dead() - Release peers on peertab->dead_peers
> + * if possible.
> + * @peertab:    Check the dead peers here.
> + */
> +void homa_peer_free_dead(struct homa_peertab *peertab)
> +	__must_hold(peertab->lock)
> +{
> +	struct homa_peer *peer, *tmp;
> +
> +	/* A dead peer can be freed only if:
> +	 * (a) there are no call_rcu calls pending (if there are, it's
> +	 *     possible that a new reference might get created for the
> +	 *     peer)
> +	 * (b) the peer's reference count is zero.
> +	 */
> +	if (atomic_read(&peertab->call_rcu_pending))
> +		return;
> +	list_for_each_entry_safe(peer, tmp, &peertab->dead_peers, dead_links) {
> +		if (atomic_read(&peer->refs) == 0) {
> +			list_del_init(&peer->dead_links);
> +			homa_peer_free(peer);
> +		}
> +	}
> +}
> +
> +/**
> + * homa_peer_wait_dead() - Don't return until all of the dead peers have
> + * been freed.
> + * @peertab:    Overall information about peers, which includes a dead list.
> + *
> + */
> +void homa_peer_wait_dead(struct homa_peertab *peertab)
> +{
> +	while (1) {
> +		spin_lock_bh(&peertab->lock);
> +		homa_peer_free_dead(peertab);
> +		if (list_empty(&peertab->dead_peers)) {
> +			spin_unlock_bh(&peertab->lock);
> +			return;
> +		}
> +		spin_unlock_bh(&peertab->lock);
> +	}
> +}

Apparently unused.

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
> +	struct dst_entry *dst;
> +
> +	dst = homa_peer_get_dst(peer, hsk);
> +	if (IS_ERR(dst))
> +		return;
> +	dst_release(peer->dst);
> +	peer->dst = dst;

Why the above does not need any lock? Can multiple RPC race on the same
peer concurrently?

> +/**
> + * struct homa_peer - One of these objects exists for each machine that we
> + * have communicated with (either as client or server).
> + */
> +struct homa_peer {
> +	/** @ht_key: The hash table key for this peer in peertab->ht. */
> +	struct homa_peer_key ht_key;
> +
> +	/**
> +	 * @ht_linkage: Used by rashtable implement to link this peer into
> +	 * peertab->ht.
> +	 */
> +	struct rhash_head ht_linkage;
> +
> +	/** @dead_links: Used to link this peer into peertab->dead_peers. */
> +	struct list_head dead_links;
> +
> +	/**
> +	 * @refs: Number of unmatched calls to homa_peer_hold; it's not safe
> +	 * to free this object until the reference count is zero.
> +	 */
> +	atomic_t refs ____cacheline_aligned_in_smp;

Please use refcount_t instead.

> +/**
> + * homa_peer_hash() - Hash function used for @peertab->ht.
> + * @data:    Pointer to key for which a hash is desired. Must actually
> + *           be a struct homa_peer_key.
> + * @dummy:   Not used
> + * @seed:    Seed for the hash.
> + * Return:   A 32-bit hash value for the given key.
> + */
> +static inline u32 homa_peer_hash(const void *data, u32 dummy, u32 seed)
> +{
> +	/* This is MurmurHash3, used instead of the jhash default because it
> +	 * is faster (25 ns vs. 40 ns as of May 2025).
> +	 */
> +	BUILD_BUG_ON(sizeof(struct homa_peer_key) & 0x3);

It's likely worthy to place the hash function implementation in a
standalone header.

> +	const u32 len = sizeof(struct homa_peer_key) >> 2;
> +	const u32 c1 = 0xcc9e2d51;
> +	const u32 c2 = 0x1b873593;
> +	const u32 *key = data;
> +	u32 h = seed;
> +
> +	for (size_t i = 0; i < len; i++) {
> +		u32 k = key[i];
> +
> +		k *= c1;
> +		k = (k << 15) | (k >> (32 - 15));
> +		k *= c2;
> +
> +		h ^= k;
> +		h = (h << 13) | (h >> (32 - 13));
> +		h = h * 5 + 0xe6546b64;
> +	}
> +
> +	h ^= len * 4;  // Total number of input bytes

Please avoid C99 comments

/P


