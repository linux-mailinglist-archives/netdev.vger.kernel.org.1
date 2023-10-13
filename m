Return-Path: <netdev+bounces-40740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F027C8911
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84ABFB209A4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115F1BDEA;
	Fri, 13 Oct 2023 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFivpRx1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368110952
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB7EC433C8;
	Fri, 13 Oct 2023 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697212041;
	bh=hzaje4tewvJblbKIeWkc4poyyNgRKrYbqer1VgiOEI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFivpRx1m0ZUojigVPR8yTCubmHLbXYy3v62x2m2/oZ1XfefSvPZ8L6LsgZqQWoHx
	 C+dVmwnJ2iq3oMhuC/mAP0ireYp20avytsaiS3onJqKxQMVJwVt59t8OEI3HVSAwUK
	 1p1lff2gla4hM+jduYwa6jDYOPZ4Q5yuSFIRQoS6zQMari6eL09MdCeCPu/IR/Mf4n
	 CFGpumfFcNYIQXKA+cgVIbS6jGzY/TRgC092YEvlRl9Mp1ddjFj0Oxh/ngCSdbG6vv
	 Ui0oC0IBMOfBuiP0PBKia8smQQCJsDaQpo+nwjqAj0FfYx5OAsUwz7MSTqf4HM3iH+
	 Fu2hEtXyDMcJA==
Date: Fri, 13 Oct 2023 17:47:16 +0200
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: ksz8: Enable MIIM
 PHY Control reg access
Message-ID: <20231013154716.GP29570@kernel.org>
References: <20231011123856.1443308-1-o.rempel@pengutronix.de>
 <20231011123856.1443308-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011123856.1443308-2-o.rempel@pengutronix.de>

On Wed, Oct 11, 2023 at 02:38:55PM +0200, Oleksij Rempel wrote:
> Provide access to MIIM PHY Control register (Reg. 31) through
> ksz8_r_phy_ctrl() and ksz8_w_phy_ctrl() functions. Necessary for
> upcoming micrel.c patch to address forced link mode configuration.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c | 81 +++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 91aba470fb2f..11cb054cb54f 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -632,6 +632,47 @@ static void ksz8_w_vlan_table(struct ksz_device *dev, u16 vid, u16 vlan)
>  	ksz8_w_table(dev, TABLE_VLAN, addr, buf);
>  }
>  
> +/**
> + * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a MIIM PHY
> + *		     Control register (Reg. 31).
> + * @dev: The KSZ device instance.
> + * @port: The port number to be read.

nit: please include an entry for @val here

> + *
> + * This function reads the SMI interface and translates the hardware register
> + * bit values into their corresponding control settings for a MIIM PHY Control
> + * register.
> + */
> +static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)

...

