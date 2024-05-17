Return-Path: <netdev+bounces-96915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB648C82F6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1753CB2127B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80361CFBC;
	Fri, 17 May 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAcs+NfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04D10A23
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936861; cv=none; b=Matty/zRgYsopurYdzFykAFDo5buDoHYOXs5Tw15XoQmnKiq6HCqJdcnsd54gRewScGSDFp2u0vc5X0EffnL9P74k/WxsvX+i5vwcNsLIlWZt3gJlBcrGDjVUfCsz3pBULbUGaOyJwnMKFoDU37tOZzv6Y6u8AsduXTPPT11nlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936861; c=relaxed/simple;
	bh=PZw+GXFDGQN6aaySB9ABJU2JqXTtDGCL+Ih8JzZpiSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRQPzOAIjbxAG04629a7HLZM3TG+vUuBG9soIKisSOEZnPJQaN/rlAg6rdWl3aOWRz1+airKOv05Vpqd7nmRf3d9fFXTGisL+Q+/EYi7UdI9En7mTDj32UcL7fjcQRhd0bX222ZXkkxM2/ptOmLIptgn9XSTWbDZx0hgwUXbkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAcs+NfP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5210684cee6so486815e87.0
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715936858; x=1716541658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUr5lK2Q/DlQ8HchNosG5H07DrUbI/DvSurqsjD4cbQ=;
        b=jAcs+NfPwa1AKTsyKMRWGaxiF3ZzpUaD9UV5HBQ6TbHsGo1xufklWKQsJ8Pi+axSfU
         RkD3ktPziB9z1bQLQYNMTuN503UKfbGwMevQmaIRZytd+Nk8y1rrGMmXZ/CMsAjFVxtm
         pMUbj3CD8ZzcRuJ4zG9NnxGsuZ489polBdMCRGhGGWPeN3Ajdb33wdiVhtHhKr2wAMIw
         3RykdKYpVd55ozHKO7onzIEhbjRMgcqU9/FDeeXAHRgOy5zj1mZYpcoyCtbU1Ret+nBo
         QR3RdCZGPHoSiyzC2CMmArYCXdYfQgjIu5Gi2ZnFAL3/Ohtx+rZr2SoqYKvHXeympnes
         vbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715936858; x=1716541658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUr5lK2Q/DlQ8HchNosG5H07DrUbI/DvSurqsjD4cbQ=;
        b=pZvY+unwE3UDcucJD38jbc+yI014Ivst6p+YlaC27QNigSrLwaRNXxkC+FGbPovrr6
         oFJ5pR0XhuSYlHhYMN4JoTZuXIPomd85ow4hOoz+T+M+izu/pQXrlgsi07Kj9AFVPAPW
         TtOUfse0HEFnOZwisfBjmkpHi82O6BsxCdBt34kwqaZi5l4eBLIvMoF8au10CElDy/FE
         YX6aScl64rzj9aHYR0EdgTzQWM6wNLOmoB4LJUDalK73T6l+t2TNPfEP5yx+LlvWs6W/
         ueSUyhmebdGJ3+JFPK3jsPMgyP2v//ufBUsk1GiwPaFiT+abzEldum8wDaIcY9iMz/CK
         wi1g==
X-Forwarded-Encrypted: i=1; AJvYcCWj6nrmgtOlGQTh1l4ZmPbp+9W8Ji2lVdqCp9C0aj6nwVr7lfh6iX+2P6A8GQV8kge9gpiuGaLxQCsKqv3I/NdkLuLqOfeE
X-Gm-Message-State: AOJu0YzHgzGBWML97lioLz/rDu4ZECwjbE6XhFkbu4KEGF+MTWgVXmBV
	dc1b/dU8rB0dJEl1rf2sunVsfV/bt5cm2RStW12f6JSRph9gBCPH
X-Google-Smtp-Source: AGHT+IE5Xop4HexGaIQJP5GhRAqey4TKUJHGctC3nX+TcVr96TNBehZb7VdS8Zm4WNX/T1A0sQAkWw==
X-Received: by 2002:a19:6449:0:b0:51d:8756:33f3 with SMTP id 2adb3069b0e04-5220fc6d46bmr13470099e87.32.1715936857881;
        Fri, 17 May 2024 02:07:37 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad584sm3242769e87.21.2024.05.17.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 02:07:37 -0700 (PDT)
Date: Fri, 17 May 2024 12:07:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <l3bkpa2bw2gsiir2ybzzin2dusarlvzyai3zge62kxrkfomixb@ryaxhawhgylt>
References: <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
 <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
 <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
 <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
 <460a6b52-249e-4d50-8d3e-28cc9da6a01b@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <460a6b52-249e-4d50-8d3e-28cc9da6a01b@loongson.cn>

On Fri, May 17, 2024 at 04:42:51PM +0800, Yanteng Si wrote:
> Hi Huacai, Serge,
> 
> 在 2024/5/15 21:55, Huacai Chen 写道:
> > > > > Once again about the naming. From the retrospective point of view the
> > > > > so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
> > > > > look similar because these are just the level-type signals connected
> > > > > to the system IRQ controller. But when it comes to the PCI_Express_,
> > > > > the implementation is completely different. The PCIe INTx is just the
> > > > > PCIe TLPs of special type, like MSI. Upon receiving these special
> > > > > messages the PCIe host controller delivers the IRQ up to the
> > > > > respective system IRQ controller. So in order to avoid the confusion
> > > > > between the actual legacy PCI INTx, PCI Express INTx and the just
> > > > > platform IRQs, it's better to emphasize the actual way of the IRQs
> > > > > delivery. In this case it's the later method.
> > > > You are absolutely right, and I think I found a method to use your
> > > > framework to solve our problems:
> > > > 
> > > >     static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
> > > >                                            struct plat_stmmacenet_data *plat,
> > > >                                            struct stmmac_resources *res)
> > > >     {
> > > >         int i, ret, vecs;
> > > > 
> > > >         /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > >          * --------- ----- -------- --------  ...  -------- --------
> > > >          * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > >          */
> > > >         vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
> > > >         ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
> > > >         if (ret < 0) {
> > > >                 dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> > > >                 return ret;
> > > >         }
> > > >        if (ret >= vecs) {
> > > >                 for (i = 0; i < plat->rx_queues_to_use; i++) {
> > > >                         res->rx_irq[CHANNELS_NUM - 1 - i] =
> > > >                                 pci_irq_vector(pdev, 1 + i * 2);
> > > >                 }
> > > >                 for (i = 0; i < plat->tx_queues_to_use; i++) {
> > > >                         res->tx_irq[CHANNELS_NUM - 1 - i] =
> > > >                                 pci_irq_vector(pdev, 2 + i * 2);
> > > >                 }
> > > > 
> > > >                 plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > >         }
> > > > 
> > > >         res->irq = pci_irq_vector(pdev, 0);
> > > > 
> > > >       if (np) {
> > > >           res->irq = of_irq_get_byname(np, "macirq");
> > > >           if (res->irq < 0) {
> > > >              dev_err(&pdev->dev, "IRQ macirq not found\n");
> > > >              return -ENODEV;
> > > >           }
> > > > 
> > > >           res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> > > >           if (res->wol_irq < 0) {
> > > >              dev_info(&pdev->dev,
> > > >                   "IRQ eth_wake_irq not found, using macirq\n");
> > > >              res->wol_irq = res->irq;
> > > >           }
> > > > 
> > > >           res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> > > >           if (res->lpi_irq < 0) {
> > > >              dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > > >              return -ENODEV;
> > > >           }
> > > >       }
> > > >         return 0;
> > > >     }
> > > > 
> > > > If your agree, Yanteng can use this method in V13, then avoid furthur changes.
> > > Since yesterday I have been too relaxed sitting back to explain in
> > > detail the problems with the code above. Shortly speaking, no to the
> > > method designed as above.

> > This function is copy-paste from your version which you suggest to
> > Yanteng, and plus the fallback parts for DT. If you don't want to
> > discuss it any more, we can discuss after V13.

My conclusion is the same. no to _your_ (Huacai) version of the code.
I suggest to Huacai dig dipper in the function semantic and find out
the problems it has. Meanwhile I'll keep relaxing...

> > 
> > BTW, we cannot remove "res->wol_irq = res->irq", because Loongson
> > GMAC/GNET indeed supports WoL.
> 
> Okay, I will not drop it in v13.

Apparently Huacai isn't well familiar with what he is reviewing. Once
again the initialization is useless. Drop it.

> 
> All right. I have been preparing v13 and will send it as soon as possible.
> 
> Let's continue the discussion in v13. Of course, I will copy the part that
> has
> 
> not received a clear reply to v13.
> 

Note the merge window has been opened and the 'net-next' tree is now
closed. So either you submit your series as RFC or wait for the window
being closed.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

