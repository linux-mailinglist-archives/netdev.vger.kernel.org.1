Return-Path: <netdev+bounces-148522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8389E1F58
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AC1164DBF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E21F7094;
	Tue,  3 Dec 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtZKslRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EF1F7090;
	Tue,  3 Dec 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236455; cv=none; b=st3ST/AgLxMJRkft41kcNBnXTql0AWzveOCk5adjnpVg8x9NXP4xBDcUbfdHHrkKjNE0wBFbc7F9ED7Xbf7xNyJSZBOoQkiti89g/jAdu5ECzxth9SMZO+7jHyJrDCLsWHoDNiYUiuoXPEJUYeN3XoVQEofXYCyjLi5dfdd1E44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236455; c=relaxed/simple;
	bh=HNvQv4Mn+yRf3AqTo5jKqGJck5Kl0ryooW890A6SVoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtiNnoqTcU54LF5f7ySDklxmpxPLYEyFX6OXPvB6i0PqDvIuATFnLrK7j0RU+BVemGgZKESPRU58a/IbeVBARRhFZ000Y2VmCyc3xMTKT580uH+bIeMW6nqkfk4pEaltNK+3qV8ajPiRbZByF98Gmf8DAfyo4DKCLyPoGgiBZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtZKslRn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a90fed23so47206155e9.1;
        Tue, 03 Dec 2024 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236452; x=1733841252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaJmi2F2d7oVyPZ9dEs5lyx3B7MZvf2znAHG2U8SJkE=;
        b=UtZKslRnw7PvO5YnxvwodwGTWwsV8Ac+1e0kafWnmJi6cG9QARZdODJSBU+iJS/gId
         6qLHKTqDLtNLVLHFknxfe4A/67lZb6d3rMhY/9f5Z5B4/S++Z4DmcPPRdlytaAiaON3D
         gyd41Q3sf2+iXQa2OARGfbi/fIjHC5Cn+y7yD2gyXbnFH4Dr3HQVnltFdaZAi6w9W+yJ
         27xDcUAVBdnEUHSMKQRrIdRwSbxDwe8NbaYEbXEtIES13aBff9cFZIxwAuuIt8abdX6d
         zMz5bZnWbfQMczEad3yiuWfb31s7EY+RHV+Jah9M35VwdJMYLjBGmg9WMAYcJDUYfUxI
         pEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236452; x=1733841252;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaJmi2F2d7oVyPZ9dEs5lyx3B7MZvf2znAHG2U8SJkE=;
        b=mJKPWBtsbeLy4UxJWCg0kxjbjoB/Jf14J9BCAgGwIjtgC0rSn3liWzlTwJabPoS20E
         htZAdyub2uMrXitoV2/+3V+i6dfmpqIF8VYU9OudExp7UYgk+sb2HjQWEyHSfr5CFwsc
         DM3NKrrRGj2WRWzSC8JP8HziekfBLxhtzO1rUrMpiEoQAEoUXoGxhvaUBrSh1HScrZe1
         y1McNiVKdJFbec6QTwvMb03fbg0vNLE8ZrG3cdWuTQsjeONI688o+iyuYRBw2jpYh6qd
         n5weYswvQjVdLI3uWtZ+F0GPLtbY2rFGZLtaIFcKA1DyfOERBbH7lKq5YAxeD/KIMtN6
         iPcg==
X-Forwarded-Encrypted: i=1; AJvYcCX+fQiOygZEPaSCBvRivUXXbQw6LTyiTqXDRKSKi3rdoDtu6xiiJr0VamOYINYNnJkp62dNZec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoBx+8/nBMCLJgBg6WkkQOUgQRzVgUf0PdkoYMxdQnGZ/KjXa
	6us6dAGMQefZVrVlQK6hpJ9UVnOyGeb9soyKILF0bhQ6BZQrxasyDHOiipH2
X-Gm-Gg: ASbGncv40v3u4F2Lwr52Ixjp7GhdwthHQHfQ2IhL2OBaKCpiruByg121hTjOCCvpd0r
	URCPV3XLDshNSgTZ7I0ta/cT7VqfYK6YB+drrlinpmLkE1M1qGJsMFOBVlYOb0ImYlpuF+COl7C
	h0xwx/cFAF6ALl4a/nttKwLdvzAL0NUl/0ogsh3GwkE1yqCRrVZ9Ayf44Jj+SsTOyNmp7Gm3F7n
	fcRuPVqKp4UOkglVFwtgIgbsBReuisyFfXFTSt2MAvZhOFQ7MU=
X-Google-Smtp-Source: AGHT+IHXPzxOR5DFEn/MeFs/flkeA4ulBRVyk5qHJg2whXQmSH48mU0TcuNMMQlhQARjWPbyEIw2uA==
X-Received: by 2002:a05:600c:1f8f:b0:434:a396:9474 with SMTP id 5b1f17b1804b1-434d09cbe39mr25296065e9.18.1733236449638;
        Tue, 03 Dec 2024 06:34:09 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2716cedsm10829147f8f.38.2024.12.03.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:34:09 -0800 (PST)
Date: Tue, 3 Dec 2024 14:34:08 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <20241203143408.GF778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-17-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-17-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:10PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for availbale HPA space is the previous step to try to obtain
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
One comment below.

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index d03fa9f9c421..79b93d92f9c2 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> +	resource_size_t max;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -102,6 +103,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					   &max);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto err3;
> +	}
> +
> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
> +		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
> +			__func__, max, EFX_CTPIO_BUFFER_SIZE);

Seems it should use %pa[p] for max here.

Martin

> +		rc = -ENOSPC;
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> -- 
> 2.17.1
> 
> 

