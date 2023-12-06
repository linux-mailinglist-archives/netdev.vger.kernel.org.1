Return-Path: <netdev+bounces-54485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11593807407
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B7A281E2F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3145975;
	Wed,  6 Dec 2023 15:54:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C894D1A2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:54:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rAuEU-0005eJ-Fi; Wed, 06 Dec 2023 16:54:42 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rAuES-00DzeT-4b; Wed, 06 Dec 2023 16:54:40 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rAuES-005aMs-1i; Wed, 06 Dec 2023 16:54:40 +0100
Date: Wed, 6 Dec 2023 16:54:40 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231206155440.GA1324895@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
 <20231206085520.GA1293736@pengutronix.de>
 <20231206151406.75eglqtsrrb4vegf@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206151406.75eglqtsrrb4vegf@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Dec 06, 2023 at 05:14:06PM +0200, Vladimir Oltean wrote:
> On Wed, Dec 06, 2023 at 09:55:20AM +0100, Oleksij Rempel wrote:
> > On Thu, Nov 23, 2023 at 11:52:57AM +0100, Paolo Abeni wrote:
> > > Hi,
> > > 
> > > On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> > > > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > > > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > > > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > > > for both chip variants, which is actually for LED configuration. This
> > > > update ensures the correct registers and bits are used for the PHY
> > > > loopback feature:
> > > > 
> > > > - For KSZ8794: Use 0xF / Bit 7.
> > > > - For KSZ8873: Use 0xD / Bit 0.
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > 
> > > This looks like a bugfix, so possibly worth a Fixes tag? Given the
> > > dependency on the previous refactor, I think we can take it via net-
> > > next.
> > > 
> > > @Andrew, Florian, Vladimir: do you have any specific preference here?
> > 
> > I do not think any one cares about supporting this switch variant in
> > stable :)
> > 
> > Regards,
> > Oleksij
> 
> Sorry, this simply fell through the cracks.
> 
> How is PHY loopback even supposed to be triggered? User space flips
> NETIF_F_LOOPBACK on the netdev, driver ndo_set_features() catches it and
> calls phy_loopback() and this calls into phylib's phydev->drv->set_loopback()
> or the generic genphy_loopback()?

correct.

> I don't see DSA implementing ndo_set_features(), nor offering NETIF_F_LOOPBACK.
> The PHY is integrated, so DSA is the only relevant netdev driver. Is
> there any other way to test this functionality?

yes - net_selftest()

> If not, I think it's a case of "tree falling in the woods and nobody
> hearing it". Not "stable" material. But it definitely has nothing to do
> with not caring about the switch variant.

Sorry, my intention is not to criticize anyone. I am not getting
feedbacks or bug reports for ksz88xx variants, so it seems like not many
people use it in upstream.

When I have time slots to work on this driver, I try to use them to do
fixes and also clean up the code. Since there is some sort of fog of
uncertainty about when I get the next time slot, or even if I get it at
all, I am trying to push both fixes and cleanups together.

But, you are right, it is not a good reason for not caring about stable :)

What is the decision about this patch set?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

