Return-Path: <netdev+bounces-29002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C6781603
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BBC281D2F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5F367;
	Sat, 19 Aug 2023 00:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA6362
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D6C433C7;
	Sat, 19 Aug 2023 00:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692404932;
	bh=VOLr2nxHuiq3Y73j8JyrdWPVFnwxKw1d13s4op18i5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M3b7tnhC1kr8fwT65KlVVZhm9X3ukQ7qJVbfGT5Ldbq5V4OmehVugAqIB7MR9ubJz
	 HTEAKoKdlM38RK9AGJOaifGhkSFD8rcFdjfDCxbFe407SFBgRRqLB84MvjcDAnPTZ2
	 hidZ6iKOrU6TbFHCfRVXoGqQP2hNswZE/qAOJgUcBBpsvlSQtqcgo/4IJg6IGBWIQX
	 Jw18k4yNlpAm6Fcu0aQbkfEmLutxwawKA13MDj+xCyDGs7qssUg56nJoU/uZ6i8lLb
	 7bEk4BkJTrulp8i9hgV5cJ5y5r7w1yw6ecXygBlcsVHtj1fTzfTt1Ox4NgrX70GAHe
	 iX49ese1WmoDg==
Message-ID: <136fabc5-d8ed-f4a4-1aa6-5a4ec1d2b70c@kernel.org>
Date: Fri, 18 Aug 2023 18:28:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCHv7 net-next 1/2] ipv6: do not match device when remove
 source route
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>, Ido Schimmel <idosch@nvidia.com>
References: <20230818082902.1972738-1-liuhangbin@gmail.com>
 <20230818082902.1972738-2-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230818082902.1972738-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/23 2:29 AM, Hangbin Liu wrote:
> After deleting an IPv6 address on an interface and cleaning up the
> related preferred source entries, it is important to ensure that all
> routes associated with the deleted address are properly cleared. The
> current implementation of rt6_remove_prefsrc() only checks the preferred
> source addresses bound to the current device. However, there may be
> routes that are bound to other devices but still utilize the same
> preferred source address.
> 
> To address this issue, it is necessary to also delete entries that are
> bound to other interfaces but share the same source address with the
> current device. Failure to delete these entries would leave routes that
> are bound to the deleted address unclear. Here is an example reproducer
> (I have omitted unrelated routes):
> 
> + ip link add dummy1 type dummy
> + ip link add dummy2 type dummy
> + ip link set dummy1 up
> + ip link set dummy2 up
> + ip addr add 1:2:3:4::5/64 dev dummy1
> + ip route add 7:7:7:0::1 dev dummy1 src 1:2:3:4::5
> + ip route add 7:7:7:0::2 dev dummy2 src 1:2:3:4::5
> + ip -6 route show
> 1:2:3:4::/64 dev dummy1 proto kernel metric 256 pref medium
> 7:7:7::1 dev dummy1 src 1:2:3:4::5 metric 1024 pref medium
> 7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
> + ip addr del 1:2:3:4::5/64 dev dummy1
> + ip -6 route show
> 7:7:7::1 dev dummy1 metric 1024 pref medium
> 7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
> 
> As Ido reminds, in IPv6, the preferred source address is looked up in
> the same VRF as the first nexthop device, which is different with IPv4.
> So, while removing the device checking, we also need to add an
> ipv6_chk_addr() check to make sure the address does not exist on the other
> devices of the rt nexthop device's VRF.
> 
> After fix:
> + ip addr del 1:2:3:4::5/64 dev dummy1
> + ip -6 route show
> 7:7:7::1 dev dummy1 metric 1024 pref medium
> 7:7:7::2 dev dummy2 metric 1024 pref medium
> 
> Reported-by: Thomas Haller <thaller@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2170513
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v7: remove fixes tag
> v6:
>  - Add back the "!rt->nh" checking as Ido said this should be fixed in
>    another patch.
>  - Remove the table id checking as the preferred source address is
>    looked up in the same VRF as the first nexthop device in IPv6. not VRF
>    table like IPv4.
>  - Move the fib tests to a separate patch.
> v5: Move the addr check back to fib6_remove_prefsrc.
> v4: check if the prefsrc address still exists on other device
> v3: remove rt nh checking. update the ipv6_del_addr test descriptions
> v2: checking table id and update fib_test.sh
> ---
>  net/ipv6/route.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



