Return-Path: <netdev+bounces-118758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADBD952AE2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00CF2824E1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1C17AE11;
	Thu, 15 Aug 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWxF2fcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE517A5A4
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710076; cv=none; b=gn3BSmBj4uGhpl87NtGCgvNMGrU4s41OYsPrR+bF9s6XXQLVkRixlrI4ZUGpUWihxZzmlGoYaXavgrBhXrYCqPrXk1FB5TsgP1uVHv6ex+1nITe2aVNKFyj+KaYEytMWld8ZmTSjFuVss2VQlSAnwSJ6ieGRqNIbnuoeBbIoDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710076; c=relaxed/simple;
	bh=X9uet7zSuLWltgukVpPkGzrQpzr2inzUwQzA4RQchBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOs6B2vXBIdX8whSRQJrUmGQRWvhwZyEi3AeQQviLcJlY3WWlWlaFhs4ityIVMEs4C/ZTN6YwzBvbzRptUHR+Qgra6AUikzsrWOjcK4qjMedA5AQvghQMk3wb7C6TgraybJ3OksA5ZX2QLiKq11iPc8/U7TliqOWIG39Ciz4no0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWxF2fcb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530d0882370so622126e87.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723710073; x=1724314873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQovpbfV+lvA+We8ZKnKw6yGfC3p1m0QQk4DiCfWvq8=;
        b=BWxF2fcb5eYgdA7500OoJXsfhi0hoHXVsOV7l9dkvGilaME+LUE0BJEKBnCxZEvNRt
         MfWS1b3EyqI/6+Zv5ZDGb0XfyMGWp02IPQ9NgmchbCDP6qj5lPO51dHD/zFhakuKY01t
         bckygiHf0G1U7p00CqOLf3e2XpCWsrvlSFrmyIaI1bGTTC2YNbRDDLJI/X8k28zUI0eZ
         i2ui9YOZUAirjMgdYlOexTEaeD7Uxr/kandOfb5XQmyfr6I+xc6njIAew8c/HTkRScHj
         9AUkCFwh1BQVSiI+CklZ4anHy3IC2K2VrfXgdPEi6eczOFnuWEKhA8KUP+VarB2PfDxK
         m7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723710073; x=1724314873;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQovpbfV+lvA+We8ZKnKw6yGfC3p1m0QQk4DiCfWvq8=;
        b=IpjAbItKe2lZ7mXXUpZRBtdyBnf3km4QWu4bqf3OEVIw1iuJdmF4AE7BpVdspPkSBg
         wZtjYxt5bkkpSXgcZ9Um9lz3uShvNV7Pv+YZViQVWZ9GP6wj1NWJV1wXro2HQuuG/11b
         pDPMugJ/ELOvMFvcNR1gKJoNh9AoNQQhOrkj+krhZ9WzqRx4yKKCrIEQeOS4is9goPZl
         m2cteeQOSa2oUoOKUUm2Rt7Z0Eo0jYFS36MxXNx98N2CXRWrlMtzXJYF2s3w60FGgKK9
         3E4ss6QM9twE95Q369/iCvUAgNWVan1Jfl/So3at2RvhMF4KJ6ez3jTo/O3VyLXArxWR
         Vlrg==
X-Forwarded-Encrypted: i=1; AJvYcCXASTeYaNI7VY3XMHvItFPNfhVGojrO65MoTP6qXTjEDQ9TyVqSM1RBJySg4bHG3EoIZLkjfcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3jRziXBX/kHz810xpKbFs8vA1z5HonhRTThApIag/nm0ZdD/
	ez6zJr6/g04/lc0psJf40q/IZv9M7c6GHdIzQRNKokMiALz++ncd
X-Google-Smtp-Source: AGHT+IGKrUPCNKDWXt0BFKF3ifm+WuzsdtQAgsKesNgkcnMb6i3G9+KHzibegLwVp7rGanaMzNHcYw==
X-Received: by 2002:a05:6512:3b8e:b0:52c:dba6:b4c8 with SMTP id 2adb3069b0e04-532edaa1d70mr3670713e87.13.1723710073017;
        Thu, 15 Aug 2024 01:21:13 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71cdcsm42021165e9.30.2024.08.15.01.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:21:12 -0700 (PDT)
Date: Thu, 15 Aug 2024 09:21:12 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Yi Yang <yiyang13@huawei.com>
Cc: ecree.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	alex.austin@amd.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com
Subject: Re: [PATCH v2 -next] sfc: Add missing pci_disable_device() for error
 path
Message-ID: <20240815082112.GA35524@gmail.com>
Mail-Followup-To: Yi Yang <yiyang13@huawei.com>, ecree.xilinx@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, alex.austin@amd.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com
References: <20240815030436.1373868-1-yiyang13@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815030436.1373868-1-yiyang13@huawei.com>

On Thu, Aug 15, 2024 at 03:04:36AM +0000, Yi Yang wrote:
> This error path needs to disable the pci device before returning.

Can you explain why this is needed? What goes wrong without this patch?

> 
> Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
> Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver")
> Fixes: 89c758fa47b5 ("sfc: Add power-management and wake-on-LAN support")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
> 
> v2: add pci_disable_device() for efx_pm_resume() (drivers/net/ethernet/sfc/efx.c)
> and ef4_pm_resume() (drivers/net/ethernet/sfc/falcon/efx.c)
> 
>  drivers/net/ethernet/sfc/efx.c        | 6 ++++--
>  drivers/net/ethernet/sfc/falcon/efx.c | 6 ++++--
>  drivers/net/ethernet/sfc/siena/efx.c  | 6 ++++--
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 6f1a01ded7d4..bf6567093001 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -1278,13 +1278,15 @@ static int efx_pm_resume(struct device *dev)
>  	pci_set_master(efx->pci_dev);
>  	rc = efx->type->reset(efx, RESET_TYPE_ALL);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  	down_write(&efx->filter_sem);
>  	rc = efx->type->init(efx);
>  	up_write(&efx->filter_sem);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  	rc = efx_pm_thaw(dev);

This always falls through into the failure path, even if efx_pm_thaw
succeeds.
Same for the other files.

Martin

> +fail:
> +	pci_disable_device(pci_dev);
>  	return rc;
>  }
>  
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
> index 8925745f1c17..2c3cf1c9a1a7 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.c
> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
> @@ -3027,11 +3027,13 @@ static int ef4_pm_resume(struct device *dev)
>  	pci_set_master(efx->pci_dev);
>  	rc = efx->type->reset(efx, RESET_TYPE_ALL);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  	rc = efx->type->init(efx);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  	rc = ef4_pm_thaw(dev);
> +fail:
> +	pci_disable_device(pci_dev);
>  	return rc;
>  }
>  
> diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
> index 59d3a6043379..dce9a5174e4a 100644
> --- a/drivers/net/ethernet/sfc/siena/efx.c
> +++ b/drivers/net/ethernet/sfc/siena/efx.c
> @@ -1240,13 +1240,15 @@ static int efx_pm_resume(struct device *dev)
>  	pci_set_master(efx->pci_dev);
>  	rc = efx->type->reset(efx, RESET_TYPE_ALL);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  	down_write(&efx->filter_sem);
>  	rc = efx->type->init(efx);
>  	up_write(&efx->filter_sem);
>  	if (rc)
> -		return rc;
> +		goto fail;
>  	rc = efx_pm_thaw(dev);
> +fail:
> +	pci_disable_device(pci_dev);
>  	return rc;
>  }
>  
> -- 
> 2.25.1
> 

