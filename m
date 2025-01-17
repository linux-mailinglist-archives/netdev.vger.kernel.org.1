Return-Path: <netdev+bounces-159347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23DA152FA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4A18899C1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6F197A7E;
	Fri, 17 Jan 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tujTLL7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9B193404
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128515; cv=none; b=W/yupWFIUcggDLRwbTfshgTFS5eLKYHfzk1zbO0C4pWVHaAGR1VK04wKh6FSW7GbL2gRdrU7M0o2vXPFzLi59+LzGl8CNz5G/3b/+QJba2MKuoA9skcyPGFGWUj7STBNsPfQmJL88yV3dXAGO1j0G/qKRLNW78HRZPxksZn57XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128515; c=relaxed/simple;
	bh=0goQeBdrjWL8unfZLe+i6UZ3RI4bCo3nkPsp0fvxPQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWcyJb6CuIaLiiupcSzW6MNrMRF4R4oD1F2ZspmwqO4r/jvoyr9UgYzT+zzhA5Lcy/5xzrevE5LAhe4bu80dyaDb2Ts2tGgfrzDHU7jmRcQCMSNKrXaIth7hhPKyfmhIOca4yEvS/FoAP5nC4Xp3fwzzynp/6wCM0cr9Lv9iGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tujTLL7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61EC4CEDD;
	Fri, 17 Jan 2025 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737128514;
	bh=0goQeBdrjWL8unfZLe+i6UZ3RI4bCo3nkPsp0fvxPQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tujTLL7pxFDMNi4B4jiI5o7KYyOI0iG2E2VtzwXlPUCmtsdokowT7tKtBL9aOZ1a1
	 Jlbj7PvClXWFBbYaPKuMcXWdtFIff6r4Qv6PACyN81CjmkCn+KaHEwegvO83PWdS5t
	 ziP6qPZ/7gqkhLw639FzSUyw7gXcfqTXhD57mdQrzEJ9i1ida5h8Ok4JIfEXHqWRSg
	 mYu77vXkxJg6fvtA1H3m/+yqFxoxWOK4PIux/nTknH2E0Aub8/avvhVZqzgZlhDgWm
	 LtJFzKLd2b08G4xKuOzrjo6bblnnC0c+Y5BrJ7QZ7cXEEDTj5H/WAP37WqPOmZgN2m
	 6Qk9CWKa4d5iQ==
Date: Fri, 17 Jan 2025 15:41:49 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com, helgaas@kernel.org,
	Manoj Panicker <manoj.panicker2@amd.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v2 10/10] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20250117154149.GQ6206@kernel.org>
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

Hi Manoj, Michael, all,

Modpost complains that:

WARNING: modpost: module bnxt_en uses symbol netdev_rx_queue_restart from namespace NETDEV_INTERNAL, but does not import it.

And looking into this I see:

* netdev: define NETDEV_INTERNAL
  https://git.kernel.org/netdev/net-next/c/0b7bdc7fab57

Which adds the following text to Documentation/networking/netdevices.rst

  NETDEV_INTERNAL symbol namespace
  ================================

  Symbols exported as NETDEV_INTERNAL can only be used in networking
  core and drivers which exclusively flow via the main networking list and trees.
  Note that the inverse is not true, most symbols outside of NETDEV_INTERNAL
  are not expected to be used by random code outside netdev either.
  Symbols may lack the designation because they predate the namespaces,
  or simply due to an oversight.

Which I think is satisfied here. So I think this problem can be
addressed by adding the following about here (completely untested!).

MODULE_IMPORT_NS("NETDEV_INTERNAL");

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

...

