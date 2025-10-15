Return-Path: <netdev+bounces-229731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4942BE04B7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1282519A5DBC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187A29BDAD;
	Wed, 15 Oct 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI/ITcpL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B571DDC07;
	Wed, 15 Oct 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554895; cv=none; b=Ewcij13ju1I5VwtEuJFFulREJjHEbFPcamJbcbpqeMTJFnMEu/8mBNNAW/471uj16ChhBfksk2GrZnVtE5PLt8sIRjb2+zZ9csFeMtaZmPdWeJ6/Tg7CA7B/k97oyoa396L2gZJWudbtSLfpQAzRSJgooGELmmIDGfO2dljwLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554895; c=relaxed/simple;
	bh=teOjTco003Dl7Ikn7APvto+WenjQ/oNmG4X5yaZV9qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArrYPoUo8bcRdqSLSL+HKp3d00MD35J6fC27MzidhR91n72OANPfe0OdRZbUN41Jj+S31HNnodMbFxhCFbNOccO1E+Gr3JkIA8dR0mTt25JJVLQEk96/ToL2V+Lzr7k835iaUlXdshFOqc0RzGCRPuLYWWBBqZko6+kwjaJS1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI/ITcpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28274C4CEFB;
	Wed, 15 Oct 2025 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760554894;
	bh=teOjTco003Dl7Ikn7APvto+WenjQ/oNmG4X5yaZV9qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aI/ITcpLndwAXbTohr7cv02xQXDQkizM+q8bZBPcjcb8GjH09H8SCIxYs3xNCNgyB
	 GDFjUsmenKpbrBG84IA10L6Gzq4yEW4F8Mtg7qoSwemJP2d5ZIJvrtQhJM0gz2wMwo
	 7XPruqc4rer/Po4TIAS7lHCICnXT109W+0Hp7wOTRh6BuoUIQhr1bEKglmkuuTiMOi
	 s4qk1sWR5EXjUIqaR5PU8MNd2kPYlM9tz1SXUE4G1w5fngOPbHzHn9T8kPe3oJRaL8
	 puLKS6blUXsTu1xJIqCIpSM3WNPAIsokHjbaNdmo2fd2PhixjPVFzDflkvhkWXWKso
	 /u48Y27xbFfVQ==
Message-ID: <22bed3ca-fb18-424f-82db-3e25fc49e3f8@kernel.org>
Date: Wed, 15 Oct 2025 13:01:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix use of improperly
 initialized dev->chipid in lan78xx_reset
To: I Viswanath <viswanathiyyappan@gmail.com>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
References: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 12:16 PM, I Viswanath wrote:
> dev->chipid is used in lan78xx_init_mac_address before it's initialized:
> 
> lan78xx_reset() {
>      lan78xx_init_mac_address()
>          lan78xx_read_eeprom()
>              lan78xx_read_raw_eeprom() <- dev->chipid is used here
> 
>      dev->chipid = ... <- dev->chipid is initialized correctly here
> }
> 
> Reorder initialization so that dev->chipid is set before calling
> lan78xx_init_mac_address().
> 
> Fixes: a0db7d10b76e ("lan78xx: Add to handle mux control per chip id")
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
> v1:
> Link: https://lore.kernel.org/netdev/20251001131409.155650-1-viswanathiyyappan@gmail.com/
> 
> v2:
> - Add Fixes tag
> 
>   drivers/net/usb/lan78xx.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 42d35cc6b421..b4b086f86ed8 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -3247,10 +3247,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
>   		}
>   	} while (buf & HW_CFG_LRST_);
>   
> -	ret = lan78xx_init_mac_address(dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	/* save DEVID for later usage */
>   	ret = lan78xx_read_reg(dev, ID_REV, &buf);
>   	if (ret < 0)
> @@ -3259,6 +3255,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
>   	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
>   	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
>   
> +	ret = lan78xx_init_mac_address(dev);
> +	if (ret < 0)
> +		return ret;
> +
>   	/* Respond to the IN token with a NAK */
>   	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
>   	if (ret < 0)

Looks good to me.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid

