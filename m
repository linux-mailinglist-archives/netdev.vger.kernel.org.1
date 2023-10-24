Return-Path: <netdev+bounces-43893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070597D53A6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364BB1C20B88
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164362B77B;
	Tue, 24 Oct 2023 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2wTaohei"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3129437;
	Tue, 24 Oct 2023 14:08:45 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1193A3;
	Tue, 24 Oct 2023 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eDhesMhiwtf5oRFEe0tcbmQl0LJ8NdA55Y6empsfy2E=; b=2wTaoheinvFFan+20dLH3nGj5o
	mtfWlWEKM8LyBNDOp+/JH7uDIycqEZtgXmeSlPZk3qP5zsH7TMOjFNf4ytimoM16XLKvRbaSVybhL
	3ojnbBDMDu0/yiXSz7A5Xgu/xZi7OwNLheXWaf/4b7wdxXlzWMd9ZrOUMM17ZI35SsPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qvI59-0004xO-Ki; Tue, 24 Oct 2023 16:08:31 +0200
Date: Tue, 24 Oct 2023 16:08:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
Message-ID: <932bef01-b498-4c1a-a7f4-3357fe94e883@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-4-romain.gantois@bootlin.com>
 <b8ac3558-b6f0-4658-b406-8ceba062a52c@lunn.ch>
 <f4e6dcee-23cf-bf29-deef-cf876e63bb8a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e6dcee-23cf-bf29-deef-cf876e63bb8a@bootlin.com>

> > > +	for (c = 0; c < priv->info->mib_count; c++) {
> > > +		mib = &ar8327_mib[c];
> > > +		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
> > > +
> > > +		ret = qca8k_read(priv, reg, &val);
> > > +		if (ret < 0)
> > > +			continue;
> > 
> > Given the switch is built in, is this fast? The 8k driver avoids doing
> > register reads for this.
> 
> Sorry, I don't quite understand what you mean. Are you referring to the existing 
> QCA8k DSA driver? From what I've seen, it calls qca8k_get_ethtool_stats defined 
> in qca8k-common.c and this uses the same register read.

It should actually build an Ethernet frame containing a command to get
most of the statistics in one operation. That frame is sent to the
switch over the SoCs ethernet interface. The switch replies with a
frame containing the statistics. This should be faster than doing lots
of register reads over a slow MDIO bus.

Now, given that this switch is built into the SoC, i assume the MDIO
bus is gone, so register access is fast. So you don't need to use
Ethernet frames.

	 Andrew

