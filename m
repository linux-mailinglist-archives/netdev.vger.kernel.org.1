Return-Path: <netdev+bounces-221982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E1B528A4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E4E1C800B9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494192580E4;
	Thu, 11 Sep 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB7JAtkl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD211CBA
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571753; cv=none; b=SFLRPWuLJhgbc0rdB+j6REA02j58c6uTXKOtnOO0FUA/8OVRiOAH3+gaIHuMw0BTGF9OokjNmGfOp1oKK13CncXKuHqPy7eEc4v4nDV+eIbJlGSHaKOUVUqDt8zGWy3EOU3Ca8UmE8fD+WdhkjiJ6b24ez08os023o/zrTD3ZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571753; c=relaxed/simple;
	bh=hlj60Y3CDwbm3ISUClYbd/cRw9Aw6yeqtaG6vuuuXSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slu4n2PAqdRTk2fN7LlhyfVUGVlN/Qr73ITit5S7aeJXd9GnMJiUsy4Ll32LdYqmN/Uavv0Ra7gTeUVWFOInWaerqKausKWIzMNXbn4aIItWOhfcAIW3pfYbrRByWvUa3aAjwMr0wcBbRniQ0DGhERKa1DgBZNn0rbNUFGw7IXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB7JAtkl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dec026c78so3287785e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757571750; x=1758176550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDPel/ZZYGzbUTLwzSWpGQzV6w/4oCA0HWnxnn69Plw=;
        b=XB7JAtklpU0SngvoNk/AF5LLYyCMdY6pVqKQDdZyIRGCUs5Ixk3fFj2p4s3knqns4l
         rJLPpVnZmTawqUY5mUKmcpHqHnLaSD3k+a8k4CZq+V/pMUcTYXUijOPH6/Gi09BDitzH
         kxR+D3m42/KVRHVAsoYu7Pj3C3gnEqQMalLYqt9LbHoHO0R42Q7zPSHcAxTlygVszWCF
         bBLDIyyhIcuXOsa1ApdI5TkkPpMV2JmS18tyh9IzjH4J9STeCejQiHhP+VG5MRKMi0Hh
         1qnTKzvA6zeQaXs/BpazirMD/RM+fLFf2tEylK5Ii3bELxMBaU4g7RbqMFKbdDhQdBZy
         /NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757571750; x=1758176550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDPel/ZZYGzbUTLwzSWpGQzV6w/4oCA0HWnxnn69Plw=;
        b=gZi9NYUcsP2QsILxJp1XeTS+DXWFgKAwJ5wGtPvUhgsIvo4Weky8BmJwxexOYMnL+J
         oX0TPfCVfW9t0ijbdLdraSLYidUsczC8ZUGtAJZgj7Vin3fTST/CbMcttlJ6ntXOCzWT
         BkiGnMuKj5hLnym6+VxezWSJSv83SeBSgSuu7en/1evq6TvrrsoJV0YREORvouhoXCeD
         Iiqsu6L1UhofP1WVDPrus2JnI6gMaFtlvGNFdIFkWoCOUJi2UBO+HpWMtxh6ixQNahA+
         qNoW02euAJqscYYVKA+TGLuf/ICAdYt0tASmN9cKJrfEp6FNk4Et3EIIPE1DQBnQwfQc
         8i5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/ktdrOLDd0iyG+QAxk1mLzyUASAxG2DZB9N4VEeXBV+u/PokF12CTwUmFkzpiiAT7pm2AJk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuByuxLssQiCUl7MgQedr6vnFKe/Q0n2l6A5ABlMGCQdJUMRmG
	Koyi7WE98Wp/NiORPapspQQjjHMUW8f6WQb+FrjNS/3MLT3eFEOhg7pz
X-Gm-Gg: ASbGncsT3fHLcOzFyWYteYy1lu9kP65mTs5Vn6AHpEboOkSJSYKJPsuz8wuv8bJc+IJ
	Ix6ewOrahgUfbdGEzt2v1hh0zdA3Sfg+SXmWyfIwV0uh07j/3Ked1cP8BzClliZi8m49IEMU+9E
	NzZz5ScXnmS7B5oq7POdi8r1mOhb7b/7CGwafQzwjKKcQokAgXoBFZOVYzPbVNvi/c3tD7P440w
	CleoBhkYy8iGt1Y+yl/0FI94Y8RarDEsD5fzEfXewQGcE2exVMoTY7ZD16ATLhMSWTpxNCPN/uC
	2rwnJ8eR2xLxGbQDzx33uTdDv/9yhFDiWoLokPIYs2fL86X2e+XWXNOt5CDKAuRwP1nnA55xuO5
	fBJuZn0pGh9APH23MyZPkbfn1SRrGM2r3a2A1ZuvQqQNXIXDXliCkdM9T
X-Google-Smtp-Source: AGHT+IFOh2GnWE2Fc4mkohprUWPhu64T3O26zygTZbKC+3ebA83Fv9+zbu+AQRGqoCzmHKD2yQx5gA==
X-Received: by 2002:a05:600c:1e8c:b0:45b:47e1:ef6a with SMTP id 5b1f17b1804b1-45ddded5aaamr156724495e9.37.1757571749699;
        Wed, 10 Sep 2025 23:22:29 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015621a3sm8402715e9.0.2025.09.10.23.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 23:22:29 -0700 (PDT)
Message-ID: <121a7d8d-6918-452d-9d81-413a54d743bc@gmail.com>
Date: Thu, 11 Sep 2025 09:22:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: Not returning mlx5_link_info table when
 speed is unknown
To: Li Tian <litian@redhat.com>, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Benjamin Poirier <bpoirier@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Carolina Jubran
 <cjubran@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
References: <20250910003732.5973-1-litian@redhat.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250910003732.5973-1-litian@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2025 3:37, Li Tian wrote:
> Because mlx5e_link_info and mlx5e_ext_link_info have holes
> e.g. Azure mlx5 reports PTYS 19. Do not return it unless speed
> is retrieved successfully.
> 
> Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
> v2:
>   - Fix indentation and spacing only.
> v1: https://lore.kernel.org/netdev/20250908085313.18768-1-litian@redhat.com
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> index 2d7adf7444ba..aa9f2b0a77d3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> @@ -1170,7 +1170,11 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
>   	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
>   					  force_legacy);
>   	i = find_first_bit(&temp, max_size);
> -	if (i < max_size)
> +
> +	/* mlx5e_link_info has holes. Check speed
> +	 * is not zero as indication of one.
> +	 */
> +	if (i < max_size && table[i].speed)
>   		return &table[i];
>   
>   	return NULL;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks.

