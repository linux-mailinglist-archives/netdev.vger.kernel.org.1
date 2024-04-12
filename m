Return-Path: <netdev+bounces-87512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93978A35CA
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0BF284B83
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1514EC53;
	Fri, 12 Apr 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRvWR28W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519E446BD
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946866; cv=none; b=bShWCiPJP4OZSWY2Z6NA4VC8Jxg1xVaKo/EkDRpgMVjzSDpXfCHampdnqCk2r0y3e3i00L7NtDF2BSsZ3RoV5TagXx2f1I2aM0PJyXww9acfN+AHy7EbT8engRgNrPrYb54w+oYfiIt5MhUw5dqQ6rSPpR5VVi+3wRug3r8yZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946866; c=relaxed/simple;
	bh=Be6sFMS56Fp0HKrbRIQDkHulRfJS1jDJD57C8H3knM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTs9GTrPQBsFsWK3eINibbQwV1gdOtLLGHm8Bf+ZGen/XnrzrIQCg6v9smA9LKXnPeqbUY4IGBGSdJohmMwlkc1qCF0L+wYDw1ro9Toix47PD8OkWOe2OA5jO4P+vYr8OXQRB3+OD+hZWe1bBoNrsxJWJtg1hi+5JiasKm9g2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRvWR28W; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a56cdbceso42981e87.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712946863; x=1713551663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLuBKzTjKQD3m3pQsUI6lL8l+5eJekv5nVNHDDLAsT8=;
        b=WRvWR28WKCZBTUK4fX+G2Tao0CbCLY0htak5hrmV/epFnaAm6NStcn7kr0O+fa7fCP
         TOvjAbE3I45ZhtpK6OQP+YDGYqTcUtp4ugF/tt8SG7u8gRDRRK1IkpcV3a1GaZxakYCm
         AKnbhmcgL2UNSs+VFnQC0YANZL0m849tYpQqzFe14gkXe8zOJQlqIdQlajA3K0lUslcA
         cM/63cYI2QxVPtagLAPFmp6duKMBWrfm1x+fBX8LqZ8vZKENFWjU7WUeMRcJu+MQyJMk
         sRnk6MOsO19di5lmPjXVU/7qVHd9rEoFTIQlyz2tBN8L3F0iE18hKo4y8kvapFF/TSGZ
         xU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946863; x=1713551663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLuBKzTjKQD3m3pQsUI6lL8l+5eJekv5nVNHDDLAsT8=;
        b=mRtFL5LbiXEnRao7LAjDqZELXp2qkcdhYbt8JbMKpno7o+R4h1nd+WGcPCK0PnvJwB
         DZ89T0QxXYRdfMIsfqzyOW2TobWFyYVlL29M82U4udVlKMb38rMB+krg1Mt6s1Arwgk2
         u+/+fGM2SgAFiwdvK+yvpAhdFjIVio93JAqcbT/rueABsQ61o1ZOslsyDpFrTxOToXiM
         t1Hlcn79NEvlzG2GBdMowCM5GM0N1YOFL63lnOuQX2w7sNLonQJURP9tf20m+sLKCPBs
         zaJhy/slKdMrlfrjF0ED2EIg7NDNjRy8k9ygx/QkF0JSRyyBjvr3ZCPJ/hTsqhACpoC7
         vHvg==
X-Forwarded-Encrypted: i=1; AJvYcCWRHp5Xa3k9aRLTMVr4qj0Ac5cFtofzhV40SuMEqQDuQ0PP+onBinyAhjqqMxJ+HV4MGrbsyMJ3sn7fpiQsW8qRGNBzAGfU
X-Gm-Message-State: AOJu0Yx8jP58UhWxRAMeu6rzJtrE0cPJfKjnCDOY2fXNMpNCoRgk8g7g
	qkMIuYAMEyVSlr0P7q27IJqiGuRyJOk8h9KAPkM5IbRslztR095u
X-Google-Smtp-Source: AGHT+IFw1PVzMNH2XCv52J/EAKT00kTJuPu871O+1GeawLUqt9vw5GMdO6sZ3i8CvOexeEOBoY8FTg==
X-Received: by 2002:a05:6512:3ca0:b0:516:c764:b3e7 with SMTP id h32-20020a0565123ca000b00516c764b3e7mr3154052lfv.9.1712946862660;
        Fri, 12 Apr 2024 11:34:22 -0700 (PDT)
Received: from mobilestation ([95.79.241.172])
        by smtp.gmail.com with ESMTPSA id m30-20020a19435e000000b005139b9f1162sm575406lfj.281.2024.04.12.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:34:22 -0700 (PDT)
Date: Fri, 12 Apr 2024 21:34:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 0/6] stmmac: Add Loongson platform support
Message-ID: <dkwz2xigkqnly6twu6akseerb3huxet56jultptjlaoapwgdt2@2va3q7isbhne>
References: <cover.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712917541.git.siyanteng@loongson.cn>

Hi Yanteng

On Fri, Apr 12, 2024 at 07:28:05PM +0800, Yanteng Si wrote:
> v11:
> * Break loongson_phylink_get_caps(), fix bad logic.
> * Remove a unnecessary ";".
> * Remove some unnecessary "{}".
> * add a blank.
> * Move the code of fix _force_1000 to patch 6/6.
> 
> The main changes occur in these two functions:
> loongson_dwmac_probe();
> loongson_dwmac_setup();
> 
> v10:
> As Andrew's comment:
> * Add a #define for the 0x37.
> * Add a #define for Port Select.
> 
> others:
> * Pick Serge's patch, This patch resulted from the process
>   of reviewing our patch set.
> * Based on Serge's patch, modify our loongson_phylink_get_caps().
> * Drop patch 3/6, we need mac_interface.
> * Adjusted the code layout of gnet patch.
> * Corrected several errata in commit message.
> * Move DISABLE_FORCE flag to loongson_gnet_data().
> 
> v9:
> We have not provided a detailed list of equipment for a long time,
> and I apologize for this. During this period, I have collected some
> information and now present it to you, hoping to alleviate the pressure
> of review.
> 
> 1. IP core
> We now have two types of IP cores, one is 0x37, similar to dwmac1000;
> The other is 0x10.  Compared to 0x37, we split several DMA registers
> from one to two, and it is not worth adding a new entry for this.
> According to Serge's comment, we made these devices work by overwriting
> priv->synopsys_id = 0x37 and mac->dma = <LS_dma_ops>.
> 
> 1.1.  Some more detailed information
> The number of DMA channels for 0x37 is 1; The number of DMA channels
> for 0x10 is 8.  Except for channel 0, otherchannels do not support
> sending hardware checksums. Supported AV features are Qav, Qat, and Qas,
> and the rest are consistent with 3.73.
> 
> 2. DEVICE
> We have two types of devices,
> one is GMAC, which only has a MAC chip inside and needs an external PHY
> chip;
> the other is GNET, which integrates both MAC and PHY chips inside.
> 
> 2.1.  Some more detailed information
> GMAC device: LS7A1000, LS2K1000, these devices do not support any pause
> mode.
> gnet device: LS7A2000, LS2K2000, the chip connection between the mac and
>              phy of these devices is not normal and requires two rounds of
>              negotiation; LS7A2000 does not support half-duplex and
> multi-channel;
>              to enable multi-channel on LS2K2000, you need to turn off
> hardware checksum.
> **Note**: Only the LS2K2000's IP core is 0x10, while the IP cores of other
> devices are 0x37.
> 
> 3. TABLE
> 
> device    type    pci_id    ip_core
> ls7a1000  gmac    7a03      0x35/0x37
> ls2k1000  gmac    7a03      0x35/0x37
> ls7a2000  gnet    7a13      0x37
> ls2k2000  gnet    7a13      0x10
> -----------------------------------------------
> Changes:
> 
> * passed the CI
>   <https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch
>   /checkpatch.sh>
> * reverse xmas tree order.
> * Silence build warning.
> * Re-split the patch.
> * Add more detailed commit message.
> * Add more code comment.
> * Reduce modification of generic code.
> * using the GNET-specific prefix.
> * define a new macro for the GNET MAC.
> * Use an easier way to overwrite mac.
> * Removed some useless printk.
> 

Thanks you very much for taking my notes into account and resubmitting
the patchset. I'll get back to reviewing your series within 2-5 days.

-Serge(y)

> 
> v8:
> * The biggest change is according to Serge's comment in the previous
>   edition:
>    Seeing the patch in the current state would overcomplicate the generic
>    code and the only functions you need to update are
>    dwmac_dma_interrupt()
>    dwmac1000_dma_init_channel()
>    you can have these methods re-defined with all the Loongson GNET
>    specifics in the low-level platform driver (dwmac-loongson.c). After
>    that you can just override the mac_device_info.dma pointer with a
>    fixed stmmac_dma_ops descriptor. Here is what should be done for that:
> 
>    1. Keep the Patch 4/9 with my comments fixed. First it will be partly
>    useful for your GNET device. Second in general it's a correct
>    implementation of the normal DW GMAC v3.x multi-channels feature and
>    will be useful for the DW GMACs with that feature enabled.
> 
>    2. Create the Loongson GNET-specific
>    stmmac_dma_ops.dma_interrupt()
>    stmmac_dma_ops.init_chan()
>    methods in the dwmac-loongson.c driver. Don't forget to move all the
>    Loongson-specific macros from dwmac_dma.h to dwmac-loongson.c.
> 
>    3. Create a Loongson GNET-specific platform setup method with the next
>    semantics:
>       + allocate stmmac_dma_ops instance and initialize it with
>         dwmac1000_dma_ops.
>       + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>         the pointers to the methods defined in 2.
>       + allocate mac_device_info instance and initialize the
>         mac_device_info.dma field with a pointer to the new
>         stmmac_dma_ops instance.
>       + call dwmac1000_setup() or initialize mac_device_info in a way
>         it's done in dwmac1000_setup() (the later might be better so you
>         wouldn't need to export the dwmac1000_setup() function).
>       + override stmmac_priv.synopsys_id with a correct value.
> 
>    4. Initialize plat_stmmacenet_data.setup() with the pointer to the
>    method created in 3.
> 
> * Others:
>   Re-split the patch.
>   Passed checkpatch.pl test.
> 
> v7:
> * Refer to andrew's suggestion:
>   - Add DMA_INTR_ENA_NIE_RX and DMA_INTR_ENA_NIE_TX #define's, etc.
> 
> * Others:
>   - Using --subject-prefix="PATCH net-next vN" to indicate that the
>     patches are for the networking tree.
>   - Rebase to the latest networking tree:
>     <git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git>
> 
> 
> v6:
> 
> * Refer to Serge's suggestion:
>   - Add new platform feature flag:
>     include/linux/stmmac.h:
>     +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)
> 
>   - Add the IRQs macros specific to the Loongson Multi-channels GMAC:
>      drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
>      +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000      /* ...*/
>      #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
>      ...
> 
>   - Drop all of redundant changes that don't require the
>     prototypes being converted to accepting the stmmac_priv
>     pointer.
> 
> * Refer to andrew's suggestion:
>   - Drop white space changes.
>   - break patch up into lots of smaller parts.
>      Some small patches have been put into another series as a preparation
>      see <https://lore.kernel.org/loongarch/cover.1702289232.git.siyanteng@loongson.cn/T/#t>
>      
>      *note* : This series of patches relies on the three small patches above.
> * others
>   - Drop irq_flags changes.
>   - Changed patch order.
> 
> 
> v4 -> v5:
> 
> * Remove an ugly and useless patch (fix channel number).
> * Remove the non-standard dma64 driver code, and also remove
>   the HWIF entries, since the associated custom callbacks no
>   longer exist.
> * Refer to Serge's suggestion: Update the dwmac1000_dma.c to
>   support the multi-DMA-channels controller setup.
> 
> See:
> v4: <https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>
> v3: <https://lore.kernel.org/loongarch/cover.1691047285.git.chenfeiyang@loongson.cn/>
> v2: <https://lore.kernel.org/loongarch/cover.1690439335.git.chenfeiyang@loongson.cn/>
> v1: <https://lore.kernel.org/loongarch/cover.1689215889.git.chenfeiyang@loongson.cn/>
> 
> Serge Semin (1):
>   net: stmmac: Move all PHYLINK MAC capabilities initializations to
>     MAC-specific setup methods
> 
> Yanteng Si (5):
>   net: stmmac: Add multi-channel support
>   net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device
>     identification
>   net: stmmac: dwmac-loongson: Introduce GMAC setup
>   net: stmmac: dwmac-loongson: Add full PCI support
>   net: stmmac: dwmac-loongson: Add Loongson GNET support
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 544 ++++++++++++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   6 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c  |   2 +
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  35 +-
>  .../ethernet/stmicro/stmmac/dwmac100_core.c   |   2 +
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   8 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  20 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  32 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  15 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  54 +-
>  include/linux/stmmac.h                        |   2 +
>  17 files changed, 599 insertions(+), 141 deletions(-)
> 
> -- 
> 2.31.4
> 

