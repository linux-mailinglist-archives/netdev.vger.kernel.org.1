Return-Path: <netdev+bounces-128564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3197A5B9
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D971F2A0D9
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82474155C98;
	Mon, 16 Sep 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFgWrH5t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC704158A1F;
	Mon, 16 Sep 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502855; cv=none; b=gYzcc9LN4JGFVEDGOUitr2raJQDZgu4T7Ke5MT7bFP8lmYoMgNfEs8hGaZVkB2jCuyCZB/EGIYMxrxBv2OKKvaAvEAdSpbb47CQ+ipWcC+uVgY/ATOm9LQeZzp+F5TsPVSGBxKWhmOZC6buTDSk6t4Pt+GuayR0AzEIek72o/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502855; c=relaxed/simple;
	bh=sXBROdPt7wd8cf2XiGmqn0y1xyxr4LAs7WBxmejgAaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pviPfpmFfoOw6Lk4bn1JrXzAqs45Dl0ilQ1qiuJZmN0Qy0uhDRNsqi99LwW03XzbPJQgpfcVPsp/mVxs1sgEkXbv8hCblVp63GdwcBpl4cW9GILx/aG8e83glos3LaDzniH+ATji1vT26ySSrYa/IzgpuVfmI/jjMt3gG5knVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFgWrH5t; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726502853; x=1758038853;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=sXBROdPt7wd8cf2XiGmqn0y1xyxr4LAs7WBxmejgAaA=;
  b=FFgWrH5t0xd6viFNjOc2Uc0vWGH4CdGZz0azbUIM3bH2sPj/LgYGkP8s
   /tm5nmJHsEhmYvyrK7TTeyVDZgKN7sRUOKAi5KELsirH/6fGrZTwSVnpI
   ToB0Tbwk5IhXjFdKWhe4d8ZAMurG+2dLgLV9XyIRC7bXIoBWpDNVKUPN/
   gEk0+24ehZ3tWXN0809E+GxvQfNXE1filCgwx7JcLBjYzgnAfR6wCBCfD
   Mo9GzldDr9A1GuImMPM3f3MVPVRpov93rJ06DQataeNAQ2V4mAa0cKbDn
   zddnF3VZySzPFsbN/2nOo6vLK7XVU9DrhVL1AGMId5+UYgtdvcZOU6E3P
   w==;
X-CSE-ConnectionGUID: ocTnxulETrGz5om8q46dIQ==
X-CSE-MsgGUID: 6fT05KezRkimAYxYmLO+Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="47845329"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="47845329"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:07:32 -0700
X-CSE-ConnectionGUID: KPEer5jfQLeSP39G20iuyA==
X-CSE-MsgGUID: Hf0CezyDRYWV9dN+DoE3Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69388175"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.18]) ([10.125.109.18])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:07:32 -0700
Message-ID: <e5816508-0c85-40fd-907d-58d3283226ef@intel.com>
Date: Mon, 16 Sep 2024 09:07:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state and
 cxl_port
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-3-alejandro.lucero-palau@amd.com>
 <06cc4873-d841-4a41-b681-e73bd7a3d4d8@intel.com>
 <7de26804-9b09-165d-02f8-0539bb17608c@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7de26804-9b09-165d-02f8-0539bb17608c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/16/24 1:36 AM, Alejandro Lucero Palau wrote:
> 
> On 9/11/24 23:17, Dave Jiang wrote:
>>
>> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Type2 devices have some Type3 functionalities as optional like an mbox
>>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>>> implements.
>>>
>>> Add a new field for keeping device capabilities as discovered during
>>> initialization.
>>>
>>> Add same field to cxl_port which for an endpoint will use those
>>> capabilities discovered previously, and which will be initialized when
>>> calling cxl_port_setup_regs for no endpoints.
>> I don't quite understand what you are trying to say here.
> 
> 
> I guess you mean the last paragraph, don't you?
> 
> If so, the point is the cxl_setup_regs or the register discovery is also being used from the cxl port code, I think for CXL switches initialization.

Yes. Your response clarified my confusion. I do suggest you say that in your commit log.

> 
> 
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/port.c |  9 +++++----
>>>   drivers/cxl/core/regs.c | 20 +++++++++++++-------
>>>   drivers/cxl/cxl.h       |  8 +++++---
>>>   drivers/cxl/cxlmem.h    |  2 ++
>>>   drivers/cxl/pci.c       |  9 +++++----
>>>   include/linux/cxl/cxl.h | 30 ++++++++++++++++++++++++++++++
>>>   6 files changed, 60 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index 1d5007e3795a..39b20ddd0296 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>>   }
>>>     static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>>> -                   resource_size_t component_reg_phys)
>>> +                   resource_size_t component_reg_phys, u32 *caps)
>>>   {
>>>       *map = (struct cxl_register_map) {
>>>           .host = host,
>>> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>>       map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>>       map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>>   -    return cxl_setup_regs(map);
>>> +    return cxl_setup_regs(map, caps);
>>>   }
>>>     static int cxl_port_setup_regs(struct cxl_port *port,
>>> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>>       if (dev_is_platform(port->uport_dev))
>>>           return 0;
>>>       return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>>> -                   component_reg_phys);
>>> +                   component_reg_phys, &port->capabilities);
>>>   }
>>>     static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>> @@ -789,7 +789,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>>        * NULL.
>>>        */
>>>       rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
>>> -                 component_reg_phys);
>>> +                 component_reg_phys, &dport->port->capabilities);
>>>       dport->reg_map.host = host;
>>>       return rc;
>>>   }
>>> @@ -858,6 +858,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>>           port->reg_map = cxlds->reg_map;
>>>           port->reg_map.host = &port->dev;
>>>           cxlmd->endpoint = port;
>>> +        port->capabilities = cxlds->capabilities;
>>>       } else if (parent_dport) {
>>>           rc = dev_set_name(dev, "port%d", port->id);
>>>           if (rc)
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index e1082e749c69..8b8abcadcb93 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -1,6 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /* Copyright(c) 2020 Intel Corporation. */
>>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>> +#include <linux/cxl/cxl.h>
>>>   #include <linux/device.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/pci.h>
>>> @@ -36,7 +37,7 @@
>>>    * Probe for component register information and return it in map object.
>>>    */
>>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>> -                  struct cxl_component_reg_map *map)
>>> +                  struct cxl_component_reg_map *map, u32 *caps)
>>>   {
>>>       int cap, cap_count;
>>>       u32 cap_array;
>>> @@ -84,6 +85,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>               decoder_cnt = cxl_hdm_decoder_count(hdr);
>>>               length = 0x20 * decoder_cnt + 0x10;
>>>               rmap = &map->hdm_decoder;
>>> +            *caps |= BIT(CXL_DEV_CAP_HDM);
>>>               break;
>>>           }
>>>           case CXL_CM_CAP_CAP_ID_RAS:
>>> @@ -91,6 +93,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>                   offset);
>>>               length = CXL_RAS_CAPABILITY_LENGTH;
>>>               rmap = &map->ras;
>>> +            *caps |= BIT(CXL_DEV_CAP_RAS);
>>>               break;
>>>           default:
>>>               dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>>> @@ -117,7 +120,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>>>    * Probe for device register information and return it in map object.
>>>    */
>>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>> -               struct cxl_device_reg_map *map)
>>> +               struct cxl_device_reg_map *map, u32 *caps)
>>>   {
>>>       int cap, cap_count;
>>>       u64 cap_array;
>>> @@ -146,10 +149,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>           case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>>               dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>>               rmap = &map->status;
>>> +            *caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>>>               break;
>>>           case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>>               dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>>               rmap = &map->mbox;
>>> +            *caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>>>               break;
>>>           case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>>               dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>>> @@ -157,6 +162,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>           case CXLDEV_CAP_CAP_ID_MEMDEV:
>>>               dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>>               rmap = &map->memdev;
>>> +            *caps |= BIT(CXL_DEV_CAP_MEMDEV);
>>>               break;
>>>           default:
>>>               if (cap_id >= 0x8000)
>>> @@ -421,7 +427,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>>       map->base = NULL;
>>>   }
>>>   -static int cxl_probe_regs(struct cxl_register_map *map)
>>> +static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>>   {
>>>       struct cxl_component_reg_map *comp_map;
>>>       struct cxl_device_reg_map *dev_map;
>>> @@ -431,12 +437,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>>       switch (map->reg_type) {
>>>       case CXL_REGLOC_RBI_COMPONENT:
>>>           comp_map = &map->component_map;
>>> -        cxl_probe_component_regs(host, base, comp_map);
>>> +        cxl_probe_component_regs(host, base, comp_map, caps);
>>>           dev_dbg(host, "Set up component registers\n");
>>>           break;
>>>       case CXL_REGLOC_RBI_MEMDEV:
>>>           dev_map = &map->device_map;
>>> -        cxl_probe_device_regs(host, base, dev_map);
>>> +        cxl_probe_device_regs(host, base, dev_map, caps);
>>>           if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>>               !dev_map->memdev.valid) {
>>>               dev_err(host, "registers not found: %s%s%s\n",
>>> @@ -455,7 +461,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>>       return 0;
>>>   }
>>>   -int cxl_setup_regs(struct cxl_register_map *map)
>>> +int cxl_setup_regs(struct cxl_register_map *map, u32 *caps)
>>>   {
>>>       int rc;
>>>   @@ -463,7 +469,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>>       if (rc)
>>>           return rc;
>>>   -    rc = cxl_probe_regs(map);
>>> +    rc = cxl_probe_regs(map, caps);
>>>       cxl_unmap_regblock(map);
>>>         return rc;
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 9afb407d438f..07c153aa3d77 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -284,9 +284,9 @@ struct cxl_register_map {
>>>   };
>>>     void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>> -                  struct cxl_component_reg_map *map);
>>> +                  struct cxl_component_reg_map *map, u32 *caps);
>>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>> -               struct cxl_device_reg_map *map);
>>> +               struct cxl_device_reg_map *map, u32 *caps);
>>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>>                  struct cxl_component_regs *regs,
>>>                  unsigned long map_mask);
>>> @@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>                      struct cxl_register_map *map, int index);
>>>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>                 struct cxl_register_map *map);
>>> -int cxl_setup_regs(struct cxl_register_map *map);
>>> +int cxl_setup_regs(struct cxl_register_map *map, u32 *caps);
>>>   struct cxl_dport;
>>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>>                          struct cxl_dport *dport);
>>> @@ -600,6 +600,7 @@ struct cxl_dax_region {
>>>    * @cdat: Cached CDAT data
>>>    * @cdat_available: Should a CDAT attribute be available in sysfs
>>>    * @pci_latency: Upstream latency in picoseconds
>>> + * @capabilities: those capabilities as defined in device mapped registers
>>>    */
>>>   struct cxl_port {
>>>       struct device dev;
>>> @@ -623,6 +624,7 @@ struct cxl_port {
>>>       } cdat;
>>>       bool cdat_available;
>>>       long pci_latency;
>>> +    u32 capabilities;
>>>   };
>>>     /**
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index afb53d058d62..37c043100300 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -424,6 +424,7 @@ struct cxl_dpa_perf {
>>>    * @ram_res: Active Volatile memory capacity configuration
>>>    * @serial: PCIe Device Serial Number
>>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>>> + * @capabilities: those capabilities as defined in device mapped registers
>>>    */
>>>   struct cxl_dev_state {
>>>       struct device *dev;
>>> @@ -438,6 +439,7 @@ struct cxl_dev_state {
>>>       struct resource ram_res;
>>>       u64 serial;
>>>       enum cxl_devtype type;
>>> +    u32 capabilities;
>>>   };
>>>     /**
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 742a7b2a1be5..58f325019886 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -503,7 +503,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>>   }
>>>     static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>> -                  struct cxl_register_map *map)
>>> +                  struct cxl_register_map *map, u32 *caps)
>>>   {
>>>       int rc;
>>>   @@ -520,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>       if (rc)
>>>           return rc;
>>>   -    return cxl_setup_regs(map);
>>> +    return cxl_setup_regs(map, caps);
>>>   }
>>>     static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>> @@ -827,7 +827,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>       else
>>>           cxl_set_dvsec(cxlds, dvsec);
>>>   -    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>> +    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>>> +                &cxlds->capabilities);
>>>       if (rc)
>>>           return rc;
>>>   @@ -840,7 +841,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>        * still be useful for management functions so don't return an error.
>>>        */
>>>       rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>>> -                &cxlds->reg_map);
>>> +                &cxlds->reg_map, &cxlds->capabilities);
>>>       if (rc)
>>>           dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>>       else if (!cxlds->reg_map.component_map.ras.valid)
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index e78eefa82123..930b1b9c1d6a 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -12,6 +12,36 @@ enum cxl_resource {
>>>       CXL_ACCEL_RES_PMEM,
>>>   };
>>>   +/* Capabilities as defined for:
>>> + *
>>> + *    Component Registers (Table 8-22 CXL 3.0 specification)
>>> + *    Device Registers (8.2.8.2.1 CXL 3.0 specification)
>> Should just use 3.1 since that's the latest spec.
> 
> 
> Ok.
> 
> 
>>> + */
>>> +
>>> +enum cxl_dev_cap {
>>> +    /* capabilities from Component Registers */
>>> +    CXL_DEV_CAP_RAS,
>>> +    CXL_DEV_CAP_SEC,
>>> +    CXL_DEV_CAP_LINK,
>>> +    CXL_DEV_CAP_HDM,
>>> +    CXL_DEV_CAP_SEC_EXT,
>>> +    CXL_DEV_CAP_IDE,
>>> +    CXL_DEV_CAP_SNOOP_FILTER,
>>> +    CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>>> +    CXL_DEV_CAP_CACHEMEM_EXT,
>>> +    CXL_DEV_CAP_BI_ROUTE_TABLE,
>>> +    CXL_DEV_CAP_BI_DECODER,
>>> +    CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>>> +    CXL_DEV_CAP_CACHEID_DECODER,
>>> +    CXL_DEV_CAP_HDM_EXT,
>>> +    CXL_DEV_CAP_METADATA_EXT,
>>> +    /* capabilities from Device Registers */
>>> +    CXL_DEV_CAP_DEV_STATUS,
>>> +    CXL_DEV_CAP_MAILBOX_PRIMARY,
>>> +    CXL_DEV_CAP_MAILBOX_SECONDARY,
>> Does the OS ever uses the SECONDARY mailbox?
> 
> 
> I have no idea. I'm just listing all the potential capabilities here as you can see for things like BI or SNOOP.
> 
> Should I just add those referenced by code?
> 
> 
>>> +    CXL_DEV_CAP_MEMDEV,
>>> +};
>>> +
>>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>>     void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

