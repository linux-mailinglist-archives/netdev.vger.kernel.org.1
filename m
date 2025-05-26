Return-Path: <netdev+bounces-193376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DEAC3B12
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C24168AAB
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF31E1DE0;
	Mon, 26 May 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bns86RnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C51A29A
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246667; cv=none; b=chWjfalkVH16xTeRVK2jvMfRCJ4w9ZEO1n/IsaK/o5s/OTdrUcU+w5g1olXBVnk5IXFK9dUtopr828LX3aOKFnwfS/p+2l8hJy198GPaYwJb6rZ1k3olOUaL9US6qR6yejXowAZTOea6l3ZhCRR7rqHeVY5GfI4AgfY58kS/iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246667; c=relaxed/simple;
	bh=DKj4jGMJwsluLhTtm1XSb43QIvPVBkJotokBx9IzykQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffy0AsJj+MQI4jt3m/mmmH+N+7N5IUHQj22zui5mRMKjAFRsnSM9opy8cKpw2RgNns2sJz7qjaZfio+CZZJ0ffXj9xLjCbAYJZXud5VPcqBjvmMCjMW8POGThU4eSgjg7gqP7g5QiRvxxVeEftrYnVOTkC4NoERu9NJ/N2pRAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bns86RnX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad5297704aaso422525766b.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748246662; x=1748851462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EqSXiGxXEzz4CTzqLi7kZXZnKST1GLrijY4jxIYksg=;
        b=bns86RnXUSYQ17WuMn/xo1SXbKER9aD8VQwT8oR0EolmXttjVzCigXkcck4a4zWn8t
         6lL26FvysTSFzgOpDKs5wiOSpiEwKcmtyRHjRVTgzvoU1ACR0vBDDbV4EIjvGA2s3PZl
         IeNbHR4VJJlHF88T93t5niZdgT/3eru6MOput90j0ZKHxmsT4evySdBXFdvD9Se808yz
         AQbCQvV4EjaufYx2eHm186akiB+igf8smPXtm9snXcB106g0knzPl6bFbY5FdiNuCdRz
         zbm2sas4eu4uncwihYvgQZPfnGYSbVA9ekPnravqwIai4O7DiwLDWgRTeSWi1y6MNgGO
         sYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748246662; x=1748851462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EqSXiGxXEzz4CTzqLi7kZXZnKST1GLrijY4jxIYksg=;
        b=tQRQdPUlGolAmUrcoWqlV29fH3VOez6VDSgQQVWcrjXmpyDn1FLX7nwzc6uTtNcebv
         W7cT9Rp/SplqxVncAepvxg3D3yJrjlmYDNlnhXZf/UQEmzhEoUeFOBP1/8bEM7pRV87W
         2p01vtK6Ha4UkLhmRs7XoI/EL+GEQCMwIfqI+sZNzIgN9BGkFC0FOenX21l71204nY/T
         WqAWmJndtkQlqdfyWmMqqrwYvF8MEhWaGHjP0BY3W0rE6lLzR5uKLRgOAbfyQgwfEj7v
         RUGAJ8madlYNqcgNjC4lyvFFLv6bMSeNh2dJ9FVSAc41UcEenzgMTYuPPIdE8uxNH8nH
         3KBw==
X-Forwarded-Encrypted: i=1; AJvYcCXk0itDaxe5HQFCDPhYBiB5ryxeR6KVUStRW6TOgvovHAdsVl1XAIp9qKS9wS+ZdK7D2FgXgpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykBglcNYkrfZUIKbZtUJFkeBR2dA/67oEdYIFCstsY6Rl2DxZe
	lObCAJ8AS75lhPpVPiZEuSLT4WlisqRUoEArpjwuGlcKoOJjeOwtRW5uvttEF7tWOYM=
X-Gm-Gg: ASbGncvLCRV63zSQhjSNKsmloZpO6aKRc2qwQci8sh8XlN13nXh6WCWC3L7FV5qFdec
	I21PQyIzipNg15tlVPO5fsdgWBNw+Q+ID1mLaE2qxPO+QylHXZkPW5Px3OKjuOX4huyKqQWcb0C
	nf1VPdUNNSu5r9TmFE9Yn1SXIVU9F/uQM8dX3mt7oDR9Tca0vTyx00BPXnaDSeP6i6Kqaj2OpCc
	IYT0INi4rkoAT4uHDD350Ek4xiri9mPSXPced5eWvcL3Hhj4XQxM0P0bVWHlfteblOkg7u8xswa
	VZnMEKgLe0EZOAPJPS3jS3pSjgzTCd/jE8h8OnweqmZ3uCKJTwsEzhZqfIs=
X-Google-Smtp-Source: AGHT+IFQQixy/VvIvZqVFDIkQNPaQDo10Gudza//G/gS6tJHfmV5TcIjld7nrBM3z67ERb/Rc4yYRA==
X-Received: by 2002:a17:907:7faa:b0:ad2:59c4:83 with SMTP id a640c23a62f3a-ad85b2b5649mr715969266b.42.1748246662344;
        Mon, 26 May 2025 01:04:22 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-604be9d8ca6sm581136a12.79.2025.05.26.01.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:04:21 -0700 (PDT)
Message-ID: <8e1250b2-b6da-4294-b02b-98c9d231a181@tuxon.dev>
Date: Mon, 26 May 2025 11:04:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: macb: Check return value of
 dma_set_mask_and_coherent()
To: Sergio Perez Gonzalez <sperezglz@gmail.com>, nicolas.ferre@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org
References: <20250526032034.84900-1-sperezglz@gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250526032034.84900-1-sperezglz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.05.2025 06:20, Sergio Perez Gonzalez wrote:
> Issue flagged by coverity. Add a safety check for the return value
> of dma_set_mask_and_coherent, go to a safe exit if it returns error.
> 
> Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1643754
> 
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index e1e8bd2ec155..d1f1ae5ea161 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5283,7 +5283,11 @@ static int macb_probe(struct platform_device *pdev)
>  
>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
> -		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
> +		if (err) {
> +			dev_err(&pdev->dev, "failed to set DMA mask\n");
> +			goto err_out_free_netdev;
> +		}
>  		bp->hw_dma_cap |= HW_DMA_CAP_64B;
>  	}
>  #endif


