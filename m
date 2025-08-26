Return-Path: <netdev+bounces-216898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33BB35CDA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416301BA4451
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5ED2F619C;
	Tue, 26 Aug 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af2sNm3S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9534A31F
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207912; cv=none; b=T+TqNfAlxOBf0MJqj6IoMMPWJn6+okbL8Orxj2mJgJIrJcTJ6wz/C8oLMY70LxnpirUnqZTEavi0EJTWnI/WoTHXB9VM7XlomYpdWfGD5f2KlOlF7oO8HvAhOjQLz6i7vceQ60Ow+FPJ0ruAdcv+F1LZhANRj6l/BEt/q2+3kBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207912; c=relaxed/simple;
	bh=CQJlq19xgno9ZREqvne/rmJu4VMmQ1RXYcxLzC+NAvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDC97FOuqY3p8ItTID02fUw89Qz6NBklNzwjML2CKAmv/x1dk7cS07AavTztCe3WDdkoGaQaro5D2z0r79kc7JUORYJYKM0ZjPKNeSc2SirsuhyYCql6bqInGBdE1IqYmOWTkOsUmnwN97S8fGOAqqtZimJrwiHmiOTiXE698m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=af2sNm3S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZrTlDOgaHtU2Cvo3h146YTXzfLIkzwilSNfOHgvmKs=;
	b=af2sNm3SPJDVWjC7WOyR4w+zvf1ZYH5limds8xOBS7PNmmVmlM4Bb0PMNBsPMgA6x57FvC
	qyLLf+QSXyMT4bxrA1+bSJffGAXPjxaRWIknevq/+7+Zp5x1YjgcAZ7+z2qnp7NvOtsFcZ
	NM3QhISS5nAvFPwlSwzf8PXNjEWJBC8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-oHcglnsMMFCVMOCaN0H1Ag-1; Tue, 26 Aug 2025 07:31:48 -0400
X-MC-Unique: oHcglnsMMFCVMOCaN0H1Ag-1
X-Mimecast-MFC-AGG-ID: oHcglnsMMFCVMOCaN0H1Ag_1756207908
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9a65c355so88724776d6.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207908; x=1756812708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZrTlDOgaHtU2Cvo3h146YTXzfLIkzwilSNfOHgvmKs=;
        b=kI2rn+1YCE2+0jdPvVsroV9v429IWDfYoQJi1Jg5VRFN1mGvUMzD1m/2LqM5SUYJTX
         GH7NqPGz0esB3aCvqllzom6TB05oZObI91Ou/EdEnGlESZuTxw3KSPpTcWM84Ur4j8jE
         AkxueRLLVvqYb9X2MjAcc1bn7wr+eO8ZD6scugdoeDdQKt2/nVQvD3Vzigzce8mO7uZ3
         NFA/GBCC1lN6w5DrepgzYSAShf5IkVB90EE14HTV3yzVWFBVCHn8dYJ9COhYzpXq19LD
         G7fGr65D5Nzco2aGRNcb8XWS6j1Kk3qNRD0ryu45qwb9azQreaj9jJDopE//+NAH87Hz
         HzLg==
X-Forwarded-Encrypted: i=1; AJvYcCVbZOJmDsCGR25cvLCT7Nc6FRv/SPekMQ4xntb36i5kdWq7rF+7RZqffneXjASMB0bz+I4ivto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2sgiJDmaqiyJO5pMRjlFfIHf9e4zy4dwKNfVQWxHmaIWST9AW
	OxP+66HcWMjDqSn4A42hPQUwk3Egr9AP8GqI33Zr9FeUgwvjc6OUe0zTv+gWBl/69LKdfnnL3Jo
	3p3xzYMDCT5Z44XEDfCGmRyjYFoYEUY9J+1Gugcr0DZkwGLLllejOR6+k/A==
X-Gm-Gg: ASbGnctY+sf51lTxqY6XuUkCvbSvr6J9BsZ89WG7Wmmj9GymagCfk4lMsfjfmkbHvO2
	4T7kJZQNACytdLW6Cv0L6L9P3Wmd4SypATTCm7KvfYwD2mPPmRTl9ERBYTg6HDgm5rBN/QML/VT
	FHepIlg2LJuI3HGymiXJQ2XkdOOIZ8uIBV3agLGbJVRtKeqFtfC5IZCSyOl+WVdOx0FLZcusDwZ
	aEzU2mZI+gV/AqERLtxdihWD57If6ys6Zj2MA1MQoq/couwCRjGD75qRtmZn4aW7HOHExhFw3dC
	q7eRAX7G+2ZIW2itS8cKYYYGvgYIrxipm8KEPA+M0qLAqVP5VaoIYgc7LusuIkbvva6eiwpoy5x
	IQFY2ZzBArbU=
X-Received: by 2002:a05:6214:19eb:b0:70d:ce5c:a57f with SMTP id 6a1803df08f44-70dd59c021amr10171616d6.11.1756207907370;
        Tue, 26 Aug 2025 04:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlBSCTHmveXT64plMow1wIpZpukatASS2aDxW56wm1rsEm/K8j7dm/g7dCCWmuj3VAJ5014w==
X-Received: by 2002:a05:6214:19eb:b0:70d:ce5c:a57f with SMTP id 6a1803df08f44-70dd59c021amr10171206d6.11.1756207906753;
        Tue, 26 Aug 2025 04:31:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dca06bae9sm19716656d6.28.2025.08.26.04.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:31:45 -0700 (PDT)
Message-ID: <7d7516a6-07b7-4882-9da2-2c192ef43039@redhat.com>
Date: Tue, 26 Aug 2025 13:31:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 09/15] net: homa: create homa_rpc.h and
 homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-10-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-10-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * homa_rpc_reap() - Invoked to release resources associated with dead
> + * RPCs for a given socket.
> + * @hsk:      Homa socket that may contain dead RPCs. Must not be locked by the
> + *            caller; this function will lock and release.
> + * @reap_all: False means do a small chunk of work; there may still be
> + *            unreaped RPCs on return. True means reap all dead RPCs for
> + *            hsk.  Will busy-wait if reaping has been disabled for some RPCs.
> + *
> + * Return: A return value of 0 means that we ran out of work to do; calling
> + *         again will do no work (there could be unreaped RPCs, but if so,
> + *         they cannot currently be reaped).  A value greater than zero means
> + *         there is still more reaping work to be done.
> + */
> +int homa_rpc_reap(struct homa_sock *hsk, bool reap_all)
> +{
> +	/* RPC Reaping Strategy:
> +	 *
> +	 * (Note: there are references to this comment elsewhere in the
> +	 * Homa code)
> +	 *
> +	 * Most of the cost of reaping comes from freeing sk_buffs; this can be
> +	 * quite expensive for RPCs with long messages.
> +	 *
> +	 * The natural time to reap is when homa_rpc_end is invoked to
> +	 * terminate an RPC, but this doesn't work for two reasons. First,
> +	 * there may be outstanding references to the RPC; it cannot be reaped
> +	 * until all of those references have been released. Second, reaping
> +	 * is potentially expensive and RPC termination could occur in
> +	 * homa_softirq when there are short messages waiting to be processed.
> +	 * Taking time to reap a long RPC could result in significant delays
> +	 * for subsequent short RPCs.
> +	 *
> +	 * Thus Homa doesn't reap immediately in homa_rpc_end. Instead, dead
> +	 * RPCs are queued up and reaping occurs in this function, which is
> +	 * invoked later when it is less likely to impact latency. The
> +	 * challenge is to do this so that (a) we don't allow large numbers of
> +	 * dead RPCs to accumulate and (b) we minimize the impact of reaping
> +	 * on latency.
> +	 *
> +	 * The primary place where homa_rpc_reap is invoked is when threads
> +	 * are waiting for incoming messages. The thread has nothing else to
> +	 * do (it may even be polling for input), so reaping can be performed
> +	 * with no latency impact on the application.  However, if a machine
> +	 * is overloaded then it may never wait, so this mechanism isn't always
> +	 * sufficient.
> +	 *
> +	 * Homa now reaps in two other places, if reaping while waiting for
> +	 * messages isn't adequate:
> +	 * 1. If too may dead skbs accumulate, then homa_timer will call
> +	 *    homa_rpc_reap.
> +	 * 2. If this timer thread cannot keep up with all the reaping to be
> +	 *    done then as a last resort homa_dispatch_pkts will reap in small
> +	 *    increments (a few sk_buffs or RPCs) for every incoming batch
> +	 *    of packets . This is undesirable because it will impact Homa's
> +	 *    performance.
> +	 *
> +	 * During the introduction of homa_pools for managing input
> +	 * buffers, freeing of packets for incoming messages was moved to
> +	 * homa_copy_to_user under the assumption that this code wouldn't be
> +	 * on the critical path. However, there is evidence that with
> +	 * fast networks (e.g. 100 Gbps) copying to user space is the
> +	 * bottleneck for incoming messages, and packet freeing takes about
> +	 * 20-25% of the total time in homa_copy_to_user. So, it may eventually
> +	 * be desirable to remove packet freeing out of homa_copy_to_user.

See skb_attempt_defer_free()

> +	 */
> +#define BATCH_MAX 20
> +	struct homa_rpc *rpcs[BATCH_MAX];
> +	struct sk_buff *skbs[BATCH_MAX];

A lot of bytes on the stack, and a quite large batch. You should probaly
decrease it.

Also it still feel suspect the need for just another tx free strategy on
top of the several existing caches.

> +	int num_skbs, num_rpcs;
> +	struct homa_rpc *rpc;
> +	struct homa_rpc *tmp;
> +	int i, batch_size;
> +	int skbs_to_reap;
> +	int result = 0;
> +	int rx_frees;
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
> +		homa_sock_lock(hsk);
> +		if (atomic_read(&hsk->protect_count)) {
> +			homa_sock_unlock(hsk);
> +			if (reap_all)
> +				continue;
> +			return 0;
> +		}
> +
> +		/* Collect buffers and freeable RPCs. */
> +		list_for_each_entry_safe(rpc, tmp, &hsk->dead_rpcs,
> +					 dead_links) {
> +			int refs;
> +
> +			/* Make sure that all outstanding uses of the RPC have
> +			 * completed. We can only be sure if the reference
> +			 * count is zero when we're holding the lock. Note:
> +			 * it isn't safe to block while locking the RPC here,
> +			 * since we hold the socket lock.
> +			 */
> +			if (homa_rpc_try_lock(rpc)) {
> +				refs = atomic_read(&rpc->refs);
> +				homa_rpc_unlock(rpc);
> +			} else {
> +				refs = 1;
> +			}
> +			if (refs != 0)
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
> +			if (rpc->msgin.length >= 0 &&
> +			    !skb_queue_empty_lockless(&rpc->msgin.packets)) {
> +				rx_frees += skb_queue_len(&rpc->msgin.packets);
> +				__skb_queue_purge(&rpc->msgin.packets);
> +			}
> +
> +			/* If we get here, it means all packets have been
> +			 *  removed from the RPC.
> +			 */
> +			rpcs[num_rpcs] = rpc;
> +			num_rpcs++;
> +			list_del(&rpc->dead_links);
> +			WARN_ON(refcount_sub_and_test(rpc->msgout.skb_memory,
> +						      &hsk->sock.sk_wmem_alloc));
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
> +			if (rpc->peer) {
> +				homa_peer_release(rpc->peer);
> +				rpc->peer = NULL;
> +			}
> +			rpc->state = 0;
> +			kfree(rpc);
> +		}
> +		homa_sock_wakeup_wmem(hsk);

Here num_rpcs can be zero, and you can have spurius wake-ups

> +/**
> + * homa_rpc_hold() - Increment the reference count on an RPC, which will
> + * prevent it from being freed until homa_rpc_put() is called. References
> + * are taken in two situations:
> + * 1. An RPC is going to be manipulated by a collection of functions. In
> + *    this case the top-most function that identifies the RPC takes the
> + *    reference; any function that receives an RPC as an argument can
> + *    assume that a reference has been taken on the RPC by some higher
> + *    function on the call stack.
> + * 2. A pointer to an RPC is stored in an object for use later, such as
> + *    an interest. A reference must be held as long as the pointer remains
> + *    accessible in the object.
> + * @rpc:      RPC on which to take a reference.
> + */
> +static inline void homa_rpc_hold(struct homa_rpc *rpc)
> +{
> +	atomic_inc(&rpc->refs);

`refs` should be a reference_t, since is uses as such.

/P


