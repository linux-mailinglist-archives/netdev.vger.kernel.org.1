Return-Path: <netdev+bounces-244837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C66CBFB5B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 21:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC97C30656C7
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC00224AED;
	Mon, 15 Dec 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+WZlXvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41B227EA7
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829472; cv=none; b=K8ijt5rQmkPfcgj85kTOqluENVFNrHSvrkGqRFBnBNthpKP9f/UXwLoyt7oXMaCM6Cp8CB1fSz83p4CwBhSgK2sK07MAdk1moWLImSRomymdkIPSjsmdkoNQGp2Kg/bhHdPryZm42pwmwW9E0eqLn8EL3UgcMXIt9Q8cc7nP3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829472; c=relaxed/simple;
	bh=bZS2d4r6+t0avva4udbs7u4lgZ+/m7V0Af/OnBnRGOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJyvnX1nrSmb+6cG0q/N9ngVblUrborUB8ZQB6sY49TBjsq+QqZl9QEDsLVRFi1vhohar/DjJX9nc+kVql/R74ls+f3yhfHNTKWZMuMySn6J3027V0+EmgqOC9hScqff54xHN635UAcnXKdXnHKtqgym/HkeQ3LrQoC/DS9A2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+WZlXvr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae77516so46598325e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765829468; x=1766434268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVHWp8cheEcClOBV4c/zxK94NkQEphirpcQRQ+Yuj0w=;
        b=Y+WZlXvrQBStn5H9hqcx7999QFxTj/F2ySRfQJxEtC5DqzayTEQmaLWN4KZ9LTdpND
         5aygj5OHCwr2zjsVwfzmfHBC6vY/thI5mOl81KEEUGva12FHGp46YJ8cWfD+K+b0bNqr
         vLS8nCK/y8ePTgCIK0WMRe/TjPs4gHfGOLq5TXcMxCc20odhaPAh8QGdWdpaydTwJgqC
         Q+m+NauBtGh9uCMpHfbr7sDTmzNKkrdRYzbd6Esku9d6ya1bZPZa1rJ8AMCzlggy+zo3
         R7C/h9jaOmWLu8pp0IFtBXKI43hSZJRCGys65eGWRbml1T1IbiRFUOLSzYXwkSU5QIzq
         /EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765829468; x=1766434268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVHWp8cheEcClOBV4c/zxK94NkQEphirpcQRQ+Yuj0w=;
        b=TMgRD6xmk5NjM4Z2v7drWjR9pLUDFU7wC1c1NProwlcapGKsQunPmE0WWU/cLbG+3C
         vZgOMryo+c/s1rYvIcI9OiWCyhQkgISVHXYvWLGlwUgCRNlUVdMcoMzGGyvjbPaL5K+Z
         rXn3jtUJWbTTRB5rpSvjP7ME2YFolYvuNOs5suvMYRRVJYe1H914rCJm8ZQHR1YOiOxx
         KZy1l609KJ9zqgcnGnZiuDB6ymYPqfC/vKDIZNApXQQ8+oYguGNpT1HMWQnXzGZfO39i
         jNZ5APQCWkyJtfWNCJUCplmD70+W2152GB/ojuWCAFI+VqExvk3J0Mvh7udLSacExatv
         CjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFJ+U8WWAq1awpagGDma3vX9NrJDtezCRFAVMo70d1FE1h/XZkSFgOEhioIEcQaXn23xFcmYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRzbd5J12uNSW82e/uDWmwVJpjBqR9bZzUMU7h5XrOZU0QH7x
	NiTy5d95Yk6w/GoC4T1Gq2OUwbzD4mfHPMznpxeLZ76+B8GlADSLOyxe13MalKFkhds=
X-Gm-Gg: AY/fxX7UxF+pAdlUAylKJ1oudaUhSW8h0LZ0wLkRGRnIPXMP+olWvJ5FuePIabxP9nJ
	Gj3FurMCJAkogsYksN2ofruMVYLuxGaLcEhBeB4DXeLaHyXb4sBaaeE8Djdkda+eIUURljEhxoe
	hFlNsb5ZHxyJb48AbYnN3MtPtGWm5JLIIHaUUvE+bqYw0EbSFI+PuZl+dRv+KwZD2Iz+X4dmNT4
	ltjkrglJD2L/Gve3EkzO9Tx7gLDNRHPgtxNg18Ik904ASvBPEr05M4C/SS2d9OnPLMBAklw9L6T
	cYOtnlVH0zIJO2vek73KUS9POIlDcgf5t4ISr1zs7Q1UTpbOUJ/Rv4XlYM51G8GNsDjtNeRLFdi
	tgA4vLdhhNpkXYASq8IehzakbmH1a+Xgvjn4eFZpNSd00rV7YQKbq50aISbNM77if/kBcwLtHlr
	2w28zqSHhNVQp0dmtl
X-Google-Smtp-Source: AGHT+IFzTdgd8HuBCRpheWEKJMhw6vXCy8KxXaScp0+GwrnVXW68cCuyCfDLEuzw7wX+ZV30A2XRQg==
X-Received: by 2002:a05:600c:46c4:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47a8f9046fcmr137755605e9.20.1765829468100;
        Mon, 15 Dec 2025 12:11:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4ace61sm200864155e9.7.2025.12.15.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:11:07 -0800 (PST)
Date: Mon, 15 Dec 2025 23:11:03 +0300
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
Message-ID: <aUBrV2_Iv4oTPkC4@stanley.mountain>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
 <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>

On Mon, Dec 15, 2025 at 02:28:43PM -0500, Frank Li wrote:
> On Mon, Dec 15, 2025 at 09:33:54PM +0300, Dan Carpenter wrote:
> > On Mon, Dec 15, 2025 at 10:56:49AM -0500, Frank Li wrote:
> > > On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> > > > The s32g devices have a GPR register region which holds a number of
> > > > miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> > > > anything from there and we just add a line to the device tree to
> > > > access that GMAC_0_CTRL_STS register:
> > > >
> > > >                         reg = <0x4033c000 0x2000>, /* gmac IP */
> > > >                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > > >
> > > > We still have to maintain backwards compatibility to this format,
> > > > of course, but it would be better to access these through a syscon.
> > > > First of all, putting all the registers together is more organized
> > > > and shows how the hardware actually is implemented.  Secondly, in
> > > > some versions of this chipset those registers can only be accessed
> > > > via SCMI, if the registers aren't grouped together each driver will
> > > > have to create a whole lot of if then statements to access it via
> > > > IOMEM or via SCMI,
> > >
> > > Does SCMI work as regmap? syscon look likes simple, but missed abstract
> > > in overall.
> > >
> >
> > The SCMI part of this is pretty complicated and needs discussion.  It
> > might be that it requires a vendor extension.  Right now, the out of
> > tree code uses a nvmem vendor extension but that probably won't get
> > merged upstream.
> >
> > But in theory, it's fairly simple, you can write a regmap driver and
> > register it as a syscon and everything that was accessing nxp,phy-sel
> > accesses the same register but over SCMI.
> 
> nxp,phy-sel is not standard API. Driver access raw register value. such
> as write 1 to offset 0x100.
> 
> After change to SCMI, which may mapped to difference command. Even change
> to other SOC, value and offset also need be changed. It is not standilzed
> as what you expected.

We're writing to an offset in a syscon.  Right now the device tree
says that the syscon is an MMIO syscon.  But for SCMI devices we
would point the phandle to a custom syscon.  The phandle and the offset
would stay the same, but how the syscon is implemented would change.

> 
> >
> > > You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */
> > >
> > > regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);
> > >
> >
> > You can use have an MMIO syscon, or you can create a custom driver
> > and register it as a syscon using of_syscon_register_regmap().
> 
> My means is that it is not necessary to create nxp,phy-sel, especially
> there already have <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> 

Right now the out of tree dwmac-s32cc.c driver does something like
this:

    89          if (gmac->use_nvmem) {
    90                  ret = write_nvmem_cell(gmac->dev, "gmac_phy_intf_sel", intf_sel);
    91                  if (ret)
    92                          return ret;
    93          } else {
    94                  writel(intf_sel, gmac->ctrl_sts);
    95          }

Which is quite complicated, but with a syscon, then it's just:

	regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);

Even without SCMI, the hardware has all these registers grouped together
it just feels cleaner to group them together in the device tree as well.

regards,
dan carpenter


