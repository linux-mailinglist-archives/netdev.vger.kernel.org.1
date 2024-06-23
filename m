Return-Path: <netdev+bounces-105937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FE913BC0
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B991F21CE9
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA7181B96;
	Sun, 23 Jun 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gSgGyS3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AE1474C5
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719152918; cv=none; b=i+S6x4OV6ANXoMFAl8v7s3mqVowwJVqrEliWeC5dzpu1EOOx4x4Rdg7r5AEJL/K3102vDL1FAc50tg3fobtku++bzKnvZqciQUPX2trQlS51qmbBevLSRBLPnStLSV9FjfYKx4lFZWnyhl9FHN812X6JR74AiKDgwskgGgvmpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719152918; c=relaxed/simple;
	bh=REj63Oeg1JNeMC+fIOJL4l0TFDuCRg+C0tubzHK0A04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMbBK3B+W73WoylvOuoNKCF4UTBPB00rSgSuYSOAnV8zYoSx7nWmGjiJp3HHtvePcU0Ff9QKKzDdI5rmTRVdPH/kYfk2jhzWHUqHtGPQO8hvqfAuDw+5mfVxY1BfDyKqbfw6RZ7beielND66kiSZq5hHubpEAUZdqRpSHW3ceac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gSgGyS3V; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4247f36f689so24388595e9.1
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719152915; x=1719757715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xn71HCap8eEL8nc/50CL8K4hb31YS8cVq4g5f7tvtks=;
        b=gSgGyS3VWfcK/4VrA4fQlOXxXcBQNs7qKwEEHjVbBaYF/Yq0FH5inASiRBDsKPXQl+
         qozVyyHmzo9CDsSBeMTm/xeDTTXwR7gwCfe1ObbmeZs4aSCUx+fb3MghpuJLEDx7Xpjj
         I4QCOxfi5GTtwmXDyKqdQqNnSPi22NXdWbdSbp4TL3/PSVvNLNVjXyiOH7xNq81Tg2Z7
         99NncQVXQm954w4nOCzW15tCu8yxSoRnmXrZM1A86217P5YjNSlDMO5dxtRxzwyoWnuo
         hn7CnIHSk3MaKnlAv9O4yhafNbe961jdg4+DDqt7DYE0NFMGE5zxBQsaU9xr/RfMv5j3
         XZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719152915; x=1719757715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xn71HCap8eEL8nc/50CL8K4hb31YS8cVq4g5f7tvtks=;
        b=FAI6ZXBVwizPlKTZcR1itPE5clRsFrd8G5iyN+52asYQTwEEHUDgtdN3gnI6/wEt1P
         sSV6SvXc0ceD0tjiqpqLPO7BoPhoryN53/2/RCKRNhhs1s2BpIAVAak0CkBv0ZZFJJKN
         LbclAGX+VDkls33A+LF8IyTvVLaFouJosyXybA6RJm1537IqaYYf4WwdacReEtmObUoz
         I1Um26clUUkdGUwgH4o7HMB7DFR9H4M4vGdEOIl5UBuQ/yTfFVFe1qlRgo/pIsKkEGe0
         fsYWU0nNYjNmbcA/ccCDJa3/2gIpABOxtADgzk6JWpCRXwkCrAGdWvDZj7MCz6ikcZIy
         3Iww==
X-Gm-Message-State: AOJu0YzJX8qLdotWADZnlGeJl9oLO7RcYAUHFi95wMjIBKBu2vKE+zEn
	UUPUozwqapzlZZ0zxsDp5azJdsSWL2VbizTMTP4hIIr0CJiAfsTCJP+wqrpPp4o=
X-Google-Smtp-Source: AGHT+IHnXesk8HWe86BQQ2qZjawCmuQPtAA1Acd3GD7OFlRtZBm/ig1xVzNAdYmY7UF25lbm/Hv78Q==
X-Received: by 2002:a05:600c:26d4:b0:422:aca:f887 with SMTP id 5b1f17b1804b1-4248b9cf993mr20858335e9.28.1719152915591;
        Sun, 23 Jun 2024 07:28:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be9fasm142958035e9.16.2024.06.23.07.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 07:28:34 -0700 (PDT)
Message-ID: <927dc197-03d6-4d1f-9037-eccbdb886e51@tuxon.dev>
Date: Sun, 23 Jun 2024 17:28:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/4] net: macb: Add ARP support to WOL
Content-Language: en-US
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
 <20240621045735.3031357-4-vineeth.karumanchi@amd.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240621045735.3031357-4-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.06.2024 07:57, Vineeth Karumanchi wrote:
> Extend wake-on LAN support with an ARP packet.
> 
> Currently, if PHY supports WOL, ethtool ignores the modes supported
> by MACB. This change extends the WOL modes with MACB supported modes.
> 
> Advertise wake-on LAN supported modes by default without relying on
> dt node. By default, wake-on LAN will be in disabled state.
> Using ethtool, users can enable/disable or choose packet types.
> 
> For wake-on LAN via ARP, ensure the IP address is assigned and
> report an error otherwise.
> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Tested-by: Claudiu Beznea <claudiu.beznea@tuxon.dev> # on SAMA7G5

> ---
>  drivers/net/ethernet/cadence/macb.h      |  1 +
>  drivers/net/ethernet/cadence/macb_main.c | 58 +++++++++++++-----------
>  2 files changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 50cd35ef21ad..122663ff7834 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1306,6 +1306,7 @@ struct macb {
>  	unsigned int		jumbo_max_len;
>  
>  	u32			wol;
> +	u32			wolopts;
>  
>  	/* holds value of rx watermark value for pbuf_rxcutthru register */
>  	u32			rx_watermark;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 4007b291526f..cecc3d6e630f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -38,6 +38,7 @@
>  #include <linux/ptp_classify.h>
>  #include <linux/reset.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/inetdevice.h>
>  #include "macb.h"
>  
>  /* This structure is only used for MACB on SiFive FU540 devices */
> @@ -84,8 +85,7 @@ struct sifive_fu540_macb_mgmt {
>  #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
>  #define MACB_NETIF_LSO		NETIF_F_TSO
>  
> -#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
> -#define MACB_WOL_ENABLED		(0x1 << 1)
> +#define MACB_WOL_ENABLED		BIT(0)
>  
>  #define HS_SPEED_10000M			4
>  #define MACB_SERDES_RATE_10G		1
> @@ -3278,13 +3278,11 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  {
>  	struct macb *bp = netdev_priv(netdev);
>  
> -	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
> -		phylink_ethtool_get_wol(bp->phylink, wol);
> -		wol->supported |= WAKE_MAGIC;
> +	phylink_ethtool_get_wol(bp->phylink, wol);
> +	wol->supported |= (WAKE_MAGIC | WAKE_ARP);
>  
> -		if (bp->wol & MACB_WOL_ENABLED)
> -			wol->wolopts |= WAKE_MAGIC;
> -	}
> +	/* Add macb wolopts to phy wolopts */
> +	wol->wolopts |= bp->wolopts;
>  }
>  
>  static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
> @@ -3294,22 +3292,15 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  
>  	/* Pass the order to phylink layer */
>  	ret = phylink_ethtool_set_wol(bp->phylink, wol);
> -	/* Don't manage WoL on MAC if handled by the PHY
> -	 * or if there's a failure in talking to the PHY
> -	 */
> -	if (!ret || ret != -EOPNOTSUPP)
> +	/* Don't manage WoL on MAC, if PHY set_wol() fails */
> +	if (ret && ret != -EOPNOTSUPP)
>  		return ret;
>  
> -	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
> -	    (wol->wolopts & ~WAKE_MAGIC))
> -		return -EOPNOTSUPP;
> -
> -	if (wol->wolopts & WAKE_MAGIC)
> -		bp->wol |= MACB_WOL_ENABLED;
> -	else
> -		bp->wol &= ~MACB_WOL_ENABLED;
> +	bp->wolopts = (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
> +	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
> +	bp->wol = (wol->wolopts) ? MACB_WOL_ENABLED : 0;
>  
> -	device_set_wakeup_enable(&bp->pdev->dev, bp->wol & MACB_WOL_ENABLED);
> +	device_set_wakeup_enable(&bp->pdev->dev, bp->wol);
>  
>  	return 0;
>  }
> @@ -5086,9 +5077,7 @@ static int macb_probe(struct platform_device *pdev)
>  		bp->max_tx_length = GEM_MAX_TX_LEN;
>  
>  	bp->wol = 0;
> -	if (of_property_read_bool(np, "magic-packet"))
> -		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
> -	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
> +	device_set_wakeup_capable(&pdev->dev, 1);
>  
>  	bp->usrio = macb_config->usrio;
>  
> @@ -5244,7 +5233,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  {
>  	struct net_device *netdev = dev_get_drvdata(dev);
>  	struct macb *bp = netdev_priv(netdev);
> +	struct in_ifaddr *ifa = NULL;
>  	struct macb_queue *queue;
> +	struct in_device *idev;
>  	unsigned long flags;
>  	unsigned int q;
>  	int err;
> @@ -5257,6 +5248,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		return 0;
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
> +		/* Check for IP address in WOL ARP mode */
> +		idev = __in_dev_get_rcu(bp->dev);
> +		if (idev && idev->ifa_list)
> +			ifa = rcu_access_pointer(idev->ifa_list);
> +		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> +			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
> +			return -EOPNOTSUPP;
> +		}
>  		spin_lock_irqsave(&bp->lock, flags);
>  
>  		/* Disable Tx and Rx engines before  disabling the queues,
> @@ -5290,6 +5289,13 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		macb_writel(bp, TSR, -1);
>  		macb_writel(bp, RSR, -1);
>  
> +		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
> +		if (bp->wolopts & WAKE_ARP) {
> +			tmp |= MACB_BIT(ARP);
> +			/* write IP address into register */
> +			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> +		}
> +
>  		/* Change interrupt handler and
>  		 * Enable WoL IRQ on queue 0
>  		 */
> @@ -5305,7 +5311,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  				return err;
>  			}
>  			queue_writel(bp->queues, IER, GEM_BIT(WOL));
> -			gem_writel(bp, WOL, MACB_BIT(MAG));
> +			gem_writel(bp, WOL, tmp);
>  		} else {
>  			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
>  					       IRQF_SHARED, netdev->name, bp->queues);
> @@ -5317,7 +5323,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  				return err;
>  			}
>  			queue_writel(bp->queues, IER, MACB_BIT(WOL));
> -			macb_writel(bp, WOL, MACB_BIT(MAG));
> +			macb_writel(bp, WOL, tmp);
>  		}
>  		spin_unlock_irqrestore(&bp->lock, flags);
>  

