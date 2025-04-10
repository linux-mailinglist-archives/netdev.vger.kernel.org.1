Return-Path: <netdev+bounces-181203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44610A8410E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312CD7A704E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2026FD99;
	Thu, 10 Apr 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcI3ZCxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA621C170;
	Thu, 10 Apr 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281886; cv=none; b=WHKfwHITJudXlPieqG2qoh3qfuHmrlSb0oa6BUKal18TabZm8IK1wuwoOLDF9JXX7TVDYyBFbtGpL9/B82NzHtcAxC/qzLZK+eAlrUEtwedWW1ZtCqtoJoXWGY6H/sxExqoGhS/ItoDMLBaLtvqnp6tvHY/YMEjDR54LlEpz1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281886; c=relaxed/simple;
	bh=CUzrs47Y+k403hyivVcJolsb+DzLoR4OGqZ1+5g0s9o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utp5EWNsaARvEXyinjak3xWBhRNNZggqYuv40N7N6R7n1VYwovIU15TSC50L1/jZcS56BmCSZUIEJMM80TvaKO3P4bDQJ+iAOPCPwLapjquJ6B0VtM+RoX7lBVG7kEI3pDBdB4+CceOFfisspkVqm3YxODbbakxgxx6+o4bc59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcI3ZCxv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so7345545e9.1;
        Thu, 10 Apr 2025 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744281882; x=1744886682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ//pMPETAg42dcoPkby3wAxyfGZ1IdNRs3h3LBFxtE=;
        b=GcI3ZCxvdSl2/o7yXnP49cdEDNLc7rciSacQb3eG2loCRRPNxdpX3r3j4d9qEgGZ40
         3lsMcnPvefCZjfHd5irhHlzCqqQH2cOCzSHcZbqc+NGSr/pvyyk3AU33wM68uwzO7eSo
         uv/eND50Z1sD/5W2BW6sYrLptf1wawWYtrArqIO1dqIRgYARxcXSyujclunwjX1ltXJl
         HFoSb8ysD2ijx0Iyj/BMxsNvG+DEP+vgb4Q+xhDNbTjOEGUQqfnHkdLGA5zp68vHZZsN
         qME/0/90UB/CY35nax1Kiw4hpEwYMNiUSY/OoqFkB0g8HR11EIN4kaIGnoMj5fNjeKWO
         K0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744281882; x=1744886682;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ//pMPETAg42dcoPkby3wAxyfGZ1IdNRs3h3LBFxtE=;
        b=Oy54p86d+NkjZ2pyXF5C+xIBkkJKYsSpJgmBlsHqxFhTFW9RWHmqnj5xUWEUuJWPlK
         LkdGO0jOT6fzvntLWXoLtb6GlMT0rm0r98xVY3axcLJcIwW7WVkhmLfrdP0gtW+FH9gD
         xl8xy1X0oPDV+2b+xWG3g9RCYC75959lqxlbSz5LWMa5EQ1yISzfRzwpFraDG2SMr5GZ
         MeVa5Nm2IuBpeQI4zoruDQQLaLOZ5sGB/l52stJBOC4k5U7JD5P0EM4AXUE8vPxSWJHw
         YmV4I9RPrXawyepWzBgRsgVLoiQE3JHmFspA/1L3I2krF6zEFsossyM39xrpitjN9q4q
         JuDg==
X-Forwarded-Encrypted: i=1; AJvYcCWwBUu6OdXjE/bUSQdE6f0YLDUfGT7hDpUmBnI5Gd0GXMo+BDpp9xWsYLDXrsKtzdBioUgu4eQ07oCFxBU=@vger.kernel.org, AJvYcCXI/PTDsWtkkGNeQ58H9wVesdtI78hK0dRMTsmeIZq3+C1Tvy8vzkcL8/PbFzX/8/Lj8D7y5LWD@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFsmkWQBywIyYIhlM24L0O/2G0ZVoq09SX55Iboc0VVeK8WM3
	IBvELB4TL+2RWKoRTLoU3S5mDjQutwS9xNP9x25P0mcI//iJU0m2
X-Gm-Gg: ASbGncs9Q264rJYPoRNR1Teo295k3lK327C5VHSQYj6Cy94/vi6dIRO/x38BfMdaMUT
	gTHtywmagpgmAjbqMMRaYdDBxUHNntlGV235fiBvjyv66sTxSlB9VIUD7iAq4vGA8IBuputlttn
	t2iASOWbLEvirDVxmmfUiXimpDbe4D2zXavCWEA1kd5O4m/Lu0Pne+2k9sYKv9MgKorm8ipwSMj
	kEv3Z6C0G9dSuisoGzbn1iLZozavBZes+jEALwFJSinT1agkPVizzIhiO9cLE1UpM14eO7rOYuO
	i218Gw5/xS60zfy7rrjC5CrIJ77surle0mO8qk6cFfi5U4YQMJANql2poqEmg5OpIYk/sMPH
X-Google-Smtp-Source: AGHT+IFpFXLEJ+sOfYOonC+1hRzn/Ph2PLZMKSNMJUMAryBjgbH/PZKYKQFKTofpYWUTnxZfWrW3yA==
X-Received: by 2002:a05:600c:1e89:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-43f2ff9a01cmr14904835e9.25.1744281882275;
        Thu, 10 Apr 2025 03:44:42 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0b2asm4376280f8f.72.2025.04.10.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:44:41 -0700 (PDT)
Message-ID: <67f7a119.050a0220.b15d0.3df3@mx.google.com>
X-Google-Original-Message-ID: <Z_ehFF-osk3iMrMw@Ansuel-XPS.>
Date: Thu, 10 Apr 2025 12:44:36 +0200
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
 <67f7a015.df0a0220.287b40.53b2@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f7a015.df0a0220.287b40.53b2@mx.google.com>

On Thu, Apr 10, 2025 at 12:40:15PM +0200, Christian Marangi wrote:
> On Thu, Apr 10, 2025 at 12:31:05PM +0200, Arnd Bergmann wrote:
> > On Thu, Apr 10, 2025, at 12:04, Christian Marangi wrote:
> > > When commit 462a3daad679 ("net: phy: mediatek: fix compile-test
> > > dependencies") fixed the dependency, it should have also introduced
> > > an or on COMPILE_TEST to permit this driver to be compile-tested even if
> > > NVMEM_MTK_EFUSE wasn't selected
> > 
> > Why does this matter? NVMEM_MTK_EFUSE can be enabled for both
> > allmodconfig and randconfig builds on any architecture, so you
> > get build coverage either way, it's just a little less likely
> > to be enabled in randconfig I guess?
> >
> 
> If we base stuff on the fact that everything is selected or that a
> random config by luck selects it, then COMPILE_TEST doesn't make sense
> at all.
> 
> For my personal test, I wanted to test the driver on a simple x86 build
> without having to depend on ARCH or having to cross compile. Won't
> happen on real world scenario? Totally. I should be able to compile it?
> Yes.
> 
> > > diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> > > index 2a8ac5aed0f8..6a4c2b328c41 100644
> > > --- a/drivers/net/phy/mediatek/Kconfig
> > > +++ b/drivers/net/phy/mediatek/Kconfig
> > > @@ -15,8 +15,7 @@ config MEDIATEK_GE_PHY
> > > 
> > >  config MEDIATEK_GE_SOC_PHY
> > >  	tristate "MediaTek SoC Ethernet PHYs"
> > > -	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> > > -	depends on NVMEM_MTK_EFUSE
> > > +	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
> > >  	select MTK_NET_PHYLIB
> > >  	help
> > >  	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
> > > -- 
> > 
> > I would expect this to break the build with CONFIG_NVMEM=m
> > and MEDIATEK_GE_SOC_PHY=y.
> > 
> > The normal thing here would be to have a dependency on
> > CONFIG_NVMEM in place of the NVMEM_MTK_EFUSE dependency,
> > or possible on 'NVMEM || !NVMEM' if you want to make it
> > more likely to be enabled in randconfig builds.
> > 
> 
> The big idea of these dependency is that... In MTK the internal PHY of
> the switch needs calibration or it won't work hence it doesn't make
> sense to select the PHY as it won't ever work without the NVMEM driver.
> 
> But from a compile test view where we only evaluate if the driver have
> compilation error or other kind of warning, we should not care...
>

Also 99% I could be wrong but from what I can see in NVMEM kconfig,
NVMEM is not tristate but only bool? So NVMEM=m is not a thing?

-- 
	Ansuel

