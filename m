Return-Path: <netdev+bounces-117254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6E94D570
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E8228113B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312C46425;
	Fri,  9 Aug 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW+PEUqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223B40BF5
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224657; cv=none; b=muDF7pcY+CKYi8u538g6DyNH2MOH/lVEm4uVgfhE4y6+GecCehg5fvBInI4NK2ijUS7GsSuMqjf23HKSIJJYNl+/8euvwAH7eMEr+MV+WICB76mLO0tDMG3dXm560qyrJJPB96riihFL36Zhs3o9Ho2lmZLHm4OhhaELWoCk1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224657; c=relaxed/simple;
	bh=CnuP8ni8Bc0XWlxFePBU/ipVDHHqIun1i0eSh9F7k7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBpH92iOEm7BQsmG0DhwmHVjm+2/DIp6C5HUPzXPP1GBtHYJZbxMF3jDeVexhbflofxhH88Poj7eUsXmIR4UIwW3aus1VW6Vlu1MBbeeFa685aNR5IdrpUHS4mR9I0j/0zUQUwHPrsZFKQSQH06Gt/uZdv3eU0mT0MLtBkVvSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW+PEUqX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so4953135e87.0
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723224653; x=1723829453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3ylTrz3zH6PY5u6oGX4HWCn+x25MB2qeKCXrefV5HE=;
        b=FW+PEUqX8lc9Wmt+G4CqOGeZb+DmPacXOir2aJMDKL6E6uogR+31NXhtvN3CfEJH3J
         mIdPDN4tchF5FzZyqImq68aKY/02j5hkstxqT9gIHWsXTT1KuQ62RgO0aneMmvJAjFfJ
         AYY8t2KqrC9LvS50KbREsIKukURUUNyY9Xty2iNvBo7TQiTY4vEFr3U+xv8OjSNH2Tz/
         UWlA48h/5jzzzDHvyDjhW6TI/M7oBuQ9J/Mn4udISuDvxyXY8/Rb/pYiG6Rkyrf8IJVV
         7pOlkLOSWiCb2TyxIGz0Ht9CuycZQBJMBwDsRkXkG8cMo9FNvF6eqWOAWoiAurxpJ4XP
         rEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224653; x=1723829453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3ylTrz3zH6PY5u6oGX4HWCn+x25MB2qeKCXrefV5HE=;
        b=Un2eDjquPZPz45HpbnO6c70L+3jL0bO9N07VJg+9xPh5LdaTR6HAj2HNkDgwTu4w1K
         ZMd3gO+779aH6HNQcTdldr1n08evc3NJNj8piuAHoPK1921hOBDLqd0kW+/ZrBCGed5C
         6iicpBQrtdES2chdTaG4h3h/iNdjyIsZXemxqtCq534XxSHPggB/p353O4rGrUt2LjYw
         dJaSy8WyJVgag9kH8Zt8Lx+OZLQbVUST+8hSkWkMdMGaNb+dLW2XgAjdn74/iIf8P7EI
         aCTbtRdqQqcYwnQGovCzx3KNsGaRGtwd4zGKZH5/KlymdItRrDkYhyKZ6mUy8kSv2sHM
         /VFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUinqc65rA0ZgCETETZAK4jlDHoyqqNG/WVPYC1ijTuCUsylXPrmeNwyjc47VnW8y+jbUmXIggGBEf/BM1pmPJIVkzhhWQc
X-Gm-Message-State: AOJu0YzJNzCcKi9e65Sa7CxdVAE2l1/8O3H+bHtxXDw+3arhNTB24ioI
	/59eZK+NzhaSEfucdIsYiAi6eKnjYEkcD23YXNhwm95xlql2T2cJ6xC1uAnn
X-Google-Smtp-Source: AGHT+IGjHntCp7Az8ook58Hiy7r04T75o108B1WLnRGlk1RYAmmp0iNUoKPvJm8HxrfF3TyS36/5AA==
X-Received: by 2002:a05:6512:2243:b0:52c:d5ac:d42 with SMTP id 2adb3069b0e04-530ee975b16mr2097063e87.9.1723224653180;
        Fri, 09 Aug 2024 10:30:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3f27ccsm1043549e87.69.2024.08.09.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:30:52 -0700 (PDT)
Date: Fri, 9 Aug 2024 20:30:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v17 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
Message-ID: <5fjet4giqcdsum4cm532y5lqcrplezfwjrcsysvl6vraja4iwp@xckha7yszkzd>
References: <cover.1723014611.git.siyanteng@loongson.cn>
 <40ae44179d56adb72d67a8b95cabcb0da0da3a9f.1723014611.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ae44179d56adb72d67a8b95cabcb0da0da3a9f.1723014611.git.siyanteng@loongson.cn>

On Wed, Aug 07, 2024 at 09:48:54PM +0800, Yanteng Si wrote:
> The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
> 
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>        Name              Tx          Rx
>   DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>   DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>   DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>   DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>   DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
> 
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
> 
> 1. Create the multi-channels Loongson GMAC-specific
>    stmmac_dma_ops::dma_interrupt()
>    stmmac_dma_ops::init_chan()
>    callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Looking good now. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ...

