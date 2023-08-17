Return-Path: <netdev+bounces-28373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9F377F34D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028FC1C21334
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A1125D8;
	Thu, 17 Aug 2023 09:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9E11185
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FDC433C7;
	Thu, 17 Aug 2023 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692264691;
	bh=CFzTEX0rQKsmpCZinWBLJkQispvrC/cuM6FI6YryA90=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=F4nFepmGxn3XQHAFKhtEoxKhB9rH8QdeTsEwHOA0bprF/h/4LiNQJUmJ9Jh9zOKPp
	 kTCUuwTNJusaI8nJcq4GvJu2wdkuzUc1fBj03aH+MkaieCRrxYOyGwBQJ1dYZeoZ5X
	 djF9tPPA9AbCnWYRizhCXlcKVB1fEvv8hz1VJVwc4W/mUBb+q/Wao70wG1G4Lby9Ih
	 vxSn/ESVJ8gf/dXMJmf0jQDRtLp5EgwQDkx7nTCkkKrnf+Q08/uHIuF53cpiEO4DQl
	 NrzjujDLWzRG2OM3ESNfuYWblNkpY10JITs4aPa6LiAQ/fcpWQ/pfdt+ud16WYdZ4S
	 wX+TCYvk1bPrQ==
Message-ID: <85d5067b-6515-5a0a-e70d-b40c5d352892@kernel.org>
Date: Thu, 17 Aug 2023 11:31:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org,
 aleksander.lobakin@intel.com, linyunsheng@huawei.com, almasrymina@google.com
Subject: Re: [RFC net-next 01/13] net: page_pool: split the page_pool_params
 into fast and slow
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230816234303.3786178-1-kuba@kernel.org>
 <20230816234303.3786178-2-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230816234303.3786178-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/08/2023 01.42, Jakub Kicinski wrote:
> struct page_pool is rather performance critical and we use
> 16B of the first cache line to store 2 pointers used only
> by test code. Future patches will add more informational
> (non-fast path) attributes.
> 
> It's convenient for the user of the API to not have to worry
> which fields are fast and which are slow path. Use struct
> groups to split the params into the two categories internally.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   include/net/page_pool/types.h | 31 +++++++++++++++++++------------
>   net/core/page_pool.c          |  7 ++++---
>   2 files changed, 23 insertions(+), 15 deletions(-)

With changes in 2/13 where you add a bool to avoid accessing "slow":

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

