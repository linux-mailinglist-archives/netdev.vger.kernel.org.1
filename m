Return-Path: <netdev+bounces-189101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD6AB05FC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73309E53B6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59C223DE7;
	Thu,  8 May 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FSXIVHaI"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F811AB52D;
	Thu,  8 May 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743598; cv=none; b=iUAA9gU2EzJRvMl0+X4P5NqPEwHvGVKT5hbB0FcAg4YxoAdCAQ4UoNotjF6Xa/qaGr90hvxsrXwZppEXZ+vsxFqFZoGtbIgyLR47QuZ9MSo+VTYFjHK3FxeEWH8i+xPDb7k2ug579ADACixEgQAMRmN5/ZhbEGq/cvUbx1gao34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743598; c=relaxed/simple;
	bh=Dy9dAmDEtYv1D1W6Os+Dt16ZXrkNQpIpd0MNSk4apV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7C1ydvh03rO9+bJBWt8LCW3r/sKn9ii2+ZPGPuUfrsbK3QWbNOe1cbkjVJJtcVhQ0O4Wy4B6OY8dvdm9zX90OgJZqZVs8YFoj/ZvNp5quorfUNTmLprlTz7hipLsjhB64dcoH8xfw8uJQ56iYrvI5xXonxWUyiJKoaUb2FfaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FSXIVHaI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de814321-7ede-4325-be9e-3dd40be68391@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746743590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HV1W+KoOI60y8Ce+gIw6Y3x5sJ2+CPiqPPkkq5vBFig=;
	b=FSXIVHaIvZLd/3dFmQP+DEjKwMczBbR7FVxNA0dt1iehlcJmWJTMeUWU2vV52R7ZjmXSi/
	iZSiHbUXW/brHwj2ZaScr2boAQLjjy7IVhxH40k/jUPZy6464j5wWBzp43HORJSsyQAH/u
	DYb9uje6klYkCpm74g+UuEhYvJAzkbI=
Date: Thu, 8 May 2025 23:33:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net: cpsw: return proper RX timestamping
 filter in cpsw_hwtstamp_get()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20250508194825.3058929-1-vladimir.oltean@nxp.com>
 <20250508194825.3058929-2-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508194825.3058929-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 20:48, Vladimir Oltean wrote:
> priv->rx_ts_enabled is a boolean variable (0 or 1). Overlapped over enum
> hwtstamp_rx_filters, it makes cfg.rx_filter take the value of either
> HWTSTAMP_FILTER_NONE (when 0) or HWTSTAMP_FILTER_ALL (when 1).

Hmm.. I have to disagree here. rx_ts_enabled is int, not bool:

struct cpsw_priv {
         struct net_device               *ndev;
         struct device                   *dev;
         u32                             msg_enable;
         u8                              mac_addr[ETH_ALEN];
         bool                            rx_pause;
         bool                            tx_pause;
         bool                            mqprio_hw;
         int                             fifo_bw[CPSW_TC_NUM];
         int                             shp_cfg_speed;
         int                             tx_ts_enabled;
         int                             rx_ts_enabled;
         struct bpf_prog                 *xdp_prog;
	....


And it's assigned a value of HWTSTAMP_FILTER_PTP_V2_EVENT in
cpsw_hwtstamp_set(). Not sure this change is actually needed.

> 
> But this is inconsistent with what is returned in cpsw_hwtstamp_set().
> There, HWTSTAMP_FILTER_ALL is refused (-ERANGE), and a subset of the RX
> filters requestable by user space are all replaced with
> HWTSTAMP_FILTER_PTP_V2_EVENT. So the driver should be reporting this
> value during SIOCGHWTSTAMP as well.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/ti/cpsw_priv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
> index 6fe4edabba44..68d8f7ea0e44 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.c
> +++ b/drivers/net/ethernet/ti/cpsw_priv.c
> @@ -687,7 +687,8 @@ static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
>   
>   	cfg.flags = 0;
>   	cfg.tx_type = priv->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
> -	cfg.rx_filter = priv->rx_ts_enabled;
> +	cfg.rx_filter = priv->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT :
> +			HWTSTAMP_FILTER_NONE;
>   
>   	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>   }


