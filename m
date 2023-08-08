Return-Path: <netdev+bounces-25414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88536773E84
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A32E28105D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485912B9B;
	Tue,  8 Aug 2023 16:31:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265914A8E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB7C433C7;
	Tue,  8 Aug 2023 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691512307;
	bh=i13P5MPqrTGWCc+X/5J6OL6JOdO6y17/4r5Ys53Uur0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUMo/ilNQjbTst5YG3/9ijxPs5mOI9ZLOnEjxhzeCm7KVteaFEsYSUu5F6P5kCu+c
	 cDaMjxIKKwWidt/oceJJBCYnV4cFJKtfctLYSJ4ksPmAW/mb38/qSvKosaEX4A4AjN
	 CJHDCGGD7KwDVjPZfJb+G4cSKBX6ud/7sUKmGVrFJHLfmwsYj9VVWTHu9mNAOWjzdW
	 AKx8NFq+92kLHrAdr4HfDc3o4JkeKHf6cNUluVZhfJcInujueS73luI8vViMDUBWyO
	 mRE2WFQtt7XWsExLES5NjKAfQgypy4Ibl5O1/3olZO1Bx3mrMHCF1On6OrRysXMZRm
	 JHDn+8ZoDXNMw==
Date: Tue, 8 Aug 2023 10:32:50 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
Message-ID: <ZNJuMoe37L02TP20@work>
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808133038.771316-1-gongruiqi@huaweicloud.com>

On Tue, Aug 08, 2023 at 09:30:38PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy
> {watchers,target,next}_offset altogether into offsets[]. Silence the
> warning by wrapping these three up via struct_group().
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> v2: fix HDRTEST error by replacing struct_group() with __struct_group(),
> since it's a uapi header.
> 
>  include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
>  net/bridge/netfilter/ebtables.c                |  3 +--
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
> index a494cf43a755..b0caad82b693 100644
> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
> @@ -182,12 +182,14 @@ struct ebt_entry {
>  	unsigned char sourcemsk[ETH_ALEN];
>  	unsigned char destmac[ETH_ALEN];
>  	unsigned char destmsk[ETH_ALEN];
> -	/* sizeof ebt_entry + matches */
> -	unsigned int watchers_offset;
> -	/* sizeof ebt_entry + matches + watchers */
> -	unsigned int target_offset;
> -	/* sizeof ebt_entry + matches + watchers + target */
> -	unsigned int next_offset;
> +	__struct_group(/* no tag */, offsets, /* no attrs */,
> +		/* sizeof ebt_entry + matches */
> +		unsigned int watchers_offset;
> +		/* sizeof ebt_entry + matches + watchers */
> +		unsigned int target_offset;
> +		/* sizeof ebt_entry + matches + watchers + target */
> +		unsigned int next_offset;
> +	);
>  	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
>  };
>  
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index 757ec46fc45a..5ec66b1ebb64 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
>  		return ret;
>  
>  	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
> -	memcpy(&offsets[1], &entry->watchers_offset,
> -			sizeof(offsets) - sizeof(offsets[0]));
> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets[0]));
							^^^^^^^^^^^^
You now can replace this ____________________________________|
with just `sizeof(entry->offsets)`

With that change you can add my
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thank you
--
Gustavo

>  
>  	if (state->buf_kern_start) {
>  		buf_start = state->buf_kern_start + state->buf_kern_offset;
> -- 
> 2.41.0
> 

