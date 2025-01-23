Return-Path: <netdev+bounces-160626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B7A1A914
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C7E1889E7B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630014659D;
	Thu, 23 Jan 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK8/ssJ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65814A4D1
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654319; cv=none; b=r5kHeb8ifWdswwRZfbBXoY/491Im6m32WYJ0zCfqttAmZ5UApwvlFaBg3MoFnyIZVXSfCgzz93eDBnRcIF2+jdArZQnVN+hWsKnjAenvclTl8uyTvykjQaZxpuqQ127jFir9W7ElrcLLt+wTZTfvLSmks47yf1yVehPzBfG+/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654319; c=relaxed/simple;
	bh=cuFrawK0/AjFL4au1asXXvINUATD4G5e1QeJ2ahF9eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9xc1pvfK6Tl+BcTYLsYJTmpCAisQ6W5jf0ezG73TXpbIt/32bCmCBk6LwsRM2QYhgfouBVHJw8JOIKIQTUd5NtFTExo4hKx21L7a9DXHR6gHQ8/hzyAnSCEMuqYqQZghMap5fysSA/Tf0KiTqyJx7bqIsA/ZVdOk8CE39yBtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK8/ssJ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737654314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmcZf0OpZkyja4d1Ct34f1VNDJ5QFDsGyx+s8LcNX9Y=;
	b=UK8/ssJ9ydTt6QO7aKPBFehUcqd+B+kcoVen6+6Ppv7k9XmUlOIwv/mMkbRcCXMrjs8XJ/
	fPy8IsfNL9awiapPpGrbKxKNJr40m2Mj8aajy3G4YugYIS0z0m1cAOCt3ZRafNIEIzSoXs
	SMH2MvKEeXL3jMw4vvT/vOfHpogMSjQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-oANBBQvoM76iToALtAIrlg-1; Thu, 23 Jan 2025 12:45:13 -0500
X-MC-Unique: oANBBQvoM76iToALtAIrlg-1
X-Mimecast-MFC-AGG-ID: oANBBQvoM76iToALtAIrlg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a873178f2so674310f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 09:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654312; x=1738259112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmcZf0OpZkyja4d1Ct34f1VNDJ5QFDsGyx+s8LcNX9Y=;
        b=U79FvIw8DgW9KrafJLrrcz7oEZmkULV1HhEbhECjqwSV/tOW6EKbFFnIlGhXIX5bGu
         KlkGzzdyKbmal3aECUwgduQVn0i6yaAZgPiJdyrYyDWFCI0YwqSyI+szHia437Fon8Xq
         RtPXNdPz69jQ0u5wlsL5QmNuempHhqTaPNyPCksIiLQeYxPQIky09BR2UdSwkjMM1rVn
         XNefgq1qCBi0eNk0bGDAIOV6ZVlNGaVFHhjJbho8Hm4xAAxF6roPfw8LMxw44n11SkQb
         rtKK7QU81ThHIZ1u9z8QLmu/04xl5CoIRZLWEF63aQJfHEWkG4xGdvzJ7NLSzvytbnW0
         z0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVNImZVyNcl93js3hfcHUCUJeXJ5qWr3xBkLpoQ+j62Zf7N1qebKD8ZCn6wS6QMNlM3ib4Yk5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/Wf7NGQ/M/Os9urnkalSmR1Ms5mxwLpIEFxN1infOoUA059+
	RoMpIUuuP7UqLMl6qCYilb8lcGTY+EnNlz+yMfM2RYWWmdpVxi8pE7/XqSz6s4/TeZ788fDXvZE
	tFAc1nOjdNW6YC870Xs4sWMETnTfs9eMyDlSEE7p4uZ4v/TmIF5hT5g==
X-Gm-Gg: ASbGncsHm4/o24eyU8P6QIYFW4RxITioewekNvU/qB+MOdTq69Oc0NNcpQi8FQ/f/6x
	FqQv2djWZxDLb/I5Rbsb7x1R1Yg7ERq89oUbiSE/pNiB8s20xPZTnz5b/uYMnKKipMBIxjpg6xQ
	guYabdZFl4AUBxXED137vE+FNbS9w30Lz7bC8MHyAnDiDYNThkirA8Gw32LkDB5WT67QcPfnogg
	F4VRj/cRdBP59gu++AyebG3Uzx7cKz4RXp0rzu+j0orAwSHdLncg9zm+eJ5uzWUVysPmjbA3Sq6
	dq/w8Mrwq+wb1QYvDlRl72lL
X-Received: by 2002:a5d:4dc2:0:b0:386:4034:f9a8 with SMTP id ffacd0b85a97d-38bf57a2911mr24372362f8f.38.1737654311503;
        Thu, 23 Jan 2025 09:45:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4Fo3FDjjHSJEuK8v8tpxtb9lSbJywhJphAzoGtDgKgsxjHAhPuXPRJNlbq8+1W/6Tj3O45g==
X-Received: by 2002:a5d:4dc2:0:b0:386:4034:f9a8 with SMTP id ffacd0b85a97d-38bf57a2911mr24372336f8f.38.1737654311061;
        Thu, 23 Jan 2025 09:45:11 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188689sm295624f8f.48.2025.01.23.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:45:10 -0800 (PST)
Message-ID: <8faebc20-2b79-4b5f-aed6-b403d5b0f33d@redhat.com>
Date: Thu, 23 Jan 2025 18:45:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 06/12] net: homa: create homa_peer.h and
 homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-7-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-7-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> +/**
> + * homa_peertab_get_peers() - Return information about all of the peers
> + * currently known
> + * @peertab:    The table to search for peers.
> + * @num_peers:  Modified to hold the number of peers returned.
> + * Return:      kmalloced array holding pointers to all known peers. The
> + *		caller must free this. If there is an error, or if there
> + *	        are no peers, NULL is returned.
> + */
> +struct homa_peer **homa_peertab_get_peers(struct homa_peertab *peertab,
> +					  int *num_peers)

Look like this function is unsed in the current series. Please don't
introduce unused code.

> +{
> +	struct homa_peer **result;
> +	struct hlist_node *next;
> +	struct homa_peer *peer;
> +	int i, count;
> +
> +	*num_peers = 0;
> +	if (!peertab->buckets)
> +		return NULL;
> +
> +	/* Figure out how many peers there are. */
> +	count = 0;
> +	for (i = 0; i < HOMA_PEERTAB_BUCKETS; i++) {
> +		hlist_for_each_entry_safe(peer, next, &peertab->buckets[i],
> +					  peertab_links)

No lock acquired, so others process could concurrently modify the list;
hlist_for_each_entry_safe() is not the correct helper to use. You should
probably use hlist_for_each_entry_rcu(), adding rcu protection. Assuming
the thing is actually under an RCU schema, which is not entirely clear.

> +			count++;
> +	}
> +
> +	if (count == 0)
> +		return NULL;
> +
> +	result = kmalloc_array(count, sizeof(peer), GFP_KERNEL);
> +	if (!result)
> +		return NULL;
> +	*num_peers = count;
> +	count = 0;
> +	for (i = 0; i < HOMA_PEERTAB_BUCKETS; i++) {
> +		hlist_for_each_entry_safe(peer, next, &peertab->buckets[i],
> +					  peertab_links) {
> +			result[count] = peer;
> +			count++;
> +		}
> +	}
> +	return result;
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
> +void homa_peertab_gc_dsts(struct homa_peertab *peertab, __u64 now)
> +{

Apparently this is called under (and need) peertab lock, an annotation
or a comment would be helpful.

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
> +	/* Note: this function uses RCU operators to ensure safety even
> +	 * if a concurrent call is adding a new entry.
> +	 */
> +	struct homa_peer *peer;
> +	struct dst_entry *dst;
> +
> +	__u32 bucket = hash_32((__force __u32)addr->in6_u.u6_addr32[0],
> +			       HOMA_PEERTAB_BUCKET_BITS);
> +
> +	bucket ^= hash_32((__force __u32)addr->in6_u.u6_addr32[1],
> +			  HOMA_PEERTAB_BUCKET_BITS);
> +	bucket ^= hash_32((__force __u32)addr->in6_u.u6_addr32[2],
> +			  HOMA_PEERTAB_BUCKET_BITS);
> +	bucket ^= hash_32((__force __u32)addr->in6_u.u6_addr32[3],
> +			  HOMA_PEERTAB_BUCKET_BITS);
> +	hlist_for_each_entry_rcu(peer, &peertab->buckets[bucket],
> +				 peertab_links) {
> +		if (ipv6_addr_equal(&peer->addr, addr))

The caller does not acquire the RCU read lock, so this looks buggy.

AFAICS UaF is not possible because peers are removed only by
homa_peertab_destroy(), at unload time. That in turn looks
dangerous/wrong. What about memory utilization for peers over time?
apparently bucket list could grow in an unlimited way.

[...]
> +/**
> + * homa_peer_lock_slow() - This function implements the slow path for
> + * acquiring a peer's @unacked_lock. It is invoked when the lock isn't
> + * immediately available. It waits for the lock, but also records statistics
> + * about the waiting time.
> + * @peer:    Peer to  lock.
> + */
> +void homa_peer_lock_slow(struct homa_peer *peer)
> +	__acquires(&peer->ack_lock)
> +{
> +	spin_lock_bh(&peer->ack_lock);

Is this just a placeholder for future changes?!? I don't see any stats
update here, and currently homa_peer_lock() is really:

	if (!spin_trylock_bh(&peer->ack_lock))
		spin_lock_bh(&peer->ack_lock);

which does not make much sense to me. Either document this is going to
change very soon (possibly even how and why) or use a plain spin_lock_bh()

> +}
> +
> +/**
> + * homa_peer_add_ack() - Add a given RPC to the list of unacked
> + * RPCs for its server. Once this method has been invoked, it's safe
> + * to delete the RPC, since it will eventually be acked to the server.
> + * @rpc:    Client RPC that has now completed.
> + */
> +void homa_peer_add_ack(struct homa_rpc *rpc)
> +{
> +	struct homa_peer *peer = rpc->peer;
> +	struct homa_ack_hdr ack;
> +
> +	homa_peer_lock(peer);
> +	if (peer->num_acks < HOMA_MAX_ACKS_PER_PKT) {
> +		peer->acks[peer->num_acks].client_id = cpu_to_be64(rpc->id);
> +		peer->acks[peer->num_acks].server_port = htons(rpc->dport);
> +		peer->num_acks++;
> +		homa_peer_unlock(peer);
> +		return;
> +	}
> +
> +	/* The peer has filled up; send an ACK message to empty it. The
> +	 * RPC in the message header will also be considered ACKed.
> +	 */
> +	memcpy(ack.acks, peer->acks, sizeof(peer->acks));
> +	ack.num_acks = htons(peer->num_acks);
> +	peer->num_acks = 0;
> +	homa_peer_unlock(peer);
> +	homa_xmit_control(ACK, &ack, sizeof(ack), rpc);
> +}
> +
> +/**
> + * homa_peer_get_acks() - Copy acks out of a peer, and remove them from the
> + * peer.
> + * @peer:    Peer to check for possible unacked RPCs.
> + * @count:   Maximum number of acks to return.
> + * @dst:     The acks are copied to this location.
> + *
> + * Return:   The number of acks extracted from the peer (<= count).
> + */
> +int homa_peer_get_acks(struct homa_peer *peer, int count, struct homa_ack *dst)
> +{
> +	/* Don't waste time acquiring the lock if there are no ids available. */
> +	if (peer->num_acks == 0)
> +		return 0;
> +
> +	homa_peer_lock(peer);
> +
> +	if (count > peer->num_acks)
> +		count = peer->num_acks;
> +	memcpy(dst, &peer->acks[peer->num_acks - count],
> +	       count * sizeof(peer->acks[0]));
> +	peer->num_acks -= count;
> +
> +	homa_peer_unlock(peer);
> +	return count;
> +}
> diff --git a/net/homa/homa_peer.h b/net/homa/homa_peer.h
> new file mode 100644
> index 000000000000..556aeda49656
> --- /dev/null
> +++ b/net/homa/homa_peer.h
> @@ -0,0 +1,233 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +
> +/* This file contains definitions related to managing peers (homa_peer
> + * and homa_peertab).
> + */
> +
> +#ifndef _HOMA_PEER_H
> +#define _HOMA_PEER_H
> +
> +#include "homa_wire.h"
> +#include "homa_sock.h"
> +
> +struct homa_rpc;
> +
> +/**
> + * struct homa_dead_dst - Used to retain dst_entries that are no longer
> + * needed, until it is safe to delete them (I'm not confident that the RCU
> + * mechanism will be safe for these: the reference count could get incremented
> + * after it's on the RCU list?).
> + */
> +struct homa_dead_dst {
> +	/** @dst: Entry that is no longer used by a struct homa_peer. */
> +	struct dst_entry *dst;
> +
> +	/**
> +	 * @gc_time: Time (in units of sched_clock()) when it is safe
> +	 * to free @dst.
> +	 */
> +	__u64 gc_time;
> +
> +	/** @dst_links: Used to link together entries in peertab->dead_dsts. */
> +	struct list_head dst_links;
> +};
> +
> +/**
> + * define HOMA_PEERTAB_BUCKET_BITS - Number of bits in the bucket index for a
> + * homa_peertab.  Should be large enough to hold an entry for every server
> + * in a datacenter without long hash chains.
> + */
> +#define HOMA_PEERTAB_BUCKET_BITS 16
> +
> +/** define HOME_PEERTAB_BUCKETS - Number of buckets in a homa_peertab. */
> +#define HOMA_PEERTAB_BUCKETS BIT(HOMA_PEERTAB_BUCKET_BITS)
> +
> +/**
> + * struct homa_peertab - A hash table that maps from IPv6 addresses
> + * to homa_peer objects. IPv4 entries are encapsulated as IPv6 addresses.
> + * Entries are gradually added to this table, but they are never removed
> + * except when the entire table is deleted. We can't safely delete because
> + * results returned by homa_peer_find may be retained indefinitely.
> + *
> + * This table is managed exclusively by homa_peertab.c, using RCU to
> + * permit efficient lookups.
> + */
> +struct homa_peertab {
> +	/**
> +	 * @write_lock: Synchronizes addition of new entries; not needed
> +	 * for lookups (RCU is used instead).
> +	 */
> +	spinlock_t write_lock;

This look looks potentially havily contented on add, why don't you use a
per bucket lock?

> +
> +	/**
> +	 * @dead_dsts: List of dst_entries that are waiting to be deleted.
> +	 * Hold @write_lock when manipulating.
> +	 */
> +	struct list_head dead_dsts;
> +
> +	/**
> +	 * @buckets: Pointer to heads of chains of homa_peers for each bucket.
> +	 * Malloc-ed, and must eventually be freed. NULL means this structure
> +	 * has not been initialized.
> +	 */
> +	struct hlist_head *buckets;
> +};
> +
> +/**
> + * struct homa_peer - One of these objects exists for each machine that we
> + * have communicated with (either as client or server).
> + */
> +struct homa_peer {
> +	/**
> +	 * @addr: IPv6 address for the machine (IPv4 addresses are stored
> +	 * as IPv4-mapped IPv6 addresses).
> +	 */
> +	struct in6_addr addr;
> +
> +	/** @flow: Addressing info needed to send packets. */
> +	struct flowi flow;
> +
> +	/**
> +	 * @dst: Used to route packets to this peer; we own a reference
> +	 * to this, which we must eventually release.
> +	 */
> +	struct dst_entry *dst;
> +
> +	/**
> +	 * @grantable_rpcs: Contains all homa_rpcs (both requests and
> +	 * responses) involving this peer whose msgins require (or required
> +	 * them in the past) and have not been fully received. The list is
> +	 * sorted in priority order (head has fewest bytes_remaining).
> +	 * Locked with homa->grantable_lock.
> +	 */
> +	struct list_head grantable_rpcs;

Apparently not used in this patch series. More field below with similar
problem. Please introduce such fields in the same series that will
actualy use them.

/P


