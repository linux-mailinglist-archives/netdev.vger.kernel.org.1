Return-Path: <netdev+bounces-139705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D69B3DF9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047F3282D39
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CC61EE033;
	Mon, 28 Oct 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KURCSItT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45367190049;
	Mon, 28 Oct 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155476; cv=none; b=R86j3tROcpOZ4ayl4c/RlJOG9OxU/ygvpNp1MyItTc6C5weQyEwmWv+4kuHlza+n34PbZ3ETW9AW3OpVlj7XlMUmQEm7A58Q1oOMkRiSi5scsHx+3aZptMB/CQb7FZIKOFxOC4MWSFx7AMrG6bs8hr05X9XwaBIbPkQbefCL0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155476; c=relaxed/simple;
	bh=oFC5xLPzfVQG32+qWcuc3Y/1lCF6OHVwdkJz8EgHe7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX366trgWhkClSf07bzvYpaD9joUPWHc9WIxsiU640DORSzR0pmSVU3GvJUy1OHeprXCowuc08EDsp41x9qqySQlP7nOhGLZxjh4wruGuaOY7hfu5yQNhQQIr2ykLrCF4vDynL5s4wWQvLEZlBkCA6tK46JAZ6bKBQ+mtRDI2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KURCSItT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20e6981ca77so51790975ad.2;
        Mon, 28 Oct 2024 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730155473; x=1730760273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgFwSqKxZi3FF7UkmPRYG9KwHiHgPKv/2vs0tc5OzUo=;
        b=KURCSItTavul58JAA5FmNmASe2JxY46t/MaRrdfG6oEDye6os14++IeB0hXeKODZjm
         uY7LAUalaFIipeJXULjUpHOkW8RVcwBADIeAFquOW5cTkSeHO3ZyKDF6hBLwbLXXvpOK
         70coOvtqzqrWYULcV7M7wsyuqTnLCu5WvAzsGXrnT5QIh2uGN7lBf80ynNRT5IaJGsjI
         KixmCPge6rCU8VXnM1Lt/bbTzvzAUW4yhTSSEL/yxL1bYq44FywDXR4xBB8FVuabI8ff
         BLr0qMg0ADj046X51UxUEzCI7yRQ1SdTFWrSjfbCLD/5xQJBMZWNEgjt/8hstAT6nAJf
         hqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155473; x=1730760273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgFwSqKxZi3FF7UkmPRYG9KwHiHgPKv/2vs0tc5OzUo=;
        b=oasc9upHEyjUT3eCy6FA1Rh/gmmzGoVLCsWU0uib5RhfTsQ0nx5QtLlppwcUXk44RF
         NfDwgjUfVPpgkhsxmx4ZqqXqgnSb3FgzwaSsr8mmUor9TkoPyesDQFwp2qK8RBoeXifM
         cVm13vtWIyPBUp3gMrAdfi8CBtSEcj/5zoDP/CJssfyjKWgV1wwYirn56LrT4s899zAn
         7zXnJI8kffzw4jVKQpzDb9bzbWv7TQzy6cBvvI0JeIaN8Ocgl88gnpyDlB5Bp0COlCp7
         UvVW24uP1/aLXyH91BjQf2G7+UsBm4L2ruBZzN8UUPuXlJWAFoHL8wR0OJB/iQo9oFgf
         +Vfg==
X-Forwarded-Encrypted: i=1; AJvYcCU3m3fhHjJcw221kwnByB07p+p/c/FW/E27LnuU5rSBjwUmoK/qaNTbK5cV2J+jQ8c4yKAZm+6ZA3OujJQE@vger.kernel.org, AJvYcCVYTwogLSlli8NDb4LDWhMrYlMUy0ngofBFKLT0H2X1EICia9rhZ9hrkIKRe64RfYCzzKjPnlnAWw9r@vger.kernel.org, AJvYcCXtyid0bMLtc81w7GSr4jLC78npV4i9IaJLfN/4sOreDsykzE4f6s7kj7i2hv+BXpG3Br17kP7A@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoUnAQ2kCqPZTSz2jMHu2g0Bj6mXih6f3WSIzCGsCJK38iWQk
	6ajM9sLZImlzFmz0+i/7RzGi90NqXmHc7o2VRak9tuTIyht+nQvn
X-Google-Smtp-Source: AGHT+IHe9JwtrfAxRCZKliVLyemHgefPy4SbHNg75z53OjoVcWbOJ47y7AP7JlSm9J6WnP1SMot6OA==
X-Received: by 2002:a17:90b:19c8:b0:2e2:b44d:119d with SMTP id 98e67ed59e1d1-2e8f11b9703mr10455615a91.39.1730155473542;
        Mon, 28 Oct 2024 15:44:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4e631esm9895493a91.27.2024.10.28.15.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:44:33 -0700 (PDT)
Date: Tue, 29 Oct 2024 06:43:03 +0800
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
Message-ID: <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>

On Mon, Oct 28, 2024 at 02:09:06PM +0100, Andrew Lunn wrote:
> > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > @@ -210,6 +210,55 @@ i2c4: i2c@4040000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		gmac0: ethernet@4070000 {
> > +			compatible = "snps,dwmac-3.70a";
> > +			reg = <0x04070000 0x10000>;
> > +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> > +			clock-names = "stmmaceth", "ptp_ref";
> > +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			phy-handle = <&phy0>;
> > +			phy-mode = "rmii";
> > +			rx-fifo-depth = <8192>;
> > +			tx-fifo-depth = <8192>;
> > +			snps,multicast-filter-bins = <0>;
> > +			snps,perfect-filter-entries = <1>;
> > +			snps,aal;
> > +			snps,txpbl = <8>;
> > +			snps,rxpbl = <8>;
> > +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > +			status = "disabled";
> > +
> > +			mdio {
> > +				compatible = "snps,dwmac-mdio";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				phy0: phy@0 {
> > +					compatible = "ethernet-phy-ieee802.3-c22";
> > +					reg = <0>;
> > +				};
> > +			};
> 
> It is not clear to me what cv18xx.dtsi represents, 

This is a include file to define common ip for the whole
cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).

> and where the PHY node should be, here, or in a .dts file. 
> Is this a SOM, and the PHY is on the SOM? 

The phy is on the SoC, it is embedded, and no external phy
is supported. So I think the phy node should stay here, not 
in the dts file.

Regards,
Inochi

