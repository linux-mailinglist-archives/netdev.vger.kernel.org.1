Return-Path: <netdev+bounces-200033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B08FAE2C3A
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D63B9888
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBA26FD95;
	Sat, 21 Jun 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t4cKbNy4"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD3253F2C
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750537510; cv=none; b=IfSRidzbNjWV68yQaOSwUPkSD5SUSR8/FtBke99BCPTYfQQkr8BdSso3rIyZwVykI9Gn7fMSuUx412Prfet8NK3VvUqjoU5F7sNz2A6DuyGbeVnyw09/uyVciabr7m1sIBo9SLEx9SOioWHBec7wWAlMrZVVn9Ptd8BKQPIT+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750537510; c=relaxed/simple;
	bh=Hs73OMeA54qel9rX7pM0slV+VYdAq3yTVD0UBpiJMtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHa4FhxNYZQ197nRX88wiN7JRkn8vJfccjQi7+HDkJEplvpC0C8SA2N76jyM+0GqA1YpwKwMCh3Yim7wqvetK+w/Afj/+o+X/4CDDoa6dtKQ5uK/a5hKeN2G9nRIo36uz6yMbzW+c6t7nNKabGe4ps97bgOc0zIqymlaRiDDpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t4cKbNy4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <861942e6-d1e9-4e6a-8d4c-d8fa4584ed45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750537494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCpu3zZVtbUfg4KgBuBug2nmC/y5jdfXaJFDqT+pqV4=;
	b=t4cKbNy47/NNOiVxNMDExoy4pVQtXyGJIfkUby+hott78wEPvd4tH9hN/hp2VWJl9DIoJo
	bzcBZl1OnBRjEfHs4aQJRelOrVmm8pU2itUwLLL/C59gKReJqZiAOqmd795IxriwsPso0m
	DWOoDS5NlAwLbf5JIrkwHumhYKiVV0A=
Date: Sat, 21 Jun 2025 21:24:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 03/13] ptp: Split out PTP_PEROUT_REQUEST ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131943.905398183@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250620131943.905398183@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/06/2025 14:24, Thomas Gleixner wrote:
> Continue the ptp_ioctl() cleanup by splitting out the PTP_PEROUT_REQUEST
> ioctl code into a helper function. Convert to a lock guard while at it.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |  129 ++++++++++++++++++++--------------------------
>   1 file changed, 58 insertions(+), 71 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -223,6 +223,61 @@ static long ptp_extts_request(struct ptp
>   		return ops->enable(ops, &req, req.extts.flags & PTP_ENABLE_FEATURE ? 1 : 0);
>   }
>   
> +static long ptp_perout_request(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
> +{
> +	struct ptp_clock_request req = { .type = PTP_CLK_REQ_PEROUT };
> +	struct ptp_perout_request *perout = &req.perout;
> +	struct ptp_clock_info *ops = ptp->info;
> +
> +	if (copy_from_user(perout, arg, sizeof(*perout)))
> +		return -EFAULT;
> +
> +	if (cmd == PTP_PEROUT_REQUEST2) {
> +		if (perout->flags & ~PTP_PEROUT_VALID_FLAGS)
> +			return -EINVAL;
> +
> +		/*
> +		 * The "on" field has undefined meaning if
> +		 * PTP_PEROUT_DUTY_CYCLE isn't set, we must still treat it
> +		 * as reserved, which must be set to zero.
> +		 */
> +		if (!(perout->flags & PTP_PEROUT_DUTY_CYCLE) &&
> +		    !mem_is_zero(perout->rsv, sizeof(perout->rsv)))
> +			return -EINVAL;
> +
> +		if (perout->flags & PTP_PEROUT_DUTY_CYCLE) {
> +			/* The duty cycle must be subunitary. */
> +			if (perout->on.sec > perout->period.sec ||
> +			    (perout->on.sec == perout->period.sec &&
> +			     perout->on.nsec > perout->period.nsec))
> +				return -ERANGE;
> +		}
> +
> +		if (perout->flags & PTP_PEROUT_PHASE) {
> +			/*
> +			 * The phase should be specified modulo the period,
> +			 * therefore anything equal or larger than 1 period
> +			 * is invalid.
> +			 */
> +			if (perout->phase.sec > perout->period.sec ||
> +			    (perout->phase.sec == perout->period.sec &&
> +			     perout->phase.nsec >= perout->period.nsec))
> +				return -ERANGE;
> +		}
> +	} else {
> +		perout->flags &= PTP_PEROUT_V1_VALID_FLAGS;
> +		memset(perout->rsv, 0, sizeof(perout->rsv));
> +	}
> +
> +	if (perout->index >= ops->n_per_out)
> +		return -EINVAL;
> +	if (perout->flags & ~ops->supported_perout_flags)
> +		return -EOPNOTSUPP;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
> +		return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
> +}
> +
>   long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	       unsigned long arg)
>   {
> @@ -262,77 +317,9 @@ long ptp_ioctl(struct posix_clock_contex
>   
>   	case PTP_PEROUT_REQUEST:
>   	case PTP_PEROUT_REQUEST2:
> -		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
> -			err = -EACCES;
> -			break;
> -		}
> -		memset(&req, 0, sizeof(req));
> -
> -		if (copy_from_user(&req.perout, (void __user *)arg,
> -				   sizeof(req.perout))) {
> -			err = -EFAULT;
> -			break;
> -		}
> -		if (cmd == PTP_PEROUT_REQUEST2) {
> -			struct ptp_perout_request *perout = &req.perout;
> -
> -			if (perout->flags & ~PTP_PEROUT_VALID_FLAGS) {
> -				err = -EINVAL;
> -				break;
> -			}
> -			/*
> -			 * The "on" field has undefined meaning if
> -			 * PTP_PEROUT_DUTY_CYCLE isn't set, we must still treat
> -			 * it as reserved, which must be set to zero.
> -			 */
> -			if (!(perout->flags & PTP_PEROUT_DUTY_CYCLE) &&
> -			    (perout->rsv[0] || perout->rsv[1] ||
> -			     perout->rsv[2] || perout->rsv[3])) {
> -				err = -EINVAL;
> -				break;
> -			}
> -			if (perout->flags & PTP_PEROUT_DUTY_CYCLE) {
> -				/* The duty cycle must be subunitary. */
> -				if (perout->on.sec > perout->period.sec ||
> -				    (perout->on.sec == perout->period.sec &&
> -				     perout->on.nsec > perout->period.nsec)) {
> -					err = -ERANGE;
> -					break;
> -				}
> -			}
> -			if (perout->flags & PTP_PEROUT_PHASE) {
> -				/*
> -				 * The phase should be specified modulo the
> -				 * period, therefore anything equal or larger
> -				 * than 1 period is invalid.
> -				 */
> -				if (perout->phase.sec > perout->period.sec ||
> -				    (perout->phase.sec == perout->period.sec &&
> -				     perout->phase.nsec >= perout->period.nsec)) {
> -					err = -ERANGE;
> -					break;
> -				}
> -			}
> -		} else if (cmd == PTP_PEROUT_REQUEST) {
> -			req.perout.flags &= PTP_PEROUT_V1_VALID_FLAGS;
> -			req.perout.rsv[0] = 0;
> -			req.perout.rsv[1] = 0;
> -			req.perout.rsv[2] = 0;
> -			req.perout.rsv[3] = 0;
> -		}
> -		if (req.perout.index >= ops->n_per_out) {
> -			err = -EINVAL;
> -			break;
> -		}
> -		if (req.perout.flags & ~ptp->info->supported_perout_flags)
> -			return -EOPNOTSUPP;
> -		req.type = PTP_CLK_REQ_PEROUT;
> -		enable = req.perout.period.sec || req.perout.period.nsec;
> -		if (mutex_lock_interruptible(&ptp->pincfg_mux))
> -			return -ERESTARTSYS;
> -		err = ops->enable(ops, &req, enable);
> -		mutex_unlock(&ptp->pincfg_mux);
> -		break;
> +		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0)
> +			return -EACCES;
> +		return ptp_perout_request(ptp, cmd, argptr);
>   
>   	case PTP_ENABLE_PPS:
>   	case PTP_ENABLE_PPS2:
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

