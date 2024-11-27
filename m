Return-Path: <netdev+bounces-147612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E115F9DAA9C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F989281978
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D9E1FF7A8;
	Wed, 27 Nov 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wYSk35aa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB43C488
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720716; cv=none; b=ddHY36rM0uitkD2/zyhWrE7jpjjFWE24NBqnVIWXF8qw7sPX66b+rjna/UdEefyusc1/bP2TqJ4DPeaLv+hFX4Qo8DQsCladvNSv4uiLHzwCsdD8mGQflwmW/JMmvTffCdy9LT4/PiT0yyvgsJWLICRiGpTM3HyCmu4YRAa6nYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720716; c=relaxed/simple;
	bh=UzrsoRPnYYaSAxf+KxJCcwH26kfqbXP6mLKhom2Y3SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHNuHaBNe8qisLDr82i00bI0/0xOlg/DHiuhi10rD7nUmdo4lWnzv7LfEspEwgzVqMmF9qiBEDPmTo85d0Pl8PPJtlDagVpQRxqVGIXV8F32vL47Wzq3E6h+vjUc8LfwlEkKsQzOD2EQwnMWeqRAOOy/qo0Q5wweIAFfMvaMm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wYSk35aa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3825c05cc90so4355632f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732720713; x=1733325513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+oSZeUR7AiLgNc+pUDR6SKyaKAYIffA6fKdBZLIk5w=;
        b=wYSk35aa4PqMFDrazp6IzjzYU9yp4IOP7YmTKYARjHjaVDH5jDRJQ5o49Sfksu2VYu
         vUkXD2JR/MgmSpzACmYySat23NHCljJ9JztQI/u+/5rYaV9kXB4nSPQkITdBSbAs6K4G
         meXO4a3AT1bwbyiEav8QddYhUE/4NaNm9xSwYL/nqaCA0N1kY0GQNz0WKpeL7BlplRlm
         gYbLL1o9QAaWmTibSJsZslymCwCISXcOfNnkJe9HKCJgY7/woz5DOBg8Y7+TvmzaNm6o
         ceJeR2vtXcupM74JgKjJHyfFvoyemWKCVsadFUYPe3cwSNK0c45P1sxvOgnmy6Wx5ocp
         J72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732720713; x=1733325513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+oSZeUR7AiLgNc+pUDR6SKyaKAYIffA6fKdBZLIk5w=;
        b=L6TOEawcYaEV//RNVi62QPwtxuqtVEUP3HHJiD1+vM9j7ONAc/QvAGuiHgr+Vqm6WP
         aRK6cPaubx/JdvW8dVxlMWqcrME1JdDicnvdCWjd/jeury0/iZHn1Idf72QyfBHC/A5+
         b1NIRfdBiquOqTBQfbTqzuzJeqJ6txE/tlbk8iF+PTlkIYNPqTOA29r4h/WyxlFQ1WPV
         0RrgQCzIkbVG6VrkmWz2PsiR/+OOPVs8GMuSwRihJQCOKUFeT8Vg1UdG+1iLX3+3P/D/
         KQkAts092vHoyOnTGJUTQsU3ellgtOcpO3R+zgDpRJjYhj2hRr02tnfnLYqUX2tGh6hc
         eBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEUkPu/Bm45Qr2VIbYbej1RuRLSfHkD0E3Xr+1Qlp6uhR3IBDdHFwhelutUf+NdVWC2F57qPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMhzajsx1oZWpikvDGvl5sIrIx+vggUoQailBvC0zQUgQq/8H
	p8QQkI2e1rmpVrXsFSDxB/5L0O196QHuOUgjjeaZfQltnDKCOtN6eI0GUxmTonY=
X-Gm-Gg: ASbGncvIJlMsaswneFCGsgkOAiGSppqY6AF4vR/WQSAo5reOU1Qmxff9dKWSor6u6Zy
	KZO/m3BrjoOOBj3JJ292w8WYUYiNL+XC6/0/cT3/SHDai1q6nUv2UT8iT3aP7VxcEl1FRqBuRD2
	7Jrphf8z7N4q3uT8x0KtrC1BspJuOnvZhUlKIv/UwrjmjBOJ1J0wb6tXe+BrkkCwqiRj/KNdnIx
	0erakOMorzliel9uODMa76ET5H/Cq/PNkqf2MAIAzUC55Oulg9H
X-Google-Smtp-Source: AGHT+IFMZq/SLB0YPTS6pOpxpXVoC3SN78NhEpBi14KtJlCKVd/tvu1fKdQs2+u0i91TxkvTnlh6gg==
X-Received: by 2002:a5d:6dac:0:b0:382:37b2:87de with SMTP id ffacd0b85a97d-385c6edd3femr3102480f8f.43.1732720713056;
        Wed, 27 Nov 2024 07:18:33 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb274d5sm16432118f8f.50.2024.11.27.07.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:18:32 -0800 (PST)
Message-ID: <e1db249d-6b34-4bd6-beb8-e8754a773b71@blackwall.org>
Date: Wed, 27 Nov 2024 17:18:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
To: Yong Wang <yongwang@nvidia.com>, roopa@nvidia.com, davem@davemloft.net,
 netdev@vger.kernel.org
Cc: aroulin@nvidia.com, idosch@nvidia.com, ndhar@nvidia.com
References: <20241126213401.3211801-1-yongwang@nvidia.com>
 <20241126213401.3211801-2-yongwang@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241126213401.3211801-2-yongwang@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 23:34, Yong Wang wrote:
> Re-implement br_multicast_enable_port() / br_multicast_disable_port() to
> support per vlan multicast context enabling/disabling for bridge ports.
> The port state could be changed by STP, that impacts multicast behaviors
> like igmp query. The corresponding context should be used for per port
> context or per vlan context accordingly.
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 75 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 67 insertions(+), 8 deletions(-)
> 

Hi,
A few comments below

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b2ae0d2434d2..8b23b0dc6129 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2105,15 +2105,45 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
>  	}
>  }
>  
> -void br_multicast_enable_port(struct net_bridge_port *port)
> +static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
>  {
> -	struct net_bridge *br = port->br;
> +	struct net_bridge *br = pmctx->port->br;
>  
>  	spin_lock_bh(&br->multicast_lock);
> -	__br_multicast_enable_port_ctx(&port->multicast_ctx);
> +	__br_multicast_enable_port_ctx(pmctx);
>  	spin_unlock_bh(&br->multicast_lock);
>  }
>  
> +void br_multicast_enable_port(struct net_bridge_port *port)
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
> +		/* iterate each vlan of the port, enable port_mcast_ctx per vlan
> +		 * when vlan is in allowed states.
> +		 */
> +		list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
> +			if ((vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED) &&

This is racy, the flag is changed only under multicast_lock and should be used
only with the lock held. I'd suggest moving this check in br_multicast_enable_port_ctx()
after taking the lock where you should check if the context is a vlan one or not.

> +			    br_vlan_state_allowed(br_vlan_get_state(vlan), true))
> +				br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
> +		}
> +		rcu_read_unlock();
> +	} else {
> +		/* use the port's multicast context when vlan snooping is disabled */
> +		br_multicast_enable_port_ctx(&port->multicast_ctx);
> +	}
> +}
> +
>  static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
>  {
>  	struct net_bridge_port_group *pg;
> @@ -2137,11 +2167,40 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
>  	br_multicast_rport_del_notify(pmctx, del);
>  }
>  
> +static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
> +{
> +	struct net_bridge *br = pmctx->port->br;
> +
> +	spin_lock_bh(&br->multicast_lock);
> +	__br_multicast_disable_port_ctx(pmctx);
> +	spin_unlock_bh(&br->multicast_lock);
> +}
> +
>  void br_multicast_disable_port(struct net_bridge_port *port)
>  {
> -	spin_lock_bh(&port->br->multicast_lock);
> -	__br_multicast_disable_port_ctx(&port->multicast_ctx);
> -	spin_unlock_bh(&port->br->multicast_lock);
> +	struct net_bridge *br = port->br;
> +
> +	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {

These blocks in enable and disable are almost identical, maybe make
a single helper called _toggle (similar to vlan mcast snooping toggle)
with a on/off bool argument and call the appropriate function based on it.

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
> +		/* iterate each vlan of the port, disable port_mcast_ctx per vlan */
> +		list_for_each_entry(vlan, &vg->vlan_list, vlist) {
> +			if (vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)

Same comment about the flag check being racy.

> +				br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
> +		}
> +		rcu_read_unlock();
> +	} else {
> +		/* use the port's multicast context when vlan snooping is disabled */
> +		br_multicast_disable_port_ctx(&port->multicast_ctx);
> +	}
>  }
>  
>  static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
> @@ -4304,9 +4363,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
>  		__br_multicast_open(&br->multicast_ctx);
>  	list_for_each_entry(p, &br->port_list, list) {
>  		if (on)
> -			br_multicast_disable_port(p);
> +			br_multicast_disable_port_ctx(&p->multicast_ctx);
>  		else
> -			br_multicast_enable_port(p);
> +			br_multicast_enable_port_ctx(&p->multicast_ctx);
>  	}
>  
>  	list_for_each_entry(vlan, &vg->vlan_list, vlist)


