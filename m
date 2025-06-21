Return-Path: <netdev+bounces-200035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5CAE2C3E
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699DF3B42DC
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD127056D;
	Sat, 21 Jun 2025 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IsWHvcCv"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D021CA14
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750537671; cv=none; b=WyAStKjmiaLNxobseM9gGLRUHwA86BiQj7lWekxkmst0ddLIpJMia9CBWIzC6tfwQUSj/xaTSs/iYMXY5aINdLBLirxjepumJsC8BpzC5tbVybsK7l/Xt4LwcUe58neEk0lW07B3SUEyIw7SOrucbBSHD4e78LQhjipODTHRQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750537671; c=relaxed/simple;
	bh=kGbP5HTZuj+YXjGxt2UBm6owXLQGpJtrJpeEg9uunP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flmEu8QcZtAGPhgoJ4FtsYJMfUzV7eifwPFcj+1LxVzajZXQkEUlb9VAfHn4iT6cUYoc0iafYPMpPog3CqVHSXjSZu3RIO5X6vYl8A8orO/YG5h4OSbstZgT2W94gzgl9AE9umOAgepNCrGepXE4t0GQ+wnk0ofjlxpr1a6DuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IsWHvcCv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e90368f-f154-4be8-8dfe-f30fb33e980b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750537666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giFL6B520wt/7GcRxZUtOhWFMqcuL5POaKOJmZjaq1I=;
	b=IsWHvcCvdEJH8VOzpzn78uFQnLGuM9zZ06zXFVy9TRJmZ/GK9ZNrcWRRfw2t5Ylkxcb41D
	7OWfmF5GhTllEqZyZr7vS4F3o03gqy6SBRKy4ss+tWB0ssWc+A+wXAn10zbMpbxoiS5RNE
	hVR4rZtS0NM+mmx94s3hbKOTRSY3/xk=
Date: Sat, 21 Jun 2025 21:27:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 05/13] ptp: Split out PTP_SYS_OFFSET_PRECISE ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.029142425@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250620131944.029142425@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/06/2025 14:24, Thomas Gleixner wrote:
> Continue the ptp_ioctl() cleanup by splitting out the PTP_SYS_OFFSET_PRECISE
> ioctl code into a helper function.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |   53 +++++++++++++++++++++++++---------------------
>   1 file changed, 29 insertions(+), 24 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -291,14 +291,40 @@ static long ptp_enable_pps(struct ptp_cl
>   		return ops->enable(ops, &req, enable);
>   }
>   
> +static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg)
> +{
> +	struct ptp_sys_offset_precise precise_offset;
> +	struct system_device_crosststamp xtstamp;
> +	struct timespec64 ts;
> +	int err;
> +
> +	if (!ptp->info->getcrosststamp)
> +		return -EOPNOTSUPP;
> +
> +	err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
> +	if (err)
> +		return err;
> +
> +	memset(&precise_offset, 0, sizeof(precise_offset));
> +	ts = ktime_to_timespec64(xtstamp.device);
> +	precise_offset.device.sec = ts.tv_sec;
> +	precise_offset.device.nsec = ts.tv_nsec;
> +	ts = ktime_to_timespec64(xtstamp.sys_realtime);
> +	precise_offset.sys_realtime.sec = ts.tv_sec;
> +	precise_offset.sys_realtime.nsec = ts.tv_nsec;
> +	ts = ktime_to_timespec64(xtstamp.sys_monoraw);
> +	precise_offset.sys_monoraw.sec = ts.tv_sec;
> +	precise_offset.sys_monoraw.nsec = ts.tv_nsec;
> +
> +	return copy_to_user(arg, &precise_offset, sizeof(precise_offset)) ? -EFAULT : 0;
> +}
> +
>   long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	       unsigned long arg)
>   {
>   	struct ptp_clock *ptp =
>   		container_of(pccontext->clk, struct ptp_clock, clock);
>   	struct ptp_sys_offset_extended *extoff = NULL;
> -	struct ptp_sys_offset_precise precise_offset;
> -	struct system_device_crosststamp xtstamp;
>   	struct ptp_clock_info *ops = ptp->info;
>   	struct ptp_sys_offset *sysoff = NULL;
>   	struct timestamp_event_queue *tsevq;
> @@ -341,28 +367,7 @@ long ptp_ioctl(struct posix_clock_contex
>   
>   	case PTP_SYS_OFFSET_PRECISE:
>   	case PTP_SYS_OFFSET_PRECISE2:
> -		if (!ptp->info->getcrosststamp) {
> -			err = -EOPNOTSUPP;
> -			break;
> -		}
> -		err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
> -		if (err)
> -			break;
> -
> -		memset(&precise_offset, 0, sizeof(precise_offset));
> -		ts = ktime_to_timespec64(xtstamp.device);
> -		precise_offset.device.sec = ts.tv_sec;
> -		precise_offset.device.nsec = ts.tv_nsec;
> -		ts = ktime_to_timespec64(xtstamp.sys_realtime);
> -		precise_offset.sys_realtime.sec = ts.tv_sec;
> -		precise_offset.sys_realtime.nsec = ts.tv_nsec;
> -		ts = ktime_to_timespec64(xtstamp.sys_monoraw);
> -		precise_offset.sys_monoraw.sec = ts.tv_sec;
> -		precise_offset.sys_monoraw.nsec = ts.tv_nsec;
> -		if (copy_to_user((void __user *)arg, &precise_offset,
> -				 sizeof(precise_offset)))
> -			err = -EFAULT;
> -		break;
> +		return ptp_sys_offset_precise(ptp, argptr);
>   
>   	case PTP_SYS_OFFSET_EXTENDED:
>   	case PTP_SYS_OFFSET_EXTENDED2:
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

