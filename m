Return-Path: <netdev+bounces-138625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BC9AE5DB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4FA2877E8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3B1DE88A;
	Thu, 24 Oct 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJI5zCBm"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45A1DD0DF;
	Thu, 24 Oct 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775800; cv=none; b=qthENILp5SkhvYl//kDx66zOFj1gJlipWK6QYRpt7GRf3V4x3X6vq0Jlux7lZsb+iGHDW3PMK6WJhrNdiIt5A1KdTRJByqMzmuKIqwVBoryPa3dimjKzmSlg6G+9FkXhQRY6gkCzGcznhsfbNAM84/4pJzGchxZnRMJ5DM7VENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775800; c=relaxed/simple;
	bh=q9uxznKnQY4XK6iA2VnlvWjgWTCmgLuEF/MdAC17O88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTuza0EGhgQsHkNpM124Rto7bh47eYO5FNToKqmuMMDVgKmAe/DMfxaKjTiKp9L4k20bmPXX3sc5YbiR7OgCApCV2id9Dzq9jjuTUSjed4D1ycwc5Ti6N4ffrgJ9HfccxPJXPMRBdEgrTEEz5f5cbOMWPXOFfpjBPS9U/VpKrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJI5zCBm; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff454a9b-5e60-49cb-8590-a2535f851057@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729775795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYx7LAyRV3Ucr0XiBCFOAYtv8t2YgLt+/TvO8hjpNtU=;
	b=IJI5zCBmkMWuSlAC6vNeUKZ/x0HqRyeKkaCRuPkB1OLmXKmyDkre5tUfruHXq1gNMlp7sa
	wAdbkUxXhNgkeBwbbk+ggdjpGjJOe2qPZyFLhIyXnkhY27YXJQ7do5bCWB6f2s/fnsAEEL
	1qpWsIUKTCgqoyPDfwoaovUS3LL604M=
Date: Thu, 24 Oct 2024 14:16:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix 1 PPS sync
To: Meghana Malladi <m-malladi@ti.com>, vigneshr@ti.com, horms@kernel.org,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
References: <20241024113140.973928-1-m-malladi@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241024113140.973928-1-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/10/2024 12:31, Meghana Malladi wrote:
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
> 
> Hello,
> 
> This patch is based on net-next tagged next-20241023.
> v1:https://lore.kernel.org/all/20241023091213.593351-1-m-malladi@ti.com/
> Changes since v1 (v2-v1):
> - Use roundup() instead of open coding as suggested by Vadim Fedorenko
> 
> Regards,
> Meghana.
> 
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 12 ++++++++++--
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h | 11 +++++++++++
>   2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 0556910938fa..6876e8181066 100644
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
> +	start_offset = roundup(current_cycle, MSEC_PER_SEC);
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

Thanks,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

