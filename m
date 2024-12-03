Return-Path: <netdev+bounces-148714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7F9E2F77
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44121B2DAD4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAE20B1ED;
	Tue,  3 Dec 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmRfFaLL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE720ADD6;
	Tue,  3 Dec 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266765; cv=none; b=k2hYAl695jszTZ1w0Rzje5BK1g1LO7X/dnGQBLNio6SPNwylq6kvbnbEMxGLt8GOcV2OJGAxzbDYmfgvZLsWtqSSBNcilL2IN8eSt9FIlx+KHmXI8PCuBAVsdROAhZpVKm+Rnq8eHxNpS2rk4ER6mSS7UP/IyzKalXtAXoLnQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266765; c=relaxed/simple;
	bh=TwAmCy+rKr8tByEDIF9lD1+Ju6rZqoIWiG61DMg6trs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZVJx5WfbtFEmiLoRUgavqNDTy38Nw+zEjanPiYtWWzYW4ckCzACvDtSHn/0Sao2bicpo5uhXn3NiNVy60VzeT3w6w/VjAyddHUnRqH56lTJlpVYG505Ma03Zd8o+dghl6/N35iD/Q8NNvFkIZewhdi8fb3oSw99umS3W5E+BOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmRfFaLL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so4471462a91.2;
        Tue, 03 Dec 2024 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733266763; x=1733871563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UTi4pLeL2t0JqyUhUgPH4ma+9gLh5SmQGIvuK937N4I=;
        b=VmRfFaLLIoSyuk2L8kQRQDvfPiS5Gh8PxPeyme3uUjscBFd0fnAoYP6V6jgu0RS9yY
         BBVI9dQSznOQeX/Dl/k/h3fc4YMZO6v1XABVHCKpAcn5rvS+Q+botfUcveKg4HOn/dWy
         vF0XQy/ewg74OEzFcVvYIreamF+idS0hvu5klaxpHuYLcuUoL4DW/1hZXcbW0T8k4Ejx
         BhlZwPwZsyio7KRsRngt/vg8fIXwopP/HbxYN3ETqe2eP+xin5yebj0kzrWiSl30Na33
         DmUTmQUbnwj4zNrAop4iD4v/5Bt1gWAJTH3hayU4SQIOYvxmGXo8xK2LvpDcKIuBS0wl
         vhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733266763; x=1733871563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTi4pLeL2t0JqyUhUgPH4ma+9gLh5SmQGIvuK937N4I=;
        b=eoyRyqt6XsYXXqIejaJT+77i8RIK22A6584tK/P8A/MtJSpezSKF+T3bLjk9lmWdLr
         DdWNFziS7JJj4WijjKB72tjJUUD+DOxOv0JlYA8/yitfWCrJxjhrJp33uW61dhtRPq6a
         VN8nx4SsVOx5JMRAOsT1YuVhTS/0/TUavLBN+R+4PKun6BRXc26MpTOtT09f+YF7iAAF
         JHFiJEDPU6PjqGC38i9cQ+6xm+IKA4+sOSAomFKZZQDjxBCCfdp4KiwXN4ipe59hCZQ3
         v+fkEmOcUuP7Lmb1reHlhYg2/GAdMt4avgd6kjMkI8R5Pp5dm44gFoIfBQH0nrddaD4L
         dJTg==
X-Forwarded-Encrypted: i=1; AJvYcCVwFw7Gad941stTbblHi2l7hS3uuYiNKOhGAhw6arhIK3rxHQOwgA/O3JLsbv3cbj2P362tAtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcUK35w1s8RmWzov3U9wwtEsqXHvlTwmSpkOxG/TmC2dy87gn
	mSlmW/8eYbhqhcmwrLg9fCnR+MzbOBVL9MPAEboHUPkHJJa3orJK
X-Gm-Gg: ASbGnctpG9eDgVuLSjp2LAd8r/LyWikvkOxEPf93CfxC17nYXhka8syk2bf98UV2XnH
	xd8Lp/v+cfkRoZtemTWnxzXF8l7HjSUB2IN6cdezvxsbk3+EZEZnma3hF0DqPrDDHr29bh8qHfO
	8Dx6v90VVo3rNjU85CcZAX/MWzgv7opRqdmvl3QwDK/zl01FKTrlmdWLAtSERXINHcK3T7ts9y9
	yFKWgmNnqYKFEmxfOnMkSzlXg/H2oiwMf/IDgcRut3GZTJeuO6ncw==
X-Google-Smtp-Source: AGHT+IG4fsbkq9iMMUNj3txJacSfIEB/xbzFYtwLwC1JP4kIz62tJCQt90cIIxkPyWuPnYTM8l4/aA==
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-2ef011e3749mr5493711a91.2.1733266763122;
        Tue, 03 Dec 2024 14:59:23 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701def5sm91838a91.31.2024.12.03.14.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:59:22 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 3 Dec 2024 22:59:20 +0000
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 05/28] cxl: move pci generic code
Message-ID: <Z0-NSDoXY4eAV3K8@smc-140338-bm01>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-6-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-6-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:11:59PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 71 ------------------------------------------
>  3 files changed, 65 insertions(+), 71 deletions(-)

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a85b96eebfd3..378ef2dfb15f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>  
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
> +
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +
> +	put_device(&port->dev);
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps)
> +{
> +	int rc;
> +
> +	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_setup_regs(map, caps);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
> +
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eb59019fe5f3..985cca3c3350 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +bool is_cxl_restricted(struct pci_dev *pdev);
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 822030843b2f..e7e978d09b06 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -467,77 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map,
> -				  struct cxl_dport *dport)
> -{
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return -ENXIO;
> -
> -	map->resource = component_reg_phys;
> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> -
> -	return 0;
> -}
> -
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map,
> -			      unsigned long *caps)
> -{
> -	int rc;
> -
> -	rc = cxl_find_regblock(pdev, type, map);
> -
> -	/*
> -	 * If the Register Locator DVSEC does not exist, check if it
> -	 * is an RCH and try to extract the Component Registers from
> -	 * an RCRB.
> -	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> -		struct cxl_dport *dport;
> -		struct cxl_port *port __free(put_cxl_port) =
> -			cxl_pci_find_port(pdev, &dport);
> -		if (!port)
> -			return -EPROBE_DEFER;
> -
> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> -		if (rc)
> -			return rc;
> -
> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> -		if (rc)
> -			return rc;
> -
> -	} else if (rc) {
> -		return rc;
> -	}
> -
> -	return cxl_setup_regs(map, caps);
> -}
> -
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -- 
> 2.17.1
> 

-- 
Fan Ni (From gmail)

