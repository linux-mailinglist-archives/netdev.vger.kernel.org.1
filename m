Return-Path: <netdev+bounces-130843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BA98BBC2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BE11F21E78
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8461190679;
	Tue,  1 Oct 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArmA8pYi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D733209
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784168; cv=none; b=nEyIbDxFx9gEAEsqyAjJQeTsjEA9Yc2rss5bsbM2PX6h6zscznmxMTyCJz9GcuFzVjud7l6eWA/57vTmYyavi3DifKPGPawItwej4jQ3YWz2AkPp8uMq5tLQjN4zxnXFPhc14PDwmW7dmW2S54Zm9chYVnJ4RKikWDKGYsziYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784168; c=relaxed/simple;
	bh=pQgBCDzP7qWnO2A24+gszxFUxDCUQLKgDAprlf4MkZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS5iZv7dg9xJscFahBX0OF/M44CVnkwKRgBesUfS8eMMI2SVeCMT0qq+i29R1DC8wPTxwc8AQGiomvCbeJ2uLX9T3ugY02PFkgI6H85/LO2c7bY7CRVFWVP3z4RPcBFTQHGHxiWpRsNSQ3Q2zeGRE/xvnpGMP4EyqBU6kww6New=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArmA8pYi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c5cc5ef139so693813a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727784165; x=1728388965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/qGRABjk3+8yuCIRkcQ4gGUdj6+0aPbtv5c1ozShFM=;
        b=ArmA8pYiYP8UjnCm58a0+8NVWCn0EFkhSm/itNr4sdToVzHx03D4YOO8+A9NR4GfLq
         T3wTUzFYrL7ekLb82KeNyAbdeD5ewSBjJBqZSCVXuP32nbx3IxdlYXfpWD4/iK3FPTdA
         nH5scCdR1FvWixxKL067PzUc18D9rCbWlMaEs09sBUoKXdywsYdUqNgIoT71P4q34pZ7
         ClpWWG5LdUrNduSX8Xzblt8dD05T8/k+pNmNq69xlkGdypKGAlgyAvJmSgy+oGeXspMA
         OS8Pex4LV91+3+mXcgSbEsq3W21TAwz69Qu5qgelFFkk5VrKkzhQ07p4qqVtWLHnPSqJ
         x8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727784165; x=1728388965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/qGRABjk3+8yuCIRkcQ4gGUdj6+0aPbtv5c1ozShFM=;
        b=DQoiPdMQi3Pppj7sSxgddLgWJdLXjG6b9tiXMIWZUMMvZKYiyVc6gVeuPrtjPVg8zx
         h5Nwpy7CSIjoS7YBpCCMP6hYSfUKVWOb5hnzkr5tVxgP+ubj1+2VX0aTqQhbg5Jt1EFx
         WO1ZX+HSEhMewpTPZzbA1mTsrF5/9aAgcaUqpADqzZuOzI0cVUBjieimjtFSNbglipvY
         D6tcPZm5L7Nm8zaapuC+XlnFlPIm06b3XOWFm226wYmBtwY3pf2c25v7F/E61NM/rUQf
         31qiVzv35C0YmpIuAbOKbFmpxRij9CEgo20OiOnypXTwJUK6GWsJIf7R3Ctn78fXP0+N
         uSKg==
X-Gm-Message-State: AOJu0YwLCBiGBKQt8QgtZ2lMoAektlTRTSoB0Tv0mV3lqXEQGWXxHrA5
	4r8HZELZh7rPjQ6UNniWUXL9GBuCY7qI4Cp8W29PcTJuWuiSik1y
X-Google-Smtp-Source: AGHT+IHWHsADhrlZ9MLBSPpIoALYCdkr/KWBkGVrCHiZub5aTSHmTdsWGeG3gQragKWRUs4IfQugrA==
X-Received: by 2002:a05:6402:13d2:b0:5c5:c5fc:1aa6 with SMTP id 4fb4d7f45d1cf-5c882600859mr5595173a12.5.1727784164232;
        Tue, 01 Oct 2024 05:02:44 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e737sm6086543a12.56.2024.10.01.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:02:42 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:02:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Message-ID: <20241001120240.isoja7wzg4mqhj3g@skbuf>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
 <20241001090151.876200-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
 <20241001090151.876200-1-alexander.sverdlin@siemens.com>

On Tue, Oct 01, 2024 at 11:01:48AM +0200, A. Sverdlin wrote:
> From: Anatolij Gustschin <agust@denx.de>
> 
> Accessing device registers seems to be not reliable, the chip
> revision is sometimes detected wrongly (0 instead of expected 1).
> 
> Ensure that the chip reset is performed via reset GPIO and then
> wait for 'Device Ready' status in HW_CFG register before doing
> any register initializations.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> [alex: added msleep() + justification for tout]
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/dsa/lan9303-core.c | 38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index 268949939636a..5744e7ac436fb 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -839,6 +839,8 @@ static void lan9303_handle_reset(struct lan9303 *chip)
>  	if (!chip->reset_gpio)
>  		return;
>  
> +	gpiod_set_value_cansleep(chip->reset_gpio, 1);
> +
>  	if (chip->reset_duration != 0)
>  		msleep(chip->reset_duration);
>  
> @@ -863,9 +865,45 @@ static int lan9303_disable_processing(struct lan9303 *chip)
>  
>  static int lan9303_check_device(struct lan9303 *chip)
>  {
> +	/*
> +	 * Loading of the largest supported EEPROM is expected to take at least
> +	 * 5.9s
> +	 */
> +	int tout = 6000 / 30;
>  	int ret;
>  	u32 reg;
>  
> +	do {
> +		ret = lan9303_read(chip->regmap, LAN9303_HW_CFG, &reg);
> +		if (ret) {
> +			dev_err(chip->dev, "failed to read HW_CFG reg: %d\n",
> +				ret);
> +		}
> +		tout--;
> +
> +		dev_dbg(chip->dev, "%s: HW_CFG: 0x%08x\n", __func__, reg);
> +		if ((reg & LAN9303_HW_CFG_READY) || !tout)
> +			break;
> +
> +		/*
> +		 * In I2C-managed configurations this polling loop will clash
> +		 * with switch's reading of EEPROM right after reset and this
> +		 * behaviour is not configurable. While lan9303_read() already
> +		 * has quite long retry timeout, seems not all cases are being
> +		 * detected as arbitration error.
> +		 *
> +		 * According to datasheet, EEPROM loader has 30ms timeout
> +		 * (in case of missing EEPROM).
> +		 */
> +		msleep(30);
> +	} while (true);
> +
> +	if (!tout) {
> +		dev_err(chip->dev, "%s: HW_CFG not ready: 0x%08x\n",
> +			__func__, reg);
> +		return -ENODEV;
> +	}
> +

Can this be written with read_poll_timeout()?

>  	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
>  	if (ret) {
>  		dev_err(chip->dev, "failed to read chip revision register: %d\n",
> -- 
> 2.46.0
> 


