Return-Path: <netdev+bounces-254269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHimE1gVemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:55:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 991FAA2598
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7CE302D962
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D535EDC1;
	Wed, 28 Jan 2026 13:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FE2DFF19
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608394; cv=none; b=elh8mIcceucoY3kkYWpwRVi8aSueZz8yI4xCKzGKNUwqlzhYYg7OPWfMNzBccAl8X4MmWXtNhWS6U+p6lEgsxfTAnHzOqebd1m7jvFv5QCTrL9pahgV4CoWupLwyUyCDrzYrd2lxzzr4U4wy+ixqpUu0AbMGCdJPcsWvT+Hm+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608394; c=relaxed/simple;
	bh=FwLlNBVRPKJWhVvMXnxt9Zw6yisSlRxe3xZf3Vi5B4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qr1dQeFAQm8f5KAqGN5N1WTftBm/mZKe5ip0+OS68YJWf0l/jJxVfF18VjHJK1ZE0WUyjvb8DWtZGsCRkkOsqf5bLaUdzyWxg9xaQdWEiMd4HmXMEB/cC8TNEntjza4JI8Oznz0H3O88s91yPJs1sN6LzIYRZTAiwT75ng75K8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vl5yd-000670-RO; Wed, 28 Jan 2026 14:52:59 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vl5yc-002vZ3-1y;
	Wed, 28 Jan 2026 14:52:57 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vl5yb-00000000BPZ-3Yu7;
	Wed, 28 Jan 2026 14:52:57 +0100
Message-ID: <52ea6b98b27235f10008406de45cdcecc2a7b105.camel@pengutronix.de>
Subject: Re: [PATCH net-next 1/3] net: stmmac: rk: fix missing
 reset_control_put()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko
 Stuebner <heiko@sntech.de>,  Jakub Kicinski	 <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, 	linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, 	netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Date: Wed, 28 Jan 2026 14:52:57 +0100
In-Reply-To: <aXn-7LWRk5cZjno8@shell.armlinux.org.uk>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
	 <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>
	 <c8a10b5355b750cfc83a7f746347175ab40b64d7.camel@pengutronix.de>
	 <aXn-7LWRk5cZjno8@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-254269-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: 991FAA2598
X-Rspamd-Action: no action

On Mi, 2026-01-28 at 12:19 +0000, Russell King (Oracle) wrote:
> On Wed, Jan 28, 2026 at 01:04:21PM +0100, Philipp Zabel wrote:
> > On Mi, 2026-01-28 at 10:58 +0000, Russell King (Oracle) wrote:
> > > rk_gmac_setup() delves into the PHY's DT node to retrieve its reset
> > > control using of_reset_control_get(). However, it never releases it
> > > when the driver is removed. Add reset_control_put() to rk_gmac_exit()
> > > to clean this up.
> > >=20
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > index 5f8d2031b97c..bc69cbb5a7d4 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > @@ -1784,6 +1784,8 @@ static void rk_gmac_exit(struct device *dev, vo=
id *bsp_priv_)
> > > =20
> > >  	if (priv->plat->phy_node && bsp_priv->integrated_phy)
> > >  		clk_put(bsp_priv->clk_phy);
> > > +
> > > +	reset_control_put(bsp_priv->phy_reset);
> > >  }
> > > =20
> > >  static int rk_gmac_probe(struct platform_device *pdev)
> >=20
> > This is fine because the driver sets plat_dat->suspend, and so
> > rk_gmac_exit() is never called via stmmac_pltfr_exit() during suspend.
> >=20
> > It does look a bit sketchy to release resources in the rk_gmac_exit()
> > counterpart to rk_gmac_init(), which never requested the resources,
> > though. Maybe use devm_add_action_or_reset() to register the release of
> > the reset during remove?
>=20
> Thanks, but I think a sense of proportion is required here. This
> patch is the result of introducing the ->init() method, and AI
> noticing that there was no cleanup of this resource. This was the
> simplest way to implement that cleanup.
>=20
> However, your review commit also applies to bsp_priv->clk_phy which
> has the same problem - this also isn't obtained in rk_gmac_init(),
> but in rk_gmac_clk_init().
>

> Given that, and the fact that this entire series is already
> considerably big (it was 21 patches, then 22, now 23, and with this
> it's going to become 24 patches) I'm going to say that this issue
> can be addressed at a later time.

No objection,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

