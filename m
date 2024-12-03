Return-Path: <netdev+bounces-148529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB39E1F70
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D83280D67
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A581F7559;
	Tue,  3 Dec 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRUnxdsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A351F6671;
	Tue,  3 Dec 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236514; cv=none; b=nIG+gT+mJsOV+2F7ciSTKxc6+4I0O4VC7DEirolpMSczpA+m02w0BQQOKdLsgNYq6CiUDBYnc2vZJNPnBQ6RmHUoJxhOGDg1S2DSDbIjfxx3teo98aouNLoVvIY62PweGUx5UxWik5TA8ijZ3xai6PjSsetIefzmTpKrvMxeves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236514; c=relaxed/simple;
	bh=P7rmLi54Mv4d9NoP+T3/y/5bBlleG+RQkSJ86Iy5xdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD/fczAtS0d4rgQ8HLiC5ekEMN87uNlhsKGGDffFO145u+Bm2tqNOzEj+5oMMm6KiXLr0xYmNNkyqx+XEY7zTX+4EhI1WOYzbN7lOJrZO5oF7kXeThwAjB22WKcok5PaPgOdnTl3lpkHhQZSNFZs2wD491lJv0uRDhM68t4BjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRUnxdsr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a2033562so45985815e9.1;
        Tue, 03 Dec 2024 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236511; x=1733841311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyu/2pHhMGFLuVestu1in3+WNSRMcaSil5Aa3Z7W0bs=;
        b=mRUnxdsr19QUHpW8811GpHznfZcVqkNFpPEBij+SMG+6nl+lC+10h8CS2Fs5mTrQ3e
         VTqj6tsKY0LUUyExL8M/t68bCu9oOeTUmk68pOLazBQnJJGqD1A3Rr+tWd4xcdNRXT9a
         CNJ9AulG07DSTqFNlg1FTL9H0domSCtriu9l/Tx1cLhfgW8dSDzzXM08Z8xT/DFEG4bv
         UedPs32iyyVuhJpZ0K/1iizYoCRP6GpjCLYGcBetk719ctNWaRkRU5yPvYPyliHm5lVi
         vkCkkxgkw4lETCbAcVdDOXMu0vn6Bm4k4o/PK36oK7E48ywds+6YTjE7++RDvkG0xnZW
         Ay4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236511; x=1733841311;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyu/2pHhMGFLuVestu1in3+WNSRMcaSil5Aa3Z7W0bs=;
        b=wEs++H3uQ30uRGpHfsp9ALvMr9B7CEQLmPo8+mJ2m/YGmPQ5YvqD0IiEV5se0YTZ7w
         c5K/cx8lAhKibcjxGm8wrYae0q7T9Rr3M6ZLEKTsZTX0QPVZSv+HDW/YAbiIA1v/khIE
         LOvLVKryYHojHsIOH2X6eklaVskKp9K8csyoTHk60HU+ZusnFNPIb525F/gEf6tU54Kw
         A8ppaIM25jkKf/qAzD3nNcfjqMDelg04oaVoDPuJfadA3v1p3EjoeGFINVshc3MqVtFp
         8lVC0zWVoqVYgZIxk04/JBETGMmiObcPK9rTdCH9QYGAzsAkOSc8qPZcGIrnNHq6rQ2i
         srgA==
X-Forwarded-Encrypted: i=1; AJvYcCWAwNkuR5WoPwgJ3P0vTLNO0J5oSMUdQMUqYE8NAiKmr2Yl+5VtgUvHtcD8lHuDvz73mvjWEjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxJaktbfOFijMr8GyLuuObRJ/DDCzqibLMBA6HvuX3+fUGNne
	METVm+/1GAni32hI3m0laArYBedQ7Lz0q/6iwiZ4qZvVuVYAcuMn
X-Gm-Gg: ASbGncv09AvnyIuef8wknq876p41JO8iYnS8a/asfDV5zA+G9FYDrKtqnjUCT+Dqxer
	oDS5FyFxJwcxYYi7DqXwVRnU+NMG1x8SV0R3H4FFIvg6sfmMvErqR6FTYJ0j/GMURm4KFOAkMDL
	MfIl4sZz3eMtpW1YcNh8fly7p9S2rt3QHt27vCFbx3VOhtzLTzPGfMaujLO+NGsHdWJhN5hhhgN
	ku1Kg0Sj/HfCk9LziX3uZL4PrWa8OWZXSTfjIhS7n/vDhLi1m0=
X-Google-Smtp-Source: AGHT+IET/tJslwZl+UzIaFNguesHOrVf/GbLRplB6wrG4RvjQRoT5pdmU8u2+P09RfAJIHPrkfGPug==
X-Received: by 2002:a05:600c:1f91:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-434d09a8dd2mr24599945e9.2.1733236510623;
        Tue, 03 Dec 2024 06:35:10 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f325fdsm196720515e9.30.2024.12.03.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:35:10 -0800 (PST)
Date: Tue, 3 Dec 2024 14:35:09 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 18/28] sfc: get endpoint decoder
Message-ID: <20241203143509.GG778635@gmail.com>
Mail-Followup-To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-19-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-19-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:12PM +0000, alejandro.lucero-palau@amd.com wrote:
> 
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 79b93d92f9c2..6ca23874d0c7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR_OR_NULL(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -136,6 +144,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
>  		kfree(probe_data->cxl);
> -- 
> 2.17.1
> 
> 

