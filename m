Return-Path: <netdev+bounces-146024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B09D1BD6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148E0B21815
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56A19753F;
	Mon, 18 Nov 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2zKY5TQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F732E3EB;
	Mon, 18 Nov 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731972764; cv=none; b=M7avhWEpNKb8gbsrB4N2+EqYgnjDDxaVsnLiZgNuzCj2AC5DGzGdFbU4glAiDNiX/TFqW6f/I9tqpOJJP2Z8TsVOlWIs8Thm2r6f4+EtDEocRN2unFeHyEFa/aF9jz2n+dQ09Gf9uSfZGqKpCb5ybM80HMLaqWkRkk2ZSOHKA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731972764; c=relaxed/simple;
	bh=3UdBLNl/rl20B2CgtKrISn3XLFGd5Aqq+qeFzU6+7tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clgNLfBRbjpZJCifg/5ZU5GD6AN2aZL+hY6iUstbAgZ9VHhQUazbakPijz9yG8fQRroa4za9mWLGhRu4XVZGolMPj//QPSj8T+gqvHsYXiWfWQLgHAk/uDcASXsXiY/kiWbnn/2mQHJZJtJATSQ8g+naU7eSAbWb0XjexoNpZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2zKY5TQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731972763; x=1763508763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3UdBLNl/rl20B2CgtKrISn3XLFGd5Aqq+qeFzU6+7tE=;
  b=I2zKY5TQh2hdk4zo0IN2Hz1yMb4o08nzq2f1tCHA/o1ZG8VLAJA17kvc
   G2/wNt9olvX6tWMTt4HEIqrWHMkMSUTRxp/haGbdmUxyK/1LOk3/ckmWs
   G6ruMqwq+Yh6Kp0h9yGTsFrBvEoDZYyuaaS5vAm/s9ujgB3uIcedv/0/t
   tVVDbfBf0aTr5/K4Z+U+ciwD+pyHjLahbeUAI8aD9JNeN4aDSXMbjWlSe
   1PSQ8VtXbdc1hCHdb2sETXhuu1xnqJOiy1AfY5949inPJsgj5dmKqfO35
   vzLAdAby7Tpf78JQNwB7UdFIlFRfm9rXVtGAhspPcQmamzsy0LP4sNCNQ
   Q==;
X-CSE-ConnectionGUID: NUV28q2TT1u/zSqAr08cYA==
X-CSE-MsgGUID: 0F7U07uIRg+VE37CJDxiyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43351499"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="43351499"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 15:32:41 -0800
X-CSE-ConnectionGUID: pSm2zkgnTme4QUg/1tD37w==
X-CSE-MsgGUID: 8cd1c+RwTe6T/Ze6FGs1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="90174107"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.108.254]) ([10.125.108.254])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 15:32:41 -0800
Message-ID: <104f5fd2-2519-4497-9ebc-2ad17b415c2b@intel.com>
Date: Mon, 18 Nov 2024 16:32:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/27] cxl: add function for type2 cxl regs setup
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  2 ++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bfc5e96e3cb9..8b9aa2c578e1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
> +	/*
> +	 * This call returning a non-zero value is not considered an error since
> +	 * these regs are not mandatory for Type2. If they do exist then mapping
> +	 * them should not fail.
> +	 */
> +	if (rc)
> +		return 0;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}
> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, cxlds->capabilities);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> +		return rc;
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map,
> +				    &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index ab243ab8024f..a88d3475e551 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,6 +5,7 @@
>  #define __CXL_H
>  
>  #include <linux/ioport.h>
> +#include <linux/pci.h>
>  
>  enum cxl_resource {
>  	CXL_RES_DPA,
> @@ -52,4 +53,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps,
>  			bool is_subset);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif


