Return-Path: <netdev+bounces-159175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC0A149F5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D563E169485
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223E1F755B;
	Fri, 17 Jan 2025 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKsxRk2J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252671D6DBF
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097659; cv=none; b=gxb+5W9aWlaoWh/m+IdjpqAALhFWFsuToSpW2dUG7fRi90ysTIipCyERCwp8kuwOq2aUb9xwMG8ki3T8Qc88sZ1PLvd5yGRqVq9WJ0LIDPTuN6BcLK4LP3oQTAE0oUjDbYxI7QKOU+7jV94+FzNQcCy97b2doRPTMBntGN/gOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097659; c=relaxed/simple;
	bh=/LiuZ91CJ42MgrWOGkeq90OSp1438J5fR5yH8U7G0gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY7TRntZ6j8CeyDHUUKk4VscowbH7JUhSyb6heUXGAUfrU4we9zqp0zs7wFNvYOy1JhAHaDXomYToqeEXKh+dvsBemu/JkAEOWxmUKUjcTDIg7WMuGdXr86R9wy1xSE49ZPgd70MRuviQFnqmf5ZoI/mcza3WNTOD2cRhkh4FAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKsxRk2J; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737097658; x=1768633658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LiuZ91CJ42MgrWOGkeq90OSp1438J5fR5yH8U7G0gQ=;
  b=ZKsxRk2JsD6MmVK7OknGhNLVSiEDDG7qMJfwwbPkd/2rujxSgSlytag7
   6kJXGYunb1fiLHgfQTX2fk1IDRmY9rObyphedttrZS7rckvs/uBL5LpoT
   4eKdkmo+pDvGNN4/HGUTsUKPQMmMlgLtM92zxuXBx3II/RCOP8tHyasSM
   Lrl+TfnNYZOQpKKM/tOBuxtaincFO3d5o86onVavNlxM5gBwdIrv+8SEK
   6YMA+bMvAbsgN75Ofg8j7cx5OtDbosQnCI3oVoePP4QbdsURnMsGTB9ZI
   xfK0oBP/A1yeToN3qaagwCsa1moigvYuf3JbvI5Ixejsv9s7F89xA5exP
   Q==;
X-CSE-ConnectionGUID: qvMYA6eGQ2mk0q8mLv4JsA==
X-CSE-MsgGUID: UN/HE9w+QcmD0zlbumYv0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37757427"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="37757427"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 23:07:38 -0800
X-CSE-ConnectionGUID: aJpbCbknT1OME1wdRKmd1g==
X-CSE-MsgGUID: HEVsw0CeRvaCKXSwWFoQAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="105789452"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 23:07:34 -0800
Date: Fri, 17 Jan 2025 08:04:17 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	helgaas@kernel.org, Manoj Panicker <manoj.panicker2@amd.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v2 10/10] bnxt_en: Add TPH support in BNXT driver
Message-ID: <Z4oA8U3opS/7Ike0@mev-dev.igk.intel.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
 <20250116192343.34535-11-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116192343.34535-11-michael.chan@broadcom.com>

On Thu, Jan 16, 2025 at 11:23:43AM -0800, Michael Chan wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
> 
> Add TPH support to the Broadcom BNXT device driver. This allows the
> driver to utilize TPH functions for retrieving and configuring Steering
> Tags when changing interrupt affinity. With compatible NIC firmware,
> network traffic will be tagged correctly with Steering Tags, resulting
> in significant memory bandwidth savings and other advantages as
> demonstrated by real network benchmarks on TPH-capable platforms.
> 
> Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> 
> Previous driver series fixing rtnl_lock and empty release function:
> 
> https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd.com/
> 
> v5 of the PCI series using netdev_rx_queue_restart():
> 
> https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd.com/
> 
> v1 of the PCI series using open/close:
> 
> https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd.com/
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 105 ++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   7 ++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0a10a4cffcc8..8c24642b8812 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,8 @@
>  #include <net/page_pool/helpers.h>
>  #include <linux/align.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +#include <linux/pci-tph.h>
>  
>  #include "bnxt_hsi.h"
>  #include "bnxt.h"
> @@ -11330,6 +11332,83 @@ static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
>  	return 0;
>  }
>  
> +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +				     const cpumask_t *mask)
> +{
> +	struct bnxt_irq *irq;
> +	u16 tag;
> +	int err;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +
> +	if (!irq->bp->tph_mode)
> +		return;
> +
Can it not be set? The notifier is registered only if it is set, can
mode change while irq notifier is registered? Maybe I am missing sth,
but it looks like it can't.

> +	cpumask_copy(irq->cpu_mask, mask);
> +
> +	if (irq->ring_nr >= irq->bp->rx_nr_rings)
> +		return;
> +
> +	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +				cpumask_first(irq->cpu_mask), &tag))
> +		return;
> +
> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
> +		return;
> +
> +	rtnl_lock();
> +	if (netif_running(irq->bp->dev)) {
> +		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
> +		if (err)
> +			netdev_err(irq->bp->dev,
> +				   "RX queue restart failed: err=%d\n", err);
> +	}
> +	rtnl_unlock();
> +}
> +
> +static void bnxt_irq_affinity_release(struct kref *ref)
> +{
> +	struct irq_affinity_notify *notify =
> +		container_of(ref, struct irq_affinity_notify, kref);
> +	struct bnxt_irq *irq;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +
> +	if (!irq->bp->tph_mode)
The same here.

> +		return;
> +
> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, 0)) {
> +		netdev_err(irq->bp->dev,
> +			   "Setting ST=0 for MSIX entry %d failed\n",
> +			   irq->msix_nr);
> +		return;
> +	}
> +}
> +
> +static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
> +{
> +	irq_set_affinity_notifier(irq->vector, NULL);
> +}
> +
> +static void bnxt_register_irq_notifier(struct bnxt *bp, struct bnxt_irq *irq)
> +{
> +	struct irq_affinity_notify *notify;
> +
> +	irq->bp = bp;
> +
> +	/* Nothing to do if TPH is not enabled */
> +	if (!bp->tph_mode)
> +		return;
> +
> +	/* Register IRQ affinity notifier */
> +	notify = &irq->affinity_notify;
> +	notify->irq = irq->vector;
> +	notify->notify = bnxt_irq_affinity_notify;
> +	notify->release = bnxt_irq_affinity_release;
> +
> +	irq_set_affinity_notifier(irq->vector, notify);
> +}
> +
>  static void bnxt_free_irq(struct bnxt *bp)
>  {
>  	struct bnxt_irq *irq;
> @@ -11352,11 +11431,18 @@ static void bnxt_free_irq(struct bnxt *bp)
>  				free_cpumask_var(irq->cpu_mask);
>  				irq->have_cpumask = 0;
>  			}
> +
> +			bnxt_release_irq_notifier(irq);
> +
>  			free_irq(irq->vector, bp->bnapi[i]);
>  		}
>  
>  		irq->requested = 0;
>  	}
> +
> +	/* Disable TPH support */
> +	pcie_disable_tph(bp->pdev);
> +	bp->tph_mode = 0;
>  }
>  
>  static int bnxt_request_irq(struct bnxt *bp)
> @@ -11376,6 +11462,12 @@ static int bnxt_request_irq(struct bnxt *bp)
>  #ifdef CONFIG_RFS_ACCEL
>  	rmap = bp->dev->rx_cpu_rmap;
>  #endif
> +
> +	/* Enable TPH support as part of IRQ request */
> +	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
> +	if (!rc)
> +		bp->tph_mode = PCI_TPH_ST_IV_MODE;
> +
>  	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
>  		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
>  		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
> @@ -11399,8 +11491,11 @@ static int bnxt_request_irq(struct bnxt *bp)
>  
>  		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>  			int numa_node = dev_to_node(&bp->pdev->dev);
> +			u16 tag;
>  
>  			irq->have_cpumask = 1;
> +			irq->msix_nr = map_idx;
> +			irq->ring_nr = i;
>  			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>  					irq->cpu_mask);
>  			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
> @@ -11410,6 +11505,16 @@ static int bnxt_request_irq(struct bnxt *bp)
>  					    irq->vector);
>  				break;
>  			}
> +
> +			bnxt_register_irq_notifier(bp, irq);
> +
> +			/* Init ST table entry */
> +			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +						cpumask_first(irq->cpu_mask),
> +						&tag))
> +				continue;
> +
> +			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
>  		}
>  	}
>  	return rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 826ae030fc09..02dc2ed9c75d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1234,6 +1234,11 @@ struct bnxt_irq {
>  	u8		have_cpumask:1;
>  	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
>  	cpumask_var_t	cpu_mask;
> +
> +	struct bnxt	*bp;
> +	int		msix_nr;
> +	int		ring_nr;
> +	struct irq_affinity_notify affinity_notify;
>  };
>  
>  #define HWRM_RING_ALLOC_TX	0x1
> @@ -2229,6 +2234,8 @@ struct bnxt {
>  	struct net_device	*dev;
>  	struct pci_dev		*pdev;
>  
> +	u8			tph_mode;
> +
>  	atomic_t		intr_sem;
>  
>  	u32			flags;
> -- 
> 2.30.1
> 

