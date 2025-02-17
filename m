Return-Path: <netdev+bounces-166874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF377A37A5E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 05:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7007E188E0B4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 04:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819021547E7;
	Mon, 17 Feb 2025 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjU4O4/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93F42A96;
	Mon, 17 Feb 2025 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765807; cv=none; b=X91j1bERQ+FxQFZnS9EGHaPLYGUHbh5uVav+WEDSKY4Fsjm7TeOseaoEs7t0/eHiss352IXNUoJreiBuTyKRss8zuJGIMdwvYN97TyH+pJtcAQTgwQwvIum2yCbXxlEP8XDTA4F2GIv0JUlNgmKYz5aFh9FF+HdG/3g1mO9/hHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765807; c=relaxed/simple;
	bh=gj/1qK7xign1jPAvFg7498pRb/o7n+h70Z+EO/Pzt1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWAUz0heG2GqDszLRdYjhT/ymKWL4e3EFB8YFxmrtlWOKByAxjH3HShpNx/gG1ad4rgeNJPxvg6/WDmHSho3ZgzsQwFuoQ0rkrAM2A6AAryZ33mtG5x5fqqjv/ig6AWJZIkjSGjJ29djPwZUqbWfdqhNgQZl0Kn81i2iTtdpYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjU4O4/H; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c095b5365eso39236385a.1;
        Sun, 16 Feb 2025 20:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739765805; x=1740370605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xeqYFA0tm4qjUwoN64e2QAw9r7GkkFQxBxzl+wfEXG4=;
        b=WjU4O4/HH2StM+oZpVL53qQKQd//bxxs7avmBhyIdbLVwlDG3zxQy2UTn0cFqDHieF
         /YOICdDS1N0b8FnSM/STo0a1MmPN+U0N25XJh9waAfna3+0NaEpQ2SzW3n56MMfVVsGH
         jmD7IcwrEuTGIiquDhqxF57TqV2sx0JLqw50KyFo+qnTSruQSZvGMnHx5ACOCOpuuoA4
         XB+0Uii97Hu+BddmbZ3dIfAAL8Tpl1qP5Aoo4SZ2BGan0n0L+5bvKJkO3k8sqIyHE1Qi
         EP5+EHMu0fNAcJyF9wPSbg5soLZ+Anzyh1/z9Zps9x6WHVU6EJlAzcK07yVivH8KaBMR
         rc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765805; x=1740370605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeqYFA0tm4qjUwoN64e2QAw9r7GkkFQxBxzl+wfEXG4=;
        b=geoc6GFCdWwJjzc1jjggKNPc24AuPVkaXmlGgnSG6LMiU9lxGC5q6X240QArFx+T+7
         JlMVnON/G4dfKwvNVYjnogndwOMaEYR3M8ICl0OsPsx1oXmbDFji9BdU+u8/bhYfuiRW
         PdqX0R3btASRfZWcf/kd9Ed1x3mm7ntMGs4VhmBHiJbdr2NVVRsX/CBZjXUI9HYnhp7X
         j/wyorQpyKqAyPGqAj7//9qpJIonRufe5W3guq9wrfLcyvL0g4VKYAJYRJcmNZ6P5VQW
         Q+O6KQljAeipyiMWoQ0VWtgPXgIIN8LEr6FS0oIyy34Rmsh6bcwutFY4C4Va0JEADAC3
         frXQ==
X-Forwarded-Encrypted: i=1; AJvYcCULqIy43+85+QSh0wiEK1kO7O5SvNp+vw8AKgx4LFiMpO6u46jywa50/TdM6Ps6jSMX4Mq5/gNg@vger.kernel.org, AJvYcCVpTjCnOmc6jAq82oa67bmOYsIXX8s0Zv3IlW4fQ1K6w+PR8+SM1lnQrQ0pnFc30N+JVCcJGpZI6NpG@vger.kernel.org, AJvYcCXe0JcMuA4vqXXBNpebiYX7KfyRIJW4ZsI/typAzqAH0E3Yndt3r7ERyAj8/R/msHIRLWRJlLnBnqk3X241@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+ENpV3qeBPrinYVVJqt/duBSp1Ofrdws33JbfcdIrUfTWAZz
	VVNu8U/BWOHho459Uf8InefbL/x64vp15t0kMJCz7cvWg5s15Oeu
X-Gm-Gg: ASbGnctKw7YT+29NRzzQc5lcuc8N9Ayfp4zIRqIOHvBKqojBnZ4WOgXEf0Oh/YljOF5
	A1zwW8+e1uuwFNt/zl6pAdEVLA2Y98mLl85GyOr3xlDVMZOnEDT3l6NLvGagIlvDR8wvMWGUQ5Q
	cdBrSJon4PMGeKk/c1CqlWiMMSnKaZtFif+EaIIfPH1vcC0CLIjbVpKKVhggmvDLDEcRiAi/hbG
	+IcjZiaDF/yaN/diGldTtqS3ZfwCY9e50RGjnrPMWuEISgbicQaSVpl8agwk2ilqP4=
X-Google-Smtp-Source: AGHT+IHUeYGGtto6/bwu6hE+gNTJFxMdU3WJnKYol+GAez3N8iWRXGYbLq/F4f11XJjWE3T4aBpX5Q==
X-Received: by 2002:a05:620a:172c:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7c08a9a2157mr1155035485a.13.1739765803223;
        Sun, 16 Feb 2025 20:16:43 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c09a14d45dsm102936485a.10.2025.02.16.20.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:16:42 -0800 (PST)
Date: Mon, 17 Feb 2025 12:16:30 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, Furong Xu <0x1207@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Serge Semin <fancer.lancer@gmail.com>, Lothar Rubusch <l.rubusch@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>

On Sun, Feb 16, 2025 at 06:07:05PM +0100, Andrew Lunn wrote:
> On Sun, Feb 16, 2025 at 03:47:18PM +0000, Russell King (Oracle) wrote:
> > On Sun, Feb 16, 2025 at 08:39:51PM +0800, Inochi Amaoto wrote:
> > > +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> > > +{
> > > +	struct sophgo_dwmac *dwmac = priv;
> > > +	long rate;
> > > +	int ret;
> > > +
> > > +	rate = rgmii_clock(speed);
> > > +	if (rate < 0) {
> > > +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > > +		return;
> > > +	}
> > > +
> > > +	ret = clk_set_rate(dwmac->clk_tx, rate);
> > > +	if (ret)
> > > +		dev_err(dwmac->dev, "failed to set tx rate %ld: %pe\n",
> > > +			rate, ERR_PTR(ret));
> > > +}
> > 
> > There are a bunch of other platform support in stmmac that are doing
> > the same:
> > 
> > dwmac-s32.c is virtually identical
> > dwmac-imx.c does the same, although has some pre-conditions
> > dwmac-dwc-qos-eth.c is virually identical but the two steps are split
> >   across a bunch of register writes
> > dwmac-starfive.c looks the same
> > dwmac-rk.c also
> > dwmac-intel-plat.c also
> > 
> > So, I wonder whether either this should be a helper, or whether core
> > code should be doing this. Maybe something to look at as a part of
> > this patch submission?
> 
> Inochi, please could you look at the datasheet for this IP. Is the
> transmit clock a part of the IP? 

I checked the ip databook and found it is part of the RGMII clock.
Also, I found RGMII also contains a rx clock following this quirk.

> Can we expect all devices integrating this IP to have such a clock?
> That would be a good indicator the clock handling should be moved
> into the core.
> 

I am not sure all whether devices has this clock, but it appears in
the databook. So I think it is possible to move this in the core so
any platform with these clock can reuse it.

Regards,
Inochi

