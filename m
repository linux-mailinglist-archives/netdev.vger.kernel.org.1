Return-Path: <netdev+bounces-100957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E78FCA78
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61436B236C0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609CF49622;
	Wed,  5 Jun 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAvOmU3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA7140380
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587024; cv=none; b=cV3Xh8ki84stc/CrgpmWFzgPLhiQpDnaqhn/BXTeyqW3aJJbs1AdKsoehVHRsBpxK0X+eLmYIz9eONiHmLLJUpkmSgCEhaP4yINZphIcmNjAVbo9ICVafSf6KE3xva1hzjxGuBn2bKp5NfP33gPhMIAYGL/JBGLRLqw34EknXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587024; c=relaxed/simple;
	bh=R2q4IaBdDWp4w9Q4IjOMmrI00g8EQFY2Hx/kRYxoGwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK1Pkj5SQCjSR+VP147RDaJGh38/sUpYxLFrt9KHwYtvd6yOMWR4QjFb1srwKJn8uR5Zv4mHminurKoJ2FFpQiusxQk6GHWSCJu/hOOYKok2pCJmWYF7/oHN55vMDN1/aLLDDSYq2qXax4UWOmIvqKP6A9JczGjMwQaPig9j1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAvOmU3M; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b979so66453851fa.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717587020; x=1718191820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31Y2bZiBbVpuVEFnBx35y1ZZB289cMm9PMbF+/66GVE=;
        b=fAvOmU3M6WKs00AUoHAI9i+E24lydwNyBMZhQC0shJpTXCg/3ty4cho7LPzJYfBrgv
         hu74I6QpR7/a5+8MD+DiPodbPv62Mx3Sczz+C2JZbaBoDWv2Zxxu3qiINVQsvyPsp2nD
         +thHDePIFXAowWv7ba1ds1oL+sLrbCR33c5MMBxhK5ZYbFWw3ak4zqboeQE2I+mql2Rv
         4gki61KGGqm2aG/0LjbP+cxqCRFsNEYGUn2HFhM44N6jLR85kJIsyBM527VQSbrAKgap
         WuvmrW7Y3affJaUtnpGw2St44LQALImtv/LtPklhAb8UYUj/Ws2xAMjCWEkwJPSzmfnd
         HP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587020; x=1718191820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31Y2bZiBbVpuVEFnBx35y1ZZB289cMm9PMbF+/66GVE=;
        b=edZWyOuPelJjOXfu6WYuLtNPhc4X/pGjhzKcRL55zyzN+10botIfKfpbSvY8geDLXl
         I774E1sBF5TZ37u4V9wIOv0febafg9k+tAVh70x5kF8B0vW/eJxbV23qmUv/9B1kKqfa
         ju/KRtwH5BbizCtOzYImdc876tIi1FBZOZ93IIDmlRMcXJ3n6hLfW0qYGCNCeUhpxzqd
         M/H4QSoLspBGlwj/rzg3HX0Vp4UpH7ZtZf001mQCVQDDwYaLHtbNZ9HBaT+vFZh058uW
         RQfiFFlUVw5OaIx+r/2rM8qBV5P504ywbfbarteqGVJ+uH34sxvsXZ7QOPRdTRoQQ38W
         BRIg==
X-Forwarded-Encrypted: i=1; AJvYcCX33u3x3Pn321jIwuCr0L1ToBmYNgY8vvFg5kcApAA82gX0J5CceM65eXo5wyr8bfScTHR06WuJmsWiv4qANtAgfIEXyGt+
X-Gm-Message-State: AOJu0YxIMo8+IJn26V3/qoEccfijJa6mrHpRTRYio8Og0rV8jcnX38fO
	c3R6Hsj/zKqYG15XEAKoA+Pn2QAVoBDE7imQ1kYmxxoSwc4pCK+r
X-Google-Smtp-Source: AGHT+IE+wR8D0Go/cFLgR/AKY9VfVBkVG/89y+NpYQfhxjrTUit3ONgmMkesYgOzUACUhMtOqquRbg==
X-Received: by 2002:a05:6512:39c4:b0:52b:797f:b21f with SMTP id 2adb3069b0e04-52bab4f4499mr1609330e87.51.1717587019994;
        Wed, 05 Jun 2024 04:30:19 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3f259sm1776641e87.81.2024.06.05.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:30:19 -0700 (PDT)
Date: Wed, 5 Jun 2024 14:30:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 00/15] stmmac: Add Loongson platform support
Message-ID: <l3zwis67sv4yzmpsryl5oyzxhpvbj4mkpmcntjez2ofhnvmyw2@fqy7mc6fcvvy>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>

Hi Yanteng

On Wed, May 29, 2024 at 06:17:22PM +0800, Yanteng Si wrote:
> v13:
> 
> * Sorry, we have clarified some things in the past 10 days. I did not
>  give you a clear reply to the following questions in v12, so I need
>  to reply again:
> 
>  1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
>     channels, so we have to reconsider the initialization of
>     tx/rx_queues_to_use into probe();
> 
>  2. In v12, we disagreed on the loongson_dwmac_msi_config method, but I changed
>     it based on Serge's comments(If I understand correctly):
> 	if (dev_of_node(&pdev->dev)) {
> 		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> 	}
> 
> 	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
> 		ret = loongson_dwmac_msi_config(pdev, plat, &res);
> 	} else {
> 		ret = loongson_dwmac_intx_config(pdev, plat, &res);
> 	}
> 
>  3. Our priv->dma_cap.pcs is false, so let's use PHY_INTERFACE_MODE_NA;
> 
>  4. Our GMAC does not support Delay, so let's use PHY_INTERFACE_MODE_RGMII_ID,
>     the current dts is wrong, a fix patch will be sent to the LoongArch list
>     later.
> 
> Others:
> * Re-split a part of the patch (it seems we do this with every version);
> * Copied Serge's comments into the commit message of patch;
> * Fixed the stmmac_dma_operation_mode() method;
> * Changed some code comments.

Thanks for the new version of the series submitted. I've received the
copy and all the currently posted comments. Alas I'll be busy on this
week to join the discussions and start reviewing the bits. I'll be
able to do that early next week. Sorry for making you and the rest of
reviewers wait.

-Serge(y)

> 
> v12:
> * The biggest change is the re-splitting of patches.
> * Add a "gmac_version" in loongson_data, then we only
>   read it once in the _probe().
> * Drop Serge's patch.
> * Rebase to the latest code state.
> * Fixed the gnet commit message.
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
>   net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size
>     init
>   net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device
>     identification
>   net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
>   net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
>   net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
>   net: stmmac: dwmac-loongson: Introduce PCI device info data
>   net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
>   net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config
>   net: stmmac: Fixed failure to set network speed to 1000.
>   net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi temporarily
>   net: stmmac: dwmac-loongson: Add Loongson GNET support
>   net: stmmac: dwmac-loongson: Add loongson module author
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 534 ++++++++++++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   4 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  35 +-
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  20 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  30 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  19 +-
>  include/linux/stmmac.h                        |   2 +
>  13 files changed, 552 insertions(+), 110 deletions(-)
> 
> -- 
> 2.31.4
> 

