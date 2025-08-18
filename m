Return-Path: <netdev+bounces-214582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B27B2A85C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C51B27861
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1A335BCE;
	Mon, 18 Aug 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTdqJVX4"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597B335BCD
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525228; cv=none; b=oq2t1zqbJrqAL1tLRuZ7id/3967ixbenC+c51RpUjA0jRO713kAdCEpJ4Bo++2R6dFb/aRTXZvWdYfdHpUTJmBnDbF+q4h82hJyWoiPcyH5oRHtbgvz9SUfd6jgqSPXyADJtW2aZLhblFJc8msSxLn7Au5Ci9ecLnEugJn1h/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525228; c=relaxed/simple;
	bh=8n4MLWmvGSgG5D+ZYZnmXbsa5Tw1HpivSRDelbO8OJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/f343DHrhU6VDIcA5xr2RMdqcaUHXA9fZF0GZrRcO5ZbRJCHjdY+bc1feniuOeZ+/auiH23BPKkRVAyxkmrFIszuel3IDw+x+nRNVD1yFD3zqElFUFtTERyV963R5HmTzeypkSkMoV5ADHi9rEM4LkLQTJf8V7K5eTZeSD9W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTdqJVX4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be442867-109f-42fe-8af4-7e5ab4210662@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755525214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe1IC22W1YduwdEbaPqcSOUyLCA5hs/5w/uQP2Z+HMs=;
	b=pTdqJVX4U41sr8k0qYK6JtEjpAed8VQU81rCwFZyL3/hlkbWU5fUVonwguyKBA564ggiDk
	g6WjRKaQCjL8uP7ocyWBE4S5tOEVo/Ey7yNFrN2mQiGVhlH4MTb5kz+iKqn44pDPzhKRPP
	c268qVX/QuIVll4FtdAmJVrKv/X3R9k=
Date: Mon, 18 Aug 2025 14:53:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, rmk+kernel@armlinux.org.uk,
 rosenp@gmail.com, christophe.jaillet@wanadoo.fr, viro@zeniv.linux.org.uk,
 quentin.schulz@bootlin.com, atenart@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250818132141.ezxmflzzg6kj5t7k@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/08/2025 14:21, Vladimir Oltean wrote:
> On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
>> diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
>> index 37e3e931a8e53..800da302ae632 100644
>> --- a/drivers/net/phy/mscc/mscc_main.c
>> +++ b/drivers/net/phy/mscc/mscc_main.c
>> @@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
>>   	return vsc85xx_dt_led_modes_get(phydev, default_mode);
>>   }
>>   
>> +static void vsc85xx_remove(struct phy_device *phydev)
>> +{
>> +	struct vsc8531_private *priv = phydev->priv;
>> +
>> +	skb_queue_purge(&priv->rx_skbs_list);
>> +}
> 
> Have you tested this patch with an unbind/bind cycle? Haven't you found
> that a call to ptp_clock_unregister() is also missing?

It was missing before this patch as well, probably needs another patch
to fix this issue

