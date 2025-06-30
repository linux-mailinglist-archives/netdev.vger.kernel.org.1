Return-Path: <netdev+bounces-202312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7BAED232
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 03:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56457188D007
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF675464D;
	Mon, 30 Jun 2025 01:25:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5C10A3E;
	Mon, 30 Jun 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751246754; cv=none; b=dSleNqCDcjatQkyuhNpIcBNHDfhCtZC/A9gHBW4rqUAuVkU0ZtPW2KmcmwQqdDw/Bbah9vIAiO6rKzd+h/yTroH1IzGDQD8E4Yfz0rhFmrotVLeUNdChWmTyuN9hB9v8iTBK+nUJW79tyIVJ6gxfJpjGPuwzAVBiaXImhkPTA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751246754; c=relaxed/simple;
	bh=FLFEknDdG1ViuZpaZhGqjpsdBYyrzwXuoKQH+mAEiWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kJjWRGO5Z5g3y3nzgUACZu8F9+TBkidiZvDbkZAxiPNfy2gSywSi+d0ocUUInZk8v7j+LvigMko2zczC1bgV8ZG+AKaA7Sx4uGjZdSUuL5/jhXAyxCN+x+nz+OjOeIFD2YMH1oOQjqpolfk1yrexPKgptKumBEP0gUJt9I/wjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bVpJc4BSTz10XJG;
	Mon, 30 Jun 2025 09:21:04 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 065CC1402EB;
	Mon, 30 Jun 2025 09:25:44 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Jun 2025 09:25:44 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Jun 2025 09:25:42 +0800
Message-ID: <6ad61ca2-606b-4f1a-a811-47e5cfd48c38@huawei.com>
Date: Mon, 30 Jun 2025 09:25:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vlan: fix VLAN 0 refcount imbalance of toggling
 filtering during runtime
To: Ido Schimmel <idosch@idosch.org>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<jiri@resnulli.us>, <oscmaes92@gmail.com>, <linux@treblig.org>,
	<pedro.netdev@dondevamos.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20250623113008.695446-1-dongchenchen2@huawei.com>
 <20250624174252.7fbd3dbe@kernel.org>
 <900f28da-83db-4b17-b56b-21acde70e47f@huawei.com> <aF6tpb4EQaxZ2XAw@shredder>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <aF6tpb4EQaxZ2XAw@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Thu, Jun 26, 2025 at 11:41:45AM +0800, dongchenchen (A) wrote:
> As I understand it, there are two issues:
>
> 1. VID 0 is deleted when it shouldn't. This leads to the crashes you
> shared.
>
> 2. VID 0 is not deleted when it should. This leads to memory leaks like
> [1] with a reproducer such as [2].
>
> AFAICT, your proposed patch solves the second issue, but only partially
> addresses the first issue. The automatic addition of VID 0 is assumed to
> be successful, but it can fail due to hardware issues or memory
> allocation failures. I realize it is not common, but it can happen. If
> you annotate __vlan_vid_add() [3] and inject failures [4], you will see
> that the crashes still happen with your patch.

Hi, Ido
Thanks for your review!

> WDYT about something like [5]? Basically, noting in the VLAN info

This fix [5] can completely solve the problem. I will send it together 
with selftest patch.

> whether VID 0 was automatically added upon NETDEV_UP and based on that
> decide whether it should be deleted upon NETDEV_DOWN, regardless of
> "rx-vlan-filter".

one small additional question: vlan0 will not exist if netdev set rx-vlan-filter after NETDEV_UP.
Will this cause a difference in the processing logic for 8021q packets? 
Best regards Dong Chenchen

> [2]
> #!/bin/bash
>
> ip link add bond1 up type bond mode 0
> ethtool -K bond1 rx-vlan-filter off
> ip link del dev bond1
>
> [3]
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index 9404dd551dfd..6dc25c4877f2 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -314,6 +314,7 @@ static int __vlan_vid_add(struct vlan_info *vlan_info, __be16 proto, u16 vid,
>   	*pvid_info = vid_info;
>   	return 0;
>   }
> +ALLOW_ERROR_INJECTION(__vlan_vid_add, ERRNO);
>   
>   int vlan_vid_add(struct net_device *dev, __be16 proto, u16 vid)
>   {
>
> [4]
> #!/bin/bash
>
> echo __vlan_vid_add > /sys/kernel/debug/fail_function/inject
> printf %#x -12 > /sys/kernel/debug/fail_function/__vlan_vid_add/retval
> echo 100 > /sys/kernel/debug/fail_function/probability
> echo 1 > /sys/kernel/debug/fail_function/times
> echo 1 > /sys/kernel/debug/fail_function/verbose
> ip link add bond1 up type bond mode 0
> ip link add link bond1 name vlan0 type vlan id 0 protocol 802.1q
> ip link set dev bond1 down
> ip link del vlan0
> ip link del dev bond1
>
> [5]
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 06908e37c3d9..9a6df8c1daf9 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -357,6 +357,35 @@ static int __vlan_device_event(struct net_device *dev, unsigned long event)
>   	return err;
>   }
>   
> +static void vlan_vid0_add(struct net_device *dev)
> +{
> +	struct vlan_info *vlan_info;
> +	int err;
> +
> +	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
> +		return;
> +
> +	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);
> +
> +	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
> +	if (err)
> +		return;
> +
> +	vlan_info = rtnl_dereference(dev->vlan_info);
> +	vlan_info->auto_vid0 = true;
> +}
> +
> +static void vlan_vid0_del(struct net_device *dev)
> +{
> +	struct vlan_info *vlan_info = rtnl_dereference(dev->vlan_info);
> +
> +	if (!vlan_info || !vlan_info->auto_vid0)
> +		return;
> +
> +	vlan_info->auto_vid0 = false;
> +	vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
> +}
> +
>   static int vlan_device_event(struct notifier_block *unused, unsigned long event,
>   			     void *ptr)
>   {
> @@ -378,15 +407,10 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
>   			return notifier_from_errno(err);
>   	}
>   
> -	if ((event == NETDEV_UP) &&
> -	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
> -		pr_info("adding VLAN 0 to HW filter on device %s\n",
> -			dev->name);
> -		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
> -	}
> -	if (event == NETDEV_DOWN &&
> -	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
> -		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
> +	if (event == NETDEV_UP)
> +		vlan_vid0_add(dev);
> +	else if (event == NETDEV_DOWN)
> +		vlan_vid0_del(dev);
>   
>   	vlan_info = rtnl_dereference(dev->vlan_info);
>   	if (!vlan_info)
> diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
> index 5eaf38875554..c7ffe591d593 100644
> --- a/net/8021q/vlan.h
> +++ b/net/8021q/vlan.h
> @@ -33,6 +33,7 @@ struct vlan_info {
>   	struct vlan_group	grp;
>   	struct list_head	vid_list;
>   	unsigned int		nr_vids;
> +	bool			auto_vid0;
>   	struct rcu_head		rcu;
>   };
>

