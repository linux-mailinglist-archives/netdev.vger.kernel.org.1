Return-Path: <netdev+bounces-67091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19902842067
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4046286E23
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4E679FB;
	Tue, 30 Jan 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUg3ihad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5666B3D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608661; cv=none; b=hT4obu1nJSU9YVKc1pCS6CXxHtCwE5TNVItUUxe2F6D/A0UjRNyKYDiLN+KkXsA6hKtxAuNA+h1/m8KPCGtTrtmzF5BQ5H8ytq9tPVp0Tq/hHI9/m6XOg9tMwf9nhA6FQS9SEOQjnmm84jctPg+L8aDlrXQ3D0EbGiNdNmffY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608661; c=relaxed/simple;
	bh=sLl/gyrDiAdofcq1IlKovgeLgeRRqI0CRTBJYD+mu50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZhkx/bUK7k1IJkvbdoR+wOHuzgFXTL44OPbcZjvfmzL28jJIMzlCbeoUyEtgGqWOogadKQvFEWuKHjG7ZAKI5KYTvMaoCQGKTicuugTSxNy5zdehC7lqEcptSM6wWlSDXUMGeKDIaHsjU9dVVaNGxDgtiQYZSSwB1BDZogcSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUg3ihad; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51030ce36fbso3790625e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706608657; x=1707213457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqnBiaDHuU7lNT5d8QXbgTsN5Je9KgG1OSol2ONXjqQ=;
        b=CUg3ihadYJT3GLe4JtEK1rdUOC5Aj0OawtrZoguEj4l2Xjt+Q6xMfBmkIUwtnuyZqs
         dwYRDS/vNNJRgYCAhT2KQjOSrOfR8qkkRKiQ0yagnnM5BVUld1iJGCj8nAO3UjcOOh5h
         +2Z0yDjA321MbD1OUTbIUGbUucH+BDdy6No/1adkJ+YaZ7oRmOYBkhCw8kUBFv0qKRmU
         XxG9L9x/khHkiZqB3fhc/IjG2vJJpDO6W6uM932u2EWahSE6BjKUGS08GrKJ+kYPFgNP
         L+zrEwxcm2du/yauYxn+9GhYS2i40l4bJqn97xpqx2VC2Dhs0qtwzvD5XItvUqtlDUaS
         mCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608657; x=1707213457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqnBiaDHuU7lNT5d8QXbgTsN5Je9KgG1OSol2ONXjqQ=;
        b=Bay3cUlUqOo2j/YTEsnFwMvHjdSV/Y8Fu9oJC5HO4q0W2jGYkyGoVUz0lZXruXmuqI
         Iq/VdSUgc9cFGqvfDLA4+QUne8f3/fsQme5C4GDcce5MYN0AsmXhzWhwmgbJxCHegrrs
         xWznWtGy9VX/rGk5ETNaV87eI+vuUkQwqmc1wlpKLq4xZcrntQPx4QQZhFFMS0+RfLKM
         8FyFEoayENgwcfN+uN3msSq6wedBxjAqYDndjhU2Kd/u+yJAd2I24QjwmRAmXKBokHbC
         s+VifG8n9skK5VZqjbh02eZ5t9IIk75u7kYlpb3fYgDOhAvolQdQVKrEJ/FuecOT26Wr
         v/vQ==
X-Gm-Message-State: AOJu0YzEUQRV9uzbXQX76TXcSrPVlBhkQSXGeTKK8FJ/DlLOwImGhSdx
	XB7Brhs1VgRdExD36y4+u/8l5Pl04gY0DFbpHpchdgHvqawi7RhKl0bwJZMB
X-Google-Smtp-Source: AGHT+IGzdHCkqTanb7f3VbUgypLUuoJGv5YO0JobH7EhcwtB2t5IOwiOY7MIX+H3xCw7N9cgi46jMQ==
X-Received: by 2002:a05:6512:314f:b0:510:1bbc:96bb with SMTP id s15-20020a056512314f00b005101bbc96bbmr4758962lfi.24.1706608657252;
        Tue, 30 Jan 2024 01:57:37 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q4-20020a19a404000000b005111feb468csm36063lfc.33.2024.01.30.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:57:36 -0800 (PST)
Date: Tue, 30 Jan 2024 12:57:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 00/11] stmmac: Add Loongson platform support
Message-ID: <atcbdt4xaawyum5vivzhrtpf4kb4rqf4fmyqu2oi3yzfiyauy2@at2fvl7tim22>
References: <cover.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706601050.git.siyanteng@loongson.cn>

Hi Yanteng

On Tue, Jan 30, 2024 at 04:43:20PM +0800, Yanteng Si wrote:
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

Thanks for the updated series. I'll have a look at it later on this
week or early on the next one.

-Serge(y)

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
> 
> Yanteng Si (11):
>   net: stmmac: Add multi-channel support
>   net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
>   net: stmmac: dwmac-loongson: Add full PCI support
>   net: stmmac: dwmac-loongson: Move irq config to loongson_gmac_config
>   net: stmmac: dwmac-loongson: Add Loongson-specific register
>     definitions
>   net: stmmac: dwmac-loongson: Add GNET support
>   net: stmmac: dwmac-loongson: Add multi-channel supports for loongson
>   net: stmmac: dwmac-loongson: Fix MAC speed for GNET
>   net: stmmac: dwmac-loongson: Fix half duplex
>   net: stmmac: dwmac-loongson: Disable flow control for GMAC
>   net: stmmac: dwmac-loongson: Disable coe for some Loongson GNET
> 
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 561 ++++++++++++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   2 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  36 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  19 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  32 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  15 +-
>  include/linux/stmmac.h                        |   3 +
>  9 files changed, 582 insertions(+), 94 deletions(-)
> 
> -- 
> 2.31.4
> 

