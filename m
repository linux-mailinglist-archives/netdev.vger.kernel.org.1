Return-Path: <netdev+bounces-158739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF25A131C1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BC27A130F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24178F47;
	Thu, 16 Jan 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRoMI44Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B6225D6;
	Thu, 16 Jan 2025 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998177; cv=none; b=BMjuayur/YfjROMgzCItJTrikeT6YjZEQawmrmF7X16A+HFfDjfdnjAZQJlgDcE2lCtMVdnqLUJL0OHK5T/f9KwFkCqrCHG86eYJy7QZswpl/1C3zul6xXsOprWfkBHYyWegbzCHLga85M7E4jNQVGTbkr2jUIrwbi/NY/26Tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998177; c=relaxed/simple;
	bh=pwZ/jOf9SwLdlxbtfzZKMIS6PPz2M3rnR+TNJOWDS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGJkpgNVvpnYKFK5TXO2l0MBt1qmQu4Mac9ffNzCxfCls6iUFRj+L2Ap1L3JyzcJClU8gk5FldLSGqg+maZ9YyI7axaLDM/Oo4D33KKGfd+noEQ6Af236yatWJ4O8E87K6BzdsgoKANNRB1BG4dLngDj7AXuPMm8gdMvmKzTVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRoMI44Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216281bc30fso10021505ad.0;
        Wed, 15 Jan 2025 19:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736998175; x=1737602975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lO4SV4fEBS5/b96bWFRJrbo3YeXzbwO/hDMej2RItM=;
        b=cRoMI44QN4+b3OTsfHTX0NkExRzgTHvoKfr0A5U3cm0ZHB0CNi4Nl6aMa9vMQcx55E
         t4oFcLRqmwTA0eyY7JEwurhAa1oG7nwUqWbd6baV4TATevNGMQxgV2Y6N8dniBqHpfEl
         ZaVYIPCTFZ9xeEK4n7JS3FnW68vGAOppqXtT6Sl3NKjRYWTHgFzAMcSmIEJjusyQ7rNL
         GEEYIV/DSQo5TpsLtGTOf5CcPehY4NOJxhdldu0Drm1VwUQairwsoKEU6205Yhb2Ayrv
         3SRvhcBCS3Xo15W4aZ4buLoLDkEAtGIR1uF++yoi0tAZtIY/B6LVkADNuCUbcHVjXCOr
         KkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736998175; x=1737602975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lO4SV4fEBS5/b96bWFRJrbo3YeXzbwO/hDMej2RItM=;
        b=Zq4MYG0TmoMV6SzrRnMc3eQ1D+Gk1JNbGVUr3Z5Vsp5w4Dx2Hw4Srlx7LRABVM8Ebg
         LMrkMY1gXoeGVxhM8gpveK0zXvIrjdCBXJQqk3tHXU6xTjooNRY2sqaVQHImV4AaoDsQ
         yGS77JXvcIWiFcGfYHXWMCr+iCZV16sZUN0idRSIFRQV4T5ER06snchRsRhxSCFldvCN
         o3O5I2nHouEXy0gY5T9402hEwTpmqVFxDtpDjFchXeT7noNKRrKMbg9d2V8MuCVRIS4r
         KIO6FiYjnTjllubjyWJQXgUHcaw8W8zfnsVFQLwy6GzJcJVN2/OT9zUzX8ckiw9usvBw
         Fn9g==
X-Forwarded-Encrypted: i=1; AJvYcCWfxf3wHq2+UyJK1rpUCa4F2nN2kAaDM2na/LHwoILe7/jtR7VHLZZk3TP7muOfX4fRKGyj/jplOEoqE3U=@vger.kernel.org, AJvYcCXUQZKP+tjlMFviUICgzzIkS1UE3qU81ByevbFvg5xFnTXdnXyzvnwjGyJHbLt8IrDih9foAQEH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuz+iaAYe16Sz7JQbNC5OEUHWuLQk8W6FgnIjoO4IWk1cPKtHm
	0FkKSEa5Sa/hPl6VMvCYsDfaGdyfqRTFMNmZNbIpJNhj/0aLdbt8
X-Gm-Gg: ASbGncumIp4mQiPQJec5Q66A2DRnTl54uAX9ldayNE4H2cmFi/uV7tqAvbwn6DqjXdL
	TJIKE2soWY2DglEteRU5nVf0tWI83Ie3+TVHhiMjKnf/tE7iO+b28yzTFXTrXq+EqgKIHEIpxaN
	TXiDjG68Y4BQrsKKFt1YfHsyCT2DXHLSsY4HrfTmHcoaSYREXDw2RX+i/iKSJs5ujWbDIxXyLsu
	h67vY4vLjRsmSFXAM2COVQ2BFM4mPZlqvsEAs8CZc8GbZlw6qYf0g==
X-Google-Smtp-Source: AGHT+IFr4zEeT47j2D8gtzZWCg1S+zmWAQ0RIesr8rmwvuje/OY6uHzv86ok/2YKYD+fA6X/sRXqeA==
X-Received: by 2002:a17:902:e5d2:b0:216:591a:8544 with SMTP id d9443c01a7336-21a83f672f6mr499273395ad.34.1736998175008;
        Wed, 15 Jan 2025 19:29:35 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21c49fsm88127385ad.118.2025.01.15.19.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:29:34 -0800 (PST)
Date: Thu, 16 Jan 2025 11:28:14 +0800
From: Furong Xu <0x1207@gmail.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: Limit the number of MTL queues to
 maximum value
Message-ID: <20250116112814.00005bef@gmail.com>
In-Reply-To: <20250116020853.2835521-2-hayashi.kunihiko@socionext.com>
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
	<20250116020853.2835521-2-hayashi.kunihiko@socionext.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 11:08:53 +0900, Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> The number of MTL queues to use is specified by the parameter
> "snps,{tx,rx}-queues-to-use" from the platform layer.
> 
> However, the maximum number of queues is determined by
> the macro MTL_MAX_{TX,RX}_QUEUES. It's appropriate to limit the
> values not to exceed the upper limit values.
> 

The Fixes: tag is required too.

> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index ad868e8d195d..471eb1a99d90 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -165,6 +165,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  	if (of_property_read_u32(rx_node, "snps,rx-queues-to-use",
>  				 &plat->rx_queues_to_use))
>  		plat->rx_queues_to_use = 1;
> +	if (plat->rx_queues_to_use > MTL_MAX_RX_QUEUES)
> +		plat->rx_queues_to_use = MTL_MAX_RX_QUEUES;

MTL_MAX_RX_QUEUES, MTL_MAX_TX_QUEUES and STMMAC_CH_MAX are defined to 8,
this is correct for gmac4, but xgmac has 16 channels at most.

Drop these legacy defines and always use
priv->dma_cap.number_rx_queues,
priv->dma_cap.number_tx_queues,
priv->dma_cap.number_tx_channel,
priv->dma_cap.number_rx_channel,
seems like a good option.

>  
>  	if (of_property_read_bool(rx_node, "snps,rx-sched-sp"))
>  		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
> @@ -224,6 +226,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  	if (of_property_read_u32(tx_node, "snps,tx-queues-to-use",
>  				 &plat->tx_queues_to_use))
>  		plat->tx_queues_to_use = 1;
> +	if (plat->tx_queues_to_use > MTL_MAX_TX_QUEUES)
> +		plat->tx_queues_to_use = MTL_MAX_TX_QUEUES;
>  
>  	if (of_property_read_bool(tx_node, "snps,tx-sched-wrr"))
>  		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;


