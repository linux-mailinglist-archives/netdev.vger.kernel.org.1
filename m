Return-Path: <netdev+bounces-50088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60C7F491D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161CB28163C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741A8466;
	Wed, 22 Nov 2023 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgLQEFs6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70F4E626
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9C2C433CA;
	Wed, 22 Nov 2023 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700663991;
	bh=hPeEc23VOK9pYSjwYJJrqGAMdXnLzHmjPsaPWQwz3fM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rgLQEFs6poeiVaFU8Au3c/0aU8bz8YK7Qlp5x1ArqE4Fz6sx01L6TySF78QOLr6N7
	 lnIst2ArIyecdZLvZfR2drDsBsOCFdcRyLI2Aw7T5ZUAq+sLpowb+tsVQIisHqhpTB
	 CX5pvhPp4gYUJNclm9pdWppJ96sL1jJwgL33qm92WNYLzmTgDDF/u4VFI/dQqPa9Al
	 zmKMc5i6PehEhiXTapQUW8owQq+E3C2dUu0OuzF/TDYpOKzahPALVua7YTRIw5ytTp
	 R4jZWQzizEp2HH1+tvgCraWux0yBwLLJqSVWB7Ref9PXJFOXH3pT2gUH1XlubX0eLo
	 vi1gm4T04HKbg==
Message-ID: <27b172a5-5161-4fe2-90b1-83b83ef3b073@kernel.org>
Date: Wed, 22 Nov 2023 15:39:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/13] net: page_pool: implement GET in the
 netlink API
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-8-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Expose the very basic page pool information via netlink.
> 
> Example using ynl-py for a system with 9 queues:
> 
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>             --dump page-pool-get
> [{'id': 19, 'ifindex': 2, 'napi-id': 147},
>   {'id': 18, 'ifindex': 2, 'napi-id': 146},
>   {'id': 17, 'ifindex': 2, 'napi-id': 145},
>   {'id': 16, 'ifindex': 2, 'napi-id': 144},
>   {'id': 15, 'ifindex': 2, 'napi-id': 143},
>   {'id': 14, 'ifindex': 2, 'napi-id': 142},
>   {'id': 13, 'ifindex': 2, 'napi-id': 141},
>   {'id': 12, 'ifindex': 2, 'napi-id': 140},
>   {'id': 11, 'ifindex': 2, 'napi-id': 139},
>   {'id': 10, 'ifindex': 2, 'napi-id': 138}]
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   include/uapi/linux/netdev.h |  10 +++
>   net/core/netdev-genl-gen.c  |  27 ++++++++
>   net/core/netdev-genl-gen.h  |   3 +
>   net/core/page_pool_user.c   | 127 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 167 insertions(+)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


Can we still somehow list "detached" page_pool's with ifindex==1 
(LOOPBACK_IFINDEX) ?

page_pool_unreg_netdev() does pool->slow.netdev = lo;


 > [...]
 > +page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 > +		  const struct genl_info *info)
 > +{
 > +	void *hdr;
 > +
 > +	hdr = genlmsg_iput(rsp, info);
 > +	if (!hdr)
 > +		return -EMSGSIZE;
 > +
 > +	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id))
 > +		goto err_cancel;
 > +
 > +	if (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
 > +	    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
 > +			pool->slow.netdev->ifindex))
 > +		goto err_cancel;
 > +	if (pool->user.napi_id &&
 > +	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi_id))
 > +		goto err_cancel;
 > +
 > +	genlmsg_end(rsp, hdr);
 > +
 > +	return 0;
 > +err_cancel:
 > +	genlmsg_cancel(rsp, hdr);
 > +	return -EMSGSIZE;
 > +}

