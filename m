Return-Path: <netdev+bounces-231648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C4BFBFEA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F465E6614
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265A83469EE;
	Wed, 22 Oct 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HKwN8OeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAF34575F
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137533; cv=none; b=DzBSEO4Ok1s8h6n9ecEKABtUGjNgMxA2iLTyyNVe3MZhnsthvsg/M5+EWqLN9+t5ixLGBbYNmlvroY6vAGagjh8ito5f7TVxswdH5ljPbep3QkEmM0B1zxlaLeaLemLkhlM11c6zed4gYNAAvFmsI+3Wsqazbylgt8l+AhPePuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137533; c=relaxed/simple;
	bh=kJHhhrYyKgYKexTzgIwJopTXyxMwS7j9M+0/ZQd5n+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNXL4VIa9YoVyW+ACJENx4VrIubs4kuYkKV7o64RRCVSo20BITPsVK0cuxe6Bcj5TlfaLIyULKKxaKvyhQGvAdxMJ9ttCwf3/ishA8PuhcQ/pmjXyVCQ0Zqsgkf5QkDKOnu+ZffHx6648zoiAsb0pataUYzxIaY7SIPn840pl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HKwN8OeP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so9615836a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137528; x=1761742328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGkRTGtX5VRtNncGlrnjJT92qVOFJfz+SCD1fTkUyjU=;
        b=HKwN8OePDIQ9CBQkdXsLgkvFGNQIDJAVy92gkeKEIe8agIudZlzN5RmREb4axBXTPb
         1SXtaLL/wj8d3uUAgVtpYUijwwHUrhYD0p4+P/mZ5wJyUIAJaIu3a4GJMxX8WOuCIeTS
         jIMw35EDs53rs7U04wphYG0exuxRMruD2AZOanIIozJ6pvuL1lHRRsCXEhLnivh+3mpN
         iX/NaVZHuh6PP4Yf8x1y4kXVRbIxXPNIUy8iKyMBQwREmbEKTEjhAB+FRA+bpljy7TG5
         xPrH2B3R+LqRGtR69jggz+wwGQ/qEKWawXOcFMG4WxZOk/Au8XE9YSsJEpv9tO2hxZ0y
         wtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137528; x=1761742328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGkRTGtX5VRtNncGlrnjJT92qVOFJfz+SCD1fTkUyjU=;
        b=Q2WdxGQfuITj6lXY7FiZbzj8sibqoEk6yc/NCbEQvSJm97yE5gtXJmhS70PBMDyBwd
         SsNijCDNr6AZ6mGmofzvWuccUzGcJaztvUmmEtrG9FW6Lt/tvGwztp1hCN0VvXq4y0+/
         MWkM9GFlF2B6wpdNrZk64V41HneJf9XnJ4NQFdEdjHOJZH00RVq6rGOqEvSlLFqXvPQj
         9wayKCT8LNWLk7x4dmt8ULEENo/bKAIcGBgfSiGHIgiEzsg2fmUIOd/p20WR3qgk1u3o
         0CuL1zMdyRos0NRwaYxSfpiPk7uGs7/9ytrImIlbSOK3DLhLM2lTGvoK1N4LDAeJ7kXv
         l/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv/GN7FwPKv3CItM2potDuAo1Ptp+izEVNg7v2FK4getI4zCILS1UnGXO+SBCGSjFWYa3sZCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3Jifdh1EfeYw+Vnxoc5XpYzXPNOqDEvrokLf1zib9I2ilD0H
	aGO7ZXexHba/o2SK7QJHEHKKEZulqF7cu1dGnlqJlpQ5SITEDSE/tFV328yRfzLyZzM=
X-Gm-Gg: ASbGnctycIBsT7ckZ03GR3EzMmP9RzwLZON8VZqTnRwntGzVo/tUJdT4/dXaLEWSAY9
	HVZ/sDjJ85Ey8vjYS4AfrKSc+w1r8pyOeynMUQh7vqyW8LFbrZu73uNKeqsszLJ1Duw1Rwg0CCH
	5XiasCTgUAWYaaf4eQ673mBepdM4RngZQhZF73coVknEcOm1Ip3hg6bndU3A9sE1c4sZLZugDRR
	V6Oxrh4Hdb01W7OORg3exN8vGJsVw1Lxk9yi780cFwhmacwWN7KblCZTA/nFpoIvROl3oAcwOgg
	4S2qgf+NvLVOePpOS73tHZkBT3yDVOh/fvNbSNevSSuYQBWmfqw5SAKnsMXaMkyQ6L+/VpEneEh
	t2YAUGjKAtmOVXMwEbDOyTA6urN6+OoW95KDlswVpn4lNdiZRrOmW7jjzwD2minytkYT8W9cEMf
	OfWLg87lXI6f7jqexwbE4o65XC2qUBmuwVi/iq2ZTe0pI=
X-Google-Smtp-Source: AGHT+IF6MXbvgO5FjwtHa42y+ByPHy6g3dQa9gyh0FKLccgvNLFAjykW8W1eT0Mf6L2mz1tna6nv1g==
X-Received: by 2002:a05:6402:398b:b0:63a:294:b02a with SMTP id 4fb4d7f45d1cf-63c1f640da1mr15389576a12.13.1761137527911;
        Wed, 22 Oct 2025 05:52:07 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab52b6sm12060841a12.10.2025.10.22.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:52:07 -0700 (PDT)
Message-ID: <5f99d86a-6409-4e4f-8e11-b990d6d99b68@blackwall.org>
Date: Wed, 22 Oct 2025 15:52:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/15] xsk: Move pool registration into single
 function
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-8-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Small refactor to move the pool registration into xsk_reg_pool_at_qid,
> such that the netdev and queue_id can be registered there. No change
> in functionality.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/xdp/xsk.c           | 5 +++++
>  net/xdp/xsk_buff_pool.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..0e9a385f5680 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -141,6 +141,11 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>  			      dev->real_num_rx_queues,
>  			      dev->real_num_tx_queues))
>  		return -EINVAL;
> +	if (xsk_get_pool_from_qid(dev, queue_id))
> +		return -EBUSY;
> +
> +	pool->netdev = dev;
> +	pool->queue_id = queue_id;
>  
>  	if (queue_id < dev->real_num_rx_queues)
>  		dev->_rx[queue_id].pool = pool;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 26165baf99f4..62a176996f02 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -173,11 +173,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
>  
> -	if (xsk_get_pool_from_qid(netdev, queue_id))
> -		return -EBUSY;
> -
> -	pool->netdev = netdev;
> -	pool->queue_id = queue_id;
>  	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
>  	if (err)
>  		return err;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


