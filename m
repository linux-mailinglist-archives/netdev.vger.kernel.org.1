Return-Path: <netdev+bounces-237992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A98C5280D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEDF54F9710
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA5338586;
	Wed, 12 Nov 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lyFdnc8L"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429D302165
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954192; cv=none; b=a594aKpYAkTimwFpIPIYhEp0bGz1WYBS5cEDKk+G/W0Ut33nt2llgeqrT3k0NHPqNzxIK5UsOCq5q4DHpu9QeIxm7VR3e+HUDi/vVGSCTgLDeKm1ZHbSYUCPX26s1VSB/5BdLGKNJLg5lcTzMEboPNlrtjHnpk3R+QP2rhd3CUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954192; c=relaxed/simple;
	bh=cFDLz+H6jgprUwiaJKuznGYcbz9JNDbR/NwTpcCUNwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNHDi9YbNbTRgaHMyyVijMTvvssEspEZ8ddSzaudIpV355uQY7PjLowXa79a2b/nmuNOQzY8NAWn9e5l3TtmEnRrMRnEH9Q5uHlruv2oi1yF2AEt3GfTQyxG340Gq9Dqre1F/5ovFlT2nTjyW/C6YGHoDIm/TTEbb7JXQ0YYIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lyFdnc8L; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2aae49d-a8f9-4893-a1b6-224fed2afdb5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762954177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RSSglgRhT7StgwYdiewsW78Pog2Jcy1C6j1GJAvawQ=;
	b=lyFdnc8LHt4mbN1nEKkHnZ/O/bYB+Hf4Jq5zJjU2AliAqGvXrgl1cgLjj+RjkCMraBAvTE
	RwpuBENkEaDqQKZCOTCTWL3jYpUNWS7GIZ7nTk9sLXnR8H2a+NWfzAG0CQnJnnnKfhLaHN
	8009muDUAshVY+NujOgIIbciFZF/J9s=
Date: Wed, 12 Nov 2025 13:29:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 1/7] ptp: ocp: Refactor signal_show() and fix
 %ptT misuse
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
 <20251111165232.1198222-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111165232.1198222-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 16:52, Andy Shevchenko wrote:
> Refactor signal_show() to avoid sequential calls to sysfs_emit*()
> and use the same pattern to get the index of a signal as it's done
> in signal_store().
> 
> While at it, fix wrong use of %ptT against struct timespec64.
> It's kinda lucky that it worked just because the first member
> there 64-bit and it's of time64_t type. Now with %ptS it may
> be used correctly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index eeebe4d149f7..95889f85ffb2 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3250,20 +3250,16 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	struct dev_ext_attribute *ea = to_ext_attr(attr);
>   	struct ptp_ocp *bp = dev_get_drvdata(dev);
>   	struct ptp_ocp_signal *signal;
> +	int gen = (uintptr_t)ea->var;
>   	struct timespec64 ts;
> -	ssize_t count;
> -	int i;
>   
> -	i = (uintptr_t)ea->var;
> -	signal = &bp->signal[i];
> -
> -	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
> -			   signal->duty, signal->phase, signal->polarity);
> +	signal = &bp->signal[gen];
>   
>   	ts = ktime_to_timespec64(signal->start);
> -	count += sysfs_emit_at(buf, count, " %ptT TAI\n", &ts);
>   
> -	return count;
> +	return sysfs_emit(buf, "%llu %d %llu %d %ptT TAI\n",
> +			  signal->period, signal->duty, signal->phase, signal->polarity,
> +			  &ts.tv_sec);
>   }
>   static EXT_ATTR_RW(signal, signal, 0);
>   static EXT_ATTR_RW(signal, signal, 1);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

