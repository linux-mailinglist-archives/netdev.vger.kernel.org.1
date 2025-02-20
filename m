Return-Path: <netdev+bounces-168303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C39A3E6FA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CA917EFA0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FAC1EEA46;
	Thu, 20 Feb 2025 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2Ntc0v2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52731EDA07
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088201; cv=none; b=P2Lko6mazSuXWxKl2kxsTp3JNGCHv6YJPEKCfG9IbCmcj2Oq9rSNWDL+XElNaVJ5iFlBHqStf0YX+OnKUk0OJxhYvOs8R3y82ewUgyIeWNrRGu/csq7EE+LiVP90/nBnjp0b1VQQYif+wcXlWeRVPNa18BpzCURCX1aDJ9PBo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088201; c=relaxed/simple;
	bh=b1G8cNby+rtSrfpFnOOMLqEaoJ35s5YHp7uhm7kte+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERxBtYErI3Uly1iZCJD0eipE+bfoifOo7byeVpAgsxUmUkVWOa20FpZpxCf83m+ac8K7vRB+Mxbax93BabmUhi2Cd6NJLZq3bt0P8Vowtn1FpOqTTRMD/jlV1nebhEflxKBz33tk6ltaojerap2iCUpulRM+UvjMLGeBoQHlItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2Ntc0v2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abad214f9c9so24943666b.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740088198; x=1740692998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5t5QNvTzKdMPHx2DKJdD/uNPtyRcmZBH16SNLJpAes=;
        b=N2Ntc0v2oTiDfSsKX1tDDxYTR9axv7CuLf0UYfuHygSeiS1Xj54OOqqKa3w7N2/hgI
         OSMfBN95Bdp2ejy5xhnpwec9oGOkxLywRlPT7Wiv9Kss8oarKl5rlDlt5reFJjEbYmr9
         lV1ElwUUR3rxqhlc9cFpcvLsOeMEiUCObP1KDTopexxNSYPAtB14Vw3teGlhUROy5kCt
         OInwggxi2g8MzCk9qxSf9ZcXAdYWSR6/79Eqw6kDB/gfMgvOjZId0ZZGVBIZ3bfW8UCQ
         U1YNgOFq3xFPTo37Tslv0Xf6BhFBQiuY9oVo5dwCbiTH4kqTMPKAvAaXK5cryOqGsqzB
         A09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088198; x=1740692998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5t5QNvTzKdMPHx2DKJdD/uNPtyRcmZBH16SNLJpAes=;
        b=vc6Fp1b98gpv1G8BQcZFSpEniX41+9JMKqxlci8H7+H2lBAP4ZlC/O4ezHgCKG3sJl
         8nyZq7xMHkE6+2hCYxLFqM/8eR80AWMWyGqjZ7Fhsx+SRJ3XNqaBaZhSpf009hS77cgr
         LSjDYgdbtZIiqJX+1gnlaGBE4gOTLIZ02o0DTX6fBh8X+X+d/s/Rdz+yGC0neRFk/F58
         DRcowuF8UZFxUdj/liqFk46/xRGwjGKieQdiFpMx3S+ZNxLMEhfbDDAGFLu70ehR/9Op
         Smh6Ihgym5ASvNnE74JNK9eXaR3W2KZOY7mujk94VOgoittfxs37p/Y33EdPCR66rvX3
         vZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlROYIHNd0SJ+gJNra9jw3w+WYPiRsXn18BodRoeWnAHN6Krt06qCz/M5r8oBTr1E0gYHyuRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRax2de3/a2cKcxlf0R05d5OyyyNQI06egEmSxVirl0tQEDJR
	J86jcvRaXFhXsY5888bVCabhP0fgX2ebc921cnFTjVf5OZL6x8da
X-Gm-Gg: ASbGnctGzMkf1BDgCxvV5nZDGpaLwMxyWLM/eI/9fUNGaeiH6XWeVTcIQr7M8PuBlXE
	pPUZAx9pJ8TbWauqbJkrrw7Eu1k2ziK/D5vcdViHUM56jXAyKHERrECCbzlEBVomYEf1WaLhzQu
	rKEdvVxg/QzlZlwIifB6yl4+Z5wLUtRLhGlqVQfaLy67GRot8p5/Qtw6H+DRTjkD/pBgWkM3ErS
	CWt6nOZtIhSMmPgg7yqMorgPHLmYlKIWy9C6NWWRCtQ+aXCN1YPbRDRbS6jYKuKalwxjbRWKQXM
	49g=
X-Google-Smtp-Source: AGHT+IFyB7wBDKlY+0oaEneuYHPXfL+BNW75zqMoc1fI3H+sr0E7964lrutp8OGIXWqiJmReyyvzog==
X-Received: by 2002:a17:906:dc8a:b0:a9a:2afc:e4ef with SMTP id a640c23a62f3a-abc09a97a18mr39638966b.7.1740088197721;
        Thu, 20 Feb 2025 13:49:57 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc728f079sm507285366b.7.2025.02.20.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:49:57 -0800 (PST)
Date: Thu, 20 Feb 2025 23:49:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <20250220214954.62lfljaxuclammce@skbuf>
References: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
 <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
 <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>

On Thu, Feb 20, 2025 at 07:48:15PM +0100, Linus Walleij wrote:
> When the kernel is compiled without LED framework support the
> rtl8366rb fails to build like this:
> 
> rtl8366rb.o: in function `rtl8366rb_setup_led':
> rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
>   undefined reference to `led_init_default_state_get'
> rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
>   undefined reference to `devm_led_classdev_register_ext'
> 
> As this is constantly coming up in different randconfig builds,
> bite the bullet and create a separate file for the offending
> code, split out a header with all stuff needed both in the
> core driver and the leds code.
> 
> Add a new bool Kconfig option for the LED compile target, such
> that it depends on LEDS_CLASS=y || LEDS_CLASS=RTL8366RB
> which make LED support always available when LEDS_CLASS is
> compiled into the kernel and enforce that if the LEDS_CLASS
> is a module, then the RTL8366RB driver needs to be a module
> as well so that modprobe can resolve the dependencies.
> 
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502070525.xMUImayb-lkp@intel.com/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v3:
> - Create a new NET_DSA_REALTEK_RTL8366RB_LEDS symbol and make
>   it resolve the compiled-in vs compiled-as-module dependencies.
> - Link to v2: https://lore.kernel.org/r/20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org

The Kconfig approach where NET_DSA_REALTEK_RTL8366RB_LEDS just
disappears when there is a mismatch between LEDS_CLASS and RTL8366RB is
a bit unusual to me (I'm used to just seeing "depends on LEDS_CLASS || LEDS_CLASS=n"),
but this seems to work too, as far as I can see.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

