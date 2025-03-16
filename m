Return-Path: <netdev+bounces-175133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E457EA63662
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAC23A4A2D
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB2131E49;
	Sun, 16 Mar 2025 16:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A415C0;
	Sun, 16 Mar 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742142743; cv=none; b=Y+DAX0dAkXgBfiTHrTRfQcfuY+1oN+l0iXWKZnXN6pTUUNJ+wO9Om8sZR+RBzaTZIAYyNhUMtsXXsKDs3Kta4VCQbgMdiQHooYR/JJu/dyHC619MoX11kmKOxJT3rL7u5Ilr0tAIwWopNjJMMRVSUp36Wctoq8zwyonkiifomOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742142743; c=relaxed/simple;
	bh=6tNpEgrX2sPS4nyDQI0vX/eclmSY+zcXwfsjcq3Un2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqzVyGFahD5i0bmE7SidhWsV3/F/UWezG5smA6gneXKN6N+2vjZY93FrZFEA6Oc6MAEOcxklEQzB77lGoxAPQ7nLIDvgTIKQuG7N1Uidy+GBhZjPmRCnjBi7G9gWYoGbStNcYrQWpopp+Ar9NQeepEsqpK8/Qt1U+KpiAY0doww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1ttquA-000000007RN-0YXs;
	Sun, 16 Mar 2025 16:32:02 +0000
Date: Sun, 16 Mar 2025 16:31:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, ericwouds@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joseph.lin@airoha.com,
	wenshin.chung@airoha.com
Subject: Re: [PATCH v3 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <Z9b8_nz1Qqn8lNFW@makrotopia.org>
References: <20250316141900.50991-1-lucienX123@gmail.com>
 <20250316141900.50991-2-lucienX123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316141900.50991-2-lucienX123@gmail.com>

Hi Lucien,

nice work, this looks much better already.

As the PHY now becomes a clk provider, please also include
linux-clk@vger.kernel.org list among the receivers in Cc for future
iterations (but allow for at least 24h to pass before resending, so
others also have time to comment on this version).

On Sun, Mar 16, 2025 at 10:19:00PM +0800, Lucien.Jheng wrote:
> The EN8811H generates 25MHz or 50MHz clocks on its CKO pin, selected by GPIO3 hardware trap.
> Register 0xcf914, read via buckpbus API, shows the frequency with bit 12: 0 for 25MHz, 1 for 50MHz.
> CKO clock output is active from power-up through md32 firmware loading.

Nit: The lines of the patch description body are still too long.

> ...
> +static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
> +{
> +	struct clk_init_data init;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
> +
> +	init.name =  devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
> +				    fwnode_get_name(dev_fwnode(dev)));
> +	if (!init.name)
> +		return -ENOMEM;
> +
> +	init.ops = &en8811h_clk_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE;

The rate is fixed by bootstrap pins, so there is reason for not allowing
to cache the rate (which is always going to be the same). Hence I
suggest to not set the CLK_GET_RATE_NOCACHE flag.

