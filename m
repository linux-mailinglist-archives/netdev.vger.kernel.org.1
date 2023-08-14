Return-Path: <netdev+bounces-27412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D614977BDB2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DC728115A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B830C8D2;
	Mon, 14 Aug 2023 16:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30BC139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE447C433C9;
	Mon, 14 Aug 2023 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692029608;
	bh=fOjB38l5xcSrMvlXvNZPGrFM5EeWYjo8GT1+lVgFs5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eXa59daESf0OZnQSenMGQ5CVhnI+CQeEIgNk34raAgpxO5GwSNwUd7W4UPqXq0BtI
	 qFCUmy2qpW+jXDFnPDEgA+eqjOKRRXXqHoBsW/2sxs/uy81QPoVzl80RxJjp2kjiaz
	 tjHMVJMXFYrvoOF4sCE7Fnx5qbHOskpx8D69uZqx7w8tGgxkGKeQN6/koxRTHM1Mnq
	 cgKbY0Tg5ItVGfgARfwuwOvEr+FtvKz5CH+J45tvIkpYTORLpzTFxVPy2zx5qSOO1V
	 9xgFzcSUea0uXQLjZnE30R9zsR/aCmLHhFxdw6p1I/G8/VhbuwE+y5/I265Z7Kk7up
	 Npo435yHahT8w==
Message-ID: <4cb32d96-6db8-fd4a-be18-52b4526a45b1@kernel.org>
Date: Mon, 14 Aug 2023 10:13:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCHv5 net-next] ipv6: do not match device when remove source
 route
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <20230811095308.242489-1-liuhangbin@gmail.com>
 <ZNkASnjqmAVg2vBg@shredder> <ZNnm4UOszRN6TOHJ@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZNnm4UOszRN6TOHJ@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/23 2:33 AM, Hangbin Liu wrote:
> Hi Ido,
> On Sun, Aug 13, 2023 at 07:09:46PM +0300, Ido Schimmel wrote:
>> On Fri, Aug 11, 2023 at 05:53:08PM +0800, Hangbin Liu wrote:
>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>> index 64e873f5895f..0f981cc5bed1 100644
>>> --- a/net/ipv6/route.c
>>> +++ b/net/ipv6/route.c
>>> @@ -4590,11 +4590,12 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>>>  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
>>>  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>>>  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
>>> +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
>>>  
>>> -	if (!rt->nh &&
>>> -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
>>> -	    rt != net->ipv6.fib6_null_entry &&
>>> -	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
>>> +	if (rt != net->ipv6.fib6_null_entry &&
>>> +	    rt->fib6_table->tb6_id == tb6_id &&
>>> +	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
>>> +	    !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
>>>  		spin_lock_bh(&rt6_exception_lock);
>>>  		/* remove prefsrc entry */
>>>  		rt->fib6_prefsrc.plen = 0;
>>
>> The table check is incorrect which is what I was trying to explain here
>> [1]. The route insertion code does not check that the preferred source
>> is accessible from the VRF where the route is installed, but instead
>> that it is accessible from the VRF of the first nexthop device. I'm not
> 
> Sorry for my bad understanding and thanks a lot for your patient response!
> 
> Now I finally get what you mean of "In IPv6, the preferred source address is
> looked up in the same VRF as the first nexthop device." Which is not same with
> the IPv4 commit f96a3d74554d ipv4: Fix incorrect route flushing when source
> address is deleted
> 
> I will remove the tb id checking in next version. Another thing to confirm.
> We need remove the "!rt->nh" checking, right. Because I saw you kept it in you
> reply.
> 

Make sure Ido's test cases for the various cases are added to the test
scripts. Lot of permutations here and we do not want to regress


