Return-Path: <netdev+bounces-65995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A783CD33
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5187929980B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464D136651;
	Thu, 25 Jan 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2SY+C86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEB1350EE
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213576; cv=none; b=bIYfX/lBWmI3Gi02gNp+4xQM6dUsbXoCi0jFw0molhAyGGpD3czz2QOEo83kBIqU9LtrSl9A/IsL5KIqfhOTXWIX0adEs1ZX8FqTd3J2nwlMZ/xSyRMiKoaj/tJ2OaYb+VGSlVf3WPgHGCLc2m1R6mLfyq71q/roVlAgtg7wzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213576; c=relaxed/simple;
	bh=akP9D0evtQfuHBvXx/T7FJEZht6k6qo+IfAnEfDNBgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA85QpOyBxpV/1CPu8I0PL3wPOXTGBbTXDVE+v6Ign26HMh3PQpPFdGIMQdA1CivTG7ApmmJpxZ/jd3kFHxcaCcmNZ6V3OeenuMbx9ORHVknPR0Dh2M7rOEXLcdBfp2lmTuOejgrwx2noaEzN9iqvC40hsN33iKC3CBCm1J+14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2SY+C86; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so122894e87.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 12:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706213572; x=1706818372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9RnfhnJnAYn6KEPX9ZquZRAqqB/VpODYVAPEvnW4Rr8=;
        b=W2SY+C86IShUxOx3Qx5J7QvwnYpLjnaKBSYoTiykTvDAh1HuyX9fGh5y5IH3RF+EEQ
         oFeodW48hnsXK9EfdEaefsT2CzsLIDdWJdDRMEh3NbRiUo3z7gbB8E7Lx7Ueo+g0/lG9
         4LUsCXqgr2wWp7nZRxwYcECXmQk2xAkCQArt1vQm62/5t281FC1rfEQSNfS1KOU9ucFH
         qIvRYyysWhV7DkkScl5W51ZAfKckf9VW+XHqOxybbDUJ1+2yBj7rWczPEgmT+Hqq0TyJ
         tIBV/j4lyK0+dH9PK/jsalPI1166TLx2vJinz92ujWkJpGpENcEkDQa7iGfzrCnXMr/z
         IljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213572; x=1706818372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RnfhnJnAYn6KEPX9ZquZRAqqB/VpODYVAPEvnW4Rr8=;
        b=W7IAVhmGSzUb9R6AeeJakOK4HnG5FlLbGcup0DfTkEUYC9MPfyocFAgWfYfEJALaAd
         FFeOYqAtsnF/hRUcdRQtIefG+4kOwK8sVd9+s2dAcm9rROM3hihHHaxuUOfrdEsLCKrj
         zIR7khxnWPCXGuta2uf0xEydhws4Lgd+p3J2cvFJODXhew2W+8I+by7zA0Ibn16iPA8T
         1zhV1BzQJPoHZiRhjq0A8tqbchFpzYCQPyrGIFsKCvH2CbJBkZ0tIkfRJfewYAWhzS5+
         xYGLIRBjg9G/7vQAzFav36V1quVLSOYQTWAhvUfox2oZ1gRLm3G9IXhBLBf8pN8dxJUm
         FSJw==
X-Gm-Message-State: AOJu0YzNc24R5lebQFE4IJf/DvDx2+wi8zhrAIpemHPNvuqDjjeaiJQz
	TA7SqiMJhDr2072cNClmYBbQ8cwx5Z5ZboxeA4qF7KHpr613399Z
X-Google-Smtp-Source: AGHT+IEA53UM5UuXc0UaQmb+HycOLagmmfgzjA6JX2Hp0+8LvlnDL/koHPH/B3CL0ZT7J1MiTiXKDA==
X-Received: by 2002:a19:5517:0:b0:50e:7a91:7e93 with SMTP id n23-20020a195517000000b0050e7a917e93mr186965lfe.44.1706213572291;
        Thu, 25 Jan 2024 12:12:52 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id cf33-20020a056512282100b005100c62d62dsm690916lfb.113.2024.01.25.12.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:12:51 -0800 (PST)
Date: Thu, 25 Jan 2024 23:12:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <52cjdjvgfiukshwoy276pega4tlaq3bouaw6syvjvmab5fbo5n@ugw6ztxjjgvl>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
 <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>
 <xrdvmc25btov77hfum245rbrncv3vfbfeh4fbscvcvdy4q4qhk@juizwhie4gaj>
 <44229f07-de98-4b47-a125-3301be185de6@loongson.cn>
 <72hx6yfvbxiuvkunzu2tvn6glum5rjrzqaxsswml2fe6j3537w@ahtfn7q64ffe>
 <ZbKrRL9W5D1kGn0F@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbKrRL9W5D1kGn0F@shell.armlinux.org.uk>

On Thu, Jan 25, 2024 at 06:41:08PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 25, 2024 at 09:38:30PM +0300, Serge Semin wrote:
> > On Thu, Jan 25, 2024 at 04:36:39PM +0800, Yanteng Si wrote:
> > > drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c: In function
> > > 'loongson_gnet_data':
> > > drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:463:41: warning:
> > > conversion from
> > > 
> > > 'long unsigned int' to 'unsigned int' changes value from
> > > '18446744073709551611' to '4294967291' [-Woverflow]
> > >   463 |         plat->mdio_bus_data->phy_mask = ~BIT(2);
> > >       |                                         ^
> > > 
> > > Unfortunately, we don't have an unsigned int macro for BIT(nr).
> > 
> > Then the alternative ~(1 << 2) would be still more readable then the
> > open-coded literal like 0xfffffffb. What would be even better than
> > that:
> > 
> > #define LOONGSON_GNET_PHY_ADDR		0x2
> > ...
> > 	plat->mdio_bus_data->phy_mask = ~(1 << LOONGSON_GNET_PHY_ADDR);
> 
> 	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
> 
> would also work.

Right, explicit type casting will work too. Something
deep inside always inclines me to avoid explicit casts, although in
this case your option may look more readable than the open-coded
bitwise shift.

-Serge(y)

> 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

