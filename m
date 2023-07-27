Return-Path: <netdev+bounces-21857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B9765155
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F14281268
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB4DDD3;
	Thu, 27 Jul 2023 10:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5631FDD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:35:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705A2684
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bl78Tq6a6qufkM1Ok03PUmnHbqshN4ZqLWgn47tc/Pk=; b=o08IEbS97okEP/CacoZindUoSu
	n2npWoYj8Ax90FK1i+sKenFYAYJFmpU9CkEndHjJacFGToK9WIomorUSurxEwzV7dHjvSkc4BZcbT
	KJSwsu//gGQuvziYJbEWc+2k11TGp8c9MIIV8h/HgO1pKSeGV3S9ZHMnfFF8i1eenImc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOyLL-002RRz-JH; Thu, 27 Jul 2023 12:35:39 +0200
Date: Thu, 27 Jul 2023 12:35:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 07/10] net: stmmac: dwmac-loongson: Add LS7A support
Message-ID: <9add374b-27ba-47c9-95cf-eec896231d58@lunn.ch>
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

> +static int loongson_dwmac_probe(struct pci_dev *pdev,
> +				const struct pci_device_id *id)
>  {
> +	int ret, i, bus_id, phy_mode;
>  	struct plat_stmmacenet_data *plat;
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;
> -
> -	np = dev_of_node(&pdev->dev);
> -
> -	if (!np) {
> -		pr_info("dwmac_loongson_pci: No OF node\n");
> -		return -ENODEV;
> -	}
> -
> -	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
> -		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
> -		return -ENODEV;
> -	}

There are a lot of changes here, and it is not easy to review.  I
would suggest you first do a refactoring patch, moving all handling of
DT into a helper. Since it is just moving code around, it should be
easy to review. Then you can add support for platforms which don't
support DT.

	Andrew

