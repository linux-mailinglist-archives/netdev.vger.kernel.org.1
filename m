Return-Path: <netdev+bounces-54735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7E80800C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99D0B20575
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CAD107B3;
	Thu,  7 Dec 2023 05:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895DD44
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 21:15:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rB6j2-0007mN-LF; Thu, 07 Dec 2023 06:15:04 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rB6j0-00E7QO-Lq; Thu, 07 Dec 2023 06:15:02 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rB6j0-005f4k-Iq; Thu, 07 Dec 2023 06:15:02 +0100
Date: Thu, 7 Dec 2023 06:15:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231207051502.GB1324895@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231207002823.2qx24nxjhn6e43w4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207002823.2qx24nxjhn6e43w4@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Dec 07, 2023 at 02:28:23AM +0200, Vladimir Oltean wrote:
> On Tue, Nov 21, 2023 at 04:24:26PM +0100, Oleksij Rempel wrote:
> > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > for both chip variants, which is actually for LED configuration. This
> > update ensures the correct registers and bits are used for the PHY
> > loopback feature:
> > 
> > - For KSZ8794: Use 0xF / Bit 7.
> > - For KSZ8873: Use 0xD / Bit 0.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> 
> How did you find, and how did you test this, and on which one of the switches?

I tested it by using "ethtool -t lanX" command on KSZ8873. Before this
patch the link will stop to work _after_ end of the selftest. The
selftest will fail too.

After this patch, the selftest is passed, except of the TCP test. And
link is working _after_ the selftest,

> Opening the KSZ8873 datasheet, I am confused about their description of
> the "far-end loopback". They make it sound as if this loops the packets
> _received_ from the media side of PHY port A back to the transmit side
> of PHY port A. But the route that these packets take is through the MAC
> of PHY port A, then the switching fabric, then PHY port B which reflects
> them back to PHY port A, where they finally egress.
> 
> Actually, they even go as far as saying that if you set the loopback bit
> of port 1, the packets that will be looped back will be from port 2's
> RXP/RXM to TXP/TXM pins, and viceversa.
> 
> If true, I believe this isn't the behavior expected by phy_loopback(),
> where the TX signals from the media side of the PHY are looped back into
> the RX side.
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

