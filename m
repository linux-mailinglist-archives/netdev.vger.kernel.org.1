Return-Path: <netdev+bounces-211659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AAB1AFFC
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0875617E7DB
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D52472B6;
	Tue,  5 Aug 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhndj3yG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95A24502D
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380989; cv=none; b=juN2u7JeghNZfhc19rOdJEP9476KdDj7A1MxQsQDrXGHzt72M1HSZeZ/Fg946IOB9175wmbamtb6aneTJZqrVjA7S7485CxFMjd1MgnTiem4yWVfAv57FkpATCY+AbiGHjdoD+Gcpg5o+ny2rmuV9LzHvkDCcksTz4zPkDZYmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380989; c=relaxed/simple;
	bh=TOjAK822mjrInW/ht6fi1JFv+F59YKxNAmcyuVc+KlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRSfT+4P5GmG9PIl2UOzJYWV+auDCBrQ6RKRNC+VkH/Ut4YlrxJALFNaCmoj7UVkbRiBhV6wOc+ZAKVWq039TzsYdOf66wLpxLI4IGTv06S6b/PMYoPRsNycr1g8QB+BA4C3bb9CbiFJdHTNIVXDV/AxFn2U3Y8tXKzAQXFBtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhndj3yG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42EC4CEF4;
	Tue,  5 Aug 2025 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754380988;
	bh=TOjAK822mjrInW/ht6fi1JFv+F59YKxNAmcyuVc+KlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yhndj3yGvuEeMt+hKYc/F17NEMMgzcwDg7xRBjG310onYJQqTrSM93lQYIT1M3Mol
	 QjZMT+6S7wuD+elnTsi2TU0vEbw3RdNsRNQh3WErgb/VWXgrdb5vZP4ei8r7y05JfQ
	 fVdp4+0AR8sOZ4MLx+QtpzN0uUwlxsQyZk0aSp2ehtO57Z6Umw2m/NtN32Go6zigW/
	 LhsFq1zlUyzIkw+Ft98YNWU6+oF5Tnu5sn+7yGCIrpl+bA7GQ4wBYFnarOlFHRkuaq
	 claKzQcSAwfc8tAA+uhyFw4+KQKTUWs9MsKbt1NtxMPcO+ntURfErSzOurTiL4BQBJ
	 eW/jpUFd+7WsA==
Message-ID: <76d3fe0c-b031-4c8f-91c0-386b169384fb@kernel.org>
Date: Tue, 5 Aug 2025 10:03:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: page_pool: allow enabling recycling late, fix
 false positive warning
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, David Wei <dw@davidwei.uk>,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ilias.apalodimas@linaro.org, almasrymina@google.com, sdf@fomichev.me
References: <20250805003654.2944974-1-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250805003654.2944974-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/08/2025 02.36, Jakub Kicinski wrote:
> Page pool can have pages "directly" (locklessly) recycled to it,
> if the NAPI that owns the page pool is scheduled to run on the same CPU.
> To make this safe we check that the NAPI is disabled while we destroy
> the page pool. In most cases NAPI and page pool lifetimes are tied
> together so this happens naturally.
> 
> The queue API expects the following order of calls:
>   -> mem_alloc
>      alloc new pp
>   -> stop
>      napi_disable
>   -> start
>      napi_enable
>   -> mem_free
>      free old pp
> 
> Here we allocate the page pool in ->mem_alloc and free in ->mem_free.
> But the NAPIs are only stopped between ->stop and ->start. We created
> page_pool_disable_direct_recycling() to safely shut down the recycling
> in ->stop. This way the page_pool_destroy() call in ->mem_free doesn't
> have to worry about recycling any more.
> 
> Unfortunately, the page_pool_disable_direct_recycling() is not enough
> to deal with failures which necessitate freeing the_new_ page pool.
> If we hit a failure in ->mem_alloc or ->stop the new page pool has
> to be freed while the NAPI is active (assuming driver attaches the
> page pool to an existing NAPI instance and doesn't reallocate NAPIs).
> 
> Freeing the new page pool is technically safe because it hasn't been
> used for any packets, yet, so there can be no recycling. But the check
> in napi_assert_will_not_race() has no way of knowing that. We could
> check if page pool is empty but that'd make the check much less likely
> to trigger during development.
> 
> Add page_pool_enable_direct_recycling(), pairing with
> page_pool_disable_direct_recycling(). It will allow us to create the new
> page pools in "disabled" state and only enable recycling when we know
> the reconfig operation will not fail.
> 
> Coincidentally it will also let us re-enable the recycling for the old
> pool, if the reconfig failed:
> 
>   -> mem_alloc (new)
>   -> stop (old)
>      # disables direct recycling for old
>   -> start (new)
>      # fail!!
>   -> start (old)
>      # go back to old pp but direct recycling is lost 🙁
>   -> mem_free (new)
> 
> The new helper is idempotent to make the life easier for drivers,
> which can operate in HDS mode and support zero-copy Rx.
> The driver can call the helper twice whether there are two pools
> or it has multiple references to a single pool.
> 
> Fixes: 40eca00ae605 ("bnxt_en: unlink page pool when stopping Rx queue")
> Tested-by: David Wei<dw@davidwei.uk>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
> v2:
>   - add kdoc
>   - WARN_ON_ONCE -> WARN_ON
> v1:https://lore.kernel.org/20250801173011.2454447-1-kuba@kernel.org

LGTM - thanks for adjusting :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper


