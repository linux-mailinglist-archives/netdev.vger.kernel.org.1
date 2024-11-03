Return-Path: <netdev+bounces-141271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895299BA476
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 08:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BFB284EB5
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393101632E8;
	Sun,  3 Nov 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Qtwz+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F1632E6
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730619261; cv=none; b=Aib82g0T/25fDN18QuTIbNVmLhZXtcL+8TL+RhTr4h3VBKFvecA4SYdSkZSKveGUDOMmqkF9nR4zMif4Tau0Lynu38VI41sJtTD0siqYye5UdNFcY5fgadBoZqc3QG2x9vHg283jtZshsMfhaydH/amKOOzpk501DOQKaIGLnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730619261; c=relaxed/simple;
	bh=1FNGSblDN0jZ8IDDFpqethRIif17Q6AjZ/R8cTSuDPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP51Zgbe8FIXWTckIdQxmrbylqRtopcG0YnLzB+8MjHs/HOfWlXN/gzMErsl+bVqQAjHNtNTwARt8j1oU1YwWikjghvx+cFcl3hestgbsSbtORvIS3ZVYhFW+6DLO53Fg8yR3D9sWgUIxMcyGRor1ftHxLIS0HyCo2ttLFc6F7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3Qtwz+3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so25987445e9.2
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730619256; x=1731224056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKzVQLdiajGP09+NCSUCT0OQElmib/rVJohuMv/8YLk=;
        b=C3Qtwz+3cnomD+xD0BkiYql8zIl8TJxreyKjv3InvnStWu0/SxCXxbpbEXmOONULFw
         6LkWbYGIad3+RTiemYO5A7udnr7RekxJPVsLJ0fhc7bGYsBiKMbLK4FOkbn5rgXMAwTB
         SlsZ6AH4eFgL1O2RP0Ntg1m6KkyIR0UXYxGKL8k3t3J+nEduk9RCLnmusfK99gBOzcsi
         NChIoNpqYYt3poDq7nIGHXinFrengSRZ+uBq4IV5sXQMuflVD/jCQDKpWcMg96MYL3dx
         E7MdHI5VydY0bsIq0BdOLIbWBM0lsEGVs4KVVtxFyVXOy5stWaOXigzu9yFQCX4iorpj
         8v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730619256; x=1731224056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKzVQLdiajGP09+NCSUCT0OQElmib/rVJohuMv/8YLk=;
        b=QiRhirp7BwVSTgXgwAZ7TN7xgBVEDn3CxD3fq9OqUPfvYzNi1GbnbVFXGzNwF8Rip+
         HB6s1HwFnj8DqWAh19Nlg73BtbSSaes0K3ytIIgYJ2IOXNZ5pNpdBuMbAfvN6d51vWYS
         jA7+EB7N61kvssXUoVNIU9E6gRSUQbgJ16wLfI3NsCQspoI9xZ/U3i5iUdTexvunSayL
         zUJcvyuijmH8jazwfE4urElkDZHYaFFtJznXvMaQuohI45do693dsqnI5lunNs4N1yXH
         8jKYMlGhxXeXv86xCvxWKU+Ole060fC2CROZ8/TIp1yq0KL1hSLFUBRd2Qg+AMU7Xoup
         qZOg==
X-Forwarded-Encrypted: i=1; AJvYcCU64AoQqV/VJvZOkg5KOLlFiJNkIil2jjXxkd0QeP9dAc17RuP/8UYKq+E/ItUmVHHUZjC6bUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CAVNWhEVWy9mIo7PIomi2NA9aYBMr8q3FOmwDKF7q8YvS3pD
	HAlcpiRrhjzMTODFHkbps88S/JtFsyTi5FOEvwEj3N7n7FfopO/j
X-Google-Smtp-Source: AGHT+IEYKPVgS8E4PSstBiyUBxci2z9CHCE7uSz85hubEoDihPkAmuwpDNBc+g432KE0hGGHwHw9ZA==
X-Received: by 2002:a05:600c:5246:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-4319aca5a1fmr253758005e9.13.1730619255402;
        Sun, 03 Nov 2024 00:34:15 -0700 (PDT)
Received: from [172.27.52.5] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abdasm10064585f8f.97.2024.11.03.00.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 00:34:15 -0700 (PDT)
Message-ID: <f1b53677-7432-4343-af63-b29bf5b17e0d@gmail.com>
Date: Sun, 3 Nov 2024 09:33:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net/mlx5e: do not create xdp_redirect for
 non-uplink rep
To: Daniel Machon <daniel.machon@microchip.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20241031125856.530927-1-tariqt@nvidia.com>
 <20241031125856.530927-6-tariqt@nvidia.com>
 <20241101132214.7m65kp434b364apl@DEN-DL-M70577>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241101132214.7m65kp434b364apl@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/11/2024 15:22, Daniel Machon wrote:
> Hi Tariq, William
> 
>> From: William Tu <witu@nvidia.com>
>>
>> XDP and XDP socket require extra SQ/RQ/CQs. Most of these resources
>> are dynamically created: no XDP program loaded, no resources are
>> created. One exception is the SQ/CQ created for XDP_REDRIECT, used
>> for other netdev to forward packet to mlx5 for transmit. The patch
>> disables creation of SQ and CQ used for egress XDP_REDIRECT, by
>> checking whether ndo_xdp_xmit is set or not.
>>
>> For netdev without XDP support such as non-uplink representor, this
>> saves around 0.35MB of memory, per representor netdevice per channel.
>>
>> Signed-off-by: William Tu <witu@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/en_main.c   | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 2f609b92d29b..59d7a0e28f24 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -2514,6 +2514,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>>                               struct mlx5e_params *params,
>>                               struct mlx5e_channel_param *cparam)
>>   {
>> +       const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
>>          struct dim_cq_moder icocq_moder = {0, 0};
>>          struct mlx5e_create_cq_param ccp;
>>          int err;
>> @@ -2534,10 +2535,12 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
>>          if (err)
>>                  goto err_close_icosq_cq;
>>
>> -       c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
>> -       if (IS_ERR(c->xdpsq)) {
>> -               err = PTR_ERR(c->xdpsq);
>> -               goto err_close_tx_cqs;
>> +       if (netdev_ops->ndo_xdp_xmit) {
> 
> Is it possible to have ndo_xdp_xmit() set, but *not* have an XDP prog attached
> to the netdevice? I see that c->xdp = !!params->xdp_prog - could that be
> used instead?
> 
> /Daniel
> 

Hi Daniel,

Unlike drivers of other vendors, in mlx5e we have the 
egress-xdp-redirect feature enabled without the need to load a dummy xdp 
program in rx.

