Return-Path: <netdev+bounces-17969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E874753E0A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440831C2107F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243C134AD;
	Fri, 14 Jul 2023 14:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A513715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 14:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B66C433C7;
	Fri, 14 Jul 2023 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689346196;
	bh=nTr+kzLq/OZ0kdWmmt3bLM3t2AwhfqHv1qzEXhKG0TE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GeqjzZ5QkJb63S9MQd/1en/jHkVFNM9s4wj/nSw43+zAioAFukB361JzAVey1hjvE
	 YNIxOZBB/T6mAVQr5sryI5HRgDFL3X5jaE1/O8srMIyC9AEI91NUfYxFyRdu1TCVtw
	 rNjR+RFXq5kWcN92f9CbP6m10JjXDsq9PACL6Tcjz462RCxpHgezaAeNfplrbue6Os
	 bDGSLvq7UQOJlJGPywfoSN19eMFkcJlufVTI2jwk7EM3YBxXnm7NuEmP1KABWOVGoc
	 L4GqQqxF/5c4o9ZRhvGzYl2SBJZs1wmwknIeTsACkhi5siluM6O46Ez86u3unKI2PC
	 tLj+uhvh3sH0A==
Message-ID: <7f295784-b833-479a-daf4-84e4f89ec694@kernel.org>
Date: Fri, 14 Jul 2023 08:49:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20230712135520.743211-1-maze@google.com>
 <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
 <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/13/23 9:03 AM, Maciej Żenczykowski wrote:
> On Thu, Jul 13, 2023 at 4:59 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 7/12/23 7:55 AM, Maciej Żenczykowski wrote:
>>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>>> index e5213e598a04..94cec2075eee 100644
>>> --- a/net/ipv6/addrconf.c
>>> +++ b/net/ipv6/addrconf.c
>>> @@ -2561,12 +2561,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>>>                       ipv6_ifa_notify(0, ift);
>>>       }
>>>
>>> -     if ((create || list_empty(&idev->tempaddr_list)) &&
>>> -         idev->cnf.use_tempaddr > 0) {
>>> +     /* Also create a temporary address if it's enabled but no temporary
>>> +      * address currently exists.
>>> +      * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
>>> +      * as part of cleanup (ie. deleting the mngtmpaddr).
>>> +      * We don't want that to result in creating a new temporary ip address.
>>> +      */
>>> +     if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
>>> +             create = true;
>>
>> I am not so sure about this part. manage_tempaddrs has 4 callers --
>> autoconf (prefix receive), address add, address modify and address
>> delete. Seems like all of them have 'create' set properly when an
>> address is wanted in which case maybe the answer here is don't let empty
>> address list override `create`.
> 
> I did consider that and I couldn't quite convince myself that simply
> removing "|| list_empty()" from the if statement is necessarily correct
> (thus I went with the more obviously correct change).
> 
> Are you convinced dropping the || list_empty would work?
> I assume it's there for some reason...

I am hoping Jiri can recall why that part was added since it has the
side effect of adding an address on a delete which should not happen.

