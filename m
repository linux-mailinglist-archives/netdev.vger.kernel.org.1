Return-Path: <netdev+bounces-268896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INgXIrRTumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:26:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA92B6EAC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB903308E846
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241D36A024;
	Wed, 18 Mar 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIRR5EhS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E133D51A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818491; cv=none; b=HJ+uAqP1MIdyHkp1rC2uVZnooGYXll86LOi/8WPaMyqBmq3OzVGR8s27fsPBQEkH8svwsZk+XNq1HudLqQt+ZVdH4kKKiDH67aVtaaBaJsZJI17yLLB1mWn3bHWm9SP5R2ViIpmiC8gI70hxAtjc74We8W5ejC3PVbVESYleXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818491; c=relaxed/simple;
	bh=3dc0JU/ZvkDWjYP28nqm/owf0iFWLlrha7m57TAytOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARa0E4uF1pXFn6i/xpcRRXLurOwqt01K0+/Qoz/uSxK3lg352XihdciJyZ+ioIQYWNP2hO2LK+YZJXCMvuzUDx1Nq94uiOQiAo/TnQS+y8dhOVip1X+Akp/CXYdU8g7O5mRuwLGMD149CgAsFslKW7Ca8eeHy1RjyX/cCsEO8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIRR5EhS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2hbaWHuKsfYm1M0MvpSmmTQLNK0jpDa1Cl1UFVeCQo=;
	b=ZIRR5EhSOOtqurKj+5RF+eUxNUtYTHMiYdvIv3DUozKU9jnWVp8jiJCq9y6/TEAae3biOv
	iTFj/g7yE4fWwOzftQ7yMcCdfekqNC6P7/drOOP+mia6iFzjW78eibPYRml6l0KCmFrxbj
	TvnwHZM0BIWDv15VE9Mx9+FwYeNhMUg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-r1ERTHf7MV6PuyCJAhuB-A-1; Wed,
 18 Mar 2026 03:21:25 -0400
X-MC-Unique: r1ERTHf7MV6PuyCJAhuB-A-1
X-Mimecast-MFC-AGG-ID: r1ERTHf7MV6PuyCJAhuB-A_1773818484
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45CED1944EB3;
	Wed, 18 Mar 2026 07:21:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 351C130001A1;
	Wed, 18 Mar 2026 07:21:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,05/14] net: homa: create homa_peer.h and homa_peer.c
Date: Wed, 18 Mar 2026 08:21:19 +0100
Message-ID: <20260318072119.268920-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-6-ouster@cs.stanford.edu>
References: <20260316223228.2611-6-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268896-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CCA92B6EAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create homa_peer.h and homa_peer.c

Homa needs to keep a small amount of information for each peer that
it has communicated with. These files define that state and provide
functions for storing and accessing it.

> diff --git a/net/homa/homa_peer.c b/net/homa/homa_peer.c
> new file mode 100644
> index 000000000000..1e5301cdef41
> --- /dev/null
> +++ b/net/homa/homa_peer.c

[ ... ]

> +/**
> + * homa_peer_free_net() - Garbage collect all of the peer information
> + * associated with a particular network namespace.
> + * @hnet:    Network namespace whose peers should be freed. There must not
> + *           be any active sockets or RPCs for this namespace.
> + */
> +void homa_peer_free_net(struct homa_net *hnet)
> +{
> +	struct homa_peertab *peertab = hnet->homa->peertab;
> +	struct rhashtable_iter iter;
> +	struct homa_peer *peer;
> +
> +	spin_lock_bh(&peertab->lock);
> +	peertab->gc_stop_count++;
> +	spin_unlock_bh(&peertab->lock);
> +
> +	rhashtable_walk_enter(&peertab->ht, &iter);
> +	rhashtable_walk_start(&iter);
> +	while (1) {
> +		peer = rhashtable_walk_next(&iter);
> +		if (!peer)
> +			break;
> +		if (IS_ERR(peer))
> +			continue;
> +		if (peer->ht_key.hnet != hnet)
> +			continue;
> +		if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
> +					   ht_params) == 0) {
> +			homa_peer_release(peer);
> +			hnet->num_peers--;
> +			peertab->num_peers--;
> +		}
> +	}
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);

Does this code correctly protect peertab->num_peers updates? Looking at
homa_peer_gc():

net/homa/homa_peer.c:homa_peer_gc() {
    spin_lock_bh(&peertab->lock);
    ...
    if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
                               ht_params) == 0) {
        homa_peer_release(peer);
        peertab->num_peers--;
        peer->ht_key.hnet->num_peers--;
    }
    ...
    spin_unlock_bh(&peertab->lock);
}

and homa_peer_get():

net/homa/homa_peer.c:homa_peer_get() {
    ...
    spin_lock_bh(&peertab->lock);
    other = rhashtable_lookup_get_insert_fast(&peertab->ht,
                                              &peer->ht_linkage, ht_params);
    ...
    peertab->num_peers++;
    key.hnet->num_peers++;
    ...
    spin_unlock_bh(&peertab->lock);
}

Both those functions hold peertab->lock while updating peertab->num_peers.

But homa_peer_free_net() drops peertab->lock before the rhashtable walk and
doesn't reacquire it before decrementing peertab->num_peers. Can a concurrent
homa_peer_get() call (for any namespace) produce lost updates to
peertab->num_peers? The gc_stop_count mechanism prevents concurrent GC but
doesn't prevent concurrent homa_peer_get().

Corrupted num_peers affects GC threshold decisions in the peertab->num_peers <
peertab->gc_threshold check in homa_peer_gc().

> +/**
> + * homa_peer_prefer_evict() - Given two peers, determine which one is
> + * a better candidate for eviction.
> + * @peertab:    Overall information used to manage peers.
> + * @peer1:      First peer.
> + * @peer2:      Second peer.
> + * Return:      True if @peer1 is a better candidate for eviction than @peer2.
> + */
> +int homa_peer_prefer_evict(struct homa_peertab *peertab,
> +			   struct homa_peer *peer1,
> +			   struct homa_peer *peer2)
> +{
> +	/* Prefer a peer whose homa-net is over its limit; if both are either
> +	 * over or under, then prefer the peer with the shortest idle time.
> +	 */
                                                      ^^^^^^^^

This isn't a bug, but the comment says "shortest idle time" while the code
returns peer1->access_jiffies < peer2->access_jiffies, which prefers the peer
accessed earlier (longest idle time). Since eviction should prefer stale peers,
the code is correct but the comment should say "longest idle time".

[ ... ]

> +/**
> + * homa_peer_free() - Release any resources in a peer and free the homa_peer
> + * struct. Invoked by the RCU mechanism via homa_peer_release.
> + * @head:   Pointer to the rcu_head field of the peer to free.
> + */
> +void homa_peer_free(struct rcu_head *head)
> +{
> +	struct homa_peer *peer;
> +
> +	peer = container_of(head, struct homa_peer, rcu_head);
> +	dst_release(rcu_dereference(peer->dst));
> +	kfree(peer);
> +}

Is the RCU API correct here? homa_peer_free() is an RCU callback invoked via
call_rcu from homa_peer_release():

net/homa/homa_peer.h:homa_peer_release() {
    if (refcount_dec_and_test(&peer->refs))
        call_rcu(&peer->rcu_head, homa_peer_free);
}

RCU callbacks run after the grace period, outside any RCU read-side critical
section. Using rcu_dereference() without holding rcu_read_lock() triggers
lockdep 'suspicious rcu_dereference_check() usage' warnings at runtime.

The peer is exclusively owned at this point (refcount was zero, grace period
has passed). The same codebase uses the correct pattern in
homa_peer_reset_dst():

net/homa/homa_peer.c:homa_peer_reset_dst() {
    ...
    dst_release(rcu_replace_pointer(peer->dst, dst, true));
    ...
}

Should this use rcu_dereference_protected(peer->dst, 1) instead of
rcu_dereference(peer->dst)?

> +/**
> + * homa_peer_get() - Returns the peer associated with a given host; creates
> + * a new homa_peer if one doesn't already exist.
> + * @hsk:        Socket where the peer will be used.
> + * @addr:       Address of the desired host: IPv4 addresses are represented
> + *              as IPv4-mapped IPv6 addresses.
> + *
> + * Return:      The peer associated with @addr, or a negative errno if an
> + *              error occurred. On a successful return the reference count
> + *              will be incremented for the returned peer. The caller must
> + *              eventually call homa_peer_release to release the reference.
> + */
> +struct homa_peer *homa_peer_get(struct homa_sock *hsk,
> +				const struct in6_addr *addr)
> +{
> +	struct homa_peertab *peertab = hsk->homa->peertab;
> +	struct homa_peer *peer, *other;
> +	struct homa_peer_key key;
> +
> +	key.addr = *addr;
> +	key.hnet = hsk->hnet;
> +	rcu_read_lock();
> +	peer = rhashtable_lookup(&peertab->ht, &key, ht_params);
> +	if (peer) {
> +		homa_peer_hold(peer);
> +		peer->access_jiffies = jiffies;
> +		rcu_read_unlock();
> +		return peer;
> +	}

Can this sequence race with homa_peer_gc()? The lookup uses
rhashtable_lookup() under rcu_read_lock() but without peertab->lock. Then it
calls homa_peer_hold() which uses refcount_inc():

net/homa/homa_peer.h:homa_peer_hold() {
    refcount_inc(&peer->refs);
}

Concurrently, homa_peer_gc() can:

net/homa/homa_peer.c:homa_peer_gc() {
    spin_lock_bh(&peertab->lock);
    ...
    if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
                               ht_params) == 0) {
        homa_peer_release(peer);
        ...
    }
    ...
    spin_unlock_bh(&peertab->lock);
}

net/homa/homa_peer.h:homa_peer_release() {
    if (refcount_dec_and_test(&peer->refs))
        call_rcu(&peer->rcu_head, homa_peer_free);
}

If homa_peer_gc() removes the peer from the rhashtable and calls
homa_peer_release() (dropping refcount to 0 and scheduling call_rcu) between
the lookup and the hold, then refcount_inc() on a zero refcount triggers
REFCOUNT_WARN and refuses the increment. This leaves the caller with an
unref'd peer that will be freed after the RCU grace period.

The standard kernel pattern for RCU + rhashtable lookups is
refcount_inc_not_zero() with retry or fallback if it returns false. The RCU
read lock keeps the memory valid but doesn't prevent the refcount from
reaching zero.

[ ... ]

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

Does this code leak kernel stack memory? The 'struct homa_ack_hdr ack' is
declared on the stack without zeroing it. Only ack.acks (via memcpy) and
ack.num_acks are initialized before calling homa_xmit_control().

Looking at how homa_xmit_control() uses the ack:

The function sets ack.common.type, sport, dport, and sender_id, but the
following homa_common_hdr fields remain uninitialized: sequence, ack[3], doff,
reserved1, window, checksum, and reserved2.

These uninitialized stack bytes are then memcpy'd into an skb by
__homa_xmit_control() and transmitted on the network, leaking kernel stack
memory.

Additionally, the homa_common_hdr comment for doff warns: "other values may
cause some NICs (such as Intel E810-C) to drop outgoing packets when TCP
hijacking is enabled", so garbage in doff can cause packet drops.

The homa_xmit_control() doc comment claims "the common header will be filled
in by this function" but only 4 of 11 fields are actually set.


