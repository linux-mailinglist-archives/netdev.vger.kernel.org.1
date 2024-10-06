Return-Path: <netdev+bounces-132489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A23991E1B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C000A1F21B3E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE39B175548;
	Sun,  6 Oct 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRw9OACU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D841741C9
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214082; cv=none; b=jJVhriin2DX2ZgxSuwcmZVQAOTOjUTm2oPPkX3GekjdKIV1WXHDZJ1pzRUtiglIKQlk6L7L1oATt4j2s7vuhZXXICvFOo3HRBdpPHo3ri5vTkZ4YazICm2Oag4KZGc7wtRAFdjksDVkwjz6At9ovUg2JVLW6rAaaStZ9ZZwTvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214082; c=relaxed/simple;
	bh=PNSAi6x4ko5iPVy2AIGQgyjrAdRvdkLZmJtp0lnXKdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEAAPSpjV7x4j+VnOwkx2MqtbwRDp+MFYu7KVEDIyFoNjVtFgLCrrcZZYo55qWs6xXJ4YeCnFOpvqd/1zON3LW45XLHwYc2gPmtS9umaadJTOH0/gsHr7r0zJpitbkF15jXFId0/2zMc0j/FkFAFtNQ3xky0tRHrLBoFkNyxxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRw9OACU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b1335e4e4so35329855ad.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728214081; x=1728818881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p1A01SrKpp4u6/46w3WFkkxP6GwJB4kJNyTLl1SXVQ=;
        b=NRw9OACUuDtSAXoSq0vjPSWyTfFmeGV0U3nIZ3ujBX9I5EWNu/DDlU81jTrrV1l3Yz
         tjJcTelICeWfRXUb7E6ZUB9/qeQ8yV/Ec42G5KfpBOIIyjm5VKZXLNy+z+GM+MPTKbaC
         uw004djTW9D1uABfpYp81sMb79nkLmM+6T83xv5vKjfvriQJw3v4tBeLNvVhEIXkcuQ5
         GwjZPilabopuSKcTpH9MqlaYiQG936LX0Aeb3hRdmhRBqJDqc3J7C539QIYgXg0hWEdz
         /S6WLf7zgcLZln1oZiDL33f/K4+FIHICIC6n72EtsNDpItmLp0hi3MSipqE5jkbeOJfG
         pS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728214081; x=1728818881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p1A01SrKpp4u6/46w3WFkkxP6GwJB4kJNyTLl1SXVQ=;
        b=hDdcQTI1ge/HR9zhddasynjuKNlNFmj6lKqs7U2bsMNR9QAltysTsZjDDMHHgBMs+E
         riAuFgq/BAaG/7lIS905waUgzGBYYy2Z2FRM/Zm1JwJKL4RNAckHeklAKYKXPnxzVfI3
         4HfPJDiDneXnynIeCbFsUwAeBQIjprOG65Nvkn1tWURj4Q6oJzNzqYVy32g0+wgBJsjy
         Ozx55wOsoMQBwunbKrCmoYZiHav/C62ygw5Xj4ix050II5CRHql91hC1aYEnoewYejLG
         2gD07+A8xrJq50EzDNMvCReQVdJn3Uc5HHul0KGbacJWpGiY7JIzqJ/X3hXuxybs0jbR
         qgZA==
X-Forwarded-Encrypted: i=1; AJvYcCULzTIWXhpAs4As9koE9xzgYNDaTD5Cc/Z73B41jiHmefY64TtWH1sHDYzV06c3lYX8cmnD/IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Vk3Pk2aTzA9aBZVMq1Yv44YmJaFHx48s3xWVSKFYHT4lpq/B
	Ps2JM9qtrM4MtG2kc/GpxFMwixjKxhsZj576Ovkuit5q+tt/xADv
X-Google-Smtp-Source: AGHT+IHhdkgz5ewQo4rZfhEHJu6U0tB2JlcAMg73iKyLot+EYLuCN32yNSdt43iMxf8TFjT1p6DOug==
X-Received: by 2002:a17:902:d4cf:b0:202:4047:e419 with SMTP id d9443c01a7336-20bfe01d88fmr117954355ad.25.1728214080623;
        Sun, 06 Oct 2024 04:28:00 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afe40sm24129205ad.39.2024.10.06.04.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 04:28:00 -0700 (PDT)
Date: Sun, 6 Oct 2024 19:27:52 +0800
From: Furong Xu <0x1207@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Jon Hunter <jonathanh@nvidia.com>,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, hawk@kernel.org
Subject: Re: [PATCH net] Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only
 if XDP is enabled"
Message-ID: <20241006192332.00001973@gmail.com>
In-Reply-To: <20241004142115.910876-1-kuba@kernel.org>
References: <20241004142115.910876-1-kuba@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 07:21:15 -0700, Jakub Kicinski <kuba@kernel.org> wrote:

> This reverts commit b514c47ebf41a6536551ed28a05758036e6eca7c.
> 
> The commit describes that we don't have to sync the page when
> recycling, and it tries to optimize that case. But we do need
> to sync after allocation. Recycling side should be changed to
> pass the right sync size instead.

Thanks for pointing this regression out.

I will send a new patch that passes the right sync size as you
suggested after this revert is applied to all affected
kernel versions to finish what I have stared :)

Reviewed-by: Furong Xu <0x1207@gmail.com>

> 
> Fixes: b514c47ebf41 ("net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Link: https://lore.kernel.org/20241004070846.2502e9ea@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: alexandre.torgue@foss.st.com
> CC: joabreu@synopsys.com
> CC: mcoquelin.stm32@gmail.com
> CC: hawk@kernel.org
> CC: 0x1207@gmail.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e2140482270a..d3895d7eecfc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2035,7 +2035,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	rx_q->queue_index = queue;
>  	rx_q->priv_data = priv;
>  
> -	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
> +	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>  	pp_params.pool_size = dma_conf->dma_rx_size;
>  	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
>  	pp_params.order = ilog2(num_pages);


