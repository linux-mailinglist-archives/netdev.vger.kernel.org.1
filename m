Return-Path: <netdev+bounces-306339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gvDQAYTkT2phpwIAu9opvQ
	(envelope-from <netdev+bounces-306339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:12:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F173427B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:12:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gGDgNua5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306339-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306339-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477D13005392
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0DC4DBD68;
	Thu,  9 Jul 2026 18:12:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1954DBD60;
	Thu,  9 Jul 2026 18:12:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620734; cv=none; b=GQVahcJfXsP5eqGL9m2aVKarHuFqhHRIlI1HyA9nxMpsLx69tJx9Tfp0NFfv4qEdwy6Pbzns7vnOrwS/++tXL5HqOgfMDcE8oZK7RrG3jKmTwUzQ2/Azf3vFiUwopeOCyEffNXJJ4+wwaYR+fWwHfZf75qMec1Hax71FfOzforM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620734; c=relaxed/simple;
	bh=gG/aMUL9K6J7MQeQ3D/OrW9+BsX4y94z01HtY4iuQps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqQpovp5J5nKLSj34w5k3ckJHuGJ1TFVBVT3JJTw/ZiqJqo+1UpHEpK2qgBSk09oaCpjUhaklPcjLpD/W8K+vOV2k/btlJhcz2IQ0Aic/05Kw7Y8zHuRS6Zo9k1U6dQCiAGUuhpoJEeJ0bGx8bwrL3IDsKjgKKbMdHkXkrAKHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGDgNua5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDAB1F000E9;
	Thu,  9 Jul 2026 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620732;
	bh=N6ExRqFYusMX+tjVg7cG0UAnunHkBLlwLxZ3V0z43Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gGDgNua5r/LnOAlUxg9BTyvo5mQCvFnGTGo2oOO+5cSHjWM2J1jOjdJw8UPmHQnVV
	 NlH8GCheUps5nixZGBXCLRI3924QII5l9IIy6oTlD/eSL8YAg/U1hW6gwouU13vVUF
	 lRUFbx29bdoVukedcHBj7JgWIYnmDfE4d2QatHh/DGoODhpiv5Pzfzd840SDSL6xvZ
	 BFBh57Rc5mmIG1MjI/a3Xxt4g6W8VF+0TlOkcDDe8LxtovAtURy5EqMo6DtEi1XVXq
	 uXMngg8j0bC9Quvo4bGNhGf9LY1O1H6Wd0B58owsFccwEEd4vh4py600QE4bLMDEm0
	 lO+sQU8ACHo6A==
Date: Thu, 9 Jul 2026 19:12:07 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Irving-CH Lin <irving-ch.lin@mediatek.com>
Subject: Re: [PATCH v2 08/18] dt-bindings: clock: mediatek: Add MT8189 clocks
Message-ID: <20260709-omission-thievish-45fb4b21f4a2@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-8-2926da3db6cf@collabora.com>
 <39ba7e37-bdd7-41ab-b72d-fed0bdbfc3b6@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UX1C2aIXjTZQUR6q"
Content-Disposition: inline
In-Reply-To: <39ba7e37-bdd7-41ab-b72d-fed0bdbfc3b6@collabora.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:angelogioacchino.delregno@collabora.com,m:louisalexis.eyraud@collabora.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:irving-ch.lin@mediatek.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306339-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,baylibre.com,kernel.org,redhat.com,gmail.com,mediatek.com,pengutronix.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,spud:mid,microchip.com:email,collabora.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 793F173427B

--UX1C2aIXjTZQUR6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 04:05:35PM +0200, AngeloGioacchino Del Regno wrote:
> On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> > Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> > The MT8189 clock IP provide clock control for main system
> > (apmixedsys, topcksys and vlpcksys) and subsys (eg. peri, scp,
> > ufs...).
> >=20
> > Also, add compatible for frequency hopping and spread spectrum clock
> > functionality and reset controller header file for MT8189 UFS reset
> > controller support.
> >=20
> > Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>=20
> Both the commit description and title are misleading, as in, you're not a=
dding
> MT8189 clocks, but *both* clocks *and* resets.
>=20
> Fix it please.
>=20
> After which:
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

And
Acked-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: changes-requested

Cheers,
Conor.

>=20
> > ---
> >   .../bindings/clock/mediatek,mt8186-clock.yaml      |  15 +
> >   .../bindings/clock/mediatek,mt8186-fhctl.yaml      |   1 +
> >   .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   5 +
> >   include/dt-bindings/clock/mediatek,mt8189-clk.h    | 433 ++++++++++++=
+++++++++
> >   include/dt-bindings/reset/mediatek,mt8189-resets.h |  17 +
> >   5 files changed, 471 insertions(+)
> >=20
>=20
>=20

--UX1C2aIXjTZQUR6q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/kdwAKCRB4tDGHoIJi
0nERAP4kLU13u3da3l4qcBWIw/VmYndpJtfFXpU6Zgypf9MYBQD8DwkM+FWeYAyD
xhlJbInggvLHDfXzemV0LCSaeSizQAw=
=+U1Y
-----END PGP SIGNATURE-----

--UX1C2aIXjTZQUR6q--

