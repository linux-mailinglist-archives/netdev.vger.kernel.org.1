Return-Path: <netdev+bounces-50107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F47F4A38
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F71C20897
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19064EB31;
	Wed, 22 Nov 2023 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnIh+EE0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6514F207
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00195C433C8;
	Wed, 22 Nov 2023 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700666699;
	bh=77QUiZQX/mLMI0vVHGbl8E+fc1JXznj5D2b54v9GfQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HnIh+EE0Bx0WqpeEHbHLmsFRMrQlvUtpuNFk3FT9e4vzhf9lzkiz/LO+vj6XAueZx
	 dTABrepyn2CoEEJYza2AkoxcIJoTt4LF1Me34qRPp2fKJ8qanyXqGWwbBe+3ll2LXk
	 +KLVNNKFVNw5smJQBZgC5yPDJDSD3AwrluXAzD/kvERggSoD/xkr/xX86PIskyRKfg
	 nErfMgvXiiZSDNBzLoO2AAXLY9cL93vOaI35g4R2pYDuQNfiIM49jZdin6eW9xacbW
	 WS2fn2hMtabB7L0voaLOrD+C80ICdSz9hGvTyjb0KrQB7QrKEXK8DYqDRvnfuNk7Uy
	 qbB18UFi/9ktg==
Message-ID: <ee5c3780-2b0e-4db2-97d0-48659686c772@kernel.org>
Date: Wed, 22 Nov 2023 16:24:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/13] net: page_pool: report amount of memory
 held by page pools
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-10-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-10-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Advanced deployments need the ability to check memory use
> of various system components. It makes it possible to make informed
> decisions about memory allocation and to find regressions and leaks.
> 
> Report memory use of page pools. Report both number of references
> and bytes held.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
>   include/uapi/linux/netdev.h             |  2 ++
>   net/core/page_pool.c                    | 13 +++++++++----
>   net/core/page_pool_priv.h               |  2 ++
>   net/core/page_pool_user.c               |  8 ++++++++
>   5 files changed, 34 insertions(+), 4 deletions(-)
> 

I like it, but see comment/suggestion below.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 82fbe81f7a49..85209e19dca9 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -114,6 +114,17 @@ name: netdev
>           checks:
>             min: 1
>             max: u32-max
> +      -
> +        name: inflight
> +        type: uint
> +        doc: |
> +          Number of outstanding references to this page pool (allocated
> +          but yet to be freed pages).

Maybe it is worth explaining in this doc that these inflight references
also cover elements in (ptr) ring (and alloc-cache) ?

In a follow up patchset, we likely also want to expose the PP ring size.
As that could be relevant when assessing inflight number.

--Jesper

> +      -
> +        name: inflight-mem
> +        type: uint
> +        doc: |
> +          Amount of memory held by inflight pages.
>   
>   operations:
>     list:
> @@ -163,6 +174,8 @@ name: netdev
>               - id
>               - ifindex
>               - napi-id
> +            - inflight
> +            - inflight-mem
>         dump:
>           reply: *pp-reply
>         config-cond: page-poo

