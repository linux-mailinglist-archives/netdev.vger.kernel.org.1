Return-Path: <netdev+bounces-118403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EB89517B9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2ADB2315F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47469148FE3;
	Wed, 14 Aug 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GV3Ya9bf"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78A14900E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627766; cv=none; b=dLPXYjuzoUoyRw9aBv0i4On/F926n+rb//ZwpaO67FkNwl4IGXyi8prxGeyB+7SFaUx83h1Vr4JgQHvApQl7A36N+ca9uPfJTxXfgB3+Or+6z79l+BuKH99YzMOTaq174Rp+Tuib+u911uKLB78jh5qPULqrKn8uNHcrIMo1a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627766; c=relaxed/simple;
	bh=PFYcPcRt+gvGB2K+xoV1fcnefzRFUXYgoRRaLz++uvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTYgNYJKfxHCdS2Eqoe8blr/AYGJ98eq1M/SRbv2ImJv8MZn3FH7cRrKbd49EunTziewz+6s2PE5nFK4DEhWfRuVGrBWsnkngKlKWqx6kJObpLaYjKVmJig+jsiEhU9k5NG1uBUhfA6DF9V9A8K7xbfCjoajBSraSf0A/g2wWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GV3Ya9bf; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c8a12b5-34b8-445d-900d-f027e58b885b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723627758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wn3KrTuiTbfJgJb/Wa5AoMC5mlX0T1z2bI1U396AEoo=;
	b=GV3Ya9bf7BPMlrmJ0Sk9l+S1LX+SHY2Bo7yviYu11AbYCHMmYGZnsa1Gb/939fiNX7JkZR
	kAsFxWsjDMW0OEeaX3XIN3Nqz67QMdbuF78PM6JhMM2kDYOT2eSaFEZsQ5fIuob3i41JbN
	t6YUPp/2SYuvQAUHS4pHtrzZbqVuV2s=
Date: Wed, 14 Aug 2024 10:29:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240813125602.155827-2-maciek@machnikowski.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/08/2024 13:56, Maciek Machnikowski wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an Untrusted Sender
>    You have not previously corresponded with this sender.
> |-------------------------------------------------------------------!
> 
> The Timex structure returned by the clock_adjtime() POSIX API allows
> the clock to return the estimated error. Implement getesterror
> and setesterror functions in the ptp_clock_info to enable drivers
> to interact with the hardware to get the error information.
> 
> getesterror additionally implements returning hw_ts and sys_ts
> to enable upper layers to estimate the maximum error of the clock
> based on the last time of correction. This functionality is not
> directly implemented in the clock_adjtime and will require
> a separate interface in the future.
> 
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>   drivers/ptp/ptp_clock.c          | 18 +++++++++++++++++-
>   include/linux/ptp_clock_kernel.h | 11 +++++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..2cb1f6af60ea 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -164,9 +164,25 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
>   
>   			err = ops->adjphase(ops, offset);
>   		}
> +	} else if (tx->modes & ADJ_ESTERROR) {
> +		if (ops->setesterror)
> +			if (tx->modes & ADJ_NANO)
> +				err = ops->setesterror(ops, tx->esterror * 1000);

Looks like some miscoding here. The callback doc later says that
setesterror expects nanoseconds. ADJ_NANO switches the structure to
provide nanoseconds. But the code here expects tx->esterror to be in
microseconds when ADJ_NANO is set, which is confusing.

> +			else
> +				err = ops->setesterror(ops, tx->esterror);
>   	} else if (tx->modes == 0) {
> +		long esterror;
> +
>   		tx->freq = ptp->dialed_frequency;
> -		err = 0;
> +		if (ops->getesterror) {
> +			err = ops->getesterror(ops, &esterror, NULL, NULL);
> +			if (err)
> +				return err;
> +			tx->modes &= ADJ_NANO;

Here all the flags except possible ADJ_NANO is cleaned, but why?

> +			tx->esterror = esterror
And here it doesn't matter what is set in flags, you return nanoseconds 
directly...

> +		} else {
> +			err = 0;
> +		}
>   	}
>   
>   	return err;
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 6e4b8206c7d0..e78ea81fc4cf 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -136,6 +136,14 @@ struct ptp_system_timestamp {
>    *                   parameter cts: Contains timestamp (device,system) pair,
>    *                   where system time is realtime and monotonic.
>    *
> + * @getesterror: Reads the current error estimate of the hardware clock.
> + *               parameter phase: Holds the error estimate in nanoseconds.
> + *               parameter hw_ts: If not NULL, holds the timestamp of the hardware clock.
> + *               parameter sw_ts: If not NULL, holds the timestamp of the CPU clock.
> + *
> + * @setesterror:  Set the error estimate of the hardware clock.
> + *                parameter phase: Desired error estimate in nanoseconds.
> + *

The man pages says that esterror is in microseconds. It makes total
sense to make it nanoseconds, but we have to adjust the documentation.

>    * @enable:   Request driver to enable or disable an ancillary feature.
>    *            parameter request: Desired resource to enable or disable.
>    *            parameter on: Caller passes one to enable or zero to disable.
> @@ -188,6 +196,9 @@ struct ptp_clock_info {
>   			    struct ptp_system_timestamp *sts);
>   	int (*getcrosscycles)(struct ptp_clock_info *ptp,
>   			      struct system_device_crosststamp *cts);
> +	int (*getesterror)(struct ptp_clock_info *ptp, long *phase,
> +			   struct timespec64 *hw_ts, struct timespec64 *sys_ts);
> +	int (*setesterror)(struct ptp_clock_info *ptp, long phase);
>   	int (*enable)(struct ptp_clock_info *ptp,
>   		      struct ptp_clock_request *request, int on);
>   	int (*verify)(struct ptp_clock_info *ptp, unsigned int pin,


