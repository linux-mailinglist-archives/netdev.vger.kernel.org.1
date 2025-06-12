Return-Path: <netdev+bounces-196758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F6AD648C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016A63AC6A6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2D26290;
	Thu, 12 Jun 2025 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud/NnQNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54783182D0;
	Thu, 12 Jun 2025 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688466; cv=none; b=uXayRTo0pVwl2KY2r1kCzXcba00D1Ricokv91SACg2PnzHGXyH0NmGcII3LGL50VtXq4OgC2nwE4PfzVMRXWE2BQNqYX7tMUGVaZgYfwyJLYnBgx6PklH+/HxDBou+P5wFcrV6G+kaWNFnHZDdiAMKiioEA7vSLU8Y1SDbLbeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688466; c=relaxed/simple;
	bh=fyg0oH5gh4es/IuhtNEOsuu0+l7oIjlulkU49FIeU38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAxalJja3zqTVYc8ivpF2e+bkubmAGR45EXmrBypy9QrW3XdNceWFMJVxQwGiSqzHXF+vNLd6Ou1yvp6AJiOpFpvJRC5Ii3ot6DeDysBerfRiMcyap8qj4yA6Wu7PvkRH25eh+IvOZ/0zM8MiQQNSAqjS4mlfiUxuBn51Jf7XQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud/NnQNy; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d38d1eae03so36057785a.2;
        Wed, 11 Jun 2025 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749688464; x=1750293264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4cnX0EhvoTvV363ROgxXVvXp5RchZqTY+BHR1peIlQ=;
        b=Ud/NnQNyF1I5G3qec7VXzvqHp/o1RuBYYwT9Rwocnwhg/wUiR5i4k7SQbvovn+96bn
         5IkQ/WiVX1yxJ3Q7J+tuYYQ4Qf/QIQSFqqv72BNBHDB46kssC7YBRtf3racQ63Ang6tH
         bKO+Oq25UHcz/gNXbsh9/ghDxA/Io23m8xPn6HLngjrcpnrXjqyMX8RIqbgXyvo8PAg5
         Czk9/YuOInk6ISaxUVORymQOUmRq7tfGuPgU3LyHoGEGKXKkjcYkMrtMFTgW8FL5tBpI
         5KZp4DNsierkMmPW+NrzFaa1RB8AygQacX834z6yR2PSngP2e4Rd9t7qh9FMzsNCURhf
         wEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749688464; x=1750293264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4cnX0EhvoTvV363ROgxXVvXp5RchZqTY+BHR1peIlQ=;
        b=eQx8o65x/ElK/K0s5g0AJuLFTR574EaRyaTyTThInyt+alZs/eLC5G04PritPO+kE7
         SCnrGocoI/yRvCIAnEWoO8VX6/WWqooCSuwPfivyjpBODhKD8DwITH3cjdxCT6wl/Jag
         gmaoX9ko4izFT4trXGrUGkY3gWZEE0nGkYZNQDo17vaLkxOJSj8B9uM5VkUxjyvG5YJS
         OOHe/RBUa7qqLNPZP9Px2fpaEqgZY7dYi7WBVhqzFN4Xb16xubPxyGUVQe2jrseiPhOX
         LZJZNRm3RhabhxfpeftlAhfMALwF6JLOXE+SXF6B6hj3t44RC3wX5UuI6ffPg+fy6v/J
         AchA==
X-Forwarded-Encrypted: i=1; AJvYcCUtDT4A+bC4eb4v0ZKg0xALVmlfqrUG0Lhp4rg92gmqA/XV4/Mw3t5Fv4vUmhmbn0hE3lRO/H6gyzSt@vger.kernel.org, AJvYcCX4SqlfmF79imYBNGgxAvaYFdlqPA+JvsGjHM6anBi6L/+uykq5IwnfCM8vtphz3cnN/orKu+cf@vger.kernel.org, AJvYcCXRSRt1oF7uqClm3EhRvVMlvqbN4Iv/G11Qdx+0I4ADyZJc+2jtaLA5wpyJaMb3pn92NHbf5XedGNxKzD24@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjL1jq+V1GljqU2fUE5or5XAMil0iXQMCe6YW8O0CVOMecbbz
	v3rK8HsN392UbQRIqVUIuoxKmRIbXu2vyLE6D67OkxwJulfxg/vxOIZX
X-Gm-Gg: ASbGncs89cnEBCGIHCKdJ5bUoDDZ5+ExBmxL+Y/TIKyRFkopqtep4ursL/0t5kCd9jj
	SjFKT3aXDXJvnBpF6iDwojNME/jFaQGEH51SlLYYpB2yRljuB/zzD1AbjVsrOCJ9UCqTSAeGmup
	poJr2wxEgzhTmgmscweZSbqlNKJPOMYxVUZbjXehzbpD5S56FXc1DICkXVV5aQIJepsZdpSZlaG
	fFVaMj6LpiDYnSE8xMlf/3KedVQdIafCTC6OPZaJ3KEkdtHkOSgXHt3+9Wvx1PMG9vdblxozZM0
	gszh3OZPIzGUmg3nfOKv1kKgSaiCJ2h9hgnBHQ==
X-Google-Smtp-Source: AGHT+IGS6qXzX1rhsw1lo3B14jV1zL+YdAy/l3s2f7PapW2jiFo2sgI8OTVrHVYxwYZAApjNnHhfeg==
X-Received: by 2002:a05:620a:24cd:b0:7d3:96ba:78d9 with SMTP id af79cd13be357-7d3b2a6bfb4mr231743485a.29.1749688464229;
        Wed, 11 Jun 2025 17:34:24 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3b5282c06sm35379685a.95.2025.06.11.17.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:34:23 -0700 (PDT)
Date: Thu, 12 Jun 2025 08:33:15 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: mdio-mux: Add MDIO mux driver for
 Sophgo CV1800 SoCs
Message-ID: <m3rqdpoztgbdocm2yx5ajcnfk7p7b2sifp6fibj3htsmw53mbl@icnaj6xndnjf>
References: <20250611080228.1166090-1-inochiama@gmail.com>
 <20250611080228.1166090-3-inochiama@gmail.com>
 <eb419ffa-055f-48db-8c6a-60bf240fbb9d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb419ffa-055f-48db-8c6a-60bf240fbb9d@lunn.ch>

On Wed, Jun 11, 2025 at 06:13:00PM +0200, Andrew Lunn wrote:
> On Wed, Jun 11, 2025 at 04:02:00PM +0800, Inochi Amaoto wrote:
> > Add device driver for the mux driver for Sophgo CV18XX/SG200X
> > series SoCs.
> > 
> > @@ -0,0 +1,119 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sophgo CV1800 MDIO multiplexer driver
> > + *
> > + * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/mdio-mux.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define EPHY_PAGE_SELECT		0x07c
> > +#define EPHY_CTRL			0x800
> > +#define EPHY_REG_SELECT			0x804
> > +
> > +#define EPHY_PAGE_SELECT_SRC		GENMASK(12, 8)
> > +
> > +#define EPHY_CTRL_ANALOG_SHUTDOWN	BIT(0)
> > +#define EPHY_CTRL_USE_EXTPHY		BIT(7)
> > +#define EPHY_CTRL_PHYMODE		BIT(8)
> > +#define EPHY_CTRL_PHYMODE_SMI_RMII	1
> > +#define EPHY_CTRL_EXTPHY_ID		GENMASK(15, 11)
> 
> There are a lot of defines here which are not used, but as far as i
> see, there is one 8bit register, where bit 7 controls the mux.
> 

You are true. Only bit 7 control the mux.

> It looks like you can throw this driver away and just use
> mdio-mux-mmioreg.c. This is from the binding documentation with a few
> tweaks:
> 
>    mdio-mux@3009000 {
>         compatible = "mdio-mux-mmioreg", "mdio-mux";
>         mdio-parent-bus = <&xmdio0>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         reg = <0x3009000 1>;
>         mux-mask = <128>;
> 
>         mdio@0 {
>             reg = <0>;
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             phy_xgmii_slot1: ethernet-phy@4 {
>                 compatible = "ethernet-phy-ieee802.3-c45";
>                 reg = <4>;
>             };
>         };
> 
>         mdio@128 {
>             reg = <128>;
>             #address-cells = <1>;
>             #size-cells = <0>;
> 
>             ethernet-phy@4 {
>                 compatible = "ethernet-phy-ieee802.3-c45";
>                 reg = <4>;
>             };
>         };
>     };
> 

It is good for me to use this. I will have a try. Thanks.

Regards,
Inochi

