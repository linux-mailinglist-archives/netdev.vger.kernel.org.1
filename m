Return-Path: <netdev+bounces-102629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6090402D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C81C21E84
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462AF38FA1;
	Tue, 11 Jun 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcPuA6Fp"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5F38FAD
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120200; cv=none; b=YZtshFFPcThtEnFRTXAoOSB5kfifYDPqQGW19Ptn6tRqNpQAFKVnsPkeJCzzg9fg3jS6xNX3siGZR2EMrnEGI/QdNrSeKCyVqJ31XwJrToOa1zbdQUYh2kX/otRwrJnzXc6HWJYJShQrhB33Owpvm1EvRPB55Mtgqaef1qCybvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120200; c=relaxed/simple;
	bh=r57qrLhmwHMKnHrFKmWypm9nE6+c8sNnIXim4c8y74s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT5TIDOym3GydS5ugPPq1gSsyAN/J2kHkZunmTEDgDAJJGGSXGGhQ0TOV1xkY4tUHjfbZRxPGB/zDpvcDDv+Oc3dhOFwSH+7wgqsHx0Sn3HeZycq/djwmWJYozu5u6TNU6MKNDSLyEPmUBVuC9tuSvj8y0wUJj7UITEn3zHCj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcPuA6Fp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrew@lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718120196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDf/Var0If69rFPJqIDSKQIuhIfmeNAqiQ/6ESKmNKs=;
	b=pcPuA6FptuahJYYDigDXzfvPCr9O1DORzHlUYC4NlO5Oie8SCuI7zLrkehHQs6qOGO0tuj
	M+ht37ApsnW65T4u6kNmUAEV6yrjciG6KskOq39MuD+Loq5n8kgJ3i/YFWZiSq/6i3xPkl
	STUEy3q1USjAcA/DBpzO/x+hUKG72Hw=
X-Envelope-To: radhey.shyam.pandey@amd.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
Message-ID: <4d3871c1-afa1-4402-ad62-2fdb9d58dc3c@linux.dev>
Date: Tue, 11 Jun 2024 11:36:31 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
 <40cff9a6-bad3-4f85-8cbc-6d4bc72f9b9f@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <40cff9a6-bad3-4f85-8cbc-6d4bc72f9b9f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/24 20:26, Andrew Lunn wrote:
>> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
>> +{
>> +	return u64_stats_read(&lp->hw_stats[stat]);
>> +}
>> @@ -1695,6 +1760,35 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>  		stats->tx_packets = u64_stats_read(&lp->tx_packets);
>>  		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
>>  	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
>> +
>> +	if (!(lp->features & XAE_FEATURE_STATS))
>> +		return;
>> +
>> +	do {
>> +		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
>> +		stats->rx_length_errors =
>> +			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
> 
> I'm i reading this correctly. You are returning the counters from the
> last refresh period. What is that? 2.5Gbps would wrapper around a 32
> byte counter in 13 seconds. I hope these statistics are not 13 seconds
> out of date?

By default we use a 1 Hz refresh period. You can of course configure this
up to 13 seconds, but we refuse to raise it further since we risk missing
a wrap-around. It's configurable by userspace so they can determine how
out-of-date they like their stats (vs how often they want to wake up the
CPU).

> Since axienet_stats_update() also uses the lp->hw_stat_sync, i don't
> see why you cannot read the hardware counter value and update to the
> latest value.

We would need to synchronize against updates to hw_last_counter. Imagine
a scenario like

CPU 1					CPU 2
__axienet_device_reset()
	axienet_stats_update()
					axienet_stat()
						u64_stats_read()
						axienet_ior()
	/* device reset */
	hw_last_counter = 0
						stats->foo = ... - hw_last_counter[...]

and now we have a glitch in the counter values, since we effectively are
double-counting the current counter value. Alternatively, we could read
the counter after reset but before hw_last_counter was updated and get a
glitch due to underflow.

--Sean

