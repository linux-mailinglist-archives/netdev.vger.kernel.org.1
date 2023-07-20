Return-Path: <netdev+bounces-19544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024375B24D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE72281F5B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1918C0C;
	Thu, 20 Jul 2023 15:18:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C918C06
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE618C433CA;
	Thu, 20 Jul 2023 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689866298;
	bh=sa++SOpu0OOLby+nKZrbEuQPjr0iW/gaMnyzIgw8AIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DXSLZmG9sH0SlU10hMwLPvpQ57q5vtc5mk3AOtculg3jPG/bzaG/46wihnNLqpBMY
	 yIxcbT7DTFFZDQOfrHs48EqyD+YFZbAGdxgkLCqj+8CMxTBt3HQ++0NhH7u0iTVTx9
	 x9NsVsjIEjoWKrgfh7HYIk/yjxAiADzoiff2n14ynez7axrZy1+OeL0bK/ZlHPv1in
	 SUeHNo0McwOMg4p70PH1whla7mm4AVI8Fnsor4TXJYlo4AK5+fbA0gSA5g5JNf7dzL
	 +98fyTCfeFq3OBJ+yj2bWcRfYyfQFTsn75Eu4WrGrp7Bh5nFmFeod55CvzgTXrmpWP
	 rlxluoJWrdcyA==
Message-ID: <dae3fc04-5e59-dff5-db77-ea7d0a3d154e@kernel.org>
Date: Thu, 20 Jul 2023 09:18:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 3/4] nexthop: Do not return invalid nexthop
 object during multipath selection
Content-Language: en-US
To: Benjamin Poirier <bpoirier@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
 <20230719-nh_select-v2-3-04383e89f868@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230719-nh_select-v2-3-04383e89f868@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/23 7:57 AM, Benjamin Poirier wrote:
> With legacy nexthops, when net.ipv4.fib_multipath_use_neigh is set,
> fib_select_multipath() will never set res->nhc to a nexthop that is not
> good (as per fib_good_nh()). OTOH, with nexthop objects,
> nexthop_select_path_hthr() may return a nexthop that failed the
> nexthop_is_good_nh() test even if there was one that passed. Refactor
> nexthop_select_path_hthr() to follow a selection logic more similar to
> fib_select_multipath().
> 
> The issue can be demonstrated with the following sequence of commands. The
> first block shows that things work as expected with legacy nexthops. The
> last sequence of `ip rou get` in the second block shows the problem case -
> some routes still use the .2 nexthop.
> 
> sysctl net.ipv4.fib_multipath_use_neigh=1
> ip link add dummy1 up type dummy
> ip rou add 198.51.100.0/24 nexthop via 192.0.2.1 dev dummy1 onlink nexthop via 192.0.2.2 dev dummy1 onlink
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh add 192.0.2.1 dev dummy1 nud failed
> echo ".1 failed:"  # results should not use .1
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh del 192.0.2.1 dev dummy1
> ip neigh add 192.0.2.2 dev dummy1 nud failed
> echo ".2 failed:"  # results should not use .2
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip link del dummy1
> 
> ip link add dummy1 up type dummy
> ip nexthop add id 1 via 192.0.2.1 dev dummy1 onlink
> ip nexthop add id 2 via 192.0.2.2 dev dummy1 onlink
> ip nexthop add id 1001 group 1/2
> ip rou add 198.51.100.0/24 nhid 1001
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh add 192.0.2.1 dev dummy1 nud failed
> echo ".1 failed:"  # results should not use .1
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip neigh del 192.0.2.1 dev dummy1
> ip neigh add 192.0.2.2 dev dummy1 nud failed
> echo ".2 failed:"  # results should not use .2
> for i in {10..19}; do ip -o rou get 198.51.100.$i; done
> ip link del dummy1
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



