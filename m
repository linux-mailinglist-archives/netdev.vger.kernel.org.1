Return-Path: <netdev+bounces-93587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4F18BC5BF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC911C211A4
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C854086A;
	Mon,  6 May 2024 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2S+pwjKW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC83FB89
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962454; cv=none; b=Uoqv8xRQBPKSZwuHYQTnOhObpdkTip2x31qz9UU9R6gXrnD3klSlyzVAVwMfki7Y/xS7Ba9xle5r66en9Am3EhXTtT0pTeZU2P4PQVENjS2f/oCxwzhbpD5RcrJF0EHIX4zvHxUyZtxU3Z1IqJsSRHpImUJqcDeG8sp0rm83eWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962454; c=relaxed/simple;
	bh=9SFYx28lbOjebzpeT1IaydZg7cFtpjFbVbcTaHrbfVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlO8JALvsfDtDMi6GR3YGZDc83bKCK/93w3jfTCwEzm3AOOKeXf9OCHAbqsNd4jnM+KrWL2U9dUGl5nyoKQkWPvcgd4Bu0evuKS9fDmwk/EJfnuUu3UxfHVDbNfR6jUtRt1CXZlhhaIx4eMIs8toORYZVZtmNN+YEz1h6j/MTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2S+pwjKW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so653283b3a.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714962451; x=1715567251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZcebAj1tOpuNxt9ewLjX4z+yHH+WF19I/SsunPNY+Q=;
        b=2S+pwjKWYlLbiuBIk3HZlOWpXEc4CXmptIS03eIOnTMcGybp8XBpbKITK9/kFRg/ic
         LbwRXnBI6CK7hAF8xFT24WlmBjb7YEHwvgMB8Ggb7SDSy0x3eu/shPeQQfnRjZw+NYA1
         kbaoiqJb4DPFSnUmhmKxZKJvK5gdq8xJbgIMFmsLTQpXTqhNB4KX37OWnqSdir8sL8Lk
         jNazIC9k+hM6cV7ysWMAa0W5ajuYP+n++sigN4uxDW11dLBcTaZ1TkFS5N1FBdrArOn4
         no+itV9cHw6eUBXvQYs3wNKVAWMIPnk2zfvrYV89CDyEGP3i5y1La5iWem9GdI0RmOpj
         9VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714962451; x=1715567251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZcebAj1tOpuNxt9ewLjX4z+yHH+WF19I/SsunPNY+Q=;
        b=pytSO72l7GGNEt2DlyOGJJXS+BvsnA8C4YM7IN7iX8B5htfsxSf1CuXbZcCnoMaLX5
         r97VR+sIyUt/h3arOjrRQARn/HMaxFUGjVMwNmilZBzVZd8WMPF7ACmfyeTc4N021rKA
         Vm+RAcP0uETvZlJs/WaGWjcxO+X1gIsWBI5VPQP+t7oSb/b4tsGQuRhQCr8E0sVvQaKA
         ba5zy678WZmZ08WqVLJDCseOBmcv9pXbm67gRqyLjKF0keqZTEJYl4IGejAJWrV7GElE
         ArD93Ozf/jIK5MN9K5JRxJWHIy2xMvOy6nSttmHhz03823D1hl3PBOtAWxNFclYb0HNM
         v/aA==
X-Forwarded-Encrypted: i=1; AJvYcCXEPjID/YUrYDNJ7TM3rSqOXmIGnVceSIDJp8uMdTAbh1zEPdxJiQaK1TOLhmsXhHr/ZvhxvQ2OkOFw7Ud7lLq/hAhDfNrA
X-Gm-Message-State: AOJu0Yx4vNBtXbvueoBUiunZc2D1w3EzyUxdJTygVNl6r3XpIe/xy3g+
	e5LN7bacJwttNKZrN80t8zvJ9/uX5zscO2ViwHlXc81QPPrmTHmpdxgQhZg5Xkw=
X-Google-Smtp-Source: AGHT+IG347eCvhxwYdPwO4e9Eg21UrEgM91mcHSey1ZRxbww3HF95DvYkZM1Vz2e8uSTe7UMyQMSlg==
X-Received: by 2002:a05:6a20:d80c:b0:1af:7bbc:9f86 with SMTP id iv12-20020a056a20d80c00b001af7bbc9f86mr9359387pzb.0.1714962450620;
        Sun, 05 May 2024 19:27:30 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id n26-20020a63591a000000b005cf450e91d2sm6955159pgb.52.2024.05.05.19.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 19:27:30 -0700 (PDT)
Message-ID: <1d0c553c-18bb-4d0d-8358-eff0b65c6c56@davidwei.uk>
Date: Sun, 5 May 2024 19:27:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix netdev refcnt leak in
 smc_ib_find_route()
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240506015439.108739-1-guwen@linux.alibaba.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240506015439.108739-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-05 18:54, Wen Gu wrote:
> A netdev refcnt leak issue was found when unregistering netdev after
> using SMC. It can be reproduced as follows.
> 
> - run tests based on SMC.
> - unregister the net device.
> 
> The following error message can be observed.
> 
> 'unregister_netdevice: waiting for ethx to become free. Usage count = x'
> 
> With CONFIG_NET_DEV_REFCNT_TRACKER set, more detailed error message can
> be provided by refcount tracker:
> 
>  unregister_netdevice: waiting for eth1 to become free. Usage count = 2
>  ref_tracker: eth%d@ffff9cabc3bf8548 has 1/1 users at
>       ___neigh_create+0x8e/0x420
>       neigh_event_ns+0x52/0xc0
>       arp_process+0x7c0/0x860
>       __netif_receive_skb_list_core+0x258/0x2c0
>       __netif_receive_skb_list+0xea/0x150
>       netif_receive_skb_list_internal+0xf2/0x1b0
>       napi_complete_done+0x73/0x1b0
>       mlx5e_napi_poll+0x161/0x5e0 [mlx5_core]
>       __napi_poll+0x2c/0x1c0
>       net_rx_action+0x2a7/0x380
>       __do_softirq+0xcd/0x2a7
> 
> It is because in smc_ib_find_route(), neigh_lookup() takes a netdev
> refcnt but does not release. So fix it.
> 
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/smc_ib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 97704a9e84c7..b431bd8a5172 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -210,10 +210,11 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>  		goto out;
>  	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
>  		goto out;
> -	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
> +	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);

Of the two implementations of neigh_lookup() I found that do not simply
return NULL, all of them increment or init struct neighbour::refcnt.

1. ipv4_neigh_lookup()
2. ip6_dst_neigh_lookup()
  a. __ipv6_neigh_lookup()
  b. neigh_create()

>  	if (neigh) {
>  		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
>  		*uses_gateway = rt->rt_uses_gateway;
> +		neigh_release(neigh);

So releasing it here looks correct.

>  		return 0;
>  	}
>  out:

