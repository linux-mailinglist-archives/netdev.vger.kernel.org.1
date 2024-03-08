Return-Path: <netdev+bounces-78692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11E876280
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A5128258C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340654BF1;
	Fri,  8 Mar 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gP4W7WSg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563C55E40
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895444; cv=none; b=GEpwjEMk0HRHjyjfKbzFDKiL9VNVq+i8SxZ+91kddq4PVSBmd52obhDdUir6jWgkAvKKKOPeHA5vu82xfxKmqIaUMjSCBAye/65Csqer4qbJrfTEqro852+tWvlZBEsZ/Deekne4PJ7RHmfixqRagCEkhl4BvHwNVRsCA0WgWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895444; c=relaxed/simple;
	bh=ww885ORZp6jpul6UKJl2yHQ6e0Fb6jaL/sGKDaf99/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DthK7srSYor4+UDKRjalR1/nf3UunlB5ill/pYHC+3AiF4B6atyj8K0pE7gd5eag5I8jmObdUbXjpCuC05L7KD8fSywWH1/f0UK1xXk7UYEUPyoqC6Hr/oIWT0dtAuJk/GX4IEZ4Epg2qVDHYPDMJvO1vPPcVAC4y7gg5YlwVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gP4W7WSg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709895442; x=1741431442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ww885ORZp6jpul6UKJl2yHQ6e0Fb6jaL/sGKDaf99/k=;
  b=gP4W7WSgg0N1uvf4gJWJMzDMySa9LFWkOlKv/uBc3qoPH5oRhesrkU1Z
   99gcDPEfakUviiEwFjnNvzoSY5NPafTvGb63sChm/xqHmiPdnyvgwUdYi
   NwWO1MnATAdElLjexWZWL4L2LXq52xevMW0i1mXojuwTxXtZmHp4FZvdp
   eduYQ3P8Be5/zs+9+VcTbQWSQ6gAqRWaZjmA3oktMDAIq+GBkxiynIFEJ
   S463EDyPldg45Io5o0BGLC2arMl9vF3+MAcZroo8/PX46mAoz4UDhkJOs
   HJAeur/IwbhifcxpndJFWHcoWkHQgs3LgIzho8sYgUNkTL2BC0X+2QP1k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="7555571"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="7555571"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15099656"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.248.101]) ([10.94.248.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:57:19 -0800
Message-ID: <0a13e22c-790e-4ac2-ad6c-eb350ef8c349@linux.intel.com>
Date: Fri, 8 Mar 2024 11:57:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/3] ice: add ice_adapter
 for shared data across PFs on the same NIC
To: Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240307222510.53654-1-mschmidt@redhat.com>
 <20240307222510.53654-2-mschmidt@redhat.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240307222510.53654-2-mschmidt@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07.03.2024 23:25, Michal Schmidt wrote:
> There is a need for synchronization between ice PFs on the same physical
> adapter.
> 
> Add a "struct ice_adapter" for holding data shared between PFs of the
> same multifunction PCI device. The struct is refcounted - each ice_pf
> holds a reference to it.
> 
> Its first use will be for PTP. I expect it will be useful also to
> improve the ugliness that is ice_prot_id_tbl.
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile      |   3 +-
>  drivers/net/ethernet/intel/ice/ice.h         |   2 +
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 107 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_adapter.h |  22 ++++
>  drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
>  5 files changed, 141 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> index cddd82d4ca0f..4fa09c321440 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -36,7 +36,8 @@ ice-y := ice_main.o	\
>  	 ice_repr.o	\
>  	 ice_tc_lib.o	\
>  	 ice_fwlog.o	\
> -	 ice_debugfs.o
> +	 ice_debugfs.o  \
> +	 ice_adapter.o
>  ice-$(CONFIG_PCI_IOV) +=	\
>  	ice_sriov.o		\
>  	ice_virtchnl.o		\
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 365c03d1c462..1ffecbdd361a 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -77,6 +77,7 @@
>  #include "ice_gnss.h"
>  #include "ice_irq.h"
>  #include "ice_dpll.h"
> +#include "ice_adapter.h"
>  
>  #define ICE_BAR0		0
>  #define ICE_REQ_DESC_MULTIPLE	32
> @@ -544,6 +545,7 @@ struct ice_agg_node {
>  
>  struct ice_pf {
>  	struct pci_dev *pdev;
> +	struct ice_adapter *adapter;
>  
>  	struct devlink_region *nvm_region;
>  	struct devlink_region *sram_region;
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> new file mode 100644
> index 000000000000..6b9eeba6edf7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-FileCopyrightText: Copyright Red Hat
> +
> +#include <linux/cleanup.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/xarray.h>
> +#include "ice_adapter.h"
> +
> +static DEFINE_XARRAY(ice_adapters);
> +
> +static unsigned long ice_adapter_index(const struct pci_dev *pdev)
> +{
> +	unsigned int domain = pci_domain_nr(pdev->bus);
> +
> +	WARN_ON((unsigned long)domain >> (BITS_PER_LONG - 13));
> +	return ((unsigned long)domain << 13) |
> +	       ((unsigned long)pdev->bus->number << 5) |

Magic numbers?

> +	       PCI_SLOT(pdev->devfn);
> +}
> +
> +static struct ice_adapter *ice_adapter_new(void)
> +{
> +	struct ice_adapter *adapter;
> +
> +	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return NULL;
> +
> +	refcount_set(&adapter->refcount, 1);
> +
> +	return adapter;
> +}
> +
> +static void ice_adapter_free(struct ice_adapter *adapter)
> +{
> +	kfree(adapter);
> +}
> +
> +DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
> +
> +/**
> + * ice_adapter_get - Get a shared ice_adapter structure.
> + * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapter.
> + *
> + * Gets a pointer to a shared ice_adapter structure. Physical functions (PFs)
> + * of the same multi-function PCI device share one ice_adapter structure.
> + * The ice_adapter is reference-counted. The PF driver must use ice_adapter_put
> + * to release its reference.
> + *
> + * Context: Process, may sleep.
> + * Return:  Pointer to ice_adapter on success.
> + *          ERR_PTR() on error. -ENOMEM is the only possible error.

What about ERR_PTR(xa_err(ret))?

> + */
> +struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
> +{
> +	struct ice_adapter *ret, __free(ice_adapter_free) *adapter = NULL;
> +	unsigned long index = ice_adapter_index(pdev);
> +
> +	adapter = ice_adapter_new();
> +	if (!adapter)
> +		return ERR_PTR(-ENOMEM);

---8<---

Thanks,
Marcin

