Return-Path: <netdev+bounces-112861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4593B891
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFFF1F2200C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7283B139CF6;
	Wed, 24 Jul 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1P64xPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0C2AE6C;
	Wed, 24 Jul 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856746; cv=none; b=jnXmJKqOYDojScDZr1GxINLrROLRJ87iSHhz9tidY3juDbH/gFpwC8hFxU3WEUhnCVaFseXj5acTYscRPOd7P36XtiYysRdpFvZad8O1ZepHStbnk6OnGq07b4AenP6wjfwezpIafVKg1vFiDSZIidHKqhrQdFuvC2Bj9lwF3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856746; c=relaxed/simple;
	bh=+ceRbvkOAsiXk+0vxG/RnajAafcgaRWEjhFXGM+A8OQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UreRbXsIMCCjkEhbiYklmxVuJYVbQ13wxDzqTpCI0pC+0o7OChgrUfpeot9VmG0cJhgwQsIb1SNkhHbZVKahy0lXOoEjh3jxEqS9Iv/dBVKJAequRfe0e7m+yOsJoTTq6G7rBASos8XbGi3QRCJD9MCXrGOa1QgIicgMaxbFiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1P64xPd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64f4fd64773so3182397b3.0;
        Wed, 24 Jul 2024 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721856743; x=1722461543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkBRhoPvjuzb7AB9u4D8EiiPMWnQNiwyXDpxcHy1w2U=;
        b=G1P64xPdl/N85hUSvOvRggW4/tq7uCTzUjy/XF6z2PvriKFtyNLt1A6LCbu21vivWc
         RjHqKehbRjFLzvB2QykPbyefF4xyx+8TdOZvP2PH2l1iMBsYxW1G+gRfTfiyDInsTY2K
         soI+gnhSLeoa06g+LN8jNNRDReg8IDlrp2zMTkos6DA+zlNav/zfz2UySE5ork0HlDIv
         Wm306zupqKj0Fg3oJWLmKQpEg9U0TrC67OOlkJWZn3TbNR+Ob0ojlAkKZfwy2X5h6/O5
         MLtGSb6EyJANv94BMV5zPSkpSMWluiD9BeowigFGRwFLxYBB0wGi1uK3EXM8dnXUeAoM
         Xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721856743; x=1722461543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkBRhoPvjuzb7AB9u4D8EiiPMWnQNiwyXDpxcHy1w2U=;
        b=tTH9sq7PUHAXIHWo934tU/V3GIhJd04w6qzE7A73+qbLLstLYzf6SQ/ddlThbFWEwb
         Sutblv8+Sdbyo7nme6VC4Yry73HgnEikXT9nJKFbsEQ4v6E3EK+fsAA5JVxHDsrgZE5W
         ZDfXXEafL5QFZyIjc1BX/+5Z4nS8bLMcmP/gHOWETAeyx/B+fK6IHfjPrnRN6gNgL7tw
         FSf/nNtJ5aIXZn13oMniE7d+yHTNvBdpKoXLsAuBLVs/6tm9Ay0V8kOnCPJUxZQ0CSiq
         uG+p5T9ALEDOme+6zlV/2aH/VmMRjPvySHFMdcX5jPy0j3/sx8ezMBAiNcgN10bNgJeI
         fRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhG/THSQZA4FOKX3yvRGYGGfOXEBcXcp1SlxCjh20cR349DoyRiGM84vpy1ZsLwzH01pmHJBM6NfXSNPu6lf8/WSinnZP8
X-Gm-Message-State: AOJu0YyQGidVgvT5hLHNI8lKmSDrZxV9d2wDQn0V/Qhl6iaYZnkLy/2I
	iOJ1eVAS9mFYJwX21mfKDLG/7vgScEin8/5tMmix2C/bj8A23caE
X-Google-Smtp-Source: AGHT+IHsG9cid3UIa2iQSmsvwOYgxNuZ9ZpoicAuwYcMFu9F6qhyGAPDsb3jX8kEpNCxMXz4f3KA4A==
X-Received: by 2002:a81:8541:0:b0:61a:d30f:a9c4 with SMTP id 00721157ae682-67510736cf5mr9345347b3.8.1721856743552;
        Wed, 24 Jul 2024 14:32:23 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd9000sm389127b3.27.2024.07.24.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:32:23 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jul 2024 14:32:21 -0700
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 07/15] cxl: support type2 memdev creation
Message-ID: <ZqFy5Qsg_uLncLRr@debian>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-8-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-8-alejandro.lucero-palau@amd.com>

On Mon, Jul 15, 2024 at 06:28:27PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add memdev creation from sfc driver.
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected. This patch checks for the
> right device type in those functions using cxl_memdev_state.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c            |  3 +++
>  drivers/cxl/core/memdev.c          |  9 +++++++++
>  drivers/cxl/mem.c                  | 17 +++++++++++------
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++--
>  include/linux/cxl_accel_mem.h      |  3 +++
>  5 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bb83867d9fec..0d4679c137d4 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  	};
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return;
> +
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 58a51e7fd37f..b902948b121f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -468,6 +468,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_ram_qos_class.attr)
>  		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
>  			return 0;
> @@ -487,6 +490,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_pmem_qos_class.attr)
>  		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
>  			return 0;
> @@ -507,6 +513,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_security_sanitize.attr &&
>  	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
>  		return 0;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f1b49bfe162..f76af75a87b7 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
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
> @@ -222,6 +224,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index a84fe7992c53..0abe66490ef5 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -57,10 +57,16 @@ void efx_cxl_init(struct efx_nic *efx)
>  	if (cxl_accel_request_resource(cxl->cxlds, true))
>  		pci_info(pci_dev, "CXL accel resource request failed");
>  
> -	if (!cxl_await_media_ready(cxl->cxlds))
> +	if (!cxl_await_media_ready(cxl->cxlds)) {
>  		cxl_accel_set_media_ready(cxl->cxlds);
> -	else
> +	} else {
>  		pci_info(pci_dev, "CXL accel media not active");
pci_warning() ??
> +		return;
> +	}
> +
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> +	if (IS_ERR(cxl->cxlmd))
> +		pci_info(pci_dev, "CXL accel memdev creation failed");
pci_err()

Fan
>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index b883c438a132..442ed9862292 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -26,4 +26,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
>  void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> +
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif
> -- 
> 2.17.1
> 

