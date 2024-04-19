Return-Path: <netdev+bounces-89563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017158AAB46
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B8B28167B
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCEF69DFB;
	Fri, 19 Apr 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZlN1sGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A34D131
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518230; cv=none; b=Ox3f9BugGHtGokmSmo7DpjYg/AhfSFaMLkjYqX7yGURb6IEjG/D+jqZZrC0QGyCN2gv3Y8wdoLTKhbf2ch9plSK2jpQayhtJ+0kroKm4qnEdxqQWC+8xEyNaqo5MJuT4SQt/tEBFLVaBUb7xFtHGeP5CKDUls7Kx1bzrodCrcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518230; c=relaxed/simple;
	bh=C3+dBCICsOMWLwza0Qfj9C9BoBcNN5mFcQLkVAXuz0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7s/hW2aWhJm7FmyveCnCoQG1b8AJhzOyekhiYhImbGsFtlxQ8/YdlOptOoVns3fqA2KbQqBlLxDOPmaA6LNkUmP31/KunToQ4JgEZ/DCRMRcGz7SFP1Rasbf7rbj25qGp/tgmxXxFS/gbrOMUOKxsXFGpd1d8poH3jZynKRvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZlN1sGS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5194cebd6caso2163216e87.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713518227; x=1714123027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qA+jHaZ971v5fc9F72WJ21aFgowg1NxbQRvruTfS7wM=;
        b=HZlN1sGS88QEd9M025oeZVGDJETjbcz2JVmvnJLHQDELXZoGjKp4wJxnanxCZ/IWyg
         e+CPBfkaf+wqvOPb54bfN7THKVvTMMRABVO2LvZWG1M/NA51hebxRmjal/yT5N3Un6uZ
         pFy/P+8jaan9vaOLGp3UPF65ko7pK6aIUjO/s42gnBRMXPY0Qm+GttQI6y+6ItG147Yj
         BZXBu5J4K5H1yIuZnnpNioU8Ileu7uxTITzwAml6ksJyOJmb0hX8H1Nq19Cl4dKjE+ig
         ZppZOeCU0LBWZ4jElvxC1TvOyq6xoO1umYTmg3rblbW73GvG9mOgJhjFffcuqUbHyN/o
         uN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518227; x=1714123027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA+jHaZ971v5fc9F72WJ21aFgowg1NxbQRvruTfS7wM=;
        b=PxSxcn/0vV/xjgSAujWE4xNpyfD3xCutruu4JPE6XpEgncn0pn8l6VqoYPl8PGoEzv
         euY1MD0yMpkni0L9ztDYCue6bGGb5cYf+xTYuB1nQyZv0QP1uNi9ViOhEgnYJ0Sefru/
         7jvKceSVI1T9vWfrrYkDWcDaXn5zx1DdEILWNXdaa/PDHwQVu7U0zZqwAZdrd1eMB/yj
         BbT/6CaxoFdkG8alvnIN+VyQe6oRVTIsa5LwO+W7opsXYCi9QOzHXGTA9prGYzuKzwsq
         02/nNDJH1PY9E8yJnu7GRaJaMwbhQPxaH0sr9xLkd6Ou7ZKrS2f5skHHsvc/YE4hCcMM
         IiAg==
X-Forwarded-Encrypted: i=1; AJvYcCWrH3Fw3uIC0AfJN/fKGwj2bqC9z+G4U42WVvhaB+J6f3/aVrSjq6QPOE7e3Klw6ZqYeLi6ndYQhNCAUCjAdMfOSkCGH2sy
X-Gm-Message-State: AOJu0YzFxHJ2lmei+jysaWbtkqbIPxgpWEfl4Yu0ajspfmg8oJrcEZQn
	zpTJtR3Yhip9q78oI5iAzFjBPCEPKwLRnGrkmYm/2YGXoTzLhBqR
X-Google-Smtp-Source: AGHT+IFf9tNzfd/0aJFV+Q2DQ/Ld2wuNriPQs/HLR8ZXmc3PIRcr3moPYfPnjEX4atblkX/hhyELhw==
X-Received: by 2002:a19:8c0c:0:b0:51a:bd58:6764 with SMTP id o12-20020a198c0c000000b0051abd586764mr785315lfd.34.1713518226622;
        Fri, 19 Apr 2024 02:17:06 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id g28-20020a0565123b9c00b00518be964835sm619823lfv.53.2024.04.19.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:17:06 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:17:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 2/6] net: stmmac: Add multi-channel support
Message-ID: <juwqvnv22ky5avg72prgi2ocx7qy4kqldet4t4qfooerj3p6nn@lrnlkioxxevy>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <5b6b5642a5f3e77ddf8bfe598f7c70887f9cc37f.1712917541.git.siyanteng@loongson.cn>
 <5v6ypjjtbq72ovb437p6n4fkq2z5a3nhkv6spjct2flvjaxmgq@ykrdiv7kk4kq>
 <636a0d00-3141-4d4d-85af-5232fd5b1820@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636a0d00-3141-4d4d-85af-5232fd5b1820@loongson.cn>

On Fri, Apr 19, 2024 at 05:02:17PM +0800, Yanteng Si wrote:
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > index daf79cdbd3ec..f161ec9ac490 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > @@ -70,15 +70,17 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> > >   	writel(value, ioaddr + DMA_AXI_BUS_MODE);
> > >   }
> > > -static void dwmac1000_dma_init(void __iomem *ioaddr,
> > > -			       struct stmmac_dma_cfg *dma_cfg, int atds)
> > > +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> > > +				       void __iomem *ioaddr,
> > > +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
> > please create a pre-requisite/preparation patch with the atds argument
> > movement to the stmmac_dma_cfg structure as I suggested in v8:
> > https://lore.kernel.org/netdev/yzs6eqx2swdhaegxxcbijhtb5tkhkvvyvso2perkessv5swq47@ywmea5xswsug/
> > That will make this patch looking simpler and providing a single
> > coherent change.
> OK.

> > >   	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> > > -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
> > > +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> > I'll ask once again:
> > 
> > "Isn't the mask change going to be implemented in the framework of the
> > Loongson-specific DMA-interrupt handler in some of the further
> > patches?"
> > 
> The future is not going to change.

Not sure I've completely got what you meant. You are adding the
Loongson-specific DMA IRQ handler in Patch 6/6:
https://lore.kernel.org/netdev/cover.1712917541.git.siyanteng@loongson.cn/T/#m439c1d8957cd6997beb0374484a8d0efbeac0182

The change in the patch 2/6 concerns the _generic_ DW MAC DMA IRQ
handler. You can't change the mask here without justification.
Moreover the generic DW MAC doesn't have the status flags behind the
mask you set. That's why earlier we find out a solution with creating
the Loongson-specific DMA IRQ-handler. You have it implemented in the
patch 6/6.

So my question was mostly rhetorical. You should have dropped the mask
change in this patch ever since the Loongson-specific DMA
IRQ-handler was added to your series.

-Serge(y) 

> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> 

