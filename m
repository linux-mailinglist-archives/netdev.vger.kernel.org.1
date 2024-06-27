Return-Path: <netdev+bounces-107144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10491A175
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074881F23B7F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A888757EA;
	Thu, 27 Jun 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="S8BWTNLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B33B79C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476967; cv=none; b=WSRclDDtIF+c4xlypmx6p6Q+TLJlmFTdSe5bVb8dA+EqcnAClYWKOwiA4QsKAxQT08VFQiN6Cge1vCi0sfMcdKIQJfNMXaem3Ks8XMbmAJruJRQJjzvR2nD4Dw0JgX1gch+39Srek3ygGT6m2ob411xurYAXWqvwfpxbzOAccAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476967; c=relaxed/simple;
	bh=VkYlRxNnFAMvvGC4wgGpvz3pyerQ/0jrvT4B/dDH/Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asMQUsDsHVhcNELYVmepBqVlv/V53PxKWAS5ejoukKLnKcAVGR+q2yxslcg4R+u1aoWkj3HGV+JkxtMZez2jLAu6cFMTOQQXUy12NV0gJOiOJbXYb86N8X80XiqmOtAVHxYuqhbWEvrePMbGbrnwvJGU1Nyw/u5uMpA9YmzPbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=S8BWTNLz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd80e55efso10451149e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719476963; x=1720081763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFRK7AMWsRu54yK4ctofHTpgyV+n69dpqIHl0mgStGk=;
        b=S8BWTNLzXjA4JbJ/JMcPuJUAciNzkMxPi0kIIcraeDqOeIlezdZSaOpRpJJilP3cYY
         oFt6z4h291iPJJbaef05YWwA14KzBce3kh+u0QDZZFUNEp48KHcTJqNgod8FpdA18m8n
         wYq9fajw9Va2GG5fqI7IqrxfcABffW6PMrwwXHJ6LD/EEAkJVkAaahLjQHoRUmEoa35A
         /DmIZjdmrmNIjpDMNEbZFYpx7aQ0q9ohSCeEh2sNyL46OV59W4CqsW/PciO5Tjye1Thm
         5Q+jO/AnoSm8p1OK8/rCo1CiHsDmlme2mpKhT7XtOPbdxvOyZAsVmO9gsmZ0NJNSJ4Ry
         EXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476963; x=1720081763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFRK7AMWsRu54yK4ctofHTpgyV+n69dpqIHl0mgStGk=;
        b=r7qnDJ9oCUIA5DY95lTJRQuZoJxKDlZAkY6dVjV6P+cQC8fc9NNPIrac5H42R6bGYc
         6ezrsBTErxMT06H79mSZ1+c0we9GCABL33qj3jK2CaKwGswR/NylW6LNiHhf+B5G9ui8
         pIkkXl4sDIA5efQTtusahWheaGBAcfq7hZcf1xTTBz9UNuio6XuuwGcl1rAgDxcWhtcL
         aBMq+gxrLFWwsYCVyFli8DeldugyepNTXj0QrLdIqaLvEF9xxQOhlrhBcHrm+E0Agnhl
         pDp2XtUxsq5SKMwYjSvwh+zIyhhHSI+72V78091JJumR1oYjihDDXp8AssAS8mdUR8Qh
         SxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1yQnxvt/3kuHwQosGY/QtKh3b+I3Zbj3o2zaIvyy++s89C+vkZPfIAv+SMuPkp+K0KqXNU1S8x78X/kvgcPQ4VYSr1pX
X-Gm-Message-State: AOJu0YyvH5b98tleQh7kRa/T42pft9WouDUgtstvkGLGqfxezlIQVxh4
	v0yG9MBs8V+jLaWHVsuedb7JmXT0SNoZ2aXuBxTLozMreP78W0jflI3Rcaq+7Sg=
X-Google-Smtp-Source: AGHT+IEpeJsfB5m97SyGfkWa9JUCRkU2vtXXgj13E+2t1IzDaph3YXLwSCK/5/fiBQhqW8eDG3O+4A==
X-Received: by 2002:a05:6512:358b:b0:52c:cb8d:637d with SMTP id 2adb3069b0e04-52ce182bca2mr9047969e87.5.1719476963201;
        Thu, 27 Jun 2024 01:29:23 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7b531esm36462266b.162.2024.06.27.01.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 01:29:22 -0700 (PDT)
Message-ID: <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
Date: Thu, 27 Jun 2024 11:29:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org> <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zn0iI3SPdRkmfnS1@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2024 11:26, Hangbin Liu wrote:
> On Wed, Jun 26, 2024 at 05:06:00PM -0700, Jay Vosburgh wrote:
>>> Hits:
>>>
>>> RTNL: assertion failed at net/core/rtnetlink.c (1823)
> 
> Thanks for this hits...
> 
>>>
>>> On two selftests. Please run the selftests on a debug kernel..
> 
> OK, I will try run my tests on debug kernel in future.
> 
>>
>> 	Oh, I forgot about needing RTNL.
>>

+1 & facepalm, completely forgot it was running without rtnl

>> 	We cannot simply acquire RTNL in ad_mux_machine(), as the
>> bond->mode_lock is already held, and the lock ordering must be RTNL
>> first, then mode_lock, lest we deadlock.
>>
>> 	Hangbin, I'd suggest you look at how bond_netdev_notify_work()
>> complies with the lock ordering (basically, doing the actual work out of
>> line in a workqueue event), or how the "should_notify" flag is used in
>> bond_3ad_state_machine_handler().  The first is more complicated, but
>> won't skip events; the second may miss intermediate state transitions if
>> it cannot acquire RTNL and has to delay the notification.
> 
> I think the administer doesn't want to loose the state change info. So how
> about something like:
> 

You can (and will) miss events with the below code. It is kind of best effort,
but if the notification is not run before the next state change, you will
lose the intermediate changes.

> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..046f11c5c47a 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  		default:
>  			break;
>  		}
> +
> +		port->slave->should_notify_lacp = 1;
>  	}
>  }
>  
> @@ -2527,6 +2529,9 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
>  		bond_slave_state_notify(bond);
>  		rtnl_unlock();
>  	}
> +
> +	/* Notify the mux state changes */
> +	bond_slave_link_notify(bond);
>  	queue_delayed_work(bond->wq, &bond->ad_work, ad_delta_in_ticks);
>  }
>  
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 3c3fcce4acd4..db8f2fb613df 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1748,11 +1748,19 @@ static void bond_netdev_notify_work(struct work_struct *_work)
>  					   notify_work.work);
>  
>  	if (rtnl_trylock()) {
> -		struct netdev_bonding_info binfo;
> +		if (slave->should_notify_link) {
> +			struct netdev_bonding_info binfo;
> +			bond_fill_ifslave(slave, &binfo.slave);
> +			bond_fill_ifbond(slave->bond, &binfo.master);
> +			netdev_bonding_info_change(slave->dev, &binfo);
> +			slave->should_notify_link = 0;
> +		}
> +
> +		if (slave->should_notify_lacp) {
> +			rtmsg_ifinfo(RTM_NEWLINK, slave->dev, 0, GFP_KERNEL, 0, NULL);
> +			slave->should_notify_lacp = 0;
> +		}
>  
> -		bond_fill_ifslave(slave, &binfo.slave);
> -		bond_fill_ifbond(slave->bond, &binfo.master);
> -		netdev_bonding_info_change(slave->dev, &binfo);
>  		rtnl_unlock();
>  	} else {
>  		queue_delayed_work(slave->bond->wq, &slave->notify_work, 1);
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index b61fb1aa3a56..38d37ea2382c 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -170,7 +170,8 @@ struct slave {
>  	       inactive:1, /* indicates inactive slave */
>  	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
>  	       should_notify:1, /* indicates whether the state changed */
> -	       should_notify_link:1; /* indicates whether the link changed */
> +	       should_notify_link:1, /* indicates whether the link changed */
> +	       should_notify_lacp:1; /* indicates whether the lacp state changed */
>  	u8     duplex;
>  	u32    original_mtu;
>  	u32    link_failure_count;
> @@ -641,11 +642,10 @@ static inline void bond_slave_link_notify(struct bonding *bond)
>  	struct slave *tmp;
>  
>  	bond_for_each_slave(bond, tmp, iter) {
> -		if (tmp->should_notify_link) {
> +		if (tmp->should_notify_link || tmp->should_notify_lacp)
>  			bond_queue_slave_event(tmp);
> +		if (tmp->should_notify_link)
>  			bond_lower_state_changed(tmp);
> -			tmp->should_notify_link = 0;
> -		}
>  	}
>  }
>  
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index eabfc8290f5e..4507bb8d5264 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4116,6 +4116,7 @@ void rtmsg_ifinfo(int type, struct net_device *dev, unsigned int change,
>  	rtmsg_ifinfo_event(type, dev, change, rtnl_get_event(0), flags,
>  			   NULL, 0, portid, nlh);
>  }
> +EXPORT_SYMBOL(rtmsg_ifinfo);
>  
>  void rtmsg_ifinfo_newnet(int type, struct net_device *dev, unsigned int change,
>  			 gfp_t flags, int *new_nsid, int new_ifindex)


