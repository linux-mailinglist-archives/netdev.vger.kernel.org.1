Return-Path: <netdev+bounces-19558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FECC75B2ED
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12711C214EE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC718C0D;
	Thu, 20 Jul 2023 15:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61E1772A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C7EC433C9;
	Thu, 20 Jul 2023 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689867321;
	bh=OVcvzXqOdhx1DIqYZHcTWn4jGte6HtcZDHDvPjBMs+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Io5qyGUefFPAyM2joBWD1y6bdQE/BITEHZxsQ0aWyQ/KaxgwoPq4rKJDF9AQQ3jFJ
	 Kf1zKZdTS0zwdof4r6np2/i9eM//PWw3GLwex0gRVDR02eXFqwHuiO5ZaQwzmAv6LL
	 QBVfYUu4NYYP1OFwE3/p0LJSDRW00yN0sAKIvIeVY/9EVBq0dll6mzIbF9lW3FPLbN
	 EORWKBpfrucmKu63kpbBfk36lFYbIR1COUD9gl4pBw9VGk8WZpAASjWNINuZ2QPEgO
	 RhjiNK+7HTeTqkWkFe+Xs2iwbtpkJsIadDETFYLnOLQBeGdLaNhP0Mwo1gMlT6YA+z
	 Kt6YZi2ywJESw==
Message-ID: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
Date: Thu, 20 Jul 2023 09:35:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20230712135520.743211-1-maze@google.com>
 <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
 <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
 <7f295784-b833-479a-daf4-84e4f89ec694@kernel.org>
 <20230718160832.0caea152@kernel.org> <ZLeHEDdWYVkABUDE@nanopsycho>
 <CANP3RGdBM+8yZcCmgrw9LTGUbGNNRD0xAx+hLgQE64wxAyda4g@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANP3RGdBM+8yZcCmgrw9LTGUbGNNRD0xAx+hLgQE64wxAyda4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/19/23 6:50 AM, Maciej Żenczykowski wrote:
> On Wed, Jul 19, 2023 at 8:47 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> Wed, Jul 19, 2023 at 01:08:32AM CEST, kuba@kernel.org wrote:
>>> On Fri, 14 Jul 2023 08:49:55 -0600 David Ahern wrote:
>>>>> I did consider that and I couldn't quite convince myself that simply
>>>>> removing "|| list_empty()" from the if statement is necessarily correct
>>>>> (thus I went with the more obviously correct change).
>>>>>
>>>>> Are you convinced dropping the || list_empty would work?
>>>>> I assume it's there for some reason...
>>>>
>>>> I am hoping Jiri can recall why that part was added since it has the
>>>> side effect of adding an address on a delete which should not happen.
>>>
>>> Did we get stuck here? Jiri are you around to answer?
>>
>> Most probably a bug. But, this is 10 years since the change, I don't
>> remember much after this period. I didn't touch the code since :/
> 
> I *think* there might be cases where we want
>   addrconf_prefix_rcv_add_addr() -> manage_tempaddrs(create=false)
> to result in the creation of a new temporary address.
> 
> Basically the 'create' argument is a boolean with interpretation
> "was managetmpaddr added/created" as opposed to "should a temporary
> address be created"
> 
> Think:
> - RA comes in, we create the managetmpaddr, we call
> manage_tempaddrs(create=true), a temporary address gets created
> - someone comes in and deletes the temporary address (perhaps by hand?
> or it expires?)
> - another RA comes in, we don't create the managetmpaddr, since it
> already exists, we call manage_tempaddrs(create=false),
>   it notices there are no temporary addresses (by virtue of the ||
> list_empty check), and creates a new one.
> 
> Note that:
>   #define TEMP_VALID_LIFETIME (7*86400)
>   #define TEMP_PREFERRED_LIFETIME (86400)
> but these are tweakable...
>   $ cat /proc/sys/net/ipv6/conf/*/temp_valid_lft | uniq -c
>      37 604800
>   $ cat /proc/sys/net/ipv6/conf/*/temp_prefered_lft | uniq -c
>      37 86400
> so we could have these be < unsolicited RA frequency.
> (that's probably a bad idea for other reasons... but that's besides the point)
> 
> I have similar misgivings about  inet6_addr_modify() -> manage_tempaddrs()
> 
> if (was_managetempaddr || ifp->flags & IFA_F_MANAGETEMPADDR) {
> if (was_managetempaddr &&
> !(ifp->flags & IFA_F_MANAGETEMPADDR)) {
> cfg->valid_lft = 0;
> cfg->preferred_lft = 0;
> }
> manage_tempaddrs(ifp->idev, ifp, cfg->valid_lft,
> cfg->preferred_lft, !was_managetempaddr,
> jiffies);
> }
> 
> Here create == !was_managetempaddr,
> but technically we can have create == false, and yet valid/prefered != 0.
> 
> This will be the case if we have inet6_addr_modify() called where
> *both* the before and after state is a managetempaddr.
> Perhaps because the expiration was updated?
> 
> Anyway... because of the above I remain unconvinced that just removing
> '|| list_empty' is safe...

ok, want to resend this patch?

