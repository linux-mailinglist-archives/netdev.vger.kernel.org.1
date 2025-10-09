Return-Path: <netdev+bounces-228317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1F1BC773E
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 102683512ED
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 05:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4E2627EC;
	Thu,  9 Oct 2025 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlPROR1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526234BA49
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988477; cv=none; b=NK0V4Vx3SpVUI1jShfQyWbgVV19P0729SCK5L8NpYtRo7mMvWBCPLw2guMQ5TqKHYeEflshQLd61GuqLTYfHCxB+HqCHjZ0ChSSxE82aZkf2UiLLV+v/aTiaOsQ7Rx8f7o5zK5+t6IlPfgPSdsMBhdMvcoZWir1pz7wxZuJ1vMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988477; c=relaxed/simple;
	bh=U7g6KkV2IFnVrQikZSPZ1dcFlLVplBkp4l5QFbLACbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMaG4l9/Y/gY1IL4qI4KEZI4V/6KzHp7AUVrkU6MQPXp8qWUdFFEMTRerEVtFXTgIbBI5hcaKdaH6GokEMNltSqKkg5xgRZB51kqfYONNlQ4WjR5OdaGkQdLEJzk6DzyVIBHomvCs36yR92FPqe1GuUTQz1mktMRQprJjshvHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlPROR1Q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so648400b3a.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 22:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759988474; x=1760593274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KNKsCp2Ww11qIKHJ00jyA6DJfSKlBk9NjUhCjdbmcc=;
        b=MlPROR1QdnJHwGy1Pxg4JeitOCx4xPZ2WhXHglt5lweA0bH0o/v4/1caXnWkLlawc4
         CTxMj/Bmp0FaQdZhkbY4lQCAhtLI/tKE8sZVGwhs62ltgn0tZcTKl3mrOMx9lFDcZzfT
         NE1ROT2vqqH3Atw8RabGiN/fM+v5nVkGKoRywHpwSGGjNgE+5riBjgoEtCoL7HE1k6lq
         OZDc4F1GK8QWJKa9uPH2vjDkhKP5DN3L7G1ajvBNqnN2BIFDHlEzhPEBBsHw9QSRnGk6
         pEC1tZZUK5iMIce0X/W1iY9zNdvfs97QceSw+cFwKV3nAZcDJoN/wBwFI0ZgbdnuJgKn
         nQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988474; x=1760593274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KNKsCp2Ww11qIKHJ00jyA6DJfSKlBk9NjUhCjdbmcc=;
        b=RGxeeayYpKe34q4ZzToptRHwDvJqxNHlQYglAQ9DEj6kk1ShlGBBnTmw2RYzo2+RA9
         w9+QWz0FvhqKlDDPWudPcj4+FnUtPu2dZg7nKI+n4WnLhf5BhtDuRticOmDgwdNVi0Qe
         84/+Qwbe1ftF98mVXrj6/99tJhpbfWjrt4/u9Jr7RV3lgtWAbBkKEdIJn0ODc30ATH5Y
         2EcfKk1rGLAsjo+UAa35dEVMYbOEBxP/lLhsRZ/knQJw2VisQEJmDyxfaY4KKtbg2Me5
         MJgkveIu7KPI1IltiCJcnRHmB1KYDsJ2s639tTrp4Q4rV5K/iWM9Sy0aD4TzaqCz12jr
         1qOw==
X-Gm-Message-State: AOJu0YxSF6I7Ens7JKGJNtl6jujCcBgiUNRwmVd7kRVJVQ99/X/AP7gG
	8LsKLEjYWYjGoxqrC6hxYZZMUq7ckJR3+zPnC7O1pJYllqaOGCymhq2H
X-Gm-Gg: ASbGncshNARZH2769UAxO59DxdsneO5wegUbWcP1I+b7rMms8K2B1Z6HRV5xz10OAm0
	DjsgCEC8IwgZ3Dli6stGLJXey1CNgOT5MgnK8hzVbEoOfP7LYD2I33UWrk6UNhMI5pQhII9xxIu
	P0H202rg88jXVim4aHwDo16j4ZkSeN3l6tRf+sgl/AZ5bYOKHP11+tvmCKaM9iHNUN1GZVHvJcC
	u9ptek3UqnoqNLPHBh9UmAGtA93eYNXj+ReT/0R6h5t6MyZfVkikM338f2S4tDRUtdIEPtE0gUq
	Vlujv92fKIJ4C7eGky2w3zVI9s228o66+WS5dAJHowEhmAZw/3VzFWFtnw6rNbYB/LBtOpljgDP
	8djnPZvO/M/xZ7JXJoYbfr+kq5pTbP6P10rdzCdquPJvLyy0ouLPuGd4R1xCcvDzOXYw=
X-Google-Smtp-Source: AGHT+IE9oykuetNbvR+7em1eWM6yMVpGn5cles1cEeIi0mcRnMwvIGU8Ccu1Dh5yRdwJE+IrZiL2mg==
X-Received: by 2002:a05:6300:7110:b0:32d:b924:f90e with SMTP id adf61e73a8af0-32db9251bfdmr3011937637.29.1759988474177;
        Wed, 08 Oct 2025 22:41:14 -0700 (PDT)
Received: from [10.0.2.15] ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f3b041sm19842042a12.24.2025.10.08.22.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:41:13 -0700 (PDT)
Message-ID: <b183a040-3d1c-47aa-a41a-9865ba70b94d@gmail.com>
Date: Thu, 9 Oct 2025 11:11:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout
 error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, stable@vger.kernel.org
References: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/25 11:00, Bhanu Seshu Kumar Valluri wrote:
> The function lan78xx_write_raw_eeprom failed to properly propagate EEPROM
> write timeout errors (-ETIMEDOUT). In the timeout  fallthrough path, it first
> attempted to restore the pin configuration for LED outputs and then
> returned only the status of that restore operation, discarding the
> original timeout error saved in ret.
> 
> As a result, callers could mistakenly treat EEPROM write operation as
> successful even though the EEPROM write had actually timed out with no
> or partial data write.
> 
> To fix this, handle errors in restoring the LED pin configuration separately.
> If the restore succeeds, return any prior EEPROM write timeout error saved
> in ret to the caller.
> 
> Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Note:
>  The patch is compiled and tested using EVB-LAN7800LC.
>  The patch was suggested by Oleksij Rempel while reviewing a fix to a bug
>  found by syzbot earlier.
>  The review mail chain where this fix was suggested is given below.
>  https://lore.kernel.org/all/aNzojoXK-m1Tn6Lc@pengutronix.de/
> 
>  ChangeLog:
>  v1->v2:
>   Added cc:stable tag as asked during v1 review.
>   V1 Link : https://lore.kernel.org/all/20251004040722.82882-1-bhanuseshukumar@gmail.com/
> 
>  drivers/net/usb/lan78xx.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index d75502ebbc0d..5ccbe6ae2ebe 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1174,10 +1174,13 @@ static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
>  	}
>  
>  write_raw_eeprom_done:
> -	if (dev->chipid == ID_REV_CHIP_ID_7800_)
> -		return lan78xx_write_reg(dev, HW_CFG, saved);
> -
> -	return 0;
> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
> +		/* If USB fails, there is nothing to do */
> +		if (rc < 0)
> +			return rc;
> +	}
> +	return ret;
>  }
>  
>  static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,

Hi,

The subject prefix must be [PATCH v2] instead. I overlooked it. Should I resend it?

Regards,
Bhanu Seshu Kumar Valluri

