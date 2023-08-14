Return-Path: <netdev+bounces-27204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D558977AF20
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 03:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8799D280EEC
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9D10FB;
	Mon, 14 Aug 2023 01:20:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F739D
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC2FC433C8;
	Mon, 14 Aug 2023 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691976017;
	bh=7UuOJzL00ePftvjGmxtIWlTFUjoLdyQHasM4X74zw5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VvYOQF0esiab3KupbwitRUAIiHNJEIbS2D0vjCCM5JBj474FSvXwsqWa3OwPn5Nnw
	 svXHWhGTWezHLmoEiarlI0LuwOspLLNzWFid8o9164wnJfq8uNJfanCmFnyBvfuR38
	 px82clmSa9OdO0H8uimT1pVSMJ769EtPn0Di5ht6sPlPm3+99Lb8n4peJS+ZdbrwqN
	 yprUTkn3+H2Y0w0sXSMsKV8luzKEy/GHy3hXk4JevEO/9EBxuyUM/X60JDCEJbFCKC
	 4RYy9jmIekmJAWmg/FgtTS1WKjZevV/6UFfr9gfHPRFl2nAfbtYX6bTluamzcbWXea
	 CevmJdHLuwRUA==
Message-ID: <66259f8d-429d-907e-6793-4229ff36463e@kernel.org>
Date: Sun, 13 Aug 2023 19:20:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/2] nexthop: Simplify nexthop bucket dump
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, mlxsw@nvidia.com
References: <20230813164856.2379822-1-idosch@nvidia.com>
 <20230813164856.2379822-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230813164856.2379822-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/23 10:48 AM, Ido Schimmel wrote:
> Before commit f10d3d9df49d ("nexthop: Make nexthop bucket dump more
> efficient"), rtm_dump_nexthop_bucket_nh() returned a non-zero return
> code for each resilient nexthop group whose buckets it dumped,
> regardless if it encountered an error or not.
> 
> This meant that the sentinel ('dd->ctx->nh.idx') used by the function
> that walked the different nexthops could not be used as a sentinel for
> the bucket dump, as otherwise buckets from the same group would be
> dumped over and over again.
> 
> This was dealt with by adding another sentinel ('dd->ctx->done_nh_idx')
> that was incremented by rtm_dump_nexthop_bucket_nh() after successfully
> dumping all the buckets from a given group.
> 
> After the previously mentioned commit this sentinel is no longer
> necessary since the function no longer returns a non-zero return code
> when successfully dumping all the buckets from a given group.
> 
> Remove this sentinel and simplify the code.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



