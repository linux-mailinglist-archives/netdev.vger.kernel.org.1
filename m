Return-Path: <netdev+bounces-44251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF07D7533
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 22:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50291C20DF8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93853328CC;
	Wed, 25 Oct 2023 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXobuwDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776B28680;
	Wed, 25 Oct 2023 20:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3671C433C8;
	Wed, 25 Oct 2023 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698264624;
	bh=W2ZtlC8h83hjoSYyz4fUnl72qO69z2zaIBKrCyxCmas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXobuwDDWpPIpl4AGv2c5SE7hxUyUbECrQX3GJJk0nfdVMzKJMUgOH4sbX/qKdVyv
	 9Dcu7WtXFdjDy/FZYaULYAWZETMipyCvyRYNGFFX8xwMLsUCKJ0rFPScDcOX0E6xcs
	 SVF4S8sYz77QDTgdkeUI9BFYOXEacv8eGXIGCLlk6wia3qtc3pPH5Dfc2HasEenD+j
	 AF3B4PIFBmkf0g65ZlgJ98SB3A2W8KZAKgRCVJgee/hOb441boZQJN2m5HOhSQw1Pk
	 qXhqILm7WzfTbaKJUEUIKKFLntVCL6b+S1gGywIhrbsPrqILWhOKv3k4TchDC26j7P
	 NxO9TUDh0W0uw==
Date: Wed, 25 Oct 2023 21:10:15 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/9] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <20231025201015.GL57304@kernel.org>
References: <20231023093343.2370248-1-o.rempel@pengutronix.de>
 <20231023093343.2370248-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023093343.2370248-5-o.rempel@pengutronix.de>

On Mon, Oct 23, 2023 at 11:33:38AM +0200, Oleksij Rempel wrote:
> Add WoL support for KSZ9477 family of switches. This code was tested on
> KSZ8563 chip.
> 
> KSZ9477 family of switches supports multiple PHY events:
> - wake on Link Up
> - wake on Energy Detect.
> Since current UAPI can't differentiate between this PHY events, map all
> of them to WAKE_PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c    | 100 +++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz9477.h    |   4 +
>  drivers/net/dsa/microchip/ksz_common.c |  24 ++++++
>  drivers/net/dsa/microchip/ksz_common.h |   4 +
>  4 files changed, 132 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index cde8ef33d029..036dfaddb32a 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -56,6 +56,103 @@ int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
>  				  REG_SW_MTU_MASK, frame_size);
>  }
>  
> +/**
> + * ksz9477_handle_wake_reason - Handle wake reason on a specified port.
> + * @dev: The device structure.
> + * @port: The port number.
> + *
> + * This function reads the PME (Power Management Event) status register of a
> + * specified port to determine the wake reason. If there is no wake event, it
> + * returns early. Otherwise, it logs the wake reason which could be due to a
> + * "Magic Packet", "Link Up", or "Energy Detect" event. The PME status register
> + * is then cleared to acknowledge the handling of the wake event.
> + *
> + * Return: 0 on success, or an error code on failure.
> + */
> +static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
> +{
> +	u8 pme_status;
> +	int ret;
> +
> +	ret = ksz_pread8(dev, port, REG_PORT_PME_STATUS, &pme_status);
> +	if (ret)
> +		return ret;
> +
> +	if (!pme_status)
> +		return 0;
> +
> +	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s\n", port,
> +		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
> +		pme_status & PME_WOL_ENERGY ? " \"Enery detect\"" : "");

nit: Energy

> +
> +	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
> +}

...

