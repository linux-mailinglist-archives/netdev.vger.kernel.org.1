Return-Path: <netdev+bounces-132691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE07992CA3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865431F2395A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1EF1D2B13;
	Mon,  7 Oct 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Us/XbZQR"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205D1D3199
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306449; cv=none; b=cb7GJMl0uxVGANxiOs/HE1k4NsZg/ARBkZiiTqSRpjQDmUYCayvk4kqofW48ILBNFz9xsEuRMFVQoSTDztTY5IdaR4fr5GNq75ImmXkNU4YOMH2DhMAqZFv8wmkXnhGmQ9mBqX25IJuCvd8ecM/zrHKCulGSRM8GZ3Jjpiif3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306449; c=relaxed/simple;
	bh=9X7dUKVzwVynxrGXq6clJJjN58q7FNEJr/DBJwWW9kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crUqHzsLJicRmncmLi2uF/0MhF04YRz8MGaA2cafOd1esTZXWJOVa1amwDZqzK41mq8uQMctqp0Z01xhjNKb8ErlFbtm64Fp2tuZuh0XTmkf6scgiWFX+Zcfc8wMCObkYHZRTIsHdl9fFbbQ10cVIP1QBk54h+OadnHFN6AZMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Us/XbZQR; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6f541f8-ac28-4180-989a-84ee4587e21c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728306444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrWRbhovOGOVAQbeFbprGmJ9L9MkLZ14lIG7fXJSwxc=;
	b=Us/XbZQR+ZbWpqRkJPwi1LuHrr0aXujk4FUI4/ifYxofclQGsZrJGYRTUYe9sFB0yLdHRh
	yT5NNS2EMC7DRg0RBjUjQNpqkMZFxUZgQsthn0c5DUAHkh+OQtodJujmAofJimDztzkM3V
	ldKk8NwjIYn83olr1cbCyK3ppHCFKfQ=
Date: Mon, 7 Oct 2024 14:07:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/5] eth: fbnic: add initial PHC support
To: Jacob Keller <jacob.e.keller@intel.com>, Vadim Fedorenko
 <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-3-vadfed@meta.com>
 <9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/10/2024 00:05, Jacob Keller wrote:
> 
> 
> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>> +/* FBNIC timing & PTP implementation
>> + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
>> + * We need to promote those to full 64b, hence we periodically cache the top
>> + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
>> + * we leave the HW clock free running and adjust time offsets in SW as needed.
>> + * Time offset is 64bit - we need a seq counter for 32bit machines.
>> + * Time offset and the cache of top bits are independent so we don't need
>> + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
>> + * are enough.
>> + */
>> +
> 
> If you're going to implement adjustments only in software anyways, can
> you use a timecounter+cyclecounter instead of re-implementing?

Thanks for pointing this out, I'll make it with timecounter/cyclecounter

> 
>> +/* Period of refresh of top bits of timestamp, give ourselves a 8x margin.
>> + * This should translate to once a minute.
>> + * The use of nsecs_to_jiffies() should be safe for a <=40b nsec value.
>> + */
>> +#define FBNIC_TS_HIGH_REFRESH_JIF	nsecs_to_jiffies((1ULL << 40) / 16)
>> +
>> +static struct fbnic_dev *fbnic_from_ptp_info(struct ptp_clock_info *ptp)
>> +{
>> +	return container_of(ptp, struct fbnic_dev, ptp_info);
>> +}
>> +
>> +/* This function is "slow" because we could try guessing which high part
>> + * is correct based on low instead of re-reading, and skip reading @hi
>> + * twice altogether if @lo is far enough from 0.
>> + */
>> +static u64 __fbnic_time_get_slow(struct fbnic_dev *fbd)
>> +{
>> +	u32 hi, lo;
>> +
>> +	lockdep_assert_held(&fbd->time_lock);
>> +
>> +	do {
>> +		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
>> +		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
>> +	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
>> +
> 
> How long does it take hi to overflow? You may be able to get away
> without looping.

According to comment above it may take up to 8 minutes to overflow, but
the updates to the cache should be done every minute. We do not expect
this cycle to happen often.

> I think another way to implement this is to read lo, then hi, then lo
> again, and if lo2 is smaller than lo, you know hi overflowed and you can
> re-read hi

That's an option too, I'll think of it, thanks!

> 
>> +static int fbnic_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>> +{
>> +	int scale = 16; /* scaled_ppm has 16 fractional places */
>> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
>> +	u64 scaled_delta, dclk_period;
>> +	unsigned long flags;
>> +	s64 delta;
>> +	int sgn;
>> +
>> +	sgn = scaled_ppm >= 0 ? 1 : -1;
>> +	scaled_ppm *= sgn;
>> +
>> +	/* d_clock is 600 MHz; which in Q16.32 fixed point ns is: */
>> +	dclk_period = (((u64)1000000000) << 32) / FBNIC_CLOCK_FREQ;
>> +
>> +	while (scaled_ppm > U64_MAX / dclk_period) {
>> +		scaled_ppm >>= 1;
>> +		scale--;
>> +	}
>> +
>> +	scaled_delta = (u64)scaled_ppm * dclk_period;
>> +	delta = div_u64(scaled_delta, 1000 * 1000) >> scale;
>> +	delta *= sgn;
> 
> 
> Please use adjust_by_scaled_ppm or diff_by_scaled_ppm. It makes use of
> mul_u64_u64_div_u64 where feasible to do the temporary multiplication
> step as 128 bit arithmetic.
> 

Got it, will use it in the next version.

>> +
>> +	spin_lock_irqsave(&fbd->time_lock, flags);
>> +	__fbnic_time_set_addend(fbd, dclk_period + delta);
>> +	fbnic_wr32(fbd, FBNIC_PTP_ADJUST, FBNIC_PTP_ADJUST_ADDEND_SET);
>> +
>> +	/* Flush, make sure FBNIC_PTP_ADD_VAL_* is stable for at least 4 clks */
>> +	fbnic_rd32(fbd, FBNIC_PTP_SPARE);
>> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
>> +
>> +	return fbnic_present(fbd) ? 0 : -EIO;
>> +}
>> +
>> +static int fbnic_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>> +{
>> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
>> +	struct fbnic_net *fbn;
>> +	unsigned long flags;
>> +
>> +	fbn = netdev_priv(fbd->netdev);
>> +
>> +	spin_lock_irqsave(&fbd->time_lock, flags);
>> +	u64_stats_update_begin(&fbn->time_seq);
>> +	WRITE_ONCE(fbn->time_offset, READ_ONCE(fbn->time_offset) + delta);
>> +	u64_stats_update_end(&fbn->time_seq);
>> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +fbnic_ptp_gettimex64(struct ptp_clock_info *ptp, struct timespec64 *ts,
>> +		     struct ptp_system_timestamp *sts)
>> +{
>> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
>> +	struct fbnic_net *fbn;
>> +	unsigned long flags;
>> +	u64 time_ns;
>> +	u32 hi, lo;
>> +
>> +	fbn = netdev_priv(fbd->netdev);
>> +
>> +	spin_lock_irqsave(&fbd->time_lock, flags);
>> +
>> +	do {
>> +		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
>> +		ptp_read_system_prets(sts);
>> +		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
>> +		ptp_read_system_postts(sts);
>> +		/* Similarly to comment above __fbnic_time_get_slow()
>> +		 * - this can be optimized if needed.
>> +		 */
>> +	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
>> +
>> +	time_ns = ((u64)hi << 32 | lo) + fbn->time_offset;
>> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
>> +
>> +	if (!fbnic_present(fbd))
>> +		return -EIO;
>> +
>> +	*ts = ns_to_timespec64(time_ns);
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +fbnic_ptp_settime64(struct ptp_clock_info *ptp, const struct timespec64 *ts)
>> +{
>> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
>> +	struct fbnic_net *fbn;
>> +	unsigned long flags;
>> +	u64 dev_ns, host_ns;
>> +	int ret;
>> +
>> +	fbn = netdev_priv(fbd->netdev);
>> +
>> +	host_ns = timespec64_to_ns(ts);
>> +
>> +	spin_lock_irqsave(&fbd->time_lock, flags);
>> +
>> +	dev_ns = __fbnic_time_get_slow(fbd);
>> +
>> +	if (fbnic_present(fbd)) {
>> +		u64_stats_update_begin(&fbn->time_seq);
>> +		WRITE_ONCE(fbn->time_offset, host_ns - dev_ns);
>> +		u64_stats_update_end(&fbn->time_seq);
>> +		ret = 0;
>> +	} else {
>> +		ret = -EIO;
>> +	}
>> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
>> +
>> +	return ret;
>> +}
>> +
> 
> Since all your operations are using a software offset and leaving the
> timer free-running, I think this really would make more sense using a
> timecounter and cyclecounter.
> 

Yeah, looks like it's better to use common interfaces.

>> +static const struct ptp_clock_info fbnic_ptp_info = {
>> +	.owner			= THIS_MODULE,
>> +	/* 1,000,000,000 - 1 PPB to ensure increment is positive
>> +	 * after max negative adjustment.
>> +	 */
>> +	.max_adj		= 999999999,
>> +	.do_aux_work		= fbnic_ptp_do_aux_work,
>> +	.adjfine		= fbnic_ptp_adjfine,
>> +	.adjtime		= fbnic_ptp_adjtime,
>> +	.gettimex64		= fbnic_ptp_gettimex64,
>> +	.settime64		= fbnic_ptp_settime64,
>> +};
>> +
>> +static void fbnic_ptp_reset(struct fbnic_dev *fbd)
>> +{
>> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
>> +	u64 dclk_period;
>> +
>> +	fbnic_wr32(fbd, FBNIC_PTP_CTRL,
>> +		   FBNIC_PTP_CTRL_EN |
>> +		   FIELD_PREP(FBNIC_PTP_CTRL_TICK_IVAL, 1));
>> +
>> +	/* d_clock is 600 MHz; which in Q16.32 fixed point ns is: */
>> +	dclk_period = (((u64)1000000000) << 32) / FBNIC_CLOCK_FREQ;
>> +
>> +	__fbnic_time_set_addend(fbd, dclk_period);
>> +
>> +	fbnic_wr32(fbd, FBNIC_PTP_INIT_HI, 0);
>> +	fbnic_wr32(fbd, FBNIC_PTP_INIT_LO, 0);
>> +
>> +	fbnic_wr32(fbd, FBNIC_PTP_ADJUST, FBNIC_PTP_ADJUST_INIT);
>> +
>> +	fbnic_wr32(fbd, FBNIC_PTP_CTRL,
>> +		   FBNIC_PTP_CTRL_EN |
>> +		   FBNIC_PTP_CTRL_TQS_OUT_EN |
>> +		   FIELD_PREP(FBNIC_PTP_CTRL_MAC_OUT_IVAL, 3) |
>> +		   FIELD_PREP(FBNIC_PTP_CTRL_TICK_IVAL, 1));
>> +
>> +	fbnic_rd32(fbd, FBNIC_PTP_SPARE);
>> +
>> +	fbn->time_offset = 0;
>> +	fbn->time_high = 0;
> 
> Not entirely sure how it works for you, but we found that most users
> expect to minimize the time loss or changes due to a reset, and we
> re-apply the last known configuration during a reset instead of letting
> the clock reset back to base state.

In case of reset the counter will be re-initialized, which means the
stored offset will be invalid anyways. It's better to reset values back
to base state because it will make easier for the app to decide to make
a step rather then adjust frequency. And it will make clocks align
faster.


