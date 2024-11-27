Return-Path: <netdev+bounces-147625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77A9DAC81
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC9EB21863
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B91E1041;
	Wed, 27 Nov 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRLZ7uix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A48A41;
	Wed, 27 Nov 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728787; cv=none; b=Qvyv+xyy9T5bxVfiMAuEtaDelbg20oJHKpAqm7YqjypK5+rpbA8FptuUJVcsOzNViNM//6VPC/3+HfkyczYiP65xmfCx1d5f84FG9VBQdM8KU6xuLdusTww/KUSBOTTHUt/X1lSVMkpfXY1Xraa3MB1XX0OY5tit1vh7YwR2P3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728787; c=relaxed/simple;
	bh=ROCiRi/yYhXsqy0A3hG8CWASE+jjM3H03lGX9OJe7DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQR1wuDrGWwesiQliwzOjIYiP9MTjnzKICqGhRhbWU6mdKOw6QWjU0733SkUAv8+yghZua+pLv01CGslOMPRdc+XRjGwj2I972fzOWZQOBIbmeoi/fQDlPOc9TKiVeJ7IH8iUQT9JVu+PAzEGeRUqXq3z0qDEIOQ3rG2InMnPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRLZ7uix; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf7aa91733so3894956a12.2;
        Wed, 27 Nov 2024 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728784; x=1733333584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kzYUqODO47hR/WQO2uQfWUqA0kWqjEwrdbtM/DTVfuU=;
        b=MRLZ7uix585zlTPNXMltB1nT+QCHTB/Ng2nXTHxA4vYqX8/eImV48eWVP8/mDU98G5
         defPT5t0zwnKHt0MNYsGtE+2AFvo4PaOa6qTX0zPRw6g9+3mEh++i3LVDPRsuaBT1AR7
         GlHnisXGDqyjL4y/6IqaHBkljWB43GAJT+DJzRJJP4rmKs7FP2xkEku3j0I2IWNuG0Bm
         4cqsJikFbKuJRgavf+rOKgpuF9iCXVfeuQ4vwyi0U38EsvEXrTGy9b822N+ZFQ05FgqU
         386OaFmA3whHiOYzyBB0LxH9MKt4y55C1s6FvRA7dt8mBvZM/vIcJQxzYPhH7Fn2TnpK
         W97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728784; x=1733333584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzYUqODO47hR/WQO2uQfWUqA0kWqjEwrdbtM/DTVfuU=;
        b=uMllxvw8l5HTBcMU4GMQycR20EoU7ibM54yOzVaoveiCrSBnjxTBmfA9wABQqo7Km4
         vBybyG1i41g0XyCSwfIjqedjdb+ewgPyj5CVdbiqXsa9a7uvR/ScXPyOkIbF7do5H0xN
         VuLU/DxCsSxN1QqMAX7p+ySWkU27QFPNJ40L8u7yAT20doOyhSERI6WTc9YVHmElERqf
         cGxvE8T5USqSxVu/Vdxnu5vYf8yUx8RzQwwcnZjvXGTvmc62+RV1X2ZfPPx0I6lsz4LP
         VQlW+h4IXOtDAbTTPurd33l4Of0dj00TfEjwBH/gRVt8ZiaUiqfaiY7G1T+5H2ekPFEf
         uxxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ObpYwzNFKzcwtHIKA1Vch7eljT2JzTfbkBKcLtdxiaktZ31Ze+JU+fRPbKnHQEVXcqKQKoBn@vger.kernel.org, AJvYcCX0jKyJ+1accxJJ385x2c9GdFqSsZNDulrkZfP4cl3Be80AcwrB0HkhE2UV2lVIul85Q5Wxomn1j7Y/5mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOROoHC/J3fnjCQm83VMYSEy46oCTF1gJ/bHtsevvL5vSkVnN
	6f+WX6f8geXLgl+uMhNTBhRmTmnOH1195E24E6biB1EZYTdhRKhr
X-Gm-Gg: ASbGncu+WBvGcP7CRkzgkundXSqFzL5UAyGqG4guJ31IUQ1/UraOYEUwnDuB65sTGea
	BLSEOT9omguJ/hKkiUYS2q9TYD0Dt0MbtaoO/nX47igEXp+dnvApdKuQKftetUfifGXZBynN+W2
	MMwzy+/fmkjIcjNv/JowDJs6xLrpQnmhQZKWOFqBDPWuy9MH6dA/LHcesF9wgQ+vHaNvESpRXqQ
	iUISmOmxvmLrmCwp8cDXZ1be3SpxGNvhBTN4ZPKecilPQ6l2+9xJ+R+4Om9p3c2SB1Zc7Ejgl21
	1E7NyCwvwi8bhTWdJ297fHDkliYqfhtVOWu7bQrEaL0RsEypDG2tymneK7h3fI0EuYDwZ7rG8ky
	bvH402ZjBjSgr+2GAYsi5j8aFUwijGpUzKcpBWwYDfQ==
X-Google-Smtp-Source: AGHT+IElZ8X7hhb3RjqL7Mk6thv/lcV/e3xD1JUsnyVdd+rC7/1j3EqdIhv1BaEeptNXbzA5nSihFA==
X-Received: by 2002:a05:6402:26c3:b0:5d0:8f07:eceb with SMTP id 4fb4d7f45d1cf-5d08f07f079mr2572908a12.10.1732728783642;
        Wed, 27 Nov 2024 09:33:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:b12f:4200:648f:850f:5e23:bc2f? (dynamic-2a02-3100-b12f-4200-648f-850f-5e23-bc2f.310.pool.telefonica.de. [2a02:3100:b12f:4200:648f:850f:5e23:bc2f])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d8603dfsm6357269a12.26.2024.11.27.09.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 09:33:02 -0800 (PST)
Message-ID: <dabcacd6-6e51-489c-b8f1-bd104ac4186f@gmail.com>
Date: Wed, 27 Nov 2024 18:33:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 2/2] net. phy: dp83tg720: Add randomized polling
 intervals for unstable link detection
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241127131011.92800-1-o.rempel@pengutronix.de>
 <20241127131011.92800-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241127131011.92800-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.11.2024 14:10, Oleksij Rempel wrote:
> Address the limitations of the DP83TG720 PHY, which cannot reliably detect or
> report a stable link state. To handle this, the PHY must be periodically reset
> when the link is down. However, synchronized reset intervals between the PHY
> and its link partner can result in a deadlock, preventing the link from
> re-establishing.
> 
Out of curiosity: This PHY isn't normally quirky, but completely broken.
Why would anybody use it?

> This change introduces a randomized polling interval when the link is down to
> desynchronize resets between link partners.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/dp83tg720.c | 76 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
> index f56659d41b31..64c65454cf94 100644
> --- a/drivers/net/phy/dp83tg720.c
> +++ b/drivers/net/phy/dp83tg720.c
> @@ -4,12 +4,31 @@
>   */
>  #include <linux/bitfield.h>
>  #include <linux/ethtool_netlink.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/phy.h>
> +#include <linux/random.h>
> 
>  #include "open_alliance_helpers.h"
> 
> +/*
> + * DP83TG720S_POLL_ACTIVE_LINK - Polling interval in milliseconds when the link
> + *				 is active.
> + * DP83TG720S_POLL_NO_LINK_MIN - Minimum polling interval in milliseconds when
> + *				 the link is down.
> + * DP83TG720S_POLL_NO_LINK_MAX - Maximum polling interval in milliseconds when
> + *				 the link is down.
> + *
> + * These values are not documented or officially recommended by the vendor but
> + * were determined through empirical testing. They achieve a good balance in
> + * minimizing the number of reset retries while ensuring reliable link recovery
> + * within a reasonable timeframe.
> + */
> +#define DP83TG720S_POLL_ACTIVE_LINK		1000
> +#define DP83TG720S_POLL_NO_LINK_MIN		100
> +#define DP83TG720S_POLL_NO_LINK_MAX		1000
> +
>  #define DP83TG720S_PHY_ID			0x2000a284
> 
>  /* MDIO_MMD_VEND2 registers */
> @@ -355,6 +374,11 @@ static int dp83tg720_read_status(struct phy_device *phydev)
>  		if (ret)
>  			return ret;
> 
> +		/* The sleep value is based on testing with the DP83TG720S-Q1
> +		 * PHY. The PHY needs some time to recover from a link loss.
> +		 */
What is the issue during this "time to recover"?
Is errata information available from the vendor?

> +		msleep(600);
> +
>  		/* After HW reset we need to restore master/slave configuration.
>  		 * genphy_c45_pma_baset1_read_master_slave() call will be done
>  		 * by the dp83tg720_config_aneg() function.
> @@ -482,6 +506,57 @@ static int dp83tg720_probe(struct phy_device *phydev)
>  	return 0;
>  }
> 
> +/**
> + * dp83tg720_phy_get_next_update_time - Determine the next update time for PHY
> + *                                      state
> + * @phydev: Pointer to the phy_device structure
> + *
> + * This function addresses a limitation of the DP83TG720 PHY, which cannot
> + * reliably detect or report a stable link state. To recover from such
> + * scenarios, the PHY must be periodically reset when the link is down. However,
> + * if the link partner also runs Linux with the same driver, synchronized reset
> + * intervals can lead to a deadlock where the link never establishes due to
> + * simultaneous resets on both sides.
> + *
> + * To avoid this, the function implements randomized polling intervals when the
> + * link is down. It ensures that reset intervals are desynchronized by
> + * introducing a random delay between a configured minimum and maximum range.
> + * When the link is up, a fixed polling interval is used to minimize overhead.
> + *
> + * This mechanism guarantees that the link will reestablish within 10 seconds
> + * in the worst-case scenario.
> + *
> + * Return: Time (in milliseconds) until the next update event for the PHY state
> + * machine.
> + */
> +static unsigned int dp83tg720_phy_get_next_update_time(struct phy_device *phydev)
> +{
> +	unsigned int jiffy_ms = jiffies_to_msecs(1); /* Jiffy granularity in ms */
> +	unsigned int next_time_ms;
> +
> +	if (phydev->link) {
> +		/* When the link is up, use a fixed 1000ms interval */
> +		next_time_ms = DP83TG720S_POLL_ACTIVE_LINK;
> +	} else {
> +		unsigned int min_jiffies, max_jiffies, rand_jiffies;
> +		/* When the link is down, randomize interval between
> +		 * configured min/max
> +		 */
> +
> +		/* Convert min and max to jiffies */
> +		min_jiffies = msecs_to_jiffies(DP83TG720S_POLL_NO_LINK_MIN);
> +		max_jiffies = msecs_to_jiffies(DP83TG720S_POLL_NO_LINK_MAX);
> +
> +		/* Randomize in the jiffie range and convert back to ms */
> +		rand_jiffies = min_jiffies +
> +			get_random_u32_below(max_jiffies - min_jiffies + 1);
> +		next_time_ms = jiffies_to_msecs(rand_jiffies);
> +	}
> +
> +	/* Ensure the polling time is at least one jiffy */
> +	return max(next_time_ms, jiffy_ms);
> +}
> +
>  static struct phy_driver dp83tg720_driver[] = {
>  {
>  	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
> @@ -500,6 +575,7 @@ static struct phy_driver dp83tg720_driver[] = {
>  	.get_link_stats	= dp83tg720_get_link_stats,
>  	.get_phy_stats	= dp83tg720_get_phy_stats,
>  	.update_stats	= dp83tg720_update_stats,
> +	.get_next_update_time = dp83tg720_phy_get_next_update_time,
> 
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
> --
> 2.39.5
> 


