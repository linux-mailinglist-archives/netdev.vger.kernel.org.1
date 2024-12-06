Return-Path: <netdev+bounces-149780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF439E7684
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D0284430
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178521F3D2D;
	Fri,  6 Dec 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl1Tu3IF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24D20626A;
	Fri,  6 Dec 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504224; cv=none; b=cFhREm63k3qAFWhkchftM2H2pVtqL4qAfTsTMIxRGHD0nroJ7aiyZPnfUoSnzxjmsKMYkPSl3VyBfRw+dXWyrRVgVPMLheF3kZK45LoOzxV0kLPAWkkJIvmdBaj1xygI5uAb1OzjR5E9Dr0TGU5/5vEOkxNmZgy7exezWChyfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504224; c=relaxed/simple;
	bh=fYfDs6Ir4Q/zYqiT3OeBInTSJD3bFy+vG8QqctHODkg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrIjU0hMZcKKW3HhqyCTA5Dfl8+NoB2hwxZIQYp/Ldel9sF1QiqHgLu6JsbS8CvaBeMKQI2awwwoIdst6ZIMAzHvxghp4YzTBCDgRUhZv1FsdODI51IfXx7qSkHfJnu89HHj3txAAhn07vu1IPaOnsso/wFu6I2JYc5tTzkh6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl1Tu3IF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215a7e487bfso20398135ad.2;
        Fri, 06 Dec 2024 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733504222; x=1734109022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgyEGKZZotV30KQ+1xi/b8vy9kNqZrcn4m6Kl44Br/A=;
        b=Wl1Tu3IFFIczLk4ZUPdFLmp9itUBnW73CjfETuMQmFbGyByU+Efl1JZLubDaqmD9Ur
         IFd8LQ/qOt2u8U3PIBjwKSylIKGPXwxPHtL7/yAz1yViM+1JQCJB2Hj0sxqB1xd9zCgN
         hmyPqYWfJ9eSLPMuX7Z9G/lzl1SjjhhmDA1JIYjq2L3pbc6/VB0SRDaveSQBVK5BZa+V
         AcTCVp++JQe3PirOWwMhAmlsPfS+sS9rg0SD534eEhjCETMOfTvYSCQ+p5svYneTrbbN
         vaDdMGndqBWiVRBi3GlDSXBO3ObZJHixw2q2fALadHxVrXaKYVy9GHHea7AuVeG43Vwk
         A0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504222; x=1734109022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgyEGKZZotV30KQ+1xi/b8vy9kNqZrcn4m6Kl44Br/A=;
        b=IRIeqqBNa25km6FFiqL+5WXTF7KINtJ7HYlNnZcJKULNBnCjiRAm4GkVxr+9RKU+Ta
         Q+E7mulAvvBjeTOhairqmkGPwHd9vo/BvLR3QHXXqR1T+CJGfOVsIwcC89CXBMsokJ3s
         SRzTix54BCWOfLclJQkNwLTp0oG5ap+Wx1vLcHsKMrTFAhlp2ylP/6D1qfos32xv7XFV
         WQaBocarHvpSKJcrvY3huDzyeYraUlZ85wzJtAHDctj3ZzVEN61X0hClvp/rm/Yth/M8
         QDwK7oF0kr365AzpLz9qj/6ojAqTLq+J5jcKx0AioQtdZ21ULZWcZ/af4Qgga/oosnzc
         dm1A==
X-Forwarded-Encrypted: i=1; AJvYcCWc1oCkZRDIytyRc5RNB7pkoj/XlqmJ0a3iaxH4MMImj/Pp2b5p82Y8vqsV44sSI1Sh8bVTOMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYmy2UxyoIUreY72VWYbZgfMIOINOw8EIeveEzoIwx66d7my3
	/xQTKsCIG+1CBIR9tBd3/iZMMMxsNzdOl+61+vcRimov8jqkFfxa
X-Gm-Gg: ASbGncuV24SUs3oyvgNPR8t3umNXlOChyV55Qg1O5ya0Sqfb+0I2cRwR3FK6yFmNZHI
	k8oRttQxM1evjn9AsG4OFsfJMQ48n1y9l0PG+iAXiXmdSLaOkS6e8pJcrgA5weWgtIYdGWbaPTf
	hZ9zdkpghzEhS5E2djFzvBLDTjCRIPHISoJwXLWJd3pPCqI9hxyE118Jh5o2JvUp7SRtaPsa1fV
	S6lmyjBgJEhyNipYhRLaXEe9vSlgEALSgoDvb/g
X-Google-Smtp-Source: AGHT+IGTDNLKuEIfGYOiaJhCLt5gDIfGmTGEqfTO9YLdpL72zBy5mbgvEClN7mF8d/Zc/ZKEq1Ab0A==
X-Received: by 2002:a17:902:f60b:b0:215:8270:77e2 with SMTP id d9443c01a7336-2161394468dmr58738625ad.0.1733504221523;
        Fri, 06 Dec 2024 08:57:01 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:3118:55bb:e021:3a22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e452sm31064765ad.43.2024.12.06.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:57:01 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Dec 2024 08:56:57 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 13/28] cxl: prepare memdev creation for type2
Message-ID: <Z1Ms2YRAMFxmd11Y@fan>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-14-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-14-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:07PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of clx_memdev_state.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c   |  3 +++
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/core/region.c |  3 ++-
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  5 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 2a1f164db98e..f1c5b77cb6a0 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b14193eae5fb..4bc946388384 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_accel_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
> +
Unwanted blank line.

Fan
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>  
> @@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 70d0a017e99c..2a34393e216d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		int i;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..cb771bf196cd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 473128fdfb22..26d7735b5f31 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -45,4 +45,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif
> -- 
> 2.17.1
> 

-- 
Fan Ni

