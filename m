Return-Path: <netdev+bounces-200040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C165AE2C5E
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3171896708
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC87271443;
	Sat, 21 Jun 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XjEcP2HO"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42EF4CE08
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750538206; cv=none; b=NWpTyursyGEEuEbLBCNXyp0iz4ZnVWbJ3ZO92Sn8RlhdE4ZebMViM44RWhGh7O+wMQTZVllOkNzmzYXwq0Jf4hjLqYoqS5cmCp3Ap9uB80NCAPz8jMGUH4MPEGH+ln3DpuUOWBsayqbgFvUlhCyH0V9gmStTZOxBTnEgmyxUF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750538206; c=relaxed/simple;
	bh=IL4FMTqf/x+Br6L5l1f33GaS1KFdfsOZFdGiVZX9Cm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cg50KnFXrmydxaJmnP0RC7/knveXHyNOYmkoT/unb0lRDTCdDMNZkG3MD+bRrDLizVx6O50ZKSCCvpdhD6WMZp4C54uEMqiYNtsHjZfc1KXhEf9yxgv3CcjtbSk/1eOPcUW7d6pZuLPBfluIRd6fPFaOE0fcZu3pnkqO1dbPqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XjEcP2HO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80052862-683c-4a53-b7a2-8d767a057022@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750538200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z+b6jov035aId35pJXpy5WeiWjPI6mbrPX66w3Fa6k=;
	b=XjEcP2HO+F1ojbxigb47Q4fx3ECpX642YaFhkzBUi7HISvvrbRAxE55WkSd4Hw3+E0WMGe
	wc4iTtsLTmKCmPTiATf//ZgJJRTrBNBImE82D0aIj5Li0+jx5Ozw2nbehU9OGCEYCr/6nQ
	ekXN8q+X8h/muamq1rEwiB1lxiRlBdg=
Date: Sat, 21 Jun 2025 21:36:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 10/13] ptp: Split out PTP_MASK_CLEAR_ALL ioctl code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.344887489@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250620131944.344887489@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/06/2025 14:24, Thomas Gleixner wrote:
> Continue the ptp_ioctl() cleanup by splitting out the PTP_MASK_CLEAR_ALL ioctl
> code into a helper function.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |    9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -442,6 +442,12 @@ static long ptp_pin_setfunc(struct ptp_c
>   		return ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
>   }
>   
> +static long ptp_mask_clear_all(struct timestamp_event_queue *tsevq)
> +{
> +	bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
> +	return 0;
> +}
> +
>   long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	       unsigned long arg)
>   {
> @@ -504,8 +510,7 @@ long ptp_ioctl(struct posix_clock_contex
>   		return ptp_pin_setfunc(ptp, cmd, argptr);
>   
>   	case PTP_MASK_CLEAR_ALL:
> -		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
> -		break;
> +		return ptp_mask_clear_all(pccontext->private_clkdata);
>   
>   	case PTP_MASK_EN_SINGLE:
>   		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {
> 

Not quite sure there is a benefit of having a function for this type,
apart from having one style. But it adds some LoC...



