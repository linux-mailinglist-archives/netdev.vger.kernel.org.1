Return-Path: <netdev+bounces-132897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE68993AAA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C63B22F89
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71A18BC16;
	Mon,  7 Oct 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dua3BJ/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF416D4E6
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342559; cv=none; b=ZoIcseMwwPUZCkSrp2AR6uqaTZglYFsMUJbZNEIZgHmGTLbvyYBOt5SOTQVM3/xRS9zN163HmxEwOtesPC6jXpOAb3j/Q1PXaD2aJyq+MPIQGHb87eILitlMJQbnz0ClJMU3gIXNKZoedZ726cT78IVlOlVs+aI1dprPU18Esr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342559; c=relaxed/simple;
	bh=KyxI4gAK1qf0wgwy6LgHewlej+0hnpc9z38XZNdGTh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvwXRm+n4hWuGQdio7DWnU1iRbSURaxkbFY1FclyxH5KHgLre/bfSIXNBgsmkge0htFa8e+8obzA0J+Z3D3TSs+4DvLkU7pk79zKTepluxDUxeI2dqSvjWxLCc/hTnl1pNGRMN2mZ88VngJZX5Ztf8ufOo2gKSccYeK3hABKB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dua3BJ/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F1C4CEC6;
	Mon,  7 Oct 2024 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728342558;
	bh=KyxI4gAK1qf0wgwy6LgHewlej+0hnpc9z38XZNdGTh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dua3BJ/Q3zzzVT95A68kuYI9VpFUT8mTdAsR4QQ4vuYqVQrISV1P1xtYsn+tCMlUD
	 8yMbIlVaOMxVPGl+cS1CYg6d3B9dWYIOvpbooPxAx19PwTWCRcwIoaOqAC07V43Lfn
	 DWmyEm3QgyFAmWyXBYXsRfyhACqfWnqWizpv6TPL7JwxwplvfF9VEydrMPK78HRCbG
	 CYI2XkD4Q/kZb502oCelpXcUaiSGkpM59YM4NpN3YnhajXzYiuOSJl0WuInVzrHu98
	 k1JiZWlvibyl6mjnnXaCbY6a4Nb9KIOi+ab9Knjns3riDSL0IPPqWXc7Gz70EH2lJG
	 9Er9JEVhmbTeg==
Date: Mon, 7 Oct 2024 16:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Vadim Fedorenko
 <vadfed@meta.com>, David Ahern <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Alexander
 Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v3 2/5] eth: fbnic: add initial PHC support
Message-ID: <20241007160917.591c2d5d@kernel.org>
In-Reply-To: <e6f541f8-ac28-4180-989a-84ee4587e21c@linux.dev>
References: <20241003123933.2589036-1-vadfed@meta.com>
	<20241003123933.2589036-3-vadfed@meta.com>
	<9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
	<e6f541f8-ac28-4180-989a-84ee4587e21c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 14:07:17 +0100 Vadim Fedorenko wrote:
> On 05/10/2024 00:05, Jacob Keller wrote:
> > On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:  
> >> +/* FBNIC timing & PTP implementation
> >> + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
> >> + * We need to promote those to full 64b, hence we periodically cache the top
> >> + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
> >> + * we leave the HW clock free running and adjust time offsets in SW as needed.
> >> + * Time offset is 64bit - we need a seq counter for 32bit machines.
> >> + * Time offset and the cache of top bits are independent so we don't need
> >> + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
> >> + * are enough.
> >> + */
> >> +  
> > 
> > If you're going to implement adjustments only in software anyways, can
> > you use a timecounter+cyclecounter instead of re-implementing?  
> 
> Thanks for pointing this out, I'll make it with timecounter/cyclecounter

Please don't, the clock is synthonized, we only do simple offsetting.

> >> +/* Period of refresh of top bits of timestamp, give ourselves a 8x margin.
> >> + * This should translate to once a minute.
> >> + * The use of nsecs_to_jiffies() should be safe for a <=40b nsec value.
> >> + */
> >> +#define FBNIC_TS_HIGH_REFRESH_JIF	nsecs_to_jiffies((1ULL << 40) / 16)
> >> +
> >> +static struct fbnic_dev *fbnic_from_ptp_info(struct ptp_clock_info *ptp)
> >> +{
> >> +	return container_of(ptp, struct fbnic_dev, ptp_info);
> >> +}
> >> +
> >> +/* This function is "slow" because we could try guessing which high part
> >> + * is correct based on low instead of re-reading, and skip reading @hi
> >> + * twice altogether if @lo is far enough from 0.
> >> + */
> >> +static u64 __fbnic_time_get_slow(struct fbnic_dev *fbd)
> >> +{
> >> +	u32 hi, lo;
> >> +
> >> +	lockdep_assert_held(&fbd->time_lock);
> >> +
> >> +	do {
> >> +		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
> >> +		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
> >> +	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
> >> +  
> > 
> > How long does it take hi to overflow? You may be able to get away
> > without looping.  
> 
> According to comment above it may take up to 8 minutes to overflow, but
> the updates to the cache should be done every minute. We do not expect
> this cycle to happen often.
> 
> > I think another way to implement this is to read lo, then hi, then lo
> > again, and if lo2 is smaller than lo, you know hi overflowed and you can
> > re-read hi  
> 
> That's an option too, I'll think of it, thanks!

The triple read is less neat in case hi jumps by more than 1.


