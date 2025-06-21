Return-Path: <netdev+bounces-200037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54346AE2C42
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB3C16B422
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0D26FDA3;
	Sat, 21 Jun 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eDlPqUYQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5371E487
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750537799; cv=none; b=PvWGjBziUBuqN93if9iDnz7rPzTywGtQ7XgrXsLM4oyCIYAnyrxddMUSrDzi/zBlLvOe3arYlanhYThtODsHUasjvHFUsIc41FhWDAF4F8JevQIlEH5gSUC4Rc5tk/mkIlMHX7Yw8xfpoEw8KE9tEbgs7NdVXAa/Xlhgz1lZvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750537799; c=relaxed/simple;
	bh=xePuLEyk0NjQMZfHBU8NlfM+NqappG0KcrsNU51lcf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iasa7c8JT1ws5ca4y2acul/juC4AT5NJ5HR6YLX40RH2CaDyczuRvTZ+g+C/e10LT2Je5hTaR51AfwIuOVW5TIZVm/C6wOd/IdAZ8pIr/cO4gfdNGAlLIbThQgTvC17cC7ExKrSIl1Cjl911gTgPudYFRuEB+INIXFv+pIqXInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eDlPqUYQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54771279-ddc6-431d-942a-cc86358f9d2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750537796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3PmuBMPugCbxMh8aXAiGyluCw5Tp3tBqwd4GASTxto=;
	b=eDlPqUYQvjTWOUSHJmISXyFKPPXEC+sCL4Zi00uB/se4Bca88nAkLUcntxHRfMqB2Ss3Zt
	TXT2KDFGiZHdl4iGQjzyCbMmTCCFvlc8pyqzvPg2FN5H/n00BQjp/QAXbymYDf8L83TOSk
	rnrKghpgDftgcwTiISIWw99uytSVpkk=
Date: Sat, 21 Jun 2025 21:29:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.218487429@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250620131944.218487429@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/06/2025 14:24, Thomas Gleixner wrote:
> Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_GETFUNC ioctl
> code into a helper function. Convert to lock guard while at it.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |   52 ++++++++++++++++++++--------------------------
>   1 file changed, 23 insertions(+), 29 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -396,6 +396,28 @@ static long ptp_sys_offset(struct ptp_cl
>   	return copy_to_user(arg, sysoff, sizeof(*sysoff)) ? -EFAULT : 0;
>   }
>   
> +static long ptp_pin_getfunc(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
> +{
> +	struct ptp_clock_info *ops = ptp->info;
> +	struct ptp_pin_desc pd;
> +
> +	if (copy_from_user(&pd, arg, sizeof(pd)))
> +		return -EFAULT;
> +
> +	if (cmd == PTP_PIN_GETFUNC2 && !mem_is_zero(pd.rsv, sizeof(pd.rsv)))
> +		return -EINVAL;
> +	else
> +		memset(pd.rsv, 0, sizeof(pd.rsv));
> +
> +	if (pd.index >= ops->n_pins)
> +		return -EINVAL;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
> +		pd = ops->pin_config[array_index_nospec(pd.index, ops->n_pins)];
> +
> +	return copy_to_user(arg, &pd, sizeof(pd)) ? -EFAULT : 0;
> +}
> +
>   long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	       unsigned long arg)
>   {
> @@ -451,35 +473,7 @@ long ptp_ioctl(struct posix_clock_contex
>   
>   	case PTP_PIN_GETFUNC:
>   	case PTP_PIN_GETFUNC2:
> -		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
> -			err = -EFAULT;
> -			break;
> -		}
> -		if ((pd.rsv[0] || pd.rsv[1] || pd.rsv[2]
> -				|| pd.rsv[3] || pd.rsv[4])
> -			&& cmd == PTP_PIN_GETFUNC2) {
> -			err = -EINVAL;
> -			break;
> -		} else if (cmd == PTP_PIN_GETFUNC) {
> -			pd.rsv[0] = 0;
> -			pd.rsv[1] = 0;
> -			pd.rsv[2] = 0;
> -			pd.rsv[3] = 0;
> -			pd.rsv[4] = 0;
> -		}
> -		pin_index = pd.index;
> -		if (pin_index >= ops->n_pins) {
> -			err = -EINVAL;
> -			break;
> -		}
> -		pin_index = array_index_nospec(pin_index, ops->n_pins);
> -		if (mutex_lock_interruptible(&ptp->pincfg_mux))
> -			return -ERESTARTSYS;
> -		pd = ops->pin_config[pin_index];
> -		mutex_unlock(&ptp->pincfg_mux);
> -		if (!err && copy_to_user((void __user *)arg, &pd, sizeof(pd)))
> -			err = -EFAULT;
> -		break;
> +		return ptp_pin_getfunc(ptp, cmd, argptr);
>   
>   	case PTP_PIN_SETFUNC:
>   	case PTP_PIN_SETFUNC2:
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

