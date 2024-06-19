Return-Path: <netdev+bounces-104727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00B90E2C3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BF5B22E29
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 05:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557857C8E;
	Wed, 19 Jun 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BvZr05ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7025588E
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775609; cv=none; b=GGvz456x5zEs3X+/b+chOyMA7Dm8FbzX90LxvfGUoGlJHiOdoxkVTi9hIrpxKLF/Mul0Oiu3vKWhSeuQSg2wqBPcWbAyP3AJVXesACnazeVo0bP9tPq61cRaDsDlLYGXq9gz1LONE8xyuypcyK+0n+pKzcBbm5ZXiraVoJ38lTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775609; c=relaxed/simple;
	bh=cuwyYPJdEccRR7FgxrcvzFghDtDBpdxth6U8JwPL6IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUguUc8fie0b75f4ohh7hL8bMpOQPk0NVc0e5eDa3oP1I12ZdNveggc/eOEkAcktHKzD2OqM7oJ0SS9wLYiCldE08e6Gyq1dKX7CF9YAY2kBMtD+VB3XbHioerPD0fhDZiuBZ7aSuAW2MmMfgqdgX9ayUsstKnfe79ZIO5fVTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BvZr05ef; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2eb5b1917so5304107a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718775606; x=1719380406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/h22X+1AcxVdzXNdguW2P6bgopaMNUUiWIJKLPjngk=;
        b=BvZr05efR85kARKVqmvRpnGHxj/cSJk1JPyp1DefCXAkaacM+9tFvyrJJ2Qwulxxfw
         jn7BXvS0wiBcutk0wt00hbSQZTkCk9Nfr2eeNRdC30dXQgCi1q7F0Ogv6GPu5HD4eeTH
         LB2wSHxCVZoUuDTVk8WI+4JtIJfif6sDAZ6tU1lhWoxHd5Vg73H0PfKmf9rQVe+ReAwu
         UeuohPH/qBgSgQNZsQpM4k4F4soc7rTmLwfOKa0AzKW3FXGjIhLBp9TODyshykm+QB7y
         dwItX6L96sB/IfJvHzEI9fqLOBudI0B/Ex7ujujIIpBn99Uxu5QQblWYbTSnjY/4IEdx
         Ka1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775606; x=1719380406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/h22X+1AcxVdzXNdguW2P6bgopaMNUUiWIJKLPjngk=;
        b=DT8cg7ROhxvJpG0sX0qRlgsG3COK0vJ9U3ocrM0ooEwT7QoKVQ3LkURhCU6UAgR/SU
         NmVtYKmS+wRDLgEB/sZua4BzCNc8+RFv++VHgJgT8/k5IzwQoVue3VuhR8EgtnYE2uYK
         9SKSobEzZgM/32FwJFK9GLgwCQ66ZcFATkwPJebtpMpzhTWwLECQuvxlMtfWg6W63MyV
         0d8Fc8IFTVzJrQTszbAx20hf2x82vX4Te2hmx8NMPwiyxfPNGr5MTD28E22fmp9dLGGW
         EsrgVcADeW/xFIL4qv2m7jlMSza64EPcP6x9/iaBzBhD3jxda/n/yq9/minXqGjZTjyk
         gHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXDA+/ufqoxw3fSGTQdFCwdHTHSvA29a4RQc6xEOKpt4CL7vl7k0ZkuCmjzm9pNhI3qBcdHo4mqLbJ2VEcbTHSoIkfrYizW
X-Gm-Message-State: AOJu0Yyq0Z15P4cFdMtbzUtZaK/DBuynEUrDSWFYYKn65S0GKUVpq2Vb
	luUZfu+Fj8U0OPEwyg+DlQS8vO65etymeY4ELmHTPNEYNkBPtbx6H9JW3DmRWGev00yLJHfgaaO
	wXj42EQ==
X-Google-Smtp-Source: AGHT+IHm0rWTUhUqUgm8kqzy7HT0siE4iAilkLUygbACX0ci3GjA7X0QFHG/egEtGdIJsTi1WsWTfg==
X-Received: by 2002:a17:90a:ec12:b0:2c7:b606:a3be with SMTP id 98e67ed59e1d1-2c7b606a645mr1658901a91.28.1718775605780;
        Tue, 18 Jun 2024 22:40:05 -0700 (PDT)
Received: from [192.168.1.8] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75d1d40sm14238282a91.9.2024.06.18.22.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 22:40:05 -0700 (PDT)
Message-ID: <187e4082-c297-472d-9185-58f08572d68c@davidwei.uk>
Date: Tue, 18 Jun 2024 22:40:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Lag, Remove NULL check before dev_{put, hold}
Content-Language: en-GB
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, saeedm@nvidia.com
Cc: leon@kernel.org, tariqt@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-18 20:53, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:1518:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9361
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index d0871c46b8c5..a2fd9a84f877 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1514,8 +1514,7 @@ struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
>  	} else {
>  		ndev = ldev->pf[MLX5_LAG_P1].netdev;
>  	}
> -	if (ndev)
> -		dev_hold(ndev);
> +	dev_hold(ndev);

Looks safe, dev_hold() -> netdev_hold() which checks for ndev.

Reviewed-by: David Wei <dw@davidwei.uk>

>  
>  unlock:
>  	spin_unlock_irqrestore(&lag_lock, flags);

