Return-Path: <netdev+bounces-131516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9F98EBAC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C00C2811E8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB413B2B4;
	Thu,  3 Oct 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0uSA4tA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530713B280
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944467; cv=none; b=FlHu+NSpVuzdXdQIb1RgvaOxNby0vtvZqfzK/gheFJq8DPX8dVgw0yPLodIOjYV5iEU4mBcIkQ7WE/sYuD31YkiMCDTlfyKaUyRtZckMrxIF8YBLLBwayuHASMXjD08bqeb9kDDLNOmxQhK0TND9CXy8BUolsjtbRxq2NvL52FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944467; c=relaxed/simple;
	bh=svIvlDNgzYSVhmtDXtaCqaYc4fjLBBi+ljuqdoOQ9Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgUKavD/4IBEv/yVCFyTbtMd8WqgVZzEtxOJhR4bCYVhkXCpLUu/H6oi9n4iFsEr2fmzYHaM7fAjHiC9oNlLrF/CWeFCJGuFtIv/Tuafwjg0yzSPAOjma6IOVJKdJLPgMcACjXB+pIlvUYF1stXIC7bgpKqJvXGbiXIcexVMp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0uSA4tA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727944464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys4i0PydXyRMQ/rv2FLr8kvuGHk51g/SWpKTr17fmEo=;
	b=U0uSA4tAALbq9wjt3ccc62J7Lm3bluDtA62H61pDtmPbXD/e9M8OZP6LMcn6dMnUcwBrDP
	srI39skODcJXHDuDQQPBlPBwdfwD7G2WtGrpR/pFpQ/6P5ZoQEmrLlKEVY6kkufpgSczZM
	L9LyXRe9Sk12dqW3ffLPbFYlll5bm6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-XGo52UfLMq-Lf4MShkIuIA-1; Thu, 03 Oct 2024 04:34:23 -0400
X-MC-Unique: XGo52UfLMq-Lf4MShkIuIA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42e77b5d3dcso3552705e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 01:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727944462; x=1728549262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ys4i0PydXyRMQ/rv2FLr8kvuGHk51g/SWpKTr17fmEo=;
        b=sivtBxYVf2+C4gXTM6iIk6Brq9NMr2Xo1gkfLW9rqMcswspWpYj0aIdy9Vk5cuoDS1
         rmQ+CDSXVK+xW887IRMkHI0ljOp5ciMmaCEyNFxYo9i0B+utR48Y+nHCGbCBhnEdP131
         GMP4iJgCkMNKMOcRnIq4xV4S3h7a99JfvMpfXrOEs94r/cCvfZ7BKKW6A0lGPdevjSEr
         RjiG2Pl4/d70buoy5ixYq79mQKq+cxN5wSPC3UBImQ33mmUtTJl1hDptL5TT9rRAqHLJ
         wbTe2hbBDNI03IC9BDj4cp4k0+/vIcuDKxXFQTgxV06R2bHhMdMa+3nrl7PxdMbYugmH
         Mg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUkZyy2s+VjUdCqvkyJ3qxWQSluBs3gGuFRNacdUukZ95H+bUnJdorKraJkMI/Vokj+hWoTl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyba+XP0/rHT17DvpYF5cZC+1PJiYI8gjZLJJlX9tSxTWn/HO9m
	4r/ntX/rmiUt/qH/ra4nbIF0UhADb2ivWlmxkynCJBK0IJ9enFk2bqKlSRTmb+qO3D/kegarch8
	BkVJklVe7XZq98IurIKyOqgyDDiqFRlPg0K2wePMp1nFvFILjz6hRuppqKhtTthRx
X-Received: by 2002:a5d:694a:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-37cfb9fb82bmr2922730f8f.46.1727944461888;
        Thu, 03 Oct 2024 01:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMhI50QmTEn44f2PnO+f2LWperfypCn6j7JnI2IqiOwLAv/irmG3mzxg+9korvdg3N8geHg==
X-Received: by 2002:a5d:694a:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-37cfb9fb82bmr2922720f8f.46.1727944461478;
        Thu, 03 Oct 2024 01:34:21 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6bf5sm743772f8f.71.2024.10.03.01.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:34:20 -0700 (PDT)
Message-ID: <a3a81b7a-71a8-451a-a16d-53d9c54d6e80@redhat.com>
Date: Thu, 3 Oct 2024 10:34:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
To: Nicolas Pitre <nico@fluxnic.net>, "David S. Miller" <davem@davemloft.net>
Cc: Nicolas Pitre <npitre@baylibre.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240927025301.1312590-1-nico@fluxnic.net>
 <20240927025301.1312590-2-nico@fluxnic.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240927025301.1312590-2-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 04:53, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Usage of devm_alloc_etherdev_mqs() conflicts with
> am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
> get unregistered twice. Switch to alloc_etherdev_mqs() and make sure
> am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
> instances properly.
> 
> With this, it is finally possible to rmmod the driver without oopsing
> the kernel.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

This patch and the previous one looks like fixes for the 'net' tree: you 
should include the 'net' target into the subj prefix and include a 
suitable fixes tag in the tag area, see:

https://elixir.bootlin.com/linux/v6.12-rc1/source/Documentation/process/maintainer-netdev.rst#L67

> ---
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index f6bc8a4dc6..4cb1c187c6 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2744,10 +2744,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>   		return 0;
>   
>   	/* alloc netdev */
> -	port->ndev = devm_alloc_etherdev_mqs(common->dev,
> -					     sizeof(struct am65_cpsw_ndev_priv),
> -					     AM65_CPSW_MAX_QUEUES,
> -					     AM65_CPSW_MAX_QUEUES);
> +	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
> +					AM65_CPSW_MAX_QUEUES,
> +					AM65_CPSW_MAX_QUEUES);
>   	if (!port->ndev) {
>   		dev_err(dev, "error allocating slave net_device %u\n",
>   			port->port_id);
> @@ -2858,7 +2857,7 @@ static int am65_cpsw_nuss_init_ndevs(struct am65_cpsw_common *common)
>   			return ret;
>   	}
>   
> -	return ret;
> +	return 0;

This chunk looks unrelated from the actual fix, please do not include in 
the next revision.

>   }
>   
>   static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
> @@ -2868,8 +2867,12 @@ static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
>   
>   	for (i = 0; i < common->port_num; i++) {
>   		port = &common->ports[i];
> -		if (port->ndev && port->ndev->reg_state == NETREG_REGISTERED)
> +		if (!port->ndev)
> +			continue;
> +		if (port->ndev->reg_state == NETREG_REGISTERED)
>   			unregister_netdev(port->ndev);
> +		free_netdev(port->ndev);
> +		port->ndev = NULL;
>   	}
>   }
>   
> @@ -3624,6 +3627,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
>   
>   err_free_phylink:
>   	am65_cpsw_nuss_phylink_cleanup(common);
> +	am65_cpsw_nuss_cleanup_ndev(common);

The cleanup functions are called in the reverse order in 
am65_cpsw_nuss_remove(). Skimming over the code the actual order between 
these 2 does not matter (please double check this statement), but it 
would be better to be consistent.

Cheers,

Paolo

>   	am65_cpts_release(common->cpts);
>   err_of_clear:
>   	if (common->mdio_dev)


