Return-Path: <netdev+bounces-114305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A795A942160
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6545A286A41
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1518DF60;
	Tue, 30 Jul 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C2H3gKII"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DED1667F1;
	Tue, 30 Jul 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370481; cv=none; b=OeMECoDDO2O5IyJgvqaG8RSFiDM3+lhNOeMfNI04WCEzUS8PHFxwymNU7jCjClxulxbZg8gY/hQJuQwgTGwh9Ocwvp43mNIt17aoYWxHtfEiotuwFImcNyBb2e5nq5RWLEoyNY8Fbr+Hp7v56/9r2sxxqs2lIL4xYY92FPHejHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370481; c=relaxed/simple;
	bh=9FSQ4rRw0IzGDwl2vOi2QSzdr2u/VER9L8rUJuaSq5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alq39LWaWdWfbOs3DM0eubBtgYcbAIBphhnEuXcGfrcXRA5GFbhK5jnQkEGCwNBnNGVdCiAJk0ZyeD2mr3g56y/QJ0LKNrsv4EiLiaY+VPFRIiqu8xrDIy5V4jEz4PIOugVSYX241wAX8Qq9VFsqIO8Jt7emCzp9/e5i/6TbkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C2H3gKII; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v4CFd2TasPmU5GDteTVVRLuZB39ec134+LR0uaf3ydU=; b=C2H3gKIIUm+tU5C1HxkyyXLETb
	PlZtDj4JkLFTu4kywGSODjI4ivgbmrIhmZvC1pSmlDF3UAWR0fxQ21aOZ/zSTXvmirEW9gg3bcvOm
	IWoixsdzzX5pVPIZWZxFnXl8cXx+o+WAJWXWa4kfOHVB2oR9hNjQrTn+3VmGOGgw8bzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYtEk-003brc-7n; Tue, 30 Jul 2024 22:14:22 +0200
Date: Tue, 30 Jul 2024 22:14:22 +0200
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
Subject: Re: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <18b83c34-c0e4-466c-aaa1-fff38c507e9a@lunn.ch>
References: <20240730091648.72322-1-swathi.ks@samsung.com>
 <CGME20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25@epcas5p1.samsung.com>
 <20240730091648.72322-3-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730091648.72322-3-swathi.ks@samsung.com>

> +static int dwc_eqos_rxmux_setup(void *priv, bool external)
> +{
> +	int i = 0;
> +	struct fsd_eqos_plat_data *plat = priv;
> +	struct clk *rx1 = NULL;
> +	struct clk *rx2 = NULL;
> +	struct clk *rx3 = NULL;

Reverse Christmas tree please.

> @@ -264,6 +264,7 @@ struct plat_stmmacenet_data {
>  	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
>  	int (*init)(struct platform_device *pdev, void *priv);
>  	void (*exit)(struct platform_device *pdev, void *priv);
> +	int (*rxmux_setup)(void *priv, bool external);
>  	struct mac_device_info *(*setup)(void *priv);
>  	int (*clks_config)(void *priv, bool enabled);
>  	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,

It would be good if one of the stmmas Maintainers looked at
this. There are already a lot of function pointers here, we should not
be added another one if one of the exiting ones could be used.

    Andrew

---
pw-bot: cr


