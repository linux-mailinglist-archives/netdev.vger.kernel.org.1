Return-Path: <netdev+bounces-16620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890DD74E053
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1965D280C32
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275C1640B;
	Mon, 10 Jul 2023 21:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1D134A5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:40:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F5E0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mmOoMil4ToBSLzrYDxnem4Eid/noGy/LsZVPob9JAyI=; b=wPJMtVtFp5KDJNXERj004Vn2IT
	bzDfANODM9Yo6FO0Se/hHUkJ6C5Ve5U01+bQnhJEAAde5OhpalMqrXAh8OXiBcIwM1DQH1YbETjnA
	WQlgcMWmBhIe5pJG9bFpU79VdhtFhGi0Mvz9S2TYcyapZdRjnhzHw9q9kZ2Ek7p0pWl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIyc9-000zGD-7p; Mon, 10 Jul 2023 23:40:13 +0200
Date: Mon, 10 Jul 2023 23:40:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <4262f852-544f-4b98-8d25-08b9b3136100@lunn.ch>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
> +
> +	/* Check the link status according to Software Initialization Guide */
> +	return (0x0 != (ret1 & 0x0004)) && (0x0 != (ret2 & 0x3000)) ? 1 : 0;

MDIO_PCS_1000BT1_STAT bit 2 is "Receive polarity" as defined in 802.3?
Please add a #define for it.

Please also add a #define for 0x3000 so we have some idea what is
means.

	Andrew

