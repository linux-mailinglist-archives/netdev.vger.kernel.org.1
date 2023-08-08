Return-Path: <netdev+bounces-25209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9243773606
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CD61C20DA1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C83391;
	Tue,  8 Aug 2023 01:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814937E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 01:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5712FC433C8;
	Tue,  8 Aug 2023 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691459079;
	bh=SVibUrrPgb3NdfR3BmD/NxT/18CFMoOaOrIpU+j8lTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HyqLENdfysq3Jioueguw2gE3rNouDLXSVYSjE25JGIB8sU97gq8lkfhvAS/FQ4n7U
	 qrqBjUVnghvNbYTbuIpMorqJQRTdurYRjs3avqeosdxe65uDI1sYbNz8zyU2fPUoZm
	 qVjKyI6srImvdQoyQdsLRi9tpFZ3zyhSnxrQl5LY4ddAh9myrQ5z+mD6bMKffIZ6aM
	 oEyhti7xNGjtN4gLiuYbtJ6RUheJeqt7JY6tm7+sKsTCD+LD950lUlfddyUjtSNTBe
	 aCMRPzqEfcDLw+syTNK6lrMB840aXa/MaWQkanfSnrXfky3s4a8qOq9W8faGFqN/+r
	 JZ3XdKZoDje9Q==
Message-ID: <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org>
Date: Mon, 7 Aug 2023 19:44:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: Thomas Haller <thaller@redhat.com>, nicolas.dichtel@6wind.com,
 Stephen Hemminger <stephen@networkplumber.org>,
 Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <ZLZnGkMxI+T8gFQK@shredder> <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/23 3:10 AM, Thomas Haller wrote:
> On Fri, 2023-07-28 at 09:42 -0600, David Ahern wrote:
>> On 7/28/23 7:01 AM, Nicolas Dichtel wrote:
>>
>>> Managing a cache with this is not so obvious 😉
>>
>>
>> FRR works well with Linux at this point, 
> 
> Interesting. Do you have a bit more information?
> 
>> and libnl's caching was updated
>> ad fixed by folks from Cumulus Networks so it should be a good too.
> 
> 
> Which "libnl" do you mean?

yes. https://github.com/thom311/libnl.git

> 
> Route caching in libnl3 upstream is very broken (which I am to blame
> for, as I am the maintainer).
> 

as someone who sent in patches it worked for all of Cumulus' uses cases
around 2018-2019 time frame. Can't speak for the status today.

