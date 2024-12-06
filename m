Return-Path: <netdev+bounces-149848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3677F9E7B13
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA44166932
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2031946DA;
	Fri,  6 Dec 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMiOE7o2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414422C6D0;
	Fri,  6 Dec 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520995; cv=none; b=iMrgYexY2Lka00Ezf548wVSsJ54QOLlOf42XEhsxSUXsg+lJ2U9Ve0cicVXkwJoVSbCrUX4ae7r4TzCLluYyUH8LtLJ0CENUQogIKBrrTBKWJVH1EINufI/Bckv2X7joLh6drVeB7JwkLnlOJHow6cx4QhmeLRvvDm1NmvAYGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520995; c=relaxed/simple;
	bh=QPqWR2FDz4pWaP5G6VyIgr7hcD704jyL49nb2VFX11c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyKM3qKjYpq2+yiKjU64egjaKbC4mqNqUiqo+JTYG/dDPyjUPZ65UI/uXP8X45zrXW7aMbet3/JDtXUItyxNWkiyjiqsk3q41QMs9w/sUGuL0WOSQSy1Wde08wl3gxgrtOG/BHRnSG9zsbHgCi7RHLmiPvyN5c4+vVinm9nzFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMiOE7o2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2153e642114so26127045ad.0;
        Fri, 06 Dec 2024 13:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733520993; x=1734125793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3QuTxe5A7kGUrMQS0h4Kp+tU8tD0ghWVw7N4Nu7pm3w=;
        b=SMiOE7o2wl4hqmbrsAiE6UQyMc+TYja9PD41hYoxaJ7hT7EXBGA85/n93/dW3oRscO
         fF7Hg0NVEpXLRbj+qrPJ4rwwHWbBLnzHnJ5nKWFFcm3ku9PQhhXhdYYgTBOkTb3eSCLR
         5nN3Twua+5xIhGBbY+wglPzOkpaB9ME2TU7yA76HJOerfr53la+O6OkV9gHJhGLfAc2K
         Tp9+8nuCpbzpwvvYFFpLQOiAFiZtziBSDlIJK0fayy6PVuPP/DsokerC9+tEJ2txrnhJ
         bV5s4lTFsFpL/mHPmi97Flmgj1/2vj8T+55OJrA+qujgo9yLWpXsbVQIuOg4pGnoILg7
         e/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733520993; x=1734125793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QuTxe5A7kGUrMQS0h4Kp+tU8tD0ghWVw7N4Nu7pm3w=;
        b=Lxty6XT9tKbl59hp8esImR2D2iqrOtyoGw/U5r7DRy5q9THmsulYDK4jFtI290RF8q
         fG0SWy1qFwmKZONj5TF9F7FXFYlAbNtmLUzJc+mw7RXonyH3/fMHK472tGjtf5TbryFr
         PbkYBY8BpxyyQRRGYSKZ0tjp3NXOo7muDWjegPV25A1Lb+BXzpf3wdNRW5Z+Q+KIYf/k
         YF9yBrquJtbdsGnjuy5qqSjJaBMEm0ZJ4O7O5Ls2+7x7t2SBmdzNbsFnOk+uopdisTr/
         E9C1QA+bV7pfZ533q0dyvb72EdxLqD5CFKqr3WT6b/xh4O304izuscH8BCXU2UQ5h+NC
         eCjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrwQdjn0HppPr93Aiyyg0heOVOxk98YJxi9JdoSm1YhjLWYjmfbizs8RZtv8adj+4CUFdZt6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7nGV1TPDbc734YYz/pnrpVDeEMAOjb6Sa12Uwv1FsQCzwLW0
	o1O+BAVddSuYtnsqnp5MgGOctpyHpTvVg+M0wBd728+kmunZHYCg
X-Gm-Gg: ASbGnctCE0jfYvLDG4peBZVbFS8iTVVQfIQOlgR2tRfZKAMIy1YjNyefFXQ6KCOYwVb
	sEqPh1o1XlBceFx28Vhs3SbvZK2bwtiNpBrWRJDFVtMSHVy4dp3LclSKbjmrKVE8ASQJMX2hpMi
	Bqm7n1+IrBST9ORaKe5s6zq5AiL9JAdvGSM++WILC3kQhD4xADT/xRqSiqyEkz0JTx3vgGi5Ygz
	biOBXm4cHmy3dFO4b2lGgnXBZQd2dGclYmDonmrwA==
X-Google-Smtp-Source: AGHT+IFQphNBxCq8SCyMh4I1DdGt+dydKcZ99ziCuWxzATcigdfuG2l+zsZAy2HvoHhrZBUe8NvpEA==
X-Received: by 2002:a17:902:e54b:b0:215:4a4e:9270 with SMTP id d9443c01a7336-21614db9e62mr49328205ad.52.1733520993054;
        Fri, 06 Dec 2024 13:36:33 -0800 (PST)
Received: from mini ([2601:646:8f03:9fe0:b125:86cb:737b:2a61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efc5efsm33065775ad.150.2024.12.06.13.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:36:32 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Dec 2024 13:36:29 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <Z1NuXSKPvND9eqA4@mini>
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
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for availbale HPA space is the previous step to try to obtain
/availbale/available/

Fan
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
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

