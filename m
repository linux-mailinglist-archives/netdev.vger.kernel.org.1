Return-Path: <netdev+bounces-158540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11081A12691
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D178C1889C4C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680513A865;
	Wed, 15 Jan 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O7Sa1k/b"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AB13C3D6
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952842; cv=none; b=fjoHkrZl3yZ+hUsXw+0pzgdD/5sfeH5cduILoi75Fjd3mYjoauJg1DUcHzh2rt3iudhMCKRhskOdS/4QGLbHJIkWxNd+yJabMXIYpZm4KMM4P2aTFcvyVbAXP19+MizMH7ipWdhpwTFH3kr9YUOeji/HpQTWppKNGf40huOnQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952842; c=relaxed/simple;
	bh=Ht71pen2DjZ4KrcyxlrE8/Qc3lERU/loKFju16OuWxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocGw943gxpVLQfKQqDvzELkPsA4+jkepdgMvRx1yIXTWUgsTHMKKxcppLurJ7RSkmK9LhDmZxuslRKlKQcX8v3dIUQY7QZ2+tQ9VCa/+A+K7VfkNOH4/CwjcZpB/bR67fELV6NqgKxIeH01NcfVoUE00skCZwB081jQEdXRzywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O7Sa1k/b; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42FD420007;
	Wed, 15 Jan 2025 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736952837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5HzedHrDTTaaYhW4c4vjlkU8W6+KNnjRLtnJ7FWDig=;
	b=O7Sa1k/bt4nVGHriNYjerugIhcrT6/4qoUmwt0nufvXWFJ0XoYacyu2lg1IYfE8wX7Bu+G
	W6u81AHHSIj+ToXo849sJQBQtCuU1LCh/YEmGB17dubCFOBDFyAzq0j+7oCuTghMMAi1k0
	frCjkp8x88ZXzRPlKUU2dD3kIcg9Vvrr9oxBZO6++rOdLwrXejmgQes2HJy4CROUk5Co54
	NwYk4Y3Muq0uhV1a70EoamSEZynuayFfa1z/Yg6+67UENHzS6n93Wakae4bZGZ/REU+NJG
	+ke/eejMCpTCGV18rORimootvxuBCANSIXH7DYqIiiSaokT/o//9vNuFVUbKrQ==
Date: Wed, 15 Jan 2025 15:53:54 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 06/10] net: mvpp2: add EEE implementation
Message-ID: <20250115155354.0acdacc7@fedora.home>
In-Reply-To: <E1tXhUz-000n0k-IY@rmk-PC.armlinux.org.uk>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
	<E1tXhUz-000n0k-IY@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Tue, 14 Jan 2025 14:02:29 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Add EEE support for mvpp2, using phylink's EEE implementation, which
> means we just need to implement the two methods for LPI control, and
> with the initial configuration. Only SGMII mode is supported, so only
> 100M and 1G speeds.
> 
> Disabling LPI requires clearing a single bit. Enabling LPI needs a full
> configuration of several values, as the timer values are dependent on
> the MAC operating speed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> --
> v3: split LPI timer limit and validation into separate patches
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  5 ++
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 86 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 9e02e4367bec..364d038da7ea 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -481,6 +481,11 @@
>  #define MVPP22_GMAC_INT_SUM_MASK		0xa4
>  #define     MVPP22_GMAC_INT_SUM_MASK_LINK_STAT	BIT(1)
>  #define	    MVPP22_GMAC_INT_SUM_MASK_PTP	BIT(2)
> +#define MVPP2_GMAC_LPI_CTRL0			0xc0
> +#define     MVPP2_GMAC_LPI_CTRL0_TS_MASK	GENMASK(8, 8)

I think this should be GENMASK(15, 8) :)

The rest looks good to me,

Thanks,

Maxime

