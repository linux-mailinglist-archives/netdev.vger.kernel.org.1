Return-Path: <netdev+bounces-131778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E34598F8BB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A3B1F22376
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0C1AD3E5;
	Thu,  3 Oct 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfdqb2Ph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625813B2AF
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990131; cv=none; b=R6Lq0/NHRwKYd+XiEvhUJbLRLSmdFS81qSBBqlOKQoN0zNj3m+gC5SZOnf0Kd3LjjARthLPL7t2Hf1zHr0Uqx5TvKtX3Q/Rr1pBR8Jx6Y6Vi18385eAEPhMGlGbDTF8C96Xv3aelewIGXKCOJYkWq0xIkkwGovIMWvH+cpxUHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990131; c=relaxed/simple;
	bh=2ShqX64bftqYqJcrpfzSvwircioLpFaDv2PWwgJTgUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8mjfA951xZ+A2ZPkpPYfXfsVA3QgJGMruCi6lz+yeA93a7XNvBGAlGXX3p8wNB0FDrzNLMUck9ZlyR6Df6sWZWmhpCDJZCX7mUIiVdxozwsFNWHJW2ha8ZcQmW1Nzjzb9ztKRGTC8KnHn1UKkkslm5rX6WaKeMvZS+visY3bow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfdqb2Ph; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cacd90ee4so2105195e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727990128; x=1728594928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7G2ATwqe9E88wjld9xml+OUC9CF+4p5A4ZgTfTq9DQ=;
        b=hfdqb2PhMp433VIGONgAZFyv68fRbmEDNcdUn6DsZdOUNNY0DhIa7ZLKIHQIKruH5l
         jVIZNfsyN5mVyZkASC3utYDlE4sqWBPtKhgrSS1ng91MZ+n0PycfdVa+z/iTbvsdOf9o
         ZyD/brfWYUNTZ6T4z4N/8c35CKGtnnfOK7VIMxfhMHkF4IzlP34YYV/UiGp/j0lChZFl
         ZKQQx6KlpUKmC5iZMRQKW4elqKqgwNrW88TF3mMw5jSiC6KrGXxiYkmqquXlWc10yCpQ
         saA2thz6EcVHDeDT/MY3JBersR2ZRhNmUu7HNCC9hWeLMgL1VRACMD9/t7ahPXYOnLL6
         Fm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990128; x=1728594928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7G2ATwqe9E88wjld9xml+OUC9CF+4p5A4ZgTfTq9DQ=;
        b=suyQYl0DMTW2ih0WmeTdajajGAuKtPJ3t6ERhOTtA/QEBtV74Y+Eatp6yZCsvx5zGv
         t7GPLxcHU23h/HKF9ESJOKFTcDU0XGDrXPwpU6OQ3u4No9WbBpL5XBIxdKrsPbC8czAN
         ktkZJjHIYkd9/GnAhjflfaWhb9gjaPl3Q9536KCEy5YU/ATJUQNENJOGO8Y35ZGDLw0z
         C02YH0oCdHXeG53C3yiVUzzNi5/iroAcPCNwoKfn0Doxgx90D7F74+DRqC3tR7M9Op1t
         ow6rwD6q8ZGytbNqJrfmG490su5t8eqnO4S7xeLQpUkN5nadXuPN85WQ9oRRYg9Sxz+r
         x5dw==
X-Gm-Message-State: AOJu0Yyhm9J/vnvkt1ehwuOQ8pOfFBKxOnCB2cTUeA7lz5ROiON/Pi05
	MZ6RfaZMA7P5PpAcYsBJeZ4APONcf/fZBO+jG0TCDaSI9mImQT1aG9WXWjZG
X-Google-Smtp-Source: AGHT+IGfyjHRpl2NqN05kXh9dMZ85DQg0VflizQWCGeIqxQp3tIQjYmRCpbg3Ioc/hs7XgK0fjxX2Q==
X-Received: by 2002:a05:600c:1ca7:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42f85a6f96fmr1218515e9.2.1727990127560;
        Thu, 03 Oct 2024 14:15:27 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f80255dfasm23874125e9.3.2024.10.03.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:15:26 -0700 (PDT)
Date: Fri, 4 Oct 2024 00:15:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net v2] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Message-ID: <20241003211524.ugrkjjc7legax2ak@skbuf>
References: <20241002171230.1502325-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002171230.1502325-1-alexander.sverdlin@siemens.com>

On Wed, Oct 02, 2024 at 07:12:28PM +0200, A. Sverdlin wrote:
> @@ -866,6 +869,29 @@ static int lan9303_check_device(struct lan9303 *chip)
>  	int ret;
>  	u32 reg;
>  
> +	/*
> +	 * In I2C-managed configurations this polling loop will clash with

netdev coding style is with comments like this: /* In I2C managed configurations...

> +	 * switch's reading of EEPROM right after reset and this behaviour is
> +	 * not configurable. While lan9303_read() already has quite long retry
> +	 * timeout, seems not all cases are being detected as arbitration error.

These arbitration errors happen only after reset? So in theory, after
this patch, we could remove the for() loop from lan9303_read()?

> +	 *
> +	 * According to datasheet, EEPROM loader has 30ms timeout (in case of
> +	 * missing EEPROM).
> +	 *
> +	 * Loading of the largest supported EEPROM is expected to take at least
> +	 * 5.9s.
> +	 */
> +	if (read_poll_timeout(lan9303_read, ret, reg & LAN9303_HW_CFG_READY,

Isn't "reg" uninitialized if "ret" is non-zero? So shouldn't be "ret"
also part of the break condition somehow?

> +			      20000, 6000000, false,
> +			      chip->regmap, LAN9303_HW_CFG, &reg)) {
> +		dev_err(chip->dev, "HW_CFG not ready: 0x%08x\n", reg);
> +		return -ENODEV;

What point is there to mangle the return code from read_poll_timeout()
(-ETIMEDOUT) into -ENODEV, instead of just propagating that?

> +	}
> +	if (ret) {
> +		dev_err(chip->dev, "failed to read HW_CFG reg: %d\n", ret);

%pe, ERR_PTR(ret) is nicer for the average, non-expert in errno.h user.
I see this driver isn't using it, so maybe there's an argument about
consistency, but there's a beginning for everything..

> +		return ret;
> +	}
> +
>  	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
>  	if (ret) {
>  		dev_err(chip->dev, "failed to read chip revision register: %d\n",
> -- 
> 2.46.2
> 

