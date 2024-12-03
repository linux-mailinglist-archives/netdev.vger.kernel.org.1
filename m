Return-Path: <netdev+bounces-148312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A429E1179
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E715EB230C6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B9137C35;
	Tue,  3 Dec 2024 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2XshAV+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1460364AE;
	Tue,  3 Dec 2024 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194197; cv=none; b=Ic8crv6Yf5f8yCsxina5J6FqQwtZEUAXo12xd+G+YL2oMeO6yer7POUldcFmOZCsPop0mDUn9+iS+OSuvvpIHMFnKrmh6JkIj1/Q4ApWFy6CN6dyIbG4dLfjlGSXSyCTy81TMy8wHUc/45c8P7w+Wllc7Nctt2kN85KcDruSNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194197; c=relaxed/simple;
	bh=eDxFHf9TSCQuFWJ4zfQvibZBSMuzLGPxyfHs4io/gPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThFzAN5QWTjZriV+UeIHIeYrfah5l9SCWLI6/aNwIygOv/elql12wualM+eYjuh9RKOAsMMU+jy3x7jmalZMcKUTJgSx6LXFR0KzuiISr2tTx52P2L4Gya7uTcqLFGCht+CRPpJsbN2bnwaOBhYtiJ1uF2d9iLXUIdr7P2StunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2XshAV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF00EC4CED2;
	Tue,  3 Dec 2024 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733194196;
	bh=eDxFHf9TSCQuFWJ4zfQvibZBSMuzLGPxyfHs4io/gPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2XshAV+t1lakGhQey2wtEnQMWlpwJHzk0MR0ijYcFL1aUP3TgIRWwq687dS2/hcM
	 Qyms5M0ywDTXqVrCddy4gwg6geR1fLK3NtNJvuHt185YKm4ox+trfV/i5FBcQx5ucV
	 vgT/ZgFAKDFlcDn3V/EM7ZpzPLp3AAYZTBzGgQAeTyvMz5b2rStaNeZYZarrPtDICk
	 CqJQCksTiMyc2kNORtqadu6FlZgiNIMhjdVx73H43Ft447SnTs+oCEkB0ulwBwtu6f
	 ZB0/Ofh1ivuOMiSS0oqgdsLSHWvPgXvlwBHrklZkyeThLC/sGYjt4hGh2SIvib7c1z
	 fvxKiFoHUTVNw==
Date: Mon, 2 Dec 2024 18:49:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/3] page_pool: fix timing for checking and
 disabling napi_local
Message-ID: <20241202184954.3a4095e3@kernel.org>
In-Reply-To: <20241120103456.396577-2-linyunsheng@huawei.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
	<20241120103456.396577-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 18:34:53 +0800 Yunsheng Lin wrote:
> page_pool page may be freed from skb_defer_free_flush() in
> softirq context without binding to any specific napi, it
> may cause use-after-free problem due to the below time window,
> as below, CPU1 may still access napi->list_owner after CPU0
> free the napi memory:
> 
>             CPU 0                           CPU1
>       page_pool_destroy()          skb_defer_free_flush()
>              .                               .
>              .                napi = READ_ONCE(pool->p.napi);
>              .                               .
> page_pool_disable_direct_recycling()         .
>    driver free napi memory                   .
>              .                               .
>              .       napi && READ_ONCE(napi->list_owner) == cpuid
>              .                               .
> 
> Use rcu mechanism to avoid the above problem.
> 
> Note, the above was found during code reviewing on how to fix
> the problem in [1].
> 
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Please split it from the rest of the series, it's related but not
really logically connected (dma mappings and NAPI recycling are 
different features of page pool).

> @@ -1126,6 +1133,12 @@ void page_pool_destroy(struct page_pool *pool)
>  	if (!page_pool_release(pool))
>  		return;
>  
> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
> +	 * before returning to driver to free the napi instance.
> +	 */
> +	synchronize_rcu();

I don't think this is in the right place.
Why not inside page_pool_disable_direct_recycling() ?

Hopefully this doesn't cause long stalls during reconfig, normally
NAPIs and page pools are freed together, and NAPI removal implies
synchronize_rcu(). That's why it's not really a problem for majority
of drivers. You should perhaps make a note of this in the commit
message.

