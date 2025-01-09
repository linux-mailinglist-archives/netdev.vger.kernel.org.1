Return-Path: <netdev+bounces-156886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DCA08368
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69DF168FB9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F5205E2F;
	Thu,  9 Jan 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHjHdouV"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2C1FCFF7
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465064; cv=none; b=JrklXU+WvCdP6v/t7mXsW8KRdHZcqmYYnruaTWzyNzng9F4YulRdIRPdyZRVEK9vb8ba949kSlCfEpsrHTsBWFeehzgBQvMmqlrtPi/uG2z0cjDdnLT4B6A7IauGYeuMMZsTfvdgcyWevauilbOoIchPi6dDH8rD/DyAIAz7u7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465064; c=relaxed/simple;
	bh=fK4BhzON9616F3GKp3F5hG/ybmIxpnX5Q03z+puuedQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRU9h1MM8vcTJY4swXzAei9LdQ8R/insnR6irOPKPyXkRCkpN0EcMcaVDX/gQWooHxHqWIVTQoiiGOwx5OI28kZVpkD0O74FSO8neoIPx6uPuqvJEdW+2jRGlv/3GLjEcfMH0BTXHwZwStD6EuqrLeFbi24uDjHQL8d6OjRst48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHjHdouV; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b819ac4-a282-4413-aa45-356563550198@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736465059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V7la2Ow0dmMmaXPhyzYEGUuO3tHH+m08W0Z8ZWwrZA=;
	b=jHjHdouV9m1wON/w/VN2qk2cwYN9hSBt+dOM6o6IC8nRm39mMpwrvsZmqFts3iJb52/Hra
	Oj7Z5+07NG9FYx6Wms7UNHr+5bwxjzotbABllcYJyyBjtGn0imQTvGXt+jiqKnl6kYNQi0
	8ITiiMuErzJeGJJ3LNMOLRXnxTpNZ14=
Date: Thu, 9 Jan 2025 18:24:14 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andy Chiu <andy.chiu@sifive.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109224246.1866690-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250109224246.1866690-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/9/25 17:42, Sean Anderson wrote:
> If coalece_count is greater than 255 it will not fit in the register and
> will overflow. This can be reproduced by running
> 
>     # ethtool -C ethX rx-frames 256
> 
> which will result in a timeout of 0us instead. Fix this by checking for
> invalid values and reporting an error.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> ---
> 
> Changes in v3:
> - Validate and reject instead of silently clamping
> 
> Changes in v2:
> - Use FIELD_MAX to extract the max value from the mask
> - Expand the commit message with an example on how to reproduce this
>   issue
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 0f4b02fe6f85..c2991aeccf2b 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2056,6 +2056,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>  		return -EBUSY;
>  	}
>  
> +	if (ecoalesce->rx_max_coalesced_frames > 255 ||
> +	    ecoalesce->rx_max_coalesced_frames > 255) {

The second line should be for tx and not rx.

Will resend tomorrow if no other feedback.

--Sean

> +		NL_SET_ERR_MSG(extack, "frames must be less than 256");
> +		return -EINVAL;
> +	}
> +
>  	if (ecoalesce->rx_max_coalesced_frames)
>  		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
>  	if (ecoalesce->rx_coalesce_usecs)


