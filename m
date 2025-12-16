Return-Path: <netdev+bounces-244905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270BCC170B
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 09:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3156C306801A
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9AD337694;
	Tue, 16 Dec 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKL4AC78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8877338580
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871780; cv=none; b=TP2G9Y5ZuXxGxYDdonEGHhlW8E+EPCDm4CrdQdMos4ptVsA48uV9Y1UI+QbiS+48x/tslA5tLpuNXzioDNTgUkSPkG90VK4NOK6+pVcA5NujvKk+vHN9NVFFRzjtf+jqSEaFomra6/rKuWvdyjJqGPXe4zMym1WRkNZmVxwGQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871780; c=relaxed/simple;
	bh=UvaxdPuzE9cHgjQPNN5Yc11mBV2d86BG3I765ToiYLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcJag3db3p47nvq6lYIrQifNGvMczC9Qr7vfQ1aaGrgF+tAiYryk1lxZ1TOP5VlxYY/V+oXi88ZFSub6V1TsE4BA/7XJ4sD3QIL218mY/dB2Rk7E4gPdddnzcPjirrOwI23zcgv68w95IB1057gLzyMz8DVsDQHePosuvVnDBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKL4AC78; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso15046215e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765871767; x=1766476567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgLiR9L5wEhCMccIYV392PBhORkDXeC6wYlSh2crOgg=;
        b=kKL4AC788ZGK7hbbd+EIUBXOOeZA3iigMdC1aw6LkK+PSmvbQIwrR87cyEwETDgDSH
         hKbJI4VrZnCpnroLWGyHQe2iT5i8IjXwG4CigDh4c7PG5UsoKDWvPdyM27Q6eIXpcNAg
         YUaVS6J0O3LY3xuU6PU4fqg/9NFffcntId8Aj09azJ3Zce3uVKeU4dJ7Bls1L8w1hXH8
         br0i69YJ/GNnZJaYIgBU6mr38Hp9CJUIrqr7RCp3mIC7nRK7h7jxbFEV9lYuWPTuMgK/
         KKTYatLaS/hZF5weJQeohBEtOlE8zymH/uaoDxui0T81ZjhISFVXBHZGrbSrYnKrSV88
         H69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765871767; x=1766476567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgLiR9L5wEhCMccIYV392PBhORkDXeC6wYlSh2crOgg=;
        b=ujDzAVDQf6bMxKIx3H52EHDC8NZaQ1sYspbQo10oyP4RGMfdcA8txcxvQd19tnTztQ
         fyA02i0uAdGgKdmsZTm5rV81RqRxF1Qw9iyF7DQzWhdeFKFbNg+Of/LSeckXVKwmPr/L
         wvnm+8/uPP/hpqTc6D1Zz7rEThWZHZJPvrfulMw0/iWrHb7dEoi7jR25M22nikoV7qmK
         DS25EQtpY7cACLLycGyWyr6vUyIY8Z5G+qDkhiuREJB7rf9rCPegDfJWZ+abpSIpSICi
         TUwpeDmW6brzk0l4dUv+Hzua+8gK4ak6VGbA7c4TwC1ou7eNpf/0BlXWdMI8Nfn4PGAu
         XLYw==
X-Forwarded-Encrypted: i=1; AJvYcCWBqY3FU+hkQTvACkkpU2x+3IBwgThyhDTAKDoUYoRuSkPyRrsbhFqiorophT1upG7aBTCzQfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb67c4ouKB5elRNuWRAqcr58kkfCRsDWX0rJ3NPjaemUbKCcxL
	uQN7Ekz/JRqAMJaz4OISgS1PSW187EB76uUWjKnR6dqqNKRFqxCQbkQaaBZ9GmhH7DM=
X-Gm-Gg: AY/fxX5QPTp2NBenfeSB3AxlplsPfEoAVgvuieLfL1zBuj2Y3OXbBs+4aJHMLChGFqt
	nE+52pZptqMoRrDgPxCKhfr/LFS7VdWnU2BpIbvdu5xwMOjiev6R5PTLKK15GwqK3BeHZrS/aLr
	5GmmOfHjm6O1Z9FGlN0VqcEQqJ+h25pyadu1OLzuyRrZNNIJSyb8n7ymuRV+UaKEMlEkhB6PRAo
	4IOY46yWv0RuZ4ODrfFT18KjqoXvgDXeJoc3PXa3klMQJI5O9welRF3kmdqL8/JFBzgfyAiwsjh
	e1tGIjDIbj7etmiRggaXGElHwQ1ltOcObm9RU9Ywm8p68+2sWRMGpKVeIgmKpiZEqQNFdwcJXh2
	2WzgcwVVWczg7dTT/AOg2KSFy3KHUxL6GpbUvsdwWK2kHxi4/QwLVGnQvmDAteXccSlMwHeGuCe
	3tmPnPu06HhyVeKLpy
X-Google-Smtp-Source: AGHT+IG+piBYJp8yRE0JaiL0XBKJcrLuB82TEEFiVQtz41FJiO/E2QY1ciGNs20Cvz2Woq6tSTEwTw==
X-Received: by 2002:a05:6000:26d0:b0:430:f74d:6e9f with SMTP id ffacd0b85a97d-430f74d6ef6mr8155517f8f.14.1765871766545;
        Mon, 15 Dec 2025 23:56:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f1fa232csm19824386f8f.6.2025.12.15.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 23:56:06 -0800 (PST)
Date: Tue, 16 Dec 2025 10:56:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUEQkuzSZXFs5nqr@stanley.mountain>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
 <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
 <aUBrV2_Iv4oTPkC4@stanley.mountain>
 <aUB4pFEwmMBzW52T@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUB4pFEwmMBzW52T@lizhi-Precision-Tower-5810>

On Mon, Dec 15, 2025 at 04:07:48PM -0500, Frank Li wrote:
> On Mon, Dec 15, 2025 at 11:11:03PM +0300, Dan Carpenter wrote:
> > On Mon, Dec 15, 2025 at 02:28:43PM -0500, Frank Li wrote:
> > > On Mon, Dec 15, 2025 at 09:33:54PM +0300, Dan Carpenter wrote:
> > > > On Mon, Dec 15, 2025 at 10:56:49AM -0500, Frank Li wrote:
> > > > > On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> > > > > > The s32g devices have a GPR register region which holds a number of
> > > > > > miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> > > > > > anything from there and we just add a line to the device tree to
> > > > > > access that GMAC_0_CTRL_STS register:
> > > > > >
> > > > > >                         reg = <0x4033c000 0x2000>, /* gmac IP */
> > > > > >                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > > > > >
> > > > > > We still have to maintain backwards compatibility to this format,
> > > > > > of course, but it would be better to access these through a syscon.
> > > > > > First of all, putting all the registers together is more organized
> > > > > > and shows how the hardware actually is implemented.  Secondly, in
> > > > > > some versions of this chipset those registers can only be accessed
> > > > > > via SCMI, if the registers aren't grouped together each driver will
> > > > > > have to create a whole lot of if then statements to access it via
> > > > > > IOMEM or via SCMI,
> > > > >
> > > > > Does SCMI work as regmap? syscon look likes simple, but missed abstract
> > > > > in overall.
> > > > >
> > > >
> > > > The SCMI part of this is pretty complicated and needs discussion.  It
> > > > might be that it requires a vendor extension.  Right now, the out of
> > > > tree code uses a nvmem vendor extension but that probably won't get
> > > > merged upstream.
> > > >
> > > > But in theory, it's fairly simple, you can write a regmap driver and
> > > > register it as a syscon and everything that was accessing nxp,phy-sel
> > > > accesses the same register but over SCMI.
> > >
> > > nxp,phy-sel is not standard API. Driver access raw register value. such
> > > as write 1 to offset 0x100.
> > >
> > > After change to SCMI, which may mapped to difference command. Even change
> > > to other SOC, value and offset also need be changed. It is not standilzed
> > > as what you expected.
> >
> > We're writing to an offset in a syscon.  Right now the device tree
> > says that the syscon is an MMIO syscon.  But for SCMI devices we
> > would point the phandle to a custom syscon.  The phandle and the offset
> > would stay the same, but how the syscon is implemented would change.
> 
> Your SCMI syscon driver will convert some private hard code to some
> function, such previous example's '1' as SEL_RGMII. It is hard maintained
> in long term.
> 

No, there isn't any conversion needed.  It's exactly the same as writing
to the register except it goes through SCMI.

> >
> > >
> > > >
> > > > > You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */
> > > > >
> > > > > regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);
> > > > >
> > > >
> > > > You can use have an MMIO syscon, or you can create a custom driver
> > > > and register it as a syscon using of_syscon_register_regmap().
> > >
> > > My means is that it is not necessary to create nxp,phy-sel, especially
> > > there already have <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > >
> >
> > Right now the out of tree dwmac-s32cc.c driver does something like
> > this:
> >
> >     89          if (gmac->use_nvmem) {
> >     90                  ret = write_nvmem_cell(gmac->dev, "gmac_phy_intf_sel", intf_sel);
> >     91                  if (ret)
> >     92                          return ret;
> >     93          } else {
> >     94                  writel(intf_sel, gmac->ctrl_sts);
> >     95          }
> >
> > Which is quite complicated, but with a syscon, then it's just:
> >
> > 	regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);
> >
> > Even without SCMI, the hardware has all these registers grouped together
> > it just feels cleaner to group them together in the device tree as well.
> 
> Why not implement standard phy interface,
> phy_set_mode_ext(PHY_MODE_ETHERNET, RGMII);
> 
> For example:  drivers/pci/controller/dwc/pci-imx6.c
> 
> In legency platform, it use syscon to set some registers. It becomes mess
> when more platform added.  And it becomes hard to convert because avoid
> break compatibltiy now.
> 
> It doesn't become worse since new platforms switched to use standard
> inteface, (phy, reset ...).
> 

This happens below that layer, this is just saying where the registers
are found.  The GMAC_0_CTRL_STS is just one register in the GPR region,
most of the others are unrelated to PHY.

regards,
dan carpenter


