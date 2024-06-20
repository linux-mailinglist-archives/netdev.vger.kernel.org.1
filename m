Return-Path: <netdev+bounces-105173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88490FF67
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30911F218A7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BC519DF64;
	Thu, 20 Jun 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zBeTL7N0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092619AD6B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873275; cv=none; b=Fn43UNaytnzvFFz6ibhepWvMdWi/tkjQBOEeor7buGFlSysnPIUqzyIhF4hmPM67cbDUYZsvvA5LJVBAfE1zxqmOdzvgC3lRzE3gZzRkR5mH/E1FXHl8ehCBSkAyDKBube/t7M23gQW7Ko24+sWKrCSaLIYPJFywiiElB9qdPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873275; c=relaxed/simple;
	bh=pu4cUJlHDM2IE/LsL3x7JELUsHAoOtPHfYJ82Jszo2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFWy8fod8phRNWGrtvP2MKVLcaAfmE+e/RMwk1YxwbI8RXSBNQU7OGrLlcpvoUFl9Zz+fveFtmx2thPcJXoFqVQH7U0R4HRTuNS46OcG4KqFELrDs6XFw5OkR7O9qv3fdeq1FqtGT/rzf1B/KN3ljqj5sMS1BHI7tpuPjknfCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zBeTL7N0; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d2469e797fso323962b6e.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1718873273; x=1719478073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzUjMgiYrV3CjZ2nfvpVdoNGlwFyp/ogee2pVUj67CY=;
        b=zBeTL7N0IBmN0SG1wz33HowNOiByo4GEy3EOcBHpFV2ommeqlUCzwfjV2u2suGlgVl
         8NknIHe7/niLNRRf1m63+aeCNTNVTKv4svzF8+wq78vt4idSW2zymmbJeOVmcR25k17X
         OOK3oA6JWWE9Ohjd0yv1rxSlBh2ErLmmATTJ07L8PzUY3ZKLViJqcL1191h2Dn6dXPYa
         gOIP9QSgo9MHPcoeyt7zJGLWqClu+oNfhzxrUrfml17ePLLY2KYNmjNZgV17Q5+jts3O
         tkBHnSbNiUUNQayDV0xnXsSbJWxpncFIVuAUVRSM/C9XJ2cNhzQiQPhILfxPjsBfArbB
         52yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873273; x=1719478073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzUjMgiYrV3CjZ2nfvpVdoNGlwFyp/ogee2pVUj67CY=;
        b=Z/w490Oh3cb5zf3F2jqQcIDEUwAB+cK6j5lipWdbzQCNPcf2FT2B9sxMvHvqubO5rD
         4BG5I/mQEx1EcV17G24npvdfn1wWgQivQfSDRPsl59QHEO8TMOEfvtyHOs5779koWDRM
         5+Fz/SY96Yk/Dhb2LwjJbtckVlUXGiLZ6HM6qoYBOiIHWmFJqNPvUJxFsWa1ln5CRDMS
         UvobUXLvP00MafnUQCRWz+j6U+nDwHXaHyOzFTlQ+0gJr1XSyAxSSU6zJNTrrS1SOMk3
         sahoyuHnWfJxPM9uhIPb7ES2PlPw6owP+fb64W0cjDNSEYiZcQVPTqkl85X1vgC5aknx
         6fqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcGdABCFS+pXQT8/vFkLDHEvOWvaAonyK2ro0ifuUVUfeRosxDLOXlIgYSxlmLZ7uzwLMMpUkDYR+oYSWMTQ8vZyvRBRCa
X-Gm-Message-State: AOJu0Ywsg70FCiQDt3KoSRIi59pL3CqNUEBtA4XbWFzLMOvETRL0H84o
	DNbFZRgoSqhKcxwVm5eUmo+ZOJbo9AzKXisUBRSWP+0XJG2YKFuoHW1GJsFFvE8=
X-Google-Smtp-Source: AGHT+IGbKrol+0UZuYIBxj0w4VnVCxhSca3aoiAcZM78STe77M1ZCPClsmLZtJGsXsSB5GaJ+OtQaA==
X-Received: by 2002:a05:6808:130c:b0:3d2:2fb5:b477 with SMTP id 5614622812f47-3d51b5d7b41mr2417341b6e.9.1718873273154;
        Thu, 20 Jun 2024 01:47:53 -0700 (PDT)
Received: from [10.11.11.3] ([91.235.68.88])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d247605ffdsm2413992b6e.20.2024.06.20.01.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 01:47:52 -0700 (PDT)
Message-ID: <1b9fd871-e34a-4a7d-b1d3-4f3fd8858fa3@blackwall.org>
Date: Thu, 20 Jun 2024 11:47:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: 3ad: send rtnl ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>
References: <20240620061053.1116077-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240620061053.1116077-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 09:10, Hangbin Liu wrote:
> Currently, administrators need to retrieve LACP mux state changes from
> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
> this process, let's send the ifinfo notification whenever the mux state
> changes. This will enable users to directly access and monitor this
> information using the ip monitor command.
> 
> To achieve this, add a new enum NETDEV_LACP_STATE_CHANGE in netdev_cmd.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 
> After this patch, we can see the following info with `ip -d monitor link`
> 
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_port_state_str <active,short_timeout,aggregating,collecting,distributing> ...
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_port_state_str <active> ...
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ...
> 
> ---
>  drivers/net/bonding/bond_3ad.c | 2 ++
>  include/linux/netdevice.h      | 1 +
>  net/core/dev.c                 | 2 +-
>  net/core/rtnetlink.c           | 1 +
>  4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..bcd8b16173f2 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  		default:
>  			break;
>  		}
> +
> +		call_netdevice_notifiers(NETDEV_LACP_STATE_CHANGE, port->slave->dev);
>  	}

This will cause sleeping while atomic because
ad_mux_machine() is called in atomic context (both rcu and bond mode
spinlock held with bh disabled) in bond_3ad_state_machine_handler().

Minor (and rather more personal pref) I'd split the addition of the new
event and adding its first user (bond) for separate review.

Cheers,
 Nik


