Return-Path: <netdev+bounces-107848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D73E91C8F5
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 00:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95361F2762D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBEC80BF7;
	Fri, 28 Jun 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URvGmxRW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AC7E57F;
	Fri, 28 Jun 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612769; cv=none; b=CFGBauCGQN1APatE88kI20VwDrysil6JFQva9JjFQ0Gj65Qd6TVWAhJEi0JmAlB1rUoSmXRrV6kyujRhSrDwnzEtcHCSYNmRBG92oqwP6Bq3zsTUNMjPA2H5sA0BM13TIynZq5zmLlRZCn1WgEVXIOlWGh2dqdyq7kVk8ip5UyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612769; c=relaxed/simple;
	bh=AyisUTH6Ol1mb1jrlE0aMiW6gf83ZXx6hkss3LG5i/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEF9rOIqAFH7t7mcUabqrPGVLFp5wIgIi2zZbol7qWG/UdSafhNP5i/ldVBjlfK5Wk4mAYwegnjLAMSyBlVCOeEOdkMoBg7zOXzGRLNmb/4n5YMV6cWdReM9L6TY7e/MhynONSstqvXA0JUJcPB+/NzOcwUcIh7HwlboIXdx0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URvGmxRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD8C116B1;
	Fri, 28 Jun 2024 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719612769;
	bh=AyisUTH6Ol1mb1jrlE0aMiW6gf83ZXx6hkss3LG5i/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URvGmxRWPzOuC2Z1GL011/xd9Zr8GFj7+4PjTus12MhMkaPcgoJabZK7FKyAtvnxL
	 knElPOgi15X4njF8T++B5ljJJkzH/FUiaXUyOGYCVOIS0gY8U9KOKIv9Qm1y225JNZ
	 35htzufXm7da+xXZcroUOpkdfOnvreY5oSJZjRoPjutvre9KLXxdVPN5bP1IKQaubV
	 v9Cr3yPokQR0zo5ycCb9f+yfH4CuHcqSQo/Tlxq5tlJ6icsDB+h/5hk62f5SYDc8X7
	 7SHStzB2rcJKwemgvPqWoNSUZ/P618druhC0UK04RTJ6+JBQU6T5EDaez33cQt7Hcl
	 j7SGDlML3bk8g==
Date: Fri, 28 Jun 2024 16:12:46 -0600
From: Rob Herring <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <20240628221246.GA296233-robh@kernel.org>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-7-fancer.lancer@gmail.com>
 <20240627-hurry-gills-19a2496797f3@spud>
 <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5mqaztxz62b7jktr47mojjrz7ht5m4ou4mqsxtozpp3xba7e4@uh7v5zn2pbn2>

On Thu, Jun 27, 2024 at 08:10:48PM +0300, Serge Semin wrote:
> On Thu, Jun 27, 2024 at 04:51:22PM +0100, Conor Dooley wrote:
> > On Thu, Jun 27, 2024 at 03:41:26AM +0300, Serge Semin wrote:
> > > +  clocks:
> > > +    description:
> > > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > > +      source connected via the clk_csr_i line.
> > > +
> > > +      PCS/PMA layer can be clocked by an internal reference clock source
> > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > > +      generator. Both clocks can be supplied at a time.
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +
> > > +  clock-names:
> > > +    oneOf:
> > > +      - minItems: 1
> > > +        items:
> > > +          - enum: [core, pad]
> > > +          - const: pad
> > > +      - minItems: 1
> > > +        items:
> > > +          - const: pclk
> > > +          - enum: [core, pad]
> > > +          - const: pad
> > 
> 
> > While reading this, I'm kinda struggling to map "clk_csr_i" to a clock
> > name. Is that pclk? And why pclk if it is connected to "clk_csr_i"?
> 
> Right. It's "pclk". The reason of using the "pclk" name is that it has
> turned to be a de-facto standard name in the DT-bindings for the
> peripheral bus clock sources utilized for the CSR-space IO buses.
> Moreover the STMMAC driver responsible for the parental DW *MAC
> devices handling also has the "pclk" name utilized for the clk_csr_i
> signal. So using the "pclk" name in the tightly coupled devices (MAC
> and PCS) for the same signal seemed a good idea.

It is? That's really just the name of the bus clock for APB (Arm 
Peripheral Bus). If there's a name that matches the docs, use that. 
Though I'd drop 'clk_' part.

Rob

