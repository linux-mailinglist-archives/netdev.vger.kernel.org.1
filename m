Return-Path: <netdev+bounces-93607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F508BC695
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 06:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CE71F21248
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1291B40847;
	Mon,  6 May 2024 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFoA2tod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531861EB36
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714970679; cv=none; b=AsPoKWpD4jI2Pujs8AE/JuxvzBfE/zJZeysTI7QgkPEk/L4A0o11x08Fv7iaVrEAG4/Y+rCkNtCHdUpw9nn3DLqmMHZ9ud+CwdHcXCuXHIAO0tLHsBY6a3wbxQ8SNF+3HZilLJbXLR+gh+CDdtXGU5GMNh8KvupugQOJkoEuvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714970679; c=relaxed/simple;
	bh=yY705WD3ZA9V6+JTLOCGg/kWWYpVotQjxtF1GWHKt/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBSVuGz/vo6eT7xEW1q1AdZpOniLc8WsV8kp0yl8a0E5qnmb8RXPWtoF1DnFhfW/gdaMeWj2xYulITXX4xSP4BQ1blGeSc+aCskZFGe1LJ5KRH/G6oxfmSzz6V0kHEMzl4OzX13wdxsNzdTHz/+iHVsPvFZDdTLzvurpHQWvSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFoA2tod; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so20495541fa.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 21:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714970675; x=1715575475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Weqg47fTxCfH12Ztkh60o7bZ2X+cwxdMO44yfNtDnEw=;
        b=OFoA2todtKJ6ZAgQehQrMSbKqkn6m8FU7fsNIQbQjGOJVr5/rapGbd3+Lcqj0xh7xM
         CUbiK5EwwmjF5/7eiTpSM25LrYm42biBwqvRIml4nCphw2MijcqBV/MVQ1zfk3taeUBL
         Wxm7Pw6aMdhy2OHSvZ6hXTJ5l+yov/Bb68H4IfDOhXAdg6wiXozqUtxzJ4rZzf3w1HwM
         M1akrJmBmJ3urDRV/BfAisgRVWvdoiOAOK30f8pZpiARtFPGSnxCl1x+3gkaV2H2WWC4
         hB3O7ZXC86Sci6lvtxQu9mDSJLRC6PZ2RN/NeV7N54T8UdAhlD34dMx5YdrY8CVjP9va
         Gl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714970675; x=1715575475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Weqg47fTxCfH12Ztkh60o7bZ2X+cwxdMO44yfNtDnEw=;
        b=IpNSyBvrAbbs2NVqhxabCvdSwjRsEpAuVDtuba5H8ASBnnZfxAlmkpykrkywCRzVTz
         YuXUal+100uI/RX38fNqmabJbQrOn6+JYnhGUFK71+gJNcC9nvzN/2lifPbjckGXjou7
         UcFIfaL3gNtvb1NoKimZvdsygNklQxi7+NyGCBsmEbfFsDpFZm8jxkK6k7VXqTv4xgZy
         ZzKwz3aS/ItZRFqUSg61bXvBb1f3mWbp/LqYLUgx+1NPqMrV7qtEiRVR1Q0lyn5rV3Mq
         jEdWIHd/14MQIeXN0ZKJgc/6a7v64rKOOUyIGJKLQjLSHDWsXO1dZcF3Q4NVbA7VVFS9
         V9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUKoJ5b8/kaZdpvSrCt+Rl5hfcfqP3oNyDstKsBs8faSZZYyol4Ji5537RF3eZ//e1RY+/fc/RkIBUFiojlwe27VSU76UEL
X-Gm-Message-State: AOJu0YyOVDID+VTRIfkacUczcWB6N6WseOGHOvryZcDqeJNjJISvzeqj
	F9ZuGWCvIpxXtewis+2b3QLSxH0JsXTZkzL00kDgXD4MaQRopBie
X-Google-Smtp-Source: AGHT+IEktcU4fYClDXrdOdYgN1WA/WPqS7YsCMIVPMielCLBDvXxRJOZtJ+TJPkH/14So9YTB0fRjA==
X-Received: by 2002:a05:6512:3f16:b0:51d:2c37:6c15 with SMTP id y22-20020a0565123f1600b0051d2c376c15mr7303633lfa.8.1714970675049;
        Sun, 05 May 2024 21:44:35 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id y13-20020a19750d000000b0051f2230523fsm1457762lfe.147.2024.05.05.21.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 21:44:34 -0700 (PDT)
Date: Mon, 6 May 2024 07:44:32 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 15/15] net: stmmac: dwmac-loongson: Add
 loongson module author
Message-ID: <774mi7wcv5nsz2al2qgdcgbdlh37io45qtorzyvrrydinjyp4v@kectrx234tgk>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <30ba385282572a2a5803b762decde061f81b8cc0.1714046812.git.siyanteng@loongson.cn>
 <CAAhV-H5ziP-7p=tyKXB-wG9=KgbHjXkfuF=nfdvbSLZoe9aTTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5ziP-7p=tyKXB-wG9=KgbHjXkfuF=nfdvbSLZoe9aTTQ@mail.gmail.com>

On Mon, May 06, 2024 at 10:12:14AM +0800, Huacai Chen wrote:
> Hi, Yanteng,
> 
> On Thu, Apr 25, 2024 at 9:11 PM Yanteng Si <siyanteng@loongson.cn> wrote:
> >
> > Add Yanteng Si as MODULE_AUTHOR of  Loongson DWMAC PCI driver.
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index dea02de030e6..f0eebed751f3 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -638,4 +638,5 @@ module_pci_driver(loongson_dwmac_driver);
> >
> >  MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
> >  MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> > +MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
> >  MODULE_LICENSE("GPL v2");

> The patch splitting is toooo strange for this line.

It's not.

> Since Qing Zhang
> is the major author of GMAC, and you are the major author of GNET, I
> think this line can be in Patch-13.

The patch size isn't something that determines the change placement,
but the change solving only one problem per patch. This patch is about
adding the driver author. The patch 13 is about adding the GNET device
support. It's perfectly fine to have these changes provided separately
and in the order they are submitted in v12. Besides the patch 13 has
just started getting to look reviewable enough. Stop trying to mix up
various changes in there again.

It was me who asked Yanteng to detach this changes into a separate and
final patch of the series, for the exact reasons I described above.

-Serge(y)

> 
> Huacai
> 
> > --
> > 2.31.4
> >

