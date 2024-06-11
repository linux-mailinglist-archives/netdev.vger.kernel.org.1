Return-Path: <netdev+bounces-102625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE9903FCC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94521281C14
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD311CD2B;
	Tue, 11 Jun 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DohB/qiX"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29811BF53
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118859; cv=none; b=qDZdJuzhdrwYDssGlxG3A8KpAKEaQ1MR/dhMZutWE6A3Mk7zGZs3zJE/hgaPEVDDFQCdmPQA3KaxZCfwHemmdzrB92LsxBsFjhuSHHrFUIebbB5JS8PikpeKR/+rvE1XB0gKmo2Rolq4QHgE00ok6uXCHi98QfTC/PGDK1/jIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118859; c=relaxed/simple;
	bh=kymxmTfzCIY+KCZTaQaGBh3Ow6FTMHvSxeNy1GitUHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcV/++83+mZ2a42re/MrkQHDP3Tw3bp1fmWvvg1DiRHE8o8cYkZEVSRl3eeYmtP35RupKQFzuHAukJ+svuxXw81E+rh3XkxOcTOmBDzUa/8+lBvAmkg2wVKsdAW7Tih/+cPzUK/gywLW7eRKBc4JcbBzafK9oIhHG6KOeZ/gZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DohB/qiX; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrew@lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718118855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qW3j5h6q3Oo1ihZw1Fz9Fs14ioQF7XsCBm6iwiYKMLk=;
	b=DohB/qiXj0/fOaAnpKROMiga+NnvRUZ6W9kui+YM6YSQ12WaTbG/q1vPfEQTCBoQ4E0poA
	nvuHpBLiwbgU/rbtT9AU/TiBnd0wHvWO45zEO0FwcjEjy4Lm15CQu2f4JREaqMRjlyh9Cg
	NcWDsIMPipfT7K4nYMBxrdw1/AuYHp8=
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
Message-ID: <abfdacc1-d7fc-45ab-800b-09c14cd41858@linux.dev>
Date: Tue, 11 Jun 2024 11:14:11 -0400
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
 <7c06c9d7-ad11-4acd-8c80-fbeb902da40d@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <7c06c9d7-ad11-4acd-8c80-fbeb902da40d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/24 20:13, Andrew Lunn wrote:
> On Mon, Jun 10, 2024 at 07:10:22PM -0400, Sean Anderson wrote:
>> Add support for reading the statistics counters, if they are enabled.
>> The counters may be 64-bit, but we can't detect this as there's no
>> ability bit for it and the counters are read-only. Therefore, we assume
>> the counters are 32-bits.
> 
>> +static void axienet_stats_update(struct axienet_local *lp)
>> +{
>> +	enum temac_stat stat;
>> +
>> +	lockdep_assert_held(&lp->stats_lock);
>> +
>> +	u64_stats_update_begin(&lp->hw_stat_sync);
>> +	for (stat = 0; stat < STAT_COUNT; stat++) {
>> +		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> 
> The * 8 here suggests the counters are spaced so that they could be 64
> bit wide, even when only 32 bits are used.

Correct.

> Does the documentation say anything about the upper 32 bits when the
> counters are only 32 bits?  Are they guaranteed to read as zero? I'm
> just wondering if the code should be forward looking and read all 64
> bits? 

The registers are documented as being 32-bit, with the upper 32-bits
being registered upon reading the lower 32 bits. The documentation
doesn't say what the upper registers are when the counters are 32 bits.

>>  static int __axienet_device_reset(struct axienet_local *lp)
>>  {
>>  	u32 value;
>>  	int ret;
>>  
>> +	/* Save statistics counters in case they will be reset */
>> +	if (lp->features & XAE_FEATURE_STATS) {
>> +		mutex_lock(&lp->stats_lock);
>> +		axienet_stats_update(lp);
>> +	}
> 
> It is a pretty unusual pattern to split a mutex lock/unlock like this
> on an if statement. Maybe just unconditionally hold the mutex? This
> does not appear to be anyway hot path, so the overhead should not
> matter.

OK

--Sean

