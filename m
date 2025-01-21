Return-Path: <netdev+bounces-160063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7611FA17FEF
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EF53A2FCA
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A771F3D3C;
	Tue, 21 Jan 2025 14:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AF1F3D51
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470186; cv=none; b=KaumIUToXrknzjh4jxlBuN/YuMJ8sUKw3h0gRyTepn0EreQ2XTYwzc/hHLn7QrR2RPdWNs4ZBQPxpqaQ3cNiCdyfwkgWw6ReY9cIx8AmYGUc9bgn8W3CUCSDKLQYatV/oCayG9uF1defHpLZ5ZGQNgZWl/OoDVRfuKLZRpoOCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470186; c=relaxed/simple;
	bh=hsdTDRdueMnbG+uiskwcVMhMRMBzdXwYvgRD/QiFinw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaHp7MG9a4E+ZlKthEZWpST+XU88Gq9RcI+IM0iCcv370vas6e2iUfvj+LN4FfbBpWsSCtKXNjeQEVuElgP82CA9ehzyG5yh4M0IM5CTJWw8NLlQ0yBs3aoXAIl35m2kVABjAyfcxfyDrcZn4PS+REj+4Wk45TGYKhzkio5ho1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1taFMT-0007tg-PJ; Tue, 21 Jan 2025 15:36:13 +0100
Message-ID: <5c4be0e8-d8c5-4955-98c7-7face42fbb5c@pengutronix.de>
Date: Tue, 21 Jan 2025 15:36:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 Jakub Kicinski <kuba@kernel.org>, Laurent Badel <laurentbadel@eaton.com>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20250121103857.12007-3-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi,

On 21.01.25 11:38, Csókás, Bence wrote:
> The core is reset both in `fec_restart()`
> (called on link-up) and `fec_stop()`
> (going to sleep, driver remove etc.).
> These two functions had their separate
> implementations, which was at first only
> a register write and a `udelay()` (and
> the accompanying block comment).
> However, since then we got soft-reset
> (MAC disable) and Wake-on-LAN support,
> which meant that these implementations
> diverged, often causing bugs. For instance,
> as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`. To eliminate
> this bug-source, refactor implementation
> to a common function.

please make the lines a bit longer for v2. 43 characters is much too limited.

Thanks,
Ahmad

> 
> Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Recommended options for this patch:
>     `--color-moved --color-moved-ws=allow-indentation-change`
> 
>  drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..850ef3de74ec 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1064,6 +1064,27 @@ static void fec_enet_enable_ring(struct net_device *ndev)
>  	}
>  }
>  
> +/* Whack a reset.  We should wait for this.
> + * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> + * instead of reset MAC itself.
> + */
> +static void fec_ctrl_reset(struct fec_enet_private *fep, bool wol)
> +{
> +	if (!wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> +		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
> +		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
> +			writel(0, fep->hwp + FEC_ECNTRL);
> +		} else {
> +			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
> +			udelay(10);
> +		}
> +	} else {
> +		val = readl(fep->hwp + FEC_ECNTRL);
> +		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
> +		writel(val, fep->hwp + FEC_ECNTRL);
> +	}
> +}
> +
>  /*
>   * This function is called to start or restart the FEC during a link
>   * change, transmit timeout, or to reconfigure the FEC.  The network
> @@ -1080,17 +1101,7 @@ fec_restart(struct net_device *ndev)
>  	if (fep->bufdesc_ex)
>  		fec_ptp_save_state(fep);
>  
> -	/* Whack a reset.  We should wait for this.
> -	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> -	 * instead of reset MAC itself.
> -	 */
> -	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
> -	    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
> -		writel(0, fep->hwp + FEC_ECNTRL);
> -	} else {
> -		writel(1, fep->hwp + FEC_ECNTRL);
> -		udelay(10);
> -	}
> +	fec_ctrl_reset(fep, false);
>  
>  	/*
>  	 * enet-mac reset will reset mac address registers too,
> @@ -1344,22 +1355,7 @@ fec_stop(struct net_device *ndev)
>  	if (fep->bufdesc_ex)
>  		fec_ptp_save_state(fep);
>  
> -	/* Whack a reset.  We should wait for this.
> -	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> -	 * instead of reset MAC itself.
> -	 */
> -	if (!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> -		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
> -			writel(0, fep->hwp + FEC_ECNTRL);
> -		} else {
> -			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
> -			udelay(10);
> -		}
> -	} else {
> -		val = readl(fep->hwp + FEC_ECNTRL);
> -		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
> -		writel(val, fep->hwp + FEC_ECNTRL);
> -	}
> +	fec_ctrl_reset(fep, true);
>  	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
>  	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
>  


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

