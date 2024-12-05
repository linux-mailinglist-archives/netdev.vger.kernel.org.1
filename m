Return-Path: <netdev+bounces-149345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E45D9E5334
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403131673D5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882045FEE4;
	Thu,  5 Dec 2024 10:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBF1D90B1
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396356; cv=none; b=hRpbvhmFQqRKDag55BIwLXPpj1J1YdLqU5N8LgyRHZYtm8kZ3vpsscGWIM4EC/y9O+2jslzuGKk9DsTbcnkHdZO3fthRefbzxvhB6tGMpDGYCrdiiDfCqhoohGF8dlKH6tHRDXtAehwlehN97krV8aa4MgDpoRUH3bKmUktV6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396356; c=relaxed/simple;
	bh=sxy8RMO6UamzIVIj4MzFK3U1aIDo1klLe+1eQR0qPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS+mRBO1ml1dySMZde06MSw3diDrip2n77bxZ5xrt6ZzliniHdjt66+X6X+my5YTUVjLDIdF5kSRXZicqmbtVwQWVmLyy3QuVFYSI92CIHUGGEbp1VUdqKhTa0T40wrIoFV50dLVG8ShK5ztp7nHfrIHhqtnn9+ldjN1kcqRxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tJ9ZV-0003Sx-0T; Thu, 05 Dec 2024 11:59:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJ9ZS-001oGe-1u;
	Thu, 05 Dec 2024 11:58:59 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJ9ZT-00GQo3-0o;
	Thu, 05 Dec 2024 11:58:59 +0100
Date: Thu, 5 Dec 2024 11:58:59 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 6/7] phy: dp83td510: add statistics support
Message-ID: <Z1GHczyyzDFkV592@pengutronix.de>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-7-o.rempel@pengutronix.de>
 <57a7b3bf-02fa-4b18-bb4b-b11245d3ebfb@intel.com>
 <20241205-satisfied-gerbil-of-cookies-471293-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-satisfied-gerbil-of-cookies-471293-mkl@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Dec 05, 2024 at 10:01:10AM +0100, Marc Kleine-Budde wrote:
> On 05.12.2024 09:43:34, Mateusz Polchlopek wrote:
> > 
> > 
> > On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
> > > Add support for reporting PHY statistics in the DP83TD510 driver. This
> > > includes cumulative tracking of transmit/receive packet counts, and
> > > error counts. Implemented functions to update and provide statistics via
> > > ethtool, with optional polling support enabled through `PHY_POLL_STATS`.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >   drivers/net/phy/dp83td510.c | 98 ++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 97 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> > > index 92aa3a2b9744..08d61a6a8c61 100644
> > > --- a/drivers/net/phy/dp83td510.c
> > > +++ b/drivers/net/phy/dp83td510.c
> > > @@ -34,6 +34,24 @@
> > >   #define DP83TD510E_CTRL_HW_RESET		BIT(15)
> > >   #define DP83TD510E_CTRL_SW_RESET		BIT(14)
> > > +#define DP83TD510E_PKT_STAT_1			0x12b
> > > +#define DP83TD510E_TX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
> > > +
> > > +#define DP83TD510E_PKT_STAT_2			0x12c
> > > +#define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
> > 
> > Shouldn't it be GENMASK(31, 16) ? If not then I think that macro
> > name is a little bit misleading
> 
> Yes, the name may be a bit misleading...

The naming is done according to the chip datasheet. This is preferable
way to name defines.

> [...]
> 
> > > + */
> > > +static int dp83td510_update_stats(struct phy_device *phydev)
> > > +{
> > > +	struct dp83td510_priv *priv = phydev->priv;
> > > +	u64 count;
> > > +	int ret;
> > > +
> > > +	/* DP83TD510E_PKT_STAT_1 to DP83TD510E_PKT_STAT_6 registers are cleared
> > > +	 * after reading them in a sequence. A reading of this register not in
> > > +	 * sequence will prevent them from being cleared.
> > > +	 */

this comment is relevant for the following question by Marc.

> > > +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_1);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	count = FIELD_GET(DP83TD510E_TX_PKT_CNT_15_0_MASK, ret);
> > > +
> > > +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_2);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	count |= (u64)FIELD_GET(DP83TD510E_TX_PKT_CNT_31_16_MASK, ret) << 16;
> > 
> > Ah... here you do shift. I think it would be better to just define
> > 
> > #define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(31, 16)
> 
> No. This would not be the same.
> 
> The current code takes the lower 16 bit of "ret" and shifts it left 16
> bits.
> 
> As far as I understand the code DP83TD510E_PKT_STAT_1 contain the lower
> 16 bits, while DP83TD510E_PKT_STAT_2 contain the upper 16 bits.
> 
> DP83TD510E_PKT_STAT_1 gives 0x????aaaa
> DP83TD510E_PKT_STAT_2 gives 0x????bbbb
> 
> count will be 0xbbbbaaaa
> 
> This raises another question: Are these values latched?
> 
> If not you can get funny results if DP83TD510E_PKT_STAT_1 rolls over. On
> unlatched MMIO busses you first read the upper part, then the lower,
> then the upper again and loop if the value of the upper part changed in
> between. Not sure how much overhead this means for the slow busses.
> 
> Consult the doc of the chip if you can read both in one go and if the
> chip latches these values for that access mode.

It is not documented, what is documented is that PKT_STAT_1 to
PKT_STAT_3 should be read in sequence to trigger auto clear function of
this registers. If chip do not latches these values, we will have
additional problem - some counts will be lost in the PKT_STAT_1/2 till we with
PKT_STAT_3 will be done.

With other words, I'll do more testing and add corresponding comments in
the code..
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

