Return-Path: <netdev+bounces-211436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA291B189FE
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C9FAA60F6
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884354262;
	Sat,  2 Aug 2025 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/MT3hSy"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD37225D6
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754096294; cv=none; b=hA4riLz1OBVjt3re7N5PolL0FVJ8VtfMbFHY0svAKK0RiYMxcup8aOcBsJGwU8G5k5UxOVJZA7H7ew4ON5DvF4niNshFZoSeZBTx6obw6vrIbO3YqV/oosCW93dt9wf07e0NG+l6ECqsd0MCC9Kvge1BY3U16RJOb9SzPQ1PxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754096294; c=relaxed/simple;
	bh=pSClDl8gMrb+z/iOjmTb4SdYjgpHPZ3SkrELa4PrHDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxoLcHqlj55nH5knaR+ojaJqba1WO68AhEgTT/UFXncMD+HVgUjXrSBJXFOUWUjHHHgPqYpco0VCYm/iMPJ1w8I/ifV9YtZtaLJJBQWG7VAEamKUpoVxX5JCuQE7rn+zxVc47vjzVLlT6TB3S52Dsz4JRmkAyrpjTgMh9kEwASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/MT3hSy; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e21c788-5187-4fee-baec-22b8e80be383@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754096290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agr9pEQlcrXuRcRC5LeRoq4JlJKkOSpXMHrBu5wJnLQ=;
	b=E/MT3hSyyzSZrT/6VXAplchf7UtnxZsm6YaNPBUb7xLOKnbooEpsQpPfy92EdP2IEl0D8w
	nYvrm9kd4A82Kk/AmQLkSTRDo2bba2SPOhanR+ZbfY3y7gnP4/So5GvGahOFEu0gbzPu5R
	QcVwjkeD/m1dAPL3/tIWMz4FVbrmlpQ=
Date: Fri, 1 Aug 2025 17:58:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Open code
 bpf_selem_unlink_storage in bpf_selem_unlink
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, kpsingh@kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com
References: <20250729182550.185356-1-ameryhung@gmail.com>
 <20250729182550.185356-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250729182550.185356-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 11:25 AM, Amery Hung wrote:
>   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>   {
> +	struct bpf_local_storage_map *storage_smap;
> +	struct bpf_local_storage *local_storage = NULL;
> +	bool bpf_ma, free_local_storage = false;
> +	HLIST_HEAD(selem_free_list);
>   	struct bpf_local_storage_map_bucket *b;
> -	struct bpf_local_storage_map *smap;
> -	unsigned long flags;
> +	struct bpf_local_storage_map *smap = NULL;
> +	unsigned long flags, b_flags;
>   
>   	if (likely(selem_linked_to_map_lockless(selem))) {

Can we simplify the bpf_selem_unlink() function by skipping this map_lockless 
check,

>   		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
>   		b = select_bucket(smap, selem);
> -		raw_spin_lock_irqsave(&b->lock, flags);
> +	}
>   
> -		/* Always unlink from map before unlinking from local_storage
> -		 * because selem will be freed after successfully unlinked from
> -		 * the local_storage.
> -		 */
> -		bpf_selem_unlink_map_nolock(selem);
> -		raw_spin_unlock_irqrestore(&b->lock, flags);
> +	if (likely(selem_linked_to_storage_lockless(selem))) {

only depends on this and then proceed to take the lock_storage->lock. Then 
recheck selem_linked_to_storage(selem), bpf_selem_unlink_map(selem) first, and 
then bpf_selem_unlink_storage_nolock(selem) last.

Then bpf_selem_unlink_map can use selem->local_storage->owner to select_bucket().

> +		local_storage = rcu_dereference_check(selem->local_storage,
> +						      bpf_rcu_lock_held());
> +		storage_smap = rcu_dereference_check(local_storage->smap,
> +						     bpf_rcu_lock_held());
> +		bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
>   	}
>   
> -	bpf_selem_unlink_storage(selem, reuse_now);
> +	if (local_storage)
> +		raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	if (smap)
> +		raw_spin_lock_irqsave(&b->lock, b_flags);
> +
> +	/* Always unlink from map before unlinking from local_storage
> +	 * because selem will be freed after successfully unlinked from
> +	 * the local_storage.
> +	 */
> +	if (smap)
> +		bpf_selem_unlink_map_nolock(selem);
> +	if (local_storage && likely(selem_linked_to_storage(selem)))
> +		free_local_storage = bpf_selem_unlink_storage_nolock(
> +			local_storage, selem, true, &selem_free_list);
> +
> +	if (smap)
> +		raw_spin_unlock_irqrestore(&b->lock, b_flags);
> +	if (local_storage)
> +		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +
> +	bpf_selem_free_list(&selem_free_list, reuse_now);
> +
> +	if (free_local_storage)
> +		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
>   }
>   
>   void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,


