Return-Path: <netdev+bounces-16616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CC74E024
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9867281343
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E2156E6;
	Mon, 10 Jul 2023 21:20:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099C14ABE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:20:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E27C0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=79UYuT1tQX5ShI3xntPTx2Dgmd2C1ulZ/F+F9vJaDjI=; b=mwveZoBB7Wl7OVhdZzVMzH8A2T
	PRBH4pMVHZVbZxopCDvsIfhmy13ite2kwbEAYuYQEMZ2DdY2Otmz79BljKSRTcCfftlROq+jhtTu+
	qAgBwk1w+mxi6EjOY6FcSp0mEc+8/hmubqOCo0CRc5xh/tLl61A6wUtwcFXvYtlMtYTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIyJ6-000zB8-77; Mon, 10 Jul 2023 23:20:32 +0200
Date: Mon, 10 Jul 2023 23:20:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <2de0a6e1-0946-4d4f-8e57-1406a437b94e@lunn.ch>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int mv88q2xxx_soft_reset(struct phy_device *phydev)
> +{
> +	return phy_write_mmd(phydev, MDIO_MMD_PCS,
> +			     MDIO_PCS_1000BT1_CTRL, MDIO_PCS_1000BT1_CTRL_RESET);
> +}

Does this bit clear on its own when the reset has completed? When
performing a C22 soft reset, the code polls waiting for the bit to
clear. Otherwise there is a danger you start writing other registers
while it is still resetting.

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

This is generally wrong. See for example genphy_update_link() and
genphy_c45_read_link().

> +static int mv88q2xxx_probe(struct phy_device *phydev)
> +{
> +	return 0;
> +}

If it does nothing, it should not be needed.

    Andrew

---
pw-bot: cr

