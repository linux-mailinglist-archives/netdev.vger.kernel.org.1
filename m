Return-Path: <netdev+bounces-22337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C37670CF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A303C282760
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D981426F;
	Fri, 28 Jul 2023 15:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8338134B0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF2C433C8;
	Fri, 28 Jul 2023 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690558931;
	bh=b49As86yg/5JYBX4M7DfYM4ZaQYfk/KakQKThOaO6kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uWyWn/xYkBvwkCrZ7LFj7lIF824IQZoowK8kJ1HCZUuDNcS5ujpYEFABzx5g8AzkF
	 1e96mljF/MQS4Opxxxt2SIAVz/GajtGvCO9BYH2wMQRWcWmiYdIPYcpFEobeVLc6II
	 tMWu6WXk0UloKXLDzqS7VXr5yqsX0nb7JF5QGEaelXKfMCF45zfFjKp4ZyovJPAYZU
	 ZLWI3eq0KOfZ4Y1rT2OufaNdC3K9OIuH4ooQ7R5xSWIBQdL389M19HFtGsQwFRUypw
	 OYOq5qAQGy00dx4qFv4EeMOAlLhUkoNxA4lVXU2VmlhOKAyGPiwDJiur+N4BXcAlTz
	 M8qieowzhNrww==
Message-ID: <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
Date: Fri, 28 Jul 2023 09:42:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: nicolas.dichtel@6wind.com, Stephen Hemminger
 <stephen@networkplumber.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <ZLZnGkMxI+T8gFQK@shredder> <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/23 7:01 AM, Nicolas Dichtel wrote:
> Frankly, it's quite complex, there are corner cases.

yes there are.
> 
> When an interface is set down, the routes associated to this interface should be
> removed. This is the simple part.
> But for ecmp routes, there are several cases:
>  - if all nh use this interface: the routes are deleted by the kernel;
>  - if only some nh uses this interface :
>    + if all other nh already point to a down interface: the route are deleted by
> the kernel;
>    + if at least one nh points to an up interface: the nh are temporarily disabled.
> 
> Managing a cache with this is not so obvious 😉


FRR works well with Linux at this point, and libnl's caching was updated
ad fixed by folks from Cumulus Networks so it should be a good too.

