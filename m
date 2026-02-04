Return-Path: <netdev+bounces-256581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMifEJDbgmnkcwMAu9opvQ
	(envelope-from <netdev+bounces-256581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98102E20B3
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A5C3060BC9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DBC31AF09;
	Wed,  4 Feb 2026 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F+lpFo8n"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF550306D2A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183565; cv=none; b=II509c55K8kGSkpbeH/wrKbeG1teCPskzSmjCov3pZXwdr6o0LrussTdLvmK/Xe3pGAFYtkVq/3UiRZw/w/e/ZXy9quKDvX9CHyfAuTWgxf+GrMv5CfL3Adz043j84q5VpaB7DB42JUsOKZFT5TIYoElwMszjnRdp6bRk3FwGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183565; c=relaxed/simple;
	bh=Ya1fXJdayG73D0309s1HgJMomX0g3FzRUGmtHwL3LcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=timnPWt8A62Ft5sZJgFLgriI9RiooG3fJCLUxQa00ETIVSOh3S9Tf95me2xmXfeU64hVJSyhv6fOX5voNcVLlv2KcycqYZ0bIMELnp6vFPHISmdxjtcstd3V1FGfB6C5AW7JtXnKazw34Z+MOmDR7f7doPnZ31DDphtBDvITDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F+lpFo8n; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d512e9fd-eb04-4194-ab75-b1d2e775461a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770183552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6FiKVWQiD6+SFmcv0TIELc6uHmdzplm6VKLZ0lrRE0=;
	b=F+lpFo8nWOcqQHiChzaps6VXdDK38sl2BTqR/DNehni/VXeBkd8eTzZPnlu80msKqjk+/S
	TyLsmZKzfR3uxtHh2LMeuJ/OnH9LUeyKQHce0+buMVaECm5eu0XTCctJHKy/DW1EZ3J0Kk
	sphqFwK8HEdVoudb0pGuIQEvJsO/U+g=
Date: Tue, 3 Feb 2026 21:39:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
References: <20260201175050.468601-1-ameryhung@gmail.com>
 <20260201175050.468601-11-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260201175050.468601-11-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98102E20B3
X-Rspamd-Action: no action

On 2/1/26 9:50 AM, Amery Hung wrote:
> +/*
> + * Unlink an selem from map and local storage with lockless fallback if callers
> + * are racing or rqspinlock returns error. It should only be called by
> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> + */
> +static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
> +				    struct bpf_local_storage_map_bucket *b)
> +{
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map *smap;
> +	bool in_map_free = !!b;
> +	unsigned long flags;
> +	int err, unlink = 0;
> +
> +	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
> +	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
> +
> +	/*
> +	 * Prevent being called twice from the same caller on the same selem.
> +	 * map_free() and destroy() each holds a link_cnt on an selem.
> +	 */
> +	if ((!smap && in_map_free) || (!local_storage && !in_map_free))

There is chance that map_free() can see "!smap" in the very first call 
of bpf_selem_unlink_nofail(). For example, the destroy() may grab the 
b->lock and do the hlist_del_init_rcu(&selem->map_node). In the unlikely 
case, the destroy() cannot grab the local_storage->lock, so it does 
atomic_dec_and_test(&selem->link_cnt). If map_free() hits the !smap in 
the very first time, it cannot move on to do 
atomic_dec_and_test(&selem->link_cnt), and the selem will be leaked. It 
is unlikely if we can assume destroy() should be able to hold its own 
local_storage->lock (no bpf prog should be holding it and no ETIMEDOUT).

I think the same goes for the "!local_storage" check calling from destroy().


> +		return;
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
> +			/*
> +			 * Normally, map_free() can call mem_uncharge() if destroy() is
> +			 * not about to return to the owner, which can then go away
> +			 * immediately. Otherwise, the charge of the selem will stay
> +			 * accounted in local_storage->selems_size and uncharged during
> +			 * destroy().
> +			 */
> +			if (likely(selem_linked_to_storage(selem))) {
> +				hlist_del_init_rcu(&selem->snode);
> +				if (smap && in_map_free &&

I think the smap non-null check is not needed.

> +				    refcount_inc_not_zero(&local_storage->owner_refcnt)) {
> +					mem_uncharge(smap, local_storage->owner, smap->elem_size);
> +					local_storage->selems_size -= smap->elem_size;
> +					refcount_dec(&local_storage->owner_refcnt);
> +				}
> +				unlink++;
> +			}
> +			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
> +		}
> +		if (!err || !in_map_free)
> +			RCU_INIT_POINTER(selem->local_storage, NULL);
> +	}
> +
> +	/*
> +	 * Normally, an selem can be unlinked under local_storage->lock and b->lock, and
> +	 * then freed after an RCU grace period. However, if destroy() and map_free() are
> +	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
> +	 * the selem only after both map_free() and destroy() drop their link_cnt.
> +	 */
> +	if (unlink == 2 || atomic_dec_and_test(&selem->link_cnt))
> +		bpf_selem_free(selem, false);

This can be bpf_selem_free(..., true) here.



