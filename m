Return-Path: <netdev+bounces-149585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0779E6550
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BCA2846DD
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69C194C9D;
	Fri,  6 Dec 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT6SPxeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F9183098;
	Fri,  6 Dec 2024 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458246; cv=none; b=MWcsL/GZ03PzGvwzFVjnhoSQavzKR9FsNRBBdIXuvP4yqdbSV/PcQCUgPP01s9rqfbs7mwM2SS/qkXEEWgAWUNfZfsnu2JROg2rttwCjbo/9jyB8Yn35ZRtRA7QKRJTUFg7VmazfugudkpnYnSGPXSr75ic8fnDYn/rGq6oWinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458246; c=relaxed/simple;
	bh=6MaL9yPxPwL/cMIGWq/VNsyMF3ms/J1O0zP8HGQRDsk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1+OuIq187rWsGdeNR5YaFPmTOHlQi6xXtItYsZ2wYy14DHUV069D0f7bElolQ8BvxlQnB5GfDyKHnGBVNE4oG2nV1zLvuQnvP9upVgoJtqt2HyCVPlviy84h1b2l5TTIBK35cjNADDvfifAxZxr+TuSlNW7ZM6rj8WtwAlFW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT6SPxeX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725b3b9fa6cso746282b3a.3;
        Thu, 05 Dec 2024 20:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733458244; x=1734063044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1sPGXkajczc/lVBkbp2d+6bdNJtz2tgNlZT4I5e7ow=;
        b=AT6SPxeXFgRS5Hia2CpjuXI1CdAXc7FTAAv8SGnJuJ1U3r01A2+7Ze+ruN/H7Dzrz5
         T8UiI9tZT6EtCXrKvSO0GBpnxkxRHq1qERAXQPptkq5RoNa9306OaNYVi9b3yOw8MnOS
         +nQMr2B9eHRUVr+PQR2mJJzcObza+4/K/y6IzjcWk+iePRiwUcMNYjIu2oPOS6ScjC0R
         rTFh1WHacW4JAe5xk/HVWNdJqOPBS8JH+aLdzkVZrK4ASdwKWPsptvexzbL4F/jv0jbO
         GAhPS/UDCHA52U9MiBrgTtMyBKw+TOh89CxtlMNz1uuP7PQZ2VxzX7CLZfgKxPN9/iGv
         Lrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458244; x=1734063044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1sPGXkajczc/lVBkbp2d+6bdNJtz2tgNlZT4I5e7ow=;
        b=FlAFpP9MjDdQ3nchQOJ1nZ+bLdZ2m/S7d2cuzL1m06zhsqt9BlvbhwxyxHlXFJ74BN
         k1Tik2NDMf5xdDD1p6Kd6W1culfHZF5MMvBjBX8hZbfSg0CAIfged4f2qxf+YX4tA9Iz
         qJdhAJRchyiGxsZNq4IQTNZk/67f0hDCF578ReIwRl5M5TlXlQAhvr0LA2wIUTbzYzvA
         5Q4WKFswCkHvJ6jfwwe4iNHsjdGkQMbz/aUZG1lcvhz2VqgC3ExhFay/0r2/ROtfPf2Y
         YRBEi2YJXsUAiKjeXApQPFjYWpkEF0DYXXi/p899K0akcbV8XvxqAqXQn94ScY0jW03+
         wCqw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+AbsZzx0O4kh9r1MairS/IF1+ixDgd49J+nAvN+hKA3DYNNnbVmSx8IIpmKWfWKaRA6kAPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYK3pncwyxVTpAwqOdSOeFyRmjICpMnA3LiPIgt3AWt0fD37yS
	lQ3OLCnkDXeQmj/LEsZ3Yug1jQhMDAI0tBuoDa8ggJMS6XkD1vfi
X-Gm-Gg: ASbGncsOwoqeaMqfjc8RC1KlAWMoEH969QnD+90UJVyCYNDipjsMzJy7Hc+ymPH2Saw
	MyTZe4DA+0IZBqy9d443K4BMWNB6bZthrfoRebB8ABMb89bf136HUm6KTvhKBTsne86kIXJmZgt
	Vl1o4eNnOiDCkxG5HaiCZpegljyGZzX88B5EvnTNksaKIzyt59fnNBvWqEQPI4TYxqfcektQBzo
	djiOdoorV7mneqrYp15EKMa0t86NKwdS7w7iUGt4A==
X-Google-Smtp-Source: AGHT+IFOs/OqzLx4BlOUbGjgz/Ms6FLoN9EHJyYUjsbIgX1/qVRrxHIYPedrI5l4cjyUGSX3OKo/LQ==
X-Received: by 2002:a17:902:c40e:b0:215:603e:214a with SMTP id d9443c01a7336-21614d2ec53mr27307785ad.1.1733458244217;
        Thu, 05 Dec 2024 20:10:44 -0800 (PST)
Received: from mini ([2607:fb90:8e63:d3d5:60d0:f219:70bf:2a20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29b4csm20010785ad.245.2024.12.05.20.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:10:43 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 5 Dec 2024 20:10:40 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 09/28] sfc: request cxl ram resource
Message-ID: <Z1J5QFZS5ZCDJggn@mini>
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
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl accessor for obtaining the ram resource the device advertises.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

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

