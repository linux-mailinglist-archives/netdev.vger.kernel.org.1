Return-Path: <netdev+bounces-150323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364ED9E9DC8
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0152E188350D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B671537C3;
	Mon,  9 Dec 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFKqGEJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08401422D8;
	Mon,  9 Dec 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767396; cv=none; b=uHO8XbHvilyJRJ5ssR0HQS7/v7RS/pU2MGaxTAvyJZHUnRrOnb3eiYCRd+dRhyrYTqSpgtlr9biUMenNaqOygpE0gyWXOsX7MbJLConXaywNJBALsbvUWzLXGRfXdJrW5o21ZqHtE8AW4xgsOMH7yMCi4aq6Lh0sKMNb4q0dg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767396; c=relaxed/simple;
	bh=okgy+MLTRZVukPpkQdOnyKHTis1jPZQhb5A6/9Vibho=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTjICzrZNtt9PzAkUYURIC8z0FqD65VtKtHsQ5CJjBn8nUpEQDwL0uQjORoICVvBnJaSsiLrxg8KTG8jnKHANnwfxp5dFDrv0URqVQjeF9BEeofWp41D2om6SUoja+Ws8g9rgTmKHW8RwSyn81u/3s93rtlpuZ2IMUurG5KaXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFKqGEJ7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f00da6232bso14097757b3.2;
        Mon, 09 Dec 2024 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733767394; x=1734372194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fS19pHErUsbSBWymBFt8sxXHouLUsXPczLGhaJeqX0k=;
        b=kFKqGEJ7h3tfwTccuZLUZxm+/OYomZe6LwmJ/YLRSTnuHNMqt4i02Uot3gNTv6v+dL
         3xYHPVWK7YmaDkuG4B9lC2k/wKg4ERhP5OZ4yA8WFPaie8m+xC5xe2JEsDJLzlrlEFqd
         cA7y1fUp1L2hDOytkrloesR235GhE8qrJM/3uyby2VnPtCcO/LfX6/2iFZncz0ePNRY7
         siQnCAwcgeieJIZLWI95EPzbUdjIDo1PvzpnCC+nM+IHzXtokPJIf0jtmqjGucPLw5Il
         dlLo9PgLFgUdxQMTaSYz64o700Der2g++CyggKb0DDeTZT4Wq+f8tv/83PIthIT0Jz3V
         3G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767394; x=1734372194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS19pHErUsbSBWymBFt8sxXHouLUsXPczLGhaJeqX0k=;
        b=S+mgQUK+Mjr2fNuoPgWodVLs0vXA09PoUR0UQO9nYFspirNnu197r9RawlX6K9mcuG
         QUUZUXq9D2IcxU1fMZ20iUxvdTlJnUb/BX6JJBEdJGOSmIpWC3GC35L5ljyvDlrN5ttc
         itn7aKhU6PAYmiHlywJE3xpX4IflPjOzaxHPIlco0DSwRMKxFAh7889rioITrBiymlxk
         inieDEhm7jbeic/Tva/W97gxLHbtpbG8g+q0sTdxcpG9sEhUP2NeADjBkr2gDbkuscQW
         YdMET/FE1LSWyaUdimZbujWDtTzKqnAs5av+UxUZkuUZTHgmFK2o8JuE7sXvVwquMmR2
         t/sg==
X-Forwarded-Encrypted: i=1; AJvYcCXenq4FLCftl1HS2wk/LY3/kRQ6DGyGJLo/biLtIPzV1fv/O8Q0j9xGiUUD9S++Ct2XFHRYF6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6PmTNP4GaNUYAIJ6e6LIlcsiz8EL8gCc4lKcLgCzyrMsdxuo
	ESpivJt2uEyUPNQpBdKLbFIDimgqPRoM1R6p1W0+9ayefKKje9ku
X-Gm-Gg: ASbGncumlnEM2UG4Co6WgTcZyQmRDGxQokx9UP3dPpWsqUcMlC5xDs2Yic5HjK77kGx
	oMuGeWpGB9ToQ64fNBn22Tih8tuVRyBed4ud5pCCL+8uop3HMxKbgr6s9dbJNX3OmOcXHleWce3
	4zz9oDmxWStSHUnZMhfyVxCxeSX0ZKx9wnUqZg68pXBQJUMhJzGesm0q83JsoEiWj1iSPFr5PWw
	DFSqcZZW4NTmhLXGyDVRjqAzt+d+VpZH50=
X-Google-Smtp-Source: AGHT+IEgFSaAMEn7YPDUy1WGNAM05B5/pB6jeAuu33qoe9PaLjRqvDPAr7QiUoOW7yfxWlp9bunHsQ==
X-Received: by 2002:a05:690c:62c8:b0:6ef:61b9:e003 with SMTP id 00721157ae682-6efe3c89e3amr133624417b3.36.1733767393795;
        Mon, 09 Dec 2024 10:03:13 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efd384e227sm23966177b3.2.2024.12.09.10.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:03:13 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 9 Dec 2024 10:03:02 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 19/28] cxl: make region type based on endpoint type
Message-ID: <Z1cw1oaOhq4OcNHS@fan>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-20-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-20-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:13PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2ddc56c07973..5f4d285da745 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2658,7 +2658,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_decoder_mode mode, int id,
> +					  enum cxl_decoder_type target_type)
>  {
>  	int rc;
>  
> @@ -2680,7 +2681,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>  }
>  
>  static ssize_t create_region_store(struct device *dev, const char *buf,
> @@ -2694,7 +2695,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, mode, id);
> +	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -3370,7 +3371,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> -				       atomic_read(&cxlrd->region_id));
> +				       atomic_read(&cxlrd->region_id),
> +				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {
> -- 
> 2.17.1
> 

-- 
Fan Ni

