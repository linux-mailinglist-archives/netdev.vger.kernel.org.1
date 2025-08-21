Return-Path: <netdev+bounces-215636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57748B2FB66
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF411889E3E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033CA2EC561;
	Thu, 21 Aug 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IIdBrxiB"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E62EC54D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784245; cv=none; b=Qdd03DGIpjDoDvBfpfvaPlg5Wzd3L3C7KxyXmNtECHgJqQk+JLCDoCD48R3SAlWkf1xWyuOlPQMLJYNMyKgeNjr0tI9fQYMtLcqEigLzeskL6UF1GAS7fZP3XhEylqbtoHTmyV/j/B6SNBXrVbEcyW6Do6Gkb/cKEC1ZjLNxD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784245; c=relaxed/simple;
	bh=mkP5EBWVtTQ9kHiLh25jAo3RKEQvDQzVw+3NRPFyI/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZF6XiYtsdtL6PZkXNr1abXFOALkW8kQzr9Ky5zY05/hncA3CoYIytzmvJvBkSSAsDwLPx5rqOrmgdeJUbNFOI24p9W7/OiO4KEvjFYpzaTJ/3gVpAaZd3nub5RTJiUvW1kMt0lTCX9qc/zoA4NYCEsdoZQ5eCB7o5sENo0TEAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IIdBrxiB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f8cef10-fbfd-42b7-8ab7-f15d46938eb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755784240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwYFnJBhm0vRX0GYykj4YGVN4EjyKu9Q29/B22dumrA=;
	b=IIdBrxiBIWGOgUU+WvYSb2IhHK4WF5kE55nkf29diLcH0wTKJJGUaW/Xl9RCRnn9cdsRPz
	ibtjjwqL16HquecLkIuXRsHQ12x5//AsPk1OHKuwiBorOy//9T5Z0Ga7Ch7znYPSaTTN0O
	yLx6uLjvew26jzqHsICERF1uiSOr148=
Date: Thu, 21 Aug 2025 14:50:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] phy: mscc: Fix when PTP clock is register and
 unregister
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com,
 rmk+kernel@armlinux.org.uk, rosenp@gmail.com, christophe.jaillet@wanadoo.fr,
 viro@zeniv.linux.org.uk, atenart@kernel.org, quentin.schulz@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821104628.2329569-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250821104628.2329569-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/08/2025 11:46, Horatiu Vultur wrote:
> +static void __vsc8584_deinit_ptp(struct phy_device *phydev)
> +{
> +	struct vsc8531_private *vsc8531 = phydev->priv;
>   
> -	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
> -						     &phydev->mdio.dev);
> -	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
> +	ptp_clock_unregister(vsc8531->ptp->ptp_clock);
> +	skb_queue_purge(&vsc8531->rx_skbs_list);
>   }
>   
>   void vsc8584_config_ts_intr(struct phy_device *phydev)
> @@ -1552,6 +1549,18 @@ int vsc8584_ptp_init(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +void vsc8584_ptp_deinit(struct phy_device *phydev)
> +{
> +	switch (phydev->phy_id & phydev->drv->phy_id_mask) {
> +	case PHY_ID_VSC8572:
> +	case PHY_ID_VSC8574:
> +	case PHY_ID_VSC8575:
> +	case PHY_ID_VSC8582:
> +	case PHY_ID_VSC8584:
> +		return __vsc8584_deinit_ptp(phydev);

void function has no return value. as well as it shouldn't return
anything. I'm not quite sure why do you need __vsc8584_deinit_ptp()
at all, I think everything can be coded inside vsc8584_ptp_deinit()

> +	}
> +}

