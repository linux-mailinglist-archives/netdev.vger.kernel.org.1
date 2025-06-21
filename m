Return-Path: <netdev+bounces-200032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC986AE2C37
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4151918961B2
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515926FDA3;
	Sat, 21 Jun 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G2eRP7JP"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95B211F
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750537464; cv=none; b=s0P7HibopA8ivNV1HJQ0b6zJi2BFPeqPiPVwkTH4z01dc8GroJSmYGzJZnnlM3niyhAJjy0p+uF2vCd82opHbWijzubCqLIMjCy5s6o629QkT5FgcJe2dFjdg1zsPnA5BWc44BKjO+TDxfvVfbAU+2tukY7rCyqCGBPx3rcn8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750537464; c=relaxed/simple;
	bh=n3DMnTpeOxFxPO+8l2MN0v354Z3Bkvvnw2IlSJIWSR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHgWiq3mobM8++rbFP5edP9wh4QVnQ4ypfSVfWMvj7Z2uU2B0yWQxgvW/Bjhh8ub8oct03N8jgFNkA+rTzxVdML0J4UbDMrxZJE9cPHv1zDSV1rICmECGPBqOVgYMShCzcWuQ2cVG63XSpQqW3LO3h6bg0QEFMYYar30p23sxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G2eRP7JP; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ccc601ef-4ee7-4f72-b2d8-64155d1bd324@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750537459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHucDhjqbAmIQzt9usEBV1YDpxHxfnFoUHYSly8jwes=;
	b=G2eRP7JPZtceBgI/gJzIh2ExGil/XEizZCAm5QYBT6cR3zLNuA/z1pjCwid0uqIwe4XpGQ
	FWZTQvPn/nejmhScZ1TsufP5DIp24K3x3eN4We+ljyK3e1y+1FchM+5YS81AdzS3KUaQoL
	lzKLvOD6RY5IiwgR83AczDQVuh+t8Z0=
Date: Sat, 21 Jun 2025 21:24:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 02/13] ptp: Split out PTP_EXTTS_REQUEST ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131943.842871495@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250620131943.842871495@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/06/2025 14:24, Thomas Gleixner wrote:
> Continue the ptp_ioctl() cleanup by splitting out the PTP_EXTTS_REQUEST
> ioctl code into a helper function. Convert to a lock guard while at it.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |  105 +++++++++++++++++++++-------------------------
>   1 file changed, 50 insertions(+), 55 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -177,12 +177,57 @@ static long ptp_clock_getcaps(struct ptp
>   	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
>   }
>   
> +static long ptp_extts_request(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
> +{
> +	struct ptp_clock_request req = { .type = PTP_CLK_REQ_EXTTS };
> +	struct ptp_clock_info *ops = ptp->info;
> +	unsigned int supported_extts_flags;
> +
> +	if (copy_from_user(&req.extts, arg, sizeof(req.extts)))
> +		return -EFAULT;
> +
> +	if (cmd == PTP_EXTTS_REQUEST2) {
> +		/* Tell the drivers to check the flags carefully. */
> +		req.extts.flags |= PTP_STRICT_FLAGS;
> +		/* Make sure no reserved bit is set. */
> +		if ((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
> +		    req.extts.rsv[0] || req.extts.rsv[1])
> +			return -EINVAL;
> +
> +		/* Ensure one of the rising/falling edge bits is set. */
> +		if ((req.extts.flags & PTP_ENABLE_FEATURE) &&
> +		    (req.extts.flags & PTP_EXTTS_EDGES) == 0)
> +			return -EINVAL;
> +	} else {
> +		req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
> +		memset(req.extts.rsv, 0, sizeof(req.extts.rsv));
> +	}
> +
> +	if (req.extts.index >= ops->n_ext_ts)
> +		return -EINVAL;
> +
> +	supported_extts_flags = ptp->info->supported_extts_flags;
> +	/* The PTP_ENABLE_FEATURE flag is always supported. */
> +	supported_extts_flags |= PTP_ENABLE_FEATURE;
> +	/* If the driver does not support strictly checking flags, the
> +	 * PTP_RISING_EDGE and PTP_FALLING_EDGE flags are merely hints
> +	 * which are not enforced.
> +	 */
> +	if (!(supported_extts_flags & PTP_STRICT_FLAGS))
> +		supported_extts_flags |= PTP_EXTTS_EDGES;
> +	/* Reject unsupported flags */
> +	if (req.extts.flags & ~supported_extts_flags)
> +		return -EOPNOTSUPP;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
> +		return ops->enable(ops, &req, req.extts.flags & PTP_ENABLE_FEATURE ? 1 : 0);
> +}
> +
>   long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	       unsigned long arg)
>   {
>   	struct ptp_clock *ptp =
>   		container_of(pccontext->clk, struct ptp_clock, clock);
> -	unsigned int i, pin_index, supported_extts_flags;
>   	struct ptp_sys_offset_extended *extoff = NULL;
>   	struct ptp_sys_offset_precise precise_offset;
>   	struct system_device_crosststamp xtstamp;
> @@ -192,6 +237,7 @@ long ptp_ioctl(struct posix_clock_contex
>   	struct ptp_system_timestamp sts;
>   	struct ptp_clock_request req;
>   	struct ptp_clock_time *pct;
> +	unsigned int i, pin_index;
>   	struct ptp_pin_desc pd;
>   	struct timespec64 ts;
>   	int enable, err = 0;
> @@ -210,60 +256,9 @@ long ptp_ioctl(struct posix_clock_contex
>   
>   	case PTP_EXTTS_REQUEST:
>   	case PTP_EXTTS_REQUEST2:
> -		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
> -			err = -EACCES;
> -			break;
> -		}
> -		memset(&req, 0, sizeof(req));
> -
> -		if (copy_from_user(&req.extts, (void __user *)arg,
> -				   sizeof(req.extts))) {
> -			err = -EFAULT;
> -			break;
> -		}
> -		if (cmd == PTP_EXTTS_REQUEST2) {
> -			/* Tell the drivers to check the flags carefully. */
> -			req.extts.flags |= PTP_STRICT_FLAGS;
> -			/* Make sure no reserved bit is set. */
> -			if ((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
> -			    req.extts.rsv[0] || req.extts.rsv[1]) {
> -				err = -EINVAL;
> -				break;
> -			}
> -			/* Ensure one of the rising/falling edge bits is set. */
> -			if ((req.extts.flags & PTP_ENABLE_FEATURE) &&
> -			    (req.extts.flags & PTP_EXTTS_EDGES) == 0) {
> -				err = -EINVAL;
> -				break;
> -			}
> -		} else if (cmd == PTP_EXTTS_REQUEST) {
> -			req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
> -			req.extts.rsv[0] = 0;
> -			req.extts.rsv[1] = 0;
> -		}
> -		if (req.extts.index >= ops->n_ext_ts) {
> -			err = -EINVAL;
> -			break;
> -		}
> -		supported_extts_flags = ptp->info->supported_extts_flags;
> -		/* The PTP_ENABLE_FEATURE flag is always supported. */
> -		supported_extts_flags |= PTP_ENABLE_FEATURE;
> -		/* If the driver does not support strictly checking flags, the
> -		 * PTP_RISING_EDGE and PTP_FALLING_EDGE flags are merely
> -		 * hints which are not enforced.
> -		 */
> -		if (!(supported_extts_flags & PTP_STRICT_FLAGS))
> -			supported_extts_flags |= PTP_EXTTS_EDGES;
> -		/* Reject unsupported flags */
> -		if (req.extts.flags & ~supported_extts_flags)
> -			return -EOPNOTSUPP;
> -		req.type = PTP_CLK_REQ_EXTTS;
> -		enable = req.extts.flags & PTP_ENABLE_FEATURE ? 1 : 0;
> -		if (mutex_lock_interruptible(&ptp->pincfg_mux))
> -			return -ERESTARTSYS;
> -		err = ops->enable(ops, &req, enable);
> -		mutex_unlock(&ptp->pincfg_mux);
> -		break;
> +		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0)
> +			return -EACCES;
> +		return ptp_extts_request(ptp, cmd, argptr);
>   
>   	case PTP_PEROUT_REQUEST:
>   	case PTP_PEROUT_REQUEST2:
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

