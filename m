Return-Path: <netdev+bounces-214581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E12B2A740
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091627BA488
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F38335BCB;
	Mon, 18 Aug 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4psvdXX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C9335BA8;
	Mon, 18 Aug 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524859; cv=none; b=lBU9SEoc1tgy94AcN7rh7KDZZ1V0agKyYhRi5yhYV1WGKE+VeKnbMI32dqvK7PSF8KDB0rF5NNpiyyfcToXkcRV9+3xnjBBYBdNvFbFnxIhzV1LHigx7DrHOAj1761JOkKlFlePz+CESY6eZyhfnIY00DAy+3vyWtqYQfIG55mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524859; c=relaxed/simple;
	bh=vRACgjgJMbZR8+OV3u93aA86G8reKGFk4q8Di30Ksbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5AOfDpte1yboNfX7BhCyl+3ylz47WzE/zDmFNO6HpS1/pfuRqhY6ypiDWzy2GqliPKSsa02IHbcxxAMAn8zIShkk1kbd5LIwbZt+7ImDPWR+vOdiEyZ2iBcYYjlIIwQxypikw7YFO7DlQUbdx/8LPCsqL/dsasRAyXzW+Q2d0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4psvdXX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755524857; x=1787060857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vRACgjgJMbZR8+OV3u93aA86G8reKGFk4q8Di30Ksbk=;
  b=H4psvdXXdLI9+i53vdUjgYKbuNuhdXHSLN2lg8SeDF1w5r3nuT+mqYzF
   3skm5RkLE0u8Wp6Q7KV+vGgrwMiC6ao7IX+S5ey3qxapXgZPTTsCbzx91
   5NYPrbv+ecgbOV1+zg+YOBR1MVOfwgtsIHbyRXDiBsj7N34BW6CNIh1bF
   QC+7LsNrZzjQFAMGiInH1uqZPPMrCIYNk3gbm2qyYivj0AjuvIY5qAvAr
   qbhcc6PQBIToyJN33pJPcLPkZGcBlhKtXbMuhX3oMHAok4u9reERhztw1
   JiFKspdHOD9KlArso7Jr7yNc5eRENYXIOae7BNVL0jNlRc1fURr5KCCZe
   A==;
X-CSE-ConnectionGUID: lj/e7lnCQTmL9R7xgd6MQQ==
X-CSE-MsgGUID: 9sJpeBHzSs+WQIlnRZ1ndw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="56952722"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="56952722"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 06:47:37 -0700
X-CSE-ConnectionGUID: WJTJ/HpFQf6P0s0jJC0FSg==
X-CSE-MsgGUID: A20GVXMCSKmulLd93mKrTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167087218"
Received: from domelchx-mobl2.ger.corp.intel.com (HELO [10.246.2.169]) ([10.246.2.169])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 06:47:34 -0700
Message-ID: <739c6d25-7421-4f8f-bb61-f613a1c8b3ce@linux.intel.com>
Date: Mon, 18 Aug 2025 15:47:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next] ipv6: mcast: Add ip6_mc_find_idev()
 helper
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818101051.892443-1-yuehaibing@huawei.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250818101051.892443-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-18 12:10 PM, Yue Haibing wrote:
> __ipv6_sock_mc_join() has the same code as ip6_mc_find_dev() to find dev,
> extract this into ip6_mc_find_dev() and add ip6_mc_find_idev() to reduce
> code duplication and improve readability.

nit: the commit msg is a tad bit confusing

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Regardless of the nit above,

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

> ---
>   net/ipv6/mcast.c | 76 ++++++++++++++++++++++--------------------------
>   1 file changed, 35 insertions(+), 41 deletions(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 36ca27496b3c..75430ad55c3d 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -169,6 +169,29 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
>   	return iv > 0 ? iv : 1;
>   }
>   
> +static struct net_device *ip6_mc_find_dev(struct net *net,
> +					  const struct in6_addr *group,
> +					  int ifindex)
> +{
> +	struct net_device *dev = NULL;
> +	struct rt6_info *rt;
> +
> +	if (ifindex == 0) {
> +		rcu_read_lock();
> +		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
> +		if (rt) {
> +			dev = dst_dev(&rt->dst);
> +			dev_hold(dev);
> +			ip6_rt_put(rt);
> +		}
> +		rcu_read_unlock();
> +	} else {
> +		dev = dev_get_by_index(net, ifindex);
> +	}
> +
> +	return dev;
> +}
> +
>   /*
>    *	socket join on multicast group
>    */
> @@ -191,28 +214,13 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
>   	}
>   
>   	mc_lst = sock_kmalloc(sk, sizeof(struct ipv6_mc_socklist), GFP_KERNEL);
> -
>   	if (!mc_lst)
>   		return -ENOMEM;
>   
>   	mc_lst->next = NULL;
>   	mc_lst->addr = *addr;
>   
> -	if (ifindex == 0) {
> -		struct rt6_info *rt;
> -
> -		rcu_read_lock();
> -		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
> -		if (rt) {
> -			dev = dst_dev(&rt->dst);
> -			dev_hold(dev);
> -			ip6_rt_put(rt);
> -		}
> -		rcu_read_unlock();
> -	} else {
> -		dev = dev_get_by_index(net, ifindex);
> -	}
> -
> +	dev = ip6_mc_find_dev(net, addr, ifindex);
>   	if (!dev) {
>   		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
>   		return -ENODEV;
> @@ -302,32 +310,18 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
>   }
>   EXPORT_SYMBOL(ipv6_sock_mc_drop);
>   
> -static struct inet6_dev *ip6_mc_find_dev(struct net *net,
> -					 const struct in6_addr *group,
> -					 int ifindex)
> +static struct inet6_dev *ip6_mc_find_idev(struct net *net,
> +					  const struct in6_addr *group,
> +					  int ifindex)
>   {
> -	struct net_device *dev = NULL;
> -	struct inet6_dev *idev;
> -
> -	if (ifindex == 0) {
> -		struct rt6_info *rt;
> +	struct inet6_dev *idev = NULL;
> +	struct net_device *dev;
>   
> -		rcu_read_lock();
> -		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
> -		if (rt) {
> -			dev = dst_dev(&rt->dst);
> -			dev_hold(dev);
> -			ip6_rt_put(rt);
> -		}
> -		rcu_read_unlock();
> -	} else {
> -		dev = dev_get_by_index(net, ifindex);
> +	dev = ip6_mc_find_dev(net, group, ifindex);
> +	if (dev) {
> +		idev = in6_dev_get(dev);
> +		dev_put(dev);
>   	}
> -	if (!dev)
> -		return NULL;
> -
> -	idev = in6_dev_get(dev);
> -	dev_put(dev);
>   
>   	return idev;
>   }
> @@ -374,7 +368,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
>   	if (!ipv6_addr_is_multicast(group))
>   		return -EINVAL;
>   
> -	idev = ip6_mc_find_dev(net, group, pgsr->gsr_interface);
> +	idev = ip6_mc_find_idev(net, group, pgsr->gsr_interface);
>   	if (!idev)
>   		return -ENODEV;
>   
> @@ -509,7 +503,7 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
>   	    gsf->gf_fmode != MCAST_EXCLUDE)
>   		return -EINVAL;
>   
> -	idev = ip6_mc_find_dev(net, group, gsf->gf_interface);
> +	idev = ip6_mc_find_idev(net, group, gsf->gf_interface);
>   	if (!idev)
>   		return -ENODEV;
>   


