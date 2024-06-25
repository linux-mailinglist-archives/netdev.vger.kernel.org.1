Return-Path: <netdev+bounces-106568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019E916D9D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF57728D62F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600B61FFE;
	Tue, 25 Jun 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa6o1FoU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1C7FD;
	Tue, 25 Jun 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331238; cv=none; b=h/nk3climhV9ymggM94ga1AHnldTOrX128ofGcFtMo4Q7DtAW+MHDLhLIGw/f0nP2T9CfbE9a8a0m2KgfC3h8kA6Ui4j9C/OTiK0pnW8XdfdFfyKD+1g93+njKe/1aezu+eglKWPHyhfg4a+iTYOuSuwIbpLUBmLdTHgYWNWp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331238; c=relaxed/simple;
	bh=sx/Sgu2zVexidr0e78d7Q0hdZTohsDJNYxZNJiQaDaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoOzj7o5KThO0DhyHzuRvWVeaUVbgyA4P+LMTDk0c6F/UlJt1B2ojgsVHNWF6CnYIHkhUHAz5YTSkg7IpKQ3h3WOzqoFXMgnhUpPeJ0I7Da7OGFyzaYiylcgzlzb8aMcc4CUMms8uxhNLTtGrPf+kqZm0fixATUumX28pKJG30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa6o1FoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05D5C32781;
	Tue, 25 Jun 2024 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719331238;
	bh=sx/Sgu2zVexidr0e78d7Q0hdZTohsDJNYxZNJiQaDaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa6o1FoUsO/Sp505hTm29y18Lo/Rltp5dpBDd4UW2av9eBN2v6Imq9j4cZ0X/CB5m
	 +kzxuGRNnd132A2hlWTncI7py3CmerB6MX8Sqz+ZrTglp1A89NMiwlWtaVh1T/gIF6
	 6VklMyE5BQScupkJinY9PBdqxapKd9dnm6+Z+vQWf4widCWAu20MKraXdOiuRnNfDu
	 rDOi2sk80exqC/JcUx9IHKt7s0wrl9H+lmPpzpDVZBauvoLwsfpF/rZq4/urWTaBIo
	 iAF7v+Nu59IAz95sDAYoy0XfaLiFzsaxxk2Nxdem0MLqU2sT+43tpY2TkuISscAgyh
	 8qiORVuTc/mdA==
Date: Tue, 25 Jun 2024 17:00:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2] dt-bindings: net: dsa: mediatek,mt7530: Minor wording
 fixes
Message-ID: <20240625-battle-easiness-7ac3e81c2d6a@spud>
References: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ns1bPUFGUN+nbcz0"
Content-Disposition: inline
In-Reply-To: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>


--Ns1bPUFGUN+nbcz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 09:18:57AM +1200, Chris Packham wrote:
> Update the mt7530 binding with some minor updates that make the document
> easier to read.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>=20
> Notes:
>     I was referring to this dt binding and found a couple of places where
>     the wording could be improved. I'm not exactly a techical writer but
>     hopefully I've made things a bit better.
>    =20
>     Changes in v2:
>     - Update title, this is not just fixing grammar
>     - Add missing The instead of changing has to have
>=20

I don't really want to ack this, a 4th ack for some wording that has
no impact on the binding itself just seems so utterly silly to me...
Instead I've spent more time writing how silly I think it is than
hitting the ack macro would take :)

--Ns1bPUFGUN+nbcz0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrpnwAKCRB4tDGHoIJi
0lhUAPoDy72HR6FZqbTZ9VCwwM+664FV/l5ZosGtfzIwwNtHDwEA3erCBpYxanRS
dXx0JBUj4DkqzhTFirctNFUCIuUuBAk=
=gPM2
-----END PGP SIGNATURE-----

--Ns1bPUFGUN+nbcz0--

