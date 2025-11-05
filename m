Return-Path: <netdev+bounces-235813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB76C35DD5
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFD33A56FA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3724313E14;
	Wed,  5 Nov 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gao/pfr6"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69F2EC083
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349809; cv=none; b=cm8cfSy/TsYKPombsh62b5gX7Acsy6E5IXXLWEWOC5yCKBAB0lBtV2ApS3fiota9UYkyv+ZERvleIy9Gg8KCfc0V1B1IOKDOiKUX6t2FMQyezKo+iJIsirnCCj6UAsXwwGZlGNb/9C/Xe/vzsnhqbRsyVzfT6HlKdHvT+q/Or4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349809; c=relaxed/simple;
	bh=U2MFy/ZpUYtu/bmSe8TinHtKJ12o4YsPED5q/xnXfl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvPhLWMZFt6kwWvQ3J03BcRwt9+72hd7pOKNX/zCFbLe7NV0Vs6EatOfrE7y/DJjdse7IU1WewqMR5qpaa+8JSv/IbLinpvUojm8kHZHBWRRADtpXGU+Ov7Jd415VEyQbVilVksuDtOlyULUIVGpVSshvMhCdEz+eVBwJpT87Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gao/pfr6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5713f16-d004-4794-9cfd-dad4bd4a1f4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762349805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMspv3hUsxYf33GQdhTPOGgMERd6YtOjZBMB/CDCRMc=;
	b=gao/pfr6YZEQh1VETo3tz3E330AzRN97tMm0hF2lvcK+DtOaq4FxspQCYwhF3TeVJQgqZP
	VCXJhP4gks4LR1a0fms78Ez+Vc17VYFCcJL1q3tmXk8vliNIi6eXdIPrzeDoFx8CGcOq2Q
	yQyDsYBWk5hVClIwRDDHYtdq12J0o5Q=
Date: Wed, 5 Nov 2025 13:36:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 7/7] qede: convert to use ndo_hwtstamp
 callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
 <20251103150952.3538205-8-vadim.fedorenko@linux.dev>
 <20251104174340.5d2d8741@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251104174340.5d2d8741@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/11/2025 01:43, Jakub Kicinski wrote:
> On Mon,  3 Nov 2025 15:09:52 +0000 Vadim Fedorenko wrote:
>>   	ptp->hw_ts_ioctl_called = 1;
>> -	ptp->tx_type = config.tx_type;
>> -	ptp->rx_filter = config.rx_filter;
>> +	ptp->tx_type = config->tx_type;
>> +	ptp->rx_filter = config->rx_filter;
>>   
>>   	rc = qede_ptp_cfg_filters(edev);
>> -	if (rc)
>> +	if (rc) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "One-step timestamping is not supported");
>>   		return rc;
>> +	}
>> +
>> +	config->rx_filter = ptp->rx_filter;
> 
> Same story as the first patch.
> I suppose these drives may predate the advanced tx config options.
> Simple fix would be to move the tx_filter validation here instead.
> 
> I'll apply 2-6.

Got it. I'll send fixed versions of patch 1 and patch 7, thanks!

