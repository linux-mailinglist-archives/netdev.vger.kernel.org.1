Return-Path: <netdev+bounces-97004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6C8C8A32
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49017280F45
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FBE13D63B;
	Fri, 17 May 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0wPvl9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB913D625
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963874; cv=none; b=dQdborC8E5Aa7HfmJXYUfQkkEioLV7O/8S4ZtWJoz1ctnyNdbOWPWRgZo3qBcBunFHMzyl0kcY7g+yfibW7wxFb/u7qDDkluAVQB5vDeiLclYx6Z1mjfbyTaUQY1n2Uf9fAiIpQpCEx0WBIBlBt+O3F7Dfs2SREyvu24XT2G0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963874; c=relaxed/simple;
	bh=bu2q0KkkLzGSzDH+nd3yl8NQNAUTF4uaQVXC7WFZOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zflvr/oZ2O6tyNqHaubFOL+Xaq+jNA/kQ4Irs4JndpJF5ThuddbqqEoeASAert8ahkKYafhz+WEz3c0ulMYxJ2wcbhYh1EDx3gIfdNqWE/AxFWrZ0W4zCX5XjQqj0DaueurzrbhZySpeSWpp7SOph45/ZGs0UINK9dE//VhuSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0wPvl9h; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e1d6166521so17729801fa.1
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963871; x=1716568671; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EAP4DaN4vw8gjJ0R+hijViGMtsg/0OuyGjPOGh3XheM=;
        b=U0wPvl9hrxXS65DC+isEx+pqUkfRCDWwvQlJhDytPfcK8jFYNDSZZY0HDrL/KDFcar
         UM5Mx3tJa6VfOxd3AfGz1lsIdF+ur/l4EPhl9aLbP7Bb60jQ9i18w7E+VpMEzHOft4gv
         JdqqFffB7J5EO2iYsuKbUnokJGQYZ+llIbsK11QWR7gOP1Bu2aiaYxaA0tIp/np8gSeL
         AowjIuwZCAUVPAaas5oQFU4Fel4say45ABOSYTzBtSLp2cVr3PI/G77jTE1UV0mRE7qB
         tEVEmC/7vm7XZcLo7h3aOqhx56UdFW4yKYtrkO++8YosvzzMDMXD/rLp+Dr8E2+Pz2gX
         uHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963871; x=1716568671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAP4DaN4vw8gjJ0R+hijViGMtsg/0OuyGjPOGh3XheM=;
        b=L4quVQ7znfU8+7EGZXppG/WR1G6utWKuzoB6wgC7lPbZl4c21DmUlHFwFrHl6wQJpi
         71yGAfX8CICdlDPU8jKqgeY4MCX4WL8dcQ3UZA/XntluLl3fTXjbnVwz3U20fa5M39+x
         NZ9UDwUxxFJYmfi0lBgMcOwOUqHHhscewNkpQWOCcNasjNLnFNrFBKUHagPp+IpE7jJK
         96ZyoTHyo3T3GRff6q/8MvaHykL0Wy1eoHjfZjl2qO9EsbbxmmMESRD+sp+zXYLScKz3
         7vzYhhbVtacZnb3hdGmh+hEoCiDyPGb98A52MK0CWHhhaRZ4ZTgedHH6wQG6GPnZ8cK4
         tDLw==
X-Forwarded-Encrypted: i=1; AJvYcCXE7q5pWmf2i/p8ZaZQlnCCD0ZmtU00s0DR0NOhKPZlg1jLBVdkLLFG7H/bNTEqFcRU5nn/e1pgEHm3zkTnhGt/83AgnkLs
X-Gm-Message-State: AOJu0Yz+/UngWg/x52xPD0Q/q9fCYNs3Gb85Qo/zbi58kKyH5YSt/l7n
	YwRJHaar2fOkFnWaBUIXjDB4UOS1LCn+XWs3kqtfzZFOwG7xQOxM
X-Google-Smtp-Source: AGHT+IEojpmRUNjMd54jCV3Z5OggilSEyQM71Hf8/ydxCCrqE1nE3+IfBOF7j6rtj6mEmw3ktsc9PQ==
X-Received: by 2002:a2e:868f:0:b0:2df:8e58:d05c with SMTP id 38308e7fff4ca-2e51ad435admr73609581fa.15.1715963870875;
        Fri, 17 May 2024 09:37:50 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d18344e9sm26772491fa.139.2024.05.17.09.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:37:50 -0700 (PDT)
Date: Fri, 17 May 2024 19:37:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <ikmwqzwplbnorwrao6afj6t4iksgo4t7jk6to65pnmtqgmalkv@gnrv5cskqlsb>
References: <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
 <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
 <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
 <460a6b52-249e-4d50-8d3e-28cc9da6a01b@loongson.cn>
 <l3bkpa2bw2gsiir2ybzzin2dusarlvzyai3zge62kxrkfomixb@ryaxhawhgylt>
 <c09237c6-6661-4744-a9d3-7c3443f2820c@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c09237c6-6661-4744-a9d3-7c3443f2820c@loongson.cn>

On Fri, May 17, 2024 at 06:37:50PM +0800, Yanteng Si wrote:
> Hi Serge,
> 
> 在 2024/5/17 17:07, Serge Semin 写道:
> > On Fri, May 17, 2024 at 04:42:51PM +0800, Yanteng Si wrote:
> > > Hi Huacai, Serge,
> > > 
> > > 在 2024/5/15 21:55, Huacai Chen 写道:
> > > > > > > Once again about the naming. From the retrospective point of view the
> > > > > > > so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
> > > > > > > look similar because these are just the level-type signals connected
> > > > > > > to the system IRQ controller. But when it comes to the PCI_Express_,
> > > > > > > the implementation is completely different. The PCIe INTx is just the
> > > > > > > PCIe TLPs of special type, like MSI. Upon receiving these special
> > > > > > > messages the PCIe host controller delivers the IRQ up to the
> > > > > > > respective system IRQ controller. So in order to avoid the confusion
> > > > > > > between the actual legacy PCI INTx, PCI Express INTx and the just
> > > > > > > platform IRQs, it's better to emphasize the actual way of the IRQs
> > > > > > > delivery. In this case it's the later method.
> > > > > > You are absolutely right, and I think I found a method to use your
> > > > > > framework to solve our problems:
> > > > > > 
> > > > > >      static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
> > > > > >                                             struct plat_stmmacenet_data *plat,
> > > > > >                                             struct stmmac_resources *res)
> > > > > >      {
> > > > > >          int i, ret, vecs;
> > > > > > 
> > > > > >          /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > > > > >           * --------- ----- -------- --------  ...  -------- --------
> > > > > >           * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > > > > >           */
> > > > > >          vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
> > > > > >          ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
> > > > > >          if (ret < 0) {
> > > > > >                  dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> > > > > >                  return ret;
> > > > > >          }
> > > > > >         if (ret >= vecs) {
> > > > > >                  for (i = 0; i < plat->rx_queues_to_use; i++) {
> > > > > >                          res->rx_irq[CHANNELS_NUM - 1 - i] =
> > > > > >                                  pci_irq_vector(pdev, 1 + i * 2);
> > > > > >                  }
> > > > > >                  for (i = 0; i < plat->tx_queues_to_use; i++) {
> > > > > >                          res->tx_irq[CHANNELS_NUM - 1 - i] =
> > > > > >                                  pci_irq_vector(pdev, 2 + i * 2);
> > > > > >                  }
> > > > > > 
> > > > > >                  plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > > > >          }
> > > > > > 
> > > > > >          res->irq = pci_irq_vector(pdev, 0);
> > > > > > 
> > > > > >        if (np) {
> > > > > >            res->irq = of_irq_get_byname(np, "macirq");
> > > > > >            if (res->irq < 0) {
> > > > > >               dev_err(&pdev->dev, "IRQ macirq not found\n");
> > > > > >               return -ENODEV;
> > > > > >            }
> > > > > > 
> > > > > >            res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> > > > > >            if (res->wol_irq < 0) {
> > > > > >               dev_info(&pdev->dev,
> > > > > >                    "IRQ eth_wake_irq not found, using macirq\n");
> > > > > >               res->wol_irq = res->irq;
> > > > > >            }
> > > > > > 
> > > > > >            res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> > > > > >            if (res->lpi_irq < 0) {
> > > > > >               dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > > > > >               return -ENODEV;
> > > > > >            }
> > > > > >        }
> > > > > >          return 0;
> > > > > >      }
> > > > > > 
> > > > > > If your agree, Yanteng can use this method in V13, then avoid furthur changes.
> > > > > Since yesterday I have been too relaxed sitting back to explain in
> > > > > detail the problems with the code above. Shortly speaking, no to the
> > > > > method designed as above.
> > > > This function is copy-paste from your version which you suggest to
> > > > Yanteng, and plus the fallback parts for DT. If you don't want to
> > > > discuss it any more, we can discuss after V13.
> > My conclusion is the same. no to _your_ (Huacai) version of the code.
> > I suggest to Huacai dig dipper in the function semantic and find out
> > the problems it has. Meanwhile I'll keep relaxing...
> > 
> > > > BTW, we cannot remove "res->wol_irq = res->irq", because Loongson
> > > > GMAC/GNET indeed supports WoL.
> > > Okay, I will not drop it in v13.
> > Apparently Huacai isn't well familiar with what he is reviewing. Once
> > again the initialization is useless. Drop it.
> 

> Hmm, to be honest, I'm still a little confused about this.
> 
> When we first designed the driver, we looked at intel,See:
> 
> $: vim drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c +953
> 
> static int stmmac_config_single_msi(struct pci_dev *pdev,
>                     struct plat_stmmacenet_data *plat,
>                     struct stmmac_resources *res)
> {
>     int ret;
> 
>     ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>     if (ret < 0) {
>         dev_info(&pdev->dev, "%s: Single IRQ enablement failed\n",
>              __func__);
>         return ret;
>     }
> 
>     res->irq = pci_irq_vector(pdev, 0);
>     res->wol_irq = res->irq;
> 
> Why can't we do this?
> 
> Intel Patch thread link <https://lore.kernel.org/netdev/20210316121823.18659-5-weifeng.voon@intel.com/>

First of all the Intel' STMMAC patches isn't something what can be
referred to as a good-practice example. A significant part of the
mess in the plat_stmmacenet_data structure is their doing.

Secondly as I already said several times initializing res->wol_irq
with res->irq is _useless_. It's because of the way the WoL IRQ line
is requested:

stmmac_request_irq_single(struct net_device *dev)
{
	...
	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
                ret = request_irq(priv->wol_irq, stmmac_interrupt,
                                  IRQF_SHARED, dev->name, dev);
		...
        }
	...
}

stmmac_request_irq_multi_msi(struct net_device *dev)
{
	...
	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
                int_name = priv->int_name_wol;
                sprintf(int_name, "%s:%s", dev->name, "wol");
                ret = request_irq(priv->wol_irq,
                                  stmmac_mac_interrupt,
                                  0, int_name, dev);
		...
        }
	...
}

See, even if you initialize priv->wol_irq with dev->irq (res->irq) it
will have the same effect as if you had it left uninitialized
(pre-initialized with zero). So from both maintainability and
readability points of view it's better to avoid a redundant code
especially if it causes an ill coding practice reproduction.


Interestingly to note that having res->wol_irq initialized with
res->irq had been required before another Intel' commit:
8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")
(submitted sometime around the commit you are referring to).
In that commit Intel' developers themself fixed the semantics in the
STMMAC core driver, but didn't bother with fixing the platform drivers
and even the Intel' DWMAC PCI driver has been left with that redundant
line of the code. Sigh...

> 
> 
> > 
> > > All right. I have been preparing v13 and will send it as soon as possible.
> > > 
> > > Let's continue the discussion in v13. Of course, I will copy the part that
> > > has
> > > 
> > > not received a clear reply to v13.
> > > 
> > Note the merge window has been opened and the 'net-next' tree is now
> > closed. So either you submit your series as RFC or wait for the window
> > being closed.
> > 

> Ok, if I'm fast enough, I'll send an RFC to talk about msi and legacy.

It's up to you. But please be aware, I'll be busy next week with my
own patches cooking up. So I won't be able to actively participate in
your patches review.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

