Return-Path: <netdev+bounces-56194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E080E212
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815961C2173D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5A81FC5;
	Tue, 12 Dec 2023 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Z6XbCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F34418
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6220DC433C7;
	Tue, 12 Dec 2023 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702349201;
	bh=cQ4wUl6++qO8BEW8ZwZKfxPjaTGwJHwd8l+J+2TIHwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j4Z6XbCiTApJbcrug5/72aaZw9xMl+uy3S74BMKXClSIf0NIOD16lf0RJZF/3hCvS
	 9pT1eea7xi7SRqSfjdNsB64zbzUw7EmRmee0vWu6KngORkdHUFGcKYvEyvp6CJTpGm
	 rmNy9LJT0stHN7K13meSd/udc+luC/rHhqjuTZKAIi2Yb13hmf1a79GeEcmd8c7ENL
	 Zbc4o1Qhf0MCrHUyfxFLRBwa2WCbiMfAVITbLtUtzmmLhhR41uFgEyzSPHyBuq3cB8
	 ewR4yuv5XPgEzhIezdrO/Tep3hWshb2DBave1DXSwTUiJhji9ZDJl+FTxX+Dn+BGRy
	 u0gNlVWHqln7w==
Date: Mon, 11 Dec 2023 18:46:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David
 Epping <david.epping@missinglinkelectronics.com>, Vladimir Oltean
 <olteanv@gmail.com>, Harini Katakam <harini.katakam@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v4 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231211184640.5faa296c@kernel.org>
In-Reply-To: <20231206232547.2501-3-ansuelsmth@gmail.com>
References: <20231206232547.2501-1-ansuelsmth@gmail.com>
	<20231206232547.2501-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Some nit picks since nobody has acked :(

On Thu,  7 Dec 2023 00:25:47 +0100 Christian Marangi wrote:
> +/**
> + * __phy_package_read_mmd - Convenience function for reading a register
> + * on an MMD on a given PHY using the PHY package base addr, added of

s/on an MMD/of an MMD/ ?
s/added of/added to/ ?

> + * the addr_offset value.
> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + *
> + * Same rules as for __phy_read();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.

I'd try to make the headline shorter:

/**
 * __phy_package_read_mmd - read MMD reg relative to PHY package base addr
 * @phydev: The phy_device struct
 * @addr_offset: The offset to be added to PHY package base_addr
 * @devad: The MMD to read from
 * @regnum: The register on the MMD to read
 *
 * Convenience helper for reading a register of an MMD on a given PHY
 * using the PHY package base address. The base address is added to
 * the addr_offset value.
 *
 * Same calling rules as for __phy_read();
 *
 * NOTE: It's assumed that the entire PHY package is either C22 or C45.
 */

