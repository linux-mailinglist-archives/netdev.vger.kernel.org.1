Return-Path: <netdev+bounces-268900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL8vEmtTumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:25:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F30AD2B6E53
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ACE23081B19
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E736A000;
	Wed, 18 Mar 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc565dv2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275D33D51A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818515; cv=none; b=dZDcoF3LiNuBEEphkxMYF0xhoSeMPLhXWUADXyITUsRwOBgJuYe2zalpgPwJOf+EWfHfBddVCmlIlPHKMfyPToGjk2IZLK6yqcpM9K0iDqkLJ4RinpwikOsqc9JiIIizPC7x9qaJ0CNEPzI6Tkf6q3jhx0UQu228/9hF118nHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818515; c=relaxed/simple;
	bh=/hBL1LSJrFst+utroPAH2APhYh6jKEaIrSvN1NfgBUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A268gthqRuFVVrcU6LTnWYdOSiCAQTwWpGYjyShX6Pl+/8fDizqmngZ7TTYbBncRkwLFI9kZm5EcGkcqLgkLOhad2v2lzAVKQUih3Yjg8GJSdoY32tzSU4OoehsyNSEz5YDM2yk9VFMObnDGD83X4JnkJ7jujfjB9jQsfe2srnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nc565dv2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrST5Li+rhEE3Yph8VtJiQzg3H9TOldHUeDae3FricM=;
	b=Nc565dv2pbqxGFQ2SG8d7vYUbaMikFHvzoA1uV0B/CflQmYa26tPdkzc2An4e+ndMxGkBK
	OMZLM2E8KxfdCCG+mzkiyKcaV6Tf0Tyqeyqm1xUiSGmPNnnxFbw7dufyeDO5YPKssWZLNC
	h7Idpa2ZKhu9XFM8EuePqkO53oZI7sY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-sA4CLulvP_uFAzFFBQRMgQ-1; Wed,
 18 Mar 2026 03:21:50 -0400
X-MC-Unique: sA4CLulvP_uFAzFFBQRMgQ-1
X-Mimecast-MFC-AGG-ID: sA4CLulvP_uFAzFFBQRMgQ_1773818509
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6F2719560B4;
	Wed, 18 Mar 2026 07:21:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6BD01800107;
	Wed, 18 Mar 2026 07:21:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,11/14] net: homa: create homa_incoming.c
Date: Wed, 18 Mar 2026 08:21:44 +0100
Message-ID: <20260318072144.269088-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-12-ouster@cs.stanford.edu>
References: <20260316223228.2611-12-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268900-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F30AD2B6E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create homa_incoming.c

This file contains most of the code for handling incoming packets,
including top-level dispatching code plus specific handlers for each
pack type. It also contains code for dispatching fully-received
messages to waiting application threads.

> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
> index 4726762b688f..779abd7bb1b7 100644
> --- a/net/homa/homa_impl.h
> +++ b/net/homa/homa_impl.h

[ ... ]

> diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
> new file mode 100644
> index 000000000000..f083784921f4
> --- /dev/null
> +++ b/net/homa/homa_incoming.c

[ ... ]

> @@ -0,0 +1,887 @@

[ ... ]

> +/**
> + * homa_add_packet() - Add an incoming packet to the contents of a
> + * partially received message.
> + * @rpc:   Add the packet to the msgin for this RPC.
> + * @skb:   The new packet. This function takes ownership of the packet
> + *         (the packet will either be freed or added to rpc->msgin.packets).
> + */
> +void homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb)
> +	__must_hold(rpc->bucket->lock)
> +{
> +	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
> +	struct homa_gap *gap, *dummy, *gap2;
> +	int start = ntohl(h->seg.offset);
> +	int length = homa_data_len(skb);
> +	enum skb_drop_reason reason;
> +	int end = start + length;
> +
> +	if ((start + length) > rpc->msgin.length) {
> +		reason = SKB_DROP_REASON_PKT_TOO_BIG;
> +		goto discard;
> +	}
> +
> +	if (start == rpc->msgin.recv_end) {
> +		/* Common case: packet is sequential. */
> +		rpc->msgin.recv_end += length;
> +		goto keep;
> +	}
> +
> +	if (start > rpc->msgin.recv_end) {
> +		/* Packet creates a new gap. */
> +		if (!homa_gap_alloc(&rpc->msgin.gaps,
> +				    rpc->msgin.recv_end, start)) {
> +			reason = SKB_DROP_REASON_NOMEM;
> +			goto discard;
> +		}
> +		rpc->msgin.recv_end = end;
> +		goto keep;
> +	}
> +
> +	/* Must now check to see if the packet fills in part or all of
> +	 * an existing gap.
> +	 */
> +	list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
> +		/* Is packet at the start of this gap? */
> +		if (start <= gap->start) {
> +			if (end <= gap->start)
> +				continue;
> +			if (start < gap->start) {
> +				reason = SKB_DROP_REASON_DUP_FRAG;
> +				goto discard;
> +			}
> +			if (end > gap->end) {
> +				reason = SKB_DROP_REASON_DUP_FRAG;
> +				goto discard;
> +			}
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
> +			if (end > gap->end) {
> +				reason = SKB_DROP_REASON_DUP_FRAG;
> +				goto discard;
> +			}
> +			gap->end = start;
> +			goto keep;
> +		}
> +
> +		/* Packet is in the middle of the gap; must split the gap. */
> +		gap2 = homa_gap_alloc(&gap->links, gap->start, start);
> +		if (!gap2) {
> +			reason = SKB_DROP_REASON_NOMEM;
> +			goto discard;
> +		}
> +		gap2->time = gap->time;
> +		gap->start = end;
> +		goto keep;
> +	}
> +
> +discard:
> +	kfree_skb_reason(skb, reason);
                           ^^^^^^

Can the 'reason' variable be used uninitialized here? When data has been
received sequentially (no gaps), a retransmitted duplicate packet with an
offset below recv_end won't match any of the early conditions (it doesn't
equal recv_end, it isn't greater than recv_end), so it falls through to the
gap traversal loop. With an empty gap list, the loop body never executes and
execution continues to the discard label where kfree_skb_reason() is called
with an uninitialized reason.

[ ... ]

> +/**
> + * homa_copy_to_user() - Copy as much data as possible from incoming
> + * packet buffers to buffers in user space.
> + * @rpc:     RPC for which data should be copied. Must be locked by caller.
> + * Return:   Zero for success or a negative errno if there is an error.
> + *           It is possible for the RPC to be freed while this function
> + *           executes (it releases and reacquires the RPC lock). If that
> + *           happens, -EINVAL will be returned and the state of @rpc
> + *           will be RPC_DEAD. Clears the RPC_PKTS_READY bit in @rpc->flags
> + *           if all available packets have been copied out.
> + */
> +int homa_copy_to_user(struct homa_rpc *rpc)
> +	__must_hold(rpc->bucket->lock)
> +{

[ ... ]

> +/**
> + * homa_dispatch_pkts() - Top-level function that processes a batch of packets,
> + * all related to the same RPC.
> + * @skb:       First packet in the batch, linked through skb->next.
> + */
> +void homa_dispatch_pkts(struct sk_buff *skb)
> +{

[ ... ]

> +		switch (h->common.type) {
> +		case DATA:
> +			homa_data_pkt(skb, rpc);
> +			break;
> +		case RESEND:
> +			homa_resend_pkt(skb, rpc, hsk);
> +			break;
> +		case RPC_UNKNOWN:
> +			homa_rpc_unknown_pkt(skb, rpc);
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
> +			break;
> +			goto discard;
                    ^^^^^^^^^^^^

This goto is unreachable because it follows the break statement above.
More critically, the switch has no default case. Looking at the validation
in homa_softirq (which checks 'h->type >= DATA && h->type <= MAX_OP'),
the header_lengths array (defined in homa_plumbing.c) has zero entries
for types 0x11, 0x15, and 0x16. Packets with these type values pass
validation since 'skb->len < 0' is always false.

When such a packet reaches homa_dispatch_pkts, no case matches, execution
falls through to 'continue', and the SKB is never freed. Can this leak
memory?

[ ... ]

> +/**
> + * homa_ack_pkt() - Handler for incoming ACK packets
> + * @skb:     Incoming packet; size already verified large enough for header.
> + *           This function now owns the packet.
> + * @hsk:     Socket on which the packet was received.
> + * @rpc:     The RPC named in the packet header, or NULL if no such
> + *           RPC exists. The RPC lock will be dead on return.
> + */
> +void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +		  struct homa_rpc *rpc)
> +	__must_hold(rpc->bucket->lock)
> +{
> +	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	struct homa_ack_hdr *h = (struct homa_ack_hdr *)skb->data;
> +	int i, count;
> +
> +	if (rpc)
> +		homa_rpc_end(rpc);
> +
> +	count = ntohs(h->num_acks);
> +	if (count > 0) {
> +		if (rpc) {
> +			/* Must temporarily release rpc's lock because
> +			 * homa_rpc_acked needs to acquire RPC locks.
> +			 */
> +			homa_rpc_unlock(rpc);
> +			for (i = 0; i < count; i++)
> +				homa_rpc_acked(hsk, &saddr, &h->acks[i]);
                                                               ^^^^^^^^^^^

Is 'count' validated before accessing h->acks[i] in this loop? The
num_acks field comes from the network via ntohs() and can be any value
from 0 to 65535. The acks array in struct homa_ack_hdr is declared as
'struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT]' where HOMA_MAX_ACKS_PER_PKT
is 5 in net/homa/homa_wire.h.

If a peer sends an ACK packet with num_acks > 5, this code reads beyond
the acks[] array boundary in the skb data. The out-of-bounds data is
passed to homa_rpc_acked() which dereferences it (reading ack->server_port
and ack->client_id). Can this cause protocol state corruption or a kernel
crash if the read extends beyond the skb's allocated linear data region?


