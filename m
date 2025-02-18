Return-Path: <netdev+bounces-167376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD3A3A059
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07351766FA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521E26B97D;
	Tue, 18 Feb 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOjZYJi/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4426B978;
	Tue, 18 Feb 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889610; cv=none; b=mkpDTZcaY/d1+IooUIVXd5Z/PuyA51ptQKDXUU1lf2HgxTR2zqArFzwIC7rRHi8FrrGVtldxW4ribhWtPpEy5haqTUfrC4DsSAQ94KfQTfBKIvDGnjb2NFvvX5j2uxKp5mYIOZPEM/WZbQqGPzeSXMdh1xYSnpQCCz1M7jzHjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889610; c=relaxed/simple;
	bh=93gRKWZ9sWNKKYWRsAOLp1himHRHtqXLZ4xduD7iumM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/0Z1v+S9g2RGKdLPLGWCDjVG52moQspercLtHJOV94jFgRfY9U2jkemSoOPKpuBPr8fNmv7zUFFR9bMoVFJi3E+PGQNL9R/lvDIDKE3bBzq29QqxkxUit5KXsmtzR/OoHrVnKepN/ZXX05AVnnVB9E1uQUhBl4gGz69R5gBu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOjZYJi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C47C4CEE2;
	Tue, 18 Feb 2025 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889610;
	bh=93gRKWZ9sWNKKYWRsAOLp1himHRHtqXLZ4xduD7iumM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aOjZYJi/6jxu4Wz33SZbEiDWRMpgYqj3t0BN62YsObgYRi+v5V9vcmuMdPn000Zmj
	 CA0qpDJt1s5PD0ZGde96Vi3mcgbXduXyw/UeSCOffLH8RaX1cR6D/zGc7Io8xIth4q
	 gqC1psROg4g1BA35r/vYrjpUzbUGGvxKS5y74xgOW82Wzjz3h/XwellFHpOglTH8Mu
	 8FurJJf6AeW2FIOLgCHwmjfGDaxPANXZW7/sM4wvs1QkivBLlcKjKcOiDi+d+w6BcE
	 la/Yjh5/uLoQz0Z2VK8Geb2DR3SemWh+3x0vQLYr24JuDxpXa0uJBOHKiXYzjuFgbQ
	 RQpddGOIfMLtw==
Message-ID: <3e6505a4-ba21-4dd6-8ad2-8e0ef8846fc3@kernel.org>
Date: Tue, 18 Feb 2025 15:40:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/pseries/iommu: Wait until all TCEs are
 unmapped before deleting DDW
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 mpe@ellerman.id.au, iommu@lists.linux.dev, ilias.apalodimas@linaro.org,
 Netdev <netdev@vger.kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
References: <20250213171051.63748-1-gbatra@linux.ibm.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250213171051.63748-1-gbatra@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc. netdev and Yunsheng Lin

On 13/02/2025 18.10, Gaurav Batra wrote:
> Some of the network drivers, like Mellanox, use core linux page_pool APIs
> to manage DMA buffers. These page_pool APIs cache DMA buffers with
> infrequent map/unmap calls for DMA mappings, thus increasing performance.
> 
> When a device is initialized, the drivers makes a call to the page_pool API
> to create a DMA buffer pool. Hence forth DMA buffers are allocated and
> freed from this pool by the driver. The DMA map/unmap is done by the core
> page_pool infrastructure.
> 
> These DMA buffers could be allocated for RX/TX buffer rings for the device
> or could be in-process by the network stack.
> 
> When a network device is closed, driver will release all DMA mapped
> buffers. All the DMA buffers allocated to the RX/TX rings are released back
> to the page_pool by the driver. Some of the DMA mapped buffers could still
> be allocated and in-process by the network stack.
> 
> DMA buffers that are relased by the Network driver are synchronously
> unmapped by the page_pool APIs. But, DMA buffers that are passed to the
> network stack and still in-process are unmapped later asynchronously by the
> page_pool infrastructure.
> 
> This asynchronous unmapping of the DMA buffers, by the page_pool, can lead
> to issues when a network device is dynamically removed in PowerPC
> architecture.  When a network device is DLPAR removed, the driver releases
> all the mapped DMA buffers and stops using the device. Driver returns
> successfully. But, at this stage there still could be mapped DMA buffers
> which are in-process by the network stack.
> 
> DLPAR code proceeds to remove the device from the device tree, deletes
> Dynamic DMA Window (DDW) and associated IOMMU tables. DLPAR of the device
> succeeds.
> 
> Later, when network stack release some of the DMA buffers, page_pool
> proceeds to unmap them. The page_pool relase path calls into PowerPC TCE
> management to release the TCE. This is where the LPAR OOPses since the DDW
> and associated resources for the device are already free'ed.
> 
> This issue was exposed during (Live Partition Migration) LPM from a Power9
> to Power10 machine with HNV configuration. The bonding device is Virtual
> Ethernet with SR-IOV. During LPM, I/O is switched from SR-IOV to passive
> Virtual Ethernet and DLPAR remove of SR-IOV is initiated. This lead to the
> above mentioned scenario.
> 
> It is possible to hit this issue by just Dynamically removing SR-IOV device
> which is under heavy I/O load, a scenario where some of the mapped DMA
> buffers are in-process somewhere in the network stack and not mapped to the
> RX/TX ring of the device.
> 
> The issue is only encountered when TCEs are dynamically managed. In this
> scenario map/unmap of TCEs goes into the PowerPC TCE management path as and
> when DMA bufffers are mapped/unmaped and accesses DDW resources. When RAM
> is directly mapped during device initialization, this dynamic TCE
> management is by-passed and LPAR doesn't OOPses.
> 
> Solution:
> 
> During DLPAR remove of the device, before deleting the DDW and associated
> resources, check to see if there are any outstanding TCEs. If there are
> outstanding TCEs, sleep for 50ms and check again, until all the TCEs are
> unmapped.
> 
> Once all the TCEs are unmapped, DDW is removed and DLPAR succeeds. This
> ensures there will be no reference to the DDW after it is deleted.
> 
> Here is the stack for reference
> 
> [ 3610.403820] tce_freemulti_pSeriesLP: 48 callbacks suppressed
> [ 3610.403833] tce_freemulti_pSeriesLP: plpar_tce_stuff failed
> [ 3610.403869]  rc      = -4
> [ 3610.403872]  index   = 0x70000016
> [ 3610.403876]  limit     = 0x1
> [ 3610.403879]  tce       = 0x80000061ee00000
> [ 3610.403882]  pgshift = 0x10
> [ 3610.403884]  npages  = 0x1
> [ 3610.403887]  tbl     = 000000003a6a2145
> [ 3610.403912] CPU: 86 PID: 97129 Comm: kworker/86:2 Kdump: loaded Tainted: G            E        6.4.0-623164-default #1 SLE15-SP6 763d454e096eda7d91355fd5b171013052d83ed3
> [ 3610.403928] Hardware name: IBM,9080-M9S POWER9 (raw) 0x4e2101 0xf000005 of:IBM,FW950.80 (VH950_131) hv:phyp pSeries
> [ 3610.403937] Workqueue: events page_pool_release_retry
> [ 3610.404003] Call Trace:
> [ 3610.404006] [c000055034e6bb30] [c000000000f63108] dump_stack_lvl+0x6c/0x9c (unreliable)
> [ 3610.404039] [c000055034e6bb60] [c000000000101258] tce_freemulti_pSeriesLP+0x1e8/0x1f0
> [ 3610.404070] [c000055034e6bbf0] [c00000000005d248] __iommu_free+0x118/0x220
> [ 3610.404086] [c000055034e6bc80] [c00000000005d4e8] iommu_free+0x28/0x70
> [ 3610.404106] [c000055034e6bcb0] [c00000000005c4b4] dma_iommu_unmap_page+0x24/0x40
> [ 3610.404113] [c000055034e6bcd0] [c00000000024b56c] dma_unmap_page_attrs+0x1ac/0x1e0
> [ 3610.404139] [c000055034e6bd30] [c000000000cfa178] page_pool_return_page+0x58/0x1b0
> [ 3610.404146] [c000055034e6bd60] [c000000000cfb7bc] page_pool_release+0x10c/0x270^
> [ 3610.404152] [c000055034e6be00] [c000000000cfbb2c] page_pool_release_retry+0x2c/0x110
> [ 3610.404159] [c000055034e6be70] [c00000000018e294] process_one_work+0x314/0x620
> [ 3610.404173] [c000055034e6bf10] [c00000000018ee88] worker_thread+0x78/0x620
> [ 3610.404179] [c000055034e6bf90] [c00000000019b958] kthread+0x148/0x150
> [ 3610.404188] [c000055034e6bfe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
> 
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---
>   arch/powerpc/kernel/iommu.c            | 22 ++++++++++++++++++++--
>   arch/powerpc/platforms/pseries/iommu.c |  8 ++++----
>   2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 76381e14e800..af7511a8f480 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -14,6 +14,7 @@
>   #include <linux/types.h>
>   #include <linux/slab.h>
>   #include <linux/mm.h>
> +#include <linux/delay.h>
>   #include <linux/spinlock.h>
>   #include <linux/string.h>
>   #include <linux/dma-mapping.h>
> @@ -803,6 +804,7 @@ bool iommu_table_in_use(struct iommu_table *tbl)
>   static void iommu_table_free(struct kref *kref)
>   {
>   	struct iommu_table *tbl;
> +	unsigned long start_time;
>   
>   	tbl = container_of(kref, struct iommu_table, it_kref);
>   
> @@ -817,8 +819,24 @@ static void iommu_table_free(struct kref *kref)
>   	iommu_debugfs_del(tbl);
>   
>   	/* verify that table contains no entries */
> -	if (iommu_table_in_use(tbl))
> -		pr_warn("%s: Unexpected TCEs\n", __func__);
> +	start_time = jiffies;
> +	while (iommu_table_in_use(tbl)) {
> +		int sec;
> +
> +		pr_info("%s: Unexpected TCEs, wait for 50ms\n", __func__);
> +		msleep(50);
> +
> +		/* Come out of the loop if we have already waited for 120 seconds
> +		 * for the TCEs to be free'ed. TCE are being free'ed
> +		 * asynchronously by some DMA buffer management API - like
> +		 * page_pool.
> +		 */
> +		sec = (s32)((u32)jiffies - (u32)start_time) / HZ;
> +		if (sec >= 120) {
> +			pr_warn("%s: TCEs still mapped even after 120 seconds\n", __func__);
> +			break;
> +		}
> +	}
>   
>   	/* free bitmap */
>   	vfree(tbl->it_map);
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 534cd159e9ab..925494b6fafb 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -2390,6 +2390,10 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
>   
>   	switch (action) {
>   	case OF_RECONFIG_DETACH_NODE:
> +		if (pci && pci->table_group)
> +			iommu_pseries_free_group(pci->table_group,
> +					np->full_name);
> +
>   		/*
>   		 * Removing the property will invoke the reconfig
>   		 * notifier again, which causes dead-lock on the
> @@ -2400,10 +2404,6 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
>   		if (remove_dma_window_named(np, false, DIRECT64_PROPNAME, true))
>   			remove_dma_window_named(np, false, DMA64_PROPNAME, true);
>   
> -		if (pci && pci->table_group)
> -			iommu_pseries_free_group(pci->table_group,
> -					np->full_name);
> -
>   		spin_lock(&dma_win_list_lock);
>   		list_for_each_entry(window, &dma_win_list, list) {
>   			if (window->device == np) {
> 
> base-commit: 6e4436539ae182dc86d57d13849862bcafaa4709

