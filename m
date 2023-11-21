Return-Path: <netdev+bounces-49717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A67F3309
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461F0282DF1
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015AE59151;
	Tue, 21 Nov 2023 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bl/aQJrf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704E139;
	Tue, 21 Nov 2023 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aZVSbYQtEsrPqaqCsxCo31rNgSiygRJ3cLDc3knYFXU=; b=bl/aQJrfTUHDANhv3Dm5Ml7ZlX
	okOdikl4AvtMqEPCYzdztmNsTVsVk54SMW+rRWhtfEdvZIL45Bq24Hiq59b/Sdqw/RhiBP96bZzgr
	A4kORTZ2Boqv7A76JCAy1UhWdqd0PYSbFYBy8O1c0KYzzbRX6IJRtyCjZZPIY4IshspA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5TBF-000m1v-SN; Tue, 21 Nov 2023 17:00:53 +0100
Date: Tue, 21 Nov 2023 17:00:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, avifishman70@gmail.com,
	tali.perry1@gmail.com, joel@jms.id.au, andrew@codeconstruct.com.au,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121151733.2015384-3-tmaimon77@gmail.com>

> +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> +			 struct plat_stmmacenet_data *plat_dat)
> +{
> +	u16 val;
> +
> +	iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> +	val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> +	val |= PCS_RST;
> +	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> +
> +	while (val & PCS_RST)
> +		val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> +
> +	val &= ~(PCS_AN_ENABLE);
> +	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> +}

Is this a licensed PCS implementation? Or home grown? If its been
licensed from somebody, it maybe should live in driver/net/pcs, so
others can reuse it when they license the same core.

       Andrew

