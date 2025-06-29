Return-Path: <netdev+bounces-202249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F27AECE5E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 17:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8801895612
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD48722D781;
	Sun, 29 Jun 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v+kESv11"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C313790B
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751212176; cv=none; b=GaVFdZSdpHca8D4s+MfH/oeALS9D1ArLMWoOiY5pMwmm5mF/e4MKrILnL54aKkkDhuOAgXiybZqTHhq+It9+YP+1JnvjrNEg8/6wfM8t2ThvN9j8c4JrzHBUEa/dIcHL4r2YplldOG6Tjg+5YdSZ2odLzgAtO6cBdG1RGwEYOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751212176; c=relaxed/simple;
	bh=GQLr7xchKK1viEfYMHygrCDLhlsEOMPIMYaTzu19GIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKh/KKYu4XbnH8Xg7uc/3ryratbYUD9QhmpQPM5IzH5rUVnpSQsg8MOmRmGqK2cwVLc4Tgc8xgn+dxOa5+5IxLOtO7pV/DYV04P08VdAv49t/4IZfH3pfEBQj64HDwVqICUu+Wq34gMsgKN115yu9Zb6iCVlclULxComOklJzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v+kESv11; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <745fd720-4cf5-42c4-9cb6-a4932c6f68ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751212172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imiGuD/gOJUll+b4BS//Yom8mQki/dKUk35+LdByEn4=;
	b=v+kESv11z0HGmpL45RAXvRBHnh0k134yrqjPIbNq6jgueBGrKJlRUqj053Ydn7zDBUIx9d
	9sBG+0wB4Ao6K09Gb2WFe1SXSgLFLMWla+z/bCKfvP9XL6RN9KjVeA/d4ObLuYSLKC/TlJ
	zA/fIOpGMm7LU8m87fp4tcsrKAo887I=
Date: Sun, 29 Jun 2025 16:49:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 1/3] timekeeping: Provide ktime_get_clock_ts64()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
References: <20250626124327.667087805@linutronix.de>
 <20250626131708.419101339@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250626131708.419101339@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/06/2025 14:27, Thomas Gleixner wrote:
> PTP implements an inline switch case for taking timestamps from various
> POSIX clock IDs, which already consumes quite some text space. Expanding it
> for auxiliary clocks really becomes too big for inlining.
> 
> Provide a out of line version.
> 
> The function invalidates the timestamp in case the clock is invalid. The
> invalidation allows to implement a validation check without the need to
> propagate a return value through deep existing call chains.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/timekeeping.h |    1 +
>   kernel/time/timekeeping.c   |   34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timesp
>   extern void ktime_get_real_ts64(struct timespec64 *tv);
>   extern void ktime_get_coarse_ts64(struct timespec64 *ts);
>   extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> +extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
>   
>   /* Multigrain timestamp interfaces */
>   extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1636,6 +1636,40 @@ void ktime_get_raw_ts64(struct timespec6
>   EXPORT_SYMBOL(ktime_get_raw_ts64);
>   
>   /**
> + * ktime_get_clock_ts64 - Returns time of a clock in a timespec
> + * @id:		POSIX clock ID of the clock to read
> + * @ts:		Pointer to the timespec64 to be set
> + *
> + * The timestamp is invalidated (@ts->sec is set to -1) if the
> + * clock @id is not available.
> + */
> +void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
> +{
> +	/* Invalidate time stamp */
> +	ts->tv_sec = -1;
> +	ts->tv_nsec = 0;
> +
> +	switch (id) {
> +	case CLOCK_REALTIME:
> +		ktime_get_real_ts64(ts);
> +		return;
> +	case CLOCK_MONOTONIC:
> +		ktime_get_ts64(ts);
> +		return;
> +	case CLOCK_MONOTONIC_RAW:
> +		ktime_get_raw_ts64(ts);
> +		return;
> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
> +		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
> +			ktime_get_aux_ts64(id, ts);
> +		return;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);
> +
> +/**
>    * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
>    */
>   int timekeeping_valid_for_hres(void)
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

