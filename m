Return-Path: <netdev+bounces-254235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL2WIVz7eWkE1QEAu9opvQ
	(envelope-from <netdev+bounces-254235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:04:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763FA0FF9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C330630094E5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F2327BE7;
	Wed, 28 Jan 2026 12:04:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7A238D54
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601878; cv=none; b=EoG37d8KSUal+BDAeDXMzPvc6wT0zydlJHvzZPx+AxF3bAEZxBsRD9BTb22sRzzT1w+F9hrXT0o+zWfeq0F6dRVwe5XLb6GH0tvqPQBZhnVOA0Kp2GuCecye5QwYhdyAVVXtsWqPWBWf83Dw7ZUh8u+ehFE6Vbw79gfY4MTgc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601878; c=relaxed/simple;
	bh=UaRanavbWIgdvIBcwHHzmu9EpfbP5cnQ+x8lDfnPtiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/rEjQzoPAIZNN46kecDp8bFupvLXAEInyrL5Yl74O/InAVWW/Pt3avrUw79fLY9TaGNWokp71VF7NJJC66pzpG47ARUw/FCJofSYQZfPWRaOTWlxl4UIUzZOpMdV3haaeN/g4cU75csn0e4dqg9WNQVVvI3K1rQxp3Syj+ULbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vl4HY-00024t-D5; Wed, 28 Jan 2026 13:04:24 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vl4HW-002uU7-0I;
	Wed, 28 Jan 2026 13:04:21 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vl4HV-000000009ui-1PUo;
	Wed, 28 Jan 2026 13:04:21 +0100
Message-ID: <c8a10b5355b750cfc83a7f746347175ab40b64d7.camel@pengutronix.de>
Subject: Re: [PATCH net-next 1/3] net: stmmac: rk: fix missing
 reset_control_put()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	 <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Heiko Stuebner <heiko@sntech.de>, Jakub
 Kicinski	 <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, 	netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Date: Wed, 28 Jan 2026 13:04:21 +0100
In-Reply-To: <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
	 <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254235-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: 4763FA0FF9
X-Rspamd-Action: no action

On Mi, 2026-01-28 at 10:58 +0000, Russell King (Oracle) wrote:
> rk_gmac_setup() delves into the PHY's DT node to retrieve its reset
> control using of_reset_control_get(). However, it never releases it
> when the driver is removed. Add reset_control_put() to rk_gmac_exit()
> to clean this up.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac-rk.c
> index 5f8d2031b97c..bc69cbb5a7d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1784,6 +1784,8 @@ static void rk_gmac_exit(struct device *dev, void *=
bsp_priv_)
> =20
>  	if (priv->plat->phy_node && bsp_priv->integrated_phy)
>  		clk_put(bsp_priv->clk_phy);
> +
> +	reset_control_put(bsp_priv->phy_reset);
>  }
> =20
>  static int rk_gmac_probe(struct platform_device *pdev)

This is fine because the driver sets plat_dat->suspend, and so
rk_gmac_exit() is never called via stmmac_pltfr_exit() during suspend.

It does look a bit sketchy to release resources in the rk_gmac_exit()
counterpart to rk_gmac_init(), which never requested the resources,
though. Maybe use devm_add_action_or_reset() to register the release of
the reset during remove?

regards
Philipp

