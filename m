Return-Path: <netdev+bounces-217804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AC7B39DD6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C225E1898378
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6F2DCF50;
	Thu, 28 Aug 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k7ozNI4/"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29B30FC01
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385609; cv=none; b=tda8Yfb5AK75mNB2dM6fJP80NI53f8UDbH0zzCACoZ9l2FmkxRUnl2p7MviHZ7vHFJDhr52j8wHoyJGObHvneyQZ5JJl8w1pXmpAaM7lt4RN3+bjIENJ1uZdhuHAubF239YzNNyR3yRDACGzA+omXWQLKz4X9vysdDSaPLI8Bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385609; c=relaxed/simple;
	bh=a/1N2HabGIQ+ll+QPBfqEgXvjTAvBRiH9gE9sUcZSl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCU2yMK1gX6ZznMcJmZK/fZ0RM5+u86/uyn425HIEPfyLakGMkGIbAIpUzbKLohA8bPidgxx0w6VV/qQWyCqIAtoI02BO83kMF91abTqmDsjhA1FoOuyMxcZnYpAHPLzWa9EVZeM8S26A7xMns1OK4QIdE3D+SOrlpN0FM8G29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k7ozNI4/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f56589b-ffd5-4ed2-afb5-18cf2e7692a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756385600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OYmscDzA8DuBFFuFEUYRr0Q0BeHltuwXxCLOeExJLw=;
	b=k7ozNI4/+5nmIXAgp5NU/6lELXl94gkgI8ycndYt0GP2Sk+vlHObYeiwZ1mAMDFPdSsaWS
	mc/TECIXESgFhDu3cfexJXSjYedEQpIPc7uh6JjacvI/3xV8RO0Pnbnx8QiCxXFM/sIakp
	qLuXraX1U1Lj6TPnCX++O6wW+bWo+eg=
Date: Thu, 28 Aug 2025 13:53:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net-next] ptp: Limit time setting of PTP clocks
To: Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20250828103300.1387025-1-mlichvar@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828103300.1387025-1-mlichvar@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 11:32, Miroslav Lichvar wrote:
> Networking drivers implementing PTP clocks and kernel socket code
> handling hardware timestamps use the 64-bit signed ktime_t type counting
> nanoseconds. When a PTP clock reaches the maximum value in year 2262,
> the timestamps returned to applications will overflow into year 1667.
> The same thing happens when injecting a large offset with
> clock_adjtime(ADJ_SETOFFSET).
> 
> The commit 7a8e61f84786 ("timekeeping: Force upper bound for setting
> CLOCK_REALTIME") limited the maximum accepted value setting the system
> clock to 30 years before the maximum representable value (i.e. year
> 2232) to avoid the overflow, assuming the system will not run for more
> than 30 years.
> 
> Enforce the same limit for PTP clocks. Don't allow negative values and
> values closer than 30 years to the maximum value. Drivers may implement
> an even lower limit if the hardware registers cannot represent the whole
> interval between years 1970 and 2262 in the required resolution.
> 
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <jstultz@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Notes:
>      v2:
>      - leave tv_nsec validation separate (Jakub)
> 
>   drivers/ptp/ptp_clock.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 1cc06b7cb17e..3e0726c6f55b 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -100,6 +100,9 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
>   		return -EBUSY;
>   	}
>   
> +	if (!timespec64_valid_settod(tp))
> +		return -EINVAL;
> +
>   	return  ptp->info->settime64(ptp->info, tp);
>   }
>   
> @@ -130,7 +133,7 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
>   	ops = ptp->info;
>   
>   	if (tx->modes & ADJ_SETOFFSET) {
> -		struct timespec64 ts;
> +		struct timespec64 ts, ts2;
>   		ktime_t kt;
>   		s64 delta;
>   
> @@ -143,6 +146,14 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
>   		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
>   			return -EINVAL;
>   
> +		/* Make sure the offset is valid */
> +		err = ptp_clock_gettime(pc, &ts2);
> +		if (err)
> +			return err;
> +		ts2 = timespec64_add(ts2, ts);
> +		if (!timespec64_valid_settod(&ts2))
> +			return -EINVAL;
> +
>   		kt = timespec64_to_ktime(ts);
>   		delta = ktime_to_ns(kt);
>   		err = ops->adjtime(ops, delta);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

