Return-Path: <netdev+bounces-234147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07CC1D36A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0545B1890CCD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18241311C21;
	Wed, 29 Oct 2025 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eqK8PpQV"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03052314B7D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770053; cv=none; b=O6vEyk2kqJQ8Gxp0RYJdvP47ZBrGLV90oQ8ok3hIT0R0X8MhAqszc4Lor/NYBM/Kgq0kOnYzFGdf2ord7jQcfc8JXyKrLCS5NGjWawVq9hv37ZJ7Un4ojbo/UAJ8jhzLKg/2v6w8M+WOV5wco1sqI9YW2TvvwrrD5W5Eto1PEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770053; c=relaxed/simple;
	bh=f4BgwcQbfSKq6anpK4XuvXsMkFdycBzStXXczZDDPlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6MvSOlal9HaW5TrBqViza6CCK44HytS7gE9nxosgG2tL0mkS5NL9z8i4nmrZitIhHNRYZtzggSU2G1rr9rix2xnPY+AshmrEVEm4GKSmnbUcaYysQm0IL/YuDLnCKhy9/+EAceYJHDffrueIsNWxvsIAPF38/e4ZdILizeyj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eqK8PpQV; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03fa25f0-b7f5-4b3e-8a93-0637d0222719@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761770038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2k0g02pMCf4/8FiMhdYemYEY3w1Y1j1mpeO8X6WI3F8=;
	b=eqK8PpQVhB45TQ+e9goYGAPAg0O2Dp06e6a1Qy0SoalbGt2/CB4bHuWi9DNZmYphHq5OsB
	CRFgUrQja5ezsp4/USWxeyJSdcFXjFc/PnpUdXp7sr/7dZJ+a5JgQ5iQ3UFdcn1W1qf3MP
	7KHJ40xm9nGAtKsecbRfiSgdOH592uw=
Date: Wed, 29 Oct 2025 20:33:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: Allow exposing cycles only for clocks with
 free-running counter
To: Carolina Jubran <cjubran@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20251029083813.2276997-1-cjubran@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251029083813.2276997-1-cjubran@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2025 08:38, Carolina Jubran wrote:
> The PTP core falls back to gettimex64 and getcrosststamp when
> getcycles64 or getcyclesx64 are not implemented. This causes the CYCLES
> ioctls to retrieve PHC real time instead of free-running cycles.
> 
> Reject PTP_SYS_OFFSET_{PRECISE,EXTENDED}_CYCLES for clocks without
> free-running counter support since the result would represent PHC real
> time and system time rather than cycles and system time.
> 
> Fixes: faf23f54d366 ("ptp: Add ioctl commands to expose raw cycle counter values")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/ptp/ptp_chardev.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 8106eb617c8c..c61cf9edac48 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -561,10 +561,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   		return ptp_mask_en_single(pccontext->private_clkdata, argptr);
>   
>   	case PTP_SYS_OFFSET_PRECISE_CYCLES:
> +		if (!ptp->has_cycles)
> +			return -EOPNOTSUPP;
>   		return ptp_sys_offset_precise(ptp, argptr,
>   					      ptp->info->getcrosscycles);
>   
>   	case PTP_SYS_OFFSET_EXTENDED_CYCLES:
> +		if (!ptp->has_cycles)
> +			return -EOPNOTSUPP;
>   		return ptp_sys_offset_extended(ptp, argptr,
>   					       ptp->info->getcyclesx64);
>   	default:

Fair point.
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

