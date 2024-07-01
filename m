Return-Path: <netdev+bounces-108293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5791EB37
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460381C20C0F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE75171E76;
	Mon,  1 Jul 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDBcr8iU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924886131
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874654; cv=none; b=adfpDNQafLFS4invL/oCUADaVYLMLMGIxKPP3QPUASbKTeo+6FgOuSrB5McZJz0lLrdDtqLpJqafL1F7VSqWNmD86jcW74RVgImTkpjD0UsfNQSvEmP52P0HNUIVGN0vTf2wRMJO3mNw3R+P6Dli/CEsubnKAkItFZ3SlNQo1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874654; c=relaxed/simple;
	bh=Q1zx2mNj/oo80mYo/y6tVTNqOLL/bTiF6Ai68Sm77/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAecrDsJQNGwCOEHx8mPwjO2k41cwzk3IsbG0VIts67ReQezfFDXWkPqJecH/2T1nu/StokQCA0FbBUo+Rrx0Rg7jyP1yA9ScxJIioPnWcHccXSLC8syEEIDwe1leYvfEjHcZcKWklP0QXjlAjtJdPfRkXUwY05gaFjez+cihFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDBcr8iU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cecba8d11so4308072e87.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719874651; x=1720479451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFlSLn41/+I7sWXNxVEuk+E2wYDq7q/w06gtb/X7pOY=;
        b=LDBcr8iUYFuZUOpyekw2MHJv/5F+E4l+yS7Twdh+aQziOzNAh8vMDe+HKaZuIqtX0z
         On+lWWUcPh79jYxias8Rtt5BFjlr2dykvxtgLTm2t/CAhnUfsCWdiHgA4PZGeGeK1ZZD
         YPoC9u+jZp+NKDem0sojNw8ZorLTBcJQEycshvisWEPa+Lfb9u/4qpDCwYcdVgXbvUVD
         GGS2LuEtvXEoLRbWQCdMxJZlLa1kRhn1mTEJwn4I0WFyxZz2KqJuKH6pON4PQA8mEjIo
         tyIRIzLa5AeOkcQj6BEAZNqvhw73N/K6w60A82CO6Ukm1xSKD0Zr8tqFhY/nbAXGTy4W
         QlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719874651; x=1720479451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFlSLn41/+I7sWXNxVEuk+E2wYDq7q/w06gtb/X7pOY=;
        b=Wz9htRrVQDDTCMcNQZUX9TV7Ns7qZ57WqUJKxretX9bqbrTYSvj31mxzuSMan/i/Pg
         xgnKeYemcq9g7jfiS+lhB1huf/fBi8+S3Q9J2/6WQVQS8Sjr0tIUmJCAc27biONnAwFX
         ESkn1GfbfFrHgZbZd1Q8PymSoo3x05e/r01YRXGWX+R+oAjysB1EsceGZK6uYouSimxm
         aWPoCFmN2FGrVu8VKjT29w1I6cgQfEdtQgGLPeu3cVsxjNSsycL//6nnlP4U7w0m6KRv
         JnG9ZtHCd8u6lJ+0vBmZ5UEF38v0mKj7Y6p5PVGtpx/FqijPO1udwKfidT0MEZoEo6gQ
         jUAg==
X-Forwarded-Encrypted: i=1; AJvYcCXwVhSa0KNvwln3iSMUhqu+GPFB/hpxUcKmCd0UmhSI8Zm3eyORjGukmD+YQocWQ2MHKaskfhyjzMzg+NBWA3keTVlBhyFK
X-Gm-Message-State: AOJu0YxnNEgvP9tFrviWsh9bxFZ725V9g8V9UcsFUUTUh/AGxJVYkVkI
	Whe9ftUI4wqOVMVTETXe7tOImVFQdGaEK7VcYiczDNSu1UKY2A1E
X-Google-Smtp-Source: AGHT+IGhm30De4VJr41N7NR6rHCefGfZTX9FhAKQKwQ/+bIpBBHGdhMuDtk77jvWvlvDAqDR5EEGFw==
X-Received: by 2002:a05:6512:2348:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-52e82665d66mr4773749e87.16.1719874650704;
        Mon, 01 Jul 2024 15:57:30 -0700 (PDT)
Received: from mobilestation ([176.213.1.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7fbef0c1sm1227373e87.127.2024.07.01.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 15:57:30 -0700 (PDT)
Date: Tue, 2 Jul 2024 01:57:28 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <6ergp6oqrccwzsvdshnapkaukurquouf74x7l7agnmzbhctwma@qw63qlynrred>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <wosihpytgfb6icdw7326xtez45cm6mbfykt4b7nlmg76xpwu4m@6xwvqj7ls7is>
 <eb305275-6509-4887-ad33-67969a9d5144@loongson.cn>
 <xafdw4u5nqknn2qehkke5p4mrj4bnfh33pcmkob5gbl7y5apr4@pkwmf6vphxsh>
 <55193345-f390-4fbb-b4e6-0bcd82cedc9a@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55193345-f390-4fbb-b4e6-0bcd82cedc9a@loongson.cn>

On Tue, Jun 25, 2024 at 08:31:32PM +0800, Yanteng Si wrote:
> 
> 在 2024/6/24 09:47, Serge Semin 写道:
> > On Mon, Jun 17, 2024 at 06:00:19PM +0800, Yanteng Si wrote:
> > > Hi Serge,
> > > 
> > > 在 2024/6/15 00:19, Serge Semin 写道:
> > > > On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
> > > > > Loongson delivers two types of the network devices: Loongson GMAC and
> > > > > Loongson GNET in the framework of four CPU/Chipsets revisions:
> > > > > 
> > > > >      Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> > > > > LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > > > > LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > > > > LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > > > > LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > > > You mentioned in the cover-letter
> > > > https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/
> > > > that LS2K now have GMAC NICs too:
> > > > " 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
> > > >       channels, so we have to reconsider the initialization of
> > > >       tx/rx_queues_to_use into probe();"
> > > > 
> > > > But I don't see much changes in the series which would indicate that
> > > > new data. Please clarify what does it mean:
> > > > 
> > > > Does it mean LS2K2000 has two types of the DW GMACs, right?
> > > Yes!
> > > > Are both of them based on the DW GMAC v3.73a IP-core with AV-feature
> > > > enabled and 8 DMA-channels?
> > > Yes!
> > > > Seeing you called the new device as GMAC it doesn't have an
> > > > integrated PHY as GNETs do, does it? If so, then neither
> > > > STMMAC_FLAG_DISABLE_FORCE_1000 nor loongson_gnet_fix_speed() relevant
> > > > for the new device, right?
> > > YES!
> > > > Why haven't you changed the sheet in the commit log? Shall the sheet
> > > > be updated like this:
> > > > 
> > > >       Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> > > >    LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > > >    LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > > > +LS2K2000 CPU         GMAC      0x7a13          v3.73a            8
> > > >    LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > > >    LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> > > > 
> > > > ?
> > > No! PCI Dev ID of GMAC is 0x7a03. So:
> > > 
> > >   LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a 1
> > >   LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a 1
> > > +LS2K2000 CPU         GMAC      0x7a03          v3.73a 8
> > >   LS2K2000 CPU         GNET      0x7a13          v3.73a 8
> > >   LS7A2000 Chipset     GNET      0x7a13          v3.73a 1
> > > 
> > > > I'll continue reviewing the series after the questions above are
> > > > clarified.
> > > OK, If anything else is unclear, please let me know.
> > Got it. Thanks for clarifying. I'll get back to reviewing the series
> > tomorrow. Sorry for the timebreak.
> 
> OK. No worries.

Seeing Loongson GMAC can be also found with the 8-channels AV feature 
enabled, we'll need to reconsider the patches logic and thus the 
commit logs too. I'll try to thoroughly describe the changes in the
respective parts of the series. But in general, if what I've come up
with is implemented, the patchset will turn to look as follows:

[PATCH net-next v14 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
[PATCH net-next v14 02/15] net: stmmac: Add multi-channel support
[PATCH net-next v14 03/15] net: stmmac: Export dwmac1000_dma_ops
[PATCH net-next v14 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
[PATCH net-next v14 05/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
[PATCH net-next v14 06/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification

[PATCH net-next v14 07/15] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
+-> Init the plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
    in the loongson_gmac_data() method.

[PATCH net-next v14 08/15] net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
[PATCH net-next v14 09/15] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC

[PATCH net-next v14 10/15] net: stmmac: dwmac-loongson: Introduce PCI device info data
+-> Make sure the setup() method is called after the pci_enable_device()
    invocation.

[PATCH net-next v14 11/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
+-> Introduce the loongson_dwmac_dt_config() method here instead of
    doing that in a separate patch.
+-> Add loongson_dwmac_acpi_config() which would just get the IRQ from
    the pdev->irq field and make sure it is valid.

[PATCH net-next v14 12/15] net: stmmac: Fixed failure to set network speed to 1000.
+-> ... not sure what to do with this ...

[PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
+-> This is former "net: stmmac: dwmac-loongson: Add Loongson GNET
    support" patch, but which adds the support of the Loongson GMAC with the
    8-channels AV-feature available.
+-> loongson_dwmac_intx_config() shall be dropped due to the
    loongson_dwmac_acpi_config() method added in the PATCH 11/15.
+-> Make sure loongson_data::loongson_id is initialized before the
    stmmac_pci_info::setup() is called.
+-> Move the rx_queues_to_use/tx_queues_to_use and coe_unsupported
    fields initialization to the loongson_gmac_data() method.
+-> As before, call the loongson_dwmac_msi_config() method if the multi-channels
    Loongson MAC has been detected.
+-> Move everything GNET-specific to the next patch.

[PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
+-> Everything Loonsgson GNET-specific is supposed to be added in the
    framework of this patch:
    + PCI_DEVICE_ID_LOONGSON_GNET macro
    + loongson_gnet_fix_speed() method
    + loongson_gnet_data() method
    + loongson_gnet_pci_info data
    + The GNET-specific part of the loongson_dwmac_setup() method.
    + ...

[PATCH net-next v14 15/15] net: stmmac: dwmac-loongson: Add loongson module author

Hopefully I didn't forget anything. I'll give more details in the
comments to the respective patches.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> 
> > 
> > -Serge(y)
> 

