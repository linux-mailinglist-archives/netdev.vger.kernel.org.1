Return-Path: <netdev+bounces-181200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DFA840F0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5F81B85728
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A726FD99;
	Thu, 10 Apr 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj0nHYUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939FBA33;
	Thu, 10 Apr 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281625; cv=none; b=mFHvwFo7RvOODDdSwZfsap2QPQGziSGPvwnY5Mj0knch3CNSS40XYocimKOvyCmLwpH5LpsYW72GJGxoHQ56tWWY6T6uSDSghNoyEuV2VTe/4PKNH8pIygZkV9Uc6tzvFUKhBEds1Own/CN79/7i4s9mB7ofntN66UO7YmnEVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281625; c=relaxed/simple;
	bh=hZhB1PMBWKI+NESKfG1kpe2ydUtCK+5FpoH25aKAhJo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIBKtRVGYtNUqU8NCKCaD15XqSxK06z5CD1gMs8EGWMS47tgNOUNYNgpvaqOXikttmYduHId6K8u0I6k3Y8f2x+p7P7KXmZscTYf2hP+KvfbAPRoSCkNDNAyz5MUGXo1EqbG2/KO6GAzHUCWhR8y8YYuJjpstximXfamNXDVuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj0nHYUW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so462127f8f.0;
        Thu, 10 Apr 2025 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744281622; x=1744886422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJGadgBYIYlqiYhBz+V1s41vhG2hQGZQ1l7A7eqIcQM=;
        b=dj0nHYUWFo3wHNgC/KC+Te4QCjUh7AI0mgBgKVL7UV3oZMtgTik/13tBMrC8FBwj9h
         JQZNTGEsAl17V9OAnuP/Di49oJEsEqSWfTTYLBKrFHJp7kDRWD7DMRBm3vEoIs1R2Y5n
         YRbSt0kSkQsR0UyV0JRFrF7Jx1UVLi+iUlNTrFB8NcoSZ54b0B2R0jK/peSGDguMnnlB
         YRkX5k5HIljofXGN8/zEoRKJ3FPnlPR8pa8gFkbpSlXwkwWlX7FqU4h7NkTdpRmsS80g
         1iJpF/tgakLDyae5iRs0rRsDiVzQ4Z5HSD+rgIVFQnoZMsH2PCO3tCx/QD/U5ghhpsYz
         bVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744281622; x=1744886422;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJGadgBYIYlqiYhBz+V1s41vhG2hQGZQ1l7A7eqIcQM=;
        b=bHVeRnWVnSXwd1yhVCLE5MrUvBVOLvgg4c+xtNYld9gXECOtCkDXpBP9++pYwsSiBF
         Hk5fBWrqaGPKgnkqWglaq8Mw0YAuqnEck1NWPJdaA25ugLbCw6NmcFuYlZoRpolPvcJx
         C80Zuunl0KQEgnOmdVRRvT3GeUXVJBFxR1PFWc9XAGaf5i8BhwtiKalvEoGMMQ0pNvo9
         Kz60TPgzTTo/mSIlDzh/2JYkiRA+RWboOqW4dtNadydm3uMLtMYoNkinyzNqWoSk1M3r
         WCu6R1LpRA6onrkEbXNanmKvxP+0oEtswtBOHEk+RwhyNKT4VsT3lT3MuSXWksyM6r8y
         U6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO9JLZJ6+++ODUtjsHK1n8E9Cey2mVh9QJulV3sUvcqoWaspcJJHHvw6cWNfdOO+gz5drKi5dZplz13fA=@vger.kernel.org, AJvYcCXK+hiXJ0TMD+vsXZ2rdX9uXCOCcJmvG1fu662k1ZoWhQSzGbtctkekO6BdN+WeSpsQl6/kBEZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYp1kYGgn2nzmSYDu8tWW+6jFP9xCSsTPNSOim7D250kUplMF
	aRcjabM9pIUZNqnVS28GxbKhUtbOQ7r7IvMX7S17vVYQgoK0C2OJ
X-Gm-Gg: ASbGncvVXm+IRhZQ3CLx5HrEpliCdgRToIvK4Zffh+adS8Edn1/cLSRVZo9FOAN+Kgu
	rTCzjA3df+QhsEJXDYbZ7wry/1UVy0L/1fndHrhMgmuwOil5jzNRBhJZERKdFsjCvo4mwOknjYE
	Vn2cIxHxp4fvGg2NwsnzQDPbX/C6P9f0yA+xK2pR06JcTACU2vMnOyTzfutLC11ak81pIB+dxWO
	+rmpN9brw4WAIo+GaTdPrTCQaMJnIACPXZIQBIo0UKiHPBrKhvoR9oyqYLDHd+BEE/mEAm/4/m6
	EOgTwi39wxnNIORjsKZZ6d+OzlrrWLOz93/VYP4WzkPPybyvCDv3xPNyQXmVpvWAlckPloEj
X-Google-Smtp-Source: AGHT+IHea/6EMcI+woiOfL8twpzyhy68IJoIIZx3j+61tAoN8k1aHKMVBgM8Xr/g0L/vw/3o1JZNLA==
X-Received: by 2002:a05:6000:1a87:b0:390:f358:85db with SMTP id ffacd0b85a97d-39d8fd8c84bmr1746608f8f.30.1744281621529;
        Thu, 10 Apr 2025 03:40:21 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938b7afsm4426302f8f.58.2025.04.10.03.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:40:21 -0700 (PDT)
Message-ID: <67f7a015.df0a0220.287b40.53b2@mx.google.com>
X-Google-Original-Message-ID: <Z_egD3gd-YO17vpQ@Ansuel-XPS.>
Date: Thu, 10 Apr 2025 12:40:15 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH v2 1/2] net: phy: mediatek: permit to compile
 test GE SOC PHY driver
References: <20250410100410.348-1-ansuelsmth@gmail.com>
 <c108aee9-f668-4cd7-b276-d5e0a266eaa4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c108aee9-f668-4cd7-b276-d5e0a266eaa4@app.fastmail.com>

On Thu, Apr 10, 2025 at 12:31:05PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 10, 2025, at 12:04, Christian Marangi wrote:
> > When commit 462a3daad679 ("net: phy: mediatek: fix compile-test
> > dependencies") fixed the dependency, it should have also introduced
> > an or on COMPILE_TEST to permit this driver to be compile-tested even if
> > NVMEM_MTK_EFUSE wasn't selected
> 
> Why does this matter? NVMEM_MTK_EFUSE can be enabled for both
> allmodconfig and randconfig builds on any architecture, so you
> get build coverage either way, it's just a little less likely
> to be enabled in randconfig I guess?
>

If we base stuff on the fact that everything is selected or that a
random config by luck selects it, then COMPILE_TEST doesn't make sense
at all.

For my personal test, I wanted to test the driver on a simple x86 build
without having to depend on ARCH or having to cross compile. Won't
happen on real world scenario? Totally. I should be able to compile it?
Yes.

> > diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> > index 2a8ac5aed0f8..6a4c2b328c41 100644
> > --- a/drivers/net/phy/mediatek/Kconfig
> > +++ b/drivers/net/phy/mediatek/Kconfig
> > @@ -15,8 +15,7 @@ config MEDIATEK_GE_PHY
> > 
> >  config MEDIATEK_GE_SOC_PHY
> >  	tristate "MediaTek SoC Ethernet PHYs"
> > -	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> > -	depends on NVMEM_MTK_EFUSE
> > +	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
> >  	select MTK_NET_PHYLIB
> >  	help
> >  	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
> > -- 
> 
> I would expect this to break the build with CONFIG_NVMEM=m
> and MEDIATEK_GE_SOC_PHY=y.
> 
> The normal thing here would be to have a dependency on
> CONFIG_NVMEM in place of the NVMEM_MTK_EFUSE dependency,
> or possible on 'NVMEM || !NVMEM' if you want to make it
> more likely to be enabled in randconfig builds.
> 

The big idea of these dependency is that... In MTK the internal PHY of
the switch needs calibration or it won't work hence it doesn't make
sense to select the PHY as it won't ever work without the NVMEM driver.

But from a compile test view where we only evaluate if the driver have
compilation error or other kind of warning, we should not care...

-- 
	Ansuel

