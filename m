Return-Path: <netdev+bounces-162678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A83A27985
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4781886F5C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F021765F;
	Tue,  4 Feb 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPf68PZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25198217658;
	Tue,  4 Feb 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692828; cv=none; b=kSGaTO1JGtM3W3Ach/zUioIeqbnROvITBqPG1UeVgWQv5otG5rnUdCyZJkMa1NcvIX5+Vue/W40mdw66Zn6ZNOe8zM8Idb54u2WFpc2Skp9RI8vfuRTJFA4gXJLSzYqoEEMp1fr6G9r1hNSy+GJm57NMI9DUU80NN3qSWwV7ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692828; c=relaxed/simple;
	bh=Dj4jkBKmFAE3YgshnrDJ3jVrrrueVT1kGYUMcy1Yj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG0TWpj41HnPHx5O0cIpAT8BOg2txBkHH4i3JpucG8ZYnH5f9crWerKXkQltgZug99vpb5EO9m5VwW2KEEnERdJK7MAdna1n/HU5yn7JYzus/F+BWctKgupyQwImfJdE0EnIJqBaWDQ/crcM9IwhmK4fkNi5llpOFbsylTMtJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPf68PZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9007BC4CEDF;
	Tue,  4 Feb 2025 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738692827;
	bh=Dj4jkBKmFAE3YgshnrDJ3jVrrrueVT1kGYUMcy1Yj58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPf68PZsXMszTHlDPMN4gJh22izWzBAeDTVr+R75uw5SpOCE7nyP7DSBMSD8VBoug
	 xyGPevgIj6fO7uivU6QaxLaepHYCFRk1Ch9w6yIwioDcspIQO7q5BjCe3EVylSpmcQ
	 sr+MfO9gZl2/My2GFjNVU5js/P2aKsmgQxTaKkfRJO4BoeDkDEjgm0vVfUuepplqRg
	 SjR2l9LABZOGAKgfquPBx80QqoSWYfqgWb6oFkD5Dia0KL9HiQqKt0LhVro3k2/B3c
	 b1tDqHuxFaBByQxrJKFuw7o2oIUmYFCigfn6mrJO+YYuIeXBfkGUwhqugC9G4h/bxi
	 4AqqyVo3Yjb/g==
Date: Tue, 4 Feb 2025 18:13:39 +0000
From: Simon Horman <horms@kernel.org>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes
 according to the interface mode
Message-ID: <20250204181339.GM234677@kernel.org>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>

On Tue, Feb 04, 2025 at 02:10:17PM +0800, Choong Yong Liang wrote:
> Intel platform will configure the SerDes through PMC api based on the
> provided interface mode.
> 
> This patch adds several new functions below:-
> - intel_tsn_lane_is_available(): This new function reads FIA lane
>   ownership registers and common lane registers through IPC commands
>   to know which lane the mGbE port is assigned to.
> - intel_config_serdes(): To configure the SerDes based on the assigned
>   lane and latest interface mode, it sends IPC command to the PMC through
>   PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
> - intel_set_reg_access(): Set the register access to the available TSN
>   interface.
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

...

> +static int intel_config_serdes(struct net_device *ndev,
> +			       void *intel_data,
> +			       phy_interface_t interface)
> +{
> +	struct intel_priv_data *intel_priv = intel_data;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int ret = 0;
> +
> +	if (!intel_tsn_lane_is_available(ndev, intel_priv)) {
> +		netdev_info(priv->dev,
> +			    "No TSN lane available to set the registers.\n");
> +		goto pmc_read_error;
> +	}
> +
> +	if (intel_priv->pid_modphy == PID_MODPHY1) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +			ret = intel_set_reg_access(pid_modphy1_2p5g_regs,
> +						   ARRAY_SIZE(pid_modphy1_2p5g_regs));
> +		} else {
> +			ret = intel_set_reg_access(pid_modphy1_1g_regs,
> +						   ARRAY_SIZE(pid_modphy1_1g_regs));
> +		}
> +	} else {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
> +			ret = intel_set_reg_access(pid_modphy3_2p5g_regs,
> +						   ARRAY_SIZE(pid_modphy3_2p5g_regs));
> +		} else {
> +			ret = intel_set_reg_access(pid_modphy3_1g_regs,
> +						   ARRAY_SIZE(pid_modphy3_1g_regs));
> +		}
> +	}
> +
> +	priv->plat->phy_interface = interface;
> +
> +	if (ret < 0)
> +		goto pmc_read_error;

Perhaps this is an artifact of earlier refactoring,
but the condition above seems to be without meaning
as in either case the code goes directly to pmc_read_error.

> +
> +pmc_read_error:
> +	intel_serdes_powerdown(ndev, intel_priv);
> +	intel_serdes_powerup(ndev, intel_priv);
> +
> +	return ret;
> +}
> +
>  static void common_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */

...

