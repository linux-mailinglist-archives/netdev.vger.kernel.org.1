Return-Path: <netdev+bounces-166516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33EA36478
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035D91718F7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69127269837;
	Fri, 14 Feb 2025 17:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2072268690;
	Fri, 14 Feb 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553718; cv=none; b=VP3y8fqaT2Q1j0oK0pbfal976UnTOO66W3jW3O/c7t2n9foN3Uv9UWSGBijRfVwYvW8ufyY2Wdt/pi4Ba6p69y5E6ActVhQL9bMiKjRbbooaGfP2I3+iXle2zfB+wPeF8jpcBwKwzIj2eF9f3tlA4czU9ck0NoTi8lVfGXvGwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553718; c=relaxed/simple;
	bh=lRbQbfyjiqWxqdNeCAxC/YxkDrLjeUGSt5L+LuO2OKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXyVNRBSgJxre6Dq0D43JOw0knk1CKXxzhUf5LOlGyC3kaWpFAkv/Lh9YA2/kSQfeND5zubmDoF/JD7Phm4QBZw41nSLQZI8DflCLtdFvtLBz09hqXYqfEcbpfU3nI5WWJzo8EkZZk31I/YAPn/3Tb+/DrrGxs1NZCf2MVWVfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvf175gKgz6M4gH;
	Sat, 15 Feb 2025 01:19:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C206140A77;
	Sat, 15 Feb 2025 01:21:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 18:21:51 +0100
Date: Fri, 14 Feb 2025 17:21:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v10 04/26] cxl: move register/capability check to driver
Message-ID: <20250214172150.0000136c@huawei.com>
In-Reply-To: <20250205151950.25268-5-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
	<20250205151950.25268-5-alucerop@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Feb 2025 15:19:28 +0000
alucerop@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

A few additional trivial comments.
With that and missing docs tidied up seems fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 722782b868ac..790d0520eaf4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,6 +5,26 @@
>  #define __CXL_H
>  
>  #include <linux/types.h>
> +
> +/* Capabilities as defined for:
Nit. It's not networking code, so lets use the standard
the rest of the kernel (more or less :) follows.
/*
 * Capabilities as defined for:

> + *
> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> + *
> + * and currently being used for kernel CXL support.
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_HDM,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS,
> +};
> +
>  /*
>   * enum cxl_devtype - delineate type-2 from a generic type-3 device
>   * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> @@ -22,5 +42,4 @@ enum cxl_devtype {
>  struct device;
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  					   u16 dvsec, enum cxl_devtype type);
> -
Stray change.  Drop it or push to earlier patch so the line never existed.

>  #endif


