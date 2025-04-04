Return-Path: <netdev+bounces-179343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B49A7C0ED
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220DA17AC13
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6327E110;
	Fri,  4 Apr 2025 15:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CF4414;
	Fri,  4 Apr 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781673; cv=none; b=io580B5hYHpUCY+AAGNyYxRS+u4LKnDDscFbkWh/DX57+dkJIYm1CIy+BjRbL1d2rrCQ7p96T8Cw4KoW+aknOsryvwadDBXvamsSqifoHZCiT6WAoQAjri6TZZmFWoBU7xDxaSrevUxoogJbj/a6DzTsAnSGQ/4ZNdS2zfJ5EPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781673; c=relaxed/simple;
	bh=RTxWiTlEusDHhssNywRrO+/P3doXCY5eg0kOiXUWjeQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9BU0hOwCGUnR6iI04GHREL46hHYjEjSgmwd0diaLxo6NECLvi1M7ZGQALMEhHq7v2FCI/fp3Et+QrvyNJWIPFqMIEsgOulM07ZW2OuZIKsCZGLM5XjtJGtmC/rVtyadCPKNRgl9/qFrnGzb4bbYMaAyRc6F0AIs/K+Ygmkuqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTjf02wyhz6L4yN;
	Fri,  4 Apr 2025 23:47:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 259E2140595;
	Fri,  4 Apr 2025 23:47:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 17:47:46 +0200
Date: Fri, 4 Apr 2025 16:47:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v12 04/23] cxl: move register/capability check to driver
Message-ID: <20250404164744.00004b34@huawei.com>
In-Reply-To: <20250331144555.1947819-5-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-5-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:36 +0100
<alejandro.lucero-palau@amd.com> wrote:

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
A few minor things inline.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0fd6646c1a2e..7adf2cff43b6 100644

> @@ -37,7 +39,8 @@
>   * Probe for component register information and return it in map object.
>   */
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map)
> +			      struct cxl_component_reg_map *map,
> +			      unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u32 cap_array;
> @@ -85,6 +88,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			decoder_cnt = cxl_hdm_decoder_count(hdr);
>  			length = 0x20 * decoder_cnt + 0x10;
>  			rmap = &map->hdm_decoder;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_HDM, caps);

Maybe it's worth a local helper?
			cxl_set_cap_bit() that checks for NULL cap

#define cxl_set_cap_bit(bit, caps) if (caps) { set_bit((bit), (caps)); }

Or just always provide caps.  Do we have use cases where we really don't
care about what is found?  

>  			break;
>  		}
>  		case CXL_CM_CAP_CAP_ID_RAS:
> @@ -92,6 +97,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  				offset);
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_RAS, caps);
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,

>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e8c0efb3a12f..2a52556bd568 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)

>  	else if (!cxlds->reg_map.component_map.ras.valid)
> @@ -895,6 +909,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {

> +		dev_err(&pdev->dev,
> +			"Found capabilities (%pb) not containing mandatory expected: (%pb)\n",

The only obvious reason I can see for an expected bitmap is this print and this isn't
that helpful as requires anyone seeing it to dig into what the bitmap means.  Maybe

	if (!test_bit(CXL_DEV_CAP_HDM, found))
		return dev_err_probe(&pdev->dev, -ENXIO "HDM decoder capability not found\n");
	etc.

That will only print the first once not found though and avoiding that adds complexity we
probably don't want here. 

> +			found, expected);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1383fd724cf6..b9cd98950a38 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -25,6 +25,26 @@ enum cxl_devtype {
>  
>  struct device;
>  
> +
> +/* Capabilities as defined for:
CXL code so 
/*
 * Capabilities...

> + *
> + *	Component Registers (Table 8-22 CXL 3.2 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.2 specification)
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

No comma as this is at terminating entry. Seems unlikely to make
sense to ever have anything after it so let us make that harder /
more obvious in future patches, but not having the comma.

> +};
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.


