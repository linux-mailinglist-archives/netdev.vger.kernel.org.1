Return-Path: <netdev+bounces-98125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9ED8CF8C5
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA91F219BC
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 05:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93731C13C;
	Mon, 27 May 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6nalNrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96D3BBE2;
	Mon, 27 May 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787797; cv=none; b=OKFuKwSgq0FlikSkxl0tgSp2XK8HH0hGIrt3DV0HDe2X+AmaApK51+ly8p2OxW2sPeSieL7wn7G/hN1rlQ5TOqcEo53hD0bmIkFcl39yvA1ubUnEzTb2PY3OGoV23nk60RiD+2N30bXcj/uOfkl/UHw+wormk77lsb23DHwptFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787797; c=relaxed/simple;
	bh=RY2GAdnVRrvLXregMrzh7G0FGtEifQ1q4+sMzLagkqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIQnXjIj2tel3cfUa5YW2Ud9nZcaF6ETBi799yyfWxzwJTUfXmyQHgooCh1dmDqE3CAV/GNwhh5Yrx90DiHgs1vUbzp2BGzzFRiIDHr3IuPH+9W1CAyAiHKFE4vhqqARiS1Tk/pp5drMhGEVFBcHSBGonNadWyD5eXOw+UBiuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6nalNrQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420180b5897so42360765e9.3;
        Sun, 26 May 2024 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716787794; x=1717392594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHpKdJ2Jnc6g6Omnv8B6n674Ws6YYn77dRRFOGAXs/I=;
        b=l6nalNrQ3HoAl3x51eDaurqAEzmxVKa2FBK2ijSyNIA1EIY+isfHHnPvpAaPuK+5b5
         JpKb7itRGPC9nzZjNCxqetTFVmHq95tuXJvhvHvw61Y07Pc659/dG86drPW6xdbqpD2X
         9v//JLHk3r33H9fzpJP1X4MVF4yID4h54nvhMzwgANR0y1wj3uPQgoU+KbvbOwptllTG
         5ol0Q9ASvPSZkgybkAntnkD7CGj3xxAEYrws/U+plsj1IPzL0HEZCV+DnIWZ+/j9wo8b
         UqgcooLMKUIBgiMAh0yGZ9gBmo60OHpkfr4TpnJ7PevgfNEmnOt1XROf9RDjeGb4iuBt
         mKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716787794; x=1717392594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHpKdJ2Jnc6g6Omnv8B6n674Ws6YYn77dRRFOGAXs/I=;
        b=nc90nfZ4/Bn+exusQWxth3kAYge4iOfWYcD5D8VSKkRHPvqf5YMrs076X3dtnrejG3
         7u4fCf2El1nY0xGT7ol9v0Oa6FZcSrlaoqHCO+W/4i3Rk4Pauof/C3AyhqCfS3QyXYdx
         O/QnDR3AGTNTsai6s8PCuE/gqkgaKYNPVLqaRT0kTGTLzJv092A2DBXdgrS/1qIIP9pw
         gLdc7bVy4zx0yZ7DOa3+pCleayBAvaGIdOQknEvjeCoXU0Of4Gf30eabBGZcEGdV1fG9
         n057TYWNRwZCsFCKDWvqvkBtCYyRct9VsU2YaCcDH/vb6CzpU3lkansMFRfvGUI/vEbS
         x69w==
X-Forwarded-Encrypted: i=1; AJvYcCUWxmI6kOm6tAUXeOWwkfVxCjVfc9o12iizhmxgbBi2WV2KzPhwSJ8ecTRBtCOpBmnyVb81QSsRfouHPJ5pbvzrUR+tyaK/lgwXImuUolnkhwJ2ZiXL1NUqLm+7c+UHucUQdLZt
X-Gm-Message-State: AOJu0Yytz2f2vGMEiylBfive4luzchU4Js2dnuy7bH9I2pgPkcOVYHyw
	thRZeNhEvlFgcg6ENuDvLd4hizHspWpY2kuMJV4BpU6NDVW+HMk3
X-Google-Smtp-Source: AGHT+IE6XN2w6i1Y6pGp3mMAX47xT3ECFpi+uTvVB1MZgywIgIKg3reTbMdA48R9tJ7Q5/1mXw8Tyw==
X-Received: by 2002:a05:600c:3b9f:b0:420:29dd:84dd with SMTP id 5b1f17b1804b1-421089d16f0mr66023365e9.3.1716787793975;
        Sun, 26 May 2024 22:29:53 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de62sm7940043f8f.6.2024.05.26.22.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 22:29:53 -0700 (PDT)
Message-ID: <57520ee5-0d7d-40df-8edc-de85b1005453@gmail.com>
Date: Mon, 27 May 2024 08:29:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: ethernet: mlx4: remove unused struct
 'mlx4_port_config'
To: linux@treblig.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: ionut@badula.org, tariqt@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240526172428.134726-1-linux@treblig.org>
 <20240526172428.134726-4-linux@treblig.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240526172428.134726-4-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2024 20:24, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'mlx4_port_config was added by
> commit ab9c17a009ee ("mlx4_core: Modify driver initialization flow to
> accommodate SRIOV for Ethernet")
> but remained unused.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/main.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> index 98688e4dbec5..febeadfdd5a5 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -169,12 +169,6 @@ module_param_array(port_type_array, int, &arr_argc, 0444);
>   MODULE_PARM_DESC(port_type_array, "Array of port types: HW_DEFAULT (0) is default "
>   				"1 for IB, 2 for Ethernet");
>   
> -struct mlx4_port_config {
> -	struct list_head list;
> -	enum mlx4_port_type port_type[MLX4_MAX_PORTS + 1];
> -	struct pci_dev *pdev;
> -};
> -
>   static atomic_t pf_loading = ATOMIC_INIT(0);
>   
>   static int mlx4_devlink_ierr_reset_get(struct devlink *devlink, u32 id,

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

