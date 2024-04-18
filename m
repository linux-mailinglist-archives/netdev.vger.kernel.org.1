Return-Path: <netdev+bounces-89137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F28A9859
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900681C2088C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315415E5A8;
	Thu, 18 Apr 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYJnHETf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA615E20D
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438860; cv=none; b=OhR3fBkf9PkHThQLaBhDvmslTd+DO0jIY6h/grtDRtYMlgzPd+iOQZM6cnbXhU3pwHAMvae19qGOMN1BuqVJgkdHERsIsB4hF8it1McSj1LP+/aWJ7YTzMJYIZqAQPtiL0PKXbXQ/IpCL3i/0Y8LfcHxDaWphgR4Dc3rPHyUp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438860; c=relaxed/simple;
	bh=5tIkYBCfJCqZryJItLj7l67sCD6SNpcCgy8fz2+3wJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3mOHM3XSgmAsN5+bfdbee0xukMxS3ChqA9qpkr/ugkosW+MzzZOyIaduiDV1NWiQ+1kb6F9yS9O2sLaoOlK3aPrMVXLFdnkBtUEfnK3eDguTrUnu4Js/D1hSrDFfpU7Aa4e6qM1pHWNqR4SvoMPn9P+bHMprlC0kAOLXnoxsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYJnHETf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so827597e87.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438857; x=1714043657; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RjoRqTxo7HSzdTkc4gBgEfqLUPj+ljTbG3vJ3pgN6z8=;
        b=mYJnHETfBSbYvc2+6EXdsqcL+5AMjWMolFHRFMV9u8d2Zi0OEo2vtHwj46Cu+LZMoR
         kXOlSFvQ9z9XtlWTdyFg6kmQpsfiLx2RHmVCGgxCun7vcqlP1lbxqty1f2QFJ6KXVUP9
         iiBqK+ULR4K2xLMzyx05S/ZMN5UwJjgP9f2tGG/UZ6Xlv5eOhWz9+Ppdozq5SrcLcDM5
         akgfBwaWBOPFg5uU53+KrJZJOKi3z/wZXSybvvCKAN696fCVY9fpgr/RXA0UPCfhUD3j
         LaEpYgRfGgPg06LlguRBtYNU2b8JOGKMZDOW50IroGNcnaD+u8tpLHaNG4E/VgZoeQIC
         nsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438857; x=1714043657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjoRqTxo7HSzdTkc4gBgEfqLUPj+ljTbG3vJ3pgN6z8=;
        b=qVZeAsHNl1QpAUYZOtJz+nZNGvtVvvCrKItCxiqeItX9hs/4PxjTAXL77xa3AvNINC
         PsAu2EddpgoenBtDAoSxSLfFxGtHVuhuzDz183Wk8fUFLcm+ft4NRMjn2NSd7goVKry8
         Eji6H1aNFJCAlFAuZsd29EQljB2zxAYFGvtyNgptZkCtqha7ot1UZF4Iv9oPEUCSWM4Y
         sli4QGo5eVsk3So6LSFClwuL8KXl/ETSNAbIV1L54FcN7YMCOmrk1F6VlaPKaTGW73lh
         t2CVs4AUgrLOE+2xm479/50Pm7PXY2LB7MxNm5F75Q4mYlQj/x8da2SwU+6m3IeFVs9l
         VtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIvVpBNziiLUA8Ai6DKabI9VYt1aNOUTh5lc+xQU++mdtaL5WQlo+Y9iUCOEeniqA7Xfuy2ArbZ4RLOYPpZaLcw42DORkn
X-Gm-Message-State: AOJu0YzZLP8swAP7ADeMmSvMpS4QQHJPD50dA3ytN9756VI2qiBeCv9u
	EKKS6RBViNXVMojOssxCrJVcTL8A/PaUHAiyjPsmU18Uo22701Gi
X-Google-Smtp-Source: AGHT+IEzcr/tekYIQJxHLoH0yseds5lxtGEtTPU295fzDzlj8+1kCePk02xberhp5BGqDPbjxaqzxA==
X-Received: by 2002:a05:6512:401:b0:518:cf01:9f21 with SMTP id u1-20020a056512040100b00518cf019f21mr1070342lfk.66.1713438857021;
        Thu, 18 Apr 2024 04:14:17 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id v19-20020a05651203b300b005159412ab81sm197475lfp.216.2024.04.18.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:14:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:14:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 3/6] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
Message-ID: <b3g2spu4y4f2atapsheaput7sjl4abeslwjacy65xaowsbgrsl@to7ek2fubiud>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <b078687371ec7e740e3a630aedd3e76ecfdc1078.1712917541.git.siyanteng@loongson.cn>
 <20240412184939.2b022d42@kernel.org>
 <0e8f4d9c-e3ef-49bd-ae8b-bbc5897d9e90@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e8f4d9c-e3ef-49bd-ae8b-bbc5897d9e90@loongson.cn>

On Mon, Apr 15, 2024 at 10:21:39AM +0800, Yanteng Si wrote:
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > index 9e40c28d453a..995c9bd144e0 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > @@ -213,7 +213,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
> > >   			 loongson_dwmac_resume);
> > >   static const struct pci_device_id loongson_dwmac_id_table[] = {
> > > -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
> > > +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > >   	{}
> > >   };
> > >   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > In file included from ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:6:
> > ../include/linux/pci.h:1061:51: error: ‘PCI_DEVICE_ID_LOONGSON_GMAC’ undeclared here (not in a function); did you mean ‘PCI_DEVICE_ID_LOONGSON_HDA’?
> >   1061 |         .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##_##dev, \
> >        |                                                   ^~~~~~~~~~~~~~
> > ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:11: note: in expansion of macro ‘PCI_DEVICE_DATA’
> >    216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> >        |           ^~~~~~~~~~~~~~~
> > ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:44: error: ‘loongson_gmac_pci_info’ undeclared here (not in a function)
> >    216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> >        |                                            ^~~~~~~~~~~~~~~~~~~~~~
> > ../include/linux/pci.h:1063:41: note: in definition of macro ‘PCI_DEVICE_DATA’
> >   1063 |         .driver_data = (kernel_ulong_t)(data)
> >        |                                         ^~~~
> 

> Will be fixed in v12.

Just move the PCI_DEVICE_ID_LOONGSON_GMAC macro definition from Patch
5/6 to this one.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

