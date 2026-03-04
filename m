Return-Path: <netdev+bounces-263764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPIsNYsUqGnUngAAu9opvQ
	(envelope-from <netdev+bounces-263764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:16:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E91FED32
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A244130200C9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F439FCBF;
	Wed,  4 Mar 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjmoVIrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF53372674;
	Wed,  4 Mar 2026 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622948; cv=none; b=eE6KrAMDcK45SlIlD1/TMi7UWm2AmQ32nIQtx40r3Ymu7H25QaJJeW2WXDZgvGGnpp8dKVFnNiaRgTo1cgWGer0sOu/RZXGadSs7CtaGL0L0xdCjIWXqJOym0wOadEiRP/+iZmfFqi9tLbk0B7gEhYo9h+tZyM7awQJe811TgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622948; c=relaxed/simple;
	bh=V+/93t4pBzGZ1wlOY2KAAn2LBwGxLMuAbKCegIklAEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHAdhV2+Il8Uvm9x8ksJFvUZ774+PNzQvOgIZSmLogZxIIdmknzCY8PYalLP3TXjl3zrgM1CapUhwvfiGXoyLfaxYt2GZcvxOuc8aWNMjQQ380v1GFgAus4uLC0b30rNUTdiAA/y3/oZk0aKwmCIG8GOLmHj/y8GenE5fjIrxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjmoVIrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F63C19423;
	Wed,  4 Mar 2026 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772622948;
	bh=V+/93t4pBzGZ1wlOY2KAAn2LBwGxLMuAbKCegIklAEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjmoVIrfOysGfdG2PLyCUlYGsybeU3oZBroR1oKsguqqLAtvrjV+6xtvtPiAVXzKk
	 QBacQMPJI+L4UoQSx1ysn/LPVLZcGSg7zYt3dOT6JtvYc6MOdMpKrTUNSeOalTpJJK
	 DS7mPLA3onCcapSScNcJ+GBqjXDrsrTsKXQOqWCdY+FHv7C5IAYTZjYxgtRupFSGq/
	 LpSb8yiYV1K2W8zHl6I3pWRPRElHuu9eZsSZHcSwABwWKCBYWKmx1wUs7o5MO/6g+s
	 9QZQkakb74n/5ZM+4OnT0yFde3COwnsYgAtH8FhYl7WMvriiCgo2Y2Z5awY7qXYFx/
	 LyQAf7hRm/+EQ==
Date: Wed, 4 Mar 2026 11:15:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e4+TuV/oChtwRV7D"
Content-Disposition: inline
In-Reply-To: <20260224202854.112813-2-charles.perry@microchip.com>
X-Rspamd-Queue-Id: DB2E91FED32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263764-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--e4+TuV/oChtwRV7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> Make it possible to connect a PHY which does not use inband
> autoneg to a gem MAC using phylink's information.
>=20
> The previous implementation relied on whether or not the link
> was a fixed-link to disable SGMII autoneg. This commit extend
> this to all link which are not configured for inband
> autonegotiation.
>=20
> Signed-off-by: Charles Perry <charles.perry@microchip.com>

This breaks the macb on mpfs-icicle-kit, I get stuck with:

[    7.189102] mpfs-sys-controller syscontroller: Registered MPFS system co=
ntroller
[    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff=
:08] driver [Vitesse VSC8662] (irq=3DPOLL)
[    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgmii link =
mode
[    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
[    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff=
:09] driver [Vitesse VSC8662] (irq=3DPOLL)
[    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgmii link =
mode
[    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
[   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control off
[   11.398403] Sending DHCP requests .
[   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow =
control off
[   13.938425] ..... timed out!
[   93.598491] macb 20110000.ethernet eth0: Link is Down
[   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unregistered.
[   93.659433] macb 20112000.ethernet eth1: Link is Down
[   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unregistered.
[   93.703977] IP-Config: Retrying forever (NFS root)...
[   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff=
:08] driver [Vitesse VSC8662] (irq=3DPOLL)
[   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgmii link =
mode
[   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control off
[   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
[   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff=
:09] driver [Vitesse VSC8662] (irq=3DPOLL)
[   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgmii link =
mode
[   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow =
control off
[   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.

and because I am NFS root, it breaks boot :)

btw, I don't see an explanation in hte commit message for why the
macb_is_gem(bp) got dropped? Is this now done unconditionally when it
was conditional before?

Cheers,
Conor.

> ---
>=20
> Notes:
>     Changes in v2:
>       * Move my notes to the cover letter
>       * Remove the spinlock in macb_pcs_config
>       * Keep the comment about the PCSSEL register
>=20
>  drivers/net/ethernet/cadence/macb_main.c | 36 +++++++++++++-----------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index f72270a39d25..f4250e76cef0 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -574,6 +574,26 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
>  			   const unsigned long *advertising,
>  			   bool permit_pause_to_mac)
>  {
> +	struct macb *bp =3D container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	u32 old, new;
> +
> +	old =3D gem_readl(bp, PCSANADV);
> +	new =3D phylink_mii_c22_pcs_encode_advertisement(interface, advertising=
);
> +	if (new !=3D -EINVAL && old !=3D new)
> +		gem_writel(bp, PCSANADV, new);
> +
> +	/* Disable AN if it's not to be used, enable otherwise.
> +	 * Must be written after PCSSEL is set in NCFGR which is done in
> +	 * macb_mac_config(), otherwise writes will not take effect.
> +	 */
> +	old =3D gem_readl(bp, PCSCNTRL);
> +	if (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		new =3D old | BMCR_ANENABLE;
> +	else
> +		new =3D old & ~BMCR_ANENABLE;
> +	if (old !=3D new)
> +		gem_writel(bp, PCSCNTRL, new);
> +
>  	return 0;
>  }
> =20
> @@ -628,22 +648,6 @@ static void macb_mac_config(struct phylink_config *c=
onfig, unsigned int mode,
>  	if (old_ncr ^ ncr)
>  		macb_or_gem_writel(bp, NCR, ncr);
> =20
> -	/* Disable AN for SGMII fixed link configuration, enable otherwise.
> -	 * Must be written after PCSSEL is set in NCFGR,
> -	 * otherwise writes will not take effect.
> -	 */
> -	if (macb_is_gem(bp) && state->interface =3D=3D PHY_INTERFACE_MODE_SGMII=
) {
> -		u32 pcsctrl, old_pcsctrl;
> -
> -		old_pcsctrl =3D gem_readl(bp, PCSCNTRL);
> -		if (mode =3D=3D MLO_AN_FIXED)
> -			pcsctrl =3D old_pcsctrl & ~GEM_BIT(PCSAUTONEG);
> -		else
> -			pcsctrl =3D old_pcsctrl | GEM_BIT(PCSAUTONEG);
> -		if (old_pcsctrl !=3D pcsctrl)
> -			gem_writel(bp, PCSCNTRL, pcsctrl);
> -	}
> -
>  	spin_unlock_irqrestore(&bp->lock, flags);
>  }
> =20
> --=20
> 2.47.3
>=20

--e4+TuV/oChtwRV7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaagUXwAKCRB4tDGHoIJi
0mrEAP9xigTCVyOeMHlvE098qBQRl6yKonw1Z0TQr/xTdRx6RgD+MzpYwSpj+U2I
LK34zEe9HFEqW9pqhaB0uZ5qRZ2qvwY=
=FMPu
-----END PGP SIGNATURE-----

--e4+TuV/oChtwRV7D--

