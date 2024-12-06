Return-Path: <netdev+bounces-149782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F09E76CF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE7282419
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA41F3D5E;
	Fri,  6 Dec 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmUmbbkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1E206274;
	Fri,  6 Dec 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505130; cv=none; b=G7hE9A9qcLhO24vMp88+rqsaisiRJckkXreoWSMRlorYcJPQyaqxm30KYv/r5owSyjvsjDuEQmb8gk0BXgwWriPeGvRsiv6z7HC8TrT1olYFdOJHBGP09H9g000CbdLV8vCkB2sYR9BfWwiiVFD8Vk30ubliw4uARnx6oeo4VOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505130; c=relaxed/simple;
	bh=Z9jpkL9lcPC6GbbHMxn23dCagEYhzC7cGAH8StYauLg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu4Jjewy3KfhPIQMXbncQR8LOE9uv7zumqvunqnbA/tMqKmXeHJEHAkhtgdOhRIW8IO0A7TR9VZ9ky8LfGVp1mkSPgJwlVfFhwp0Lm48NgsDbiWrYkVocTUnR7K2xlMekv5ylorvOJHwNIpSAz8ed0oQe1ZzhZWrXrYvzo1YxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmUmbbkG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725abf74334so1935036b3a.3;
        Fri, 06 Dec 2024 09:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733505128; x=1734109928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyRjfFVucsezeCVsFiNo9bFijXbZ7Qu5ifeQgImd5Gw=;
        b=EmUmbbkG0lcrsTyXM90Mk7O2b5sXR5STAco/+SezzQd7W22KAWL+vYr6RgEzVi1Aw2
         lzA5GwzbvnKUVDgnpaC3/GMCh1aTCJCZ2eDaLzaHe3mVjqpzTUaqcjVAGLtoEYZZkpWU
         OK9zLADcqvH/faYcGI6uptXrBtIPh/FA/bVhnPzhwHhn9mcLr0w4AQnzi+ZwDNjohxg+
         fm06HxxOaOdLoJrJdhvhPozklOkGsRV2CrEZoxZ8Nnau2tkMENLKhL54L5a43Bi1Iuah
         Nkj1iGqzL96Yn4OzoqOHMysC+ILC/TZ2TRUDlIpMoDQWop3RZk0dWsKKVU+DjSwHBS/F
         JxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733505128; x=1734109928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyRjfFVucsezeCVsFiNo9bFijXbZ7Qu5ifeQgImd5Gw=;
        b=F16A0ZT0e7bBa0adS4N5HkxqVjR4Heusq2xmVjcYaXe+JrXHNOUjS8wm+ZW/8GyNnn
         WxEE2oYlIyaBOleGmsyYeXg2GFBh9H8UCsPJ+i3aSLxYShmS7lBVsoV30wlv2saQcTAm
         TchfUQSt9zmHG7oJYH8MoufdCxvsX1xQwD2R19A4+JP/K1y4T47gNOigf79Yvcf1+158
         jaC48dUeqF9qOCzxLmx2kNLYdWjJJjtULgbEIPqzj6WBBeaHVr4/Ls7ti7zjMphGEtT4
         Xhc90i9/7LDlCRjREjPgmHmjuK4mhCUPXa+DsyKEMOVgzxmy5/hg6wKKbKuw7WO4xhdk
         iWYw==
X-Forwarded-Encrypted: i=1; AJvYcCWfc5fANyzUcxiM3LDWh5gDmYHqkJOl8nrqarzep4CBOwyxjGE/16pmvYvCAYufMGqNib8Ly6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMGoPAzJh8vOVo1DlPrhQ/jC06v99oTXD1bMtkkAJ5LcDQaL8
	UEoSmsXRii0tK9f2Rxm+Y1LDIkCdA68T1zfMkNu8xSJxbuiFpWfx
X-Gm-Gg: ASbGncsj/QVf4U2iE7wFwSR/V9xwsNcQRaB4AHjhBtaI8kxrC01EOrscCaPLsKrn1+E
	HVn+pShwpYiwcMWzebm9Su1NB8xYRuhztixf1ZwM217t7hiWX+zQg4k1Y7LK2Jyp5bmXYVOIR0c
	iUH7snLIYCSLrwJUbWPAhbs4GnX+w+trQGKORANXn2avituz7OxHGUpMm2UfALYaJs+PXkTWRm5
	hR0kj3xUPa3P4qTbmCAvV/5RibqQSfBvxXECVJn
X-Google-Smtp-Source: AGHT+IG9aEh8xVegdDO9gt9ImoRXQBRnk/rAL1B7XxdyWT8laEnBfVNFQzj9E7Siq3OTiqKo+q8xpw==
X-Received: by 2002:a05:6a00:2e87:b0:725:b347:c3cd with SMTP id d2e1a72fcca58-725b8118dbfmr4233383b3a.9.1733505128252;
        Fri, 06 Dec 2024 09:12:08 -0800 (PST)
Received: from mini ([2601:646:8f03:9fe0:713e:4b65:ca0:73a7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1569b751sm3277372a12.5.2024.12.06.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:12:07 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Dec 2024 09:12:04 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 14/28] sfc: create type2 cxl memdev
Message-ID: <Z1MwZHGBfkgi9X1i@mini>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-15-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-15-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:08PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index aa65f227c80d..d03fa9f9c421 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -95,10 +95,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl_set_media_ready(cxl->cxlds);
>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> +		rc = PTR_ERR(cxl->cxlmd);
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err3:
> +	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err2:
>  	kfree(cxl->cxlds);
>  err1:
> -- 
> 2.17.1
> 

