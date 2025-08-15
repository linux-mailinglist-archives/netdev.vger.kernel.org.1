Return-Path: <netdev+bounces-214081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C987EB282B1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A41AE5512
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD7289810;
	Fri, 15 Aug 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="C1RVc9on"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5933289807
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270518; cv=none; b=sSYWAR09gYrI93DLPnI5VpVX7VcjzLeKw16752QCf7wR8n43q3y5sqxxp2r+bEzAdnVd+enPD/J2Z4lsuFHzOcpB+LDZ1A6JrvLjlu+HrnFPrZWZSZDx45SuJVn0jOrBekp60TH5SxYQiTJZIABX7hs1/olcU31VWidPT1NpIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270518; c=relaxed/simple;
	bh=wxXY4tEGwganMnpiKU8Ayd+L73yT/MpiUpiLzweyTx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g87E15sydkVfPuqvdbghntGTcn6fII6daNqW8YEcXk3Lpp1gj7zw5JFIvxEWaOBYtQkuSlH9IymAWoqwtNmfn97XlXOrC0SJd3vfIYqJyJvBVcdZdb/OfFBo0YXxm8gnS6hsHpAHMXJlxz+ecLZCx6DJm1INDDHdYopryKuS02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C1RVc9on; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so4283134a12.1
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755270514; x=1755875314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvYymIzLnJigupjUPWkbrLGydSeNzR7fRIJx+eQRmEI=;
        b=C1RVc9onz/M86sN91Ek7JRoEF86dRLnQdhY0FShJL5A9YAlHQ2ClSsbsvxzmosqedL
         kAEfrg81xKdPsfwcgf6XXePHbdulXFyTM583GPWP1mtlrFzYQohhm80NXZE9vKKUbikf
         gO//ln37Tbu9sigNmftbwrX8AOea2gHz7XlB5Je9gRJLoo0a8uyUHsmCsjhWLh+kXtw4
         UnH7HxAuy0oZ7I/ggSwU/Qu/N3IY3uaLl0H4H3W/SsWvNm4zBmSDybu3XORN7j2bgmnO
         Avtj8e1Wal6qB/4kNpX49EhJw4RZ2WnlQRaCKuDXvkbTBGH8RFy/N1I4DaVgv4wHUNd9
         tteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270514; x=1755875314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvYymIzLnJigupjUPWkbrLGydSeNzR7fRIJx+eQRmEI=;
        b=vA5H+UGXxyVB41J6+VrBxgjT4yhPVaKPh2AdhfGptYFTXCfTCFfGJmrdOGdB4sDwX2
         hi8ToOa9jlAu2nRLd8upgYI+4HNznTftwe0FqxPxDfx+My5nn/RpTVKBZM8LYpPBBqNm
         ys+oBdRlWt3JHLgSwzeDHUrQMNyjJrm5h/C0dLoNDEUnA8ZwQQXNgb02ymUI9cSvNQ5i
         iNEiLiYl7XC3Ypp1L04oGrJyDSsH6p9eFro7Nito/pVpwNm+Ue32K45Hb/KZIRLMnjPC
         2G35E3BuJWAajHTGh6fRlgRW1eebg11M0BOuxeAvt8xfxR39vTOrDLAZTeUASJwTdifd
         2oTA==
X-Forwarded-Encrypted: i=1; AJvYcCXocVs7PJM1v7rABQ5igujNvw4D7rR49yR5F+HjiAbAjWEqqJoL9ERJOJcNJGyVzZTA0PhN/p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NYxRF+f2qrCU9edB4tOlybSYWm3qvWSp7Ql84VixhclocKu2
	EVUE4P+HcvzSv0ymhnr5vSuC7AOYklxZD6GoZ1oipotCFmM+fT7wdMl5JkVGMgyxAoM=
X-Gm-Gg: ASbGnct+TtdDrZTwRO4E62BnKAZQSmtH3zgkgqnYN9RTf2+2rHh6oZo7CkgvilZ0uZO
	E5DDvl2QpZWUKij9NNIk16zGrjRSQTNQUJzlMzUs1I+heqV2qaHbr8lZistrPG8sLVuxjIT228o
	IDcRJZkmY9g1PHfAGC1BhX2+D74jEAOtUooibCZKFrixWLgdEyNbmJa1B+tfuvB50EDZU5CcID6
	ssqeRzxvpCbodiXiOPwiK8r8r0Kmj687l9d88EtdgXyJKFuwiLNFkyJjjoC6PZQ8r/7XmiMlU6Q
	kPA30QVSdjhWfGq/8wfZpA91H9s9w9ImaDuoZxN0rY+WO3BAkOg0rnmcjf0yeJtGN9bgxCt93UD
	RQgMNz65LLBAwniDxY+gKLMK+nTJ5Ni1IKzeVBKE=
X-Google-Smtp-Source: AGHT+IGg3ipRv25chD0V0TpD5T6M8dl0rPLRTtfh63vVqHF23z3Qpb+K6dK+mPlUqX6NaiNGb1oPjA==
X-Received: by 2002:a05:6402:2188:b0:618:780f:e89d with SMTP id 4fb4d7f45d1cf-6189199fa41mr6105149a12.3.1755270513688;
        Fri, 15 Aug 2025 08:08:33 -0700 (PDT)
Received: from [100.115.92.205] ([149.62.209.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae5casm1791561a12.36.2025.08.15.08.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:08:33 -0700 (PDT)
Message-ID: <9680221e-e702-41b6-8401-9e940e2f3290@blackwall.org>
Date: Fri, 15 Aug 2025 18:08:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: remove unused argument of
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 07:23, Wang Liang wrote:
> Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
> port/address updates are consistent"), the argument 'querier' is unused,
> just get rid of it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   net/bridge/br_multicast.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1377f31b719c..4dc62d01e2d3 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4049,8 +4049,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
>   }
>   
>   static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
> -				       struct bridge_mcast_own_query *query,
> -				       struct bridge_mcast_querier *querier)
> +				       struct bridge_mcast_own_query *query)
>   {
>   	spin_lock(&brmctx->br->multicast_lock);
>   	if (br_multicast_ctx_vlan_disabled(brmctx))
> @@ -4069,8 +4068,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
>   	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>   							     ip4_own_query.timer);
>   
> -	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
> -				   &brmctx->ip4_querier);
> +	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
>   }
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -4079,8 +4077,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
>   	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>   							     ip6_own_query.timer);
>   
> -	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
> -				   &brmctx->ip6_querier);
> +	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
>   }
>   #endif
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


