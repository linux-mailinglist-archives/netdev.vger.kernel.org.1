Return-Path: <netdev+bounces-89182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1328A99E1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6B2B22A04
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AD182C5;
	Thu, 18 Apr 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SScQHgZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CCE57B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443499; cv=none; b=Myaa6bCskmeAgIMMWeMs7MEObW/i2fXY4wNpJL+XYayYGQgXjr26upX7UVhsiUC8mcgRklsKLUwRVM3DHJiK1K6dAq9FkaUJI/cweNfOjlpXSLh7rXEjiUoMG1SHy+hPu5rIuXBx/97aL6gYmH5OX/lzyIC8hlEfBBgyFDYe/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443499; c=relaxed/simple;
	bh=L7ofQA4kwD8cJXbIzFcWQvFRtbHJRChJiDR04VP/84c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E49lDSmbgeRg1+gEb2vPsyRNY0N/qxfdLl0NJu1v2Wi+yt/vb1sxGydzDh475JbyBlQnVpPW7wBQQQ+yc6JYiP8qpqM4fdVCricY89SuYPW0b9QhmsZxHOxz77JFcIvUyalRlkN6XoJx9sEoKOcuqUsjpqrDqmh5/zxv8sk7clI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SScQHgZN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d3a470d5so898108e87.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713443496; x=1714048296; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ujj5nxG3JBP+ilkPtG+ibqRZyvxFhWiJmdaF1yoIGew=;
        b=SScQHgZNK3PbluhTA3G0epyaOGLlJiJ5qnEgI6uBGCZ8hyNMEYQ6SBLTGeX9AB4QkK
         EDztKCDHi7Xjr2ztZTUVj/3/Rj8aW3xEMAT6UvemK9Nqf9H3Ga7hIz1ljTMQg2DT50Ct
         XPuMD7bLwX1OulOVOi5rxTny6K65kcAn+VjG+IhBd5rVApmzr3T3nvyzhLAJWkF0X8MU
         NZ8ZiX43Kye9NnSIy2T4us6luap6bTAgY3Y31sXqbRMN9q0IldUdQG5pDgH8CXJOlkYM
         GlDuxcDBR7kNS/VXuL0RQu3+Q3aQg7MGuHJyV9Y1HY4ERJ02NSI2X12rZ6OJMnqn2pWo
         kKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443496; x=1714048296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujj5nxG3JBP+ilkPtG+ibqRZyvxFhWiJmdaF1yoIGew=;
        b=LZ/1AWLD3oe7Z3RNt+Or5md65ydZFk7muefZpczGoiwDlHAA6cPqp//SyP6e7HMNuV
         1P9UArB1U76haeNO39BK7aiwfZ1FcAYE41Q5mTKHBXTXRmE7GR8HADYDCC8lzJtkoXKn
         +RWPh6qveO43z4tYIBozVVHtqlKE9RfXVolgMqG6BEySm0cnggqYc2mjZ7GYpvCZnTPw
         PBaMmnr36+iCuvV/7fn2b47/WE2FH4q8pgbHmMl5+Rni7HrzXvmPFn5+HAr5qp5LINyY
         ZOEtl2ux6vTo//z2VHAWl61BjenPtJa7Jr5AaNbcKxJVwwt9xV0g6k6F3o7OOWf/wjKO
         k0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHyL/NiLKmNJB9PkwQ/KTvmVMcYPoWktyE+Tt3dhyL6hDuGAWeAXYdykz3wxhg8EdaLum0UkZniJA7lq0ccxwdqlDAiC+R
X-Gm-Message-State: AOJu0YwbBIrnibLohzzkSDd35MHMFWNEKinmet6pKf5vV0AGS52EDzqb
	ftQ6DybOy0xV+j27+nBqGN11Tdyhwy/0dlr0cYapsTyxssfzP0Vc
X-Google-Smtp-Source: AGHT+IE3z258VXUG6U0f+0SDIGyvM327sqbGCTcyIgQ38yhlNkJpdfcYp9hwOxwnGXFHoXxBoJUOQA==
X-Received: by 2002:a19:5f53:0:b0:513:30fb:d64 with SMTP id a19-20020a195f53000000b0051330fb0d64mr1386231lfj.44.1713443495631;
        Thu, 18 Apr 2024 05:31:35 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id e28-20020ac2547c000000b00515d407aaa0sm217368lfn.252.2024.04.18.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:31:35 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:31:33 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 3/6] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
Message-ID: <y6ea3idgz5i4qhhb4agbizmosgg6yuijgsjhgexwxnioqczwlo@slq7q5ln3twr>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <b078687371ec7e740e3a630aedd3e76ecfdc1078.1712917541.git.siyanteng@loongson.cn>
 <20240412184939.2b022d42@kernel.org>
 <0e8f4d9c-e3ef-49bd-ae8b-bbc5897d9e90@loongson.cn>
 <b3g2spu4y4f2atapsheaput7sjl4abeslwjacy65xaowsbgrsl@to7ek2fubiud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3g2spu4y4f2atapsheaput7sjl4abeslwjacy65xaowsbgrsl@to7ek2fubiud>

On Thu, Apr 18, 2024 at 02:14:17PM +0300, Serge Semin wrote:
> On Mon, Apr 15, 2024 at 10:21:39AM +0800, Yanteng Si wrote:
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > index 9e40c28d453a..995c9bd144e0 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > @@ -213,7 +213,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
> > > >   			 loongson_dwmac_resume);
> > > >   static const struct pci_device_id loongson_dwmac_id_table[] = {
> > > > -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
> > > > +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > > >   	{}
> > > >   };
> > > >   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > > In file included from ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:6:
> > > ../include/linux/pci.h:1061:51: error: ‘PCI_DEVICE_ID_LOONGSON_GMAC’ undeclared here (not in a function); did you mean ‘PCI_DEVICE_ID_LOONGSON_HDA’?
> > >   1061 |         .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##_##dev, \
> > >        |                                                   ^~~~~~~~~~~~~~
> > > ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:11: note: in expansion of macro ‘PCI_DEVICE_DATA’
> > >    216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > >        |           ^~~~~~~~~~~~~~~
> > > ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:44: error: ‘loongson_gmac_pci_info’ undeclared here (not in a function)
> > >    216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > >        |                                            ^~~~~~~~~~~~~~~~~~~~~~
> > > ../include/linux/pci.h:1063:41: note: in definition of macro ‘PCI_DEVICE_DATA’
> > >   1063 |         .driver_data = (kernel_ulong_t)(data)
> > >        |                                         ^~~~
> > 
> 
> > Will be fixed in v12.
> 

> Just move the PCI_DEVICE_ID_LOONGSON_GMAC macro definition from Patch
> 5/6 to this one.

... and of course pass NULL as the data-pointer to PCI_DEVICE_DATA().

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > 
> > Thanks,
> > 
> > Yanteng
> > 

