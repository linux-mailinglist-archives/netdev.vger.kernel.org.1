Return-Path: <netdev+bounces-17624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B6C752693
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3638E1C210F3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133B1EA94;
	Thu, 13 Jul 2023 15:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200118B12
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:18:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5641B6
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LS/5lGFAZMJk/69HvYubpmP2liqeL42cX0dbzWPZD04=; b=XzyKgTU0VG1Go7jsz1GoCcY/rw
	UQ8OkCps8VD6Ln9j55PWly3tRpwaz9lm5l/nnlgdKTesGHCDV0nHsBx5rVLaUyAHdIR/PS1Tbaz21
	0A7JJ0xkQilD3lfIWHhwKlHTKFlCgD+yBeuemG4AMaOy0B5XXHn686cFa71MotSRPGjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJy4w-001GUL-A6; Thu, 13 Jul 2023 17:18:02 +0200
Date: Thu, 13 Jul 2023 17:18:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: add the link modes for
 1000BASE-T1 Ethernet PHY
Message-ID: <f33be5e3-cfb4-473f-8669-58e1982d2a17@lunn.ch>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-2-eichest@gmail.com>
 <cad4c420-470d-497a-9a1d-a43654af9a7e@lunn.ch>
 <ZLAFzaN7IRzerGpX@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLAFzaN7IRzerGpX@eichest-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 04:10:21PM +0200, Stefan Eichenberger wrote:
> Hi Andrew,
> 
> On Mon, Jul 10, 2023 at 11:10:17PM +0200, Andrew Lunn wrote:
> > On Mon, Jul 10, 2023 at 10:58:57PM +0200, Stefan Eichenberger wrote:
> > > This patch adds the link modes for the 1000BASE-T1 Ethernet PHYs. It
> > > supports 100BASE-T1/1000BASE-T1 in full duplex mode. So far I could not
> > > find a 1000BASE-T1 PHY that also supports 10BASE-T1, so this mode is not
> > > added.
> > 
> > Is this actually needed? Ideally you want to extend
> > genphy_c45_pma_read_abilities() to look in the PHY registers and
> > determine what the PHY can do. You should only use .features if it is
> > impossible to determine the PHY abilities by reading registers.
> 
> Unfortunately the MDIO_PMA_EXTABLE register does not work on this PHY.
> It will not signalize that it is BT1 capable (MDIO_PMA_EXTABLE_BT1). I
> tested it again (should be 0x0800):

**
 * genphy_c45_baset1_able - checks if the PMA has BASE-T1 extended abilities
 * @phydev: target phy_device struct
 */
static bool genphy_c45_baset1_able(struct phy_device *phydev)
{
        int val;

        if (phydev->pma_extable == -ENODATA) {
                val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
                if (val < 0)
                        return false;

                phydev->pma_extable = val;
        }

        return !!(phydev->pma_extable & MDIO_PMA_EXTABLE_BT1);
}

This is rather odd, but might help you. You already have a workaround
in mv88q2xxx_config_init(). Have you tried adding a get_features()
callback with sets phydev->pma_extable to the correct value, and then
calls genphy_c45_pma_read_abilities()?

Please also report the bug in the PHY to Marvell. Maybe a later
revision might have it fixed.

      Andrew

