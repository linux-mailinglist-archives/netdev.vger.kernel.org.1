Return-Path: <netdev+bounces-93318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C678BB2FD
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CDB2237E
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2967157E86;
	Fri,  3 May 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IghObs9a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB31552FE
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760523; cv=none; b=HUtkxrV96qJLbuL9hOFa9H2RKVJ/+mCB98y8S3JaqiQ3410m3Ch2Y9TiydlJapoo2DqAKwGZEChBH9iscdIjgS02LxLEr+Z0p6pn65IMKtQU/miCvsbSisg8Btct9LWSphzzn0NyDirgP8P77u7/IERPNjDBz33oDuCbjPnZTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760523; c=relaxed/simple;
	bh=nm7CSw+eklSwGG1xoezV37RRMBIUAqkFOWel9pGPPtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4ar4qlrf07yiWHoJnrEW/jzP6FbZOERY7CBD5cagzYANTg3tY0Uhq6DlyKUa/YB9349HIM7Z+aSf8BPn1y3bsYwAnR1ay6FRtAG5hc8kRGfGDMsrZrQRwDKYB0xwjCvzQx27mBc2htrwvmRRYdY3QhrZSCa1KAi4YEBgKcmIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IghObs9a; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f8211c588so1154177e87.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714760520; x=1715365320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5wr2BsnoIzuUJWHwNQi6KC107tzXGiigwRha3BHCDI=;
        b=IghObs9awm3KbCAhdzqWSoUV1lBrt9CY1JH54xxO3kPwCyvRT/T0Kn3UZ+jgAutS2u
         yD3hY4kQ6Id+xiNBxJY8CT86IzXHZDMHENGvXG1AlsKDAexflHFpdcbGCCYkUDs0tkDb
         MYhftaH4+FHDQvjKDfLoROwlLHsDN6BobG+a8wbdzqRenx/Jg8GVyYSRDffz9vDutZXY
         JRvVUtLLgeLMvZw4hQ82S/cbkaD42ypomjuxrMtiIrH6oObAJrblrhWhhMq2lGdVV/ea
         CJn1H6Dmcxf/MzvT7Ugd9hSYwNiQQB1BHDVaXi+1eu7krKK7MRqW9d6to0uVZASj0apc
         qbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760520; x=1715365320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5wr2BsnoIzuUJWHwNQi6KC107tzXGiigwRha3BHCDI=;
        b=DnIYO29QfKNm/5trXAPgzftt5j7ACrbwCE2tZa8PP6Vjz2UiLDcAwx/2K7Qr9qPToa
         CVzisueD4DSYUODV+IHnT26AUB6z8j3rhshgh2fPKMNOcc713SsBkXwSWhPvG44kqgWT
         ZXN0ndUuuOviArQ/rdN77p/ii4ximZ87kxuRN/tYX77eYJSzZUcaeLhaij41k6h3ncU4
         ClDMglY9ZD54qYPMguAYC7el8sjrrLNiqQUUBGnRo7mhP83+Ae8+BwplRUNZTrnOa0EZ
         CtQB0KKAHDrBrEw+WjsFH/QIyxY8ZLZsPP9ih2EoLXNlWXq+xiQNA0e/cJJ1IP21WgZ/
         8AVw==
X-Forwarded-Encrypted: i=1; AJvYcCWUA5m8GCJBNXsVonjAq8RebZTMCtnDKznSI8Ts4QUwQ+jEhiHXo4LnzOPqsovb//tjeqE4bJpfzpdLuBFFH8OTBxGVqDQX
X-Gm-Message-State: AOJu0YyunlAKOzeOSOUXZl3yNNUN0lRDMM0bBCO8t0iZI0xddkj3v+4/
	mmMEPqfIDMzko5kSyHpICbNiY4KOJoB9yuhiVrFXJQLjgbEC98K9
X-Google-Smtp-Source: AGHT+IHVa5+i4saOyGGzjYJczF64l+jJL5LHfy45+d6PMy4L0R7fd6IkUszCfdYBld9RInnZQPSVCA==
X-Received: by 2002:a05:6512:1583:b0:519:2a88:add6 with SMTP id bp3-20020a056512158300b005192a88add6mr2744815lfb.55.1714760520077;
        Fri, 03 May 2024 11:22:00 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bi5-20020a0565120e8500b0051cb300265dsm602620lfb.109.2024.05.03.11.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:21:59 -0700 (PDT)
Date: Fri, 3 May 2024 21:21:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 07/15] net: stmmac: dwmac-loongson: Add ref
 and ptp clocks for Loongson
Message-ID: <26kbmvputkbfuz7zdfa2wblsgz5sn6iwucwscswwrpbu7ttwmj@3btn75ewpdwi>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <aa9e291e181017146f88238cdeec9f18759915c3.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9e291e181017146f88238cdeec9f18759915c3.1714046812.git.siyanteng@loongson.cn>

> [PATCH net-next v12 07/15] net: stmmac: dwmac-loongson: Add ref and ptp clocks for Loongson

s/ptp/PTP

Mentioning Loongson is redundant. Just:

net: stmmac: dwmac-loongson: Init ref and PTP clocks rate

On Thu, Apr 25, 2024 at 09:06:10PM +0800, Yanteng Si wrote:
> The ref/ptp clock of gmac(amd gnet) is 125000000.

What about a log like this?

"Reference and PTP clocks rate of the Loongson GMAC devices is 125MHz.
(So is in the GNET devices which support is about to be added.) Set
the respective plat_stmmacenet_data field up in accordance with that
so to have the coalesce command and timestamping work correctly."

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 904e288d0be0..9f208f84c1e7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -32,6 +32,9 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  	/* Disable RX queues routing by default */
>  	plat->rx_queues_cfg[0].pkt_route = 0x0;
>  
> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;
> +
>  	/* Default to phy auto-detection */
>  	plat->phy_addr = -1;
>  
> -- 
> 2.31.4
> 

