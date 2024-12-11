Return-Path: <netdev+bounces-150931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F3E9EC213
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2428188B976
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2311FC11C;
	Wed, 11 Dec 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byWYlxpt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A31FC0F4;
	Wed, 11 Dec 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883997; cv=none; b=YvyaR7xZI6yrZ3zpW7qdDwhnVFjigZD3EvOv1v1shOfT2vZ6fHxU62klEmOJ8mQd+Z9paszFxOTiJ054j6gpb/N3Rl3/7UrkXUcc77mxwBytSVoWf9Z0izq9MMfzjMZctk6UutTL6O03IhznDntRQmeUiY4qndetHc33wSyZaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883997; c=relaxed/simple;
	bh=E+hBB5pqqfhb7ph/gXl+WOvqvXhrHEPVinJD2eUh2Jc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Kfk7ZUJdI1lMN/ioRZHjG9t2zjdbJh16zZaqg7LSTgQUVIBRm+qaUFbEWl/yErbfbF9ImG6zEddWudBkA52l8gbwgJN5k5eRE7ltvSOaW8VbSHf4xw9nBMJbl+PUX3qvlvU5KyQ5xrfHkALId2Vn6WETGyJsFhmoIWzSk7xAl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byWYlxpt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4739367f8f.1;
        Tue, 10 Dec 2024 18:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733883993; x=1734488793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5mLS8pb+KNJoyuNPuFmK9HlqacVzGWATu/+gYlroLM=;
        b=byWYlxpttk8wyce4hEqkz2K5sdkKCTAVFvYTap6BxKbO55pFnTf2nVYZwCYlmnbtVA
         xtNoBG6Eu+g2RvE81nGIz+7GggQISfLVDGIRm4wcGSdhqE1KQFTZ0r584Mq3hn8lYuco
         1TNL/Y5VK0TK53qviGUt0rMUSUqhpzgeboJVGWva/SreP0xGjve1adYEFap+MuQo6y9Q
         gjsjUbGuF3tswtuQ6mi41iVoJyUyJr2TRRuVYkRBP/gZUeV58/AQvrFdv5qALCsP0RTt
         FszsEkfMFTqpK49mYbxnIr5WZ5xgsD3zijX6xU9YgbsxU1EX2pHsh9IgkuHuw7tXvr+T
         v/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733883993; x=1734488793;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5mLS8pb+KNJoyuNPuFmK9HlqacVzGWATu/+gYlroLM=;
        b=P/icITSUjjVjubU5YX9BC1A9gcgY58pDlLTXhV9V65S9uAwKq06CsHpxTt5YrBxXXC
         udiIZDIw5M1DjA/MFUgaQRUN2Et6NDGFTo9cVDjknn8icHyfoN0DQZ1bpu+tlOCuq2tI
         ZRm33htr1D2b9+Add7irVmkNGU8kXkSOoifTkU4tFJg3p7tpuShvmuzer4ZZHC9uospf
         N1ZNck9WI/8xhSwa6LNiCRpxhEQ/jtNM0A31BfE+olbgDFZnW9/ukJzsclu76PPQGLSR
         XAIR2TLRNzqHPfpYiHSHm9nYaNsxC74McbEXodM5xxqf8CzqtmlkrlLrNfxKxExsdwUu
         plBA==
X-Forwarded-Encrypted: i=1; AJvYcCVl06NIajOK/ze5TNtU6To0CYrEES1T44LK+EMt5avjkVnBQqDad1XzT8mY/3jx40l69wBARzkepkA=@vger.kernel.org, AJvYcCWpSzpNl2iijjqWghYxuvtqqX1bBKfWmzJw1SeHgKW9PWu5kzzCRAlzcmJbsXpyb1y+o0YRYP7x@vger.kernel.org
X-Gm-Message-State: AOJu0YxBs88EPH10ATt9pJggch+rzhie1eutlRL6xnKoNEZCeK8meqHm
	1flTP/dVNvWQp0+3ynjOiqAdUbucYQhcXdK4wPPOqdBmdwI/s/Dx
X-Gm-Gg: ASbGncuqL57c243OZWk32zpnQAodd+CqZsycqc+TC45+GFx0uzYsD9sYG98gbJno3zN
	fS4W5pNl4mi6P2RK9cI9vAv2uDudwHGYkp/RUkm4M4bOskPWjZNQNFHRwf/SugDMM21XMjIMQAL
	LOocpOyX1gPF9c2hgqgvfZhy/o+zrBY5lY8qTlT6POXYWzjoHSJ6GUnvsx31zfq5aI/UnavMHBE
	yriG2V2MfCvUvO/zWW5r4JhwDscsMXoYYX5aK7GnQKyVIhHW9lYJ67J6OTUM9OOY7O5dpv2gApg
	oRObgzwt5ZHwyNVrU8hKdlIxS0rQKVUuiX63G88CkQ==
X-Google-Smtp-Source: AGHT+IGQis99JLmrTJSoU3BdriR3JrbkD6EDyruzS8T2GiFiY3vohDo10sOrFvtzp1x2hLuzqsDzbA==
X-Received: by 2002:a5d:64c2:0:b0:386:3e3c:efd with SMTP id ffacd0b85a97d-3864cec57a2mr804525f8f.44.1733883992594;
        Tue, 10 Dec 2024 18:26:32 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ec87bc3sm1546175e9.1.2024.12.10.18.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 18:26:31 -0800 (PST)
Subject: Re: [PATCH v7 23/28] sfc: create cxl region
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-24-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <5aa783dc-ee17-d72d-98cb-0d0a64fbd96b@gmail.com>
Date: Wed, 11 Dec 2024 02:26:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-24-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 09827bb9e861..9b34795f7853 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
> +	if (!cxl->efx_region) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_region;

Little bit weird to have this mixture of numbered and named labels in the
 failure ladder.  Ideally I'd prefer the named kind throughout, in which
 case e.g. err3: would become three labels called something like
 err_memdev:, err_freespace:, and err_dpa:, all pointing to the same stmt
 (the cxl_release_resource call).
But up to you whether you want to bother.

> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err_region:
> +	cxl_dpa_free(cxl->cxled);
>  err3:
>  	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err2:

