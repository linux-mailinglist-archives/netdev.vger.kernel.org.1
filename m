Return-Path: <netdev+bounces-18089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12914754A6D
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383CA281E1E
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B16846A;
	Sat, 15 Jul 2023 17:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6415B8
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 17:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D18C433C8;
	Sat, 15 Jul 2023 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689441636;
	bh=pUM/+E0mchtEL5aXVIDfQBGQoM2EdqzptGbYZLJmW4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f6xmu1FqCdNh56ViC1A0Tm5yTeoS1ug16m4cbrLFkLFQom3eQP+f85Qbprq6ZQ+4Z
	 Ah1YlIT8RZYugUOnnP5b5Uxx/uPP9OxziUkQHwdJrfWa6eVwAOZ1j+G6rbyElBWL82
	 o73vsvnabz4oB7BevSqnME8d5qtoimMB9RDdTHi4kxW6Q/johVSXf8ffYINb3dcSjv
	 rFdY7CQyFyP1KlYfFAEWcOVc1ftnziBS/MbFeTWv4DHz2qkM/ouPi2wMB1WygDe9dQ
	 9+vOdMIgid7vFVl8anTxDnZzURuHmgsOZMIV+ZnJsRD1TAVHK43a46eUr1mVhfNtli
	 3MyODUH5MSkuA==
Message-ID: <06164db3-e738-c39e-56e5-10372a87a09b@kernel.org>
Date: Sat, 15 Jul 2023 11:20:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net] vrf: Fix lockdep splat in output path
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, naresh.kamboju@linaro.org
References: <20230715153605.4068066-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230715153605.4068066-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/23 9:36 AM, Ido Schimmel wrote:
> Cited commit converted the neighbour code to use the standard RCU
> variant instead of the RCU-bh variant, but the VRF code still uses
> rcu_read_lock_bh() / rcu_read_unlock_bh() around the neighbour lookup
> code in its IPv4 and IPv6 output paths, resulting in lockdep splats
> [1][2]. Can be reproduced using [3].
> 
> Fix by switching to rcu_read_lock() / rcu_read_unlock().
> 

...

> [3]
> #!/bin/bash
> 
> ip link add name vrf-red up numtxqueues 2 type vrf table 10
> ip link add name swp1 up master vrf-red type dummy
> ip address add 192.0.2.1/24 dev swp1
> ip address add 2001:db8:1::1/64 dev swp1
> ip neigh add 192.0.2.2 lladdr 00:11:22:33:44:55 nud perm dev swp1
> ip neigh add 2001:db8:1::2 lladdr 00:11:22:33:44:55 nud perm dev swp1
> ip vrf exec vrf-red ping 192.0.2.2 -c 1 &> /dev/null
> ip vrf exec vrf-red ping6 2001:db8:1::2 -c 1 &> /dev/null
> 
> Fixes: 09eed1192cec ("neighbour: switch to standard rcu, instead of rcu_bh")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/netdev/CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> Using the "Link" tag instead of "Closes" since there are two reports in
> the link, but I can only reproduce the second.
> 
> I believe that the rcu_read_lock_bh() / rcu_read_unlock_bh() in
> vrf_finish_direct() can be removed since dev_queue_xmit_nit() uses
> rcu_read_lock() / rcu_read_unlock(). I will send a patch to net-next
> after confirming it.
> ---
>  drivers/net/vrf.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks, Ido.


