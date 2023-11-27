Return-Path: <netdev+bounces-51314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD247FA12E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01D6B20C64
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073502F87F;
	Mon, 27 Nov 2023 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JRzzzBUR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F90B8;
	Mon, 27 Nov 2023 05:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dCgnYA2BHI8R6kOuu4v1Rr1eB4wzNkIiBg2MOXwz+BY=; b=JRzzzBURcil9rlFybupVTuue/j
	mpbF6lr8Dcw5ofoEFFGxD5Qh9rXJY8GaHgh5vRr2xC8FrVhiZfvcKPIi+W76VSd0plT6ieKlZwQnK
	QF7ihjEeC42ugiVrnAQ2E5G3JcsJrx9A7KCqcmU58xyTbzoI6JgCab42kz8g1eaZAKTU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7bnx-001LUS-N5; Mon, 27 Nov 2023 14:37:41 +0100
Date: Mon, 27 Nov 2023 14:37:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n_N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: microchip_t1s: add support for LAN867x Rev.C1
Message-ID: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-3-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127104045.96722-3-ramon.nordin.rodriguez@ferroamp.se>

>  #define PHY_ID_LAN867X_REVB1 0x0007C162
> +#define PHY_ID_LAN867X_REVC1 0x0007C164

So there is a gap in the revisions. Maybe a B2 exists?

> +static int lan867x_revc1_read_fixup_value(struct phy_device *phydev, u16 addr)
> +{
> +	int regval;
> +	/* The AN pretty much just states 'trust us' regarding these magic vals */
> +	const u16 magic_or = 0xE0;
> +	const u16 magic_reg_mask = 0x1F;
> +	const u16 magic_check_mask = 0x10;

Reverse christmass tree please. Longest first, shorted last.

> +	regval = lan865x_revb0_indirect_read(phydev, addr);
> +	if (regval < 0)
> +		return regval;
> +
> +	regval &= magic_reg_mask;
> +
> +	return (regval & magic_check_mask) ? regval | magic_or : regval;
> +}
> +
> +static int lan867x_revc1_config_init(struct phy_device *phydev)
> +{
> +	int err;
> +	int regval;
> +	u16 override0;
> +	u16 override1;
> +	const u16 override_addr0 = 0x4;
> +	const u16 override_addr1 = 0x8;
> +	const u8 index_to_override0 = 2;
> +	const u8 index_to_override1 = 3;

Same here.

> +
> +	err = lan867x_wait_for_reset_complete(phydev);
> +	if (err)
> +		return err;
> +
> +	/* The application note specifies a super convenient process
> +	 * where 2 of the fixup regs needs a write with a value that is
> +	 * a modified result of another reg read.
> +	 * Enjoy the magic show.
> +	 */

I really do hope that by revision D1 they get the firmware sorted out
so none of this undocumented magic is needed.

	Andrew

