Return-Path: <netdev+bounces-216877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067CB35A77
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E6A1889B32
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B62E267D;
	Tue, 26 Aug 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZXtGBJ8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E492FD7DE
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205648; cv=none; b=MZDNLh9IfV4GcL6GhtxlNDoJClbqAYgJWkXxYeetg52OOzK+HmDQc2rJfabUjwk7ZMySb7rB0v2cmWLa9RsiV+Ec/EUWhqhrh/ZXtkdP0FABofmtPqH9ujTt6EJ6jicoCFhpSiN1RVTf/Vv6nTnZmvKDVaBUs7zCE4uhBxN4g+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205648; c=relaxed/simple;
	bh=lp4qUB/iFCiDO2bbcS0i4IsaitqmrQGgBtH+G+JOMso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMHtsy6q+gGdNEqdieMxXosPUO+MyZ46T86t+Pzh4nCVxe1JTKFT+NZDt626cVM+TxPQ4fYzDCDLVnq2ptC0eOOxBX9sQYJ2SYPbqhE4YKOduwdTnmS8jO+P0NLeDP4wAzNOBxf23kS/bRJi+uCbrlQf9SsosXqdnaGlCa+yclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZXtGBJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756205645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmZInkyqroxO61jCOvr1Vj+N6nNqACCevIwWJbuiovk=;
	b=CZXtGBJ8owkbOiccVMteMvm+d4TnafApIlpS1ZXA3+pOyluPxnbGzG2r0jeLABfek+/+19
	r7IIJp9GEsPjm+5k8ZUlAfYXMdRGOuO2RVGZ6b1nM7nyD2B2vIg/kNcmN2O+o7p04PAKlC
	apkJPjlc6PmW6CitcRVbUudZOrTRcoU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-RSk3OVfaMsqjILfKdSITtA-1; Tue, 26 Aug 2025 06:54:03 -0400
X-MC-Unique: RSk3OVfaMsqjILfKdSITtA-1
X-Mimecast-MFC-AGG-ID: RSk3OVfaMsqjILfKdSITtA_1756205643
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f2942a1aa1so372141785a.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 03:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205643; x=1756810443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmZInkyqroxO61jCOvr1Vj+N6nNqACCevIwWJbuiovk=;
        b=sPXCkGFFs5AkeOtjt3SsCzrexEOmyGytI50sXE9dJt2nxE/X4x311J6clH/4MZI8O9
         AvrpRxv0dRhXT04xOukKjRyb24BwpUhytrgezoUQ41NwlwMhZTheHzravsnrDEbZJ30z
         sXmd0QMNcuvMWcKwhplSkAx7sQ6SFpYSfSWmwZoppZpRCDAyHnrXZt8u8A+N7dkkmPbp
         Ssr8ZYgacM5Buv0lzSvFb5EkBGunSo0ueA4v84kegt4lWUj+7/wo93DJC6aE/o71Uqeh
         eXqoArTuJQ6VRvj4P1uwgCrQU8g0JLoQqgDWdsqxB+Fokd42Oacx2w38scqHKvJmsQjW
         acZg==
X-Forwarded-Encrypted: i=1; AJvYcCV+W6I1fZ0Qq6qUfjld1zg9RJ8Pm8XlqZMFoi2yQcJW0aQoAguNLb2KaTkvUXS8R//NaZ03Mnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGj5kjHJNxVnfQvlaKeNQv8fKHMYgyoGofEEHDflv2yVlIC7Q
	wP3viWh04pYwj37+lN7eimx/rvuVF1XG9qC3nynFAu5rSnQBRm+tqQHxakMMud7e6oLzIZBWYII
	0JYEvwRTc1wJGL6xR1OmfDKnmfwdH2RmPH7DzVDCwGIyVa3E5Y3Yg535iOg==
X-Gm-Gg: ASbGncvHbeMGWRJafEONsdIagWKC8phZvDK5g8KKG8TxfIi6lRVxey/PpDkn2LDADnm
	6d78h6bHPtK5yiYA7zhvArpYpYOXr8tInB3E4Xg+Q4LXq2O7xh9axpMOS5ktLXw3zA7bPHvWXYa
	3nOaCXieyRVfFtI3c4wvyeT2mQNl8Ffii6T2R8d20XWw5kFItfnu4ioXKdsq09G4luf1BaBb+5U
	XNzq+T40BlhCJk+G38GFU3JGgmuwMOxgZfoVnrfkNTWQ9nL4cYoH2KOJWlRotpaGwW4SJphPzCN
	ofJpTnOYmv+jyn0F1EI/havhVnnD5zPlOy7t3+sAyasxXdJqF7esBW3btaMox24nI0RZADqHzzL
	XOdZCv9OdQ68=
X-Received: by 2002:a05:620a:19a8:b0:7e8:271:aa81 with SMTP id af79cd13be357-7f58d941cd2mr74802485a.19.1756205643238;
        Tue, 26 Aug 2025 03:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mJd8n3IxmD7p6z1XMuV5erwlZh5IxTZ6t9Ayq0MH6ODZNkoPFoJgQtjU3Byi3QYQ+rpgLw==
X-Received: by 2002:a05:620a:19a8:b0:7e8:271:aa81 with SMTP id af79cd13be357-7f58d941cd2mr74799985a.19.1756205642729;
        Tue, 26 Aug 2025 03:54:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf4178d59sm656023485a.66.2025.08.26.03.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 03:54:01 -0700 (PDT)
Message-ID: <3b432e20-cca3-4163-b7ac-139efe6a8427@redhat.com>
Date: Tue, 26 Aug 2025 12:53:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 08/15] net: homa: create homa_pacer.h and
 homa_pacer.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-9-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-9-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * homa_pacer_alloc() - Allocate and initialize a new pacer object, which
> + * will hold pacer-related information for @homa.
> + * @homa:   Homa transport that the pacer will be associated with.
> + * Return:  A pointer to the new struct pacer, or a negative errno.
> + */
> +struct homa_pacer *homa_pacer_alloc(struct homa *homa)
> +{
> +	struct homa_pacer *pacer;
> +	int err;
> +
> +	pacer = kzalloc(sizeof(*pacer), GFP_KERNEL);
> +	if (!pacer)
> +		return ERR_PTR(-ENOMEM);
> +	pacer->homa = homa;
> +	spin_lock_init(&pacer->mutex);
> +	pacer->fifo_count = 1000;
> +	spin_lock_init(&pacer->throttle_lock);
> +	INIT_LIST_HEAD_RCU(&pacer->throttled_rpcs);
> +	pacer->fifo_fraction = 50;
> +	pacer->max_nic_queue_ns = 5000;
> +	pacer->throttle_min_bytes = 1000;
> +	init_waitqueue_head(&pacer->wait_queue);
> +	pacer->kthread = kthread_run(homa_pacer_main, pacer, "homa_pacer");
> +	if (IS_ERR(pacer->kthread)) {
> +		err = PTR_ERR(pacer->kthread);
> +		pr_err("Homa couldn't create pacer thread: error %d\n", err);
> +		goto error;
> +	}
> +	atomic64_set(&pacer->link_idle_time, homa_clock());
> +
> +	homa_pacer_update_sysctl_deps(pacer);

IMHO this does not fit mergeable status:
- the static init (@25Gbs)
- never updated on link changes
- assumes a single link in the whole system

I think it's better to split the pacer part out of this series, or the
above points should be addressed and it would be difficult fitting a
reasonable series size.

Also a single thread for all the reap RPC looks like a potentially high
contended spot.

> +/**
> + * homa_pacer_xmit() - Transmit packets from  the throttled list until
> + * either (a) the throttled list is empty or (b) the NIC queue has
> + * reached maximum allowable length. Note: this function may be invoked
> + * from either process context or softirq (BH) level. This function is
> + * invoked from multiple places, not just in the pacer thread. The reason
> + * for this is that (as of 10/2019) Linux's scheduling of the pacer thread
> + * is unpredictable: the thread may block for long periods of time (e.g.,
> + * because it is assigned to the same CPU as a busy interrupt handler).
> + * This can result in poor utilization of the network link. So, this method
> + * gets invoked from other places as well, to increase the likelihood that we
> + * keep the link busy. Those other invocations are not guaranteed to happen,
> + * so the pacer thread provides a backstop.
> + * @pacer:    Pacer information for a Homa transport.
> + */
> +void homa_pacer_xmit(struct homa_pacer *pacer)
> +{
> +	struct homa_rpc *rpc;
> +	s64 queue_cycles;
> +
> +	/* Make sure only one instance of this function executes at a time. */
> +	if (!spin_trylock_bh(&pacer->mutex))
> +		return;
> +
> +	while (1) {
> +		queue_cycles = atomic64_read(&pacer->link_idle_time) -
> +					     homa_clock();
> +		if (queue_cycles >= pacer->max_nic_queue_cycles)
> +			break;
> +		if (list_empty(&pacer->throttled_rpcs))
> +			break;
> +
> +		/* Select an RPC to transmit (either SRPT or FIFO) and
> +		 * take a reference on it. Must do this while holding the
> +		 * throttle_lock to prevent the RPC from being reaped. Then
> +		 * release the throttle lock and lock the RPC (can't acquire
> +		 * the RPC lock while holding the throttle lock; see "Homa
> +		 * Locking Strategy" in homa_impl.h).
> +		 */
> +		homa_pacer_throttle_lock(pacer);
> +		pacer->fifo_count -= pacer->fifo_fraction;
> +		if (pacer->fifo_count <= 0) {
> +			struct homa_rpc *cur;
> +			u64 oldest = ~0;
> +
> +			pacer->fifo_count += 1000;
> +			rpc = NULL;
> +			list_for_each_entry(cur, &pacer->throttled_rpcs,
> +					    throttled_links) {
> +				if (cur->msgout.init_time < oldest) {
> +					rpc = cur;
> +					oldest = cur->msgout.init_time;
> +				}
> +			}
> +		} else {
> +			rpc = list_first_entry_or_null(&pacer->throttled_rpcs,
> +						       struct homa_rpc,
> +						       throttled_links);
> +		}
> +		if (!rpc) {
> +			homa_pacer_throttle_unlock(pacer);
> +			break;
> +		}
> +		homa_rpc_hold(rpc);

It's unclear what ensures that 'rpc' is valid at this point.

> +		homa_pacer_throttle_unlock(pacer);
> +		homa_rpc_lock(rpc);
> +		homa_xmit_data(rpc, true);
> +
> +		/* Note: rpc->state could be RPC_DEAD here, but the code
> +		 * below should work anyway.
> +		 */
> +		if (!*rpc->msgout.next_xmit)
> +			/* No more data can be transmitted from this message
> +			 * (right now), so remove it from the throttled list.
> +			 */
> +			homa_pacer_unmanage_rpc(rpc);
> +		homa_rpc_unlock(rpc);
> +		homa_rpc_put(rpc);

All the loop is atomic context, you should likely place a cond_resched()
here - releasing and reaquiring the mutex as needed.

> +/**
> + * struct homa_pacer - Contains information that the pacer users to
> + * manage packet output. There is one instance of this object stored
> + * in each struct homa.
> + */
> +struct homa_pacer {
> +	/** @homa: Transport that this pacer is associated with. */
> +	struct homa *homa;

Should be removed

> +/**
> + * homa_pacer_check() - This method is invoked at various places in Homa to
> + * see if the pacer needs to transmit more packets and, if so, transmit
> + * them. It's needed because the pacer thread may get descheduled by
> + * Linux, result in output stalls.
> + * @pacer:    Pacer information for a Homa transport.
> + */
> +static inline void homa_pacer_check(struct homa_pacer *pacer)
> +{
> +	if (list_empty(&pacer->throttled_rpcs))
> +		return;
> +
> +	/* The ">> 1" in the line below gives homa_pacer_main the first chance
> +	 * to queue new packets; if the NIC queue becomes more than half
> +	 * empty, then we will help out here.
> +	 */
> +	if ((homa_clock() + (pacer->max_nic_queue_cycles >> 1)) <
> +			atomic64_read(&pacer->link_idle_time))
> +		return;
> +	homa_pacer_xmit(pacer);
> +}

apparently not used in this series.

/P


