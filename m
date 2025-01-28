Return-Path: <netdev+bounces-161335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FCCA20B88
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208891884E11
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17231A8407;
	Tue, 28 Jan 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xw3lOHtQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB47199FAB;
	Tue, 28 Jan 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738072152; cv=none; b=mIWVRhDyIKs2OiZxS7C46xMeD1mbA+E53Y+DyV8Sz2io+nStS3E8CKVR9pOtlfUvHb9HAznoF+J0VBFvJ8K2n32Tihhdm0uEIbbnitPsvbRWdnssSY+1/JaqPmlke22fSYWD2dXD6RukvyGPGade+L3kWZ4rjyBcIkgj5X4TTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738072152; c=relaxed/simple;
	bh=d4PrPPmuTDSTv2dpojCKTePBfPraNwlALzkpPei7KPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEgHWx8G+ePMpbCaA6kF0QtWob5snR410KB4opdsmNnqfK88LqlnoCOBqYrKyGtHY8U2kSs+65hIHAHNey4Wa8IP2yBBfegHRjDY+6Ohr/sP8H7wi7Kb6FZHGZ8xyrWtdSeGhpTFXe19Zkk0VHs74vxtZW2v5ARmnAIUFfrTRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xw3lOHtQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yEmFa+/qd3u+ok4UR2h6fx/Z5JLxm/bEDrf24WuzN2s=; b=Xw3lOHtQvDhLs/svevG9AM/IFX
	DhAAsE7AbxXPYOdj8yAuflscQ/Nlx0sLKdGSZR4X8y95DXU6pGRQPOx2vi3vdBMYV+NxBPc0pRVwq
	7aqUuCbiG0LKhNxVxlVc6oPMrm444u87/9y3325aNXFkZ0vjAhOjPWvS7rgGxqPyB4/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tclxR-008rO1-KR; Tue, 28 Jan 2025 14:48:49 +0100
Date: Tue, 28 Jan 2025 14:48:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
	linux-fsd@tesla.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <63e64aa6-d018-4e45-acc7-f9d88a7db60f@lunn.ch>
References: <20250128102558.22459-1-swathi.ks@samsung.com>
 <CGME20250128102732epcas5p4618e808063ffa992b476f03f7098d991@epcas5p4.samsung.com>
 <20250128102558.22459-3-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128102558.22459-3-swathi.ks@samsung.com>

> +static int fsd_clks_endisable(void *priv, bool enabled)
> +{
> +	struct fsd_eqos_plat_data *plat = priv;
> +
> +	if (enabled) {
> +		return clk_bulk_prepare_enable(plat->num_clks, plat->clks);
> +	} else {
> +		clk_bulk_disable_unprepare(plat->num_clks, plat->clks);
> +		return 0;
> +	}
> +}
> +
> +static int fsd_eqos_probe(struct platform_device *pdev,
> +			  struct plat_stmmacenet_data *data,
> +			  struct stmmac_resources *res)
> +{
> +	struct fsd_eqos_plat_data *priv_plat;
> +	struct clk *rx1 = NULL;
> +	struct clk *rx2 = NULL;
> +	int ret = 0;
> +
> +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> +	if (!priv_plat)
> +		return -ENOMEM;
> +
> +	priv_plat->dev = &pdev->dev;
> +
> +	ret = devm_clk_bulk_get_all(&pdev->dev, &priv_plat->clks);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "No clocks available\n");
> +
> +	priv_plat->num_clks = ret;

It looks like you should be able to share all the clk_bulk code with
tegra_eqos_probe(). The stmmac driver suffers from lots of cut/paste
code with no consolidation. You can at least not make the tegra code
worse by doing a little refactoring.

	Andrew

