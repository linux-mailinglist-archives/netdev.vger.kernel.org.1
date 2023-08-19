Return-Path: <netdev+bounces-29004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E904781619
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAB1281E41
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8B376;
	Sat, 19 Aug 2023 00:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CE817
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C022EC433C8;
	Sat, 19 Aug 2023 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692405081;
	bh=Fo31e0YmYaAXWnVLsu7gc+ylwu14S8mGp51nbK4ztYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jqIzPQxVM9P7uCHnrmbup4vJa6A/9sehyKZALzadlvtGr3fMxmPDajs1IgX3qWe7n
	 2t8qLvHFVLFM6I+g2Qp6/4ATTClyoyhT0p30rc8HXfSjpt2nTXEW5XG2TM53NXoYCZ
	 exOp4/YnPJBQEUOKvCklVEyoAfBTLX3hm6M2SWR8njreDcbVzRxASxIzCqBjoZRaPU
	 VaIpu+rNYPgeQwj5ZcODhnD2IUY/ierTA32zTgbIts3rvtzKJvVljWxQeLedubRjLk
	 r45HXYSti10m3DtTiWe81BGJVDUcrIrmoQbJP0iLahwae7rq7wPrEZGH9KtxCWo+L5
	 vHACwyI0/XGjQ==
Message-ID: <c14aef2a-99bb-7f41-7a75-c08385557a9a@kernel.org>
Date: Fri, 18 Aug 2023 18:31:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCHv7 net-next 2/2] selftests: fib_test: add a test case for
 IPv6 source address delete
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>
References: <20230818082902.1972738-1-liuhangbin@gmail.com>
 <20230818082902.1972738-3-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230818082902.1972738-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/23 2:29 AM, Hangbin Liu wrote:
> Add a test case for IPv6 source address delete.
> 
> As David suggested, add tests:
> - Single device using src address
> - Two devices with the same source address
> - VRF with single device using src address
> - VRF with two devices using src address
> 
> As Ido points out, in IPv6, the preferred source address is looked up in
> the same VRF as the first nexthop device. This will give us similar results
> to IPv4 if the route is installed in the same VRF as the nexthop device, but
> not when the nexthop device is enslaved to a different VRF. So add tests:
> - src address and nexthop dev in same VR
> - src address and nexthop device in different VRF
> 
> The link local address delete logic is different from the global address.
> It should only affect the associate device it bonds to. So add tests cases
> for link local address testing.
> 
> Here is the test result:
> 
> IPv6 delete address route tests
>     Single device using src address
>     TEST: Prefsrc removed when src address removed on other device      [ OK ]
>     Two devices with the same source address
>     TEST: Prefsrc not removed when src address exist on other device    [ OK ]
>     TEST: Prefsrc removed when src address removed on all devices       [ OK ]
>     VRF with single device using src address
>     TEST: Prefsrc removed when src address removed on other device      [ OK ]
>     VRF with two devices using src address
>     TEST: Prefsrc not removed when src address exist on other device    [ OK ]
>     TEST: Prefsrc removed when src address removed on all devices       [ OK ]
>     src address and nexthop dev in same VRF
>     TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
>     TEST: Prefsrc in default VRF not removed                            [ OK ]
>     TEST: Prefsrc not removed from VRF when source address exist        [ OK ]
>     TEST: Prefsrc in default VRF removed                                [ OK ]
>     src address and nexthop device in different VRF
>     TEST: Prefsrc not removed from VRF when nexthop dev in diff VRF     [ OK ]
>     TEST: Prefsrc not removed in default VRF                            [ OK ]
>     TEST: Prefsrc removed from VRF when nexthop dev in diff VRF         [ OK ]
>     TEST: Prefsrc removed in default VRF                                [ OK ]
>     Table ID 0
>     TEST: Prefsrc removed from default VRF when source address deleted  [ OK ]
>     Link local source route
>     TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
>     TEST: Prefsrc removed when delete ll addr                           [ OK ]
>     TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
>     TEST: Prefsrc removed even ll addr still exist on other dev         [ OK ]
> 
> Tests passed:  19
> Tests failed:   0
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v8:
>   - remove test "Same FIB info with different table ID"
>   - test deleting src address from all devices.
>   - consistent the space before "src". Remove all.
> v7: add more tests as Ido and David suggested. Remove the IPv4 part as I want
>     to focus on the IPv6 fixes.
> ---
>  tools/testing/selftests/net/fib_tests.sh | 152 ++++++++++++++++++++++-
>  1 file changed, 151 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



