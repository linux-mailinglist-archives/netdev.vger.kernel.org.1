Return-Path: <netdev+bounces-26474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A6777EA2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E9A2821DA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233520CB8;
	Thu, 10 Aug 2023 16:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235971E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:52:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28910C4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Seofgw310bBlx/zof7bIYzosrMYlGHkFMAaFE8li1fo=; b=xfwRdF/p83RBvMIfVXbrfFPU9n
	TuYqxWlPQiyvW2/pb0MpplZpMsljuOcWnH5/ivtvSn+jHCds7hWVbjWnXtA0UMEbVWNsmNddgGhWY
	+SNi2U/sgp1bH5o6UZIslQmB/TzbbT9QLVt+Dni1lEwxbrL+UHJB0b1tl9YRoQFmLUP7L4JTVx/ZI
	qNT/oy0xQfGxOR6PMQnzWQrnjYH4TogxAwzqXu0OdXf1t0S0ANTuOrHq84e+5RRtGsqga+kCta2jz
	adBDM7ZI75wvktcA+ADPECTCSpZklzTLuR7MEWDVFFiFcESOXmxzstApWLRC4Sok40wjj8FB3gHhZ
	Il1Zn+yQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57798)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU8tt-0004IF-2q;
	Thu, 10 Aug 2023 17:52:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU8tt-0001yE-BF; Thu, 10 Aug 2023 17:52:41 +0100
Date: Thu, 10 Aug 2023 17:52:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk>
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <20230810164441.udjyn7avp3afcwgo@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810164441.udjyn7avp3afcwgo@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 07:44:41PM +0300, Vladimir Oltean wrote:
> Hi Russell,
> 
> On Wed, Aug 09, 2023 at 03:46:03PM +0100, Russell King (Oracle) wrote:
> > Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
> > This is a fast ethernet switch, with internal PHYs for ports 0 through
> > 4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
> > MII, REVMII, REVRMII and SNI without an internal PHY.
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Sergei,
> > 
> > Would it be possible for you to check that this patch works with your
> > setup please?
> > 
> > Thanks!
> > 
> >  drivers/net/dsa/mv88e6060.c | 46 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
> > index fdda62d6eb16..0e776be5e941 100644
> > --- a/drivers/net/dsa/mv88e6060.c
> > +++ b/drivers/net/dsa/mv88e6060.c
> > @@ -247,11 +247,57 @@ mv88e6060_phy_write(struct dsa_switch *ds, int port, int regnum, u16 val)
> >  	return reg_write(priv, addr, regnum, val);
> >  }
> >  
> > +static void mv88e6060_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				       struct phylink_config *config)
> > +{
> > +	unsigned long *interfaces = config->supported_interfaces;
> > +	struct mv88e6060_priv *priv = ds->priv;
> > +	int addr = REG_PORT(port);
> > +	int ret;
> > +
> > +	ret = reg_read(priv, addr, PORT_STATUS);
> > +	if (ret < 0) {
> > +		dev_err(ds->dev,
> > +			"port %d: unable to read status register: %pe\n",
> > +			port, ERR_PTR(ret));
> > +		return;
> > +	}
> > +
> > +	if (!(ret & PORT_STATUS_PORTMODE)) {
> > +		/* Port configured in SNI mode (acts as a 10Mbps PHY) */
> > +		config->mac_capabilities = MAC_10 | MAC_SYM_PAUSE;
> > +		/* I don't think SNI is SMII - SMII has a sync signal, and
> > +		 * SNI doesn't.
> > +		 */
> > +		__set_bit(PHY_INTERFACE_MODE_SMII, interfaces);
> 
> I don't think that SNI == SMII either.
> 
> From what I could gather (datasheets of implementations in the wild,
> rather than any official spec):
> KSZ8895: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8895MQX-RQX-FQX-MLX-Integrated-5-Port-10-100-Managed-Ethernet-Switch-with-MII-RMII-Interface-DS00002246C.pdf
> DP83910A: https://www.ti.com/lit/ds/symlink/dp83910a.pdf
> RTL8201BL: https://file.elecfans.com/web1/M00/9A/9F/pIYBAF0fDAuANJTlAAqoYDastvw919.pdf
> 
> SNI (7-wire Serial Network Interface) has the same structural pin layout
> as the parallel MII/Rev-MII, except for the fact that RXD[3:0] and
> TXD[3:0] became RXD0 and TXD0, resulting in an effectively "serial"
> interface and reducing the baud rate of the 100 Mbps MII to a quarter,
> and the TX_CLK and RX_CLK signals also operate at a reduced 10 MHz
> rather than MII's 25 MHz, to provide a further 2.5x baud rate reduction
> down to 10 Mbps. It was a once popular (in the 1990s) interface mode
> between a MAC and a 10Mbps-only PHY.
> 
> If we compare that to SMII (Serial MII), I could only find this document here:
> https://opencores.org/ocsvn/smii/smii/trunk/doc/SMII.pdf
> 
> but it appears to be quite different. SMII seems to be a gasket/encapsulation
> module which serializes both the data and control signals of up to 4 10/100
> Mbps MACs, which can be connected to a quad SMII PHY. The resulting
> (cumulated, or individual) bandwidth is much larger than that of SNI, too.
> 
> The pinout of SMII is:
> - one RX and one TX signal for each MAC. Data transfer consists of
>   segments (10 serial bits on these lines). The bits in each segment are:
>   RX direction: CRS, RX_DV, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7
>   TX direction: TX_ER, TX_EN, TXD0, TXD1, TXD2, TXD3, TXD4, TXD5, TXD6, TXD7
> - SYNC: denotes the beginning of a new segment
> - CLK: denotes the beginning of a new bit
> 
> So, I guess we have to introduce PHY_INTERFACE_MODE_SNI rather than
> pretend it is the same as SMII.

I wonder whether we have any implementation using SNI mode. I couldn't
find anything in the in-kernel dts files for this driver, the only
dts we have is one that was posted on-list recently, and that was using
MII at 100Mbps:

https://lore.kernel.org/r/CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com

No one would be able to specify "sni" in their dts, so maybe for the
sake of simplicity, we shouldn't detect whether it's in SNI mode, and
just use MII, and limit the speed to just 10Mbps?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

