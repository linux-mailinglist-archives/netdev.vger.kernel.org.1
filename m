Return-Path: <netdev+bounces-234135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5FC1D003
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0FA3BF4D8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543913563DA;
	Wed, 29 Oct 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YQI9gRm6"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B028A704
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766120; cv=none; b=nF3YibNR6NJ2JaF3LymSMJrvV2SfjE5Xyfd3E28sNF6thRIWShx+PI1df7uoH4QJsA/SQG2x3uhyHYZ7OTuOa2Q0YvXuF0PQ0qLpVuSJKlSrmm+prgsFffRm9pF2KVpnZaOcS+Gf7T22x/w7in4LzhYw0u0znFWZcU1El4/D9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766120; c=relaxed/simple;
	bh=fU6xgrz9SAUr3d0giA8VMjk5cn1m3CdR+l6cyZzTx6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eedwh0j3jvwnA9YcKP+oazEbUSnL4uVLi7PKiHaef/rM6c/mCd/c9E3GU+Ac3IfuMiH/pcKB/ca3tQMFJqzE3A1mwqAQVyv0qe38RWuSpVI9t2vk8GCL8ddoyLK7MAdNSgqADpdtT9Sfsjl+uLkVxQOXQxcDq6OxB2qkRfi0lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YQI9gRm6; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761766115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76a6h3KK7ED1ZCKb1Hx0rF+dSuEgbWH0hrQ/nz0xYnU=;
	b=YQI9gRm6tFD7iQp621k9PbsyyHpF9hDCLRYOKK8nA+Y3dlK0/1ulqxV3IAnHAbkMZ853oi
	A8rde/e3tOhdHzUH1ZHFFW0PxCl1EPpNsanYWIk0t0YP4ovhb+cz+IA20gwzG7E/fglWtc
	PrEah+4POiLP3Jl6VUAvFi4sgoIbYlQ=
Date: Wed, 29 Oct 2025 19:28:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Linux Kernel Bug] KASAN: null-ptr-deref Read in
 generic_hwtstamp_ioctl_lower
To: Kory Maincent <kory.maincent@bootlin.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jiaming Zhang <r772577952@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 linux-kernel@vger.kernel.org, sdf@fomichev.me, syzkaller@googlegroups.com
References: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
 <20251029110651.25c4936d@kmaincent-XPS-13-7390>
 <20251029161934.xwxzqoknqmwtrsgv@skbuf>
 <20251029174740.0f064865@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251029174740.0f064865@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2025 16:47, Kory Maincent wrote:
> On Wed, 29 Oct 2025 18:19:34 +0200
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> 
>> On Wed, Oct 29, 2025 at 11:06:51AM +0100, Kory Maincent wrote:
>>> Hello Jiaming,
>>>
>>> +Vlad
>>>
>>> On Wed, 29 Oct 2025 16:45:37 +0800
>>> Jiaming Zhang <r772577952@gmail.com> wrote:
>>>    
>>>> Dear Linux kernel developers and maintainers,
>>>>
>>>> We are writing to report a null pointer dereference bug discovered in
>>>> the net subsystem. This bug is reproducible on the latest version
>>>> (v6.18-rc3, commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa).
>>>>
>>>> The root cause is in tsconfig_prepare_data(), where a local
>>>> kernel_hwtstamp_config struct (cfg) is initialized using {}, setting
>>>> all its members to zero. Consequently, cfg.ifr becomes NULL.
>>>>
>>>> cfg is then passed as: tsconfig_prepare_data() ->
>>>> dev_get_hwtstamp_phylib() -> vlan_hwtstamp_get() (via
>>>> dev->netdev_ops->ndo_hwtstamp_get) -> generic_hwtstamp_get_lower() ->
>>>> generic_hwtstamp_ioctl_lower().
>>>>
>>>> The function generic_hwtstamp_ioctl_lower() assumes cfg->ifr is a
>>>> valid pointer and attempts to access cfg->ifr->ifr_ifru. This access
>>>> dereferences the NULL pointer, triggering the bug.
>>>
>>> Thanks for spotting this issue!
>>>
>>> In the ideal world we would have all Ethernet driver supporting the
>>> hwtstamp_get/set NDOs but that not currently the case.	
>>> Vladimir Oltean was working on this but it is not done yet.
>>> $ git grep SIOCGHWTSTAMP drivers/net/ethernet | wc -l
>>> 16
>>
>> Vadim also took the initiative and submitted (is still submitting?) some
>> more conversions, whereas I lost all steam.
> 
> Ok no worry I was simply pointing this out, people will convert it when they
> want to use the new netlink API.
>   
>>>> As a potential fix, we can declare a local struct ifreq variable in
>>>> tsconfig_prepare_data(), zero-initializing it, and then assigning its
>>>> address to cfg.ifr before calling dev_get_hwtstamp_phylib(). This
>>>> ensures that functions down the call chain receive a valid pointer.
>>>
>>> If we do that we will have legacy IOCTL path inside the Netlink path and
>>> that's not something we want.
>>> In fact it is possible because the drivers calling
>>> generic_hwtstamp_get/set_lower functions are already converted to hwtstamp
>>> NDOs therefore the NDO check in tsconfig_prepare_data is not working on
>>> these case.
>>
>> I remember we had this discussion before.
>>
>> | This is why I mentioned by ndo_hwtstamp_set() conversion, because
>> | suddenly it is a prerequisite for any further progress to be done.
>> | You can't convert SIOCSHWTSTAMP to netlink if there are some driver
>> | implementations which still use ndo_eth_ioctl(). They need to be
>> | UAPI-agnostic.
>>
>> https://lore.kernel.org/netdev/20231122140850.li2mvf6tpo3f2fhh@skbuf/
>>
>> I'm not sure what was your agreement with the netdev maintainer
>> accepting the tsconfig netlink work with unconverted device drivers left
>> in the tree.
> 
> I did like 21th versions and there was not many people active in the reviews.
> No one stand against this work.
> 
>>> IMO the solution is to add a check on the ifr value in the
>>> generic_hwtstamp_set/get_lower functions like that:
>>>
>>> int generic_hwtstamp_set_lower(struct net_device *dev,
>>> 			       struct kernel_hwtstamp_config *kernel_cfg,
>>> 			       struct netlink_ext_ack *extack)
>>> {
>>> ...
>>>
>>> 	/* Netlink path with unconverted lower driver */
>>> 	if (!kernel_cfg->ifr)
>>> 		return -EOPNOTSUPP;
>>>
>>> 	/* Legacy path: unconverted lower driver */
>>> 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
>>> }
>>
>> This plugs one hole (two including _get). How many more are there? If
>> this is an oversight, the entire tree needs to be reviewed for
>> ndo_hwtstamp_get() / ndo_hwtstamp_test() pointer tests which were used
>> as an indication that this net device is netlink ready. Stacked
>> virtual interfaces are netlink-ready only when the entire chain down to
>> the physical interface is netlink-ready.
> 
> I don't see this as a hole. The legacy ioctl path still works.
> If people want to use the new Netlink path on their board, yes they need to
> convert all the parts of the chain to hwtstamp NDOs. If they don't they will
> get now a EOPNOTSUPP error instead of a null pointer dereference koops.

I agree with Kory - we don't have many spots in the code calling HW
timestamping configuration. The ones to check is actually phy code and
can drivers. But anyways, we have this interface exposed to UAPI, and we
have ethtool with supports it already. And there is a bug, which can be
fixed with the proposed code.

I'm working right now to finish conversion by the end of this term, both
can and phy will be switched to new API as well as mlx5/ti_netcp
ethernet drivers.

