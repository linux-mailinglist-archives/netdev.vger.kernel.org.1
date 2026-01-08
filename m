Return-Path: <netdev+bounces-248265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EDBD06253
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C7733010049
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FA330324;
	Thu,  8 Jan 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fevDRRIs"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231D272E6D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904852; cv=none; b=oYVYbuh7KJ5A7FoGN5S8ghKbLVvYJwKjRQVwh9Fzu12ZRoOdT1smzqCUU/TdXdg0Omee1KWkvF3zqYca2DLaArPsblUPmD76EbEg8wzbtu6SxqbQycsutkE3AkxwfI9+FnlLkrUQuiQTr4jGlxdxb5ga6b/XUSeIVgGjVA3Mdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904852; c=relaxed/simple;
	bh=ZC+GaLOedqG+vnnsl+BrV19OUtejsr+nLom7bNc9P6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6Ejz1lr4GgLtYfnBu4xocUd5f+ntR9bZMQLPcV+dR+arQfEUS+OzkPAiG6WR6qvrVCeWHfOIRXbs1B+InwAE/6wb2OhzWov6yBnBAk127UD+t4OYnOvVXK334ZLUsGDgs0FeKSV7P2RrXnXG67HLo1j4Y4ZYoIL8yZI7eAzdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fevDRRIs; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b801c37-d9e8-48f8-a0bc-4acd03a2acd6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767904839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXeimtVMK2Ohvz2xSObLh7cvohzsH69iBC6/85r1n6s=;
	b=fevDRRIs1vrnY5tcRaEBV6kOJhxQn058haNxcIXLLagfkVwdyYPLYu9Bl9gquIrd6oYKR6
	ubH6JN9nURZHLKtvKVMSJ9SOab/etUnQK3gw4WakkayZHFCMaDFfkNv7NU0I5DQX4SZqmP
	7Dq9hWBwSw+VZDMPtBE3YxTsqXu6Stc=
Date: Thu, 8 Jan 2026 12:40:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to
 failable
To: ameryhung@gmail.com
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, kpsingh@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20251218175628.1460321-2-ameryhung@gmail.com>
 <1a31d5b805f81b28ea95cdfdd57b8e2fb88ab29bfbbc034b4443978b4dddb5c6@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1a31d5b805f81b28ea95cdfdd57b8e2fb88ab29bfbbc034b4443978b4dddb5c6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/18/25 10:27 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index e2fe6c32822b..4e3f227fd634 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
> 
> [ ... ]
> 
>> @@ -488,9 +516,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>   {
>>   	struct bpf_local_storage_data *old_sdata = NULL;
>>   	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
>> +	struct bpf_local_storage_map_bucket *b, *old_b = NULL;
>> +	unsigned long flags, b_flags, old_b_flags;
>>   	struct bpf_local_storage *local_storage;
>>   	HLIST_HEAD(old_selem_free_list);
>> -	unsigned long flags;
>>   	int err;
> 
> [ ... ]
> 
>> @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>   		goto unlock;
>>   	}
>>
>> +	b = select_bucket(smap, selem);
>> +
>> +	if (old_sdata) {
>> +		old_b = select_bucket(smap, SELEM(old_sdata));
>> +		old_b = old_b == b ? NULL : old_b;
>> +	}
>> +
>> +	raw_spin_lock_irqsave(&b->lock, b_flags);
>> +
>> +	if (old_b)
>> +		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Could this introduce an ABBA deadlock between two bucket locks? If two
> threads concurrently update storage on the same map with different owners,
> their new and old selems could hash to different buckets with reversed
> order:
> 
>    Thread 1: new_selem -> bucket_A, old_selem -> bucket_B
>              acquires b->lock (A), then waits for old_b->lock (B)
> 
>    Thread 2: new_selem -> bucket_B, old_selem -> bucket_A
>              acquires b->lock (B), then waits for old_b->lock (A)
> 
> Since the locks are regular raw_spinlocks (not rqspinlocks yet), they
> will block indefinitely in this scenario.
> 
> Note: I see that commit 615477732ee8 ("bpf: Change local_storage->lock
> and b->lock to rqspinlock") later in this series changes to rqspinlock
> which has deadlock detection and can return -EDEADLK instead of blocking.
> However, in the current commit the locks are still raw_spinlocks.

I just catch up on this ai-review, so I made a similar comment on this 
raw_spinlock in another reply instead of here. imo, we should still 
avoid this even the rqspinlock is used in the later patch.


