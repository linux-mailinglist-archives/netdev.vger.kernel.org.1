Return-Path: <netdev+bounces-189512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F6AB26F9
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5245188E673
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546A1A0BC5;
	Sun, 11 May 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8k7VL8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F912F399
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746948101; cv=none; b=EqDB7xG92SQpbeqOpY0AxQTygL80pNx05xSRpMWx4P151psNEmscUNclfe3825rNXgb7vSOt0MzyGz2K+l4WUf9poKJlbXaWKQFOH5wt/4rn1tabhCXuDhbcAZpwUPTzpVT+8OBnWa76l0ZcvSaqqpWkaYUlA6kRVr5tke/k5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746948101; c=relaxed/simple;
	bh=UW0MMcZU4gJacCtL6wnOvxF6sAcQZo7HHk04/8VpgtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeYRmNGbRmsi1/Ewru3abruZezSUPL/V6Lp5nG9mUlOjS2pxH8AgNpRNbczQ5HQNPKfe0OnwxsDTQ2UQ0OLyNfwNpuIB7saFVL2Em6Er4ozn8FedaCf/kISLP054haf7bGhWThkXujFcI6nUdSHSTXoB3b0VI/Z5ocuOfkhFNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8k7VL8N; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so6283235a12.1
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746948097; x=1747552897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIyPjXEBeL4TsVcUb5wc72dnDke5CFgQ8JeP4LvIQvo=;
        b=F8k7VL8NbloJi89xzBqAWekM2iRxfxjJRbAedJSR9q0rRWshNM/C9Saryo/6/zFZFe
         xRk0ueZHXClh3ybbjuxYpTtcHzPaC/6Hs9Zwl5C2zJCxvqVYKTftmw/XuVJEcFar8kR0
         Zwmt9qoqbv5jl7JMf3GdAODpnPwY0Vss1cdTiOc4TtFPccr4fopGo+WdVp8hoU1qmYm4
         RnQr38+b4a0F7FCOeWUSi/eKbCJqBqpvkNR2s+a7HgwSulT3Z9koBGg4qsxY+w21Naqm
         g2FRqnj1lQepxXrxQMZV4vyL58MIwYbV4hZ1P/4LeHDSXUtw7Brrbklsdmtc/8S4DoP9
         jQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746948097; x=1747552897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIyPjXEBeL4TsVcUb5wc72dnDke5CFgQ8JeP4LvIQvo=;
        b=U8kWlE1H6rdSixc8ZkXMexhPNFkIlMTK5IWAq9vew+8uUDBSRkjeFrmX/BbTzTyvOq
         8cLlODmj4KGk7uoa5gFL2aVLr5vFhjCQZRjYKxME0hJ2GdEdNZuEPjKf1NNams+XBPFO
         upBaQF3gtBx0Xc1adizLhxXR57wXBHov8rhtCELfxLgR14l+CIkdGuNvfs8jraQLebyd
         jblCUOM7frd0i9lNSKr3lFiMJpag3SOQ4Q9feocrEBJeXtAcivdwLvJgiu1Gz4qYF4qi
         XgCR+oXThaULktj3oVsteoWICIJfB/466ZBE/HGV6eB7mlZCdyqAehFBCufqBF8uhW75
         7w4w==
X-Gm-Message-State: AOJu0YwZ8drsCOJIbx++jHvdOLQo2JGOfRgHG19AMegmTvA6WdUMk3lL
	b/mdQzvRu8rzBikYWo88RGxz5A/GA15goyQ+uyM4YYQXe7DGS/U/c7ju/Q==
X-Gm-Gg: ASbGnctSFKCF6uisYOpeXgnPjHroxAhablEtfuUb6wGQkzfH3/Oa4+V5FX3jnIuIP6o
	vUu4yUzwIhVAaJ/dcSICzXZzSvuHj0H6pz19EIhOqf//3MCeJYueAKM5LPLlYoX7UabQfo8NEW3
	6YNhE1i57NwzNhjahiraoWD4/3PNZIvp+b+eIrXCJjim3RuV2ImVJ325/ARCgVO7HX0aTrh5l4o
	7xL/Jmeex4DXpytzT0aXeK3xbHCgKr1wj/evCOXnMN0oUJHlV/KhGbMVl4HTaocqVqvN08/zg9N
	PyABFX/kVbi0w8Plkq6yCrCGehDktAAMBQIo3UiVj3NmtA0M72q0VnHKQVwfyn+SRCxmTkv1
X-Google-Smtp-Source: AGHT+IFBHwu59h1u7uW2E+5TUCKoLoBIqte1zYhh4BK9mT8qGxhhzc7gD5PzCSFo1D0IB91mAkNMsw==
X-Received: by 2002:a17:907:7ba1:b0:ad2:4da6:f573 with SMTP id a640c23a62f3a-ad24da6f7b0mr103554966b.41.1746948096987;
        Sun, 11 May 2025 00:21:36 -0700 (PDT)
Received: from [172.27.62.162] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2406eeadasm170322066b.97.2025.05.11.00.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 May 2025 00:21:36 -0700 (PDT)
Message-ID: <5d953d23-284b-4388-9421-89e0750cda7b@gmail.com>
Date: Sun, 11 May 2025 10:21:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag
 when getting ts info
To: Jason Xing <kerneljasonxing@gmail.com>, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20250510093442.79711-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250510093442.79711-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/05/2025 12:34, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> As mlx4 has implemented skb_tx_timestamp() in mlx4_en_xmit(), the
> SOFTWARE flag is surely needed when users are trying to get timestamp
> information.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index cd17a3f4faf8..a68cd3f0304c 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -1897,6 +1897,7 @@ static int mlx4_en_get_ts_info(struct net_device *dev,
>   	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS) {
>   		info->so_timestamping |=
>   			SOF_TIMESTAMPING_TX_HARDWARE |
> +			SOF_TIMESTAMPING_TX_SOFTWARE |
>   			SOF_TIMESTAMPING_RX_HARDWARE |
>   			SOF_TIMESTAMPING_RAW_HARDWARE;
>   

Thanks for your patch.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


