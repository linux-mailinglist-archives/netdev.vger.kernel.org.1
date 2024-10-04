Return-Path: <netdev+bounces-131957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE679900B7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4591F216B0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC841494AD;
	Fri,  4 Oct 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROgm9ACY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447A137903
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037118; cv=none; b=KlQHPVy3eSb8S4z6Uz0DWDJGlpym/3Tmj5XDJUI/hfj0lP8aD1pTAvChbbeXxoidjYCO+Fd8nJWrMr5RNtfvouqYk67I1YAJwv7voy3FOfiA7zZk56MZyOci77xgce+gBGJXKcgKndkHBDjaxC/rqw0T9zkbLLFKPJPsPeXSmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037118; c=relaxed/simple;
	bh=5P0qWKZiFQG8GAkwKy/5mflbAiOOnZMLETWWEmHwh9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9IS0UU1grDwRfUDJeNbjCQCUX9bFMY+WKWFg40FwmRNZsbryakCdeGaWEG5pJVS5VlkyPzY4ZsBug013IxMQLRVDWMpTc2W58LvNck2K7hGJ7dDdaZmtJKCEHFPI6bpT/E9WbIJgtkL5LDVYrrHKYrgZZiBzE0KMfusJDROEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROgm9ACY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cacd90ee4so2968985e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037115; x=1728641915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fksya9RrVRE6jf5/3hM46ocX2Dai6/5RMjtjvRrt0LE=;
        b=ROgm9ACYZyPL6UeE/PtRqusxSgSmjMiWqFx8TKB7MDy9XHt7nVStz9Unoyn/Nst91P
         oGDbQAHGSsLlqeY0r9Or56TeoQOklGtfZcwKiGoeZLlYida4UYpDjDeMU3ONF5LiQQzp
         9ruEj2vtSUqOBKSty6as9bZRvu+lu3jTVwlkhIAR1yiB7jJdB8ClzzTdZHkjZsOfYQaN
         /A8wm7XQJmjgbqpyzGDDW3KIIeKGie8t8uB76Vr20SLSjRn2OvoICGViQ7FtONfYVfI8
         /IswTAMdkucAcJKy/jzjt+FrvRWlLjt+9G2FGqRTHV4ZDt1u8CWFST70w13WhOepaTRf
         IVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037115; x=1728641915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fksya9RrVRE6jf5/3hM46ocX2Dai6/5RMjtjvRrt0LE=;
        b=bD8d6T5QmPW8mps7OF1c8zxtIk8BCzTVZAtPr5MyQB1hzufJbKyCPHUjOAiUDt8Toz
         yQi67dzQUBlrYxB959SVDexynJQSuyWXsz9xnxh5h2uR9hWJQEmdc1PhM9VcpTaYPAsW
         K6GWnuZ7uudqTYU/RtnyMlymH8SCihsftaiHf48FvC/ok3M00bjxztaHcyet/vRgS9Ev
         VTNfd2wQrWhVkG5GccHGMyo1yNfwqdYrAJVPpIj9IwMuu40bdgrCwOobg8pE6F+2oNXr
         +wCr+mLtfq2sbO+SibJE+tYFUTtSBFnGw1XHW4EMMBZHsJTIJys52COQnhcNZ4Fppxho
         H1Yg==
X-Gm-Message-State: AOJu0Yx6In3SHjs9jWTqX5dllGoTWWG9erVwaurYCQjEH4TD3sgUqVZM
	Oru3TRRlPkqUpiCicc/CA63hRBOlYSCE+VBStxmBc+Ev54rPosKC
X-Google-Smtp-Source: AGHT+IEOerGszXM39XAf6rchuCXnSPb+eTYh4vPZoyIPJm7hOLW0RIShgBofINvaXhbhoAyus3CqTw==
X-Received: by 2002:a05:600c:4f11:b0:42c:aeee:e605 with SMTP id 5b1f17b1804b1-42f85af63f3mr7087255e9.9.1728037114264;
        Fri, 04 Oct 2024 03:18:34 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4a38bsm11965615e9.39.2024.10.04.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:18:33 -0700 (PDT)
Date: Fri, 4 Oct 2024 13:18:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net v3] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Message-ID: <20241004101830.4z3lhux6i5nki62o@skbuf>
References: <20241004090332.3252564-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004090332.3252564-1-alexander.sverdlin@siemens.com>

On Fri, Oct 04, 2024 at 11:03:31AM +0200, A. Sverdlin wrote:
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
> [alex: reworked using read_poll_timeout()]
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v3: comment style, use "!ret" in stop condition, user-readable error code
> v2: use read_poll_timeout()
> 
>  drivers/net/dsa/lan9303-core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index 268949939636a..f478b55d4d297 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/regmap.h>
> +#include <linux/iopoll.h>
>  #include <linux/mutex.h>
>  #include <linux/mii.h>
>  #include <linux/of.h>
> @@ -839,6 +840,8 @@ static void lan9303_handle_reset(struct lan9303 *chip)
>  	if (!chip->reset_gpio)
>  		return;
>  
> +	gpiod_set_value_cansleep(chip->reset_gpio, 1);
> +
>  	if (chip->reset_duration != 0)
>  		msleep(chip->reset_duration);
>  
> @@ -866,6 +869,30 @@ static int lan9303_check_device(struct lan9303 *chip)
>  	int ret;
>  	u32 reg;
>  
> +	/* In I2C-managed configurations this polling loop will clash with
> +	 * switch's reading of EEPROM right after reset and this behaviour is
> +	 * not configurable. While lan9303_read() already has quite long retry
> +	 * timeout, seems not all cases are being detected as arbitration error.
> +	 *
> +	 * According to datasheet, EEPROM loader has 30ms timeout (in case of
> +	 * missing EEPROM).
> +	 *
> +	 * Loading of the largest supported EEPROM is expected to take at least
> +	 * 5.9s.
> +	 */
> +	if (read_poll_timeout(lan9303_read, ret,
> +			      !ret && reg & LAN9303_HW_CFG_READY,
> +			      20000, 6000000, false,
> +			      chip->regmap, LAN9303_HW_CFG, &reg)) {
> +		dev_err(chip->dev, "HW_CFG not ready: 0x%08x\n", reg);
> +		return -ETIMEDOUT;

Please:

	int ret, err;

	err = read_poll_timeout();
	if (err)
		ret = err;
	if (ret) {
		dev_err(chip->dev, "failed to read HW_CFG reg: %pe\n",
			ERR_PTR(ret));
		return ret;
	}

No hardcoding of -ETIMEDOUT either.

> +	}
> +	if (ret) {
> +		dev_err(chip->dev, "failed to read HW_CFG reg: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
>  	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
>  	if (ret) {
>  		dev_err(chip->dev, "failed to read chip revision register: %d\n",
> -- 
> 2.46.2
> 

