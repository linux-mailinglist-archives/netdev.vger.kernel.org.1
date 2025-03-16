Return-Path: <netdev+bounces-175143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8BA63758
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 21:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2316BB7E
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D748635D;
	Sun, 16 Mar 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yI54AagB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788C4A1E;
	Sun, 16 Mar 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742156178; cv=none; b=iFw/W1m98tHL7822Bx7mnWNK8bmI+S0NKtKRBUU/YCbp+55f3mZz7uwKtrz0ZZegtakZuG/611vM3sPx2riq6Bnc5QR0rqSD7aW8c45f5JTpsWCaLU33eisgRgaAWS+idJ5/JMN79v1b9s9AdAurUM1CHq8n87ruMvBsdmQhAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742156178; c=relaxed/simple;
	bh=s3IEVzJiIJzPMqECniQJY2egU2jkaIMn7rtXp2oSER0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz4KzaLb/C0W0vFlcZhtf2up2EOMUauHiErW2lDgV9LHpm1FEeZSHvuLVb5Uk6uAPaGznDP1dykKGTam2MwdT/vuKATLTFgQdoagGXvamgPrPZZrFmSQlSu3MOUyCw4tYonpeSdDQDnNSdF6QR7aeovI+yywgSlmXY4NMLf795Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yI54AagB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uN4vbjXlVG16Rnn7dawaAyEkuJP9unu6/jGTHQe3s/k=; b=yI54AagBAWG1eC+CfwHBTMNRXy
	PXJ4y8gnarN3QJeu7tG+yxLpH8d5+bR0FrVqncrWC+kbNtsf5QI3E+3w8Gtn1pseivgqPbYPgXPAJ
	thiAqjNUdIu6IXf847SCUt4Nt0bhE4rVCbfQlBEYImeiO/Tn814uJvW7LLRarb9JRYTA7qbYoDwwl
	VienZp8MuE50G1Dfhaf+/BGMSRq2XsemlVgKawXeXNJnzHKNb81PTBwHa2cTfmKdDSXCW8gLI0CTv
	0wQ6A0E7rtwwCzId2qQZUqiLVnwxmSUFGhc1hEXS5dRE4RR4bSFN0lq3aSvD/PbcuezIv27mwwq53
	VVRLkbLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42324)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ttuOu-0002jq-1W;
	Sun, 16 Mar 2025 20:16:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ttuOn-0002oy-0x;
	Sun, 16 Mar 2025 20:15:53 +0000
Date: Sun, 16 Mar 2025 20:15:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	daniel@makrotopia.org, ericwouds@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joseph.lin@airoha.com,
	wenshin.chung@airoha.com
Subject: Re: [PATCH v3 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <Z9cxeSm3sLTi2R-P@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 16, 2025 at 10:19:00PM +0800, Lucien.Jheng wrote:
> +#define to_en8811h_priv(_hw)			\
> +	container_of(_hw, struct en8811h_priv, hw)

Maybe better to call this "clk_hw_to_en8811h_priv()" ?

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

Given that this is the clk API, naming a clock with a "-clk" suffix
is redundant. Instead, consider something more descriptive. You say
this is the "CKO" output, so maybe "%s-cko" so that hardware reference
is included in the name.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

