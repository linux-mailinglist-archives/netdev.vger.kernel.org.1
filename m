Return-Path: <netdev+bounces-49956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB87F4109
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FE61C20906
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212142D637;
	Wed, 22 Nov 2023 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRpwO2Px"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019AC2BAEA
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 09:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86468C4AF5D;
	Wed, 22 Nov 2023 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643763;
	bh=pbWnN9CvbMIMYHlY7mu7tdZDHpMUBdubAMzneJKqXso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fRpwO2Pxt/9nc8KZaP8+YqwsttfW8/RdC0NCtXL7okAM6XuLkl9F2INXv1zTActWH
	 RsXKFMjShaseqZ5d6QaOxAZM7WIdi/EzQA1SzHXVX6Sf7PkdUQFgp5FSIz8XIe1rHv
	 j55IQAEVm1NgMmr3aLkcz92EwCZ6miIox238vw2Q+eq64g/2dkxCCL+z/znET/iXV9
	 gxHhijjJVLlosK20JveRb+0p+gBFuaNDOHpePDLVQ3g1+oa0E2CXu5sEvlnQy/n1O3
	 nkxez0orv9QkVCNFo6sqN/YTYPkBusbnXsb7/F8z4/fKGsqubT01VDWU86nvOujlaN
	 PFAS2euBiRyVQ==
Message-ID: <86a63230-767c-42c6-b0ed-520d90691ce1@kernel.org>
Date: Wed, 22 Nov 2023 10:02:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/13] net: page_pool: report when page pool
 was destroyed
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-11-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Report when page pool was destroyed. Together with the inflight
> / memory use reporting this can serve as a replacement for the
> warning about leaked page pools we currently print to dmesg.
> 
> Example output for a fake leaked page pool using some hacks
> in netdevsim (one "live" pool, and one "leaked" on the same dev):
> 
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>             --dump page-pool-get
> [{'id': 2, 'ifindex': 3},
>   {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]
> 
> Tested-by: Dragos Tatulea<dtatulea@nvidia.com>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
>   include/net/page_pool/types.h           |  1 +
>   include/uapi/linux/netdev.h             |  1 +
>   net/core/page_pool.c                    |  1 +
>   net/core/page_pool_priv.h               |  1 +
>   net/core/page_pool_user.c               | 12 ++++++++++++
>   6 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 85209e19dca9..695e0e4e0d8b 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -125,6 +125,18 @@ name: netdev
>           type: uint
>           doc: |
>             Amount of memory held by inflight pages.
> +      -
> +        name: detach-time
> +        type: uint
> +        doc: |
> +          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
> +          the driver. Once detached Page Pool can no longer be used to
> +          allocate memory.
> +          Page Pools wait for all the memory allocated from them to be freed
> +          before truly disappearing. "Detached" Page Pools cannot be
> +          "re-attached", they are just waiting to disappear.
> +          Attribute is absent if Page Pool has not been detached, and
> +          can still be used to allocate new memory.
>   

Thanks for making the adjustments. I like the new "detach" term.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

