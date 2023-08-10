Return-Path: <netdev+bounces-26472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F557777E89
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611341C21639
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CC20C97;
	Thu, 10 Aug 2023 16:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB081E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:44:47 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384E810C7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:44:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-997c4107d62so160607066b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691685884; x=1692290684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwK9Dnr3jssWp76IMF2PA3x2niqmsK0Q6CYGvBdegnE=;
        b=EKo+6czrhyiRCx+yARb8acyw72Bb5C7and6gQtUgrJNTreaZh7cT4iZYZk5UuCLVMX
         6gRCExNy/dNfOWdfd3y/puB0l1yhGGhYFzfOc0TOC0h6z4B5hb1XM4ihNg5CdiVens/z
         lZB8fjZCHkUx5W/o9YOk48IKn5TkXU7UqKMsbLAhHEr644vWPLvWh8TJQvacMCStumQa
         SjjfCifOE79QggovDehiVMHTEl6oiCTVqJRAtYtgLJE1GL0+HI6vuG2sl/YR6sMKXSPH
         v57BttqRkLhysYBRVvWApaUA960tF2NSOpH1kb9FLg8LoS8QSDHjts7jwmpziRfAWpEj
         AAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685884; x=1692290684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwK9Dnr3jssWp76IMF2PA3x2niqmsK0Q6CYGvBdegnE=;
        b=NgPEhCdGHU3UjpLLeqqe6RuISofwdmDycPBS7M1k94QGm0zqZ+In9sZFt4B+//Zsjl
         UHJ7QOLBYhb3yC7N++IJBas+q+TXZBpI6R4QSMansNtYwa6i3f51pacabujVGXhbJBc8
         ySkiqvt+Y052swWhiumad94/Vk70332hg81imiBg8D5X5MmbHYpLb/K7rEd9bjGUctBD
         p/zt10TVvWgPd39JJiOLS/I2jnLIYcncYZEC7eqcjVMZ5FCf2XNwomtrMpeh6dBVf0xT
         Usc36D3uNH/OAR31G5Q4S6dkCPpEB/FL0uqQHf+gkpW+aEItMxqz4RPVeeiX0SjxVh35
         yT7Q==
X-Gm-Message-State: AOJu0YxQfB7EURuedMVSXpsIDbpLllTaBJ+vB17zgoDXOnfH6tt9EhNA
	R3bFWdWoOl2HvE0KBohLWOY=
X-Google-Smtp-Source: AGHT+IEHbaQxyNQlEHviy18wBNpWtC2GGRZaUsaKSpJAAPKfZTYD34fSXgnaN++Fs1whJvkAXicTOg==
X-Received: by 2002:a17:906:5381:b0:99c:b46d:22da with SMTP id g1-20020a170906538100b0099cb46d22damr2509760ejo.46.1691685884398;
        Thu, 10 Aug 2023 09:44:44 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906950400b0099bd1a78ef5sm1150183ejx.74.2023.08.10.09.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:44:44 -0700 (PDT)
Date: Thu, 10 Aug 2023 19:44:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <20230810164441.udjyn7avp3afcwgo@skbuf>
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

On Wed, Aug 09, 2023 at 03:46:03PM +0100, Russell King (Oracle) wrote:
> Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
> This is a fast ethernet switch, with internal PHYs for ports 0 through
> 4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
> MII, REVMII, REVRMII and SNI without an internal PHY.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Sergei,
> 
> Would it be possible for you to check that this patch works with your
> setup please?
> 
> Thanks!
> 
>  drivers/net/dsa/mv88e6060.c | 46 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
> index fdda62d6eb16..0e776be5e941 100644
> --- a/drivers/net/dsa/mv88e6060.c
> +++ b/drivers/net/dsa/mv88e6060.c
> @@ -247,11 +247,57 @@ mv88e6060_phy_write(struct dsa_switch *ds, int port, int regnum, u16 val)
>  	return reg_write(priv, addr, regnum, val);
>  }
>  
> +static void mv88e6060_phylink_get_caps(struct dsa_switch *ds, int port,
> +				       struct phylink_config *config)
> +{
> +	unsigned long *interfaces = config->supported_interfaces;
> +	struct mv88e6060_priv *priv = ds->priv;
> +	int addr = REG_PORT(port);
> +	int ret;
> +
> +	ret = reg_read(priv, addr, PORT_STATUS);
> +	if (ret < 0) {
> +		dev_err(ds->dev,
> +			"port %d: unable to read status register: %pe\n",
> +			port, ERR_PTR(ret));
> +		return;
> +	}
> +
> +	if (!(ret & PORT_STATUS_PORTMODE)) {
> +		/* Port configured in SNI mode (acts as a 10Mbps PHY) */
> +		config->mac_capabilities = MAC_10 | MAC_SYM_PAUSE;
> +		/* I don't think SNI is SMII - SMII has a sync signal, and
> +		 * SNI doesn't.
> +		 */
> +		__set_bit(PHY_INTERFACE_MODE_SMII, interfaces);

I don't think that SNI == SMII either.

From what I could gather (datasheets of implementations in the wild,
rather than any official spec):
KSZ8895: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8895MQX-RQX-FQX-MLX-Integrated-5-Port-10-100-Managed-Ethernet-Switch-with-MII-RMII-Interface-DS00002246C.pdf
DP83910A: https://www.ti.com/lit/ds/symlink/dp83910a.pdf
RTL8201BL: https://file.elecfans.com/web1/M00/9A/9F/pIYBAF0fDAuANJTlAAqoYDastvw919.pdf

SNI (7-wire Serial Network Interface) has the same structural pin layout
as the parallel MII/Rev-MII, except for the fact that RXD[3:0] and
TXD[3:0] became RXD0 and TXD0, resulting in an effectively "serial"
interface and reducing the baud rate of the 100 Mbps MII to a quarter,
and the TX_CLK and RX_CLK signals also operate at a reduced 10 MHz
rather than MII's 25 MHz, to provide a further 2.5x baud rate reduction
down to 10 Mbps. It was a once popular (in the 1990s) interface mode
between a MAC and a 10Mbps-only PHY.

If we compare that to SMII (Serial MII), I could only find this document here:
https://opencores.org/ocsvn/smii/smii/trunk/doc/SMII.pdf

but it appears to be quite different. SMII seems to be a gasket/encapsulation
module which serializes both the data and control signals of up to 4 10/100
Mbps MACs, which can be connected to a quad SMII PHY. The resulting
(cumulated, or individual) bandwidth is much larger than that of SNI, too.

The pinout of SMII is:
- one RX and one TX signal for each MAC. Data transfer consists of
  segments (10 serial bits on these lines). The bits in each segment are:
  RX direction: CRS, RX_DV, RXD0, RXD1, RXD2, RXD3, RXD4, RXD5, RXD6, RXD7
  TX direction: TX_ER, TX_EN, TXD0, TXD1, TXD2, TXD3, TXD4, TXD5, TXD6, TXD7
- SYNC: denotes the beginning of a new segment
- CLK: denotes the beginning of a new bit

So, I guess we have to introduce PHY_INTERFACE_MODE_SNI rather than
pretend it is the same as SMII.

The rest looks ok (but, as SNI is a 10Mbps only interface, you could, in
v2, populate config->mac_capabilities in a common code path to MAC_100 |
MAC_10, and let phylink_get_capabilities() reduce it).

pw-bot: cr

> +		return;
> +	}
> +
> +	config->mac_capabilities = MAC_100 | MAC_10 | MAC_SYM_PAUSE;
> +
> +	if (port >= 4) {
> +		/* Ports 4 and 5 can support MII, REVMII and REVRMII modes */
> +		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_REVRMII, interfaces);
> +	}
> +	if (port <= 4) {
> +		/* Ports 0 to 3 have internal PHYs, and port 4 can optionally
> +		 * use an internal PHY.
> +		 */
> +		/* Internal PHY */
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL, interfaces);
> +		/* Default phylib interface mode */
> +		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
> +	}
> +}
> +
>  static const struct dsa_switch_ops mv88e6060_switch_ops = {
>  	.get_tag_protocol = mv88e6060_get_tag_protocol,
>  	.setup		= mv88e6060_setup,
>  	.phy_read	= mv88e6060_phy_read,
>  	.phy_write	= mv88e6060_phy_write,
> +	.phylink_get_caps = mv88e6060_phylink_get_caps,
>  };
>  
>  static int mv88e6060_probe(struct mdio_device *mdiodev)
> -- 
> 2.30.2
> 


