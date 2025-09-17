Return-Path: <netdev+bounces-223974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCFB7C58B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DF1C03C4F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A02DEA74;
	Wed, 17 Sep 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GY1ZHOT1"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D42EC08B
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107894; cv=none; b=ipnpwVG0hjMiMbIJU2E0b47FufmrTA3FXHrhXw8JESYbvsEk/vja/yEShQvm3X0rfxwQcmu/Rfe/AKmIxfVXL7gZtKleh5PCfNHwUDac7iu3T5SvXXOfsnYE71lJsY1nd2CJbV+07sy5LnWNAaC++ky07xQ88K6Mz78nOVKLvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107894; c=relaxed/simple;
	bh=fUKPTw/jrCmIgUj55A/LWv1Kjf1lKlW2Lrqq+JZSJ4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xsud8d1SQQ1MAtEs2WRSKlOXqBr6UmlGPcZvaedHchTxxj91gFAgD5y1LJeHOfUgXvc+kOTgoodW58uYTTAjj6sDmF12ke1G1MgLK9Swp6N4tBM1i8sWebmrhcBKDSOBim7Iw5DiikwDQJfiiQ6RdIRoXL/DW2/mA9njmgKZJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GY1ZHOT1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <649298e6-4a8e-4641-aedc-37708f6a797f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758107890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IssIQO7BFDZKYD8boaAxFTZ8xweSlUfwCHKHVAU0RA=;
	b=GY1ZHOT1ijHpMuDc8cnjHNbRxGtB+mUs5mleabc8gsVKUowPiyXLO4RE04F3iEMwVvUDCd
	BOsJ5KUNknkj7qTZCkzrJ5DayAhSXh+TPQQcNnOkXWmKstlc4WOwDcpV7DdT50KPts73Ym
	mo757M39SxzjW4rxK4HdrqbCCNtdtBg=
Date: Wed, 17 Sep 2025 12:18:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] octeontx2-pf: Fix use-after-free bugs in
 otx2_sync_tstamp()
To: Duoming Zhou <duoming@zju.edu.cn>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, richardcochran@gmail.com,
 naveenm@marvell.com
References: <20250917063853.24295-1-duoming@zju.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250917063853.24295-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/09/2025 07:38, Duoming Zhou wrote:
> The original code relies on cancel_delayed_work() in otx2_ptp_destroy(),
> which does not ensure that the delayed work item synctstamp_work has fully
> completed if it was already running. This leads to use-after-free scenarios
> where otx2_ptp is deallocated by otx2_ptp_destroy(), while synctstamp_work
> remains active and attempts to dereference otx2_ptp in otx2_sync_tstamp().
> Furthermore, the synctstamp_work is cyclic, the likelihood of triggering
> the bug is nonnegligible.
> 
> A typical race condition is illustrated below:
> 
> CPU 0 (cleanup)           | CPU 1 (delayed work callback)
> otx2_remove()             |
>    otx2_ptp_destroy()      | otx2_sync_tstamp()
>      cancel_delayed_work() |
>      kfree(ptp)            |
>                            |   ptp = container_of(...); //UAF
>                            |   ptp-> //UAF
> 
> This is confirmed by a KASAN report:
> 
> BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x7d7/0x8c0
> Write of size 8 at addr ffff88800aa09a18 by task bash/136
> ...
> Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x55/0x70
>   print_report+0xcf/0x610
>   ? __run_timer_base.part.0+0x7d7/0x8c0
>   kasan_report+0xb8/0xf0
>   ? __run_timer_base.part.0+0x7d7/0x8c0
>   __run_timer_base.part.0+0x7d7/0x8c0
>   ? __pfx___run_timer_base.part.0+0x10/0x10
>   ? __pfx_read_tsc+0x10/0x10
>   ? ktime_get+0x60/0x140
>   ? lapic_next_event+0x11/0x20
>   ? clockevents_program_event+0x1d4/0x2a0
>   run_timer_softirq+0xd1/0x190
>   handle_softirqs+0x16a/0x550
>   irq_exit_rcu+0xaf/0xe0
>   sysvec_apic_timer_interrupt+0x70/0x80
>   </IRQ>
> ...
> Allocated by task 1:
>   kasan_save_stack+0x24/0x50
>   kasan_save_track+0x14/0x30
>   __kasan_kmalloc+0x7f/0x90
>   otx2_ptp_init+0xb1/0x860
>   otx2_probe+0x4eb/0xc30
>   local_pci_probe+0xdc/0x190
>   pci_device_probe+0x2fe/0x470
>   really_probe+0x1ca/0x5c0
>   __driver_probe_device+0x248/0x310
>   driver_probe_device+0x44/0x120
>   __driver_attach+0xd2/0x310
>   bus_for_each_dev+0xed/0x170
>   bus_add_driver+0x208/0x500
>   driver_register+0x132/0x460
>   do_one_initcall+0x89/0x300
>   kernel_init_freeable+0x40d/0x720
>   kernel_init+0x1a/0x150
>   ret_from_fork+0x10c/0x1a0
>   ret_from_fork_asm+0x1a/0x30
> 
> Freed by task 136:
>   kasan_save_stack+0x24/0x50
>   kasan_save_track+0x14/0x30
>   kasan_save_free_info+0x3a/0x60
>   __kasan_slab_free+0x3f/0x50
>   kfree+0x137/0x370
>   otx2_ptp_destroy+0x38/0x80
>   otx2_remove+0x10d/0x4c0
>   pci_device_remove+0xa6/0x1d0
>   device_release_driver_internal+0xf8/0x210
>   pci_stop_bus_device+0x105/0x150
>   pci_stop_and_remove_bus_device_locked+0x15/0x30
>   remove_store+0xcc/0xe0
>   kernfs_fop_write_iter+0x2c3/0x440
>   vfs_write+0x871/0xd70
>   ksys_write+0xee/0x1c0
>   do_syscall_64+0xac/0x280
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ...
> 
> Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
> that the delayed work item is properly canceled before the otx2_ptp is
> deallocated.
> 
> This bug was initially identified through static analysis. To reproduce
> and test it, I simulated the OcteonTX2 PCI device in QEMU and introduced
> artificial delays within the otx2_sync_tstamp() function to increase the
> likelihood of triggering the bug.
> 
> Fixes: 2958d17a8984 ("octeontx2-pf: Add support for ptp 1-step mode on CN10K silicon")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>    - Describe how the issue was discovered and how the patch was tested.
> 
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> index e52cc6b1a26c..dedd586ed310 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> @@ -491,7 +491,7 @@ void otx2_ptp_destroy(struct otx2_nic *pfvf)
>   	if (!ptp)
>   		return;
>   
> -	cancel_delayed_work(&pfvf->ptp->synctstamp_work);
> +	cancel_delayed_work_sync(&pfvf->ptp->synctstamp_work);
>   
>   	ptp_clock_unregister(ptp->ptp_clock);
>   	kfree(ptp);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


