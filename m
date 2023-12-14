Return-Path: <netdev+bounces-57524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328F81346C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38F72820FA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F25C8F5;
	Thu, 14 Dec 2023 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMgpQ8mc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE9199
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:15:35 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1efabc436e4so5787969fac.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702566935; x=1703171735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wb1/c99fDx2vxrOG/BjC5kU3A8NpbcUe6YaEnqoVq+s=;
        b=DMgpQ8mcnZ5qsHjxyevwPDp6E6KSgkIahmJq/AhxramV6ZU3V4b8o/cuzH2iCAsF7F
         mYER8s5vOnxDn4To3qV0RAcl0523P/OJayq4DrUCY+OZI8ZvfmAAdOC8UIRjeuUutiHF
         GtJl0uFtUxEWSt2Rv0rikcn503QoRw2OcW6NT+uIuigj7oQVoUbGSe3mNgCt+RkUz+/K
         WOiq4sh56uz/7dAB3xYh5Dqihpo/graE3J9DdXQ92cxAPe5uFv41qYe7WzgD02hYMnqy
         TbYsWkpUPfr5V/EsvMF4cKTY3AJyRLpGC1MReT0NsZccxOcm993eJSwA8WOgyQ3eggIk
         V/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566935; x=1703171735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb1/c99fDx2vxrOG/BjC5kU3A8NpbcUe6YaEnqoVq+s=;
        b=PHlYv7zWdGrDRD15Wi1O01k5mATmIDuL6PvIQtBpgJ8LWjBRw+MWXb8cYpjMrT0vAs
         W/l8uFS5se2rwErGqNkTny8fo0Bnt+WBdunmibwT0Hhtw7I7+Ef1g4AZFr8xvplKF7pC
         jaL3P9ue590aMgOVCiUHDv8omI+o23UefQSc/WHXKdNCXajfXYf6lT4woxFI6Oklicxk
         5AkMqXjeEOaElTiSzjHCxCiy/CVAB94wo2w2bwVmyEQbf6rnAA23IwMhesar6FcBDP6H
         pFq0OSostk3Ydc/+6lpBYSbe9rRMFUbBiubzk7eVqqC8WAU/LtPqYAebKXlCLt0CGrvE
         CGxw==
X-Gm-Message-State: AOJu0YwtJNA+ew9QO5xgsVcNxLFl2hhVHZEhLhMR4tu4sd9XXXUH+Crz
	AhrV22n06JLjKSkpYO82oetrvIHVv7S7MQ==
X-Google-Smtp-Source: AGHT+IEPfMadRV3cTITiKW5mlEGOHNGhNvsrfOl026TFEUVp+domMSgFVqmzh2kXUESW9AXEtzPilA==
X-Received: by 2002:a05:6870:a693:b0:203:506a:326e with SMTP id i19-20020a056870a69300b00203506a326emr715873oam.79.1702566934908;
        Thu, 14 Dec 2023 07:15:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d24-20020a67fb18000000b004665bd1453asm160375vsr.30.2023.12.14.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:15:34 -0800 (PST)
Date: Thu, 14 Dec 2023 18:15:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v6 0/9] stmmac: Add Loongson platform support
Message-ID: <pwdr6mampxe33jpqdf6o5xczgd4qkdttqj4tvionxl7qbry2ek@hpadl7wi4zni>
References: <cover.1702458672.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702458672.git.siyanteng@loongson.cn>

Hi Yanteng

On Wed, Dec 13, 2023 at 06:12:22PM +0800, Yanteng Si wrote:
> v6:
> 
> * Refer to Serge's suggestion:
>   - Add new platform feature flag:
>     include/linux/stmmac.h:
>     +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)
> 
>   - Add the IRQs macros specific to the Loongson Multi-channels GMAC:
>      drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
>      +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000	/* Normal Loongson Tx/Rx Summary */
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

Thanks for submitting the updated series. I'll have a closer look at
it on the next week.

-Serge(y)

> 
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
> Yanteng Si (9):
>   net: stmmac: Pass stmmac_priv and chan in some callbacks
>   net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
>   net: stmmac: dwmac-loongson: Add full PCI support
>   net: stmmac: Add multi-channel supports
>   net: stmmac: Add Loongson-specific register definitions
>   net: stmmac: dwmac-loongson: Add MSI support
>   net: stmmac: dwmac-loongson: Add GNET support
>   net: stmmac: dwmac-loongson: Disable flow control for GMAC
>   net: stmmac: Disable coe for some Loongson GNET
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 296 ++++++++++++++----
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   2 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  61 +++-
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  47 ++-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  65 ++--
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  11 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  13 +-
>  include/linux/stmmac.h                        |   4 +
>  14 files changed, 413 insertions(+), 107 deletions(-)
> 
> -- 
> 2.31.4
> 

