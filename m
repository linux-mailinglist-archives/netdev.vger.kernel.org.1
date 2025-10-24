Return-Path: <netdev+bounces-232373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC4C04CC5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F47C3437BE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF12EACF3;
	Fri, 24 Oct 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Up0Mu6Qn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE742EA73D
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291784; cv=none; b=maznwMJ0eecTZRn+VrQERRxKAhDNbLxPM2EqCUy1VAgLQ4hWpHiNSAaQ1hbVlWFBp4oXz5puGVuZkATLTUYnT85AM+F6u2ioJ3Lp1OMDBtPvVHFwSdZNzIjnSWHs8if4ktVWly6Nf4YWZUuv75NlIbof5csDEYBBzAUiW9q9ZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291784; c=relaxed/simple;
	bh=+Ri+9nDNnz2Ro7JzCcrVpBywjcXVkOfSO4cIXjqKvQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hq1BlTabYXjlVr6yM7giLRsCXo0uAEZkfnFXbtLL7NMz6J1QOLYw8Yx+2HKRyB7LeATWoszDgGe14QLLa2EoVgbNejl93y7cqKhXPdk3J3CB1CQLwVJZY2V67zqpDD7u4sMhzWsuKd1bzHrCHaQuTihP4POKNIN/vyh4gxvKHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Up0Mu6Qn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso324460266b.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761291780; x=1761896580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhahQiKxL2l5ZMBK3/b5kydysdy0zRxJIFdQCfDiF8I=;
        b=Up0Mu6Qnt9s1Agdx0WpGlDCptZq7Of6/qQ3PMQUT5fOCxaHzoVdLqR+85caxz42MUN
         B0BNSvRQCWwiaKncNks6pIcGJsFto2dHya2OayE4PAYWFyTP+3AegysrlSEvpWM275Yh
         bvyP3wZsJLcB6ylkQYmNsyaxA6rJhkX8D9V5ZrSRlSkkDZzWn3wshrHg/8HaV+4RAwFO
         8xPpgqT67LJwjbGG7wxHu9j06MGRJVfDOJfZJ0B6kc5v+ZKxPoaifNn4B9RFY3ZJemy0
         OZwTbOzfa8B8HAZ0VynMKVvJvOA2I47scRT5AeaRMcPCuJnpjuFmzT9x6NSuy8NA++Ae
         puHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291780; x=1761896580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhahQiKxL2l5ZMBK3/b5kydysdy0zRxJIFdQCfDiF8I=;
        b=kBUymkc2XMLJMH5hrxweh0umCIBLZ5gbWy0vNXrlfYqgsSlTgccD7bx7PUuZnxHUZC
         Fk6puHVX1B0ZAyo+E+ZGHkUYSjT3N0BFrxBDJVAv4OiaOyKOOFen9GyO6YtNjdjr8uVm
         UHgWxgggMS35yrPFK/SicCv3bZOU1k38jG65yAj7vGiHVEkSAWe5E9m8MAhTFdf4+67v
         xzZxWmBLh+fC+XnSbDI7cOjl4HkD1PS08yRTWbt4Wc9j86eUC+TY1dEilCC7SeVnn4jv
         Ra9kV2BZZ7TUmq7AnAPeknRuWWtf6AoXnrj/xnFH+pgUfQGh/01xF8ydYv94/mzPNicY
         F1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUnQJ/wflWXqnZ1+j2VBn7UewYuKcXjRsISbeyXDUwGRUbyWh6mOS83cB8WK5I2Ftgfj7AnxbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRv4eond7Eu6ReMZObCiDidi4sGkHOt8nwT71g85f67tTZCbQ
	rLBdBCO/O/lLRvudrqbJPS5B58a5Snir7Gk5fkxe27CQ1es0rEmgBTJFymB8QuZeXF8=
X-Gm-Gg: ASbGncuJe6UUUiGYoWdvxdrz5vkmgNc72phsUg/IFu3whzRmJBVlI3AZE7UR7gheohz
	0YWUSaf7TMgI74yd8aDqgdzERtjq4cpGUwj7vlDZipB+cNprNQrCOHk1FEKmX68pwaaeBgozzIb
	xbQDgViemOACaSBsBkXigFkX3gcLm+l9SAPvP/iG5RvteL+DPHdAE1O66U3a/jBeHrF7Il7PK0O
	55bvMZ2deyv1L57V/xYUu9ue00x2OKM9OFYX1dPF7QCOKlqF6JaUK7lDYUhvtOnGOdUem7utvQh
	IiXdeiWqvrIt2eFWA/BXFNB4838tq7zeg8lROFVVjcNPYwVo7Ovdx/0Y6jOMViw0fqvnbgbULpi
	3i64cQyUJbo699nnXjtj1jqEeI3O0kxzSRvmS0stzZh6evuP8c5u8IiwZ5LRVxgHNXQV0lcr5il
	+Aiy3bf+G2qf9bDoBL7GwpzL34mwZv80+j
X-Google-Smtp-Source: AGHT+IFvbTrKGBBpoTCaoGS2gvcjtD63K6LWeth4uaR2zH92WeIfEL6ETRbjxcJ7CljSIdIyP7aerw==
X-Received: by 2002:a17:906:ee89:b0:b6d:595b:f54d with SMTP id a640c23a62f3a-b6d6ba8f860mr195451266b.7.1761291779267;
        Fri, 24 Oct 2025 00:42:59 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144ece8sm443173966b.68.2025.10.24.00.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:42:58 -0700 (PDT)
Message-ID: <aa92bbb5-c64b-4262-a382-ae5609254606@blackwall.org>
Date: Fri, 24 Oct 2025 10:42:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Flush multicast groups when
 snooping is disabled
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com
References: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 17:45, Petr Machata wrote:
> When forwarding multicast packets, the bridge takes MDB into account when
> IGMP / MLD snooping is enabled. Currently, when snooping is disabled, the
> MDB is retained, even though it is not used anymore.
> 
> At the same time, during the time that snooping is disabled, the IGMP / MLD
> control packets are obviously ignored, and after the snooping is reenabled,
> the administrator has to assume it is out of sync. In particular, missed
> join and leave messages would lead to traffic being forwarded to wrong
> interfaces.
> 
> Keeping the MDB entries around thus serves no purpose, and just takes
> memory. Note also that disabling per-VLAN snooping does actually flush the
> relevant MDB entries.
> 
> This patch flushes non-permanent MDB entries as global snooping is
> disabled.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 22d12e545966..d55a4ab87837 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4649,6 +4649,14 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
>  	rcu_read_unlock();
>  }
>  
> +static void br_multicast_del_grps(struct net_bridge *br)
> +{
> +	struct net_bridge_port *port;
> +
> +	list_for_each_entry(port, &br->port_list, list)
> +		__br_multicast_disable_port_ctx(&port->multicast_ctx);
> +}
> +
>  int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>  			struct netlink_ext_ack *extack)
>  {
> @@ -4669,6 +4677,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>  	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
>  	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
>  		change_snoopers = true;
> +		br_multicast_del_grps(br);
>  		goto unlock;
>  	}
>  

I've actually thought about this, disabling multicast has always been weird in the
bridge and I think this is an improvement:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



