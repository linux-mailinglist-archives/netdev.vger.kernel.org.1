Return-Path: <netdev+bounces-140627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82089B746D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C11284958
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C11482E3;
	Thu, 31 Oct 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmqkIOeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92047146A66;
	Thu, 31 Oct 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730355551; cv=none; b=IBQtQTfMelHhLZpBhwpT4OE2jIiGvZi+IkSUvqR48BQqN2vbB8a4RzED82hl4A3r3jZHa9Ks0p3rv27ODyUnjBYGj+ifL+k4bQKhTNHQnEOLmXzYxkojwN7LpDsJ4OuYKj1jhz8GdPfcco9qGxgUEvXEkz++yI5VInLB5ENb29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730355551; c=relaxed/simple;
	bh=FthSQR3wQ2bQ1mi6KBDIv1GkRuxrTPmRX7Y+Ler4hS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohWyLG6lH4grQUtkaiNvNGgspIszYwtL11QrxsiMRl/XxFdl2ALwT+PoyJhKTopKgcr90ttKAlWOCZs9e77aq/HrXXz4P94/ygf2Tcv6a9HdClRb+LIV1zAosWtRxCL1IFVTg2UAJYOqnuzmBOiAXuowtqmPAuRKTYoQeLe6264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmqkIOeO; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7181caa08a3so289487a34.0;
        Wed, 30 Oct 2024 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730355548; x=1730960348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl02seAhFeSZSgXn8G8HesYy2zdJG36tpIiCaOJ58KE=;
        b=UmqkIOeO+nyGMEJ/3IoHmnvNoQxEDIfFlYKpv3/QamU0FPYgcq1h13WzCVwU79Wvna
         1o/VyD2rfHiDh51wtri2I6T5W+a6Rwgn3Ck8L6UXhpKxzuWG5vsWf5rZ1TKnavls5r/Y
         h0+vjvCriMrpBOI8JY9MlHAlQtgF9RHSWPw1aMa5YUJvkKnQf0o1cJqNCnzDiqI36KxY
         x+6kgZ3Ku3rZnF+U5xESnHP6Fz20MrVGDmWC/ue+Vk5uvCoI6uejSCdSwTNfuoAFRxnI
         YTM0+5x6x8u5gb3viXiKQEYUywgEfsWtaMLPlCXnkLDVXAAIQuAUe+f+l9ffMTEY9+84
         PnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730355548; x=1730960348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl02seAhFeSZSgXn8G8HesYy2zdJG36tpIiCaOJ58KE=;
        b=gUBxoOE+zqoNMsHqrDYRjVPuGNpJofxAxVkUES2DwKI/hWqfwMxCxoUEkMPZk+IusA
         yd91fC9eUT8jvdV/hQTqEFPDSBzV2Ue/FI8c5CABe6Qg6P7PWa3W2BzJrv3fmc2Hkntd
         Vbw/h1xQ8MDl6N8g9iVnu5MC253JG5+oCzz9YiT6Eau2jO10xU4nHvkcZadTaXyg4qjY
         lPqmSGuivXXbjWxgpmGuHjDpqoNyNx9SrJqZ7IMQMclSdsb5dUxtHyMYl86GESO7s1jk
         d6SHgDzN1NCQ/Yss6hbSYQiJlotxTSMFoN977+VqaYfMQir7xWhNuOlyzJzlwj6cIWpy
         ip8w==
X-Forwarded-Encrypted: i=1; AJvYcCUQDghYkv4gzCWoi/g5n0ZkScTWMlp2FazDJI5jY6SKnVEO5AZYQHch+xuvruVIbqw6sAVbxAOL8rME@vger.kernel.org, AJvYcCWQEq87NvRClzaOcbjtM626Eu9Arb0vS+PPARB6g2Z2eKxFP4Y6Di/6dxdDHi3WnW9EWqpplIZ4LOltPB0H@vger.kernel.org, AJvYcCX5I+KkKmeBHYwFFUuFnJxV7Cs9+NYY/bu3qZtq3LEi7EEz8mS5SeuMaOHp3PLs6kutxzX6mMxC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9LerXY19csNjMe29wSLXxdHxTwAtI1wZ55rv/Y/BMkmCTEPTI
	2C5GDC9DwQUjvS7iGiio4He1/+fIz54YrSgESQhUXoxgv3lVqrIG
X-Google-Smtp-Source: AGHT+IH+yIWABoBo9Y8/riPdmGozM5MRcQuOYYbZGmtix58loibt8/a/SmR1ACqJJrBlrL2IPX7jTQ==
X-Received: by 2002:a05:6830:6309:b0:717:fab7:f7cb with SMTP id 46e09a7af769-71868285d37mr14892097a34.21.1730355548594;
        Wed, 30 Oct 2024 23:19:08 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2ebb6bsm587807b3a.176.2024.10.30.23.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:19:08 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:18:39 +0800
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
Message-ID: <ftfp2rwkytqmzruogcx66d5qkn4tzrgyjtlz4hdduxhwit3tok@kczgzrjdxx46>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>

On Tue, Oct 29, 2024 at 06:43:03AM +0800, Inochi Amaoto wrote:
> On Mon, Oct 28, 2024 at 02:09:06PM +0100, Andrew Lunn wrote:
> > > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > @@ -210,6 +210,55 @@ i2c4: i2c@4040000 {
> > >  			status = "disabled";
> > >  		};
> > >  
> > > +		gmac0: ethernet@4070000 {
> > > +			compatible = "snps,dwmac-3.70a";
> > > +			reg = <0x04070000 0x10000>;
> > > +			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
> > > +			clock-names = "stmmaceth", "ptp_ref";
> > > +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "macirq";
> > > +			phy-handle = <&phy0>;
> > > +			phy-mode = "rmii";
> > > +			rx-fifo-depth = <8192>;
> > > +			tx-fifo-depth = <8192>;
> > > +			snps,multicast-filter-bins = <0>;
> > > +			snps,perfect-filter-entries = <1>;
> > > +			snps,aal;
> > > +			snps,txpbl = <8>;
> > > +			snps,rxpbl = <8>;
> > > +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> > > +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> > > +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> > > +			status = "disabled";
> > > +
> > > +			mdio {
> > > +				compatible = "snps,dwmac-mdio";
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				phy0: phy@0 {
> > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > +					reg = <0>;
> > > +				};
> > > +			};
> > 
> > It is not clear to me what cv18xx.dtsi represents, 
> 
> This is a include file to define common ip for the whole
> cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> 
> > and where the PHY node should be, here, or in a .dts file. 
> > Is this a SOM, and the PHY is on the SOM? 
> 
> The phy is on the SoC, it is embedded, and no external phy
> is supported. So I think the phy node should stay here, not 
> in the dts file.

There is a mistake, Some package supports external rmii/mii
phy. So I will move this phy definition to board specific.

Regards,
Inochi

