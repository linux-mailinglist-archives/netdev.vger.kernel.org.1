Return-Path: <netdev+bounces-39602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE97C0047
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5071C20B17
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42027448;
	Tue, 10 Oct 2023 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAsC17fW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172727444
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260F6C433C8;
	Tue, 10 Oct 2023 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696951314;
	bh=99eJ0iwDfRXiGwvrWcUHIOEqchSJKeRc6lfjSVnAxEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MAsC17fWoj5cAPNu7e4k02i80hiOUPG5WvK3hprvTLfq0L2NkI7VsM21Ly8xvTk3r
	 /2Hel2FweVFxwNI6lflZk7B/I1UiSq4zH8BIcJkVwIYnn9N/AWbKWjyiJL4ClZvcEr
	 S3iVa3uDSJ+MMJVG98pAYQu7QgdK3bl2g8Q3zTQUPPlML4m+nDkTCthHbKQE6W9D3F
	 0qVV/FpOOZtbpeJZAjtA3yr1uVv/bu4ILfCpaaKK57D/iadnmgKguUSHwYzYZfSMPy
	 VExAmMjnN9bmdxmaB+DPUEDHRvKcVzP/xBbROrfYj96OIfz8Yt5mFdy3ydUcKE/ArG
	 usu0LFXx5WpYw==
Message-ID: <d903ddfb-e71a-e1d7-9d78-913825d7332e@kernel.org>
Date: Tue, 10 Oct 2023 09:21:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 2/2] selftests: fib_tests: Count all trace point
 invocations
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@gmail.com, sriram.yagnaraman@est.tech,
 oliver.sang@intel.com, mlxsw@nvidia.com
References: <20231010132113.3014691-1-idosch@nvidia.com>
 <20231010132113.3014691-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231010132113.3014691-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/23 7:21 AM, Ido Schimmel wrote:
> The tests rely on the IPv{4,6} FIB trace points being triggered once for
> each forwarded packet. If receive processing is deferred to the
> ksoftirqd task these invocations will not be counted and the tests will
> fail. Fix by specifying the '-a' flag to avoid perf from filtering on
> the mausezahn task.
> 
> Before:
> 
>  # ./fib_tests.sh -t ipv4_mpath_list
> 
>  IPv4 multipath list receive tests
>      TEST: Multipath route hit ratio (.68)                               [FAIL]
> 
>  # ./fib_tests.sh -t ipv6_mpath_list
> 
>  IPv6 multipath list receive tests
>      TEST: Multipath route hit ratio (.27)                               [FAIL]
> 
> After:
> 
>  # ./fib_tests.sh -t ipv4_mpath_list
> 
>  IPv4 multipath list receive tests
>      TEST: Multipath route hit ratio (1.00)                              [ OK ]
> 
>  # ./fib_tests.sh -t ipv6_mpath_list
> 
>  IPv6 multipath list receive tests
>      TEST: Multipath route hit ratio (.99)                               [ OK ]
> 
> Fixes: 8ae9efb859c0 ("selftests: fib_tests: Add multipath list receive tests")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/netdev/202309191658.c00d8b8-oliver.sang@intel.com/
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



