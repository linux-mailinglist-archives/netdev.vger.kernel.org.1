Return-Path: <netdev+bounces-31075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6ED78B3F9
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB8C1C20954
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718A912B97;
	Mon, 28 Aug 2023 15:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804D46AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C17C433C7;
	Mon, 28 Aug 2023 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693235186;
	bh=JWQLXxjSFyLZsLLKMkWVkDZfdWptll95kqHsbPlqozA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bgkICEZGvC6SiLvsbSKk+gX+L+B8Js2mGisqW1n2x0zNpTe9PXfP+PRvu3hg0H1mb
	 2keLEQd7zq8ZtVSo/LnBdl8o+eL5Ryu9FBYlsP8J7PCwY6J4BJ/9mmwjkKAQEgtuQx
	 uJ+wfODWWXdHBpUUC4U5kfNAshUeVB1Sbxq6k7dhucAIAJiWB1lVYYztCdfI1NjPRA
	 /vodk4e8CEc/uElNoHiTMamAWNkFo+BGJVKDko/nDAY3Atm/7tIntY0mo3+qdcnySi
	 jFa2ahnfDclpuUJNSAQzn4ahjTXOsRQLC+njY2EgZXo3RAhst3czGZnnnIbIxc3S/f
	 tFfPazDEgPofA==
Message-ID: <078061ce-1411-d150-893a-d0a950c8866f@kernel.org>
Date: Mon, 28 Aug 2023 09:06:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route
To: Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel <idosch@idosch.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1> <ZMKC7jTVF38JAeNb@shredder>
 <ZOxSYqrgndbdL4/M@Laptop-X1>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZOxSYqrgndbdL4/M@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 1:53 AM, Hangbin Liu wrote:
> On Thu, Jul 27, 2023 at 05:45:02PM +0300, Ido Schimmel wrote:
>>> Since the route are not merged, the nexthop weight is not shown, which
>>> make them look like the same for users. For IPv4, the scope is also
>>> not shown, which look like the same for users.
>>
>> The routes are the same, but separate. They do not form a multipath
>> route. Weight is meaningless for a non-multipath route.
>>
>>> But there are 2 issues here:
>>> 1. the *type* and *protocol* field are actally ignored
>>> 2. when do `ip monitor route`, the info dumpped in fib6_add_rt2node()
>>>    use the config info from user space. When means `ip monitor` show the
>>>    incorrect type and protocol
>>>
>>> So my questions are, should we show weight/scope for IPv4?
> 
> Here is the first one. As the weight/scope are not shown, the two separate
> routes would looks exactly the same for end user, which makes user confused.

Asked and answered many times above: Weight has no meaning on single
path routes; it is not even tracked if I recall correctly.

> So why not just show the weight/scope, or forbid user to add a non-multipath
> route with weight/scope?

That is a change to a uAPI we can not do at this point.

> 
>>> How to deal the type/proto info missing for IPv6?
> 
> What we should do for this bug? The type/proto info are ignored when
> merge the IPv6 nexthop entries.

I need more information; this thread has gone on for a long time now.

