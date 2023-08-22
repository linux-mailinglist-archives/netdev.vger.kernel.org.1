Return-Path: <netdev+bounces-29688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E69784589
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5202280D3F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8341D31F;
	Tue, 22 Aug 2023 15:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ACA1CA14
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AC2C433CB;
	Tue, 22 Aug 2023 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692718183;
	bh=AZNcG+IYsi6DNqBPKXkzo6RHEQG/Hk67R5Q8hUGOrqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oU1h0ICUMrY3jTFHMDS3hUN5OpSQbC5VrkAUGcIpRJA/bMjilrgVJ3Uc0f4O5Os6D
	 cIZgrwsFT6oEoPcer+d7paH9Mh8wkLUuF90ggSKYSmWe4It+2CVqLBV1v3ointAW3Z
	 11DK28xCUZ7pei6F/92woN6z5fcrHDnHaF8Sdd8nF0cBn573ba0vOmFqva++othh5U
	 HMB0NvNuZYCyWCnO/b57VxuqEe98K7eXm3xgZDd/GlT096Eop6PZfnijEfAywwLVP6
	 LfME+N6D3dY8Yx23WpRFxR36uRBp7wSqXo4gICdi7blSHzJ+jHnR11D/PklrOZM111
	 7B5H+7OzDuNdA==
Message-ID: <9884f61a-8a92-cf18-6477-11b4dd12ce6b@kernel.org>
Date: Tue, 22 Aug 2023 08:29:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] vrf: Remove unnecessary RCU-bh critical section
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, mlxsw@nvidia.com
References: <20230821142339.1889961-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230821142339.1889961-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/23 8:23 AM, Ido Schimmel wrote:
> dev_queue_xmit_nit() already uses rcu_read_lock() / rcu_read_unlock()
> and nothing suggests that softIRQs should be disabled around it.
> Therefore, remove the rcu_read_lock_bh() / rcu_read_unlock_bh()
> surrounding it.
> 
> Tested using [1] with lockdep enabled.
> 
> [1]
>  #!/bin/bash
> 
>  ip link add name vrf1 up type vrf table 100
>  ip link add name veth0 type veth peer name veth1
>  ip link set dev veth1 master vrf1
>  ip link set dev veth0 up
>  ip link set dev veth1 up
>  ip address add 192.0.2.1/24 dev veth0
>  ip address add 192.0.2.2/24 dev veth1
>  ip rule add pref 32765 table local
>  ip rule del pref 0
>  tcpdump -i vrf1 -c 20 -w /dev/null &
>  sleep 10
>  ping -i 0.1 -c 10 -q 192.0.2.2
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



