Return-Path: <netdev+bounces-268898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDIlGOxTumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:27:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3B2B6ED1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC60309C740
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01D36A018;
	Wed, 18 Mar 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJcoETxZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926D30648C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818504; cv=none; b=hlzySDXPhTfs5Xm+G+ICrvAyw5BUfpo68t+UHIHrjLt0zUx1CqUOgNAjw+1Ee3y2jK6lRPTJW+Llw1T47fcwaV6VzcipM/f//d7x/z6Aa7/dBos3TxS701Dslb3mTICO4DL5YVPOzCqAW3C59Kmw74WNEMd01WHSlnZeO0zIkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818504; c=relaxed/simple;
	bh=AXAGRQY+teHY70JDPqMQzFeLL7R3vtayufYu+NIyjHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmTHyJCPnK/KUb3EBbUpXcNvQXMIPRwptVgGMuK0Ast/GUdvCS2prGqD7xOik54/8JhppiiYov9rrJdeb+sT+UFzJHrtES2tC2Ycd6IW5w2d3ieSVxPa0viLT0MYz+2WU5Rw9NIrrWfDkzhEMnV4o/PKm/hTfMBHjsqSuiw06CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJcoETxZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yizvclYykCQLb7osgFbO1VcoWcoxkNCOo8AxvTO5Ffg=;
	b=iJcoETxZvcMmqfhr2z/dA9x2KPlVlN3GuyYcdVJ6sKKuLX1+2BIUdFoH4SlpBMWsxUsNLH
	EpObSd11THlJ2YnGwL4G1ZO6nLgRl7vwx0z5n43heRqySWYpxFzSbIaBDPqr/bCWJJNrFO
	ebSmT7SUVYoAM6O5f4EvdWF8Vu8OTpU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-KAQ1jI7XMdKylODj_PjbsQ-1; Wed,
 18 Mar 2026 03:21:37 -0400
X-MC-Unique: KAQ1jI7XMdKylODj_PjbsQ-1
X-Mimecast-MFC-AGG-ID: KAQ1jI7XMdKylODj_PjbsQ_1773818496
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07A0F1800621;
	Wed, 18 Mar 2026 07:21:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F219A1955F19;
	Wed, 18 Mar 2026 07:21:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,08/14] net: homa: create homa_rpc.h and homa_rpc.c
Date: Wed, 18 Mar 2026 08:21:31 +0100
Message-ID: <20260318072131.268946-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-9-ouster@cs.stanford.edu>
References: <20260316223228.2611-9-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: BAF3B2B6ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create homa_rpc.h and homa_rpc.c

These files provide basic functions for managing remote procedure calls,
which are the fundamental entities managed by Homa. Each RPC consists
of a request message from a client to a server, followed by a response
message returned from the server to the client.

> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
> index f55a7b80431d..adedc8757e5b 100644
> --- a/net/homa/homa_impl.h
> +++ b/net/homa/homa_impl.h

[ ... ]

> diff --git a/net/homa/homa_rpc.c b/net/homa/homa_rpc.c
> new file mode 100644
> index 000000000000..9d4b05149805
> --- /dev/null
> +++ b/net/homa/homa_rpc.c
> @@ -0,0 +1,698 @@

[ ... ]

> +/**
> + * homa_rpc_alloc_server() - Allocate and initialize a server RPC (one that is
> + * used to manage an incoming request). If appropriate, the RPC will also
> + * be handed off (we do it here, while we have the socket locked, to avoid
> + * acquiring the socket lock a second time later for the handoff).
> + * @hsk:      Socket that owns this RPC.
> + * @source:   IP address (network byte order) of the RPC's client.
> + * @h:        Header for the first data packet received for this RPC; used
> + *            to initialize the RPC.
> + * @created:  Will be set to 1 if a new RPC was created and 0 if an
> + *            existing RPC was found.
> + *
> + * Return:  A pointer to a new RPC, which is locked, or a negative errno
> + *          if an error occurred. If there is already an RPC corresponding
> + *          to h, then it is returned instead of creating a new RPC.
> + */
> +struct homa_rpc *homa_rpc_alloc_server(struct homa_sock *hsk,
> +				       const struct in6_addr *source,
> +				       struct homa_data_hdr *h, int *created)
> +	__cond_acquires(nonnull, srpc->bucket->lock)
> +{
> +	u64 id = homa_local_id(h->common.sender_id);
> +	struct homa_rpc_bucket *bucket;
> +	struct homa_rpc *srpc = NULL;
> +	int err;
> +
> +	if (!hsk->buffer_pool)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Lock the bucket, and make sure no-one else has already created
> +	 * the desired RPC.
> +	 */
> +	bucket = homa_server_rpc_bucket(hsk, id);
> +	homa_bucket_lock(bucket, id);
> +	hlist_for_each_entry(srpc, &bucket->rpcs, hash_links) {
> +		if (srpc->id == id &&
> +		    srpc->dport == ntohs(h->common.sport) &&
> +		    ipv6_addr_equal(&srpc->peer->addr, source)) {
> +			/* RPC already exists; just return it instead
> +			 * of creating a new RPC.
> +			 */
> +			*created = 0;
> +			return srpc;
> +		}
> +	}
> +
> +	/* Initialize fields that don't require the socket lock. */
> +	srpc = kzalloc(sizeof(*srpc), GFP_ATOMIC);

In v6, Paolo Abeni suggested avoiding GFP_ATOMIC by doing the allocation
outside the bucket lock. The current code allocates while holding the
bucket lock (acquired above), which forces GFP_ATOMIC.

Paolo's suggestion was to do a lockless RCU lookup first, and only if that
fails, allocate outside the lock with GFP_KERNEL. Could this allocation be
moved outside the lock to use GFP_KERNEL instead?

Reference: https://lore.kernel.org/netdev/1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com/

Additionally, in a later review on January 28, Paolo and Eric Dumazet
suggested using SLAB_TYPESAFE_BY_RCU with a dedicated kmem_cache for RPC
allocations to improve performance and handle high RPC rates.

This approach would allow lockless RCU lookups and faster reclamation. Paolo
referenced tcp established socket lookup as an example:

  "Have a look at tcp established socket lookup and the SLAB_TYPESAFE_BY_RCU
   flag usage for slab-based allocations. A combo of such flag for RPC
   allocation (using a dedicated kmem_cache) and RCU lookup should improve
   consistently the performances, with a consolidate code layout and no
   unmanageable problems with large number of objects waiting for the grace
   period."

The current code still uses plain kzalloc/kfree without a dedicated cache.
Would it make sense to implement this optimization?

Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com/

> +	if (!srpc) {
> +		err = -ENOMEM;
> +		goto error;
> +	}

[ ... ]

> +error:
> +	homa_bucket_unlock(bucket, id);
> +	if (srpc && srpc->peer)
> +		homa_peer_release(srpc->peer);
> +	kfree(srpc);
> +	return ERR_PTR(err);
> +}

[ ... ]

In the v6 review thread, Paolo and Eric raised concerns about SKB freeing
costs and suggested optimizations. Eric noted that proper software GRO
significantly reduces SKB count using napi_get_frags() and napi_reuse_skb().

Paolo also suggested using deferred SKB freeing (skb_attempt_defer_free) to
reduce the cost. While you mentioned that GRO is implemented in the full
Homa but was left out of the initial patch series, would it be beneficial to
include at least some of these optimizations in this initial submission?

Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com/

[ ... ]

> diff --git a/net/homa/homa_rpc.h b/net/homa/homa_rpc.h
> new file mode 100644
> index 000000000000..98bfd389f5b1
> --- /dev/null
> +++ b/net/homa/homa_rpc.h

[ ... ]

> +/**
> + * homa_protect_rpcs() - Ensures that no RPCs will be reaped for a given
> + * socket until homa_sock_unprotect is called. Typically used by functions

This isn't a bug, but the comment references 'homa_sock_unprotect' which
doesn't exist. Should this be 'homa_unprotect_rpcs'?

> + * that want to scan the active RPCs for a socket without holding the socket
> + * lock.  Multiple calls to this function may be in effect at once. See
> + * "Homa Locking Strategy" in homa_impl.h for more info on why this function
> + * is needed.
> + * @hsk:    Socket whose RPCs should be protected. Must not be locked
> + *          by the caller; will be locked here.
> + *
> + * Return:  1 for success, 0 if the socket has been shutdown, in which
> + *          case its RPCs cannot be protected.
> + */
> +static inline int homa_protect_rpcs(struct homa_sock *hsk)
> +{
> +	int result;
> +
> +	homa_sock_lock(hsk);
> +	result = !hsk->shutdown;
> +	if (result)
> +		atomic_inc(&hsk->protect_count);
> +	homa_sock_unlock(hsk);
> +	return result;
> +}
> +
> +/**
> + * homa_unprotect_rpcs() - Cancel the effect of a previous call to
> + * homa_sock_protect(), so that RPCs can once again be reaped.

This isn't a bug, but the comment references 'homa_sock_protect()' which
doesn't exist. Should this be 'homa_protect_rpcs()'?

> + * @hsk:    Socket whose RPCs should be unprotected.
> + */
> +static inline void homa_unprotect_rpcs(struct homa_sock *hsk)
> +{
> +	atomic_dec(&hsk->protect_count);
> +}
> +
> +/**
> + * homa_rpc_hold() - Increment the reference count on an RPC, which will
> + * prevent it from being freed until homa_rpc_put() is called. References

[ ... ]

> +/**
> + * homa_rpc_put() - Release a reference on an RPC (cancels the effect of
> + * a previous call to homa_rpc_put).
> + * @rpc:      RPC to release.
> + */
> +static inline void homa_rpc_put(struct homa_rpc *rpc)
> +{
> +	refcount_dec(&rpc->refs);
> +}

This isn't a bug, but the kdoc comment says "cancels the effect of a
previous call to homa_rpc_put" which is self-referential. Should this say
"cancels the effect of a previous call to homa_rpc_hold" instead?

The function decrements rpc->refs via refcount_dec(), which is the inverse
operation of homa_rpc_hold() that calls refcount_inc(). This misleading
comment could confuse maintainers about the refcount lifecycle.

[ ... ]


