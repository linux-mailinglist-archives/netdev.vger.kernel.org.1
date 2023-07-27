Return-Path: <netdev+bounces-21839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C51F764F3B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0805B282225
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262D100BD;
	Thu, 27 Jul 2023 09:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14119FC16
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:18:56 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185459E3
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dSNsN/LTsKX10D6cdFw1cxgWEKBK7bNscrS4QLCJv6k=; b=ocf8x/lDQIZWAM7kjMqz6Y86QO
	I35OhdbMgzkJAO/lETUiyDRD97U/R8K8UFC5qj3YFwVf8QtX/48mGFVdFY5vIDaqQEWSb7l/y+zfZ
	5ZoraRkmMC+dqphEPxkwpZsl2Z00IXzsw1ie4amMVpbK5W9jH1PUaZJG97dXsVzQ8ch0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOx8w-002RE9-LP; Thu, 27 Jul 2023 11:18:46 +0200
Date: Thu, 27 Jul 2023 11:18:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 07/10] net: stmmac: dwmac-loongson: Add LS7A support
Message-ID: <1bbba61c-19b7-48bb-8c93-0741b43abda5@lunn.ch>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <dd88ed0f53e9ee0f653ddeb78b326f8eb44bdbd1.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd88ed0f53e9ee0f653ddeb78b326f8eb44bdbd1.1690439335.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static void common_default_data(struct pci_dev *pdev,
> +				struct plat_stmmacenet_data *plat)
>  {
> +	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
>  
>  	/* Set default value for multicast hash bins */
> -	plat->multicast_filter_bins = HASH_TABLE_SIZE;
> +	plat->multicast_filter_bins = 256;

HASH_TABLE_SIZE is 64. You appear to be changing it to 256 for
everybody, not just your platform. I would expect something like
common_default_data() is called first, and then you change values in a
loongson specific function.

	 Andrew

