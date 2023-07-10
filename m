Return-Path: <netdev+bounces-16617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A774E034
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4C82812E0
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C2156F3;
	Mon, 10 Jul 2023 21:27:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC2156E6
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:27:02 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B8DE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:26:59 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 23205209ED;
	Mon, 10 Jul 2023 23:26:57 +0200 (CEST)
Date: Mon, 10 Jul 2023 23:26:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, francesco.dolcini@toradex.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <ZKx3nyiSm73G70Oo@francesco-nb.int.toradex.com>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-5-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710205900.52894-5-eichest@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:59:00PM +0200, Stefan Eichenberger wrote:
> Add a driver for the Marvell 88Q2110. This driver is minimalistic, but
> already allows to detect the link, switch between 100BASE-T1 and
> 1000BASE-T1 and switch between master and slave mode. Autonegotiation
> supported by the PHY is not yet implemented.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

...

> +static int mv88q2xxx_read_link(struct phy_device *phydev)
> +{
> +	u16 ret1, ret2;
> +
> +	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
> +	 * therefore we need to read the link status from the vendor specific
> +	 * registers.
> +	 */
> +	if (phydev->speed == SPEED_1000) {
> +		/* Read twice to clear the latched status */
> +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> +		/* Read vendor specific Auto-Negotiation status register to get
> +		 * local and remote receiver status
> +		 */
> +		ret2 = phy_read_mmd(phydev, MDIO_MMD_AN, 0x8001);
> +	} else {
> +		/* Read vendor specific status registers, the registers are not
> +		 * documented but they can be found in the Software
> +		 * Initialization Guide
> +		 */
> +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8109);
> +		ret2 = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8108);
> +	}
you are ignoring errors from phy_read_mmd() here

> +
> +	/* Check the link status according to Software Initialization Guide */
> +	return (0x0 != (ret1 & 0x0004)) && (0x0 != (ret2 & 0x3000)) ? 1 : 0;
> +}
> +
> +static int mv88q2xxx_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	phydev->link = mv88q2xxx_read_link(phydev);
> +
> +	ret = genphy_c45_read_pma(phydev);
> +	if (ret)
> +		return ret;
return genphy_c45_read_pma(phydev);

> +static int mv88q2xxx_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_c45_config_aneg(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = mv88q2xxx_soft_reset(phydev);
> +	if (ret)
> +		return ret;
return mv88q2xxx_soft_reset(phydev);

> +static int mv88q2xxx_probe(struct phy_device *phydev)
> +{
> +	return 0;
> +}
not needed? just remove it, if nothing to be done

> +static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
> +{
> +	u16 value;
> +
> +	if (phydev->speed == SPEED_100) {
> +		/* Read the SQI from the vendor specific receiver status
> +		 * register
> +		 */
> +		value = (phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230) >> 12) & 0x0F;
> +	} else {
> +		/* Read from vendor specific registers, they are not documented
> +		 * but can be found in the Software Initialization Guide. Only
> +		 * revisions >= A0 are supported.
> +		 */
> +		phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
> +		value = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88) & 0x0F;
> +	}

errors from phy_modify_mmd/phy_read_mmd ignored?


