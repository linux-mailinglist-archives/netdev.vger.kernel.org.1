Return-Path: <netdev+bounces-257662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k617J2J4hmlWNwQAu9opvQ
	(envelope-from <netdev+bounces-257662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 00:25:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26667104220
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 00:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69741301397B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C692FFDDC;
	Fri,  6 Feb 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zta5ai80"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D041A9F82
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420317; cv=none; b=gf1Ti37NO9N+iy2OabONqCnWepyKDbLkUV7sePwdzJcTQBNoAcT7z9ruexTEk4kSZLw58ZOlTzlw7nW0i3+sE6SQDOoVSfB1Yo7UXUyE6UkK0ofpUdwOesSZ4C9RJTWj4UG1mRVGClkGOeqsuhA7/WPwrVHYm9X2glvYIduLfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420317; c=relaxed/simple;
	bh=oLKYSJ2oOaZgh9XG4peYTfHwxJmGKtIzFjjOk4fTcYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFz+LHsTU12cqMNDNy2SSRGVVurJ7Ws8Tk0MkFWfOz7O4X2VwLa16wgzmIjSrZ3jE/l7SIXc090bRQTV3xDH9Iummu7gbRQ7JxENpNMfyye8uAGPS4a2s9pqWwJKHMlI0RqKpV8M/VU4w8DkMznCYv8QY2iWakGoDu/DsDoGqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zta5ai80; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b51ca47f-46e2-457e-a152-2f7fbdeee1e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770420314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mql9Wf+rKSETAXdAbbRRwRbZwWvQI+TtWOfK6+wz2s=;
	b=Zta5ai80eZTdBqO+UWUWnmQBH1ScN/wlAMxXQcWHFbjPWiQ9etpCU+wmeJLDwF7KbYUnoZ
	IthBCo2stQmsYBkc6jJZHGynIX0rlUvAbP/duJmrLGcD1BoPrpKFNRRo5M6OIPQzCv8drE
	wtAlGTQyFOv/qLP7NMgHiikVuF6eXaM=
Date: Fri, 6 Feb 2026 15:25:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 10/17] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260205222916.1788211-1-ameryhung@gmail.com>
 <20260205222916.1788211-11-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260205222916.1788211-11-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257662-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 26667104220
X-Rspamd-Action: no action

On 2/5/26 2:29 PM, Amery Hung wrote:
> +/*
> + * Unlink an selem from map and local storage with lockless fallback if callers
> + * are racing or rqspinlock returns error. It should only be called by
> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> + */
> +static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
> +				    struct bpf_local_storage_map_bucket *b)
> +{
> +	bool in_map_free = !!b, free_storage = false;
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map *smap;
> +	unsigned long flags;
> +	int err, unlink = 0;
> +
> +	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
> +	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
> +
> +	if (smap) {
> +		b = b ? : select_bucket(smap, local_storage);
> +		err = raw_res_spin_lock_irqsave(&b->lock, flags);
> +		if (!err) {
> +			/*
> +			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
> +			 * exactly once for an selem. Safe to free special fields immediately
> +			 * as no BPF program should be referencing the selem.
> +			 */
> +			if (likely(selem_linked_to_map(selem))) {
> +				hlist_del_init_rcu(&selem->map_node);
> +				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> +				unlink++;
> +			}
> +			raw_res_spin_unlock_irqrestore(&b->lock, flags);
> +		}
> +		/*
> +		 * Highly unlikely scenario: resource leak
> +		 *
> +		 * When map_free(selem1), destroy(selem1) and destroy(selem2) are racing
> +		 * and both selem belong to the same bucket, if destroy(selem2) acquired
> +		 * b->lock and block for too long, neither map_free(selem1) and
> +		 * destroy(selem1) will be able to free the special field associated
> +		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
> +		 */
> +		WARN_ON_ONCE(err && in_map_free);
> +		if (!err || in_map_free)
> +			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> +	}
> +
> +	if (local_storage) {
> +		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> +		if (!err) {
> +			if (likely(selem_linked_to_storage(selem))) {
> +				free_storage = hlist_is_singular_node(&selem->snode,
> +								      &local_storage->list);
> +				 /*
> +				  * Okay to skip clearing owner_storage and storage->owner in
> +				  * destroy() since the owner is going away. No user or bpf
> +				  * programs should be able to reference it.
> +				  */
> +				if (smap && in_map_free)
> +					bpf_selem_unlink_storage_nolock_misc(
> +						selem, smap, local_storage,
> +						free_storage, true);
> +				hlist_del_init_rcu(&selem->snode);
> +				unlink++;
> +			}
> +			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
> +		}
> +		if (!err || !in_map_free)
> +			RCU_INIT_POINTER(selem->local_storage, NULL);
> +	}
> +
> +	if (unlink != 2)
> +		atomic_or(in_map_free ? SELEM_MAP_UNLINKED : SELEM_STORAGE_UNLINKED, &selem->state);
> +
> +	/*
> +	 * Normally, an selem can be unlinked under local_storage->lock and b->lock, and
> +	 * then freed after an RCU grace period. However, if destroy() and map_free() are
> +	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
> +	 * the selem only after both map_free() and destroy() see the selem.
> +	 */
> +	if (unlink == 2 ||
> +	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
> +		bpf_selem_free(selem, true);
> +
> +	if (free_storage)
> +		bpf_local_storage_free(local_storage, true);

I think there is a chance that selem->state reached SELEM_UNLINKED but 
free_storage is false, and then local_storage is leaked.

afaik, it can happen when destroy() cannot hold its own 
local_storage->lock, but it should be very unlikely. There is a similar 
WARN_ON_ONCE in this function. If addressing this unlikely case is not 
worth the complexity, maybe it deserves a WARN_ON_ONCE here also. This 
can be followed up.

Thanks for working on this. It is a huge effort. The set is applied.

> +}


