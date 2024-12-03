Return-Path: <netdev+bounces-148668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897B9E2D35
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40DFB28B58
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E81E0DAF;
	Tue,  3 Dec 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meUPET/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638251A01B9;
	Tue,  3 Dec 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258030; cv=none; b=cQIddF3arxo0YygqurHtF11B1Hd0Nlk44OHwKLwaRxd7CzWvqOPsGZjnTt9YzKGmAQL7Fo4Jsol77Y6N2nq2DmvoQDIR7kKhmt0mhcNMXQ+34ete2nkHeySpmHjr00X+AbSmbifH88EgcYAJUc/VEVo61xZ5WIF+hdRdyV2VgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258030; c=relaxed/simple;
	bh=qZYiQEFUY1AkdD/TCr3naI2kgNtzgauRD1TTdlgOxto=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DDQBgVar3go7zHfmNw8DiLDuqv5ZpC+kVvUw6VPGTmyKs4NxNjWPy52S7hCPa1zjHwyq5NpKQBLa1LTgkFR99ILxhcEKU4iPjy4J8xZ/2n0QItmR07BpjpjwM9zfOEyAdGPZ+mRl0nfqihW2wbSZ4RvxxEeO1YYWe+2FxEnAYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meUPET/d; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a10588f3so39177735e9.1;
        Tue, 03 Dec 2024 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733258026; x=1733862826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n1p9wpP+zs7RFxQ9jZCHg+mp1E022AqD1rZ3rD5wwA=;
        b=meUPET/dX8MtNUtX5ftk2fURKoFTKom9Oaayi7VSjchR+vKu22oIgKHQ58Gi6e0571
         VzIO39a7ApgmMFFLv1PDO6nyyEH4TXi8lMFdmqONmGr+wcOs344oMU+GbU8aIgmsTRAX
         4kTCJfWawU31rYKk1mEr2SMNP736XStzoDpW9DW89fz5lP5ECMnPmKeayn+NLK2Ndo7T
         kN7/kWAwKapiwujZBWlmwD1PJ3VjxJT+brGOEtBDjHDIP1LcJzCCGdhOOopd+PcEZhcS
         SoadCL0xjZPtUw86RLZaIltEb7aRbmIOWhyb1f4aZ+YQXMQ5wu8YNjb+5HK9pqntQouz
         r3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733258026; x=1733862826;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6n1p9wpP+zs7RFxQ9jZCHg+mp1E022AqD1rZ3rD5wwA=;
        b=czE7ts7Q/If83wLWgAVEWOV9TQ/H50y+uFYYgFFPTaCksq4B7NCydL3Xmd0/th0yfR
         2bRL7Mbks70bZRDTkMGW1jKgFGjVvYzmBzn1phRwOOzLUNjLDG9LQ+K6noMGIbw8IMnx
         GVi/b1UfQyFhcxyL0FNVjIk1fHOW2a2QFIsCkTIpjNtmMIbVA3n9PCWqsg5CzuQRdcLO
         cHOd9MSpiLkaEYQS2bH8vnrHo5qS4MMOf16W0R0EQukIxdnH8xC7eyWfY5hTp1TBKgMG
         dSOEvILOI9mos1ynXhTx3JG4542WjkyDmzS4xD/9230qSemzgjxFeUJrbZExTNrR80yf
         Lzdg==
X-Forwarded-Encrypted: i=1; AJvYcCULv98VtWQGebMn2BhUCh1pT4nP8tVE28DOp2bSWjfj3T8LtAB42IoxQstl2zhQD5ATD8BGzYmevW0=@vger.kernel.org, AJvYcCWLy+5WdvX3MPrRVrDwrYQNs48JpAS1wB8+TSz/l4j1Wgs7LqWKxIQKYlSa96DAvweTEHpuXPAf@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcawZoTRf81nCyOAk+J6Zuiu2mz5exY7Qa98XFHXN8vT4u9Hx
	iOcs8529bR9JZd254EpX3D5Q3v1lYKTBNs1ct0NS0uweUguTDbeA
X-Gm-Gg: ASbGncvgG/yxvcmhDFstFzbli+V546nZ0ieE1YlH8cVI/C/DDuNDLZ6JLd3Yow2vQuE
	61SjRqFlWDRZidee1xhP6fRV9Gf/UD62H5m2zkM1Pm5Flp/o/UypRZ71OjadqkQYid/7b5jMK5D
	g2meJbfod1a6kOJIMiskfYQjWMOiL2FWFTi4mcqBigDbHETtslDMkTEYSx5mm9/+8JHEUwGiPcD
	EJ57VaAk8vjByZaYGezZAMBJ3Ly7VMfZVZ8I5UI/aCqaYHzz/CCrdPjY4Tdwt5ZfhZYCktg8/Td
	NCynXqr6cVQk9PX82bg2xdLqbySedYZvNLkaoA==
X-Google-Smtp-Source: AGHT+IFAapOjKvSN5RLi3zaCi5alUp2EfZVmjkLqdbO/sBuhCpCBSXL/9l/AIwLIirQerXKK3u5n1w==
X-Received: by 2002:a05:6000:4603:b0:382:41ad:d8e2 with SMTP id ffacd0b85a97d-38607c0deadmr1687573f8f.39.1733258026429;
        Tue, 03 Dec 2024 12:33:46 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e1f3f2desm12020455f8f.87.2024.12.03.12.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 12:33:46 -0800 (PST)
Subject: Re: [PATCH v6 02/28] sfc: add cxl support using new CXL API
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-3-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <66ac91f6-b027-3732-882a-4b5f32edfaf5@gmail.com>
Date: Tue, 3 Dec 2024 20:33:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202171222.62595-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/12/2024 17:11, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependable on kernel CXL configuration.

You probably mean 'dependent' (or maybe just 'depend').

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Some nits to consider for v7, but this already gets my
Acked-by: Edward Cree <ecree.xilinx@gmail.com>

...
> @@ -1214,6 +1222,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +#ifdef CONFIG_SFC_CXL
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(probe_data);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +
> +#endif
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.

nit: weird to have the blank line before the #endif rather than after.

...
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 620ba6ef3514..7f11ff200c25 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1199,14 +1199,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;

Not clear why this needs to be a separate bool rather than just
 seeing if probe_data->cxl is nonnull; afaict from a quick skim of
 the series it's only used in patch 28, which sets it to true in
 the same place probe_data->cxl is populated.

