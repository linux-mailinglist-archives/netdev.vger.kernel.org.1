Return-Path: <netdev+bounces-143523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E039C2DF8
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807FC282923
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944441448F2;
	Sat,  9 Nov 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QihDLrrq"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772D1DFFC
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164471; cv=none; b=NXWJp5Z60S8pqO/zSqCeWeTnLcYiKPxU1pw2CQ4x7E4QtHiJgsim3EH8PavTmPJ8NCJjhNdwMUk28jnxHU3Omkx+jwaKXM25sRirdSvQ25Utb3fsXisrvk/ySTwr9U7fdurKIqMivVoNulFdt+ArmRQGMppBsYj38mTci/vYLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164471; c=relaxed/simple;
	bh=xjHYBzkNA2QJLik1N/FyRGPsd69C2yjVqwnGcZlqljY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GbGdYcJ5gy2v1lcU7jDxOZB9eLS/n+bl7BGGEnvYDiz6Ff545FxaFpqh7+LscMHY8fJgx6/bOfKjn3yzUnsKdikToQ4IO9Jv8EvEMLGF/Yr73N3OG4THOHry5UUlnynNWFtOIrrkqboyIRcrl9f5UcInXnnfFQNus1mTQqycaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QihDLrrq; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea009a4a-c9f2-4843-b84d-e6b72982228e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731164463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBWdaYY7oZil/8F5g5wMNbyVFHwPk9nYWDS+2FprxqI=;
	b=QihDLrrqNl0mmlpA31ADFLZbPSba3/Dsm/fcTEaoeyeceq4Q5G+/alt6FuneNFpoAsdf2V
	k8Y6xaioukzDITmvYXb7oYyWQbauwJ5qrQIRNRW8/o6qjstmYLFyNLnAHn9VoTHNo5LBya
	R0KvFtPaXey9K6rlEju9vRCbcYqSFRA=
Date: Sat, 9 Nov 2024 15:00:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
To: Gilad Naaman <gnaaman@drivenets.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20241108052559.2926114-1-gnaaman@drivenets.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241108052559.2926114-1-gnaaman@drivenets.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/11/2024 05:25, Gilad Naaman wrote:
> struct inet6_dev already has a list of addresses owned by the device,
> enabling us to traverse this much shorter list, instead of scanning
> the entire hash-table.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
> Changes in v2:
>   - Remove double BH sections
>   - Styling fixes (extra {}, extra newline)
> ---
>   net/ipv6/addrconf.c | 38 +++++++++++++++++---------------------
>   1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index d0a99710d65d..c6fbd634912a 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3846,12 +3846,12 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>   {
>   	unsigned long event = unregister ? NETDEV_UNREGISTER : NETDEV_DOWN;
>   	struct net *net = dev_net(dev);
> -	struct inet6_dev *idev;
>   	struct inet6_ifaddr *ifa;
>   	LIST_HEAD(tmp_addr_list);
> +	struct inet6_dev *idev;
>   	bool keep_addr = false;
>   	bool was_ready;
> -	int state, i;
> +	int state;
>   
>   	ASSERT_RTNL();
>   
> @@ -3890,28 +3890,24 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>   	}
>   
>   	/* Step 2: clear hash table */
> -	for (i = 0; i < IN6_ADDR_HSIZE; i++) {
> -		struct hlist_head *h = &net->ipv6.inet6_addr_lst[i];
> +	read_lock_bh(&idev->lock);
 > +	spin_lock(&net->ipv6.addrconf_hash_lock);>
> -		spin_lock_bh(&net->ipv6.addrconf_hash_lock);
> -restart:
> -		hlist_for_each_entry_rcu(ifa, h, addr_lst) {
> -			if (ifa->idev == idev) {
> -				addrconf_del_dad_work(ifa);
> -				/* combined flag + permanent flag decide if
> -				 * address is retained on a down event
> -				 */
> -				if (!keep_addr ||
> -				    !(ifa->flags & IFA_F_PERMANENT) ||
> -				    addr_is_local(&ifa->addr)) {
> -					hlist_del_init_rcu(&ifa->addr_lst);
> -					goto restart;
> -				}
> -			}
> -		}
> -		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
> +	list_for_each_entry(ifa, &idev->addr_list, if_list) {
> +		addrconf_del_dad_work(ifa);
> +
> +		/* combined flag + permanent flag decide if
> +		 * address is retained on a down event
> +		 */
> +		if (!keep_addr ||
> +		    !(ifa->flags & IFA_F_PERMANENT) ||
> +		    addr_is_local(&ifa->addr))
> +			hlist_del_init_rcu(&ifa->addr_lst);
>   	}
>   
> +	spin_unlock(&net->ipv6.addrconf_hash_lock);
> +	read_unlock_bh(&idev->lock);

Why is this read lock needed here? spinlock addrconf_hash_lock will
block any RCU grace period to happen, so we can safely traverse
idev->addr_list with list_for_each_entry_rcu()...

> +
>   	write_lock_bh(&idev->lock);

if we are trying to protect idev->addr_list against addition, then we
have to extend write_lock scope. Otherwise it may happen that another
thread will grab write lock between read_unlock and write_lock.

Am I missing something?

