Return-Path: <netdev+bounces-50148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD287F4B9F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589A52811C9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F556B99;
	Wed, 22 Nov 2023 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjxSqyI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F156B97
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B4C433C9;
	Wed, 22 Nov 2023 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700668268;
	bh=lRsf4IvEReXaw1/5lM+YkjZL0zQ0itDvEJ8dxQsTJ40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qjxSqyI0tT5Nbw/nibVNJ48D5NGluiiZWh4+qV8alMSjNWBf1Qqpy3Y5bQmyighE8
	 ka8meDSCspHjFTGnIiCc1fp1iNSm5MvM3HawPoacd05QnGCn48HeMA5SmTSTyTBjnq
	 6A59dTFosF2rIUyLKj/8pNtM2ur2+CXFGmEqYh9Tu2clefElKm1DfzNJMMtavx9LNp
	 VlEpLH7srOGoTHYHQAW4NYLUs4Lba7A+CSnFcSxfiQNBcikEjthxdPHm+tUanrMdeT
	 GE0md2BSMv+v0MxOUVi8iBx5D3qKW6Reoh72py2JWoJJFLcAhFaeTtim3oTKMosw/F
	 X+2NC2RD11mNQ==
Message-ID: <fb6b70cd-9f92-4f78-8337-65154188c0ab@kernel.org>
Date: Wed, 22 Nov 2023 16:51:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/13] net: page_pool: expose page pool stats
 via netlink
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-12-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-12-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Dump the stats into netlink. More clever approaches
> like dumping the stats per-CPU for each CPU individually
> to see where the packets get consumed can be implemented
> in the future.
> 
> A trimmed example from a real (but recently booted system):
> 
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>             --dump page-pool-stats-get
> [{'info': {'id': 19, 'ifindex': 2},
>    'alloc-empty': 48,
>    'alloc-fast': 3024,
>    'alloc-refill': 0,
>    'alloc-slow': 48,
>    'alloc-slow-high-order': 0,
>    'alloc-waive': 0,
>    'recycle-cache-full': 0,
>    'recycle-cached': 0,
>    'recycle-released-refcnt': 0,
>    'recycle-ring': 0,
>    'recycle-ring-full': 0},
>   {'info': {'id': 18, 'ifindex': 2},
>    'alloc-empty': 66,
>    'alloc-fast': 11811,
>    'alloc-refill': 35,
>    'alloc-slow': 66,
>    'alloc-slow-high-order': 0,
>    'alloc-waive': 0,
>    'recycle-cache-full': 1145,
>    'recycle-cached': 6541,
>    'recycle-released-refcnt': 0,
>    'recycle-ring': 1275,
>    'recycle-ring-full': 0},
>   {'info': {'id': 17, 'ifindex': 2},
>    'alloc-empty': 73,
>    'alloc-fast': 62099,
>    'alloc-refill': 413,
> ...
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml |  78 ++++++++++++++++++
>   Documentation/networking/page_pool.rst  |  10 ++-
>   include/net/page_pool/helpers.h         |   8 +-
>   include/uapi/linux/netdev.h             |  19 +++++
>   net/core/netdev-genl-gen.c              |  32 ++++++++
>   net/core/netdev-genl-gen.h              |   7 ++
>   net/core/page_pool.c                    |   2 +-
>   net/core/page_pool_user.c               | 103 ++++++++++++++++++++++++
>   8 files changed, 250 insertions(+), 9 deletions(-)

Great to get stats support.

Looking forward to get feedback from my new colleagues at Cloudflare
how to consume this into our monitoring systems :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

