Return-Path: <netdev+bounces-213502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B65B255EF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345D57A61A9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D882BDC2B;
	Wed, 13 Aug 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTog7zuQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949623009CB;
	Wed, 13 Aug 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121888; cv=none; b=tBh40erLEnh+Ce+aPoaFRWPXSswDegTDmjRbtD1jm5ElWmqXQSTwuGv+YS3bRRSg8usn8txiE9dErmB09ABkGqOwrI0/0C16PAuTULvgiV/0dToB3B5SbzWwMVI+6WHptDIidyiyhyxq9XhQPgPR+oGKMFgIB9pyp0ZTBOZoC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121888; c=relaxed/simple;
	bh=5F8EEBGF7NpuTGwYMI/wUerdlii1addjaF7AtasrlmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNkRXM+R1zBszaIA5hX6VWjnBuHu3b6ctXxza+rOq6FAM32j2ilEEcnx7f/viLg4vu6lVh3/jab49OCRPsWjujNNxyHZmHdUKAsxeyV8jlK4BtQuomzCRmpGDEwlIgww83hIV5oWdU6D72bWyZYVcCTEaKhqj4nCNfpMEGoKt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTog7zuQ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b25635ec-0ab3-4c90-9fb9-b9c5c1748590@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755121883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X2T2a5oAnnfM7V6t2lvvrUsAnEiflVCEAk8ZEzo21I=;
	b=jTog7zuQpeAsBN+gkS45v6q/fnhpuX1etNGl0fb0VzrQQvw3dsyrsEje1rKHM1dITrHFMb
	MSPEB50SRgAmtVMUd2+gicAEvgCIZqkiVm6xtDA3SW0gIDFxj/PZMiaGk5x9ZObV2JrzLq
	wSR6d/7ZiV4NyhIgAYj+VC/Di+ZaAGQ=
Date: Wed, 13 Aug 2025 22:51:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] phy: mscc: Fix timestamping for vsc8584
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, viro@zeniv.linux.org.uk, atenart@kernel.org,
 quentin.schulz@bootlin.com, olteanv@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/08/2025 06:46, Horatiu Vultur wrote:
> There was a problem when we received frames and the frames were
> timestamped. The driver is configured to store the nanosecond part of
> the timestmap in the ptp reserved bits and it would take the second part
> by reading the LTC. The problem is that when reading the LTC we are in
> atomic context and to read the second part will go over mdio bus which
> might sleep, so we get an error.
> The fix consists in actually put all the frames in a queue and start the
> aux work and in that work to read the LTC and then calculate the full
> received time.

The expectation here is that aux worker will kick in immediately and the
processing will happen within 1 second of the first stamped skb in the
list. Why cannot you keep cached value of PHC, which is updated roughly 
every 500ms and use it to extend timestamp? Your aux worker will be much 
simpler, and packet processing will be faster...

> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> v1->v2:
> - use sk_buff_head instead of a list_head and spinlock_t
> - stop allocating vsc8431_skb but put the timestamp in skb->cb
> ---
>   drivers/net/phy/mscc/mscc.h     | 12 ++++++++
>   drivers/net/phy/mscc/mscc_ptp.c | 50 +++++++++++++++++++++++++--------
>   2 files changed, 50 insertions(+), 12 deletions(-)
> 


[...]

>   /* Shared structure between the PHYs of the same package.
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> index 275706de5847c..d368d4fd82e17 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -1194,9 +1194,8 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
>   {
>   	struct vsc8531_private *vsc8531 =
>   		container_of(mii_ts, struct vsc8531_private, mii_ts);
> -	struct skb_shared_hwtstamps *shhwtstamps = NULL;
> +
>   	struct vsc85xx_ptphdr *ptphdr;

No empty line needed.

> -	struct timespec64 ts;
>   	unsigned long ns;
>   

