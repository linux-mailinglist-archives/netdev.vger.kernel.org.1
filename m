Return-Path: <netdev+bounces-146735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE199D5589
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D8FB20EE9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C271917FE;
	Thu, 21 Nov 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWoTacQn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9D5695;
	Thu, 21 Nov 2024 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228460; cv=none; b=GWzfqDcTOKdrJhVcKOQCXjjdN8ZaLwAEcd17CdAKagWUemzSpQyEuKuCLy5ZsMNBkXGC1pHLn120B4dGgBclHRbB4lak/MLSRBrBpKjwWdO6MsaXi9txojXTf3ofof/Tgu5bbVbZy3P8hO8vFsX8mf5EKe6GLJ/Pg0ksECbw+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228460; c=relaxed/simple;
	bh=ifFfp6lVTdk1P/6odOLvYXPfAiEG8yQD5a7mN0hTi78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY19a47Z6RtK2Gp/Bgm+tWsz9PrGrgaV8dsAAQL1TsOcW0BvhF3GpOEp4RuWbckrElk5aPSgEJTKxXhX+WD1prVEb4GaXE3ekgQnvItRfGPqZX+qxyhoMo8UP2DO8QNXKXreLyJ6geAY4c25U1ZrS4ow5WP5ER/uXXBIjJ6J4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWoTacQn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732228457; x=1763764457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifFfp6lVTdk1P/6odOLvYXPfAiEG8yQD5a7mN0hTi78=;
  b=UWoTacQnegcFI1fFIzJb8t6vj/8e1I1NUWJMQFEjv06DwvbSXgCZDLMg
   4FDjXIJtZvglhvUd32idU5rOzcZ/xAiLvqyGvSo5mRhGTPLMlUvhzv9CK
   UaUuaxCQnB2W9eTpB2U2lWZZUobNqWKNuHoQob+ggPMDhYXDy3/tSNE7g
   d8nMIaH87gAR0ZdeHK2V/G9N6Yyf4WmGSnkYKglOl4Qd/ts13p23CU6rX
   QN3FxQ6hRxOreQxgc9hxOAl+Eb3LQ64ymXCjLcUtpSC+sG+/oamjzx8AS
   q15Xn3Le1AP6a1LJftY2lcYODa//yFFVTaXS3RByiWgOa7u/mNtDG2Ylx
   g==;
X-CSE-ConnectionGUID: wO6gaVivSu2mV0Cfo0qOEw==
X-CSE-MsgGUID: aJdijWAPR7GtW3C9UYC2MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32115730"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32115730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 14:34:17 -0800
X-CSE-ConnectionGUID: AZdJFJb7S9uNLyilgEqH3g==
X-CSE-MsgGUID: vtVZpa56QHKqing6z4mtZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="127906494"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 14:34:17 -0800
Date: Thu, 21 Nov 2024 14:34:15 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v5 06/27] cxl: add function for type2 cxl regs setup
Message-ID: <Zz-1Z6fzAbl_RCAZ@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-7-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164434.7551-7-alejandro.lucero-palau@amd.com>

On Mon, Nov 18, 2024 at 04:44:13PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  2 ++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c

snip

> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	int rc;

maybe init to 0

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

init rc to 0 or return 0 directly here

> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map,
> +				    &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;

init rc to 0 or return 0 directly here


> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);

snip
> 
> 

