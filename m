Return-Path: <netdev+bounces-17400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D029B751726
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6582811DA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A802246BC;
	Thu, 13 Jul 2023 04:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4F46B0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:07:34 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751111FFD
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hrCfErwkscRSyk4ywcvbivogrzbjMtp7Ba26Fc0mfp0=; b=V0xV5d5fh38TLktJQxIhBd1lQU
	LgbBdgmPtdoy6Q2ZPgjz1vMHv2z0P+AcxJleiTG4nWERnd70/AK/glh4wPl6UlYiO+dwQZJAe4tg6
	Gj4hW2BR75k9/do8UfH3fy+gYGNCBTKCPMmmixpnNeGLJZxlIWas79AHGPDIex2MD/rc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJnbw-001CVn-ND; Thu, 13 Jul 2023 06:07:24 +0200
Date: Thu, 13 Jul 2023 06:07:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
Message-ID: <e491227b-81a1-4363-b810-501511939f1b@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:49:38AM +0800, Feiyang Chen wrote:
> Add GNET support. Use the fix_mac_speed() callback to workaround
> issues with the Loongson PHY.

What are the issues?

> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed)
> +{
> +	struct net_device *ndev = (struct net_device *)(*(unsigned long *)priv);
> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> +
> +	if (speed == SPEED_1000)
> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> +			phy_restart_aneg(ndev->phydev);

This needs a comment at least, but if you explain what is actually
FUBAR in this PHY, we might be able to tell you a better way to work
around its problems.

> +static int loongson_gnet_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	common_default_data(pdev, plat);
> +
> +	plat->mdio_bus_data->phy_mask = 0xfffffffb;
> +
> +	plat->phy_addr = 2;
> +	plat->phy_interface = PHY_INTERFACE_MODE_GMII;

You would normally get this from DT. Is the PHY integrated? Is it
really using GMII, or would PHY_INTERFACE_MODE_INTERNAL be better?

       Andrew

