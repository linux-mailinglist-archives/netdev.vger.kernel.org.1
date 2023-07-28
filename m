Return-Path: <netdev+bounces-22204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56097766792
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D5028243F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CEF101FD;
	Fri, 28 Jul 2023 08:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFEC147
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:46:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F9422A
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gRJiEADq0g4SPm+PLrkquEB3e0XLdKa7jTYbfWUHAfU=; b=YQ
	EZ6C93h2dyKAjh1k/m8vd/Ho4Mmvso6UyzzgQZFpC75idNP5li9ZbkAbNFrFkFYUV2sDk189FRZSB
	J54riX+c78cmt2gFMn0WuI471nj+rz880JgKrrq8cMqnumazJqlFdJ5Cb0BdVpBxsGrTq8WnffOjj
	WWUUbfVoS7wfvEY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPJ6y-002WEI-Tc; Fri, 28 Jul 2023 10:46:12 +0200
Date: Fri, 28 Jul 2023 10:46:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 07/10] net: stmmac: dwmac-loongson: Add LS7A support
Message-ID: <a353bda9-2931-4c26-a853-21b6b340e1c3@lunn.ch>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <dd88ed0f53e9ee0f653ddeb78b326f8eb44bdbd1.1690439335.git.chenfeiyang@loongson.cn>
 <1bbba61c-19b7-48bb-8c93-0741b43abda5@lunn.ch>
 <CACWXhK=rVTf=BYo2G2CDDo6AFOwqJJM_v+H6G=0YNohqh8OycA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhK=rVTf=BYo2G2CDDo6AFOwqJJM_v+H6G=0YNohqh8OycA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 09:59:53AM +0800, Feiyang Chen wrote:
> On Thu, Jul 27, 2023 at 5:18 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +static void common_default_data(struct pci_dev *pdev,
> > > +                             struct plat_stmmacenet_data *plat)
> > >  {
> > > +     plat->bus_id = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> > > +
> > >       plat->clk_csr = 2;      /* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> > >       plat->has_gmac = 1;
> > >       plat->force_sf_dma_mode = 1;
> > >
> > >       /* Set default value for multicast hash bins */
> > > -     plat->multicast_filter_bins = HASH_TABLE_SIZE;
> > > +     plat->multicast_filter_bins = 256;
> >
> > HASH_TABLE_SIZE is 64. You appear to be changing it to 256 for
> > everybody, not just your platform. I would expect something like
> > common_default_data() is called first, and then you change values in a
> > loongson specific function.
> >
> 
> Hi, Andrew,
> 
> The common_default_data() here is defined in our platform driver. We
> have tested on our platforms (LS7A and LS2K) and it can be safely
> changed to 256.

Then add a new #define.

     Andrew

