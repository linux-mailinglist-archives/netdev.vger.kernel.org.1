Return-Path: <netdev+bounces-235960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034DC37701
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B883AE4A8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F90B279DCD;
	Wed,  5 Nov 2025 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o2Dl9lqc"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3C32E722
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369967; cv=none; b=mbjBBNGxCXhd+4ABwXW3iRPYF+nGtEBwGUQ2mdyDzBDW9MFuXDWQPW98Dz3djgnvt+tLN96kNOplKqPYR0VR571xQ42Imvz/bVBx7+5i+uYd5msGNR7ZlESJpv5c/nkraHHydshhX5M08GOXYTBnqYn8RBP21qmGmMYgCM4ykRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369967; c=relaxed/simple;
	bh=SyJ3SYCF3gRrvu3C7rfv7W/4oAvWqM3anaoKZ2WP8Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRxBHOntaDgDvcMY6Gp+b92/Jo+eSwVsOiG9xULlWYfaYi5IOQLqPr4sysbydC8a8nyOMlESUIohSLWVV+ufceb+pqLUfDOW77ZQ8U1XANMfYjBJG8pmL7LIVkUTm+cIR5eJqC41qmLIqxk4tday5nJvi/NqG5I4ENlk7Cy/v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o2Dl9lqc; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3695841c-d9e7-4c71-a81d-4fca5e1de8fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762369962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPCG4/wKuRgOdZXZHsD5gh/cG/gpHhwNURgx6mdwEdM=;
	b=o2Dl9lqch12Si/UQeahzlhmTvC+ANlu0cTNgNVc+dxHTGCBQ6GeN/RZ0ll8beLDKEk23e8
	Rpvmb7+yBmRfodjZNWm9gtaIyYOrFoYFV4hu/qhnGqD87+9LzJArvZc7FLHrOAboOgsZsX
	6DRa1x6IYuBoLTBqUyGvphBDWA2tpJk=
Date: Wed, 5 Nov 2025 19:12:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/7] bnx2x: convert to use ndo_hwtstamp
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
 <20251103150952.3538205-2-vadim.fedorenko@linux.dev>
 <20251104173737.3f655692@kernel.org>
 <f28ee997-ed08-4123-83ab-3496e88ed815@linux.dev>
 <20251105104610.726fb780@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251105104610.726fb780@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/11/2025 18:46, Jakub Kicinski wrote:
> On Wed, 5 Nov 2025 13:33:08 +0000 Vadim Fedorenko wrote:
>>>>    	bp->hwtstamp_ioctl_called = true;
>>>> -	bp->tx_type = config.tx_type;
>>>> -	bp->rx_filter = config.rx_filter;
>>>> +	bp->tx_type = config->tx_type;
>>>> +	bp->rx_filter = config->rx_filter;
>>>>    
>>>>    	rc = bnx2x_configure_ptp_filters(bp);
>>>
>>> bnx2x_configure_ptp_filters() may return -ERANGE if settings were not applied.
>>> This may already be semi-broken but with the get in place we will make
>>> it even worse.
>>
>> Ah, you mean in case of -ERANGE we will still have new filter
>> configuration set in bp object? It's easy to fix, but it will be
>> some kind of change of behavior. If it's acceptable, I'm happy to send
>> v3 of the patchset.>
> 
> True, you can probably make the -ERANGE handling a separate patch
> for ultimate clarity.

Well, looks like there is a special guard hwtstamp_ioctl_called
implemented, so it looks safe to move the check. I've sent these patches 
as a separate patchset.

