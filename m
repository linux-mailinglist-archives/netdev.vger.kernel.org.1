Return-Path: <netdev+bounces-248082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB057D03058
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BD12302949A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620C33BBA8;
	Thu,  8 Jan 2026 13:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116B18859B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878591; cv=none; b=hnEebbGXqv+7k5HDsVHiW8dgYRBCMRPq83cGB8/xqGDO5ComNS1YUA8GTUyLHJySj7W9OCxTqnkEi9i99+pK+zjiRZ3Ih34GdsOzlHabOJpR6HaHkrC8zrYcUMq8ntIo0VAEM8Rt5UYGXE7TCVgiH6rTqf+cHBj78T98oFv1RG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878591; c=relaxed/simple;
	bh=sushfq5GAYWdCXpDJKKEKFHV3Afei3pz/MnRjM3PDt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJpElVsI5CCGx3rz/c6vkxnRemIL+laxPFpaUyTHfDUmECWBVCyQRGX2AcCyTNoH8gTdugTRpaKCMms2M6nvdxT+4Ck57PQATP4ZvaznIUjy0pXnKvRhoaueWfPA0WvWH6oEG65VvZUeokXwpi/8zoCkr4Hr1MNectEm1crCiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vdpyU-0005cJ-PR; Thu, 08 Jan 2026 14:22:50 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vdpyS-009gXW-2F;
	Thu, 08 Jan 2026 14:22:48 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vdpyS-000000007uP-1b8C;
	Thu, 08 Jan 2026 14:22:48 +0100
Message-ID: <1fe08251f091bd695f630b7b46ae8c8d85d664a3.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] net: stmmac: socfpga: add call to
 assert/deassert ahb reset line
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>, Maxime Chevallier	
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue	 <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mamta Shukla	 <mamta.shukla@leica-geosystems.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, Pengutronix Kernel Team	
 <kernel@pengutronix.de>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Thu, 08 Jan 2026 14:22:48 +0100
In-Reply-To: <20260108-remove_ocp-v3-1-ea0190244b4c@kernel.org>
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
	 <20260108-remove_ocp-v3-1-ea0190244b4c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Do, 2026-01-08 at 07:08 -0600, Dinh Nguyen wrote:
> The "stmmaceth-ocp" reset line of stmmac controller on the SoCFPGA
> platform is essentially the "ahb" reset on the standard stmmac
> controller. But since stmmaceth-ocp has already been introduced into
> the wild, we cannot just remove support for it. But what we can do is
> to support both "stmmaceth-ocp" and "ahb" reset names. Going forward we
> will be using "ahb", but in order to not break ABI, we will be call reset
> assert/de-assert both ahb and stmmaceth-ocp.
>=20
> The ethernet hardware on SoCFPGA requires either the stmmaceth-ocp or
> ahb reset to be asserted every time before changing the phy mode, then
> de-asserted when the phy mode has been set.
>=20
> With this change, we should be able to revert patch:
> commit 62a40a0d5634 ("arm: dts: socfpga: use reset-name "stmmaceth-ocp"
> instead of "ahb"")
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index a2b52d2c4eb6f..79df55515c718 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -407,6 +407,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_d=
wmac *dwmac)
> =20
>  	/* Assert reset to the enet controller before changing the phy mode */
>  	reset_control_assert(dwmac->stmmac_ocp_rst);
> +	reset_control_assert(dwmac->plat_dat->stmmac_ahb_rst);

Since these two are just different names for the same reset,
I think it would be cleaner to rename dwmac->stmmac_ocp_rst to
dwmac->stmmac_ahb_rst and assign this either to
dwmac->plat_dat->stmmac_ahb_rst or to the stmmac-ocp reset during
probe.

Also, a comment explaining that the dem_reset_control_get_optional(dev,
"stmmaceth-ocp") is for backwards compatibility with legacy device
trees could be helpful to future readers.


regards
Philipp

