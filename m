Return-Path: <netdev+bounces-114234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B8941A77
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8CC1C229A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C118454A;
	Tue, 30 Jul 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APykGfmu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590EC14831F;
	Tue, 30 Jul 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357847; cv=none; b=UusPATecJ96u8BTZ4kVYFKrq3T0ccFUa9SBeoiDIfz9SRwgForsuB8Y+l1cnOEJg9DONxX7sL5SuJQ2//rZrVzpanS40xQa0YNx9NOPK5JkAkhZEFRIjElvNZujjE/GFkkj7R/flCY6Opi89grvzDSkCe+cFtpgN/uOv16ehePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357847; c=relaxed/simple;
	bh=3a6OvZo4Hj14qRFssrmzs6wWYxe5MMQzPlkSR22rbPo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiTZqJWxpChHn72Y14BsP/vfMEDLPto9UycskV0+FeRJMRiq2JEOVVDPfdKEDCGSMe53Pu4Gb7I3YqsZE4c1xpPu89jPcKjsGByPLKDCVKJgTk947PWR9331qYhuh51jWKEhj4l/hTK793eLoQix6JKzVVYxvOMUjiOt1DQV05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APykGfmu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65f9e25fffaso35804437b3.3;
        Tue, 30 Jul 2024 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357844; x=1722962644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp1ZetS0sXF1CjQKcb+ztjQ+Hp2ujG7Nc++ITl8dDtw=;
        b=APykGfmuesax07hJMvBR1Ad6L4UriNJQc8HZaQKX6StNoSp/xQWohtAb5GSV9f5s+C
         93nj4vm4v1y0XiOBbrTRQYOSNNtPE6G85ikqxk361ivmAQPQNfyJaZk30FLwkHaYPkE3
         Xk5c01G+1nhLiQlT0xHu2GprfWLZ9+KG5K3VByjFWXE+7FiIlDMp8la5eX/7QPeO4rs7
         LUCx5pfNOMV7y0BlQVOOsF7jPP7KOM2grdgUaXpSKZOlprf+OrUbzi3SN0WT6lwNW3jT
         YFHHdWV3IseLoB6kmHP14y8Ip65FmetdOZjsGKSui6eEh9hwuhKQQry3Cb0VfZFqCk3A
         026Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357844; x=1722962644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp1ZetS0sXF1CjQKcb+ztjQ+Hp2ujG7Nc++ITl8dDtw=;
        b=DDtFm0GXxwylRopFbgLMUcIKHP4wLkpTRws8cHRPOaCkqTIWqZb2tFU8+Cqi3K5YNU
         vJTZocAkS0bNbzk64NYe4xvQfNSw2/wWPyFI2pKXfxWWuEG6emjCgYwgA+tBxJtS25C5
         1Hd18gX/cIJSvhl/++cDqyRWEwTwzVWCxrnq9v8umUaK6Am/HLmeRWmZ0eeTvFpzX0Nv
         UQYZtaAm9u1WQrZsaejLv8efXCd/wRZxUeJvGC7r0h76nad9fwRjzJbOsEfisJj3JBDD
         KkcDyXpkjKp7MCidZew7KKOy1tQI/UxQxcNlHO4aMmkE4moE/Fn1Ujb3LUyGxsTMsNin
         ikEA==
X-Forwarded-Encrypted: i=1; AJvYcCWRdN4OC9OJrbNwiuTEh0fHncP8ebyAxf6indhcPxu/JR2LP6tMjj6pKlOjHs6nwcJDBkxC27k65DbNvyTFOfq/ly94Yv1a
X-Gm-Message-State: AOJu0YxMd2ojuj0y9aS0B7j7YFAJM0sITquqy68IQOmF5iuLxqsYSJ1R
	Yxw4O4ZYJMFPW/mYCXyFSagkITHc1HR/mkAbakUwXPDdB37VuOou
X-Google-Smtp-Source: AGHT+IFe5PZBuMhFo9qgsnjbZWUpKAIuKDWIOXlpCW214Z62FPN+hpZZUtGFamo1JesAs3jjMXpjaw==
X-Received: by 2002:a81:c244:0:b0:64b:4a9f:540d with SMTP id 00721157ae682-67a0959294bmr128318997b3.31.1722357844146;
        Tue, 30 Jul 2024 09:44:04 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567869dfbsm26171317b3.35.2024.07.30.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:44:03 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 30 Jul 2024 09:43:49 -0700
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
Message-ID: <ZqkYRYsWm2kgtYUt@debian>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-9-alejandro.lucero-palau@amd.com>

On Mon, Jul 15, 2024 at 06:28:28PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> The first stop for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
> 
> If the root driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci_driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
> accelerator driver probing should be defferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> The first consumer of this API is a test driver that excercises the CXL
> Type-2 flow.
> 
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c          | 41 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c            |  2 +-
>  drivers/cxl/mem.c                  |  7 +++--
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>  include/linux/cxl_accel_mem.h      |  3 +++
>  5 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b902948b121f..d51c8bfb32e3 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver
> +*/
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d66c6349ed2d..3c6b896c5f65 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f76af75a87b7..383a6f4829d3 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 0abe66490ef5..2cf4837ddfc1 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -65,8 +65,16 @@ void efx_cxl_init(struct efx_nic *efx)
>  	}
>  
>  	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> -	if (IS_ERR(cxl->cxlmd))
> +	if (IS_ERR(cxl->cxlmd)) {
>  		pci_info(pci_dev, "CXL accel memdev creation failed");
pci_err()?
> +		return;
> +	}
> +
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint))
> +		pci_info(pci_dev, "CXL accel acquire endpoint failed");
pci_err()?
> +
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index 442ed9862292..701910021df8 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -29,4 +29,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif
> -- 
> 2.17.1
> 

