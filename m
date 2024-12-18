Return-Path: <netdev+bounces-152979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102249F67EF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFF1887957
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DE11B424B;
	Wed, 18 Dec 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="anACCiCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B81C5CA0
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530685; cv=none; b=iMX3VlOnqK0G2sL/qHFcBpt9V+h8eLsYN4OY7/RSocOjrBt5lPjlrjALks8Kkjk/92RZIalHIsY7Ax9e+bXOHzct3gM1fGAwDbXHQfExLzDL/7OTN8J0W7rRGNr1WAewOP4uVkxibkcFrWKFKP50A6lj1ZXChGkWZB8zACLilZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530685; c=relaxed/simple;
	bh=uKZGuxu1O2Svc7LX9xRZZdT8eJfyJMlzuBWnDnQaNmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebRO4GsqXUChlX2AMsseBqKu7uwLFtpCJAQ7OUlNdEDm4E10iedz1KPoNIu8q8XeScy8xpV4zAzTJcKwk4x86dTpOXQe+5YSyKxm2U93kDOq0p4z/CpiGJFxRiBJx/Xb3BxGaN0Pr2mgttlzYdy/CDBVNUCkO76UEWe2lFGi0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=anACCiCh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa543c4db92so30731266b.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734530681; x=1735135481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HbzEYguX7Enkd9x2A8psK17RascnEPFae0WnK5nGIsg=;
        b=anACCiCh5YwbQjGJoMVWRlknR4Mgq2czo5ByjbInIgQNAfv94Le0pvfxvDf+3150CI
         bzHwu6Zi9Y9XFqL1YpegrXFlL9Clgsls4O9lsfbOFAc/F//aly+DRjplD+wRnVQm5yZJ
         VwMPnKvV1YPZ5gLS5vkbSelPJRDjn5rXdMTXN31efOFFeLdYXsr0VGNZ8Wj/XFvK35Gk
         7m3nOpuMPh7F5wWxdWOidwiIzh/gVXVllrrPuRCJaNc3RuiOJrUczoLwkyjXt//VxKtC
         +j6zQmo306UpnUg1hAKyBR0SkxCUK7K0K77gKmCKte7UQA/W69kZ6H8/CN8LCSWNzerQ
         9d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734530681; x=1735135481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbzEYguX7Enkd9x2A8psK17RascnEPFae0WnK5nGIsg=;
        b=kk4Fap2Nrd9mISiEL5KyROVPGcLzbj9Vfjy6wJPdqtxt8ikQjxW5v0/5vfS0FArksD
         HghdTwMVAchCjZqp0ePE54p/56j7kNneWE9sjGO9ePkDqTWAI/HIOQ+pwKUcqXtBQt5F
         4EF3nxKEHWau+tplG6VpDp0NQikDEPeFhRjUsXx8xpgkHCE0NJGLU3OKmKzND+P6bJWf
         FfpMtb16dd79+pxdMoAfbuEC4BtKjDIgc7T7HoK4yPd+O74xKMlP4wEg7ucl0+wWI21P
         RaSYvGTGVRLjWhwuCynBl1KPJKEJLznam/VdS2cHG2ZkE0DYoMH9qAMSd4+y/6yuHOiQ
         ucYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsqpMFqC4aiJF0ZBtsU/jeAVPjApEQH3NSQnxYy2iniz8MDm8i8rP80mVuVR/2rRQ+FpmCNxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqWPicZWf2bJslRn6NVKmjKs8Z25cj2euPNYJHW1VpjDB3oyx
	NCUOYnJvHNIKMUKGFFa3dCkPrlD3MeeyXbZkdCnuONDB4XIGIMjT/HYTBi+Pogs=
X-Gm-Gg: ASbGncsBqcalOCoLmYeJFYQ4C7L+ocRmYDf3d9wZrD1y3+KmkIV/2fYx2XprULUbRGW
	V74cDJ9o00TB+QuhfDNGdiAtfT+J6xln729WniSzMzIzEBMlQkAFnURNETHWLByROR29aCW9q1J
	oH5yttjJ+JJQyJH1aPshAC9D5Ivo+qNkwEJpuSg6e7yfibFSF2F2xEPUJPAcKh6ycBw971WBPys
	kskocvWS1+OrbnEOrFa0lXTI5MRVlPhZhbiZ/7WRpARQ3f4G+UoPTlZ7MZxmQ==
X-Google-Smtp-Source: AGHT+IHAIbY2BfEE61yTQ649e95uAgnboexuSVsj6pOoSnKeKFjwNH71crXSR0FCfrv3JRB/MSuviA==
X-Received: by 2002:a17:907:2d08:b0:aa6:79fa:b47a with SMTP id a640c23a62f3a-aabf471fcb0mr238018066b.7.1734530681162;
        Wed, 18 Dec 2024 06:04:41 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9600686csm560506466b.33.2024.12.18.06.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:04:40 -0800 (PST)
Message-ID: <fb4027a7-48a7-4488-a008-584d3b69c025@blackwall.org>
Date: Wed, 18 Dec 2024 16:04:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
To: Yong Wang <yongwang@nvidia.com>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org
Cc: aroulin@nvidia.com, idosch@nvidia.com, nmiyar@nvidia.com
References: <20241213033551.3706095-1-yongwang@nvidia.com>
 <20241213033551.3706095-2-yongwang@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241213033551.3706095-2-yongwang@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 05:35, Yong Wang wrote:
> Re-implement br_multicast_enable_port() / br_multicast_disable_port() by
> adding br_multicast_toggle_port() helper function in order to support
> per vlan multicast context enabling/disabling for bridge ports. As the
> port state could be changed by STP, that impacts multicast behaviors
> like igmp query. The corresponding context should be used either for
> per port context or per vlan context accordingly.
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> ---
>   net/bridge/br_multicast.c | 72 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b2ae0d2434d2..67438a75babd 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2105,12 +2105,17 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
>   	}
>   }
>   
> -void br_multicast_enable_port(struct net_bridge_port *port)
> +static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
>   {
> -	struct net_bridge *br = port->br;
> +	struct net_bridge *br = pmctx->port->br;
>   
>   	spin_lock_bh(&br->multicast_lock);
> -	__br_multicast_enable_port_ctx(&port->multicast_ctx);
> +	if (br_multicast_port_ctx_is_vlan(pmctx) &&
> +	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
> +		spin_unlock_bh(&br->multicast_lock);
> +		return;
> +	}
> +	__br_multicast_enable_port_ctx(pmctx);
>   	spin_unlock_bh(&br->multicast_lock);
>   }
>   
> @@ -2137,11 +2142,62 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
>   	br_multicast_rport_del_notify(pmctx, del);
>   }
>   
> +static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
> +{
> +	struct net_bridge *br = pmctx->port->br;
> +
> +	spin_lock_bh(&br->multicast_lock);
> +	if (br_multicast_port_ctx_is_vlan(pmctx) &&
> +	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
> +		spin_unlock_bh(&br->multicast_lock);
> +		return;
> +	}
> +
> +	__br_multicast_disable_port_ctx(pmctx);
> +	spin_unlock_bh(&br->multicast_lock);
> +}
> +
> +static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
> +{
> +	struct net_bridge *br = port->br;
> +
> +	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
> +		struct net_bridge_vlan_group *vg;
> +		struct net_bridge_vlan *vlan;
> +
> +		rcu_read_lock();
> +		vg = nbp_vlan_group_rcu(port);
> +		if (!vg) {
> +			rcu_read_unlock();
> +			return;
> +		}
> +
> +		/* iterate each vlan of the port, toggle port_mcast_ctx per vlan */
> +		list_for_each_entry(vlan, &vg->vlan_list, vlist) {

list_for_each_entry_rcu()

> +			/* enable port_mcast_ctx when vlan is LEARNING or FORWARDING */
> +			if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
> +				br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
> +			else
> +				br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
> +		}
> +		rcu_read_unlock();
> +	} else {
> +		/* use the port's multicast context when vlan snooping is disabled */
> +		if (on)
> +			br_multicast_enable_port_ctx(&port->multicast_ctx);
> +		else
> +			br_multicast_disable_port_ctx(&port->multicast_ctx);
> +	}
> +}
> +
> +void br_multicast_enable_port(struct net_bridge_port *port)
> +{
> +	br_multicast_toggle_port(port, true);
> +}
> +
>   void br_multicast_disable_port(struct net_bridge_port *port)
>   {
> -	spin_lock_bh(&port->br->multicast_lock);
> -	__br_multicast_disable_port_ctx(&port->multicast_ctx);
> -	spin_unlock_bh(&port->br->multicast_lock);
> +	br_multicast_toggle_port(port, false);
>   }
>   
>   static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
> @@ -4304,9 +4360,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
>   		__br_multicast_open(&br->multicast_ctx);
>   	list_for_each_entry(p, &br->port_list, list) {
>   		if (on)
> -			br_multicast_disable_port(p);
> +			br_multicast_disable_port_ctx(&p->multicast_ctx);
>   		else
> -			br_multicast_enable_port(p);
> +			br_multicast_enable_port_ctx(&p->multicast_ctx);
>   	}
>   
>   	list_for_each_entry(vlan, &vg->vlan_list, vlist)


