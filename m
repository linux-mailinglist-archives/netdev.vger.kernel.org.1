Return-Path: <netdev+bounces-248578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1097D0BCF3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6D523013158
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79453321BD;
	Fri,  9 Jan 2026 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E41qEvWx"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AB22AE65
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982572; cv=none; b=jTb/FQW/VAV8WLgyQORLhlg3GwSc04g4gxR+PuYp6cjc+gUwdGLQBpucrIj44HdT7Z4tSQN1s58jq4l1K8Xn/i5FFHRHacGShlUJusYBPyEq5IGDH3Z/dfIoAEjw5O9zOkMPMZ/OyEvDgsc8dAtxdRft/jBvG24zes9HSZkLRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982572; c=relaxed/simple;
	bh=ML7xH8bdEeUUQLjoAoECBAy95ypOvkyEbD46iVVfPVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ibw9BiWqpgAGWh8h5fbY9I0furB7vLDKvfitwPU72PRt3YxcsaPV/30L/jROYey4CkryFjmiIxIWWGPDzv3EkLNHq3akoUa0IXkvTe3aig30amglHVJPtfAywZ9ATf0kHa25fHFzuCGfLMVvthttkz3N6D7gPeelEFVvuztLPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E41qEvWx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71c80294-9602-4302-a823-00a0fe7ed7c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767982567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbJmJnSbNyL5FE7DeAV7iny/pYwmAwxYW049CqQZNOg=;
	b=E41qEvWxNQ9SI+HO9X93b+aYH/WnZMukkTwx7iGpKJEC9i+2AzATFlT39LvdMN1P2Rhosg
	Ed952cp2rpLADfaSO0Kz4Wy0IOpVdW/g1div2QCGPCPQMCcDMHCnEcRg2hjYmfPoSYia+x
	x12zvGsiKedK4WWzbHFH9Z6jxSdFTTw=
Date: Fri, 9 Jan 2026 10:16:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 04/16] bpf: Convert bpf_selem_unlink to
 failable
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-5-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251218175628.1460321-5-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 9:56 AM, Amery Hung wrote:
> To prepare changing both bpf_local_storage_map_bucket::lock and
> bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
> failable. It still always succeeds and returns 0 until the change
> happens. No functional change.
> 
> For bpf_local_storage_map_free(), WARN_ON() for now as no real error
> will happen until we switch to rqspinlock.
> 
> __must_check is added to the function declaration locally to make sure
> all callers are accounted for during the conversion.

I don't see __must_check. The same for patch 2.

> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   include/linux/bpf_local_storage.h | 2 +-
>   kernel/bpf/bpf_cgrp_storage.c     | 3 +--
>   kernel/bpf/bpf_inode_storage.c    | 4 +---
>   kernel/bpf/bpf_local_storage.c    | 8 +++++---
>   kernel/bpf/bpf_task_storage.c     | 4 +---
>   net/core/bpf_sk_storage.c         | 4 +---
>   6 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 6cabf5154cf6..a94e12ddd83d 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
>   void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
>   				   struct bpf_local_storage_elem *selem);
>   
> -void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
>   
>   int bpf_selem_link_map(struct bpf_local_storage_map *smap,
>   		       struct bpf_local_storage_elem *selem);
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index 0687a760974a..8fef24fcac68 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
>   	if (!sdata)
>   		return -ENOENT;
>   
> -	bpf_selem_unlink(SELEM(sdata), false);
> -	return 0;
> +	return bpf_selem_unlink(SELEM(sdata), false);
>   }
>   
>   static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index e54cce2b9175..cedc99184dad 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
>   	if (!sdata)
>   		return -ENOENT;
>   
> -	bpf_selem_unlink(SELEM(sdata), false);
> -
> -	return 0;
> +	return bpf_selem_unlink(SELEM(sdata), false);
>   }
>   
>   static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 0e3fa5fbaaf3..fa629a180e9e 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -367,7 +367,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
>   	hlist_add_head_rcu(&selem->map_node, &b->list);
>   }
>   
> -void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>   {
>   	struct bpf_local_storage *local_storage;
>   	bool free_local_storage = false;
> @@ -377,7 +377,7 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>   
>   	if (unlikely(!selem_linked_to_storage_lockless(selem)))
>   		/* selem has already been unlinked from sk */
> -		return;
> +		return 0;
>   
>   	local_storage = rcu_dereference_check(selem->local_storage,
>   					      bpf_rcu_lock_held());
> @@ -402,6 +402,8 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>   
>   	if (free_local_storage)
>   		bpf_local_storage_free(local_storage, reuse_now);
> +
> +	return err;

err is not used in patch 3 and then becomes useful in patch 4. The 
ai-review discovered issue on err also. Squash patch 4 into patch 3. It 
will be easier to read.

>   }
>   
>   void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
> @@ -837,7 +839,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
>   				struct bpf_local_storage_elem, map_node))) {
>   			if (busy_counter)
>   				this_cpu_inc(*busy_counter);
> -			bpf_selem_unlink(selem, true);
> +			WARN_ON(bpf_selem_unlink(selem, true));

nit. I would add __must_check to the needed functions in a single patch 
when everything is ready instead of having an intermediate WARN_ON here 
and then removed it later.


