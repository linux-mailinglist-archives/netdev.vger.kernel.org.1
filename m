Return-Path: <netdev+bounces-148512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA069E1F11
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86231645EF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6E1F4725;
	Tue,  3 Dec 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMiF2egM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14B17BB16;
	Tue,  3 Dec 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235912; cv=none; b=StSMiAqvkskh5EEPqGp9VK4qTM1ln18IW0iBTj0L5oXPZw5yHqMdr3Nhkn9UGE04oH3AG0RasjQKNzSkJYszY0B0IvEG9I89u5o/A5E+Lk7TMqqBL4CVQEOa5TpGMMdpdeeRWQi+QmlZ5Ep6CKnSgasWE5KTgtmPjsuS8ZPuuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235912; c=relaxed/simple;
	bh=tXzn3t6PIt+Cm/HLJEXqeYFYkkxalqBT77NJiwrY6iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgzx4S62EeZunEU0XQgyQr2eGlz80u/8mNusQelldtzIbXwGZlVovinL7RPQNVqfmqeM/2w2r3H4AmF/vL0Dc/uu1subhVy+Kgrp8TrKoBWRT7KNX8mzLUpHD6bVhqOcrZiX4hF3gOj9osRgVIWKQTVoFugIUQdFTm6c3sz8HNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMiF2egM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e3621518so2704752f8f.1;
        Tue, 03 Dec 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733235909; x=1733840709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHy0FVcu6W8MYC5P3+/vGgdDglDx0m/yFgllSZ1cVMs=;
        b=KMiF2egMRTIwcxENyW86XHmIpTSn05xteZ5Vt/bF2KLRKSSBaYAw8YnHwLmnIOfo2w
         /T418mgxbGpcy3cnoCK1YEi3HVOTWkfamogzmRbQGYlimLYAxJ5lfvnPK1XzMlq5nbqU
         urZ5O8eyWTXMTlpw69uxb8f7UZjKelj1Owj4qy8kY7s45b20ZA76qsXfSHTN7EqOh/5M
         hnP1jdu2NQJ5JbpfQh081qOvFcRAJXVC4CoeL0nITSDy0CtQpKO2iWamxw+NPebs+TeF
         bVAo3HR1pBZaOTWtaYV89Qr4gNVjXZEI9m1sMR9W9qyWzpnQdH7COAQ0neu/T3Iu8KQa
         ZLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235909; x=1733840709;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHy0FVcu6W8MYC5P3+/vGgdDglDx0m/yFgllSZ1cVMs=;
        b=WbOBSGZl5x6WDreE86QtAnM2GzUcBvgQQbiF3xTBDcDWekMIIIlKEtKp45eRRY0aIR
         Ua4WrOYK+1LFad6oe1vnUmwNDtlG+d0VoffaA7BstjqeuIhykAQ8wrrIuv8oud7jIejo
         CcRRWNPn7VG1MyDME1OWPOM2BSUjQO8K9JQdHEAlOgHxZALwgCElX9O9awgBXgvbrEFO
         S3kVIHJuGqoctphAOgBGSfIj125ifB4fVZLmLDV1cQ5SdeGhRPO6AtMDVfApJ+qwSzON
         MZmc6h2dXMclbiS6Xuu84FaDZ9wBjnrs2ivGwUJ2jTBOXkyPKs0d8ToGy53QWgJRywUm
         D2EA==
X-Forwarded-Encrypted: i=1; AJvYcCXkeVHfvkmgxuGcKiP2MfmuVfmXHSQyzn5OEb9v+nvHSSonk8CqBsfPPm5/Fk0vagOrR2RfSM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz30bgItVJeBbTFZxR0na6nqpqDt+MZdb8ZKqDkgsAKebJaJV1
	hASX3uK0zTj/y/Qe9Z6qcPPqTlx+Te3DGDQvhKIqMne5n9haklMVyoSQburB
X-Gm-Gg: ASbGnctbIHJBWRe7Z0fv9IAfigZIVcveuhjCIBWtDu7OuYwZZ8yoH82YDQoP/n9pbnr
	+T7HCX4L/bD8HMsC+H0H8QuNAF7tomwlkbfktJZTQ3VpIQ1wz22pWtTPqa6HsVVGB5iIcQSV6+k
	PGj+Oj6rjPRaq1TCKFegNDDlg45o0xeNZeJR4KmW4PrMcMdhNVLvKEiYfmIkeO/VtjZagFiLMWZ
	px6eJUmIMgNng479Hbhtf9kjfqwUM2MYZD1PV2Dj1qhBSGXn1Q=
X-Google-Smtp-Source: AGHT+IHIdpK6rRkId5WiFNC9ga0Gn+TPs6o5yGpp5JLtVmGwKSB1C5i9xMWf3QWjBAHjIJpqdeHMpg==
X-Received: by 2002:a05:6000:1787:b0:374:c4e2:3ca7 with SMTP id ffacd0b85a97d-385fd3f213fmr2377039f8f.5.1733235908535;
        Tue, 03 Dec 2024 06:25:08 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd687c3sm16056335f8f.77.2024.12.03.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:25:08 -0800 (PST)
Date: Tue, 3 Dec 2024 14:25:06 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 09/28] sfc: request cxl ram resource
Message-ID: <20241203142506.GC778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-10-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-10-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:03PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl accessor for obtaining the ram resource the device advertises.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 44e1061feba1..76ce4c2e587b 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err2;
>  	}
>  
> +	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL request resource failed");
> +		goto err2;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -98,6 +104,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
>  		kfree(probe_data->cxl);
>  	}
> -- 
> 2.17.1
> 
> 

