Return-Path: <netdev+bounces-148706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7267E9E2EFE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321EB2834E9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473591F76AB;
	Tue,  3 Dec 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzzNDqfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEA1EF08E;
	Tue,  3 Dec 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264650; cv=none; b=L12QVkGmFdWAl95jUvPRicHMJZ11Bvog//B9GxjhIXePW/nthP0909YU/W4T5R+LPhDIMvZeuQoAEeGPFEOG9jfiI7CJ17yCpKsogEUS7Tu4t48mxiIwHTX/wF/RzwM28Hgf+joGV2Qk5pMQpJ0RXcIBsbC7ykJBC+Hqs/j4/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264650; c=relaxed/simple;
	bh=EFFv7KuORYdm3EdRMvejGNb34H+BW/MpRJzKLrjZ/l8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVSsElQAH+ZzrNe/p9OhagyHTjnxvRH1lHsZwK/kL1qyxd3di8j+v0NzpTv/9ieGJAbTjvoivWTOII69IYz3wrunueOfWdo9uv5kPCNY1D0osKphpgyNuC+LAxBNYeQMwvkNgz4ITG0I0/sQbGaVgVDf+kPuErfMty0sC9wnq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzzNDqfW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7250906bc63so218790b3a.1;
        Tue, 03 Dec 2024 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264647; x=1733869447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYhIECUsH2WlC8jswAYffCc6xqaoXhGr1s7+1pPC8G0=;
        b=MzzNDqfWdafw9eijuyoGxYCSFtOrYbV1po1bsr32wiqL74+W89kXdToaD7iO8Jfhno
         E8m2bwKy/aGen7oFYERBWdzzYj2SMNtzFbuEhn9qdsh8GhQ8xYf2CVxFbKSw3F7jeLZp
         O+qxWak6+xXR9VkDLVLtI41HwpIEiyF1hFFlaoLhoNKJUMi+iC3cyf7apWZPIbmadq3g
         YodwgSWTHMmwCCbPHF0+BJiWVXu4RrgQKMLHC0MSmHzmi6fY9hW7CzMbS4o2vQ7cnXSz
         xLQKltfKJyi4DyiRJPSEzeWCW6pSlzO74sNgjgn05ZXpvsnf1/DHv7CpRVhbgiItdKmt
         Wu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264647; x=1733869447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYhIECUsH2WlC8jswAYffCc6xqaoXhGr1s7+1pPC8G0=;
        b=FloWotamlI+B4/xjgszivn5JdO9ak41Re5zMyA6YJLnkhu2WvC6k2ANyTN/zegPhlZ
         UkHCASa/20mQQfzr0mkXCa1Iyf/0YhRsKNWI67QzXp5HI7xiiIVCGATuo2l0vH1h4yqP
         +f4YevpvNCeNIPP26QukrErIvPeTDMNVkoQiukz8PBnYst30DyG9QG75H1nxklqG/snc
         TbIkU6FOmnhomjDR24euI57z3mb6sYwWSj/+RcPFIwTAfpKPBXfhy2dJ8b6GtZt2zFZQ
         Gm/zOtRvKedqMEk5BjjQkYFPYQci2jVrVKno2bpD5GYkQmaOg2X3ia75ZUzHn+O0KAbu
         o3gg==
X-Forwarded-Encrypted: i=1; AJvYcCXFBSij/6thG9nopj19Qx2JknlaEGCp1RLNkLmMmgh5w6A0bVtbJ+hcBUXdqNbU3xqAUAg5QJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPHYii2gxM9g8PW8k6JbU9qpl2zDA7m4hl24trtmu+OXQ/yJX
	j5+/enuL5C2EWgeBM16y3kKupSm0rRj1JSnrU1bkNlZ81yPzd5WY
X-Gm-Gg: ASbGnctT2rJN4PCdPreiI1r2Qyai76/d+IXgQb8LSwmR5U7eusqoarKTZUKC0munRuN
	sOWClOwPLFn8r1CWo0Y/DH3hGT+iJP8rGAlGQXztovUs4FqCu7qRbNZteIuwLLHpsL3fY4aMgJe
	nPugw5A9jkWgGrX5sChMvbk2qwaTCF8NQOz5LWFPKxzGLcQole6VedWrHZH8H/M/hm3f7ZHMSRp
	I7KlVjcM4MhnqDzodKXlCjoy92sogNr4Ipnta1/JxPGPktRBt3JhA==
X-Google-Smtp-Source: AGHT+IEI4o09wpU3FsPspxezJ/P7oWNgPWK2oW1ryQ5+s3S+fv8ngnFjCpzSV1/XwZfTufGKzsUVnw==
X-Received: by 2002:a17:902:f104:b0:215:531f:8e39 with SMTP id d9443c01a7336-215531f9156mr189223355ad.11.1733264647376;
        Tue, 03 Dec 2024 14:24:07 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849bfasm10939054b3a.195.2024.12.03.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:24:06 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 3 Dec 2024 22:24:04 +0000
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 03/28] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <Z0-FBDH8BPTbjZl-@smc-140338-bm01>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-4-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-4-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:11:57PM +0000, alejandro.lucero-palau@amd.com wrote:
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
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/port.c | 11 +++++++----
>  drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>  drivers/cxl/cxl.h       |  9 ++++++---
>  drivers/cxl/cxlmem.h    |  2 ++
>  drivers/cxl/pci.c       | 10 ++++++----
>  include/cxl/cxl.h       | 19 +++++++++++++++++++
>  6 files changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index af92c67bc954..5bc8490a199c 100644
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
> @@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
>  		port->reg_map = cxlds->reg_map;
>  		port->reg_map.host = &port->dev;
>  		cxlmd->endpoint = port;
> +		bitmap_copy(port->capabilities, cxlds->capabilities,
> +			    CXL_MAX_CAPS);
>  	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
>  		if (rc)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 429973a2165b..fe835f6df866 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <pmu.h>
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
> index f6015f24ad38..22e787748d79 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -4,6 +4,7 @@
>  #ifndef __CXL_H__
>  #define __CXL_H__
>  
> +#include <cxl/cxl.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
>  #include <linux/notifier.h>
> @@ -292,9 +293,9 @@ struct cxl_register_map {
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
> @@ -308,7 +309,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> @@ -609,6 +610,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -632,6 +634,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..4c1c53c29544 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -428,6 +428,7 @@ struct cxl_dpa_perf {
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -443,6 +444,7 @@ struct cxl_dev_state {
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6c9a6fb38635..f6071bde437b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> +			      struct cxl_register_map *map,
> +			      unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -534,7 +535,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		return rc;
>  	}
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> @@ -938,7 +939,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxl_set_dvsec(cxlds, dvsec);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -951,7 +953,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return an error.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, cxlds->capabilities);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 19e5d883557a..f656fcd4945f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -12,6 +12,25 @@ enum cxl_resource {
>  	CXL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
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
> +	CXL_MAX_CAPS = 64
> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> -- 
> 2.17.1
> 

-- 
Fan Ni (From gmail)

