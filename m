Return-Path: <netdev+bounces-47137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB07E831C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A991F20F1C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209F3B291;
	Fri, 10 Nov 2023 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX4ifgLq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2C3B28F;
	Fri, 10 Nov 2023 19:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03042C433C8;
	Fri, 10 Nov 2023 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699646229;
	bh=pPeEBHJvQREKkTU30qYxMcqhI6GQEWa9vdngVVAWlco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HX4ifgLq+XwZy+KNkyT0S+JWropAdL44XUYyjluHGSYpALor868pJnwNCQ9wHe9eu
	 tQxk3q8EDwspwZknT9Ge6BOV1BLRgnyE+n3UrEqyDlyIssNyitBD1TDWGrDOjwOWmB
	 9OmkjDxk/zKY+YEN6EmDGy6eIrC/+R1vzyHHlqTRRhPqIqJrW0MACB6fVHDl/pipB+
	 6h0Bae+FM7VCIWwtd1BBnPBVzPhpl7CeYFSbFgXU8OePRScmo6m3UQ2jFTDi5dcHj0
	 tdwmOYOMfkN3IY0VJ1M9cQwkMli1RW2hQ+fTOWsDfH2hb4jrZdoTQWX04WQjKx7Uqp
	 UICOwInuwywGg==
Date: Fri, 10 Nov 2023 19:57:02 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v6 3/4] net: phy: aquantia: add firmware
 load support
Message-ID: <20231110195628.GA673918@kernel.org>
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
 <20231109123253.3933-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109123253.3933-3-ansuelsmth@gmail.com>

On Thu, Nov 09, 2023 at 01:32:52PM +0100, Christian Marangi wrote:
> From: Robert Marko <robimarko@gmail.com>
> 
> Aquantia PHY-s require firmware to be loaded before they start operating.
> It can be automatically loaded in case when there is a SPI-NOR connected
> to Aquantia PHY-s or can be loaded from the host via MDIO.
> 
> This patch adds support for loading the firmware via MDIO as in most cases
> there is no SPI-NOR being used to save on cost.
> Firmware loading code itself is ported from mainline U-boot with cleanups.
> 
> The firmware has mixed values both in big and little endian.
> PHY core itself is big-endian but it expects values to be in little-endian.
> The firmware is little-endian but CRC-16 value for it is stored at the end
> of firmware in big-endian.
> 
> It seems the PHY does the conversion internally from firmware that is
> little-endian to the PHY that is big-endian on using the mailbox
> but mailbox returns a big-endian CRC-16 to verify the written data
> integrity.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Hi Christian and Robert,

thanks for your patch-set.

I spotted some minor endien issues which I have highlighted below.

...

> +/* load data into the phy's memory */
> +static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> +			      const u8 *data, size_t len)
> +{
> +	u16 crc = 0, up_crc;
> +	size_t pos;
> +
> +	/* PHY expect addr in LE */
> +	addr = cpu_to_le32(addr);

The type of addr is host byte-order,
but here it is assigned a little-endian value.

Flagged by Sparse.

> +
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));

VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR() performs a bit-shift on addr,
and applies a mask which is in host-byte order.
But, as highlighted above, addr is a little-endian value.
This does not seem right.

This is all hidden by a cast in VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR()
This seems dangerous to me.


> +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> +		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));

There seem to be similar issues with the use of addr here.

> +
> +	/* We assume and enforce the size to be word aligned.
> +	 * If a firmware that is not word aligned is found, please report upstream.
> +	 */
> +	for (pos = 0; pos < len; pos += sizeof(u32)) {
> +		u32 word = get_unaligned((const u32 *)(data + pos));
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE6,
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(word));
> +
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE1,
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
> +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
> +
> +		/* calculate CRC as we load data to the mailbox.
> +		 * We convert word to big-endiang as PHY is BE and mailbox will
> +		 * return a BE CRC.
> +		 */
> +		word = cpu_to_be32(word);

Similarly here, Sparse flags that a little-endian value is assigned to a
host byte-order variable.

> +		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> +	}

...

pw-bot: changes-requested

