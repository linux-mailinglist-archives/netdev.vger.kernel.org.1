Return-Path: <netdev+bounces-200031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478AEAE2C35
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA341895C7F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3F26FA60;
	Sat, 21 Jun 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZH6wd1XI"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB11F5E6
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750537395; cv=none; b=AKhxejpe72oQ75uK8iT8u707kovqW16XwAzcVNE9JOcMYuMtKsPMGr0WqOHWVzKqvzMwrKzu6iXuIGmuaNN1zNdH8OW3Ibp4eyoXXKLtTWAbre5qXP3nXBT7iF+b2uyj10UJz2jWLNqnZjnfBjpfkqf6D0WJwf8gYErzdPP1TZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750537395; c=relaxed/simple;
	bh=u3OUKEzKT6AsnY3b5/4jcuXGRA/3vmHPCzxG1zfNk6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWqJvlaPjaPv4XtkWXyU1nZBW8wkcquztauafBmp+xLSRMDyQRku0SlcuLhiv0edK+tWSFJ7lqGHPH8ZIiANGZINQOFz0MR4NY4YJN+paKXCiipkkSCLm2SUObskL0iSMnTSzVBceLY+BXLRSlcqGAPCAZ0/LZDiDCkgEQT8pO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZH6wd1XI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fde40e1e-5950-441c-a5c0-fbe25e0bb918@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750537390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNxAdA3B5Hr3ZTYiXMZqyMBI4q1hXrsEpVt1ACDknIo=;
	b=ZH6wd1XIAF/e0IVsqANDXugQeCBCKvU4a8Pnf2ES2BN0gsSxKifTT1r1PV1sHA/ip1rb3l
	3GCKf8itYANMH/BUuRwlSAVMCyuadOpk9TpsDnIzKN0jeUFNbJMNqmp9FMSKihC8erpwcb
	/TpfzFnV6KkrnEHi6eP/etXg5gJObm0=
Date: Sat, 21 Jun 2025 21:22:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 01/13] ptp: Split out PTP_CLOCK_GETCAPS ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131943.779603403@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250620131943.779603403@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/06/2025 14:24, Thomas Gleixner wrote:
> ptp_ioctl() is an inpenetrable letter soup with a gazillion of case (scope)
> specific variables defined at the top of the function and pointless breaks
> and gotos.
> 
> Start cleaning it up by splitting out the PTP_CLOCK_GETCAPS ioctl code into
> a helper function. Use a argument pointer with a single sparse compliant
> type cast instead of proliferating the type cast all over the place.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |   41 +++++++++++++++++++++++------------------
>   1 file changed, 23 insertions(+), 18 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -157,6 +157,26 @@ int ptp_release(struct posix_clock_conte
>   	return 0;
>   }
>   
> +static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
> +{
> +	struct ptp_clock_caps caps = {
> +		.max_adj		= ptp->info->max_adj,
> +		.n_alarm		= ptp->info->n_alarm,
> +		.n_ext_ts		= ptp->info->n_ext_ts,
> +		.n_per_out		= ptp->info->n_per_out,
> +		.pps			= ptp->info->pps,
> +		.n_pins			= ptp->info->n_pins,
> +		.cross_timestamping	= ptp->info->getcrosststamp != NULL,
> +		.adjust_phase		= ptp->info->adjphase != NULL &&
> +					  ptp->info->getmaxphase != NULL,
> +	};
> +
> +	if (caps.adjust_phase)
> +		caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
> +
> +	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
> +}
> +
>   long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	       unsigned long arg)
>   {
> @@ -171,37 +191,22 @@ long ptp_ioctl(struct posix_clock_contex
>   	struct timestamp_event_queue *tsevq;
>   	struct ptp_system_timestamp sts;
>   	struct ptp_clock_request req;
> -	struct ptp_clock_caps caps;
>   	struct ptp_clock_time *pct;
>   	struct ptp_pin_desc pd;
>   	struct timespec64 ts;
>   	int enable, err = 0;
> +	void __user *argptr;
>   
>   	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
>   		arg = (unsigned long)compat_ptr(arg);
> +	argptr = (void __force __user *)arg;
>   
>   	tsevq = pccontext->private_clkdata;
>   
>   	switch (cmd) {
> -
>   	case PTP_CLOCK_GETCAPS:
>   	case PTP_CLOCK_GETCAPS2:
> -		memset(&caps, 0, sizeof(caps));
> -
> -		caps.max_adj = ptp->info->max_adj;
> -		caps.n_alarm = ptp->info->n_alarm;
> -		caps.n_ext_ts = ptp->info->n_ext_ts;
> -		caps.n_per_out = ptp->info->n_per_out;
> -		caps.pps = ptp->info->pps;
> -		caps.n_pins = ptp->info->n_pins;
> -		caps.cross_timestamping = ptp->info->getcrosststamp != NULL;
> -		caps.adjust_phase = ptp->info->adjphase != NULL &&
> -				    ptp->info->getmaxphase != NULL;
> -		if (caps.adjust_phase)
> -			caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
> -		if (copy_to_user((void __user *)arg, &caps, sizeof(caps)))
> -			err = -EFAULT;
> -		break;
> +		return ptp_clock_getcaps(ptp, argptr);
>   
>   	case PTP_EXTTS_REQUEST:
>   	case PTP_EXTTS_REQUEST2:
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

