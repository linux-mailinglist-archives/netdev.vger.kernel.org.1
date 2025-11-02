Return-Path: <netdev+bounces-234896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5DDC28F5E
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B5A3AAEE5
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B79219E8;
	Sun,  2 Nov 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKpBsPci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717963CF
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762088572; cv=none; b=L7Me37U0VbNjIpuvZ1hebA3nj4QXVsRt5jWFQKVnbOoS3OgqpJ28QpUB6Gu2CYxPIQclQ/CJjwYAEunDSPY2RwoSs2pjYmOPBupBX8+TgTR54CmOobxDRwXYPi7Vj4EjkByd2Ms99vjkQVrZE7aojhPCt+g4SwuP8LmFD4S6Fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762088572; c=relaxed/simple;
	bh=vHtRHt1aeqlb+Q6VqJpLFPdHouXsD44LIjl6xjDRAVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am2J4t8nB0IKURv5a+vWZo4Aeikz+nQZ488Qo/tku8KnkCcmqbDdEp6At8pa/KgTTyQPPbcb9rfSHGhmFRv9VOMH9ZFYyKDADZzCzsCO/6MhtlfvPmvTA98Y7o8RkLpAxmYOiIyP9gyoEGPwhuLuQ3jtWPRxeJpPeNUv6n3Dw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKpBsPci; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2849729f8f.1
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762088568; x=1762693368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD72NHftHXVw+tLTNBDM4x2/4TZWtcG7mkQZCrIMNLo=;
        b=kKpBsPci5HzRDRPx+aAG+9qY11gS47kOUuu0xCp6Ip+WbxHO1zXPnRbHJviIRROiV9
         hvab+CvGUlv4FJtikWub9h/rQIR/mU2JyCi56zi3tWfSkvWTkOIQx3fJDJYX6o5GjNDM
         W0qdfMQOgdrIhzTkwOlrHOQiCBLxZ8tv6QFqxF14Cz425jk9U/WqKYcxSwaRoE69o0pF
         1BumJSVAhFGEJTimDzcwDkZCwMWgIF0EDWrOZKQOTna2lX54Ihp9KMH1sbhCMbVHjzzU
         vyed52RLSKZb6aHL21IJLrMOC6DM/746L/iom0W54keopCZrlTmYbwb28oOjx8qiM1ey
         Cq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762088568; x=1762693368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD72NHftHXVw+tLTNBDM4x2/4TZWtcG7mkQZCrIMNLo=;
        b=Y/gpxeoK/OUrWrGqeRoltu0EDZI1/ihT57LEpLbO7oqXiHyyriHJQ4Jt4R5MlSWBhu
         ae70hQi0uZnBgVx5Tu/zIF4NwOiTOFj4X40FUqt4Zlu01cGp6W9e6tq4jjlCka3x/sQ8
         4r94W0yN/pfpcxDIfcOOR36orQPshOZ7MWTmKtwr0Bq+WmENNz6o+Bc5wOBfZC3/5ys+
         M3306K0HkEizonVc3ABgwUbNFepQSChQI2eaFeifAsEJHlpF5jBmSfYT/sh5vOqgXNsj
         acXksToUVWmKowIwLN36goQmnYZ2t4nZ+HtIyu77Ltax6DZGTESA/sQ5wIahl1gQ2SHw
         +AUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+VZwO+55w6CCw74346u81DIOO29qPBMV24gv/Zm3Ajx7jo9pdiAYQ2L4foiK09+FaC1+SdOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01MaoPNf/o0y2s7HJOI+25MitzxawmfONYrrs8V6B3gDZ8irv
	rBLznBbMOqmnRDZVqoWTdI0Yib4HwdOMR2sLeGGUA8WppDs6dZJIPKho
X-Gm-Gg: ASbGnctrKXk07dHrFsDRyEbtqJcl6//jS9GdjtT+po++a+H7IN06Y/V8NTdkgeELbs6
	NsKF47nFmgeedHAHxljUCRBuRcrNjTtadiw0t3xjfz6QD+8mVidCA6QLeSea02LsoxWGlfZ0PS5
	ddFS+iK8MPO+aajtsiQKnn3LLM0zqaBc/oXMBxSdndcL+MtScBHBdvfnCtUEtAjqUhliNHU1Alk
	7Y3hckp1gvCwjEwKEqAlHwqxJDP07k7ateBJ7Rg2Jt8daJ24MxpXFZy7N5QcGugTI420KMWadFN
	h1JGit45guKWWnR45th8p5o659SDYqXSG6ZIrLJJeNvFQUFlmyykE0bhEbwKN6WIaGpSg8AnXB9
	Bne46apjYPa5NBDaKGSBgU8dykMJAvO117Y3BaoZQAmKkM+g0uEzAygNOnYvywh5o+OeiNgiw8O
	kHosoLGiRADDaFvDxa701TU/wb+sHU8NuOrZd2rm2Jark=
X-Google-Smtp-Source: AGHT+IFx99j6MA6bT6IJoV6WMQC+CHozQ6CCVzhSdu/MzzBdxZex0pghDWW3pisvjT+EfIJBclR88g==
X-Received: by 2002:a05:6000:2882:b0:429:c6ba:d94e with SMTP id ffacd0b85a97d-429c6bada73mr4188459f8f.12.1762088568077;
        Sun, 02 Nov 2025 05:02:48 -0800 (PST)
Received: from [10.221.203.8] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47744ff700esm24474605e9.2.2025.11.02.05.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 05:02:47 -0800 (PST)
Message-ID: <44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com>
Date: Sun, 2 Nov 2025 15:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
To: Zijian Zhang <zijianzhang@bytedance.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com, parav@nvidia.com,
 tariqt@nvidia.com, hkelam@marvell.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Salil Mehta <salil.mehta@huawei.com>
References: <20251031231038.1092673-1-zijianzhang@bytedance.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251031231038.1092673-1-zijianzhang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/11/2025 1:10, Zijian Zhang wrote:
> When performing XDP_REDIRECT from one mlnx device to another, using
> smp_processor_id() to select the queue may go out-of-range.
> 
> Assume eth0 is redirecting a packet to eth1, eth1 is configured
> with only 8 channels, while eth0 has its RX queues pinned to
> higher-numbered CPUs (e.g. CPU 12). When a packet is received on
> such a CPU and redirected to eth1, the driver uses smp_processor_id()
> as the SQ index. Since the CPU ID is larger than the number of queues
> on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
> the redirect fails.
> 
> This patch fixes the issue by mapping the CPU ID to a valid channel
> index using modulo arithmetic.
> 
>      sq_num = smp_processor_id() % priv->channels.num;
> 
> With this change, XDP_REDIRECT works correctly even when the source
> device uses high CPU affinities and the target device has fewer TX
> queues.
> 

++

This was indeed an open issue in XDP_REDIRECT. It was discussed in 
multiple ML threads and conferences, with Jesper and friends, including 
in https://netdevconf.info/0x15/session.html?XDP-General-Workshop.

I am not aware of a clear conclusion, seems that things were left for 
the vendor drivers to decide.

Current code keeps things super fast. But I understand the limitation, 
especially on moderns systems with a large number of cpus.

> v2:
> Suggested by Jakub Kicinski, I add a lock to synchronize TX when
> xdp redirects packets on the same queue.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h      | 3 +++
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c  | 8 +++-----
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
>   3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 14e3207b14e7..2281154442d9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -516,6 +516,9 @@ struct mlx5e_xdpsq {
>   	/* control path */
>   	struct mlx5_wq_ctrl        wq_ctrl;
>   	struct mlx5e_channel      *channel;
> +
> +	/* synchronize simultaneous xdp_xmit on the same ring */
> +	spinlock_t                 xdp_tx_lock;
>   } ____cacheline_aligned_in_smp;
>   
>   struct mlx5e_xdp_buff {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5d51600935a6..6225734b256a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -855,13 +855,10 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>   		return -EINVAL;
>   
> -	sq_num = smp_processor_id();
> -
> -	if (unlikely(sq_num >= priv->channels.num))
> -		return -ENXIO;
> -
> +	sq_num = smp_processor_id() % priv->channels.num;

Modulo is a costly operation.
A while loop with subtraction would likely converge faster.

>   	sq = priv->channels.c[sq_num]->xdpsq;
>   
> +	spin_lock(&sq->xdp_tx_lock);
>   	for (i = 0; i < n; i++) {
>   		struct mlx5e_xmit_data_frags xdptxdf = {};
>   		struct xdp_frame *xdpf = frames[i];
> @@ -942,6 +939,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	if (flags & XDP_XMIT_FLUSH)
>   		mlx5e_xmit_xdp_doorbell(sq);
>   
> +	spin_unlock(&sq->xdp_tx_lock);
>   	return nxmit;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 9c46511e7b43..ced9eefe38aa 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1559,6 +1559,8 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
>   	if (err)
>   		goto err_sq_wq_destroy;
>   
> +	spin_lock_init(&sq->xdp_tx_lock);
> +
>   	return 0;
>   
>   err_sq_wq_destroy:


