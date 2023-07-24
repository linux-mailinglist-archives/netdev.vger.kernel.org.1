Return-Path: <netdev+bounces-20529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4857D75FF00
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 20:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BA42813C9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13537100CF;
	Mon, 24 Jul 2023 18:26:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82478100CB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97218C433C7;
	Mon, 24 Jul 2023 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690223167;
	bh=Bkh8ORp11I3JWi+TdQCKZGsrCOdvGnXV6kNnuKPOC1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lww/DT2U8M0zocDcCpPa91hqcUcuhd5NB0kejtH66dOOwYjNiSPJ5de8rwKI/G0GW
	 ji0ngJ3rmtYGO1Do7XI9BTUnTAydDJM26vgkshvxnQC6y2b0XjBIWYynynrVOQ92pd
	 IJMx1K6UTIqHItBAHwG71YxoAHeqv/QCqcqE8QtQfyB+c+pihtanAIER76zy7np8zg
	 v2+V9CDM1wjL4Efm64jvOc4RVDRw2QomTD3RlNVdQlQ0vxVMF29zfA3zhWjTwuBWTe
	 mTAieRdkmzZBEh3F6UXZmnI8TzIJxs/l/97U2rT7LI/c1DXnYpbZzCmIAZ6YhmFAPr
	 UbOR4WEzELAKw==
Message-ID: <eda44d92-7ac9-c3e9-fdc4-3dd287464981@kernel.org>
Date: Mon, 24 Jul 2023 12:26:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Thomas Haller <thaller@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Xiao Ma <xiaom@google.com>
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
 <20230720160022.1887942-1-maze@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230720160022.1887942-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/20/23 10:00 AM, Maciej Żenczykowski wrote:
> currently on 6.4 net/main:
> 
>   # ip link add dummy1 type dummy
>   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
>   # ip link set dummy1 up
>   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
>   # ip -6 addr show dev dummy1
> 
>   11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>       inet6 2000::44f3:581c:8ca:3983/64 scope global temporary dynamic
>          valid_lft 604800sec preferred_lft 86172sec
>       inet6 2000::1/64 scope global mngtmpaddr
>          valid_lft forever preferred_lft forever
>       inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
>          valid_lft forever preferred_lft forever
> 
>   # ip -6 addr del 2000::44f3:581c:8ca:3983/64 dev dummy1
> 
>   (can wait a few seconds if you want to, the above delete isn't [directly] the problem)
> 
>   # ip -6 addr show dev dummy1
> 
>   11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>       inet6 2000::1/64 scope global mngtmpaddr
>          valid_lft forever preferred_lft forever
>       inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
>          valid_lft forever preferred_lft forever
> 
>   # ip -6 addr del 2000::1/64 mngtmpaddr dev dummy1
>   # ip -6 addr show dev dummy1
> 
>   11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>       inet6 2000::81c9:56b7:f51a:b98f/64 scope global temporary dynamic
>          valid_lft 604797sec preferred_lft 86169sec
>       inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
>          valid_lft forever preferred_lft forever
> 
> This patch prevents this new 'global temporary dynamic' address from being
> created by the deletion of the related (same subnet prefix) 'mngtmpaddr'
> (which is triggered by there already being no temporary addresses).
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Fixes: 53bd67491537 ("ipv6 addrconf: introduce IFA_F_MANAGETEMPADDR to tell kernel to manage temporary addresses")
> Reported-by: Xiao Ma <xiaom@google.com>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> ---
>  net/ipv6/addrconf.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



