Return-Path: <netdev+bounces-86694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFA89FFA0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854141F22C58
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3417F365;
	Wed, 10 Apr 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgoDnO7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9217BB35
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773003; cv=none; b=qcgRWaUvzgC63jeJltrQn1kWhbE6Hds86RdK1z+hyj/06rqhYokTMaKHbzhJ+tvPK+g55pYmU1nDRGuhHAnDzoKHcd73LZyLW0rfhpLaP/A8Ir1AOkriM7XPWZzHD2+/SwXT8sT09/UP+xnZbYb1ahOx8MNtOVxH1ZqTamUor+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773003; c=relaxed/simple;
	bh=pO9x0IyEbfYYyhuv6Ay0cUlhwEO/Fb1/tmk8mv1J7jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9d4e1EqCvzNvkCRsvjtoQKjnHtWl3z4jlJ2GDVOvPCWnB2M2Z3PpC4TN8eOtLD8wHNqWYSMdgQwyPRJaic9bXbPF3ffdI3M9J2LDqAPHwWFBdT8AknVk3FUK4AvqAauE9h3/gVncMeXi92zkfdPI07Hg29rYpzzwM7c20YmC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgoDnO7o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d886dd4f18so43952621fa.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712773000; x=1713377800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnylT+ImFuAYAlZ2eTr248rzDjIWzNMC6ClpV09yqrg=;
        b=OgoDnO7oQu98pdp3Rd59eH0vT5PZiy9FfdQ1FVyKLRGAry3qqUe0/6rYAjV8qwC1oV
         GXNEmH3yMWZcqy5TynMnxaC3MyHdLt6NAP/b6a3HKtCx+7oNMMLZviqpF6ON2pI+kbKy
         EOIq0RtOO64aq0WNANWHbBpViA7G03OUFTAmHlj3Ucsf+wdwoVGSe9z6Sv3wibO8MsDu
         gQyONcZTqjGNlKOi10V/FNind6AA025mPqP+uZ/d3t+17ShwmyZbcU7qHdcYzz6paom7
         GBrOKcuu3iYavu2eSt+SKp10UzJAqP61PDOWrTrMxzDhavBQCaiU19OxzZs3aNpZ5RYF
         Xc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773000; x=1713377800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnylT+ImFuAYAlZ2eTr248rzDjIWzNMC6ClpV09yqrg=;
        b=Djmhn611j9SRsKpAWjiJPOhwjbwnnkh31XOtHoOhJQxgSpxQLGKAINeaVH+c7+/FtX
         t7Gb74qexUeHbAvb7crIbW2EU7oGLc6YQWWHJSJWGBpkpwZY31AqIOeOOG2XJQRtl2Mx
         ytpPUnDwQZwa7cKAi0acfye+rppa8JUN+DZAc54JBwYxkva7m4USrMp/UMpevXG3MobV
         NGqNtP455HwyuJTEJjHr4RzVBZcbDeGsTN3dXo2JIBuZ3T/3fB3DRg+z+wpNj3QQGmvl
         jb7tvkQKgkwb9MfjumhCmask9oYQYjA6AmF3imXIESw3yDXJ+5Bkrdt5K0XlVfLO75Dp
         VIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwcxygOkjRDi7bkqt9qBr/TS1eUHj3XI2skIJe4bUZCK0qz7JqdoNsn9GHLbepGH/H78TmeDZSZMNo5xn6YjB1Rk1Klvh/
X-Gm-Message-State: AOJu0YzCaHBM/IXS7aIXeLAyah3HkSYNpW+5vQfX+r8YBquIfBGmdFMD
	TWz94De5es2F269tRtWKgID2bqEhA+r8MqnHpgDAGGceiuXgDb9/
X-Google-Smtp-Source: AGHT+IHvweHK447Y8j+0aUy9h053i9QIKVzMiLA2t0LTrql8Z5TVCaf5XuoFbqoj1ZByc/3+9RCQnA==
X-Received: by 2002:a2e:80d8:0:b0:2d8:36ee:350d with SMTP id r24-20020a2e80d8000000b002d836ee350dmr2190193ljg.16.1712772999671;
        Wed, 10 Apr 2024 11:16:39 -0700 (PDT)
Received: from [172.27.56.106] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b00343300a4eb8sm14209660wro.49.2024.04.10.11.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:16:39 -0700 (PDT)
Message-ID: <43f4a10f-b5d1-4a1e-a765-c2324d03c6a7@gmail.com>
Date: Wed, 10 Apr 2024 21:16:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 12/12] net/mlx5: SD, Handle possible devcom ERR_PTR
To: Dan Carpenter <dan.carpenter@linaro.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
 <20240409190820.227554-13-tariqt@nvidia.com>
 <ebf275e7-f986-436d-b665-3320a04eb83e@moroto.mountain>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ebf275e7-f986-436d-b665-3320a04eb83e@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2024 16:24, Dan Carpenter wrote:
> On Tue, Apr 09, 2024 at 10:08:20PM +0300, Tariq Toukan wrote:
>> Check if devcom holds an error pointer and return immediately.
>>
>> This fixes Smatch static checker warning:
>> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c:221 sd_register()
>> error: 'devcom' dereferencing possible ERR_PTR()
>>
>> Fixes: d3d057666090 ("net/mlx5: SD, Implement devcom communication and primary election")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Link: https://lore.kernel.org/all/f09666c8-e604-41f6-958b-4cc55c73faf9@gmail.com/T/
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index 5b28084e8a03..adbafed44ce7 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> @@ -213,8 +213,8 @@ static int sd_register(struct mlx5_core_dev *dev)
>>   	sd = mlx5_get_sd(dev);
>>   	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
>>   						sd->group_id, NULL, dev);
>> -	if (!devcom)
>> -		return -ENOMEM;
>> +	if (IS_ERR_OR_NULL(devcom))
>> +		return devcom ? PTR_ERR(devcom) : -ENOMEM;
> 
> Why not just change mlx5_devcom_register_component() to return
> ERR_PTR(-EINVAL); instead of NULL?  Then the callers could just do:
> 
> 	if (IS_ERR(devcom))
> 		return PTR_ERR(devcom);
> 
> We only have a sample size of 4 callers but doing it in this
> non-standard way seems to introduce bugs in 25% of the callers.
> 
> regards,
> dan carpenter
> 
> 

Hi Dan,

Touching mlx5_devcom_register_component() as a fix for commit 
d3d057666090 ("net/mlx5: SD, Implement devcom communication and primary 
election") doesn't look right to me.
In addition, I prefer minimal fixes to net.

After this one is accepted to net, we can enhance the code in a followup 
patch to net-next.

Regards,
Tariq

