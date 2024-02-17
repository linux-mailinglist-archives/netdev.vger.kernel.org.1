Return-Path: <netdev+bounces-72621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC37858D8C
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 07:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BE2282C1D
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80F1B28D;
	Sat, 17 Feb 2024 06:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403F23D0
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708152453; cv=none; b=vDFtrVEdJ++Kxml6eBBSu55BxnZuRPVHhfL+P62RdfJQcpUo/z/ANtqTuTnLhKa37gzBVhO8pKHfX5pv9rGqgDAyfBAfFy0zqNQtEqH29332112C7fGUgprxhb3pk5+Z+ewP29RaXwdcBeLkktP11qBQbM0UXRyvokBGV4o2R0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708152453; c=relaxed/simple;
	bh=vct0oM2xD8QMdRPrjg/MRpA2z2oOXKzf3lvCs+WHSlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKpS162JVouwNatu7TMAZn6JoIJ6J+nbJw8MD29JILzCQ0nANU2+1RrZjOLR5w/4dzrGJMl0bmfK41ms915HDnYnSferuA/ithdb9xpo9R8WBr9s8YYHUPL3+oq4RzAi3EXAdOLFD4DbFQcE+QAy7JDwcwQIIzKBrIc0OIGQEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rbETO-0000dn-DO; Sat, 17 Feb 2024 07:46:54 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rbETJ-001DUW-My; Sat, 17 Feb 2024 07:46:49 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rbETJ-00CtWH-1w;
	Sat, 17 Feb 2024 07:46:49 +0100
Date: Sat, 17 Feb 2024 07:46:49 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <ZdBWWXSgFIDSgn7P@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
 <ZciUQqjM4Z8Tc6Db@pengutronix.de>
 <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
 <Zc3IrO_MXIdLXnEL@pengutronix.de>
 <65099b67-b7dc-4d78-ba42-d550aae2c31e@lunn.ch>
 <Zc8TAojumif1irE-@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc8TAojumif1irE-@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

Can you please integrated this new insights to the PSE PI documentation.
Instead of 1000BaseT only, please use 1000/2.5G/5G/10GBASE-T as
documented in the spec.

On Fri, Feb 16, 2024 at 08:47:14AM +0100, Oleksij Rempel wrote:
> On Thu, Feb 15, 2024 at 06:51:55PM +0100, Andrew Lunn wrote:
> > > Hm.. good question. I didn't found the answer in the spec. By combining all
> > > puzzle parts I assume, different Alternative configurations are designed
> > > to handle conflict between "PSE Physical Layer classification" and PHY
> > > autoneg.
> > > 
> > > Here is how multi-pulse Physical Layer classification is done:
> > > https://img.electronicdesign.com/files/base/ebm/electronicdesign/image/2020/07/Figure_5.5f2094553a61c.png
> > > 
> > > this is the source:
> > > https://www.electronicdesign.com/technologies/power/whitepaper/21137799/silicon-labs-90-w-power-over-ethernet-explained
> > > 
> > > To avoid classification conflict with autoneg. Assuming, PHY on PD side
> > > will be not powered until classification is completed. The only source
> > > of pulses is the PHY on PSE side (if it is not under control of software
> > > on PSE side or Midspan PSE is used), so aneg pulses should be send on
> > > negative PoE pair? This all is just speculation, I would need to ask
> > > some expert or do testing.
> > > 
> > > If this assumption is correct, PHY framework will need to know exact
> > > layout of MDI-X setting and/or silent PHY until PSE classification is done.
> > 
> > Ideally, we don't want to define a DT binding, and then find it is
> > wrong for 1000BaseT and above and we need to change it.
> >
> > So, either somebody needs to understand 1000BaseT and can say the
> > proposed binding works, or we explicitly document the binding is
> > limited to 10BaseT and 100BaseT.
> 
> I asked the internet and found the answer: Some PSE/PD implementations
> are not compatible with 1000BaseT.
> 
> See Figure 33–4—10BASE-T/100BASE-TX Endpoint PSE location overview.
> Alternative B show a variant where power is injected directly to pairs
> without using magnetics as it is done for Alternative A (phantom
> delivery - over magnetics).
> 
> I assume, the reasoning for this kind of design is simple - price.
> Otherwise magnetics will have special requirements:
> https://www.coilcraft.com/de-de/edu/series/magnetics-for-power-over-ethernet/
> 
> So, we have following variants of 2 pairs PoE:
> +---------+---------------+-------------------+---------------------+--------------------+
> | Variant | Alternative   | Polarity          | Power Feeding Type  | Compatibility with |
> |         | (a/b)         | (Direct/Reverse)  | (Direct/Phantom)    | 1000BaseT          |
> +=========+===============+===================+=====================+====================+
> | 1       | a             | Direct            | Phantom             | Yes                |
> +---------+---------------+-------------------+---------------------+--------------------+
> | 2       | a             | Reverse           | Phantom             | Yes                |
> +---------+---------------+-------------------+---------------------+--------------------+
> | 3       | b             | Direct            | Phantom             | Yes                |
> +---------+---------------+-------------------+---------------------+--------------------+
> | 4       | b             | Reverse           | Phantom             | Yes                |
> +---------+---------------+-------------------+---------------------+--------------------+
> | 5       | b             | Direct            | Direct              | No                 |
> +---------+---------------+-------------------+---------------------+--------------------+
> | 6       | b             | Reverse           | Direct              | No                 |
> +---------+---------------+-------------------+---------------------+--------------------+
> 
> An advanced PSE may implement range of different variants direct in the PSE
> controller or with additional ICs in the PSE PI. The same is about PD.
> 
> Let's take as example PD-IM-7608M eval board:
> https://www.microchip.com/en-us/development-tool/PD-IM-7608M
> 
> According to the schematics:
> https://ww1.microchip.com/downloads/en/DeviceDoc/PD-IM-7608M.zip
> It supports only Variant 5 - Alternative B, with only one polarity,
> and direct feeding without magnetics.
> 
> The simple PD may support only one variant:
> https://community.fs.com/article/troubleshooting-poe-errors.html
> " the power modes of PSE and PD are other factors that may cause PoE
> faults. There are three PoE modes: Alternative A, alternative B, and
> 4-pair delivery. If a PD only supports PoE mode B power delivery, while
> a PoE switch is based on Alternative A, as a result, the PD and PoE
> switch can not work together."
> 
> For this case, it will be good if systems knows supported modes, so user
> can get this information  directly. For example with ethtool
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

