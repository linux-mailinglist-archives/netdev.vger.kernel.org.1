Return-Path: <netdev+bounces-18761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D937C758902
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94620281794
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D717AC7;
	Tue, 18 Jul 2023 23:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D1F51D
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C09BC433C8;
	Tue, 18 Jul 2023 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689722321;
	bh=Ej8txNbwt+OS6+eyWTsWb6hR3F1syo/go5VXr5m+ASM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lRxlX2ffqf9ZcwSMyGabSzHJevOw/EPc0sLWCdvTjbWDv9gsPPINdkLqkFUcQJjOT
	 W1UUkKDtgwO4m1ggglSbsm9B1bXB7StyDj4lEesfYdiNLlSDyMZhcZH5RBLzUcHJH3
	 JBee3BorRCwHxXiHoVcbQS2j70UoRABpCM7uKvq1LxMoYZwFbhrnatUao5bTlqeoVn
	 0AJvKSrQH1ms6lcLtKrTeurPvNnIjx8Jnzb9MbaOA2NgyY4VAhlR4BtUOrw+bNvxXm
	 YBXH2pOdBgeVHOqPtZGT/TFlY7/TCdnGZW1pVE5V8NUkARIUxRkeh0cWdLsAu6WIIM
	 Ae840w7Y5MYLg==
Message-ID: <3de5b93c-0fb3-8468-5d90-c3ffca286293@kernel.org>
Date: Tue, 18 Jul 2023 17:18:40 -0600
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
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20230712135520.743211-1-maze@google.com>
 <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
 <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
 <7f295784-b833-479a-daf4-84e4f89ec694@kernel.org>
 <20230718160832.0caea152@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230718160832.0caea152@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/23 5:08 PM, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 08:49:55 -0600 David Ahern wrote:
>>> I did consider that and I couldn't quite convince myself that simply
>>> removing "|| list_empty()" from the if statement is necessarily correct
>>> (thus I went with the more obviously correct change).
>>>
>>> Are you convinced dropping the || list_empty would work?
>>> I assume it's there for some reason...  
>>
>> I am hoping Jiri can recall why that part was added since it has the
>> side effect of adding an address on a delete which should not happen.
> 
> Did we get stuck here? Jiri are you around to answer?

If Jiri is not around or does not remember, I suggest moving forward by
dropping the list_empty check. Adding an address when one is deleted is
not intuitive at all.

