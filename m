Return-Path: <netdev+bounces-139613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1709B38F1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80521C21558
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC07E186616;
	Mon, 28 Oct 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vew79i6x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2154155A52;
	Mon, 28 Oct 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139572; cv=none; b=jHHijwVb+8FKqZ2yC4sPE7b3JHnO/jqHLT8UdX0yIwmr175907vW/c7XsKBVZrmRZPUF+B08SXiK9gWlqg6IMHn4XkKC3TaSTaIu4Ub2GhFTiW/Y5Amd4zornXkBSOMd9UQBfgrC7c76y19VCT0mht6buxkPT53RZcY17rVrrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139572; c=relaxed/simple;
	bh=vYsWeSLce9N41fFy59+LAhg3m1VcSEsSGmnqvtpwcFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TK4c3cBY2rngRxM4qKRf/ClE8b6eNhL/fJ6pEbJEoFDOvHRT878+zMVpnR4F/i3wk0ZAcmmxOZaMecG5kZpAHEDSu0dPMemhotN1L/JGYr+Ir4mjP2nFUoVIpe04PydBiyqztNkS6PJIBE21BYYVuXF9XADQVBBKai23IfsLL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vew79i6x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730139569; x=1761675569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vYsWeSLce9N41fFy59+LAhg3m1VcSEsSGmnqvtpwcFA=;
  b=Vew79i6xpRiLOo25X2Stm2uq70a2H4IVD9a0zwNBjZBOpN6qj54ItgWY
   7aQKUODGZ66HSWR9sRVzIM2fQOpnIYJotLQfbI2L7m+OcfBN235iIBQPW
   D9BHNttuPhohXJOFqhCQz4bnzyOzwqOh64IL0h4qsAY8W3ERgSrrIirmk
   d4oHTcBmew+wP716QKWTB0Qwg5ZeGdPlRZTCRhMW3h4beEBN0RiCiAjuC
   WaLzggNPTBRmgNeEwGEnQgK0Eg+EvD43FKSltwqzIaHlng+cxkydmoJrF
   mXkW+bFTtyixLkKTIvGWUiICtwxqzE167QW4LCpPirtNSAri7TIQt6YAD
   w==;
X-CSE-ConnectionGUID: mn4eXFBsTYKeg5xBIYNpDQ==
X-CSE-MsgGUID: znig77IrTgG4zbdmtI29cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33670004"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="33670004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:19:28 -0700
X-CSE-ConnectionGUID: qLlEMQxXSUOAkmhnQz815A==
X-CSE-MsgGUID: i5UCrm2nS8i7M0eklCv9VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="119163959"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.2]) ([10.125.108.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:19:27 -0700
Message-ID: <deccd9ee-5868-4a2a-a756-13f4dd2a27ba@intel.com>
Date: Mon, 28 Oct 2024 11:19:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/26] cxl: add capabilities field to cxl_dev_state and
 cxl_port
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017165225.21206-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field to cxl_dev_state for keeping device capabilities as
> discovered during initialization. Add same field to cxl_port as registers
> discovery is also used during port initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/port.c | 11 +++++++----
>  drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>  drivers/cxl/cxl.h       |  9 ++++++---
>  drivers/cxl/cxlmem.h    |  2 ++
>  drivers/cxl/pci.c       | 10 ++++++----
>  include/linux/cxl/cxl.h | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 66 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..7b859b79d59d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  }
>  
>  static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
> -			       resource_size_t component_reg_phys)
> +			       resource_size_t component_reg_phys, unsigned long *caps)
>  {
>  	*map = (struct cxl_register_map) {
>  		.host = host,
> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>  	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_port_setup_regs(struct cxl_port *port,
> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  	if (dev_is_platform(port->uport_dev))
>  		return 0;
>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
> -				   component_reg_phys);
> +				   component_reg_phys, port->capabilities);
>  }
>  
>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> @@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	 * NULL.
>  	 */
>  	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
> -				 component_reg_phys);
> +				 component_reg_phys,
> +				 dport->port->capabilities);
>  	dport->reg_map.host = host;
>  	return rc;
>  }
> @@ -858,6 +859,8 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  		port->reg_map = cxlds->reg_map;
>  		port->reg_map.host = &port->dev;
>  		cxlmd->endpoint = port;
> +		bitmap_copy(port->capabilities, cxlds->capabilities,
> +			    CXL_MAX_CAPS);
>  	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
>  		if (rc)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..9d63a2adfd42 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/cxl/cxl.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> @@ -36,7 +37,8 @@
>   * Probe for component register information and return it in map object.
>   */
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map)
> +			      struct cxl_component_reg_map *map,
> +			      unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u32 cap_array;
> @@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			decoder_cnt = cxl_hdm_decoder_count(hdr);
>  			length = 0x20 * decoder_cnt + 0x10;
>  			rmap = &map->hdm_decoder;
> +			*caps |= BIT(CXL_DEV_CAP_HDM);
>  			break;
>  		}
>  		case CXL_CM_CAP_CAP_ID_RAS:
> @@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  				offset);
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
> +			*caps |= BIT(CXL_DEV_CAP_RAS);
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
> @@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
> @@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>  			rmap = &map->status;
> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>  			rmap = &map->mbox;
> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> @@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>  			rmap = &map->memdev;
> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(host, base, comp_map);
> +		cxl_probe_component_regs(host, base, comp_map, caps);
>  		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(host, base, dev_map);
> +		cxl_probe_device_regs(host, base, dev_map, caps);
>  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>  		    !dev_map->memdev.valid) {
>  			dev_err(host, "registers not found: %s%s%s\n",
> @@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -int cxl_setup_regs(struct cxl_register_map *map)
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(map);
> +	rc = cxl_probe_regs(map, caps);
>  	cxl_unmap_regblock(map);
>  
>  	return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9afb407d438f..a7c242a19b62 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/notifier.h>
>  #include <linux/bitops.h>
> +#include <linux/cxl/cxl.h>
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> @@ -284,9 +285,9 @@ struct cxl_register_map {
>  };
>  
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map);
> +			      struct cxl_component_reg_map *map, unsigned long *caps);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map);
> +			   struct cxl_device_reg_map *map, unsigned long *caps);
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> @@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> @@ -600,6 +601,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -623,6 +625,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..68d28eab3696 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -424,6 +424,7 @@ struct cxl_dpa_perf {
>   * @ram_res: Active Volatile memory capacity configuration
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -438,6 +439,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 246930932ea6..6cd7ab117f80 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -503,7 +503,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> +			      struct cxl_register_map *map,
> +			      unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -520,7 +521,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc)
>  		return rc;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> @@ -827,7 +828,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxl_set_dvsec(cxlds, dvsec);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -840,7 +842,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return an error.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, cxlds->capabilities);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index c06ca750168f..4a4f75a86018 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -12,6 +12,37 @@ enum cxl_resource {
>  	CXL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
> + *
> + *	Component Registers (Table 8-22 CXL 3.0 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.0 specification)
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_SEC,
> +	CXL_DEV_CAP_LINK,
> +	CXL_DEV_CAP_HDM,
> +	CXL_DEV_CAP_SEC_EXT,
> +	CXL_DEV_CAP_IDE,
> +	CXL_DEV_CAP_SNOOP_FILTER,
> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
> +	CXL_DEV_CAP_CACHEMEM_EXT,
> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
> +	CXL_DEV_CAP_BI_DECODER,
> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
> +	CXL_DEV_CAP_CACHEID_DECODER,
> +	CXL_DEV_CAP_HDM_EXT,
> +	CXL_DEV_CAP_METADATA_EXT,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MAILBOX_SECONDARY,

I think there was a previous comment about dropping this cap since OS would never access this cap?

DJ

> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS,
> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);


