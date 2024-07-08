Return-Path: <netdev+bounces-109957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA592A78E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C051C20E87
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD038146595;
	Mon,  8 Jul 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s7OyuJih"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02A144D00;
	Mon,  8 Jul 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457080; cv=none; b=uL0xY68i02QGP/UX4MY7S/+zpW1Iom7maMtEJuo25IO1EdmN6taTILU4dZXnOThGjwyf+rtewD+NwMkytO9whcECg7x5FstFUQJdY7suM6aE7XvvPmbn47J2wBpEAYs0eF5xM3Sq2nDSLT0GuDsoLqB6U+6kENkEmwhkaveFvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457080; c=relaxed/simple;
	bh=5ESnARZBkTED1KaBFyUpVqcIWmDqIz4mvhGGd9iC4Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfF2kEOKMqHx3WPrxpnlLDNHHF9+FWEQqN2gE+aNcv0Wp11vilcQk3zWqMEsvBVfeoE+S6GhqcIiq9udmvWnZTQ/ClvKxICkr3PGPXhcBItWz2WB4PGyiBMpo4YyvJZucGDfq+a7yOWLvM8kwylzXcU8PT3Bi1ukaOZAGPxukew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s7OyuJih; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KVS+i1XUHvUJQaRfBqutTAmdyqVGb8npULF3liLDUsQ=; b=s7OyuJihm6lz9XvGrgJrMbu96T
	D/12ylaxD8Ha37VBpjzrQJkqHR9SzhjKFhgH4jO+4kDsceXjwSzu/uR0NR2ZdCh3MduiS5meUgrG5
	KMp2jPkqacfM0UYznnFmUGg8PAf8+Rnjxy0M60+L1yAFpb5V04hrVGDpxtjyWWKRRe6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQrTS-0023lo-PL; Mon, 08 Jul 2024 18:44:22 +0200
Date: Mon, 8 Jul 2024 18:44:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83td510: add cable testing
 support
Message-ID: <a14ae101-d492-45a0-90fe-683e2f43fa3e@lunn.ch>
References: <20240708140542.2424824-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708140542.2424824-1-o.rempel@pengutronix.de>

On Mon, Jul 08, 2024 at 04:05:42PM +0200, Oleksij Rempel wrote:
> Implement the TDR test procedure as described in "Application Note
> DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.
> 
> The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
> cable length was 5 meters more for each 20 meters of actual cable length.
> For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
> showed as 50 meters. Since other parts of the diagnostics provided by this
> PHY (e.g., Active Link Cable Diagnostics) require accurate cable
> characterization to provide proper results, this tuning can be implemented
> in a separate patch/interface.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/dp83td510.c | 158 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> index d7616b13c5946..3375fa82927d0 100644
> --- a/drivers/net/phy/dp83td510.c
> +++ b/drivers/net/phy/dp83td510.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/ethtool_netlink.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/phy.h>
> @@ -29,6 +30,42 @@
>  #define DP83TD510E_INT1_LINK			BIT(13)
>  #define DP83TD510E_INT1_LINK_EN			BIT(5)
>  
> +#define DP83TD510E_TDR_CFG			0x1e
> +#define DP83TD510E_TDR_START			BIT(15)
> +#define DP83TD510E_TDR_DONE			BIT(1)
> +#define DP83TD510E_TDR_FAIL			BIT(0)
> +
> +#define DP83TD510E_CTRL				0x1f
> +#define DP83TD510E_CTRL_HW_RESET		BIT(15)
> +#define DP83TD510E_CTRL_SW_RESET		BIT(14)
> +
> +#define DP83TD510E_TDR_CFG1			0x300

> +/* TX_TYPE: Transmit voltage level for TDR. 0 = 1V, 1 = 2.4V */
> +#define DP83TD510E_TDR_TX_TYPE			BIT(12)

This does not appear to be used, so it is not too important. But i
generally encode this as

#define DP83TD510E_TDR_TX_TYPE_1V		(0 << 12)
#define DP83TD510E_TDR_TX_TYPE_2V4		(1 << 12)

You can then OR in DP83TD510E_TDR_TX_TYPE_1V which does nothing, but
does document you are using 1V for the test.

> +#define DP83TD510E_TDR_CFG2			0x301
> +#define DP83TD510E_TDR_END_TAP_INDEX_1		GENMASK(14, 8)
> +#define DP83TD510E_TDR_END_TAP_INDEX_1_DEF	36
> +#define DP83TD510E_TDR_START_TAP_INDEX_1	GENMASK(6, 0)
> +#define DP83TD510E_TDR_START_TAP_INDEX_1_DEF	3

Does this correspond the minimum and maximum distance it will test?
Is this 3m to 36m?

   Andrew

