Return-Path: <netdev+bounces-284372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hz0D8jl+Wn2EwMAu9opvQ
	(envelope-from <netdev+bounces-284372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35C4CDC2E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B856130599DB
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49242B724;
	Tue,  5 May 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZgitXAQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6B382F23;
	Tue,  5 May 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984860; cv=none; b=dgsCXS2SVqQ8AE0QgW5gj5vur3j186u7PdKLArBIfKS4h9N5kVWplpEcc+PvuBnD0HZvgLeqwqn+Zjj+mBBp3idM2DVh41me+iVRRjK/UKrfDvySqJ0fX6ThnSdfDWirvPTUbcUq/qVfqAHu4cPUAd23atOJd+ByULLcSI2qsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984860; c=relaxed/simple;
	bh=xSeupnuvJlm1SCUwSLTr6zr3hWRgUFyf0/4uoYJZNaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9Au2SglrDL+8AhNKd/YwG+gIy35pg6TF4W1IWl6nbqcZ2aG7smAe4ihbi7D2lzQwwmeod4+sxbf06bi1Y3Ms5dIxcEdUUwtsjF25GiMle9WDd6tmAx+T3SBSLoGrjgBhAs4wIA9PTADFhYlREIQBzYHzvqzlR0PW4vLaLYCe2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZgitXAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23959C2BCB4;
	Tue,  5 May 2026 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984859;
	bh=xSeupnuvJlm1SCUwSLTr6zr3hWRgUFyf0/4uoYJZNaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aZgitXAQKnW8uvL01qWyAO8epkmapRR+vivO7oPD4fKv9/nkYvrQ+aO/slBm5f88/
	 QZTDO48wpznV2zMZUJLQ4fxkCKqYciPLGFUf69yd4J8scVI45m1Cc21jAUiTsDTSUz
	 J8g6LLCuC357F0VkIUPeiPKoFjs20PODZ6jmcw26u+w6eJu7+BXxsDH21QKjK6gCd6
	 f0aK4gasN5dT0zd+L59XUVA64VNl7JTnZOc2hgy3Lk3xHGSwNIyJb2k8451k4tehkz
	 IyAQERUtR9xEMDBPHx98qVih9IJW72p62eJ4UtkSnHZxDmt7SBAFAv4MAs4IkEgq5v
	 fG55DM5de+v/Q==
Message-ID: <0737c71e-0614-4ecf-9801-a7e71be198d4@kernel.org>
Date: Tue, 5 May 2026 14:40:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/4] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20260501071633.644353-3-hawk@kernel.org>
 <20260502071828.616C3C19425@smtp.kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260502071828.616C3C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9F35C4CDC2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284372-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 02/05/2026 09.18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Out-of-bounds array access on peer_dev->_tx in veth_poll() when local RX queues exceed peer TX queues.
> - [High] Disabling XDP permanently stops peer TX queues if they were backpressured (DRV_XOFF leak).
> --
> 
> commit 9bc3ed022846dda6dd5cc131e798f949f63f491f
> Author: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> veth: implement Byte Queue Limits (BQL) for latency reduction
> 
> This commit adds byte queue limits support to the veth driver to provide
> qdiscs with feedback and reduce latency. It charges a fixed unit per
> packet rather than byte-based charging.
> 
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index e35df717e65e2..3de25ba34a906 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
> 
> [ ... ]
> 
>> @@ -975,7 +1016,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>   	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
>>   
>>   	xdp_set_return_frame_no_direct();
>> -	done = veth_xdp_rcv(rq, budget, &bq, &stats);
>> +	done = veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
> 
> Could this lead to an out-of-bounds array access on the peer device's
> transmit queues?
> 
> If a veth pair is configured asymmetrically, the local device might have
> more receive queues than the peer has transmit queues.
> 
> If packets are redirected from another interface into a higher-indexed
> receive queue, the poll function will run with a queue_idx greater than or
> equal to peer_dev->real_num_tx_queues.
> 
> Since netdev_get_tx_queue() performs a direct array access without bounds
> checking, peer_txq would point out-of-bounds. This out-of-bounds pointer is
> then passed into the new veth_xdp_rcv() code paths and accessed by
> netif_tx_queue_stopped().
> 
> Should queue_idx be checked against peer_dev->real_num_tx_queues before
> fetching the transmit queue?
Yes, for the XDP redirect code path, which enqueues frames into the
peer's ptr_ring using smp_processor_id() % peer->real_num_rx_queues
as the ring index.  Then this is actually possible.

It is not a bug introduced in this patchset, but given we access
peer_txq a bit earlier, then a fix for this is needed as part of this
patchset. I have prepared a patch that fixes this.

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e35df717e65e..0cfb19b760dd 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -972,7 +972,8 @@ static int veth_poll(struct napi_struct *napi, int 
budget)

         /* NAPI functions as RCU section */
         peer_dev = rcu_dereference_check(priv->peer, 
rcu_read_lock_bh_held());
-       peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : 
NULL;
+       peer_txq = (peer_dev && queue_idx < peer_dev->real_num_tx_queues) ?
+                  netdev_get_tx_queue(peer_dev, queue_idx) : NULL;



> [ ... ]
> 
>> @@ -1091,6 +1133,17 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
>>   		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>>   	}
>>   
>> +	/* Reset BQL on peer's txqs: remaining ring items were freed above
>> +	 * without BQL completion, so DQL state must be reset.
>> +	 */
>> +	peer = rtnl_dereference(priv->peer);
>> +	if (peer) {
>> +		int peer_end = min(end, (int)peer->real_num_tx_queues);
>> +
>> +		for (i = start; i < peer_end; i++)
>> +			netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
>> +	}
> 
> Does this cleanup leave peer transmit queues permanently stopped if they
> were backpressured when xdp was disabled?
> 
> When the ptr_ring is full, veth_xmit() stops the transmit queue using
> netif_tx_stop_queue(), which sets the __QUEUE_STATE_DRV_XOFF flag.
> 
> While netdev_tx_reset_queue() successfully clears the newly added
> __QUEUE_STATE_STACK_XOFF flag, it does not clear __QUEUE_STATE_DRV_XOFF.
> If a queue was backpressured exactly when xdp is disabled, it appears it
> would remain locked forever.
> 
> Would it be appropriate to wake the queues using netif_tx_wake_queue() or
> explicitly clear the __QUEUE_STATE_DRV_XOFF flag during this cleanup?

The watchdog timer in this patchset will call netif_tx_wake_queue().
So, we would recover from this unlikely case.  I guess there is no harm
in adding a netif_tx_wake_queue() call here (but we should likely guard
it with netif_running(dev)).

--Jesper


