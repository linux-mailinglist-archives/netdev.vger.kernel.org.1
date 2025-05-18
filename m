Return-Path: <netdev+bounces-191362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3683ABB23C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 00:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B157A6D21
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5F2066F7;
	Sun, 18 May 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u9It1wTn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DE17BA9;
	Sun, 18 May 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747607905; cv=none; b=TX3KqUS+jCnB1oekTuDoUHzA+Qebx9MOEZqi41a32cJj1CzKpLBI95bEC1CF0FV313YFQ44o+6AgOGeBRjtV7Ylw0NgdY1wEso/jYh0EOPLP378YRJfAjIuSiu2rD1JFPDgZuXRSHn6nYnaGxaThXI6rWLYVRH1fgVn47uP12yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747607905; c=relaxed/simple;
	bh=SrpRgtxQuJWqIgmTwM2Lg0ofoeubBOdmYiObl3GXdRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Seadkad/ER+swBt3UyNhFX4AbA2pDnMZBZSsKM8No26andlXrcOcBYlsUEUWXFMWIngBc1jto33ZDFM3AsVfTOdg02ntTKDy1TLr2+i8gRrTQiCxm8Qj9HpWXQhkuQ/vihwy4+b8+OKzkJ7tNf7bRZFx8iCTMKBS0+W3nRWxJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u9It1wTn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9PAtzibwPGzPsb2gvUMPS4izyL4nfJ85lKJcGMeMkIY=; b=u9It1wTng+n27k/Da9wot3ipbE
	nkgw93z5yood/RlJjxLZBNSayr0VihjFpH/DTgZN7LxwMLqSt+tX+zWsdW+hrzeOFHIPK7L/wJwSf
	JuxxLpQFWBMFnRxHoYOZgzGvYxQ/L6ebDJ39lmuxrWpq+EXU5WltIGdq21ljuvLHxrxk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGme5-00Cwv3-Rh; Mon, 19 May 2025 00:38:13 +0200
Date: Mon, 19 May 2025 00:38:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	yong.liang.choong@linux.intel.com, rmk+kernel@armlinux.org.uk,
	jszhang@kernel.org, inochiama@gmail.com, jan.petrous@oss.nxp.com,
	dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v1 1/2] ethernet: eswin: Document for eic7700 SoC
Message-ID: <c9f0cb9e-26e9-43cb-bf67-3fd27033f55c@lunn.ch>
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
 <20250516011040.801-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516011040.801-1-weishangjuan@eswincomputing.com>

> +  phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [mii, gmii, rgmii, rmii, sgmii]

In theory, all four rgmii modes should be listed. In practice, only
rgmii-id is likely to be used.

> +examples:
> +  - |
> +    gmac0: ethernet@50400000 {
> +        compatible = "eswin,eic7700-qos-eth";
> +        reg = <0x0 0x50400000 0x0 0x10000>;
> +        interrupt-parent = <&plic>;
> +        interrupt-names = "macirq";
> +        interrupts = <61>;
> +        phy-mode = "rgmii";

Please don't use rgmii in an example. It is probably wrong, unless you
have an unusual PCB design.

	Andrew

