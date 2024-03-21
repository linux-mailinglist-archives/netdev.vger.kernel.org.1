Return-Path: <netdev+bounces-81055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3D885977
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E183281F78
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B483CC4;
	Thu, 21 Mar 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pPc+IfHR"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F383CB7
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025812; cv=none; b=Y0QHN0Ood5cdcn0Okb+L237mvpWFcIJF1L4JnZfFXjRJK+MToNgQI1OZnkOFpfxA9MMbLJiNanOSKZAfYTk3kFx8mCFD8vwZip6pEdS+4V0ezDoKykUh24vF0FtZrhV47RWUTqTNyFZ09jZw7jK4rL3X1cgUGSIYKczuSyOvkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025812; c=relaxed/simple;
	bh=Ksx1B8S0HuTXY77hiHMqkey4XaIabz9nNjNx5yMCyeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgpWeeWx+GIAxPJ5UjOFJdzGwtuKAMw1IFmJSkXmWOTOUy3XuDXfYJr8zmG2ExHZmPBIkOC7HPnjS7OtbksmYBaZkEeDehm4GwKPPNDZH3MO5I1j1oyo+dRC1kMxiKN8qjI2QaRVJKHif4qKlj5NAsXofElJNjoj4A+M1h6SIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pPc+IfHR; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711025807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXohp44bVJqyA9VP99U4GSaIHGvh6261AUTii/uNcwA=;
	b=pPc+IfHRjTUQXqaF1xnn0n8NOiZnClXRhJ6USlcGAc0lZdRH6uu2Gr4VMxI9yYvWABcmLg
	50GuzCPE5SHZjOCfGNnwJFW3kWFoXAXKqSCgDq6KrDwWbhzgBOqUFQnvM0+VzYKdfib+yU
	2TmwAsNu5vrkcvRj3ZVCTMQTxfHFSvM=
Date: Thu, 21 Mar 2024 14:56:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 idosch@idosch.org, johannes@sipsolutions.net, fw@strlen.de,
 pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>,
 Paul Holzinger <pholzing@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org> <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20240319104046.203df045@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/03/2024 19:40, Jakub Kicinski wrote:
> On Tue, 19 Mar 2024 18:17:47 +0100 Eric Dumazet wrote:
>>> Hi Stefano! I was worried this may happen :( I think we should revert
>>> offending commits, but I'd like to take it on case by case basis.
>>> I'd imagine majority of netlink is only exercised by iproute2 and
>>> libmnl-based tools. Does passt hang specifically on genetlink family
>>> dump? Your commit also mentions RTM_GETROUTE. This is not the only
>>> commit which removed DONE:
>>>
>>> $ git log --since='1 month ago' --grep=NLMSG_DONE --no-merges  --oneline
>>>
>>> 9cc4cc329d30 ipv6: use xa_array iterator to implement inet6_dump_addr()
>>> 87d381973e49 genetlink: fit NLMSG_DONE into same read() as families
>>> 4ce5dc9316de inet: switch inet_dump_fib() to RCU protection
>>> 6647b338fc5c netlink: fix netlink_diag_dump() return value  
>>
>> Lets not bring back more RTNL locking please for the handlers that
>> still require it.
> 
> Definitely. My git log copy/paste is pretty inaccurate, these two are
> better examples:
> 
> 5d9b7cb383bb nexthop: Simplify dump error handling
> 02e24903e5a4 netlink: let core handle error cases in dump operations
> 
> I was trying to point out that we merged a handful of DONE "coalescing"
> patches, and if we need to revert - let's only do that for the exact
> commands needed. The comment was raised on my genetlink patch while
> the discussion in the link points to RTM_GETROUTE.
> 
>> The core can generate an NLMSG_DONE by itself, if we decide this needs
>> to be done.
> 
> Exactly.
> 

We've encountered a new issue recently which I believe is related to
this discussion.

Following Eric's patch:
9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump_addr()")

Setting the interface mtu to < 1280 results in 'ip addr show eth2'
returning an error, because the ipv6 dump fails. This is a degradation
from the user's perspective.

# ip addr show eth2
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
default qlen 1000
    link/ether 24:42:53:21:52:44 brd ff:ff:ff:ff:ff:ff
    altname enp6s0f0np0
# ip link set dev eth2 mtu 1000
# ip addr show eth2
RTNETLINK answers: No such device
Dump terminated

