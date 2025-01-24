Return-Path: <netdev+bounces-160744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC57A1B1BA
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 09:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558CD3A6C6C
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBDF218EB8;
	Fri, 24 Jan 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNzNWFNJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CC1D8E16
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707490; cv=none; b=h6AWlFGN3ybbys5uRJXwa9og+JsnMSD5J9RSXjeN7IfIh1gr+8itP7243HUWn1pp+Ko0b9hYu+ZK2iUucwLFymRUtCwHVtv/omGa+MxRlg6R+fUQOiwUNF0uXHRo78JMt5VxHNhk0/Gjz5Cx3k/7nmErCh68nxuDg7a3AHOdf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707490; c=relaxed/simple;
	bh=RSnu0KNcPRR2fxyJ8kWyOqd0vP9R3wbnkoDuTmRkc7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPSyOXdXEQPYj/HjvHZZmjrt5QKpqnBcZ1IQtFn+N7vnhEQLJIuO+UPixPN/YcA/AC78RGkumi3BNzEnOmLKU+S3GIrpWNY8aKQNek9GcKYh2AlVtNnKppNAU3XKRpAE5aFxIMv73YrLWJ/cJ+XvmXF3QbQ6KxvTQ7yl+T+U5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNzNWFNJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737707486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3UIKLsXurtCbFvzyCPpPZECv0E4Bx5//vQGJissNKI=;
	b=jNzNWFNJCS9AY4KH9DvnyG2cwYoyG8u50EKxQCRVsDmSXHSog3gXtBldLsJvgBr5ZUhvsT
	/vScAiB/PynRYUllTIFdpZKcHTpKHbri5RxOSUfGz0MedJywGAo0rO14Tjwkin1usA6wen
	79hzorGaPPytRqGQltT/VZFt+S0fwBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-h0fPfWMBPMKu3rxbe-skxw-1; Fri, 24 Jan 2025 03:31:24 -0500
X-MC-Unique: h0fPfWMBPMKu3rxbe-skxw-1
X-Mimecast-MFC-AGG-ID: h0fPfWMBPMKu3rxbe-skxw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361b090d23so8805695e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 00:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737707483; x=1738312283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3UIKLsXurtCbFvzyCPpPZECv0E4Bx5//vQGJissNKI=;
        b=WrLG/PxeT8Lhv3Py/hweQB1qGfkBhUGO+9MHv92/T4cniq7dQehz1bgsfjRforEExe
         HGdrTOkW0HAPXOMl5IJAaMaSvf/eiCDqnukMZb48X3an5uAE4hZeSkwaXojU8+N7m6aN
         4YK5KtnyLfl5pI94npms8moBinu6/4XnTjKWltCaPxIsP0kZIzAiXNwilnAzX7JQMsuw
         tDEd17jgmvd0zVjc4gQgsfgTFTjyaIRcypduNus1ybZjyuyK7GceC7dgt7K3bJ4yiUkD
         O11kDLyGrkJ4AHRKpghNS9ufvl5hIJ1aqdk1pSQ9TniD9UaI2VkArxJ7R4SlWDOtI5N4
         4qrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdNLH1CUQwG1eA6Z+QXRIkbx64vFrxJV658vH6o8HkToZgvBbilst2s1AdjvBVpYRXpFmuhCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtn803rxyjNp7/fnWCU5p2TmVi2AsiBGgKk0GpLodR5JRnt84G
	EnvzkO//939FLHxORyBuT3uCE5zLK0j2Levs5tJ6qjXWdCFbzAGpgnqtCddC9Qif7kKdiyT/wua
	at4J4+84LeM5ktHgTROrMOytvU4hwKq84CtDDue+4usB7rzT8FT7uk6I+BGPUkw==
X-Gm-Gg: ASbGncv7KRSAA24IyarTM5iQmpOkH6nJP4r1q7d4AepBQVlncWHh5TyNYKA52dcWIvi
	0Vgzvyf3HloXoAokKHLXcahcNx+D2tu+mhUOGJeM8BtlykFRlKSVrL/11YWqSf9XJ3IBxxy32QM
	0lLA9JsOLJtECfgb/duVGNFPtgMrM6CjFXB8Uv3EcV7pCt7b8kDefg0MN1AAQznVqpqPF2VbcNl
	yMkbVSvlvAsKD5qpOSyxDn3tj6ly1KDtQlQ237t9Tnrcuzmrjgx4nJkqX66d8xl27Pe0whYgYHo
	ZR4scYF7prnYb3LIx449wpX+
X-Received: by 2002:a05:600c:1f86:b0:436:faeb:2a1b with SMTP id 5b1f17b1804b1-438913db2cfmr255764835e9.13.1737707482071;
        Fri, 24 Jan 2025 00:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX3yIKSTne9MC3H6RxXDiVT2z0GgDBgxOvID6rhp/+jMnFeWaW8ESvc77gSS08CbwWT6bArg==
X-Received: by 2002:a05:600c:1f86:b0:436:faeb:2a1b with SMTP id 5b1f17b1804b1-438913db2cfmr255764335e9.13.1737707481383;
        Fri, 24 Jan 2025 00:31:21 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-186.dyn.eolo.it. [146.241.89.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a18918dsm2036908f8f.57.2025.01.24.00.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 00:31:20 -0800 (PST)
Message-ID: <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com>
Date: Fri, 24 Jan 2025 09:31:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-9-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> +/**
> + * homa_add_packet() - Add an incoming packet to the contents of a
> + * partially received message.
> + * @rpc:   Add the packet to the msgin for this RPC.
> + * @skb:   The new packet. This function takes ownership of the packet
> + *         (the packet will either be freed or added to rpc->msgin.packets).
> + */
> +void homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb)
> +{
> +	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
> +	struct homa_gap *gap, *dummy, *gap2;
> +	int start = ntohl(h->seg.offset);
> +	int length = homa_data_len(skb);
> +	int end = start + length;
> +
> +	if ((start + length) > rpc->msgin.length)
> +		goto discard;
> +
> +	if (start == rpc->msgin.recv_end) {
> +		/* Common case: packet is sequential. */
> +		rpc->msgin.recv_end += length;
> +		goto keep;
> +	}
> +
> +	if (start > rpc->msgin.recv_end) {
> +		/* Packet creates a new gap. */
> +		if (!homa_gap_new(&rpc->msgin.gaps,
> +				  rpc->msgin.recv_end, start)) {
> +			pr_err("Homa couldn't allocate gap: insufficient memory\n");
> +			goto discard;

OoO will cause additional allocation? this feels like DoS prone.

> +		}
> +		rpc->msgin.recv_end = end;
> +		goto keep;
> +	}
> +
> +	/* Must now check to see if the packet fills in part or all of
> +	 * an existing gap.
> +	 */
> +	list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {

Linear search for OoO has proven to be subject to serious dos issue. You
should instead use a (rb-)tree to handle OoO packets.

> +		/* Is packet at the start of this gap? */
> +		if (start <= gap->start) {
> +			if (end <= gap->start)
> +				continue;
> +			if (start < gap->start)
> +				goto discard;
> +			if (end > gap->end)
> +				goto discard;
> +			gap->start = end;
> +			if (gap->start >= gap->end) {
> +				list_del(&gap->links);
> +				kfree(gap);
> +			}
> +			goto keep;
> +		}
> +
> +		/* Is packet at the end of this gap? BTW, at this point we know
> +		 * the packet can't cover the entire gap.
> +		 */
> +		if (end >= gap->end) {
> +			if (start >= gap->end)
> +				continue;
> +			if (end > gap->end)
> +				goto discard;
> +			gap->end = start;
> +			goto keep;
> +		}
> +
> +		/* Packet is in the middle of the gap; must split the gap. */
> +		gap2 = homa_gap_new(&gap->links, gap->start, start);
> +		if (!gap2) {
> +			pr_err("Homa couldn't allocate gap for split: insufficient memory\n");
> +			goto discard;
> +		}
> +		gap2->time = gap->time;
> +		gap->start = end;
> +		goto keep;
> +	}
> +
> +discard:
> +	kfree_skb(skb);
> +	return;
> +
> +keep:
> +	__skb_queue_tail(&rpc->msgin.packets, skb);

Here 'msgin.packets' is apparently under RCP lock protection, but
elsewhere - in homa_rpc_reap() - the list is apparently protected by
it's own lock.

Also it looks like there is no memory accounting at all, and SO_RCVBUF
setting are just ignored.

> +/**
> + * homa_dispatch_pkts() - Top-level function that processes a batch of packets,
> + * all related to the same RPC.
> + * @skb:       First packet in the batch, linked through skb->next.
> + * @homa:      Overall information about the Homa transport.
> + */
> +void homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa)

I see I haven't mentioned the following so far, but you should move the
struct homa to a pernet subsystem.

> +{
> +#define MAX_ACKS 10
> +	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
> +	__u64 id = homa_local_id(h->common.sender_id);
> +	int dport = ntohs(h->common.dport);
> +
> +	/* Used to collect acks from data packets so we can process them
> +	 * all at the end (can't process them inline because that may
> +	 * require locking conflicting RPCs). If we run out of space just
> +	 * ignore the extra acks; they'll be regenerated later through the
> +	 * explicit mechanism.
> +	 */
> +	struct homa_ack acks[MAX_ACKS];
> +	struct homa_rpc *rpc = NULL;
> +	struct homa_sock *hsk;
> +	struct sk_buff *next;
> +	int num_acks = 0;
> +
> +	/* Find the appropriate socket.*/
> +	hsk = homa_sock_find(homa->port_map, dport);

This needs RCU protection

> +	if (!hsk) {
> +		if (skb_is_ipv6(skb))
> +			icmp6_send(skb, ICMPV6_DEST_UNREACH,
> +				   ICMPV6_PORT_UNREACH, 0, NULL, IP6CB(skb));
> +		else
> +			icmp_send(skb, ICMP_DEST_UNREACH,
> +				  ICMP_PORT_UNREACH, 0);
> +		while (skb) {
> +			next = skb->next;
> +			kfree_skb(skb);
> +			skb = next;
> +		}
> +		return;
> +	}
> +
> +	/* Each iteration through the following loop processes one packet. */
> +	for (; skb; skb = next) {
> +		h = (struct homa_data_hdr *)skb->data;
> +		next = skb->next;
> +
> +		/* Relinquish the RPC lock temporarily if it's needed
> +		 * elsewhere.
> +		 */
> +		if (rpc) {
> +			int flags = atomic_read(&rpc->flags);
> +
> +			if (flags & APP_NEEDS_LOCK) {
> +				homa_rpc_unlock(rpc);
> +				homa_spin(200);
> +				rpc = NULL;
> +			}
> +		}
> +
> +		/* Find and lock the RPC if we haven't already done so. */
> +		if (!rpc) {
> +			if (!homa_is_client(id)) {
> +				/* We are the server for this RPC. */
> +				if (h->common.type == DATA) {
> +					int created;
> +
> +					/* Create a new RPC if one doesn't
> +					 * already exist.
> +					 */
> +					rpc = homa_rpc_new_server(hsk, &saddr,
> +								  h, &created);

It looks like a buggy or malicious client could force server RPC
allocation to any _client_ ?!?

> +					if (IS_ERR(rpc)) {
> +						pr_warn("homa_pkt_dispatch couldn't create server rpc: error %lu",
> +							-PTR_ERR(rpc));
> +						rpc = NULL;
> +						goto discard;
> +					}
> +				} else {
> +					rpc = homa_find_server_rpc(hsk, &saddr,
> +								   id);
> +				}
> +			} else {
> +				rpc = homa_find_client_rpc(hsk, id);

Both the client and the server lookup require a contended lock; The
lookup could/should be lockless, and the the lock could/should be
asserted only on the relevant RPC.

> +			}
> +		}
> +		if (unlikely(!rpc)) {
> +			if (h->common.type != NEED_ACK &&
> +			    h->common.type != ACK &&
> +			    h->common.type != RESEND)
> +				goto discard;
> +		} else {
> +			if (h->common.type == DATA ||
> +			    h->common.type == BUSY ||
> +			    h->common.type == NEED_ACK)
> +				rpc->silent_ticks = 0;
> +			rpc->peer->outstanding_resends = 0;
> +		}
> +
> +		switch (h->common.type) {
> +		case DATA:
> +			if (h->ack.client_id) {
> +				/* Save the ack for processing later, when we
> +				 * have released the RPC lock.
> +				 */
> +				if (num_acks < MAX_ACKS) {
> +					acks[num_acks] = h->ack;
> +					num_acks++;
> +				}
> +			}
> +			homa_data_pkt(skb, rpc);
> +			break;
> +		case RESEND:
> +			homa_resend_pkt(skb, rpc, hsk);
> +			break;
> +		case UNKNOWN:
> +			homa_unknown_pkt(skb, rpc);

It's sort of unexpected that the protocol explicitly defines the unknown
packet type, and handles it differently form undefined types.

> +			break;
> +		case BUSY:
> +			/* Nothing to do for these packets except reset
> +			 * silent_ticks, which happened above.
> +			 */
> +			goto discard;
> +		case NEED_ACK:
> +			homa_need_ack_pkt(skb, hsk, rpc);
> +			break;
> +		case ACK:
> +			homa_ack_pkt(skb, hsk, rpc);
> +			rpc = NULL;
> +
> +			/* It isn't safe to process more packets once we've
> +			 * released the RPC lock (this should never happen).
> +			 */
> +			while (next) {
> +				WARN_ONCE(next, "%s found extra packets after AC<\n",
> +					  __func__);

It looks like the above WARN could be triggered by an unexpected traffic
pattern generate from the client. If so, you should avoid the WARN() and
instead use e.g. some mib counter.

> +				skb = next;
> +				next = skb->next;
> +				kfree_skb(skb);
> +			}
> +			break;
> +		default:
> +			goto discard;
> +		}
> +		continue;
> +
> +discard:
> +		kfree_skb(skb);
> +	}
> +	if (rpc)
> +		homa_rpc_unlock(rpc);
> +
> +	while (num_acks > 0) {
> +		num_acks--;
> +		homa_rpc_acked(hsk, &saddr, &acks[num_acks]);
> +	}
> +
> +	if (hsk->dead_skbs >= 2 * hsk->homa->dead_buffs_limit)
> +		/* We get here if neither homa_wait_for_message
> +		 * nor homa_timer can keep up with reaping dead
> +		 * RPCs. See reap.txt for details.
> +		 */
> +		homa_rpc_reap(hsk, false);
> +}
> +
> +/**
> + * homa_data_pkt() - Handler for incoming DATA packets
> + * @skb:     Incoming packet; size known to be large enough for the header.
> + *           This function now owns the packet.
> + * @rpc:     Information about the RPC corresponding to this packet.
> + *           Must be locked by the caller.
> + */
> +void homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc)
> +{
> +	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
> +
> +	if (rpc->state != RPC_INCOMING && homa_is_client(rpc->id)) {
> +		if (unlikely(rpc->state != RPC_OUTGOING))
> +			goto discard;
> +		rpc->state = RPC_INCOMING;
> +		if (homa_message_in_init(rpc, ntohl(h->message_length)) != 0)
> +			goto discard;
> +	} else if (rpc->state != RPC_INCOMING) {
> +		/* Must be server; note that homa_rpc_new_server already
> +		 * initialized msgin and allocated buffers.
> +		 */
> +		if (unlikely(rpc->msgin.length >= 0))
> +			goto discard;
> +	}
> +
> +	if (rpc->msgin.num_bpages == 0)
> +		/* Drop packets that arrive when we can't allocate buffer
> +		 * space. If we keep them around, packet buffer usage can
> +		 * exceed available cache space, resulting in poor
> +		 * performance.
> +		 */
> +		goto discard;
> +
> +	homa_add_packet(rpc, skb);
> +
> +	if (skb_queue_len(&rpc->msgin.packets) != 0 &&
> +	    !(atomic_read(&rpc->flags) & RPC_PKTS_READY)) {
> +		atomic_or(RPC_PKTS_READY, &rpc->flags);
> +		homa_sock_lock(rpc->hsk, "homa_data_pkt");
> +		homa_rpc_handoff(rpc);
> +		homa_sock_unlock(rpc->hsk);

It looks like you tryied to enforce the following lock acquiring order:
rpc lock
socket lock
which is IMHO quite innatural, as the socket has a wider scope than the
RPC. In practice the locking schema is quite complex and hard to follow.
I think (wild guess) that inverting the lock order would simplify the
locking schema significantly.

[...]
> +/**
> + * homa_ack_pkt() - Handler for incoming ACK packets
> + * @skb:     Incoming packet; size already verified large enough for header.
> + *           This function now owns the packet.
> + * @hsk:     Socket on which the packet was received.
> + * @rpc:     The RPC named in the packet header, or NULL if no such
> + *           RPC exists. The RPC has been locked by the caller but will
> + *           be unlocked here.
> + */
> +void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +		  struct homa_rpc *rpc)
> +	__releases(rpc->bucket_lock)
> +{
> +	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	struct homa_ack_hdr *h = (struct homa_ack_hdr *)skb->data;
> +	int i, count;
> +
> +	if (rpc) {
> +		homa_rpc_free(rpc);
> +		homa_rpc_unlock(rpc);

Another point that makes IMHO the locking schema hard to follow is the
fact that many non-locking-related functions acquires or release some
lock internally. The code would be much more easy to follow if you could
pair the lock and unlock as much as possible inside the same code block.

> +	}
> +
> +	count = ntohs(h->num_acks);
> +	for (i = 0; i < count; i++)
> +		homa_rpc_acked(hsk, &saddr, &h->acks[i]);
> +	kfree_skb(skb);
> +}
> +
> +/**
> + * homa_rpc_abort() - Terminate an RPC.
> + * @rpc:     RPC to be terminated.  Must be locked by caller.
> + * @error:   A negative errno value indicating the error that caused the abort.
> + *           If this is a client RPC, the error will be returned to the
> + *           application; if it's a server RPC, the error is ignored and
> + *           we just free the RPC.
> + */
> +void homa_rpc_abort(struct homa_rpc *rpc, int error)
> +{
> +	if (!homa_is_client(rpc->id)) {
> +		homa_rpc_free(rpc);
> +		return;
> +	}
> +	rpc->error = error;
> +	homa_sock_lock(rpc->hsk, "homa_rpc_abort");
> +	if (!rpc->hsk->shutdown)
> +		homa_rpc_handoff(rpc);
> +	homa_sock_unlock(rpc->hsk);
> +}
> +
> +/**
> + * homa_abort_rpcs() - Abort all RPCs to/from a particular peer.
> + * @homa:    Overall data about the Homa protocol implementation.
> + * @addr:    Address (network order) of the destination whose RPCs are
> + *           to be aborted.
> + * @port:    If nonzero, then RPCs will only be aborted if they were
> + *	     targeted at this server port.
> + * @error:   Negative errno value indicating the reason for the abort.
> + */
> +void homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
> +		     int port, int error)
> +{
> +	struct homa_socktab_scan scan;
> +	struct homa_rpc *rpc, *tmp;
> +	struct homa_sock *hsk;
> +
> +	rcu_read_lock();
> +	for (hsk = homa_socktab_start_scan(homa->port_map, &scan); hsk;
> +	     hsk = homa_socktab_next(&scan)) {
> +		/* Skip the (expensive) lock acquisition if there's no
> +		 * work to do.
> +		 */
> +		if (list_empty(&hsk->active_rpcs))
> +			continue;
> +		if (!homa_protect_rpcs(hsk))
> +			continue;
> +		list_for_each_entry_safe(rpc, tmp, &hsk->active_rpcs,
> +					 active_links) {
> +			if (!ipv6_addr_equal(&rpc->peer->addr, addr))
> +				continue;
> +			if (port && rpc->dport != port)
> +				continue;
> +			homa_rpc_lock(rpc, "rpc_abort_rpcs");
> +			homa_rpc_abort(rpc, error);
> +			homa_rpc_unlock(rpc);
> +		}
> +		homa_unprotect_rpcs(hsk);
> +	}
> +	homa_socktab_end_scan(&scan);
> +	rcu_read_unlock();
> +}
> +
> +/**
> + * homa_abort_sock_rpcs() - Abort all outgoing (client-side) RPCs on a given
> + * socket.
> + * @hsk:         Socket whose RPCs should be aborted.
> + * @error:       Zero means that the aborted RPCs should be freed immediately.
> + *               A nonzero value means that the RPCs should be marked
> + *               complete, so that they can be returned to the application;
> + *               this value (a negative errno) will be returned from
> + *               recvmsg.
> + */
> +void homa_abort_sock_rpcs(struct homa_sock *hsk, int error)
> +{
> +	struct homa_rpc *rpc, *tmp;
> +
> +	rcu_read_lock();
> +	if (list_empty(&hsk->active_rpcs))
> +		goto done;
> +	if (!homa_protect_rpcs(hsk))
> +		goto done;
> +	list_for_each_entry_safe(rpc, tmp, &hsk->active_rpcs, active_links) {
> +		if (!homa_is_client(rpc->id))
> +			continue;
> +		homa_rpc_lock(rpc, "homa_abort_sock_rpcs");
> +		if (rpc->state == RPC_DEAD) {
> +			homa_rpc_unlock(rpc);
> +			continue;
> +		}
> +		if (error)
> +			homa_rpc_abort(rpc, error);
> +		else
> +			homa_rpc_free(rpc);
> +		homa_rpc_unlock(rpc);
> +	}
> +	homa_unprotect_rpcs(hsk);
> +done:
> +	rcu_read_unlock();
> +}
> +
> +/**
> + * homa_register_interests() - Records information in various places so
> + * that a thread will be woken up if an RPC that it cares about becomes
> + * available.
> + * @interest:     Used to record information about the messages this thread is
> + *                waiting on. The initial contents of the structure are
> + *                assumed to be undefined.
> + * @hsk:          Socket on which relevant messages will arrive.  Must not be
> + *                locked.
> + * @flags:        Flags field from homa_recvmsg_args; see manual entry for
> + *                details.
> + * @id:           If non-zero, then the caller is interested in receiving
> + *                the response for this RPC (@id must be a client request).
> + * Return:        Either zero or a negative errno value. If a matching RPC
> + *                is already available, information about it will be stored in
> + *                interest.
> + */
> +int homa_register_interests(struct homa_interest *interest,
> +			    struct homa_sock *hsk, int flags, __u64 id)
> +{
> +	struct homa_rpc *rpc = NULL;
> +	int locked = 1;
> +
> +	homa_interest_init(interest);
> +	if (id != 0) {
> +		if (!homa_is_client(id))
> +			return -EINVAL;
> +		rpc = homa_find_client_rpc(hsk, id); /* Locks rpc. */
> +		if (!rpc)
> +			return -EINVAL;
> +		if (rpc->interest && rpc->interest != interest) {
> +			homa_rpc_unlock(rpc);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Need both the RPC lock (acquired above) and the socket lock to
> +	 * avoid races.
> +	 */
> +	homa_sock_lock(hsk, "homa_register_interests");
> +	if (hsk->shutdown) {
> +		homa_sock_unlock(hsk);
> +		if (rpc)
> +			homa_rpc_unlock(rpc);
> +		return -ESHUTDOWN;
> +	}
> +
> +	if (id != 0) {
> +		if ((atomic_read(&rpc->flags) & RPC_PKTS_READY) || rpc->error)
> +			goto claim_rpc;
> +		rpc->interest = interest;
> +		interest->reg_rpc = rpc;
> +		homa_rpc_unlock(rpc);

With the current schema you should release the hsh socket lock before
releasing the rpc one.

> +	}
> +
> +	locked = 0;
> +	if (flags & HOMA_RECVMSG_RESPONSE) {
> +		if (!list_empty(&hsk->ready_responses)) {
> +			rpc = list_first_entry(&hsk->ready_responses,
> +					       struct homa_rpc,
> +					       ready_links);
> +			goto claim_rpc;
> +		}
> +		/* Insert this thread at the *front* of the list;
> +		 * we'll get better cache locality if we reuse
> +		 * the same thread over and over, rather than
> +		 * round-robining between threads.  Same below.
> +		 */
> +		list_add(&interest->response_links,
> +			 &hsk->response_interests);
> +	}
> +	if (flags & HOMA_RECVMSG_REQUEST) {
> +		if (!list_empty(&hsk->ready_requests)) {
> +			rpc = list_first_entry(&hsk->ready_requests,
> +					       struct homa_rpc, ready_links);
> +			/* Make sure the interest isn't on the response list;
> +			 * otherwise it might receive a second RPC.
> +			 */
> +			if (!list_empty(&interest->response_links))
> +				list_del_init(&interest->response_links);
> +			goto claim_rpc;
> +		}
> +		list_add(&interest->request_links, &hsk->request_interests);
> +	}
> +	homa_sock_unlock(hsk);
> +	return 0;
> +
> +claim_rpc:
> +	list_del_init(&rpc->ready_links);
> +	if (!list_empty(&hsk->ready_requests) ||
> +	    !list_empty(&hsk->ready_responses)) {
> +		hsk->sock.sk_data_ready(&hsk->sock);
> +	}
> +
> +	/* This flag is needed to keep the RPC from being reaped during the
> +	 * gap between when we release the socket lock and we acquire the
> +	 * RPC lock.
> +	 */
> +	atomic_or(RPC_HANDING_OFF, &rpc->flags);
> +	homa_sock_unlock(hsk);
> +	if (!locked) {
> +		atomic_or(APP_NEEDS_LOCK, &rpc->flags);
> +		homa_rpc_lock(rpc, "homa_register_interests");
> +		atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
> +		locked = 1;
> +	}
> +	atomic_andnot(RPC_HANDING_OFF, &rpc->flags);
> +	homa_interest_set_rpc(interest, rpc, locked);
> +	return 0;
> +}
> +
> +/**
> + * homa_wait_for_message() - Wait for receipt of an incoming message
> + * that matches the parameters. Various other activities can occur while
> + * waiting, such as reaping dead RPCs and copying data to user space.
> + * @hsk:          Socket where messages will arrive.
> + * @flags:        Flags field from homa_recvmsg_args; see manual entry for
> + *                details.
> + * @id:           If non-zero, then a response message matching this id may
> + *                be returned (@id must refer to a client request).
> + *
> + * Return:   Pointer to an RPC that matches @flags and @id, or a negative
> + *           errno value. The RPC will be locked; the caller must unlock.
> + */
> +struct homa_rpc *homa_wait_for_message(struct homa_sock *hsk, int flags,
> +				       __u64 id)
> +	__acquires(&rpc->bucket_lock)
> +{
> +	struct homa_rpc *result = NULL;
> +	struct homa_interest interest;
> +	struct homa_rpc *rpc = NULL;
> +	int error;
> +
> +	/* Each iteration of this loop finds an RPC, but it might not be
> +	 * in a state where we can return it (e.g., there might be packets
> +	 * ready to transfer to user space, but the incoming message isn't yet
> +	 * complete). Thus it could take many iterations of this loop
> +	 * before we have an RPC with a complete message.
> +	 */
> +	while (1) {
> +		error = homa_register_interests(&interest, hsk, flags, id);
> +		rpc = homa_interest_get_rpc(&interest);
> +		if (rpc)
> +			goto found_rpc;
> +		if (error < 0) {
> +			result = ERR_PTR(error);
> +			goto found_rpc;
> +		}
> +
> +		/* There is no ready RPC so far. Clean up dead RPCs before
> +		 * going to sleep (or returning, if in nonblocking mode).
> +		 */
> +		while (1) {
> +			int reaper_result;
> +
> +			rpc = homa_interest_get_rpc(&interest);
> +			if (rpc)
> +				goto found_rpc;
> +			reaper_result = homa_rpc_reap(hsk, false);
> +			if (reaper_result == 0)
> +				break;
> +
> +			/* Give NAPI and SoftIRQ tasks a chance to run. */
> +			schedule();
> +		}
> +		if (flags & HOMA_RECVMSG_NONBLOCKING) {
> +			result = ERR_PTR(-EAGAIN);
> +			goto found_rpc;
> +		}
> +
> +		/* Now it's time to sleep. */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		rpc = homa_interest_get_rpc(&interest);
> +		if (!rpc && !hsk->shutdown)
> +			schedule();
> +		__set_current_state(TASK_RUNNING);
> +
> +found_rpc:
> +		/* If we get here, it means either an RPC is ready for our
> +		 * attention or an error occurred.
> +		 *
> +		 * First, clean up all of the interests. Must do this before
> +		 * making any other decisions, because until we do, an incoming
> +		 * message could still be passed to us. Note: if we went to
> +		 * sleep, then this info was already cleaned up by whoever
> +		 * woke us up. Also, values in the interest may change between
> +		 * when we test them below and when we acquire the socket lock,
> +		 * so they have to be checked again after locking the socket.
> +		 */
> +		if (interest.reg_rpc ||
> +		    !list_empty(&interest.request_links) ||
> +		    !list_empty(&interest.response_links)) {
> +			homa_sock_lock(hsk, "homa_wait_for_message");
> +			if (interest.reg_rpc)
> +				interest.reg_rpc->interest = NULL;
> +			if (!list_empty(&interest.request_links))
> +				list_del_init(&interest.request_links);
> +			if (!list_empty(&interest.response_links))
> +				list_del_init(&interest.response_links);
> +			homa_sock_unlock(hsk);
> +		}
> +
> +		/* Now check to see if we received an RPC handoff (note that
> +		 * this could have happened anytime up until we reset the
> +		 * interests above).
> +		 */
> +		rpc = homa_interest_get_rpc(&interest);
> +		if (rpc) {
> +			if (!interest.locked) {
> +				atomic_or(APP_NEEDS_LOCK, &rpc->flags);
> +				homa_rpc_lock(rpc, "homa_wait_for_message");
> +				atomic_andnot(APP_NEEDS_LOCK | RPC_HANDING_OFF,
> +					      &rpc->flags);
> +			} else {
> +				atomic_andnot(RPC_HANDING_OFF, &rpc->flags);
> +			}
> +			if (!rpc->error)
> +				rpc->error = homa_copy_to_user(rpc);
> +			if (rpc->state == RPC_DEAD) {
> +				homa_rpc_unlock(rpc);
> +				continue;
> +			}
> +			if (rpc->error)
> +				goto done;
> +			atomic_andnot(RPC_PKTS_READY, &rpc->flags);
> +			if (rpc->msgin.bytes_remaining == 0 &&
> +			    !skb_queue_len(&rpc->msgin.packets))
> +				goto done;
> +			homa_rpc_unlock(rpc);
> +		}
> +
> +		/* A complete message isn't available: check for errors. */
> +		if (IS_ERR(result))
> +			return result;
> +		if (signal_pending(current))
> +			return ERR_PTR(-EINTR);
> +
> +		/* No message and no error; try again. */
> +	}
> +
> +done:
> +	return rpc;

The amount of custom code to wait is concerning. Why can't you build
around sk_wait_event()?

/P


