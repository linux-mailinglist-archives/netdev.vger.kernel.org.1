Return-Path: <netdev+bounces-160577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E9A1A5C2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76C03A8C6D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB8211495;
	Thu, 23 Jan 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxEagVIJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84020F99F
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642608; cv=none; b=jZOUMqZccjyErQaPmb1fw8+SCQJbLiltFZw7XYhgNnlxV+vI4CiyBK/hQl75RBe97AsIxec/k46YR3rK2i+6dXg1WBUPIQ15dlNmZZJNcQ/6h5C6TX5ehHQVqqlJ4rTWXNNrEiF8DpgCxqqLaEAjFF9UCSIz1IOePQGWRGbCtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642608; c=relaxed/simple;
	bh=i7/XsU6PEbHjTlCZdu6cAboOC8Aeu1vOyfBW9nbxlfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI1cJL9plpZ56hRJkWSJBPx8JWw3Quu4Xn0Mb2sgJIAa6dZlNkCaY3XCrRPCTpZYr9zM4Fb+iyuIgnxlAUTRvf8ZFnctMrCx2Cszq4E/NO1dylgg0658zyVrHeiXj+9/8ZgndsN/rer28CxH18vgUPOFaG2Hei6O35nqB9T8RCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxEagVIJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737642604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69fNqV6W40NaES0ZNRD3wLLpvYWqsjkwvjngIk4Kzvc=;
	b=bxEagVIJzRRogKmF32iE4tMHJExD42U7Y7vRiRYYSzvfiTpIfuv1XpTJQtnXX9wLuXNWxY
	vPyIRai88xi3QmaK53T8nRjadmV6TTmpuDMynmwKC+XrNUXHgng03aY9EFUJ42Q4lQSW5l
	s88eMcrkSgSFR5QoYrGmdgpR6rl1AFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-3Mt-A1NhM1eB7aWeTBv8_g-1; Thu, 23 Jan 2025 09:30:03 -0500
X-MC-Unique: 3Mt-A1NhM1eB7aWeTBv8_g-1
X-Mimecast-MFC-AGG-ID: 3Mt-A1NhM1eB7aWeTBv8_g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso5693175e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 06:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737642602; x=1738247402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69fNqV6W40NaES0ZNRD3wLLpvYWqsjkwvjngIk4Kzvc=;
        b=Y4cHuODXEuyIJ385/dUz3H97IV7Koft7cL8JvsGdgJnj+PWEuYfAkNZfpdGbdVKbbk
         y2nXnuCeHHnrk4Uzp9H+rKO6sZHRPcqoC3Lfl7wP53l9WJ70nmwscwIaCBFsRO0FTBN6
         rS/VuISLGT6JjF7eZ1g1c4l5B5JW8g7rC22Bq1X93QZNqI1+IkqJq3zY5lzHXjzgS4qi
         bk5Fx2m4xfAr+6MQWZaZQUrnCD4jmP/ht1Ze7+2V02Qim5Zx+aktLMDfxmxLikfr80gl
         98FCmEX/6nuvP252ZfPtd3HODus3CyeSAl8cFGIaGjgyPeucwrv39LV6nLYPaK5t0mOt
         dj9A==
X-Forwarded-Encrypted: i=1; AJvYcCUu+oahhBvpDctf/lCIA/7iziJI+VyOwnKKcKgBqJIvts/WYjN1bpK4T+cMsTHg7/zDf3j/zb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxubN8MtjnRW/3T70WasHnHw6cDnJFRvVnOU33fzOeucnkqsx7Y
	kfENRgoaU14XratVHFTf0wWNSybjyy7vDNcaigbou38R3eiy2iOEq/74utpJnEfjoaUYVcWWp7n
	X+KcvPfn064p2TNlOnqHbNCXrSDpODIQd3n8NmL/THYDdFK6Xn/+0K6sKxJFjkQ==
X-Gm-Gg: ASbGnctRY6shJAcwQs2mLh3Dhftt4SkMzz3yUa9hRPwSaU/0+Xw4vD5u5BkEQKLcrBg
	dyAzweV27rIwP9749i7a8L7Dfv9IigYDkupcWmZh/Ka1x8EVKcg/ebFgAiXAR4pZ70p6QOXIgOj
	uE/ZdvQLznG10GjGhRvaMxqUTZCRMarrinUtWghnF23L2Sjyek4/f9VOWPzrPltH+VGL/Xv3xbQ
	Y/jwzQWNEfwtDzwylGuuwl71zZEGzLKXycQQn7QSdRLfPZiGE6YwMjEmr2/iRE1YGYUecHIxpUh
	OdNk6V75ql2ctSklIkbFgPgk
X-Received: by 2002:a05:600c:5021:b0:436:1c0c:bfb6 with SMTP id 5b1f17b1804b1-438914514f2mr219124485e9.27.1737642601763;
        Thu, 23 Jan 2025 06:30:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENtgwTofdPC+vAlgg76YtvO+mO69ythzpJmtaPFkkaTaoXU+qA2Nbg/9XvwqvNg2XrXwW4/w==
X-Received: by 2002:a05:600c:5021:b0:436:1c0c:bfb6 with SMTP id 5b1f17b1804b1-438914514f2mr219124135e9.27.1737642601233;
        Thu, 23 Jan 2025 06:30:01 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm63732085e9.21.2025.01.23.06.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 06:30:00 -0800 (PST)
Message-ID: <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com>
Date: Thu, 23 Jan 2025 15:29:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and
 homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-6-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-6-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> These files provide basic functions for managing remote procedure calls,
> which are the fundamental entities managed by Homa. Each RPC consists
> of a request message from a client to a server, followed by a response
> message returned from the server to the client.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/homa/homa_rpc.c | 494 ++++++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_rpc.h | 458 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 952 insertions(+)
>  create mode 100644 net/homa/homa_rpc.c
>  create mode 100644 net/homa/homa_rpc.h
> 
> diff --git a/net/homa/homa_rpc.c b/net/homa/homa_rpc.c
> new file mode 100644
> index 000000000000..cc8450c984f8
> --- /dev/null
> +++ b/net/homa/homa_rpc.c
> @@ -0,0 +1,494 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file contains functions for managing homa_rpc structs. */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_pool.h"
> +#include "homa_stub.h"
> +
> +/**
> + * homa_rpc_new_client() - Allocate and construct a client RPC (one that is used
> + * to issue an outgoing request). Doesn't send any packets. Invoked with no
> + * locks held.
> + * @hsk:      Socket to which the RPC belongs.
> + * @dest:     Address of host (ip and port) to which the RPC will be sent.
> + *
> + * Return:    A printer to the newly allocated object, or a negative
> + *            errno if an error occurred. The RPC will be locked; the
> + *            caller must eventually unlock it.
> + */
> +struct homa_rpc *homa_rpc_new_client(struct homa_sock *hsk,
> +				     const union sockaddr_in_union *dest)
> +	__acquires(&crpc->bucket->lock)
> +{
> +	struct in6_addr dest_addr_as_ipv6 = canonical_ipv6_addr(dest);
> +	struct homa_rpc_bucket *bucket;
> +	struct homa_rpc *crpc;
> +	int err;
> +
> +	crpc = kmalloc(sizeof(*crpc), GFP_KERNEL);
> +	if (unlikely(!crpc))
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Initialize fields that don't require the socket lock. */
> +	crpc->hsk = hsk;
> +	crpc->id = atomic64_fetch_add(2, &hsk->homa->next_outgoing_id);
> +	bucket = homa_client_rpc_bucket(hsk, crpc->id);
> +	crpc->bucket = bucket;
> +	crpc->state = RPC_OUTGOING;
> +	atomic_set(&crpc->flags, 0);
> +	crpc->peer = homa_peer_find(hsk->homa->peers, &dest_addr_as_ipv6,
> +				    &hsk->inet);
> +	if (IS_ERR(crpc->peer)) {
> +		err = PTR_ERR(crpc->peer);
> +		goto error;
> +	}
> +	crpc->dport = ntohs(dest->in6.sin6_port);
> +	crpc->completion_cookie = 0;
> +	crpc->error = 0;
> +	crpc->msgin.length = -1;
> +	crpc->msgin.num_bpages = 0;
> +	memset(&crpc->msgout, 0, sizeof(crpc->msgout));
> +	crpc->msgout.length = -1;
> +	INIT_LIST_HEAD(&crpc->ready_links);
> +	INIT_LIST_HEAD(&crpc->buf_links);
> +	INIT_LIST_HEAD(&crpc->dead_links);
> +	crpc->interest = NULL;
> +	INIT_LIST_HEAD(&crpc->throttled_links);
> +	crpc->silent_ticks = 0;
> +	crpc->resend_timer_ticks = hsk->homa->timer_ticks;
> +	crpc->done_timer_ticks = 0;
> +	crpc->magic = HOMA_RPC_MAGIC;
> +	crpc->start_ns = sched_clock();
> +
> +	/* Initialize fields that require locking. This allows the most
> +	 * expensive work, such as copying in the message from user space,
> +	 * to be performed without holding locks. Also, can't hold spin
> +	 * locks while doing things that could block, such as memory allocation.
> +	 */
> +	homa_bucket_lock(bucket, crpc->id, "homa_rpc_new_client");
> +	homa_sock_lock(hsk, "homa_rpc_new_client");
> +	if (hsk->shutdown) {
> +		homa_sock_unlock(hsk);
> +		homa_rpc_unlock(crpc);
> +		err = -ESHUTDOWN;
> +		goto error;
> +	}
> +	hlist_add_head(&crpc->hash_links, &bucket->rpcs);
> +	list_add_tail_rcu(&crpc->active_links, &hsk->active_rpcs);
> +	homa_sock_unlock(hsk);
> +
> +	return crpc;
> +
> +error:
> +	kfree(crpc);
> +	return ERR_PTR(err);
> +}
> +
> +/**
> + * homa_rpc_new_server() - Allocate and construct a server RPC (one that is
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
> +struct homa_rpc *homa_rpc_new_server(struct homa_sock *hsk,
> +				     const struct in6_addr *source,
> +				     struct homa_data_hdr *h, int *created)
> +	__acquires(&srpc->bucket->lock)
> +{
> +	__u64 id = homa_local_id(h->common.sender_id);
> +	struct homa_rpc_bucket *bucket;
> +	struct homa_rpc *srpc = NULL;
> +	int err;
> +
> +	/* Lock the bucket, and make sure no-one else has already created
> +	 * the desired RPC.
> +	 */
> +	bucket = homa_server_rpc_bucket(hsk, id);
> +	homa_bucket_lock(bucket, id, "homa_rpc_new_server");
> +	hlist_for_each_entry_rcu(srpc, &bucket->rpcs, hash_links) {
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

How many RPCs should concurrently exists in a real server? with 1024
buckets there could be a lot of them on each/some list and linar search
could be very expansive. And this happens with BH disabled.

> +
> +	/* Initialize fields that don't require the socket lock. */
> +	srpc = kmalloc(sizeof(*srpc), GFP_ATOMIC);

You could do the allocation outside the bucket lock, too and avoid the
ATOMIC flag.

> +	if (!srpc) {
> +		err = -ENOMEM;
> +		goto error;
> +	}
> +	srpc->hsk = hsk;
> +	srpc->bucket = bucket;
> +	srpc->state = RPC_INCOMING;
> +	atomic_set(&srpc->flags, 0);
> +	srpc->peer = homa_peer_find(hsk->homa->peers, source, &hsk->inet);
> +	if (IS_ERR(srpc->peer)) {
> +		err = PTR_ERR(srpc->peer);
> +		goto error;
> +	}
> +	srpc->dport = ntohs(h->common.sport);
> +	srpc->id = id;
> +	srpc->completion_cookie = 0;
> +	srpc->error = 0;
> +	srpc->msgin.length = -1;
> +	srpc->msgin.num_bpages = 0;
> +	memset(&srpc->msgout, 0, sizeof(srpc->msgout));
> +	srpc->msgout.length = -1;
> +	INIT_LIST_HEAD(&srpc->ready_links);
> +	INIT_LIST_HEAD(&srpc->buf_links);
> +	INIT_LIST_HEAD(&srpc->dead_links);
> +	srpc->interest = NULL;
> +	INIT_LIST_HEAD(&srpc->throttled_links);
> +	srpc->silent_ticks = 0;
> +	srpc->resend_timer_ticks = hsk->homa->timer_ticks;
> +	srpc->done_timer_ticks = 0;
> +	srpc->magic = HOMA_RPC_MAGIC;
> +	srpc->start_ns = sched_clock();
> +	err = homa_message_in_init(srpc, ntohl(h->message_length));
> +	if (err != 0)
> +		goto error;
> +
> +	/* Initialize fields that require socket to be locked. */
> +	homa_sock_lock(hsk, "homa_rpc_new_server");
> +	if (hsk->shutdown) {
> +		homa_sock_unlock(hsk);
> +		err = -ESHUTDOWN;
> +		goto error;
> +	}
> +	hlist_add_head(&srpc->hash_links, &bucket->rpcs);
> +	list_add_tail_rcu(&srpc->active_links, &hsk->active_rpcs);
> +	if (ntohl(h->seg.offset) == 0 && srpc->msgin.num_bpages > 0) {
> +		atomic_or(RPC_PKTS_READY, &srpc->flags);
> +		homa_rpc_handoff(srpc);
> +	}
> +	homa_sock_unlock(hsk);
> +	*created = 1;
> +	return srpc;
> +
> +error:
> +	homa_bucket_unlock(bucket, id);
> +	kfree(srpc);
> +	return ERR_PTR(err);
> +}
> +
> +/**
> + * homa_rpc_acked() - This function is invoked when an ack is received
> + * for an RPC; if the RPC still exists, is freed.
> + * @hsk:     Socket on which the ack was received. May or may not correspond
> + *           to the RPC, but can sometimes be used to avoid a socket lookup.
> + * @saddr:   Source address from which the act was received (the client
> + *           note for the RPC)
> + * @ack:     Information about an RPC from @saddr that may now be deleted
> + *           safely.
> + */
> +void homa_rpc_acked(struct homa_sock *hsk, const struct in6_addr *saddr,
> +		    struct homa_ack *ack)
> +{
> +	__u16 server_port = ntohs(ack->server_port);
> +	__u64 id = homa_local_id(ack->client_id);
> +	struct homa_sock *hsk2 = hsk;
> +	struct homa_rpc *rpc;
> +
> +	if (hsk2->port != server_port) {
> +		/* Without RCU, sockets other than hsk can be deleted
> +		 * out from under us.
> +		 */
> +		rcu_read_lock();
> +		hsk2 = homa_sock_find(hsk->homa->port_map, server_port);
> +		if (!hsk2)
> +			goto done;
> +	}
> +	rpc = homa_find_server_rpc(hsk2, saddr, id);
> +	if (rpc) {
> +		homa_rpc_free(rpc);
> +		homa_rpc_unlock(rpc); /* Locked by homa_find_server_rpc. */
> +	}
> +
> +done:
> +	if (hsk->port != server_port)
> +		rcu_read_unlock();
> +}
> +
> +/**
> + * homa_rpc_free() - Destructor for homa_rpc; will arrange for all resources
> + * associated with the RPC to be released (eventually).
> + * @rpc:  Structure to clean up, or NULL. Must be locked. Its socket must
> + *        not be locked.
> + */
> +void homa_rpc_free(struct homa_rpc *rpc)
> +	__acquires(&rpc->hsk->lock)
> +	__releases(&rpc->hsk->lock)

The function name is IMHO misleading. I expect homa_rpc_free() to
actually free the memory allocated for the rpc argument, including the
rpc struct itself.

> +{
> +	/* The goal for this function is to make the RPC inaccessible,
> +	 * so that no other code will ever access it again. However, don't
> +	 * actually release resources; leave that to homa_rpc_reap, which
> +	 * runs later. There are two reasons for this. First, releasing
> +	 * resources may be expensive, so we don't want to keep the caller
> +	 * waiting; homa_rpc_reap will run in situations where there is time
> +	 * to spare. Second, there may be other code that currently has
> +	 * pointers to this RPC but temporarily released the lock (e.g. to
> +	 * copy data to/from user space). It isn't safe to clean up until
> +	 * that code has finished its work and released any pointers to the
> +	 * RPC (homa_rpc_reap will ensure that this has happened). So, this
> +	 * function should only make changes needed to make the RPC
> +	 * inaccessible.
> +	 */
> +	if (!rpc || rpc->state == RPC_DEAD)
> +		return;
> +	rpc->state = RPC_DEAD;
> +
> +	/* Unlink from all lists, so no-one will ever find this RPC again. */
> +	homa_sock_lock(rpc->hsk, "homa_rpc_free");
> +	__hlist_del(&rpc->hash_links);
> +	list_del_rcu(&rpc->active_links);
> +	list_add_tail_rcu(&rpc->dead_links, &rpc->hsk->dead_rpcs);
> +	__list_del_entry(&rpc->ready_links);
> +	__list_del_entry(&rpc->buf_links);
> +	if (rpc->interest) {
> +		rpc->interest->reg_rpc = NULL;
> +		wake_up_process(rpc->interest->thread);
> +		rpc->interest = NULL;
> +	}
> +
> +	if (rpc->msgin.length >= 0) {
> +		rpc->hsk->dead_skbs += skb_queue_len(&rpc->msgin.packets);
> +		while (1) {
> +			struct homa_gap *gap = list_first_entry_or_null(&rpc->msgin.gaps,
> +									struct homa_gap,
> +									links);
> +			if (!gap)
> +				break;
> +			list_del(&gap->links);
> +			kfree(gap);
> +		}
> +	}
> +	rpc->hsk->dead_skbs += rpc->msgout.num_skbs;
> +	if (rpc->hsk->dead_skbs > rpc->hsk->homa->max_dead_buffs)
> +		/* This update isn't thread-safe; it's just a
> +		 * statistic so it's OK if updates occasionally get
> +		 * missed.
> +		 */
> +		rpc->hsk->homa->max_dead_buffs = rpc->hsk->dead_skbs;
> +
> +	homa_sock_unlock(rpc->hsk);
> +	homa_remove_from_throttled(rpc);
> +}
> +
> +/**
> + * homa_rpc_reap() - Invoked to release resources associated with dead
> + * RPCs for a given socket. For a large RPC, it can take a long time to
> + * free all of its packet buffers, so we try to perform this work
> + * off the critical path where it won't delay applications. Each call to
> + * this function normally does a small chunk of work (unless reap_all is
> + * true). See the file reap.txt for more information.
> + * @hsk:      Homa socket that may contain dead RPCs. Must not be locked by the
> + *            caller; this function will lock and release.
> + * @reap_all: False means do a small chunk of work; there may still be
> + *            unreaped RPCs on return. True means reap all dead rpcs for
> + *            hsk.  Will busy-wait if reaping has been disabled for some RPCs.
> + *
> + * Return: A return value of 0 means that we ran out of work to do; calling
> + *         again will do no work (there could be unreaped RPCs, but if so,
> + *         reaping has been disabled for them).  A value greater than
> + *         zero means there is still more reaping work to be done.
> + */
> +int homa_rpc_reap(struct homa_sock *hsk, bool reap_all)
> +{
> +#define BATCH_MAX 20
> +	struct homa_rpc *rpcs[BATCH_MAX];
> +	struct sk_buff *skbs[BATCH_MAX];
> +	int num_skbs, num_rpcs;
> +	struct homa_rpc *rpc;
> +	int i, batch_size;
> +	int skbs_to_reap;
> +	int rx_frees;
> +	int result = 0;
> +
> +	/* Each iteration through the following loop will reap
> +	 * BATCH_MAX skbs.
> +	 */
> +	skbs_to_reap = hsk->homa->reap_limit;
> +	while (skbs_to_reap > 0 && !list_empty(&hsk->dead_rpcs)) {
> +		batch_size = BATCH_MAX;
> +		if (!reap_all) {
> +			if (batch_size > skbs_to_reap)
> +				batch_size = skbs_to_reap;
> +			skbs_to_reap -= batch_size;
> +		}
> +		num_skbs = 0;
> +		num_rpcs = 0;
> +		rx_frees = 0;
> +
> +		homa_sock_lock(hsk, "homa_rpc_reap");
> +		if (atomic_read(&hsk->protect_count)) {
> +			homa_sock_unlock(hsk);
> +			if (reap_all)
> +				continue;
> +			return 0;
> +		}
> +
> +		/* Collect buffers and freeable RPCs. */
> +		list_for_each_entry_rcu(rpc, &hsk->dead_rpcs, dead_links) {
> +			if ((atomic_read(&rpc->flags) & RPC_CANT_REAP) ||
> +			    atomic_read(&rpc->msgout.active_xmits) != 0)
> +				continue;
> +			rpc->magic = 0;
> +
> +			/* For Tx sk_buffs, collect them here but defer
> +			 * freeing until after releasing the socket lock.
> +			 */
> +			if (rpc->msgout.length >= 0) {
> +				while (rpc->msgout.packets) {
> +					skbs[num_skbs] = rpc->msgout.packets;
> +					rpc->msgout.packets = homa_get_skb_info(
> +						rpc->msgout.packets)->next_skb;
> +					num_skbs++;
> +					rpc->msgout.num_skbs--;
> +					if (num_skbs >= batch_size)
> +						goto release;
> +				}
> +			}
> +
> +			/* In the normal case rx sk_buffs will already have been
> +			 * freed before we got here. Thus it's OK to free
> +			 * immediately in rare situations where there are
> +			 * buffers left.
> +			 */
> +			if (rpc->msgin.length >= 0) {
> +				while (1) {
> +					struct sk_buff *skb;
> +
> +					skb = skb_dequeue(&rpc->msgin.packets);
> +					if (!skb)
> +						break;
> +					kfree_skb(skb);

You can use:
					rx_free+= skb_queue_len(&rpc->msgin.packets);
					skb_queue_purge(&rpc->msgin.packets);


> +					rx_frees++;
> +				}
> +			}
> +
> +			/* If we get here, it means all packets have been
> +			 *  removed from the RPC.
> +			 */
> +			rpcs[num_rpcs] = rpc;
> +			num_rpcs++;
> +			list_del_rcu(&rpc->dead_links);
> +			if (num_rpcs >= batch_size)
> +				goto release;
> +		}
> +
> +		/* Free all of the collected resources; release the socket
> +		 * lock while doing this.
> +		 */
> +release:
> +		hsk->dead_skbs -= num_skbs + rx_frees;
> +		result = !list_empty(&hsk->dead_rpcs) &&
> +				(num_skbs + num_rpcs) != 0;
> +		homa_sock_unlock(hsk);
> +		homa_skb_free_many_tx(hsk->homa, skbs, num_skbs);
> +		for (i = 0; i < num_rpcs; i++) {
> +			rpc = rpcs[i];
> +			/* Lock and unlock the RPC before freeing it. This
> +			 * is needed to deal with races where the code
> +			 * that invoked homa_rpc_free hasn't unlocked the
> +			 * RPC yet.
> +			 */
> +			homa_rpc_lock(rpc, "homa_rpc_reap");
> +			homa_rpc_unlock(rpc);
> +
> +			if (unlikely(rpc->msgin.num_bpages))
> +				homa_pool_release_buffers(rpc->hsk->buffer_pool,
> +							  rpc->msgin.num_bpages,
> +							  rpc->msgin.bpage_offsets);
> +			if (rpc->msgin.length >= 0) {
> +				while (1) {
> +					struct homa_gap *gap;
> +
> +					gap = list_first_entry_or_null(
> +							&rpc->msgin.gaps,
> +							struct homa_gap,
> +							links);
> +					if (!gap)
> +						break;
> +					list_del(&gap->links);
> +					kfree(gap);
> +				}
> +			}
> +			rpc->state = 0;
> +			kfree(rpc);
> +		}
> +		if (!result && !reap_all)
> +			break;
> +	}
> +	homa_pool_check_waiting(hsk->buffer_pool);
> +	return result;
> +}
> +
> +/**
> + * homa_find_client_rpc() - Locate client-side information about the RPC that
> + * a packet belongs to, if there is any. Thread-safe without socket lock.
> + * @hsk:      Socket via which packet was received.
> + * @id:       Unique identifier for the RPC.
> + *
> + * Return:    A pointer to the homa_rpc for this id, or NULL if none.
> + *            The RPC will be locked; the caller must eventually unlock it
> + *            by invoking homa_rpc_unlock.

Why are using this lock schema? It looks like it adds quite a bit of
complexity. The usual way of handling this kind of hash lookup is do the
lookup locklessly, under RCU, and eventually add a refcnt to the
looked-up entity - homa_rpc - to ensure it will not change under the
hood after the lookup.

> + */
> +struct homa_rpc *homa_find_client_rpc(struct homa_sock *hsk, __u64 id)
> +	__acquires(&crpc->bucket->lock)
> +{
> +	struct homa_rpc_bucket *bucket = homa_client_rpc_bucket(hsk, id);
> +	struct homa_rpc *crpc;
> +
> +	homa_bucket_lock(bucket, id, __func__);
> +	hlist_for_each_entry_rcu(crpc, &bucket->rpcs, hash_links) {

Why are you using the RCU variant? I don't see RCU access for rpcs.

/P


