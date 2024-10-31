Return-Path: <netdev+bounces-140828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F72C9B863F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC81C211AB
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CA1D0DF2;
	Thu, 31 Oct 2024 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRbMg9by"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234013D8AC;
	Thu, 31 Oct 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414837; cv=none; b=k1FageP0xEh7BEIABqlbcfRMCoSd2VM4QlKh7nNng1MapsSvR3z5Olcv0Vlj2cryYmFgvBeD19i0/caadEg5WOzBaFf56PbPjui47+SCl8agMalcz2QpAU8k4lN1o/n03SO8Ss8cYdSGSDkDjCq1u/xl/MdcNfQotYK1BQECXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414837; c=relaxed/simple;
	bh=ZP6nBZqbC05NsUiSMvtmgAFARItsZ76FKZK56Ia0yY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjueJDOqqX7asAQ4MPSwY66cDYZCRWmBciaGoXKMeCnGLfOGKeUq3Cg8d3fWgfMJCLc9oUavWAMim5UmnpYirriWgHfU5MsChl+Ak8x3aoTg6L4u4n9UzXSdCV/b3HgOSEZO7Hz54Qwc1uXWTrJsLzKJ9ZHIrxBRoejXUrQdAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRbMg9by; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c805a0753so14014605ad.0;
        Thu, 31 Oct 2024 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730414831; x=1731019631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQCrudqNvXdy7lrxuF49N08JEGcOIqKAEAmppY5ECKA=;
        b=TRbMg9byooxf3vfHg4jBUBsSD4K9IZnR9/5bdSaVcIExWW/axVZdZWvi/86nXDsrfg
         0yHosV2aK3RMr61khEjJiYO60Ff3DbiH3p/gunNP9ode8J2eXRWygtBTcUVSnsfZUqP6
         JXL4dB6SnEQF6gAfNMQ4LKGUv/EAIpIy6x/ljlEwvizgSXev1/6yuEqPm5RXCaZbpExK
         z7AIQphgDjS1RZlcRdSgiBiJUGxijxGM+VkpRhqo3nnhUxu9RxPOPq3qaXGlEX5fOCwK
         ecuRRLcAo+GRduMwLUkW5tvXlH+scDhJdTG7GAV43dTHIn1TJSqrzsmHroC4bLr8nBuw
         WJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414831; x=1731019631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQCrudqNvXdy7lrxuF49N08JEGcOIqKAEAmppY5ECKA=;
        b=RUP2fVykZ9t5fxDQPV0WyRxmqUHGjtWqN+tguwOra/ZoG2xoSiWoggFJ25VDbSm6H2
         u3BbCX2NRznnWTe95Wuun5WXY76axWiDLvpskCw+OvU9+SVHHxzxX+8rQJtHTtxbFNh7
         tr+EqYU97lnMFyuZjVjnzlRsP5dA5LJeR22tpaW+/cqq343N9NorolQ54DZygiKQokp1
         /jiIDigyQnW1tlpRRVzS5tBkg4inKH0DvOZTRiuaHLvB5Oxztv7itxG8Le+eAA1n7eWk
         UcNcobkKBICS8ja9ixUApGRGGpm2I/DqDVOIvQwVOppWnvTSJkC4tnqcmWnGw3Wqo7cy
         DbeA==
X-Forwarded-Encrypted: i=1; AJvYcCUdw9Xy7h/vThf+YUY/BzpvCc7q9UhvErdQKIbA4iGBd376kMPbqkSaoWGAKxXgdTc6EGXnkI9Bhpbk6qBw@vger.kernel.org, AJvYcCWal0MAJyu4XXE/mtmB56yecIPYnKjsN1Z9wyAZlTwK/XwD6TqwXH9hXdDHCk0yie3AJB0SrOxW@vger.kernel.org, AJvYcCWeQIIFMrtOTKwqCqilotNSu1O3HsRwtdBiHoQGcv8BXRXIHRH9sYv3mvMmekbeANMEBl9NvBIgWvwp@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbHN/iJ7AbnxjFEYICxIImaGene9qryr7d4kZ0LLzGbfnpGPz
	I6m6aWYwKCr9aj+on1CmGvPcIoRuhMe2Zo3rrIG4xCkK7ZnF/UVA
X-Google-Smtp-Source: AGHT+IHG/sKyN58dDIoIT5G3OVlXe0NhTIIngTp1CVkh2jnU+eHCNSuLvxChS6xstMqP1z4RZCpBEw==
X-Received: by 2002:a17:902:e5c2:b0:20b:6188:fc5e with SMTP id d9443c01a7336-210c6ae9baemr269872565ad.28.1730414830985;
        Thu, 31 Oct 2024 15:47:10 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daacb29sm1700296a91.14.2024.10.31.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:47:10 -0700 (PDT)
Date: Fri, 1 Nov 2024 06:46:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Richard Cochran <richardcochran@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Liu Gui <kenneth.liu@sophgo.com>, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: Add ethernet configuration for cv18xx
Message-ID: <nkydxanwucqmbzzz2fb24xyelrouj6gvhuuou2ssbf4tvvhfea@6uiuueim7m3a>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
 <ftfp2rwkytqmzruogcx66d5qkn4tzrgyjtlz4hdduxhwit3tok@kczgzrjdxx46>
 <e389a60d-2fe3-46fd-946c-01dd3a0a0f6f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e389a60d-2fe3-46fd-946c-01dd3a0a0f6f@lunn.ch>

On Thu, Oct 31, 2024 at 02:04:31PM +0100, Andrew Lunn wrote:
> > > > > +		gmac0: ethernet@4070000 {
> > > > > +			compatible = "snps,dwmac-3.70a";
> > > > > +			reg = <0x04070000 0x10000>;
> > > > > +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> > > > > +			clock-names = "stmmaceth", "ptp_ref";
> > > > > +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +			interrupt-names = "macirq";
> > > > > +			phy-handle = <&phy0>;
> > > > > +			phy-mode = "rmii";
> > > > > +			rx-fifo-depth = <8192>;
> > > > > +			tx-fifo-depth = <8192>;
> > > > > +			snps,multicast-filter-bins = <0>;
> > > > > +			snps,perfect-filter-entries = <1>;
> > > > > +			snps,aal;
> > > > > +			snps,txpbl = <8>;
> > > > > +			snps,rxpbl = <8>;
> > > > > +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > > > > +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > > > > +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > > > > +			status = "disabled";
> > > > > +
> > > > > +			mdio {
> > > > > +				compatible = "snps,dwmac-mdio";
> > > > > +				#address-cells = <1>;
> > > > > +				#size-cells = <0>;
> > > > > +
> > > > > +				phy0: phy@0 {
> > > > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > > > +					reg = <0>;
> > > > > +				};
> > > > > +			};
> > > > 
> > > > It is not clear to me what cv18xx.dtsi represents, 
> > > 
> > > This is a include file to define common ip for the whole
> > > cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> > > 
> > > > and where the PHY node should be, here, or in a .dts file. 
> > > > Is this a SOM, and the PHY is on the SOM? 
> > > 
> > > The phy is on the SoC, it is embedded, and no external phy
> > > is supported. So I think the phy node should stay here, not 
> > > in the dts file.
> > 
> > There is a mistake, Some package supports external rmii/mii
> > phy. So I will move this phy definition to board specific.
> 
> When there is an external PHY, does the internal PHY still exists? If
> it does, it should be listed, even if it is not used.
> 
> Do the internal and external PHY share the same MDIO bus? 

They share the same MDIO bus and phy id setting. When an external phy
is select, the internal one is not initialized and can not be accessed
by the SoC.

> I've seen some SoCs with complex MDIO muxes for internal vs external
> PHYs.
> 
> 	Andrew

There is a switch register on the SoC to decide which phy/mode is used. 
By defaut is internal one with rmii mode. I think a driver is needed to
handle this properly.

Regards,
Inochi

