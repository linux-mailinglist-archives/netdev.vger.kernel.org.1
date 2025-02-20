Return-Path: <netdev+bounces-168236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1FA3E366
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1541F421CAA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC5212B0A;
	Thu, 20 Feb 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXIfAQti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318C20485B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074901; cv=none; b=QtZjaTJtl31IuWCzJ1qyPtKlDf6uvYugaFSbwFOQV95WvF6bnKR3SUM66buizkMY/XaXNo5kY3Sk7xMT8v9Pa7RnlbjUi9i47/2jozZDjUr20ZHPBRtVf5PDXljZln5P6ZycGEKJy4M8OALk47rQsKUDFMp+CGbgQkh48vt5e5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074901; c=relaxed/simple;
	bh=CF3Vchk4lfIr8SfSsGrRnxSzchuHZc4UIsRbFbZeAI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/CbljrAVbbIRp1Ssx8wbAsoSo7ZcwlAEavoyyGujNJXPsDmtG5lD3x77q0WTUGJKLfERM6TVKaNxRDZI9fBOVdgBXpskuXQrUbUGgcvMUYz6/JabnXdd479iuCEXutl7SYYaR/hGP/MwAeVkWkwXY4R8QNuPDOSZQS30rRHAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXIfAQti; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7ee6f5535so20919166b.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740074898; x=1740679698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIY9lIKGXMgHeeoPQhLBsxkcbvuY42lMs6uiHPyjpAk=;
        b=FXIfAQti2+umWulJMtWhfmde6cf0s92NJxDs/wXyQA0cJ6IwZeEYwpkgq7KTO6hhSB
         7uk35mMitjoWMIBltjTXQFS41LbKD7BfT41GDk7T3fBBpnQy1j3Ibp0aqxz9NV1B73J8
         4/0UZEkpmcJ6p+gPMpiBz+DLG6kTUgQF8z53rg0IC1hNprrUHS8mRPpqpFsMXrcPzRND
         oS01gHh+77S8uaxiv1lCcbxynB/0BTlMUhm+2bcf/qZTl+mJSkkj1pbAHFL7rQqgBFyd
         CoYFNoLZ5H+r1DHNbkNTi8ZxmGojxoPgfR4omAPYBo07Ewq1uHFDgP0AO2S6L3Z9mA6Q
         TRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074898; x=1740679698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIY9lIKGXMgHeeoPQhLBsxkcbvuY42lMs6uiHPyjpAk=;
        b=T66dFLjZDgs3q9Zg/3lAdIaFJigF3g5APviQdGBbYjG0tpy3oMlXwlikVcxh/HV3Ge
         HVYocfmX9WXMOhdIM0mDMO8a9eYZ6JP8zsdJXq52WqZ58/s46NGmS12qBzwn/i4hXENf
         OFEPyn4uylWunzSaUP7nT9Wn7ud9A51DHTuJTB62/N8+Wf3Nj1lsPbKB0tizdMjcxhoP
         HeyT0gUACk6e/7kgtNya37EviajQz8xpI0a5OrQFnC9pkJQJSM8fcsdhDntMKmUtNk5O
         NKxsxOmwMSqWxtQLcJaVyuSeXApyJW1QMdh2BhiZXbYrt2N/+FwG4SX9jaVJxkMYJz7U
         f7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8H11HiRKNuEPWS0dRFxUfGrOoP5FY9HOjiUhxrzbMDxh+HeVGRQg03f6JscUBEPc/lRXlikE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2ZZwkHryUyEmKCfKZ44CaaEt8xJVNwU3ptQ2/b5+WCo57qcu
	diKjluHPFCK02lI83jfqtRNldvwbfH53abeyv8JiBfZGpjOGJW8N
X-Gm-Gg: ASbGncuQ0Dgm5Jql5XxLPoLRG3dr7BeztqxPGK2jZpi6haQuDE8Zr3NOw9//f4z3JAD
	YSI3BVsqQxDKcJIg7/+JbeXLkz3cg8JJexAKNSelHpsfcmnRTR54i0MBgL+qcj99V1M8usL/8Bv
	qS8Pzenu8Y/2oUslF4SnUg3mVewhiZTbH/xMj5/w9zCoihLN6DtS0nLFIYgmE2pQX+TSDBzx/Oy
	19KV1f8m1ncb5Fk7RTK/XfZxDU62GQtt/6/8FIuTyfE+V+pGmdD0xD+e0mM01BTQQG0eRQ9q7S7
	7WI=
X-Google-Smtp-Source: AGHT+IGddrZuHtLLjvZ2brldT2Xai8DBF2RWdA9vsJk+3J8GGMFbPpQ2wyKlGY17kg6YyG7YWc7UVg==
X-Received: by 2002:a17:907:7286:b0:aa6:9c29:86d1 with SMTP id a640c23a62f3a-abc099b8837mr12868466b.3.1740074897854;
        Thu, 20 Feb 2025 10:08:17 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9657249sm702131466b.38.2025.02.20.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:08:16 -0800 (PST)
Date: Thu, 20 Feb 2025 20:08:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <20250220180814.efeavobwf4oy5pvy@skbuf>
References: <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>
 <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>
 <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>

On Thu, Feb 20, 2025 at 05:02:21PM +0100, Linus Walleij wrote:
> diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> index 35491dc20d6d6ed54855cbf62a0107b13b2a8fda..2fb362bbbc183584317b4bc7792ee638c40fa6a1 100644
> --- a/drivers/net/dsa/realtek/Makefile
> +++ b/drivers/net/dsa/realtek/Makefile
> @@ -12,4 +12,7 @@ endif
>  
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
>  rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
> +ifdef CONFIG_LEDS_CLASS
> +rtl8366-objs 				+= rtl8366rb-leds.o
> +endif
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o

I was expecting to see even more than this. What happens if CONFIG_LEDS_CLASS
is a module but CONFIG_NET_DSA_REALTEK_RTL8366RB is built-in? Built-in
code can't call symbols exported by modules, but I don't see that
restriction imposed, that CONFIG_NET_DSA_REALTEK_RTL8366RB should also
be a module.

> +	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
> +					 dp->ds->index, dp->index, led_group);
> +	if (!init_data.devicename)
> +		return -ENOMEM;
> +
> +	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
> +	if (ret) {
> +		dev_warn(priv->dev, "Failed to init LED %d for port %d",
> +			 led_group, dp->index);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

I know this is just moving the code around, but I was looking at it anyway.

Doesn't init_data.devicename need to be kfree()d after devm_led_classdev_register_ext(),
regardless of whether it succeeds or fails?

IMHO, the code could use further simplification if "realtek,disable-leds" were
honored only with the LED subsystem enabled. I understand the property exists
prior to that, but it can be ignored if convenient. It seems reasonable to
leave LEDs as they are if CONFIG_LEDS_CLASS is disabled. But let me know
if you disagree, it's not a strong opinion.

Also, I'm not sure there's any reason to set RTL8366RB_LED_BLINKRATE_56MS from
within the common code instead of from rtl8366rb-leds.c, since the only
thing that the common code does is disable the LEDs anyway (so why would
the blink rate matter). But that's again unrelated to this specific change,
and something which can be handled later in net-next.

