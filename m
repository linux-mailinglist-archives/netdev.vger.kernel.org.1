Return-Path: <netdev+bounces-139780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B799B4115
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F31F2203B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570271FB3C7;
	Tue, 29 Oct 2024 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqs2BZA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CF16F84F;
	Tue, 29 Oct 2024 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173022; cv=none; b=SqZaPytiEca/6MkJVIBnm+Hy5RAg5cmvUDx+DYkoY+xUx4W2iwSvnV/Kb3sLq7aPV0i9mysuuqFZgqx6z/WORgvOzP8hjshiLtRwOhTsg3rQPD7v0JJY3mu1BF7/jtQXW1EOACb0/KAWORE/tqrns9DNemf7ugVKgQKwt/bV++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173022; c=relaxed/simple;
	bh=lk5mQvoRMsekzwIeHFwdn2nNjtGqy/Sx/EwYE48gTgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htJZ6uGFwywi4vnBW5HZnjf2xJQU1t0zpurR02qoiWkTGiQae8jFvk9Psiuaw6aM3ZPSqrRy1xnUXfNQfrV7BUrbbOwlz/F5a3PLIL2RfnaaHygm1iVM43S9XH2jwljEfEtk36YA+10+Zm/0vVHlEF18ZvhcvyRZWatv9nlgyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqs2BZA5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c714cd9c8so50351435ad.0;
        Mon, 28 Oct 2024 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730173019; x=1730777819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgIs46VKTRXxZFzsmboe1Vla7wwZ28w6yjRfWTTcG7E=;
        b=Yqs2BZA5vWYNL474KE7XwI8iMWLuz5wMCeI3dacTA8HkOP2Rp2NGTtiLOSsIv93Jc0
         ovcqERqeHIPg/8Z9m9RQj8opfqgdxtw8TUUyjnSYoDeMvvEXehNvf3TS28FFIKWy7nft
         dcNo1BiymZ8s7sT3nx3xxYAOgh4qo08UK2nSe0f7ezfOY9+fw6QczEfcJF5HHjyXdgx4
         HBs81a8q/2FNpEkwyjGsJmNKJSLrekO9mm/+91BfI0p18gg33bf957xaQfPe1XHzyC5C
         YuItW/uMJ0sFL+Mma7uMcomj3sozwKZwPygO8cF9vmy007Oyprpu9OpzqGbAXFv7HCcq
         JzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730173019; x=1730777819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgIs46VKTRXxZFzsmboe1Vla7wwZ28w6yjRfWTTcG7E=;
        b=SzqxDChhtMZTRtwz1W9vnOJlMyq2vH3BMf0XFcQD7s95zQMnPe8b/hxnkT5rB6Lgmj
         Wq5ltdLuRhGsYNYSzUf2KP7SZNl4orqPz4fVbbY6WZMlXdFF8W/ZLJx2P66viyMOWd4t
         agB9O0hdXXQKCawPiEsOdZyJ74L87buAdIEJqjFPVT9Dn8g/c3BJyJE1ascCunmQ3k0V
         1D6Ww+fU2t2/dTkwH3+F/Uofn5fbkFiF8WsUWZWKwFdLdIjORlgxfrOR52aPtk6Si09P
         l/AjLqNnOFZeWdbtLb9beNXb4MjmOMcCrFm18akEfq/yeVMXXi2eEAyGW5g1Q5LqBKSk
         Xiew==
X-Forwarded-Encrypted: i=1; AJvYcCUqMYmBVApy0/3xockVx8Ib32+C+gfcSsCIpbmicCd2F2rKPJJ3Mg8qK9NsimxHrPXaAwLgN0MEZCso@vger.kernel.org, AJvYcCV17bTlKZ+LnDIh6tv1b2QgiCuJOUVGiPtrqekc/2VL0gmTzf5i9FIp6y1VQd5O++pCOFIEPmDY@vger.kernel.org, AJvYcCXErrNB9ep9QbCzHz20ndiRk7FM0n++0BdiZvG7iF3zYJVFbETMLpuTN0MWOwoUzTHzf5bM3IPh14qR7iJl@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVzQhGlG0FF6vM1hlhJSbBkXTLDtWJdLOnO7F3rpseiVI9Lej
	ZOKgCKex4kCHKvteUC1Jn/BcloIw2TpM6LbDvoyuX0bV70qmSon6
X-Google-Smtp-Source: AGHT+IH7E5KOZwH2Aycp5b0wrZCV4lKGbdlSkydNAi8Hwl/gm3YX6Bjuz/Jj61OCVDFj7QWo+41dnQ==
X-Received: by 2002:a17:902:dace:b0:20b:a41f:6e48 with SMTP id d9443c01a7336-210c69ed062mr145051695ad.27.1730173019540;
        Mon, 28 Oct 2024 20:36:59 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013405sm57944485ad.135.2024.10.28.20.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 20:36:58 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:36:32 +0800
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
Message-ID: <4uzr7ubzy6x474a36gevlzw5s54yemrfnoimjk3dlrfwizljzr@syo5hpafkeju>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
 <ab0ed945-07ff-4aff-9763-e31f156df25f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0ed945-07ff-4aff-9763-e31f156df25f@lunn.ch>

On Tue, Oct 29, 2024 at 03:50:41AM +0100, Andrew Lunn wrote:
> On Tue, Oct 29, 2024 at 06:43:03AM +0800, Inochi Amaoto wrote:
> > On Mon, Oct 28, 2024 at 02:09:06PM +0100, Andrew Lunn wrote:
> > > > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > > @@ -210,6 +210,55 @@ i2c4: i2c@4040000 {
> > > >  			status = "disabled";
> > > >  		};
> > > >  
> > > > +		gmac0: ethernet@4070000 {
> > > > +			compatible = "snps,dwmac-3.70a";
> > > > +			reg = <0x04070000 0x10000>;
> > > > +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> > > > +			clock-names = "stmmaceth", "ptp_ref";
> > > > +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			interrupt-names = "macirq";
> > > > +			phy-handle = <&phy0>;
> > > > +			phy-mode = "rmii";
> > > > +			rx-fifo-depth = <8192>;
> > > > +			tx-fifo-depth = <8192>;
> > > > +			snps,multicast-filter-bins = <0>;
> > > > +			snps,perfect-filter-entries = <1>;
> > > > +			snps,aal;
> > > > +			snps,txpbl = <8>;
> > > > +			snps,rxpbl = <8>;
> > > > +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > > > +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > > > +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > > > +			status = "disabled";
> > > > +
> > > > +			mdio {
> > > > +				compatible = "snps,dwmac-mdio";
> > > > +				#address-cells = <1>;
> > > > +				#size-cells = <0>;
> > > > +
> > > > +				phy0: phy@0 {
> > > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > > +					reg = <0>;
> > > > +				};
> > > > +			};
> > > 
> > > It is not clear to me what cv18xx.dtsi represents, 
> > 
> > This is a include file to define common ip for the whole
> > cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> > 
> > > and where the PHY node should be, here, or in a .dts file. 
> > > Is this a SOM, and the PHY is on the SOM? 
> > 
> > The phy is on the SoC, it is embedded, and no external phy
> > is supported. So I think the phy node should stay here, not 
> > in the dts file.
> 
> So this is correct when the PHY is internal. However, this is normally
> expressed by setting phy-mode to "internal". The stmmac driver might
> however not allow that? If not, please put a comment indicating the
> PHY is part of the SoC.
> 
> 	Andrew

Thanks, I will try "internal" and check whether it is OK, and add
a comment if not.

Regards,
Inochi

