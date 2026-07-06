Return-Path: <netdev+bounces-304832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VK68Ma84S2pnNwEAu9opvQ
	(envelope-from <netdev+bounces-304832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABE70C875
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:10:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.dropbear.id.au header.s=202606 header.b=gEa0qIiW;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304832-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304832-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E5403009144
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 05:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65F3B3883;
	Mon,  6 Jul 2026 05:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC381A316E;
	Mon,  6 Jul 2026 05:09:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314603; cv=none; b=grs28Jc+75WJFFqS7V3ZcpEr0vNIQe4ueB+Ebpt8BbDoI/JaIDFLNSWsPtdBFxHCcfLjatoAg488pbzevuKvmaKffieotbZ0xpi7NrZYBvmIBBJ6V7jCtElo91qySlo6sKsIYWf05bVEOBHmHmW0MDoFb2kEwzfFmpa8yaY5ZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314603; c=relaxed/simple;
	bh=TzEV38N0fQm7TuKomVm1d0gtrUP+oGTdRReoy1Bv9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYWI0oihqOZBtk96hcgL5MYBY9p1wdP/oexzm0of8LKZjhmtFMFd8LEUMlZViX8vX0JOPUV77R7vNYgOnVdStXSqIUlPuobs97toFBmjRTODsLioArl6LxNt6GK/RQpfYI7J2HQYwFb2rNnsciyLtZsVkujuWh+Wuc3YLbIGEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=gEa0qIiW; arc=none smtp.client-ip=150.107.74.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202606; t=1783314591;
	bh=+n/qI825Jj03eEuuMZj/pF5Wn17cJq07JymR5XMV3zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEa0qIiW6Twgn979ieahJiK0gLEQH5KVlCz9eNbPz46Czm5c1QueZUskQGHA/qE/x
	 P3KmjZqIDLqNgCNZUpDarKwQf13+S75A2pGxTSt5dypfyZbBxAkrODxWtDaySLFJPe
	 bnyu9kZflEolLWgFDaISbt7YbIEaO0S1YebhdwQr9TKZ3WW4SGMLQ6N+RZEFp6+/uA
	 Bmy2JUtVgXzXaTzXl+9+GCUomJ+wMmbBeWYeEUQdtDotSoYRpt/aW9wxYAp1pa8Bzj
	 bpYEPq4olRJ7Bl4vec3I5O8gCdzQgdOEvl6UNu/+PY4C93FWjsfLFIWUynOBxB36j7
	 5p9ZArzzRByeg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gtsqM11GMz4wMG; Mon, 06 Jul 2026 15:09:51 +1000 (AEST)
Date: Mon, 6 Jul 2026 15:09:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: emac: mal: fix W1C write race in ICINTSTAT
 clearing
Message-ID: <aks4l2Td3cS9srTe@zatzit>
References: <20260704032146.2307296-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbd+X9hpns4orx3x"
Content-Disposition: inline
In-Reply-To: <20260704032146.2307296-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202606];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[dropbear.id.au];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304832-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,zatzit:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EABE70C875


--kbd+X9hpns4orx3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2026 at 08:21:46PM -0700, Rosen Penev wrote:
> The ICINTSTAT register is write-1-to-clear (W1C).  The read-modify-write
> pattern in both mal_txeob() and mal_rxeob() can lose interrupts: if a bit
> that should not be cleared is already asserted when mfdcri() reads the
> register, it is included in the read value, retained by the bitwise OR, a=
nd
> then written back as 1 - inadvertently clearing a pending but unhandled
> interrupt.
>=20
> Fix by writing only the specific bit to clear (ICINTSTAT_ICTX for TXEOB,
> ICINTSTAT_ICRX for RXEOB).  W1C semantics guarantee that writing 0 to the
> other bits has no effect.
>=20
> Tested on Cisco Meraki MX60. No issues seen.

Can you elaborate on what that means?  On the face it sounds like you
made the change and nothing blew up dramatically.  That's much better
than nothing, but since the original version also apparently worked
well enough to get by for years with no-one noticing, it doesn't
(alone) give a lot of confidence that the new version is an
improvement.

Or, did you mean that you observed dropped interrupts before, but
didn't after the change?  That would be much stronger evidence that
the change is beneficial.

> Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: mention that this was tested.
>  drivers/net/ethernet/ibm/emac/mal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/i=
bm/emac/mal.c
> index 74526002d52b..e88e4a1ddcd4 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -282,8 +282,7 @@ static irqreturn_t mal_txeob(int irq, void *dev_insta=
nce)
> =20
>  #ifdef CONFIG_PPC_DCR_NATIVE
>  	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
> -		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
> -				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICTX));
> +		mtdcri(SDR0, DCRN_SDR_ICINTSTAT, ICINTSTAT_ICTX);
>  #endif
> =20
>  	return IRQ_HANDLED;
> @@ -302,8 +301,7 @@ static irqreturn_t mal_rxeob(int irq, void *dev_insta=
nce)
> =20
>  #ifdef CONFIG_PPC_DCR_NATIVE
>  	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
> -		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
> -				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICRX));
> +		mtdcri(SDR0, DCRN_SDR_ICINTSTAT, ICINTSTAT_ICRX);
>  #endif
> =20
>  	return IRQ_HANDLED;
> --=20
> 2.55.0
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--kbd+X9hpns4orx3x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmpLOIYACgkQzQJF27ox
2GdWGhAAkrewJrncnPj0zs9cGyMbMk0C/kY80DtKuHPGUZE6+qDENjlRukq+f7v2
emjz/cnp5MYu+T5vpgG9pceEqHpPkbyA8kDvN+/pZivJBqqSAeulD06Mno917Byz
XrsyoZ2I9CkAZPX1zTGV2tuK13JbqDN0UR5nHO/T0EztUX/5nTqyxzbT1c9wWA2N
vQjZ2UZWPxh9DmrlW/ZMc2I3UWogZ7vsp40cJr+bmMrO3YuGQZP7A2u/fl113b7T
GjqqzoABerV4QYjSGJvpxoo7ujT3pTNi9+ED6R9e6GG+ImR77c61ymkbuNG+8pl0
6x/BWu6yIGZKg+3qMpFKvYh3MZjULiPF5G2xaiGOsmZfLh0zbVO3Q3sPJadn12wt
ohYNTn3y6Fg4ldK1RaQQbH+DAD06jSriSOyBh4REYtnLGA1cVEWNiqlGxFz5Na9/
xgYAZKSpeTeBFfMqKQV1B9PFL4gsrNmD1ep4Tq8vXg7y5uyHvdCZaC0qS/ETHEcO
DKgx46NxxWBIVDYdJid6tdzxnw2Y6shFyomARPe6upbDLRD58A0Q+5RLn6NHUljx
xpnWzDlOn5lcSDu5hPL6H6rP3dzWMc1m+L35YxNQ1T08XJIZ9XohCVNVPcBPF11D
3PzHdGYR0mo5MHydRQ3XRccgwviUKo239H1qu7nHd8ZEXtb7WvY=
=9Ztb
-----END PGP SIGNATURE-----

--kbd+X9hpns4orx3x--

