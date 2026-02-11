Return-Path: <netdev+bounces-258301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDsnN8ChjGkkrwAAu9opvQ
	(envelope-from <netdev+bounces-258301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:35:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822C125B92
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D10263013AB7
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED13016E5;
	Wed, 11 Feb 2026 15:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B72301026;
	Wed, 11 Feb 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824114; cv=none; b=KBSlv+65D+6mFmcD9MA8cGn6EKKF4de/nW9K29wh/JArWyH12SDJUP16CGxmgNyb7g3SAehSZKcWsdZjv47JYYf2nUjG+3L8f8ijFUnvChCXgc0BYWH1Y+/o2jcHxCaubE2+vDmJ2ZQvUcWlCnHkR+kMfhM4Qa+gHPgEmf+sR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824114; c=relaxed/simple;
	bh=UWXxaLHFxnrMjLGcQlf96C64rHuTjx0dRzZhfIi4iZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7gey6AsKUv3rdFlpc7ny6OhsyCjGUGmXnRNOPR/SHajR7SIyc1zvFvREFLyavq+Y0UDFoHj8qdjaLjGYO81FTM+N1IXn/Qbyp+KfS+LJxG3bZOelZ87xTHGcTLe7NvBtIQ4TFdps6A0PdZFQJJMRVfVXoB7MSaN/I5s/IIT4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876B9339;
	Wed, 11 Feb 2026 07:35:06 -0800 (PST)
Received: from [10.57.53.64] (unknown [10.57.53.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867543F63F;
	Wed, 11 Feb 2026 07:35:11 -0800 (PST)
Message-ID: <88647103-55cd-4531-b96f-e0db5cbb288a@arm.com>
Date: Wed, 11 Feb 2026 15:35:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Rate-limit WARN in iommu_dma_unmap_phys()
To: Breno Leitao <leitao@debian.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 ttoukan.linux@gmail.com, netdev@vger.kernel.org, kbusch@kernel.org
References: <20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258301-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4822C125B92
X-Rspamd-Action: no action

On 2026-02-11 3:13 pm, Breno Leitao wrote:
> When a PCI error (e.g. AER error or DPC containment) marks the PCI
> channel as frozen or permanently failed, the IOMMU mappings for the
> device may already be torn down. If a driver continues processing
> completions in this state, every call to dma_unmap_page() triggers a
> WARN_ON in iommu_dma_unmap_phys().

That is definitely a major bug in the caller that needs fixing rather 
than papering over. You're lucky you do have an IOMMU that needs a valid 
mapping before it can get as far as the "corrupting memory" part of 
dma_unmap_phys() being called inappropriately.

Thanks,
Robin.

> In a real-world crash scenario on an NVIDIA Grace (ARM64) platform, a
> DPC event froze the PCI channel and the mlx5 NAPI poll continued
> processing error CQEs, calling dma_unmap for each pending WQE. With
> dozens of pending WQEs, the resulting WARN_ON storm monopolized the CPU
> in softirq context for over 23 seconds, triggering a soft lockup panic.
> 
> Replace WARN_ON(!phys) with WARN_RATELIMIT() to cap the warning output
> at the kernel's default rate limit (10 messages per 5 seconds), while
> still providing visibility into the failure with the device name in the
> message.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> ---
> I initially attempted to fix this in the driver itself, but that approach
> doesn't appear to be optimal, given the mappings can go away at any
> time, which is impossible to check at any time. Please see the discussion at:
> 
> https://lore.kernel.org/all/20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org/
> ---
>   drivers/iommu/dma-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c92088855450a..3cb5948eafe86 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1239,7 +1239,8 @@ void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
>   	}
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> -	if (WARN_ON(!phys))
> +	if (WARN_RATELIMIT(!phys, "iova_to_phys translation failed for dev %s\n",
> +			   dev_name(dev)))
>   		return;
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
> 
> ---
> base-commit: f884ff9142ee4b741a88030d77feede84f51fd4f
> change-id: 20260211-dma_io_mmu-519b73988134
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
> 


