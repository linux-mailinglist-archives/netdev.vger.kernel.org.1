Return-Path: <netdev+bounces-217052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0BB372E7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0C444E18E3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2F27A909;
	Tue, 26 Aug 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW1W65Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AD31A546;
	Tue, 26 Aug 2025 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235742; cv=none; b=q8OhXf2uymkiTzNa53FaNQrzGrLesV/VyiWnXR2Q1/bD6tas1hIkGmzOzLJvMmvtFduj943c+GYsb2GMtcw4sfLEYZ0m9u7V/JWJQrY/3fKHY2DprUHusxNmfs/BdTUgDqfsb+31bZ3qpSN1wZ//nvdTiNADhX/U1Zl95cw4d5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235742; c=relaxed/simple;
	bh=4oIbK0dlmTqaUp15Y8918iqdp+r8eysmF0eVjvNdtl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=M/EttX3FCTsgG+X0Th/c4a4x/M4/CFm3c9LEpjD1rcNn/JciVMTm+2K4dPQRHQ1yKPOs1+cihas5ghEvldhEuAGMKuaoUtHV30hjhAuxictPSLVLYIiEZj0an9gXnT+a2Tk1pt047YkmgsCTlJekwTsjKnvfQoWTZkLEFiCmCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW1W65Nc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso36012205e9.3;
        Tue, 26 Aug 2025 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756235739; x=1756840539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNzxRNmE/EKiQpaMndjIGmivQbwP1c5FSr/pLiv46ys=;
        b=OW1W65NcHt6R0g5xl5hbYRTq9XOUauvb1o8+AOIIGF6HIJtj8CjWfV1OTyB6A4AqwZ
         WKAASO64SsgNHvUdEP1DRUAQKkz8jU+wWQLMPSjsuwzlY+Z7usoPPgM9+RMeXpaYgFs0
         tLPHuJguQXFoJ48gUeeXklYH71zi5/t2J91+am68Bt2pyLovLbWtvWSebjgDPgThiv8n
         UNEIrpU+kHI0OajZqjA/PpPlgpJCbyZwJlHl2Mqjiv1zst5AeoR0PS7xPuJuEsbrrC6j
         dtWEtALOz+Cz4OYZhvn8zhK19s//nJIXr1SiTs6KUL1+C7PXyel78rLR5p/iY1JfAJzl
         yd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235739; x=1756840539;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNzxRNmE/EKiQpaMndjIGmivQbwP1c5FSr/pLiv46ys=;
        b=rzCTfCUIeDwkhLkDUeAdEsc1ZsWV8eXtCareseIn7J6gVN5SW0TmFA4gDXUN7UJE0d
         hkRRETJ+HcbgM+EPdeDCbghLajwS9bBQxH0JUzwyKPUp83EIuguohutCgYEx6FKhCZG4
         izNWVMTgFSiZ2UIrAVuziOjjN4zKc/S3YJhr0ac8BDMdqBiPm/s2pcHMQPsRmvpS8wv2
         EguXhVH6lVywmH6W9POWA4IedxHMo7r6sSCRxkKqUuDNoVQ9yiIGQgkgdRP6z6haqmjL
         z42h+AKYyZntF2Hl/MSb4Xv1S10l4E0GmPUaRgzE7ozRHRgj4ihTJgca27HYx/T9rZO8
         KS+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQZnVC2XUBVyHeOXFKOTrL5pxM+I56dwUmdolSxoYyu7WlPgaHdUVDrVymrUCeIk9CatqcWXlfOrIqx/s=@vger.kernel.org, AJvYcCWjonyYbKqGO3Zgc5zrEHUE102u/kHICZ5ouYrpvLJ7QKSIC4F9KKQ/3598puxFUlNlxfe1bcYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yym47KAMc5+xHNkljiZZ/Yf1B5UgrcTicGeqHFT0tiLVoZ5ySrd
	BtYTLSHNPpcqRnnZJWWTwyyNi7yLvSNcco3OauJtn5PFFQ5uuwr1rTBI
X-Gm-Gg: ASbGncuiLv99CaGo4qH7HlzfwVMScuMHxXbP7orpKu1IxzNMNSj+jY1UPZI00qcu61x
	c0eSgVb4XdwtlEcjWzk2TCGwp6VoORFn/IIO9GUwcYnWMcK8fpugU40Trg9J9vuw79X+2K8fq9x
	KV3gqaXgMssG+AOT/FyvsI/Rn3BLvL3qiBebztIp4o1jpY3wby+hPIqtkWaDTAPkPSvgTdtl1dm
	LgqKeg6X9NldFLHwIalMKF1nMHy5anhkKVZrk8cJKdv+mBw0AfECcMTQiFakj5ZiH98Jza6tpGO
	o787FT6Zyr8f8bpuExmsCPTDo1HNwMx3FMsMQbfBZkZLon2GBqeun9ogBfEIkQeiA3WyitOZvU0
	Gn4IvwZr9CE74vDVb1pqG5ulI9Wq7VGU0VW7nIXOUi4Byt/FABy3u2RdVTxE10wwoDNb0BCE9QL
	ql/JIMd+2Oir1odG8RsA1d
X-Google-Smtp-Source: AGHT+IH7WBCt6pVN3TJd/7YUZla9RJO5wp0JBJSRMHH/wLVRBu+wkAsogHkN5FfzzEJWCNpnC+OaZg==
X-Received: by 2002:a05:6000:40dd:b0:3c3:973a:fe40 with SMTP id ffacd0b85a97d-3c5de349863mr15117249f8f.58.1756235738577;
        Tue, 26 Aug 2025 12:15:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6c5cf38fsm3881735e9.12.2025.08.26.12.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:15:38 -0700 (PDT)
Message-ID: <7bfb811e-72cf-43c4-81e1-6e63338f6a29@gmail.com>
Date: Tue, 26 Aug 2025 20:15:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: use kmalloc_array() instead of kmalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>, linux-net-drivers@amd.com,
 Andy Moreton <andy.moreton@amd.com>
References: <20250825151209.555490-1-rongqianfeng@vivo.com>
Content-Language: en-GB
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250825151209.555490-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2025 16:12, Qianfeng Rong wrote:
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer overflow.
> 
> Use kmalloc_array() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

This is fine on its own terms, but I would prefer the use of array_size()
 (as in the existing ef100 code) rather than kmalloc_array(), because the
 new X4 devices report a buffer size rather than a number of stats to the
 host, meaning that the common code will need to work in terms of size
 rather than num when support for stats on X4 is added.
Looping in AndyM who's been working on said support and can hopefully
 correct me if I've misstated anything.

-ed

> ---
>  drivers/net/ethernet/sfc/ef10.c      | 4 ++--
>  drivers/net/ethernet/sfc/ef100_nic.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index fcec81f862ec..311df5467c4a 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -1326,8 +1326,8 @@ static int efx_ef10_init_nic(struct efx_nic *efx)
>  		efx->must_realloc_vis = false;
>  	}
>  
> -	nic_data->mc_stats = kmalloc(efx->num_mac_stats * sizeof(__le64),
> -				     GFP_KERNEL);
> +	nic_data->mc_stats = kmalloc_array(efx->num_mac_stats, sizeof(__le64),
> +					   GFP_KERNEL);
>  	if (!nic_data->mc_stats)
>  		return -ENOMEM;
>  
> diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
> index 3ad95a4c8af2..f4b74381831f 100644
> --- a/drivers/net/ethernet/sfc/ef100_nic.c
> +++ b/drivers/net/ethernet/sfc/ef100_nic.c
> @@ -640,7 +640,8 @@ static size_t ef100_update_stats(struct efx_nic *efx,
>  				 u64 *full_stats,
>  				 struct rtnl_link_stats64 *core_stats)
>  {
> -	__le64 *mc_stats = kmalloc(array_size(efx->num_mac_stats, sizeof(__le64)), GFP_ATOMIC);
> +	__le64 *mc_stats = kmalloc_array(efx->num_mac_stats, sizeof(__le64),
> +					 GFP_ATOMIC);
>  	struct ef100_nic_data *nic_data = efx->nic_data;
>  	DECLARE_BITMAP(mask, EF100_STAT_COUNT) = {};
>  	u64 *stats = nic_data->stats;


