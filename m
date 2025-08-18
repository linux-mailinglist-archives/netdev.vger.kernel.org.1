Return-Path: <netdev+bounces-214516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D75B2A005
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE53C7B5A1A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266F30DEC8;
	Mon, 18 Aug 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kvhhAM/l"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF66261B67
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515228; cv=none; b=TD3qkbAQnNJGHJCB4qMRx35MVnYnDyw6p4q8xBfh0gqEDROJBXLbvyFUAKR5qcgSxcMEowsUF8z8+W8lzSl9qVo0Ih2v6UXGmg4z2jBGouqAQazxEOJOiKkjpWk00L/RmMjnUoykL4zQ3MbEqhhJpzlvS+Uwu6VhK+bQurFZLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515228; c=relaxed/simple;
	bh=KkRWsU9GEcmKhIcbI+UJZgptxr43GIeeAg1UbQNYROg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXfhUddsmhr9ogHCPtUSNYrktLip74NS45Nu8QlTfr5QUcvaDVHfbUIRa6Au5ci/ZTWnrSIYl9KKWesjWTi1+A1PsrxHfn0vNqT1JlPh7Gswa0EDPDM493hv++w6nA9ILYeX7XOFcfoN84hje327U8Jqm+QvicHALo9FcZUy5p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kvhhAM/l; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4817ccc-bc8e-4a29-b202-ef30d95e8b65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755515213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGyM5mBEI84dMtOki1bsKxgSNO+vJrc7HUUiZpurZKc=;
	b=kvhhAM/lGeri24XGcyBqNkezrDhr1PZhSaYJKNxvFBjv9J+x39KvViENzwfvp9DoQ9DMT1
	8E22LKMOqbRiQV4cdO7u+nstScasO1AVUoRKmi/2gSpFBSeYsI7rmmbOp7pHY0e8Si4KPP
	WiNKwUo7gkV+YYKm2zmD+nAxN7BXUtg=
Date: Mon, 18 Aug 2025 12:06:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/2] microchip: lan865x: fix missing Timer
 Increment config for Rev.B0/B1
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
 <20250818060514.52795-3-parthiban.veerasooran@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250818060514.52795-3-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/08/2025 07:05, Parthiban Veerasooran wrote:
> Fix missing configuration for LAN865x silicon revisions B0 and B1 as per
> Microchip Application Note AN1760 (Rev F, June 2024).
> 
> The Timer Increment register was not being set, which is required for
> accurate timestamping. As per the application note, configure the MAC to
> set timestamping at the end of the Start of Frame Delimiter (SFD), and
> set the Timer Increment register to 40 ns (corresponding to a 25 MHz
> internal clock).
> 
> Link: https://www.microchip.com/en-us/application-notes/an1760
> 
> Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY")
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> ---
>   .../net/ethernet/microchip/lan865x/lan865x.c  | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index d03f5a8de58d..84c41f193561 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -32,6 +32,10 @@
>   /* MAC Specific Addr 1 Top Reg */
>   #define LAN865X_REG_MAC_H_SADDR1	0x00010023
>   
> +/* MAC TSU Timer Increment Register */
> +#define LAN865X_REG_MAC_TSU_TIMER_INCR		0x00010077
> +#define MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS	0x0028
> +
>   struct lan865x_priv {
>   	struct work_struct multicast_work;
>   	struct net_device *netdev;
> @@ -346,6 +350,21 @@ static int lan865x_probe(struct spi_device *spi)
>   		goto free_netdev;
>   	}
>   
> +	/* LAN865x Rev.B0/B1 configuration parameters from AN1760
> +	 * As per the Configuration Application Note AN1760 published in the
> +	 * link, https://www.microchip.com/en-us/application-notes/an1760
> +	 * Revision F (DS60001760G - June 2024), configure the MAC to set time
> +	 * stamping at the end of the Start of Frame Delimiter (SFD) and set the
> +	 * Timer Increment reg to 40 ns to be used as a 25 MHz internal clock.
> +	 */
> +	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_TSU_TIMER_INCR,
> +				    MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to config TSU Timer Incr reg: %d\n",
> +			ret);
> +		goto oa_tc6_exit;
> +	}
> +
>   	/* As per the point s3 in the below errata, SPI receive Ethernet frame
>   	 * transfer may halt when starting the next frame in the same data block
>   	 * (chunk) as the end of a previous frame. The RFA field should be

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

