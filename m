Return-Path: <netdev+bounces-128950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFA97C8C7
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90E71F23708
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7419D06B;
	Thu, 19 Sep 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Fy/IkPJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99119C57B
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747076; cv=none; b=VwD+3rrRfIXUjsRXtx0IXIj9qpWSyLJi9UlichBM0g0rIVBIfCmLSNoup5fknStOGiDys+hPTZ/DaztmsZzeiD8v1VkJBDiWkAsaAhNVuAeAWqUGQjxA11iaqZUDIYpncnT7gzzkTr9sWDmT+JD4JYdKjnb2xq9H61IjLBsqRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747076; c=relaxed/simple;
	bh=tUSAApJsR6bjbekHWxd0HmaGyhBk+7hBy4H/bL9w1tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCd7PSMlkQU8IrcvqviVrRWILJOb+XDk1VVKPHTm5MgR85VMkxvbephNiM+/rwAsCZ9jqIMtYYoKKHiNOQ+VXevtxfF21P40HHezTbDAtGzMwyHIsmHdHjEcvRLdCLVuxGU1DgFrNLn8Dry3d0vsLNUlmdBBo9aXLUbACAruhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Fy/IkPJf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83562f9be9so83852866b.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726747072; x=1727351872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zwrW2Lc8dlR//tvccpuLEE6Q8LzaBUraS8Mxjz75Chc=;
        b=Fy/IkPJfnXoOx1keJR/SZoJpYt0cIYOkDF+OHMhSRXmUwf5dc+dZNHo5Oa9+jhnt2s
         SLX5+TPQtjkqqFtjkaaaUh3RuZ1Aj5AGVfsnl/HXCxWMenD1DPuO+nQn4ne26/ymjHjX
         C50UV2eUFFnXzCcm9HQB90ZpiEaXXqeKWDg+mCL+XxUzuObHB1xIYZtJEgeljg8et3H/
         MnDIMgGH+bAjDaIzy8VTLGNJzfsqMjXDl6iz+id+eISR3pZMi/z35OWgGeK+LLPJ50EF
         nQbt8Wv+sXOVuLKfCeMgyMpK7ekPDiGYFf/9p/+MT2s09d6/jGSCU0kqKwlSndDAiFsT
         KTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726747072; x=1727351872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwrW2Lc8dlR//tvccpuLEE6Q8LzaBUraS8Mxjz75Chc=;
        b=WB9Hh4DJNq25dtuCRUr/LyHNVQkYf5TvkG9IxVLi0LOoiDBuPtIEvb2SkM7BqRMO7p
         Ri50o2BOEwblg4PVULrA7TLmWwqqn6JA/M4z9uVLmX1s+MvKfg79dLBy+3wzY1s2yqMf
         oDKWVx+dZTMJvEOtn2H9d7POj4XSxqSP/eAc56V9aUQbuRw/E577cBybu09JDZU6EtPz
         U+lZiBKNdP74ITOdal6HJiG/H/3QFrLIR4FrFKJYnqgwLjBaV7M1/8px4iA0gBNLGkOd
         6iSR4phIKpJNo/WrjMMERXeCo6SI+hSBJAVjSr96QqDrmJRsS+XES/o4JDbfaefx5ifz
         o9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUoJTE3QhpavzsLT1122/7qo6u8C780wpJW8ZZc6dP642h533HUOQmtKeU/Xi5r2FEAOKgYUNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYq+rdgP/Ew1icKASfUOdjI678rimtJMnfq1lT9T4d0jw404N
	Sjm6DwET3W7JxNskVvxhCHeAt4QOAGs/AH2c4d06Hgw+rD0lacHc9GN4idh1r3I=
X-Google-Smtp-Source: AGHT+IHQpQzHc1cIXN31U3ZoomqTuQNLNx77DCvWceGy2dZ0tN3IaP9KotCwGRWYaqVtQj58XgSiSA==
X-Received: by 2002:a17:907:2cc5:b0:a8d:55ce:fb86 with SMTP id a640c23a62f3a-a902966f593mr2423044066b.57.1726747072099;
        Thu, 19 Sep 2024 04:57:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:fece:3c82:bfdf:c36f? ([2001:67c:2fbc:1:fece:3c82:bfdf:c36f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4438sm712756666b.51.2024.09.19.04.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 04:57:51 -0700 (PDT)
Message-ID: <a10dcebf-b8f1-4d9b-b417-cca7d0330e52@openvpn.net>
Date: Thu, 19 Sep 2024 13:57:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew@lunn.ch, antony.antony@secunet.com, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, sd@queasysnail.net, steffen.klassert@secunet.com
References: <20240917010734.1905-4-antonio@openvpn.net>
 <20240919055259.17622-1-kuniyu@amazon.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240919055259.17622-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kuniyuki and thank you for chiming in.

On 19/09/2024 07:52, Kuniyuki Iwashima wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
> Date: Tue, 17 Sep 2024 03:07:12 +0200
>> +/* we register with rtnl to let core know that ovpn is a virtual driver and
>> + * therefore ifaces should be destroyed when exiting a netns
>> + */
>> +static struct rtnl_link_ops ovpn_link_ops = {
>> +};
> 
> This looks like abusing rtnl_link_ops.

In some way, the inspiration came from
5b9e7e160795 ("openvswitch: introduce rtnl ops stub")

[which just reminded me that I wanted to fill the .kind field, but I 
forgot to do so]

The reason for taking this approach was to avoid handling the iface 
destruction upon netns exit inside the driver, when the core already has 
all the code for taking care of this for us.

Originally I implemented pernet_operations.pre_exit, but Sabrina 
suggested that letting the core handle the destruction was cleaner (and 
I agreed).

However, after I removed the pre_exit implementation, we realized that 
default_device_exit_batch/default_device_exit_net thought that an ovpn 
device is a real NIC and was moving it to the global netns rather than 
killing it.

One way to fix the above was to register rtnl_link_ops with netns_fund = 
false (so the ops object you see in this patch is not truly "empty").

However, I then hit the bug which required patch 2 to get fixed.

Does it make sense to you?
Or you still think this is an rtnl_link_ops abuse?

The alternative was to change 
default_device_exit_batch/default_device_exit_net to read some new 
netdevice flag which would tell if the interface should be killed or 
moved to global upon netns exit.

Regards,

> 
> Instead of a hack to rely on default_device_exit_batch()
> and rtnl_link_unregister(), this should be implemented as
> struct pernet_operations.exit_batch_rtnl().
> 
> Then, the patch 2 is not needed, which is confusing for
> all other rtnl_link_ops users.
> 
> If we want to avoid extra RTNL in default_device_exit_batch(),
> I can post this patch after merge window.
> 
> ---8<---
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1e740faf9e78..eacf6f5a6ace 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11916,7 +11916,8 @@ static void __net_exit default_device_exit_net(struct net *net)
>   	}
>   }
>   
> -static void __net_exit default_device_exit_batch(struct list_head *net_list)
> +void __net_exit default_device_exit_batch(struct list_head *net_list,
> +					  struct list_head *dev_kill_list)
>   {
>   	/* At exit all network devices most be removed from a network
>   	 * namespace.  Do this in the reverse order of registration.
> @@ -11925,9 +11926,7 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
>   	 */
>   	struct net_device *dev;
>   	struct net *net;
> -	LIST_HEAD(dev_kill_list);
>   
> -	rtnl_lock();
>   	list_for_each_entry(net, net_list, exit_list) {
>   		default_device_exit_net(net);
>   		cond_resched();
> @@ -11936,19 +11935,13 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
>   	list_for_each_entry(net, net_list, exit_list) {
>   		for_each_netdev_reverse(net, dev) {
>   			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
> -				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
> +				dev->rtnl_link_ops->dellink(dev, dev_kill_list);
>   			else
> -				unregister_netdevice_queue(dev, &dev_kill_list);
> +				unregister_netdevice_queue(dev, dev_kill_list);
>   		}
>   	}
> -	unregister_netdevice_many(&dev_kill_list);
> -	rtnl_unlock();
>   }
>   
> -static struct pernet_operations __net_initdata default_device_ops = {
> -	.exit_batch = default_device_exit_batch,
> -};
> -
>   static void __init net_dev_struct_check(void)
>   {
>   	/* TX read-mostly hotpath */
> @@ -12140,9 +12133,6 @@ static int __init net_dev_init(void)
>   	if (register_pernet_device(&loopback_net_ops))
>   		goto out;
>   
> -	if (register_pernet_device(&default_device_ops))
> -		goto out;
> -
>   	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
>   	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
>   
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 5654325c5b71..d1feecab9c4a 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -99,6 +99,9 @@ void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
>   void unregister_netdevice_many_notify(struct list_head *head,
>   				      u32 portid, const struct nlmsghdr *nlh);
>   
> +void default_device_exit_batch(struct list_head *net_list,
> +			       struct list_head *dev_kill_list);
> +
>   static inline void netif_set_gso_max_size(struct net_device *dev,
>   					  unsigned int size)
>   {
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 11e4dd4f09ed..0a9bce599d54 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -27,6 +27,8 @@
>   #include <net/net_namespace.h>
>   #include <net/netns/generic.h>
>   
> +#include "dev.h"
> +
>   /*
>    *	Our network namespace constructor/destructor lists
>    */
> @@ -380,6 +382,7 @@ static __net_init int setup_net(struct net *net)
>   		if (ops->exit_batch_rtnl)
>   			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
>   	}
> +	default_device_exit_batch(&net_exit_list, &dev_kill_list);
>   	unregister_netdevice_many(&dev_kill_list);
>   	rtnl_unlock();
>   
> @@ -618,6 +621,7 @@ static void cleanup_net(struct work_struct *work)
>   		if (ops->exit_batch_rtnl)
>   			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
>   	}
> +	default_device_exit_batch(&net_exit_list, &dev_kill_list);
>   	unregister_netdevice_many(&dev_kill_list);
>   	rtnl_unlock();
>   
> @@ -1214,6 +1218,7 @@ static void free_exit_list(struct pernet_operations *ops, struct list_head *net_
>   
>   		rtnl_lock();
>   		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
> +		default_device_exit_batch(net_exit_list, &dev_kill_list);
>   		unregister_netdevice_many(&dev_kill_list);
>   		rtnl_unlock();
>   	}
> ---8<---

-- 
Antonio Quartulli
OpenVPN Inc.

