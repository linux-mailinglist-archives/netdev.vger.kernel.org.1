Return-Path: <netdev+bounces-138169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0609AC7BE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187781F26B04
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784E1AB515;
	Wed, 23 Oct 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="POCLNRf+"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF01AB530
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678965; cv=none; b=gQ4TbYzZbcQWCazOqhZwJHBUwRPfheMBupfs0epV4VrcXsH2l+KfZjDU/ssMSVtU2PuvWTWe/fyc7J7DntFs7eVlPnmLlpCPAAbQi2HvssKnNgGsQJjLN1ODDLCIMPOPlsU1Sx0CUvu+tQaAVYMxn/ssw3f+JxvnH/UR93wZxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678965; c=relaxed/simple;
	bh=2mcs0IKbxNJT5BlNCYB0HknWRyTSmQEZnBQOkwEAxu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZFQzIBC3yNZeH4Uno9dtGMbUHuUG+m8bktrEfrTtzo083knzK92BI4eJupPAauLecKLGsBrb8x/+EhwJaiuPWw3+kPpx6GrQoAAY8sU0W+8ufBHfmBW3Li/k/xw6K1lp+aC0Er2TxOwf6k8crj61xYOetOwDSOKUEnXvPZozqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=POCLNRf+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3fe8183a-08d3-47d3-b1a1-0d84f7bf58b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729678960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn+zF09KPNYa3iXtf4zTqB+9MiKB/XGy0KKTzUMaa8M=;
	b=POCLNRf+fxsROF6+a4fgY3UQqUVnbn0P73g/39VpVcNVfPXWKpOaFFgJbCJ09td4dWQujb
	1PdGR2v7QmYvwFOr+jhWtpG/o+n8q38oyakHvAQJUX3J/piYXxeKL2HnIcsVpBCMIzaf53
	PGo1gPjySqNn8jxyt79IeprT7Vhs5AI=
Date: Wed, 23 Oct 2024 11:22:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ti: iccsg-prueth: Fix 1 PPS sync
To: Meghana Malladi <m-malladi@ti.com>, vigneshr@ti.com, horms@kernel.org,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
References: <20241023091213.593351-1-m-malladi@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241023091213.593351-1-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/10/2024 10:12, Meghana Malladi wrote:
> The first PPS latch time needs to be calculated by the driver
> (in rounded off seconds) and configured as the start time
> offset for the cycle. After synchronizing two PTP clocks
> running as master/slave, missing this would cause master
> and slave to start immediately with some milliseconds
> drift which causes the PPS signal to never synchronize with
> the PTP master.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 12 ++++++++++--
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h | 11 +++++++++++
>   2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 0556910938fa..6b2cd7c898d0 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -411,6 +411,8 @@ static int prueth_perout_enable(void *clockops_data,
>   	struct prueth_emac *emac = clockops_data;
>   	u32 reduction_factor = 0, offset = 0;
>   	struct timespec64 ts;
> +	u64 current_cycle;
> +	u64 start_offset;
>   	u64 ns_period;
>   
>   	if (!on)
> @@ -449,8 +451,14 @@ static int prueth_perout_enable(void *clockops_data,
>   	writel(reduction_factor, emac->prueth->shram.va +
>   		TIMESYNC_FW_WC_SYNCOUT_REDUCTION_FACTOR_OFFSET);
>   
> -	writel(0, emac->prueth->shram.va +
> -		TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
> +	current_cycle = icssg_readq(emac->prueth->shram.va +
> +				    TIMESYNC_FW_WC_CYCLECOUNT_OFFSET);
> +
> +	/* Rounding of current_cycle count to next second */
> +	start_offset = ((current_cycle / MSEC_PER_SEC) + 1) * MSEC_PER_SEC;

This looks more like roundup(current_cycle, MSEC_PER_SEC), let's use it
instead of open coding.

> +
> +	icssg_writeq(start_offset, emac->prueth->shram.va +
> +		     TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
>   
>   	return 0;
>   }
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 8722bb4a268a..a4af2dbcca31 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -330,6 +330,17 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
>   extern const struct ethtool_ops icssg_ethtool_ops;
>   extern const struct dev_pm_ops prueth_dev_pm_ops;
>   
> +static inline u64 icssg_readq(const void __iomem *addr)
> +{
> +	return readl(addr) + ((u64)readl(addr + 4) << 32);
> +}
> +
> +static inline void icssg_writeq(u64 val, void __iomem *addr)
> +{
> +	writel(lower_32_bits(val), addr);
> +	writel(upper_32_bits(val), addr + 4);
> +}
> +
>   /* Classifier helpers */
>   void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
>   void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
> 
> base-commit: 73840ca5ef361f143b89edd5368a1aa8c2979241


