Return-Path: <netdev+bounces-161343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D1AA20C6E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D55A167409
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B31A7249;
	Tue, 28 Jan 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bQv7y2Vk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE51199EAD;
	Tue, 28 Jan 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076423; cv=none; b=DJo/JCbE5X9DCQhMCx0IvXjHzdFk9Q6XeEAsFrP5H3FW92vFy1s1CjDr/0UIm6ApL20EMhETQVDdzey4hXsKxerBi3/ngtjsTaXqQM2EmJ30sG7XHvWBbxuwyhSWOi7mwZmpbEABFoxS2HvV+lBP12lSJZrjApTpIc81uEdpueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076423; c=relaxed/simple;
	bh=QRfiqBpEw7/liJXDoioKBx1vNw67bwXhn1uGoicqW/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cATf9E1crkMT+8bi95olDJWxdX7kG/OZ9UzRvQHgaO8z/QFz6fCL3Pc2Cbhlcz9L3VNCPnJc0bsfz2Dj2Ilqv/J/nwB0ftAhpxu5bLIb6He/jUlXRu0P24qhEu8YHXL+x3Koy8MLM70qiNUNo3BnyX+GGOVzajnjQxGYtTAyxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bQv7y2Vk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U0y1/5KjujPLLYN0/a/OAGfW6wEftE6jNU0MO4+5f08=; b=bQv7y2Vk//g3H/hdiNSHTo2fkb
	5rkNlvgrieDxx2+XrUXeykAh16ZYPuQonhyRvcDlXZsibeVKZvw2rQ3A5ChZeTW7Dr7a6HXQqgpq0
	M7mg8suoSySCT1qYG1uG5Io1T5I24Ouk19C7lxE/mlrQdHQnnBBMPFWVinUc3qbge6w/C5LkkGbQa
	VnIjA6fBz6nq28N+1C0LEe6Jq12INu+vt++UroH0nqdRrZwFJysb9SkDhcguTxTfn9PBzFSWY45zD
	MTt3IGISTU3pufnRvMhep54CEt8+V4mqWdyWEhat0v3dlLWKeW/jLeI0C8zjY+GetUnXM5jLl/PYc
	zcOGnM0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tcn4Q-0007Nk-0L;
	Tue, 28 Jan 2025 15:00:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tcn4I-0002jM-0z;
	Tue, 28 Jan 2025 14:59:58 +0000
Date: Tue, 28 Jan 2025 14:59:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, andrew@lunn.ch, alim.akhtar@samsung.com,
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
Message-ID: <Z5jw7pUXEoGjLtgP@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 28, 2025 at 03:55:56PM +0530, Swathi K S wrote:
> +struct fsd_eqos_plat_data {
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	struct device *dev;

You only write to this, so it serves no purpose in this patch. Please
remove.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

