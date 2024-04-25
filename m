Return-Path: <netdev+bounces-91324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9408B226D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22791C20F49
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08730139D16;
	Thu, 25 Apr 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVJVl4pk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BE84FC9
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051195; cv=none; b=ifIPHb5MiHqTXz2G0S+qLaPR46ypswUlOw95+S9qYQ6nnrdpAsZtBYcqwJlh0ZRr8toELFsZifnE6d3v6qVvoz0bIINygA7ol/LzQMPQ5k5Mhi7CfHf9t8I4e+ndPbs8A5+Y8/lRAvHo79iN7yvvPe3nAXS2YQGBIHOk7fMKVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051195; c=relaxed/simple;
	bh=BuVnhYzbx4VT8qZFJPpb1lNu8TaGm9ovVP3FKBSVmuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+ibqQxGEczWL+LjSZncrQA+cciecZwl3sZs/irHrNxH85qLrzNmezrZ36DUAkw4V2x9U8ckfEFv+uVvFhcX8vpoDEReneWmxfgo5TmRt7nfqWuCYFQ1H1zuihHnmzsXlG7exQ7piQyj58qMyS7Fl0eXBmrNBts3yEsqO621IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVJVl4pk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso1083263e87.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051192; x=1714655992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yemf4LlyCQUTnmFym4j26o9S2FNITso4okkweSUMjOw=;
        b=eVJVl4pk6p9ic2Fbx2BygydIaWXlQcXQF5Grt0KrdQKciBO8coIPIM2JrGjpO/cJei
         Eet9MRmpZn0/vKJ5KXKciJQF9ju3ZLjYzM6YHetmNC2eUMiJbJWmoJfrVRGdC3ngs8f+
         L2ieBHZcWKTDXuxTpZc1ieyJQmzHyAN4jEFkYSIdE0oZqJopBXZ2UBzQzVacZiJaAQAK
         OpsM1s+Gj0AxpYRSIoQ9a56xSdyEKmrgpL6GIbDsh8CE21eISvF0IC5bahchxtokoNbu
         F4xKw0a8ME3iEvhDEuuFdg/gLQ99daXLx+avwIhot4VQLniTKktZp0u6NhK6QVGSC5x9
         WiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051192; x=1714655992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yemf4LlyCQUTnmFym4j26o9S2FNITso4okkweSUMjOw=;
        b=VDbUsj6DwmUceABZuX6XZ9rGxMm/DOJJQX22j21nIN/+O05H99pUxTf8luxotj5t7L
         z4fJASBWXPcS0hyJUL4H7YE2wT4CRIBsnGPgrdLQ/iuWDKlXjfVg7wXnMVwxavy3adbJ
         Nl6E03xvOTAEoHO6k02ZI1+F5wBY+H6ux4C8ABFeuff4mq1pN3YJt4RFLISTn0ADqTLn
         BEylqTmjit9+CGRIEoNbH3bHXUptz9Uuu+MPE45fz3eyd+qKDIzkGQzRehVDnAG3JrW3
         NFo2aboyPM8vH0qwmFIdlRTvsTMvApkDLBggfEIXr7K6OuyHZ6dQt49mv1jQ221satlc
         8+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXlYJsV+TRCftnToO9WC6qYMWvxv77xPS/QzV/DOVvyEefSMRV0Z8mZa+fJtVMPj6V0dIkKqfdSkL+silgj1tNwrgJeSqy3
X-Gm-Message-State: AOJu0YySMFOK6b3Iziav7vCiZO1+0+l/K+7KLmGX/NqqV87oXOdxijbC
	+YFiTXzQhmwcbVbssPyKQKlgYGxKA77AcvpBEwub+vsKByp+JEEvDNzC8HTs
X-Google-Smtp-Source: AGHT+IEigN4JyH5Gf6f2dzRGwdVs/W7BePvUw0IbOWDlBPPe8Er9Nszo6IApT0+jL4pItL8QZGsGcA==
X-Received: by 2002:ac2:596f:0:b0:51b:92ea:9f3 with SMTP id h15-20020ac2596f000000b0051b92ea09f3mr3511404lfp.7.1714051191678;
        Thu, 25 Apr 2024 06:19:51 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0051ab5649482sm2473515lfu.97.2024.04.25.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:19:51 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:19:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 00/15] stmmac: Add Loongson platform support
Message-ID: <go6zgo5mxqscourw567e756tngt3xpbrnuqsid4av2luu4zkfm@h6xjnlosexwi>
References: <cover.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714046812.git.siyanteng@loongson.cn>

Yanteng,

On Thu, Apr 25, 2024 at 09:01:53PM +0800, Yanteng Si wrote:
> v12:
> * The biggest change is the re-splitting of patches.
> * Add a "gmac_version" in loongson_data, then we only
>   read it once in the _probe().
> * Drop Serge's patch.
> * Rebase to the latest code state.
> * Fixed the gnet commit message.

V11 review hasn't finished yet. You posted a question to me just four
hours ago, waited for an answer a tiny bit and decided to submit v12.
Really, what the rush for? Do you expect the reviewer to react in an
instant?

Please understand, the review process isn't a quick-road process. The
most of the maintainers and reviewers have their own jobs and can't
react just at the moment you want it or need it. It's better to
collect all the review comments, wait for all questions being answered
(ping the person you need if you waited long enough) and resubmit the
series with all the notes taken into account. Needlessly rushing and
spamming out the maintainers inboxes with your series containing just
a part of the requested changes, won't help you much but will likely
irritate the reviewers.

What do you expect me to do now? Move on with v11 review? Copy my
questions to v12 and continue the discussion here? By not waiting for
all the discussions done you made the my life harder. What was the
point? Sigh...

-Serge(y)

> 
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
> Yanteng Si (15):
>   net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
>   net: stmmac: Add multi-channel support
>   net: stmmac: Export dwmac1000_dma_ops
>   net: stmmac: dwmac-loongson: Drop useless platform data
>   net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device
>     identification
>   net: stmmac: dwmac-loongson: Split up the platform data initialization
>   net: stmmac: dwmac-loongson: Add ref and ptp clocks for Loongson
>   net: stmmac: dwmac-loongson: Add phy mask for Loongson GMAC
>   net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
>   net: stmmac: dwmac-loongson: Add full PCI support
>   net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
>   net: stmmac: dwmac-loongson: Fixed failure to set network speed to
>     1000.
>   net: stmmac: dwmac-loongson: Add Loongson GNET support
>   net: stmmac: dwmac-loongson: Move disable_force flag to _gnet_date
>   net: stmmac: dwmac-loongson: Add loongson module author
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 519 ++++++++++++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   4 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  35 +-
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  20 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  30 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  11 +-
>  include/linux/stmmac.h                        |   2 +
>  13 files changed, 536 insertions(+), 103 deletions(-)
> 
> -- 
> 2.31.4
> 

