Return-Path: <netdev+bounces-112089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A17934E33
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D41F23092
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2E81745;
	Thu, 18 Jul 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeNOlSAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516889457
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309556; cv=none; b=gykN9kF09cAfMCovdiCGUMYkOgkxRB8MfF39kevnXR4uCiHB2EvB+0PQch7HqkDQ3bsoxMU6vL3KFPhM9HMqASN0b7nI+J3ye/Xmck+5huGUrsrFwTommeXB6fB6AdI/eKL63u81hlcqVCju4f42dMrQ4cyTQSbljUFiNE0XqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309556; c=relaxed/simple;
	bh=TlXh6zu51WNDK35DukFYv3tjsZbNqkovFNQhn1wYY+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go7695O10KMYCsjwAMtJqBpMpahScexHGs3ZS8rYKUUCWvg69fVudfddseoOSlo2WEYQSqhs4LdFtcy7Rywuq5znfrIAzM6iEBtXfarhjRw9E0tOber/ZP8ihfE+XkEQ5L6LpUrQYwCc81V5KR4n5QoEPbbCd3VleBfla/j72NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeNOlSAM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-78006198aeeso514167a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721309554; x=1721914354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/F/SyyENrss0icGM7H5RMWboHG6zgq4Ni62GWxWydc=;
        b=jeNOlSAMtRmff2+ntjFvQqqZjaDIgBXFoEFWPsoWkjIICmO+m+A53TqahpSgBmU2Y1
         uT57eJi10vvY6LG0dCpitw38W4dYEGF8TxB/F0rEKWG9Or86JH+UYGNYqd/VJmh+htgH
         jYmlxhQMhkTrPDKTRkRzXqJIT012Gz6MbUMT3JLJcyjLLUW5JJ73DJQ2GEvYXGeoO9dr
         RAxiYDgWelfS4vZqxXy/V/QzmaeHQmh0zGiYRlEJ6M+1UTt4xiw/lFBjrwWmHY/q/hTS
         C0YkB57s4KVCaiZfFFpv1MXMLJQocRCDsjiW8RGJRr5BZzfRXVdb7efRCTqEeLnXDjH3
         8w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309554; x=1721914354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/F/SyyENrss0icGM7H5RMWboHG6zgq4Ni62GWxWydc=;
        b=na7KyvdlKD+Vm3h/2rj21t3pdInj8C2ZeNTGzICS2Djf33zuzieE9DcKfAveHQUuUC
         kb8c4ZJ9DuBXSoCI5CBItiFOENWRWUOBhvz55AvaRcpNGBUkvQKLlubQliK0Wz/2n6K/
         DDVuwTd35Hfbc+DHgw3CU2XLDg6HUTtyKTUytgDprNdx7sqv4yIo6G3MOBgXTTKjoNuR
         etUyunjrPxHcMLrGsOfLN1kRl45/EaS0kpcXOf9p2HsttSa6YcJQCQHal6Mil/McWfRk
         pibshwvx38NwMZ43jTmALTE++5xk9yeHzpf8v7DV6aPZKSimJ9hXhaPuE+O5FVfvJw2X
         BQcA==
X-Forwarded-Encrypted: i=1; AJvYcCU5yPqtsSTJZecpjM1xItZfMQ6z96YQneK3DhrijjkGbA00x5CUWrLlC6cHuvfHMTa4LaZj5PRDXAubWDnzbAeeTVGux4ma
X-Gm-Message-State: AOJu0YxQ5CBdy7+aM/dmjAd7bVVlDRs5KCHFDHHIA4XcLSDWX4w1edPj
	5zSGcrXuLEd/64mw6+Oa8PJm6N51xfK47ooOWN+pLZnmw0H5gdKy
X-Google-Smtp-Source: AGHT+IE0UwTx4ZD02TrRliHgNEXC7eM+gcYslXCJ1tZU1F3A0eSZOF76JzaYQlJVdRzfJP3TV57i8g==
X-Received: by 2002:a05:6a20:918e:b0:1c2:9598:7578 with SMTP id adf61e73a8af0-1c407888b7dmr4568744637.22.1721309554515;
        Thu, 18 Jul 2024 06:32:34 -0700 (PDT)
Received: from mobilestation ([176.15.243.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6749sm9960742b3a.58.2024.07.18.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 06:32:34 -0700 (PDT)
Date: Thu, 18 Jul 2024 16:32:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 00/14] stmmac: Add Loongson platform support
Message-ID: <roq3jfend2i4omuobjzafzaxx5umqntsp3h5kxxuisluozxkc5@iriervsbuq3v>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <xebiag2qjzaxgmtl4o5fn4zaon75gjl4akzxgb56ngxeahm2eu@si4our7feved>
 <84d5db29-5da4-440c-82a4-e223e3afc977@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84d5db29-5da4-440c-82a4-e223e3afc977@loongson.cn>

Hi Yanteng

On Mon, Jul 15, 2024 at 07:35:04PM +0800, Yanteng Si wrote:
> 
> 在 2024/7/11 23:35, Serge Semin 写道:
> > Hi Yanteng
> > 
> > On Tue, Jul 09, 2024 at 05:34:07PM +0800, Yanteng Si wrote:
> > > v14:
> > > 
> > > Because Loongson GMAC can be also found with the 8-channels AV feature
> > > enabled, we'll need to reconsider the patches logic and thus the
> > > commit logs too. As Serge's comments and Russell's comments:
> > > [PATCH net-next v14 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
> > > [PATCH net-next v14 02/15] net: stmmac: Add multi-channel support
> > > [PATCH net-next v14 03/15] net: stmmac: Export dwmac1000_dma_ops
> > > [PATCH net-next v14 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
> > > [PATCH net-next v14 05/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
> > > [PATCH net-next v14 06/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
> > > [PATCH net-next v14 07/15] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
> > > +-> Init the plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
> > >      in the loongson_gmac_data() method.
> > > [PATCH net-next v14 08/15] net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
> > > [PATCH net-next v14 09/15] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
> > > [PATCH net-next v14 10/15] net: stmmac: dwmac-loongson: Introduce PCI device info data
> > > +-> Make sure the setup() method is called after the pci_enable_device()
> > >      invocation.
> > > [PATCH net-next v14 11/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
> > > +-> Introduce the loongson_dwmac_dt_config() method here instead of
> > >      doing that in a separate patch.
> > > +-> Add loongson_dwmac_acpi_config() which would just get the IRQ from
> > >      the pdev->irq field and make sure it is valid.
> > > [PATCH net-next v14 12/15] net: stmmac: Fixed failure to set network speed to 1000.
> > > +-> Drop the patch as Russell's comments, At the same time, he provided another
> > >      better repair suggestion, and I decided to send it separately after the
> > >      patch set was merged. See:
> > >      <https://lore.kernel.org/netdev/ZoW1fNqV3PxEobFx@shell.armlinux.org.uk/>
> > > [PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
> > > +-> This is former "net: stmmac: dwmac-loongson: Add Loongson GNET
> > >      support" patch, but which adds the support of the Loongson GMAC with the
> > >      8-channels AV-feature available.
> > > +-> loongson_dwmac_intx_config() shall be dropped due to the
> > >      loongson_dwmac_acpi_config() method added in the PATCH 11/15.
> > > +-> Make sure loongson_data::loongson_id  is initialized before the
> > >      stmmac_pci_info::setup()  is called.
> > > +-> Move the rx_queues_to_use/tx_queues_to_use and coe_unsupported
> > >      fields initialization to the loongson_gmac_data() method.
> > > +-> As before, call the loongson_dwmac_msi_config() method if the multi-channels
> > >      Loongson MAC has been detected.
> > > +-> Move everything GNET-specific to the next patch.
> > > [PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
> > > +-> Everything Loonsgson GNET-specific is supposed to be added in the
> > >      framework of this patch:
> > >      + PCI_DEVICE_ID_LOONGSON_GNET macro
> > >      + loongson_gnet_fix_speed() method
> > >      + loongson_gnet_data() method
> > >      + loongson_gnet_pci_info data
> > >      + The GNET-specific part of the loongson_dwmac_setup() method.
> > >      + ...
> > > [PATCH net-next v14 15/15] net: stmmac: dwmac-loongson: Add loongson module author
> > > 
> > > Other's:
> > > Pick Serge's Reviewed-by tag.
> > Thanks for submitting an update. I've briefly looked at it and spotted a
> > few places left to improve. I'll send my comments on the next week.
> 
> Okay, thank you for spending a lot of time and effort reviewing our patch.

In case if you are willing to resubmit the series anytime soon, please
note that 6.11 merge window was opened two days ago. So the series
either need to be submitted as RFC v15 or you need to hold on with
posting the patch set for the next two weeks.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

