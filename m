Return-Path: <netdev+bounces-37423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EF7B54C7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BABF7280DCC
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4919BB8;
	Mon,  2 Oct 2023 14:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D419BAB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 14:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EAEC433C8;
	Mon,  2 Oct 2023 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696256125;
	bh=yBLggVfjJptc78Vjm7vipW9J6f/K+WIJSeZEXBiMFCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WYHkK05bK8+f3PBgxgAZOWhYVMJ78oD7cpe+heni54N9r63Q4zK5wWzBJajT1l6yK
	 COn05Jh8yqDhTY8zPDk+SHqOiOl8DVQU5eF2nsggzQxWJY+Q4p63QeWRz9SE3oPhAP
	 Vo0mH4EgXC2z46wDeAIUxbhpgAU4Dg1/u5IvGq5GnaQXUoHaGbHiANLhDofh3ec7Bm
	 6S0rlmO0VZn8OR/VcNNi9kLhP1KJMWVgCD/X+Tcp0EF0LDCvtOlIOd4SjshXU8pOns
	 IA4LXBYFV4vHr4MRUJa+Ekdapyv9lXX9AeVYdQT4prGbJrE2fAm66K8ooyYom5zp3A
	 PBOL3KUC3jwTg==
Message-ID: <37a93031-b594-f27f-70f9-02762511d6b9@kernel.org>
Date: Mon, 2 Oct 2023 08:15:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] ipv4: Set offload_failed flag in fibmatch results
To: Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Amit Cohen <amcohen@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>
References: <20230926182730.231208-1-bpoirier@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230926182730.231208-1-bpoirier@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/23 12:27 PM, Benjamin Poirier wrote:
> Due to a small omission, the offload_failed flag is missing from ipv4
> fibmatch results. Make sure it is set correctly.
> 
> The issue can be witnessed using the following commands:
> echo "1 1" > /sys/bus/netdevsim/new_device
> ip link add dummy1 up type dummy
> ip route add 192.0.2.0/24 dev dummy1
> echo 1 > /sys/kernel/debug/netdevsim/netdevsim1/fib/fail_route_offload
> ip route add 198.51.100.0/24 dev dummy1
> ip route
> 	# 192.168.15.0/24 has rt_trap
> 	# 198.51.100.0/24 has rt_offload_failed
> ip route get 192.168.15.1 fibmatch
> 	# Result has rt_trap
> ip route get 198.51.100.1 fibmatch
> 	# Result differs from the route shown by `ip route`, it is missing
> 	# rt_offload_failed
> ip link del dev dummy1
> echo 1 > /sys/bus/netdevsim/del_device
> 
> Fixes: 36c5100e859d ("IPv4: Add "offload failed" indication to routes")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/route.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

