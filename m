Return-Path: <netdev+bounces-127680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DDC97616A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328ED281EEA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B378188A00;
	Thu, 12 Sep 2024 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SzZ7v/Ho"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AA12D20D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122060; cv=none; b=Av/s1uX6Zy4InlRB3mvXz+m6Q1wZ4/ZKYNiq/tnUlXl2wyu2V6yLM5nDM7FzmvKqb22zF0uBbVbJo2DdbDyN9tYaE5cPuSGFFJXJWVb4zydPu80EdDzVFQwbj8hGypoFGg7PM6jdblhzFWubj4kQpkXnOZKgbqaNo76M2ZTcwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122060; c=relaxed/simple;
	bh=gzbSoPirbdV6OvBwyuWqLFshkq7xcrFRuE660vVWxGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLgUjrH5tzWbgUw8CGCS8hxm6Whw0Y+kICgG+LWC2LncOIDbIZdwVQ/Wjf89dkLnAQH6VCVR4KAnMnD3pmjaOA3EWj9CDZ9+xbCrDwJfzIDJ3nJTmpxCmJaTevt2lWkja5O7I/o12aHlec0KhdbD7tETuRJ3xj8NpUQ/fN7PRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SzZ7v/Ho; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726122049; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=59yYUrpUy3/4Te83JX89VyLwpxLKMTv2A1pEy9jghpc=;
	b=SzZ7v/HoyxGjfOZIiy5k8fFrqbwJ1t8DIMTV/ohEiLnFdGf/RZf9Z4JqyHBTCPdVKQbPBfcfRYrkWpOWLSAuXlWz+w9KE6ffd0/Z+8SndJQ7c9amjc3EH2nqaabCd89rkvnSzSTGNQYvIg/3UjA09ZffWYRkGvSvP1pSK/w/8ik=
Received: from 30.221.149.207(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WEqHQH5_1726122047)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 14:20:48 +0800
Message-ID: <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
Date: Thu, 12 Sep 2024 14:20:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
 syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/24 8:04 AM, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
> RCU version, which are netdev_walk_all_lower_dev_rcu() and
> netdev_next_lower_dev_rcu(). Switching to the RCU version would
> eliminate the need for RTL lock, thus could amend the deadlock
> complaints from syzbot. And it could also potentially speed up its
> callers like smc_connect().
> 
> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Jan Karcher <jaka@linux.ibm.com>
> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> Cc: Tony Lu <tonylu@linux.alibaba.com>
> Cc: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>


Haven't looked at your code yet, but the issue you fixed doesn't exist.
The real reason is that we lacks some lockdep annotations for
IPPROTO_SMC.

Thanks,
D. Wythe

> ---
>   net/smc/smc_core.c |  6 +++---
>   net/smc/smc_pnet.c | 14 +++++++-------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 3b95828d9976..574039b7d456 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1850,9 +1850,9 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
>   	}
>   
>   	priv.data = (void *)&ini->vlan_id;
> -	rtnl_lock();
> -	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
> -	rtnl_unlock();
> +	rcu_read_lock();
> +	netdev_walk_all_lower_dev_rcu(ndev, smc_vlan_by_tcpsk_walk, &priv);
> +	rcu_read_unlock();
>   
>   out_rel:
>   	dst_release(dst);
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 2adb92b8c469..b8ee6da08638 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -29,7 +29,6 @@
>   #include "smc_ism.h"
>   #include "smc_core.h"
>   
> -static struct net_device *__pnet_find_base_ndev(struct net_device *ndev);
>   static struct net_device *pnet_find_base_ndev(struct net_device *ndev);
>   
>   static const struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
> @@ -791,7 +790,7 @@ static void smc_pnet_add_base_pnetid(struct net *net, struct net_device *dev,
>   {
>   	struct net_device *base_dev;
>   
> -	base_dev = __pnet_find_base_ndev(dev);
> +	base_dev = pnet_find_base_ndev(dev);
>   	if (base_dev->flags & IFF_UP &&
>   	    !smc_pnetid_by_dev_port(base_dev->dev.parent, base_dev->dev_port,
>   				    ndev_pnetid)) {
> @@ -857,7 +856,7 @@ static int smc_pnet_netdev_event(struct notifier_block *this,
>   		smc_pnet_add_base_pnetid(net, event_dev, ndev_pnetid);
>   		return NOTIFY_OK;
>   	case NETDEV_DOWN:
> -		event_dev = __pnet_find_base_ndev(event_dev);
> +		event_dev = pnet_find_base_ndev(event_dev);
>   		if (!smc_pnetid_by_dev_port(event_dev->dev.parent,
>   					    event_dev->dev_port, ndev_pnetid)) {
>   			/* remove from PNETIDs list */
> @@ -925,7 +924,6 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
>   {
>   	int i, nest_lvl;
>   
> -	ASSERT_RTNL();
>   	nest_lvl = ndev->lower_level;
>   	for (i = 0; i < nest_lvl; i++) {
>   		struct list_head *lower = &ndev->adj_list.lower;
> @@ -933,7 +931,9 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
>   		if (list_empty(lower))
>   			break;
>   		lower = lower->next;
> -		ndev = netdev_lower_get_next(ndev, &lower);
> +		ndev = netdev_next_lower_dev_rcu(ndev, &lower);
> +		if (!ndev)
> +			break;
>   	}
>   	return ndev;
>   }
> @@ -945,9 +945,9 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
>    */
>   static struct net_device *pnet_find_base_ndev(struct net_device *ndev)
>   {
> -	rtnl_lock();
> +	rcu_read_lock();
>   	ndev = __pnet_find_base_ndev(ndev);
> -	rtnl_unlock();
> +	rcu_read_unlock();
>   	return ndev;
>   }
>   

