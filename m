Return-Path: <netdev+bounces-150593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68B9EAD3A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6389188EAA8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459A78F38;
	Tue, 10 Dec 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDJZPGwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73678F30;
	Tue, 10 Dec 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824268; cv=none; b=PXxLIURF/w7YxKY8m2g0UZQEpvjANEdAVDa0aSQKmsHF2XAWd6QDNtNvvz535yV9iwbOjHYE5Bc7lbpay0co4NjJ6cKSMZ83es320tdhrYnF4trXVYkPmTTlGcf8vRlliBza/dTma4AgbxxOppYdQnM9nGT700g29Ac2GmxoGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824268; c=relaxed/simple;
	bh=oi7eCnykiiMdiANJBoLlcbfnIekOTSmhDJnHa4TSeJI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oQ8kh6scrK4efokesfe9xvCEZbzAnX/o5mBBXMralQIa1bA6H6xhoUcaO/wOxkyjnjpfinw7XI3J9zUL7E9Q+JHG/ipA1DyCIgcKgCngblO5h65B+F2oVrzxpwSoOe/+5/u/AnfeDJkhh5o32TPYbFF0HF8F78EtkAoT9MpMk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDJZPGwz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso58109495e9.2;
        Tue, 10 Dec 2024 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733824265; x=1734429065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVngt1qTy/xN3Hpa896xeIHRZX1r8nOJq/F7ShWMruQ=;
        b=VDJZPGwzVxmc/ktT87hfP47PSwsIujM79x+QxT7l2SmMWmCUsM3mQrbzJmKQsozaCm
         9+GzgKBPSXPg5fxJrEwehKuFCvmKcM5BIZ3y1hUi1Ox46rgA38bAVtyyP/lpEVth4RNe
         I0rzqr1kF5IK8VOEDGBHC7vq+dTEDXjFBjnJlcNghTIqIdaakY3TPoFM7YItYJuwVWij
         yN5Aog9D+hEO2PDgFrG27af50eVwbhiiRwV73oocmNdXEQxEib2GKryVWNbSYd+M3G6P
         YTkE71QfSeghIG7HbHqP5TVPZLr5zzTjzLog/l/kcJV3yDTztx2XmVgg5O4ydR/DsS2G
         kqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733824265; x=1734429065;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVngt1qTy/xN3Hpa896xeIHRZX1r8nOJq/F7ShWMruQ=;
        b=kcNwvNPtA8mp7Ee2zPYHhIcIP8vaOUc/f8qn90MWvP5md5awiaqItrFR2gMHTzQRNa
         etfr4nh0MNWXVJjhfk9hKhxaOwdGJeJ8w04tGolkcYoGsLDWEqHbVnMMP+xfRLARZTYe
         pdh3aXYetxP2WvsyAeiL4mLMTWMZL1aFenPtZS6uXoRUCUA4b/VZH3anU2/V6kS+FQsn
         Bo+sF60SvH6qP3B8yrTR2YcsBNgs0YkvuFUL+875/iY8iePf1xAdw5I5HSIQyqqXhRDC
         cka5Vk0i8u6eDJUM3yQIWPHwWV1bDoID7JJjo2Nb6wjLOwDQtcy+MPJ5s57xqDtr10GE
         6cXw==
X-Forwarded-Encrypted: i=1; AJvYcCUbFVGtf+uf/VsKUtnm42KUOrHwybQGlZky9h/veF0B7y+NNWoF3ceuKwA/lV2q0ytT1XA9UAT6@vger.kernel.org, AJvYcCVvzSBg21YineMpFMp7PGbKpWe+YDW1aaBCBq11jAej2HJ4okqkIu0Rp2jnNGzOYDN9fq2iAUwyfTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycQXRRYDWtL8ZyewUwk66kGuropy/8Bm/1guuztD/lIROk+m66
	0QlBD5Ssmkbaa/I1BKy+nwywGmwSutzzBhnRGNx3r0u2NSHe/k4euoibaw==
X-Gm-Gg: ASbGncvcmUagtQC0EsMd5UEv2TTYmqB1EaXxk2vmd2l7E0DY+UZN2gD+VC7cqFpe53l
	fw9VWCjEl0fb7eE17MJNhUUC1TnfLE1vg9UW9XAFhgIoCzf8ye+bOnqOBOwdwiOyFgfAs0KvNf+
	GT/6QDo/GtLnv7Z37sgo8xwcndPn9tKE/ksBvXEN+5VPHvNeGtSBRIndwA6aSHzcdSF2/gQj18w
	h4RNvFjulvxUi/e1443LtziTMxk6zNNv7j0j25tjchhwOK/bvo65RUBGlW1Wx6kjHdl5p0CHcAm
	+QB4JiP3SgzzEkFRwMRy8eAWCirma1L6MNWOWsH+Hg==
X-Google-Smtp-Source: AGHT+IG1bPkTNmZoa++SRWPW66kFFJI1n5L1bp5c5HzG2uRlnN9E30pff4QzwAt6iLDjZTxSjuFfQw==
X-Received: by 2002:a05:600c:1e27:b0:434:f804:a992 with SMTP id 5b1f17b1804b1-434f804ac4emr51157525e9.32.1733824265028;
        Tue, 10 Dec 2024 01:51:05 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e8ec8072sm115493755e9.18.2024.12.10.01.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:51:04 -0800 (PST)
Subject: Re: [PATCH v7 16/28] sfc: obtain root decoder with enough HPA free
 space
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-17-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6c4f75a0-b63b-9591-5ffc-db4bf4bf3a16@gmail.com>
Date: Tue, 10 Dec 2024 09:51:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for available HPA space is the previous step to try to obtain
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 8db5cf5d9ab0..f2dc025c9fbb 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> +	resource_size_t max;

While it won't actually match because there's no (), the fact that this
 is the name of a common function-like macro is not ideal.  Can you
 rename this variable to something clearer ('max_size' perhaps)?

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
> +		pci_err(pci_dev, "%s: no enough free HPA space %pap < %u\n",

s/no/not/

> +			__func__, &max, EFX_CTPIO_BUFFER_SIZE);
> +		rc = -ENOSPC;
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> 


