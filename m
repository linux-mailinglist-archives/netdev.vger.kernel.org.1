Return-Path: <netdev+bounces-149580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB19E6513
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E308728A99E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502F188906;
	Fri,  6 Dec 2024 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UITUCQ1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74B339AB;
	Fri,  6 Dec 2024 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733456111; cv=none; b=KzLDQkLkFH6a3huGlmE1kxCnVuRRBMzYCP+vJq+eLsesM2cBJyYgSlKg0Wof3743O0FfLdlhLduhtAEuGfOIFT5ne0CpXCRQw1btfZIRcIuOoMJNMulaC+ynCpRfNlXsraMpXnLP08gMqetU5nFaxFVzaZifLiKv74cbgzZJazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733456111; c=relaxed/simple;
	bh=141rHwWG/5xaIdP6tAd76fkIH872PUveriDNGAWF9+w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiWJ9OJOqWymq6wbtDjSJw78KB2UjQWzQikcHA5WaOgnXLrA4tvYJjrHlhejPQvh1d7B/D7oHp/J2kYUwIU305GWKnW0op6Abk3G5rpQi0+um3BvLbjJGBNTeOtMbR72156kL2fjsvYN597XbzyGZIJj2AHc5AVyUFsZhdSLirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UITUCQ1J; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd1403fcbfso1198939a12.0;
        Thu, 05 Dec 2024 19:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733456109; x=1734060909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqJRvLw9N8O71RlXU+UvAAGHuUIAq0psVBbOSBxB/2s=;
        b=UITUCQ1JZHosKLGoCbGrC/X2FisTK41pqIXWOZ/gvd17IoREx59YLMh8pVUOVntxli
         kMns99Me3t6T7Ly/lajnBgRNQ9KaQABS9Vn2kwB0j/i4Z2p6GX4L9atLmRnORD1+86xj
         95QAd7pP/CxzeUuLp5aJf7mqHYVuhL5cN3Pdcxt1LqYAiEmhRGoFO5tKSHYfovoXR65H
         0dW5AhZYqMRxeFE164Z001aN6GdAVrnuNwS4uTniHoxFFgLJdhEPXy+UClvHmbiugDFs
         aXcZkDI+YdBeRsel9plrRIXchHHYGEUNBMoIj2I5wQjvEZk7IWE14cV+Ab60XX9cuuri
         H+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733456109; x=1734060909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqJRvLw9N8O71RlXU+UvAAGHuUIAq0psVBbOSBxB/2s=;
        b=ppS64nvkzfBnuC1O5Qr4n212C5NpuNCy6spxAgxgnHiuALF1kwzM1o5FFFFNB3p0rR
         iOEkWddgjMY09y7H8FejoezAuSjn8ykZk6kSrqgL3V6+AI2XJrY2EN9tEc+WQyEmc2em
         20kfctsf0oSUJu8X8W2MWVQ430vdR5Y8+CxwzjdlNn2OZt94TmHPnRI4+WFUn3g2rMRx
         c7BJZZI4CpPzbLADIranflAuHbKClkuTE1E8tK1OxuV6KcY3TRQqQ61o0dtCvNjcwCCG
         oXIEyJd01u435pjwAsH9G3G2j9jpHTqOWXEJyAq09Jyw3FAxeNa9SUU5cmnnBMa9/rPE
         SwdA==
X-Forwarded-Encrypted: i=1; AJvYcCVqMPXoX2RKWuYEahAE9VWrh20z4owEZK3M2e/FpqGiN0sC8xMHEtQk5AY7khg+DpxcGE9iqxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtLvdqTSe+rcjvMlZa5kmN6K7SOQc5s6WVUWsRwa720S3+IfX
	2exIWQCtThLzk18TkAPdIJ2KZ+LiwbZ9H6FCenqPQLPk4LZIkjhs
X-Gm-Gg: ASbGncs+kUf26HaV86ofG3t0rJIV0YJXG9ou3qltjTGYfdnGS/mZ3rSGTIVFJjNf4NK
	jRsQ6YYL2VvIDI85PKki1W7ekl4XJCOL8O4d8GHfuvbjTayZCwODXJ9gnuc2HsYG53kOZBLJJXk
	CwDxQ7ZBFyrS4qyUrEq5Gzc5rpgYZ2ej4z7GRCJrE4urqv5PwrmChWmAKs3OYzgLSAaStDAFBbV
	6L/gABPT1/2fb5RMkFZenQfXjtDUdGN0jKNvxNuYA==
X-Google-Smtp-Source: AGHT+IGCG2xyQLW9GgBKAgBynMNAAulAZ0ZhRg1Pa67Co0GBUCZrA2ZRRFZ/71aPxGIm1goYNEQsiw==
X-Received: by 2002:a05:6a20:8429:b0:1e0:d123:7166 with SMTP id adf61e73a8af0-1e1870bd916mr2282759637.14.1733456109512;
        Thu, 05 Dec 2024 19:35:09 -0800 (PST)
Received: from mini ([2607:fb90:8e63:d3d5:60d0:f219:70bf:2a20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d2c4sm2348992a91.47.2024.12.05.19.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 19:35:09 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 5 Dec 2024 19:35:04 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 08/28] cxl: add functions for resource request/release
 by a driver
Message-ID: <Z1Jw6Iq2c58_C5rt@mini>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-9-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-9-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:02PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create accessors for an accel driver requesting and releasing a resource.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 8257993562b6..1d43fa60525b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>  
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		if (!resource_size(&cxlds->ram_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for ram with size 0\n");
> +			return -EINVAL;
> +		}
> +
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +		break;
> +	case CXL_RES_PMEM:
> +		if (!resource_size(&cxlds->pmem_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for pmem with size 0\n");
> +			return -EINVAL;
> +		}
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		rc = release_resource(&cxlds->ram_res);
> +		break;
> +	case CXL_RES_PMEM:
> +		rc = release_resource(&cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 18fb01adcf19..44664c9928a4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif
> -- 
> 2.17.1
> 

