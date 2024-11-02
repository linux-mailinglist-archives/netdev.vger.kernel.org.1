Return-Path: <netdev+bounces-141139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920BF9B9BA2
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 01:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397D2282419
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869AAD23;
	Sat,  2 Nov 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRhbE48U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029654690;
	Sat,  2 Nov 2024 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508598; cv=none; b=LwdJGb8H8IXHYPVGlIBEFIZ73RHLeiEa8GlRgTeHhjvW2jetpwXLxt0J/GzWeSwJ3zxYFyXQjIX/e3DGW8m8MJM+GF+rg2EOL4p/7MBWt4SEzKTxUJs7pv+N9o+C5l9iCOUwKPDiWjwce4KFMbYBpyGK3Co4KIAOA+BIcrgggz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508598; c=relaxed/simple;
	bh=qEroFCiIBuVzalKB5k23XEUrskQ5paOey5x9e6/IrCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4vZH3jvaXKvyNT6usD+fIPpIBC4rRo/KB/dnx+KO4G1PPRkp9GWtxJCc7gsWp8aPnb3MkXAcIqLhC1Jihn0qhXOrvTqFRFxzv64uGWOTFOcYxYJ4p1bPDO/yvFiCh7QjxtJTrkA3bEioX5T7er6grnqwZFlJCaJ8c1TzQFYmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRhbE48U; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720be27db27so1897111b3a.2;
        Fri, 01 Nov 2024 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730508596; x=1731113396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXIAuR/51D0pou43bt+LOMQQ2AlEuDQoocShKXn+15Y=;
        b=XRhbE48U8tADGBVXesXeDoj2i3wX3tQ8cUtzsccXlamkH+rjKwzA+MpCLj4F6BgcfG
         hdS05MhFrK9CKPPbPIBfBzOaZGKbJhVgJyW4pxSHqFbqUFCMAEhdlprxcE3HhYAYjERe
         RGHwsbKwmGOL8JK240aVZdQHS+9GcNsgNZNbaAx1bD3wvk3knxOnUGMnSYtmKqars0DS
         8rkLOe6SYXfzANr9hxKGIscKhpQk5GKxY8ZtIuiRUy8+1yLKwegDXex8AtnJ6ULiQzkJ
         9FA28Rsj7/zXkqm1ZcIWpTTlHOo66zCA95IwBTgbp9YN4b7YiQErcc+PUvX34Wyc+tqf
         YhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508596; x=1731113396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXIAuR/51D0pou43bt+LOMQQ2AlEuDQoocShKXn+15Y=;
        b=AleFB3JNo0x/Cjo1o+FcSRrQwGN0/UUi9tPikJX/bqd+IGAR1pcQ3s8fLIpu06eFit
         z/pSL5FdqcdzKVyTKi5RwlfoAoHMKYOM7HvWVfkxIZpvpnRqgnccMXwOjOWug+wM+Xl2
         d/B1kQKFNTd6p6fwZpG964xtd6b9F47Uld3HTaaZVz43ZM+GrE3hUBNXuG6htNec+HGX
         IZECCkeHGvdCMBR+9Zn/2Dr46OSGJHf65Tdn0c59eX2QRUTBsCNRMg14x7qJ9ciPqYC0
         U/5fUFe/cWAnjCfL8AcoqA23SLorHGTXf02qInX1FUGC7ODKxTtykXNAJzlIiKqhwsMn
         Vc8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9qPzZIeotqOcitO/+Ri2jkIuAEgDJ8mKiadShNeIQzCXLv5wDMctRi903wIL5eiMkSqKjyF0YYJcZ@vger.kernel.org, AJvYcCUnNhAbGSJL3BttGGa15LVpOtc3MEqxzC2qQR82e144XgUk55YSxOBmyiurR+mFqmvX2twZ0mrE23WI3y69@vger.kernel.org, AJvYcCXzhPEmF2hiw9BttC63Ox3z1PD/EmtGnF7Uo3RcvFBt1O3Xqbvo3eB6MrubkqiMvaOypCiBrb4V@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyZzrkR9HsFpOARZxYX8ufXYv5FVRVtiFE0GUExV0Xj1/L2xL
	IUYJ1wvnIk1O6GELKtAodUFMatngF3cw9K0uV6hrrEnLWfRAw0a0
X-Google-Smtp-Source: AGHT+IHbrS7Zz8aqhA9iNJ6BENNi1qi8TjZ5N6MLO9abZP6T/0eW2eyn4Dxkv2ihng2PAT86PcvCUA==
X-Received: by 2002:a05:6a20:b40a:b0:1d9:29ab:9b49 with SMTP id adf61e73a8af0-1d9eee1e129mr15296159637.32.1730508596196;
        Fri, 01 Nov 2024 17:49:56 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f9050sm3127263a12.74.2024.11.01.17.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:49:55 -0700 (PDT)
Date: Sat, 2 Nov 2024 08:49:26 +0800
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
Message-ID: <nrpyz7kdbcx2zlrgtqd7fkg2fb5n2s4matjj6ouy6jxcubcwzy@vwnlhrgchgm3>
References: <20241028011312.274938-1-inochiama@gmail.com>
 <87e215a7-0b27-4336-9f9c-e63ade0772ef@lunn.ch>
 <wgggariprpp2wczsljy3vw6kp7vhnrifg6soxdgiio2seyctym@4owbzlg3ngum>
 <ftfp2rwkytqmzruogcx66d5qkn4tzrgyjtlz4hdduxhwit3tok@kczgzrjdxx46>
 <e389a60d-2fe3-46fd-946c-01dd3a0a0f6f@lunn.ch>
 <nkydxanwucqmbzzz2fb24xyelrouj6gvhuuou2ssbf4tvvhfea@6uiuueim7m3a>
 <5b08e092-c302-43a9-a04d-3566bec96e94@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b08e092-c302-43a9-a04d-3566bec96e94@lunn.ch>

On Fri, Nov 01, 2024 at 01:40:00PM +0100, Andrew Lunn wrote:
> > > > > > > +			mdio {
> > > > > > > +				compatible = "snps,dwmac-mdio";
> > > > > > > +				#address-cells = <1>;
> > > > > > > +				#size-cells = <0>;
> > > > > > > +
> > > > > > > +				phy0: phy@0 {
> > > > > > > +					compatible = "ethernet-phy-ieee802.3-c22";
> > > > > > > +					reg = <0>;
> > > > > > > +				};
> > > > > > > +			};
> > > > > > 
> > > > > > It is not clear to me what cv18xx.dtsi represents, 
> > > > > 
> > > > > This is a include file to define common ip for the whole
> > > > > cv18xx series SoCs (cv1800b, cv1812h, sg2000, sg2000).
> > > > > 
> > > > > > and where the PHY node should be, here, or in a .dts file. 
> > > > > > Is this a SOM, and the PHY is on the SOM? 
> > > > > 
> > > > > The phy is on the SoC, it is embedded, and no external phy
> > > > > is supported. So I think the phy node should stay here, not 
> > > > > in the dts file.
> > > > 
> > > > There is a mistake, Some package supports external rmii/mii
> > > > phy. So I will move this phy definition to board specific.
> > > 
> > > When there is an external PHY, does the internal PHY still exists? If
> > > it does, it should be listed, even if it is not used.
> > > 
> > > Do the internal and external PHY share the same MDIO bus? 
> > 
> > They share the same MDIO bus and phy id setting.
> 
> What do you mean by phy ID?
> 

It is just part of the MDIO mux. Just ignore it. It is just
used to show only one phy can be used at the same time.

> > When an external phy
> > is select, the internal one is not initialized and can not be accessed
> > by the SoC.
> > 
> > > I've seen some SoCs with complex MDIO muxes for internal vs external
> > > PHYs.
> > > 
> > > 	Andrew
> > 
> > There is a switch register on the SoC to decide which phy/mode is used. 
> > By defaut is internal one with rmii mode. I think a driver is needed to
> > handle this properly.
> 
> This sounds like a complex MDIO mux. You should think about this now,
> because others have left this same problem too late and ended up with
> a complex design in order to keep backwards compatibility with old DT
> blobs which don't actually describe the real hardware.
> 
> 	Andrew

Thanks, I wiil design a driver for it to handle this mux.

Regards,
Inochi

