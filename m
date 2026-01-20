Return-Path: <netdev+bounces-251357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE2D3BE9F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 06:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9F1D3530B6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B93612FE;
	Tue, 20 Jan 2026 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar9cdeXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDD35FF77
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768885553; cv=none; b=KyAVRFjWGuXDsjk647iYSB1UZS0V/1xzK/zozvlg50ET9AF6ZrzLVDoSg0qcTZQtyPkw+7/ax3yUlE+6TrZYFmcusx5lapsu5G8bQP4CECeq+1hMqmiBSJrjNWwIly18WvvkTxrE5QOa9P1y5yvFXGXGAp5A5E3c0US1yATG7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768885553; c=relaxed/simple;
	bh=PC4UrdjLqaW0iLhVA9Sz3l4QXzyP/7m+HKjSOXpuvYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJTmmZCE8jJEMyh2lbvMlaSIwZE06Iq2yaZUGLhbWnbp8VPudVGd00UN/Uuvb/9EpUJ49n5SvfbqhNUQwucHf4dkTyHmNaHnPeh7Utx1lK3imHeuzIt0z8EQUKq8G4e+9tXx3NdQ9UTmvyW08afSVmTy49e370VOd6ErHiz7Aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar9cdeXJ; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1233c155a42so6379195c88.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768885549; x=1769490349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFedj4f11o/3T9vWUp8OttHw6rjgwlEi4dqKoM80zmU=;
        b=Ar9cdeXJXB4htFKCh+kHdDLQZF8B6yRc05KRIA9ESLIVLV35SjF7NJ0UHmPPRMnH5e
         1Pn7j3eUZpb4rqg84OE4f1H6giGUsn6NH/88a16jseZ/NB5hZyRyA3CxPowQ+TQM7DcB
         PIGg2yDAYfgv5spq5hvHiORzuEjG4TnoBovhQV07lbrOCmam81fTSGgNeXPFZwpfqGcn
         N3MCh6bFf7zdVD1uU0KLVQ8vIpTHCoxbaC4A3yOOkcbi2pHHmKvxjWPJ4gQI5NETGNsk
         e5QGzomxi/a+BI1vvCaNQfpo0NosxIsRLo9kvg2BBhlmZRZqd4lpKlI/hax+MnSfmLae
         f+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768885549; x=1769490349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFedj4f11o/3T9vWUp8OttHw6rjgwlEi4dqKoM80zmU=;
        b=hX2X/737TjpHzgjxU5AkxtGgS8iEnn95AbSKKWKVkXk2dx0YFw+346FS5xhE9H/dTe
         KH23cPoWSmKJd2cU99B9inK69RT4kP7zJ6Fv8DOvEnrhkyP5+wzoQRNE9rbkkZ2u+zMa
         79+vRkeJ5OicQNp0PYZhLeatz5ILsBsdBtMPuLqILiaKm4oPk76yMrP1+Z8KcNymdbbo
         kRlmrI4hmsw36M+IS72BRW9GaeuF44+6y1VrhGTMLep7oI02SH8yjR9qUj0zAOYClbBM
         /DmiMaH6s0pN0MqtP3aoRNdEYoFJ2EIIKzUnYbf3yLWUjeTXu2y1LtLQ/zFGa09k7Sn5
         B4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpSin1VxeCKJrvvcmslmVdFUanbKKcTZdRWqIn7Kj6zjVS1kyNIV8631HcbpbYJwEYoCaAZQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbUBYRtLO2amWI2YjN+YWPcAtW/pK8wZMwKsRlaRjLIPmiwyR
	eKeeOO090rzk/K0OSqxMduRB1fWsFl0Q37ZxKbXR+Fjb14x4aIlatale
X-Gm-Gg: AY/fxX4FNbLFfIRbxoYkRWMai4hnnQtkkZuKx0R6hs9Tx/O483gQqwANuuAyGriFo4o
	jIoXOa4xBv3f3mBVt1TGWRhPff3G2BYegVJBd6JYiXUbirMmQPwJ8YjsIaMPe4DoVcuVL9ukmTC
	9nNR25j0DQCWdEJmMoMQOlrlRhfAK5F1Qr1JN5rPhmNbYuVN5GgS/4upEjn4//VUkZ6BQuRMx7S
	N5VMH8W93E7sIvzqty5s3PqjlW+GTKee+rRarjVSmPo4jIoogFvC7BUvvdjEKMGXXqOKdigQs99
	UGb2YAxcpaHL8tCtZgjgpzo3dWeVwhoU4srgmGOs8jQN89txdKeSmCs+zAckriemjK7h4zUsTRt
	IgYY3TWyOe61HeCq6JEhmEziGQbxdEIfj9Y8L0jQxiVeDqaCy0xdqklF1LSCZbrHVCsmIPMu9wX
	9YEmSOoIIRwZLQ67CYgpIf
X-Received: by 2002:a05:7022:672a:b0:119:e56b:98bf with SMTP id a92af1059eb24-1246aac3151mr600082c88.38.1768885549389;
        Mon, 19 Jan 2026 21:05:49 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10736sm19178432c88.14.2026.01.19.21.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 21:05:48 -0800 (PST)
Date: Tue, 20 Jan 2026 13:05:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Yao Zi <ziyao@disroot.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aW8MJpERR3TmsiKg@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
 <aW8LAFhCRWlMVemz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW8LAFhCRWlMVemz@shell.armlinux.org.uk>

On Tue, Jan 20, 2026 at 04:56:32AM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 20, 2026 at 12:36:08PM +0800, Inochi Amaoto wrote:
> > Adds Spacemit dwmac driver support on the Spacemit K3 SoC.
> 
> Some more information would be useful. E.g. describing why you need to
> fix the RGMII mode.
> 

OK. I will add this.

> > +/* ctrl register bits */
> > +#define PHY_INTF_RGMII			BIT(3)
> > +#define PHY_INTF_MII			BIT(4)
> > +
> > +#define WAKE_IRQ_EN			BIT(9)
> > +#define PHY_IRQ_EN			BIT(12)
> > +
> > +/* dline register bits */
> > +#define RGMII_RX_DLINE_EN		BIT(0)
> > +#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
> > +#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
> > +#define RGMII_TX_DLINE_EN		BIT(16)
> > +#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
> > +#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
> > +
> > +#define MAX_DLINE_DELAY_CODE		0xff
> > +
> > +struct spacemit_dwmac {
> > +	struct device *dev;
> > +	struct clk *tx;
> > +};
> 
> This structure seems unused.
> 

Yeah, I forgot this, will remove in the next version.

> > +
> > +/* Note: the delay step value is at 0.1ps */
> > +static const unsigned int k3_delay_step_10x[4] = {
> > +	367, 493, 559, 685
> > +};
> > +
> > +static int spacemit_dwmac_set_delay(struct regmap *apmu,
> > +				    unsigned int dline_offset,
> > +				    unsigned int tx_code, unsigned int tx_config,
> > +				    unsigned int rx_code, unsigned int rx_config)
> > +{
> > +	unsigned int mask, val;
> > +
> > +	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> > +	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> > +	val = FIELD_PREP(RGMII_TX_DLINE_CODE, tx_config) |
> > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, rx_config) |
> > +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
> 
> These FIELD_PREP() fields look wrong. Did you mean to use DLINE_CODE
> both tx_config and tx_code, and did you mean to use TX_DLINE_CODE for
> rx_config ?
> 

This should be RGMII_TX_DLINE_CODE. This is a copy paste error, I
will fix it.

> > +	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> > +	if (IS_ERR(plat_dat->clk_tx_i))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
> > +				     "failed to get tx clock\n");
> 
> You set plat_dat->clk_tx_i, but you don't point
> plat_dat->set_clk_tx_rate at anything, which means the stmmac core
> does nothing with this.
> 

Yes, the vendor told me that the internal tx clock rate will be auto
changed when the speed rate is changed. So no software interaction
is needed.

> Given the last two points, has RGMII mode been tested on this
> hardware?
> 

In fact I only tested the rgmii-id, which does not change the internal
id. I will try the rgmii mode.

Regards,
Inochi

