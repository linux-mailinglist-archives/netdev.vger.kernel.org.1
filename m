Return-Path: <netdev+bounces-250749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09900D3919D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1DE63005006
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FDB2DF153;
	Sat, 17 Jan 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQFMITC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754101F239B;
	Sat, 17 Jan 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768692010; cv=none; b=rfBCtgHgQGz+8kQTvHnaxU2YN9hSc8VA0qNffR1JaxyVtkbIj3iIVEPpPwFEXpIUXxIGFb3p+1HQLPgf+7G6Vis/pUg0vMDZRgznCGTPcSabzKAcW5mIFFg/R6xITqJ0WPZcLo/S4HGS48uh52w0yg1CtoGwkE7pWKI2pn3XEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768692010; c=relaxed/simple;
	bh=pxhkgYoWbdsgiCuc5Rs9dZLmf5rnoA9KQE8DwQul9yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaEyCQQ0RplDexhUDA6ETjUeSrb8hXG5+7OKgomJ+Lwg7QhamqK5IjCiLKhjGo0joqG4OL++0JQTE2C/kIFZO1DsrDXm6AVKzdXRInZGVinb3GAesH5SCUhpfV0jHoEhnPpQnQ24tGNHRzPEY3bzFca94Asb0wHEOZxy623+WK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQFMITC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCE8C4CEF7;
	Sat, 17 Jan 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768692010;
	bh=pxhkgYoWbdsgiCuc5Rs9dZLmf5rnoA9KQE8DwQul9yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQFMITC+eiCs2FGVHNgVkhJDAiHnDXzupAWKdbyaMp+M10SoqxXxn2G0RCs6lFXmU
	 YzQkEPPtGUhJ2TOWrdKa2V3OUBeDRwV/2wDvDZP5k7q6j1ZhrT0+zl58+1MvszS7Th
	 yOZovvGP6b3wxSPd26NSBMN2KmvLFhtd1Fkw/KHmj63DS+RPaETzAHNXnBS42LcSt0
	 LoYLuO7kT4KehxUWt1CEnLjvanxnGGrDa49PX/P8qhWeBRL5Wkum0ji0fnRA1HfIw7
	 nkjccQ364r9EMPPdPmSnHr7quHnaPliFOuSDcSNfWWkPh3YHb0ZOcYHVN0Dl94VbJ7
	 sLTgs+n+WO2bQ==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org,
	michael@fossekall.de,
	linux@armlinux.org.uk,
	edumazet@google.com,
	andrew@lunn.ch,
	olek2@wp.pl,
	davem@davemloft.net,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via MDIO_MMD_VEND2
Date: Sat, 17 Jan 2026 15:20:06 -0800
Message-ID: <20260117232006.1000673-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: realtek: simplify C22 reg access via MDIO_MMD_VEND2

This commit adds support for translating MDIO_MMD_VEND2 registers back
to Clause-22 registers for PHYs on a C22-only bus. It also renames
RTL_PHYSR to RTL_VND2_PHYSR and changes the register access method in
several read_status functions.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index a593150b6cbb..40cae9968d20 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> @@ -1156,7 +1156,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
>  	if (!phydev->link)
>  		return 0;
>
> -	val = phy_read(phydev, RTL_PHYSR);
> +	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
> +			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));

This changes rtlgen_read_status() from reading C22 register MII_RESV2
(0x1a) directly to using paged access at page 0xa43, register 18.

rtlgen_read_status() is used by RTL8211F, RTL8211F-VD, and Generic FE-GE
Realtek PHY drivers. Are these Gigabit-only PHYs guaranteed to have the
PHYSR at the same paged location as the RTL822x 2.5GbE PHYs?

I notice this change is reverted in a later commit in the series:
  efef1a8042ec ("net: phy: realtek: demystify PHYSR register location")
which changes back to:
  val = phy_read(phydev, RTL_PHYSR);

with the note "Turns out that register address RTL_VND2_PHYSR (0xa434)
maps to Clause-22 register MII_RESV2".

Is the paged access in this intermediate commit correct, or could it
cause issues during bisection?

[ ... ]

> @@ -2127,7 +2137,7 @@ static int rtlgen_sfp_read_status(struct phy_device *phydev)
>  	if (!phydev->link)
>  		return 0;
>
> -	val = phy_read(phydev, RTL_PHYSR);
> +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);

Similarly, this changes from C22 register read to C45 MDIO_MMD_VEND2
access via rtlgen_read_vend2(). The SFP PHY mode uses PHY_IS_INTERNAL
and is used by r8169 for 2.5GbE chips in SFP mode.

This is also reverted in the same later commit to:
  val = phy_read(phydev, RTL_PHYSR);

Does rtlgen_read_vend2() work correctly for all PHYs that could be in
SFP mode?
-- 
pw-bot: cr

