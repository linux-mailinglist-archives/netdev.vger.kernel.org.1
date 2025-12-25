Return-Path: <netdev+bounces-246048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864ECDD976
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 10:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85893014DB0
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224A279DC3;
	Thu, 25 Dec 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpKMTk6c"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DF23EAB6
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655256; cv=none; b=lh9L1XPxm+jkq9lrzuAf1cYLKodqpEzTWFzhuqo97+NMYnBlxkQy8VSowg2L2bqorF0s/LbH9UNSrhlsUZHdsidNO2XAvKgIKYVBFwtk3yujX5L8b85CId3mHsfQ1vOqSJVGJllzOGuJ/XgTUgErq5m5DVZaa2EDgpf/qArRZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655256; c=relaxed/simple;
	bh=NNUrM2zAGUjWPDCFlGd3GqWRc78KxkS2I3C5XHreo2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ0NmuNf0gNRc/27Rv6FIJlIYeUdJro+Su12RqXIWwV+lqWEVVxQfrcHERGtdYCsEi/KBE7q6/BAbQj/XHiDm96Sw+XtYRQt30P1bSf6oXtIJCDq019T5h0v8IzCdN+yIHr+RBi36J8BoXnq5q0+RWw1qdcsbsfdIcnNkpS39TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpKMTk6c; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a115aeb-7831-46f8-a4ce-03eb8def8d37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766655251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ND3WMcBgJbSd8OXNXZONm5JOUjLXZ1PdOOotqt0l/Zg=;
	b=JpKMTk6cizL4CeJ44bD1TlQS7NUZpijTR3gLQcNqFC0AVcQEvXFVRnY9ZVHRfdqe6i54Vu
	OP4e33K22ZqYxpUbLpYdM7RUDR+RJ567ZK2lUoBcafr7WKg+ECzAKFvldpz58ZQeNT7g8f
	wH3h+MLVR33GZr7mUchYGQL1R9E57gI=
Date: Thu, 25 Dec 2025 09:34:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bnxt_en: Fix potential data corruption with HW
 GRO/LRO
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Srijit Bose <srijit.bose@broadcom.com>,
 Ray Jui <ray.jui@broadcom.com>
References: <20251224191116.3526999-1-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251224191116.3526999-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/24/25 19:11, Michael Chan wrote:
> From: Srijit Bose <srijit.bose@broadcom.com>
> 
> Fix the max number of bits passed to find_first_zero_bit() in
> bnxt_alloc_agg_idx().  We were incorrectly passing the number of
> long words.  find_first_zero_bit() may fail to find a zero bit and
> cause a wrong ID to be used.  If the wrong ID is already in use, this
> can cause data corruption.  Sometimes an error like this can also be
> seen:
> 
> bnxt_en 0000:83:00.0 enp131s0np0: TPA end agg_buf 2 != expected agg_bufs 1
> 
> Fix it by passing the correct number of bits MAX_TPA_P5.  Add a sanity
> BUG_ON() check if find_first_zero_bit() fails.  It should never happen.
> 
> Fixes: ec4d8e7cf024 ("bnxt_en: Add TPA ID mapping logic for 57500 chips.")
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srijit Bose <srijit.bose@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d17d0ea89c36..6704cbbc1b24 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1482,9 +1482,10 @@ static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
>   	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
>   	u16 idx = agg_id & MAX_TPA_P5_MASK;
>   
> -	if (test_bit(idx, map->agg_idx_bmap))
> -		idx = find_first_zero_bit(map->agg_idx_bmap,
> -					  BNXT_AGG_IDX_BMAP_SIZE);
> +	if (test_bit(idx, map->agg_idx_bmap)) {
> +		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
> +		BUG_ON(idx >= MAX_TPA_P5);
> +	}
>   	__set_bit(idx, map->agg_idx_bmap);
>   	map->agg_id_tbl[agg_id] = idx;
>   	return idx;


The change itself is correct, but it would be great to use DECLARE_BITMAP() in
struct bnxt_tpa_idx_map to completely remove BNXT_AGG_IDX_BMAP_SIZE and avoid
such problems in the future.



