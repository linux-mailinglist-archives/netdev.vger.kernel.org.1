Return-Path: <netdev+bounces-121435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A558C95D22C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBBC1F22230
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1418BBB1;
	Fri, 23 Aug 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L++hseRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA71885BE;
	Fri, 23 Aug 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428578; cv=none; b=BP6wWuc2lbkyV3mt2OTDL5V/N8FwSvgw4S7gzxmQ3Q+iOPAjyswTizHt0GO0UEwMjFagPR+I03PL3d3+BcBaxUF1Bo9DrVrdgGr8Wrcyh3elutQNzYA2nbxvRbgmzxq/Ts5/063Y2lWBtfPY+XRmAknZwuJH63lM+zeUf2rltsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428578; c=relaxed/simple;
	bh=1DkFpRNUuvVbzXLS5nkNQsNUzpujVqKCccs30oDKFrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc44QoY7+kP9R5FSJ3oGTVieT2c84voqPbHvaSkVPQJaivl6wGuCaMQilwNxi0QSFL6fcmHwocTjA/PXePEUaDZH2K4ewJ44bZUFCdabtAoYncypeNI3q4byKWQluDrUlLouuK1viUXQoKWjxAUVEhkVlFuqZm475+Wt+4DeUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L++hseRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE18C32786;
	Fri, 23 Aug 2024 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428578;
	bh=1DkFpRNUuvVbzXLS5nkNQsNUzpujVqKCccs30oDKFrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L++hseRDfFgMHYM7kN/OSwY2n/VFOY9WAkhxVgygTfLGjpOn3h9ikwZWu6iOkZQGU
	 paEtjPZC8USZsoLM8HldgNs1hFg4l3bsZR842s9jveupLAvAf0AbWHmUrXLMwUzYTj
	 s+gf4fWCYhMtQBxyJE7LR69snXLXQ7N7OXKlncHaE2BtDP4yo/YnhH+fy2vH6zkex6
	 Eg0jcSlFsu3gBH/qd5Qj6B9mCrsJY67di2SC5NtR9RtbWId9Ab8iRS7JsDOYEUoHVt
	 8DwZ4/5XnW+W2mRIP8DIEulSgH4I5lWQMI0H7VaJbljNG3zNmjy5j5McPTN+GMpQ4V
	 kG8XvsO7wvizA==
Date: Fri, 23 Aug 2024 16:56:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Message-ID: <20240823-jersey-conducive-70863dd6fd27@spud>
References: <20240822013721.203161-1-wei.fang@nxp.com>
 <20240822013721.203161-3-wei.fang@nxp.com>
 <20240822-headed-sworn-877211c3931f@spud>
 <PAXPR04MB85107F19C846ABDB74849086888F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240822-passerby-cupcake-a8d43f391820@spud>
 <PAXPR04MB85109CB5538707701F52246E88882@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ANYxDycCsQyo/fXE"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85109CB5538707701F52246E88882@PAXPR04MB8510.eurprd04.prod.outlook.com>


--ANYxDycCsQyo/fXE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 01:31:02AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: 2024=E5=B9=B48=E6=9C=8823=E6=97=A5 0:14
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; andrew@lunn.ch; f.fainelli@gmail.com;
> > hkallweit1@gmail.com; linux@armlinux.org.uk; Andrei Botila (OSS)
> > <andrei.botila@oss.nxp.com>; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
> > "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
> >=20
> > On Thu, Aug 22, 2024 at 09:37:11AM +0000, Wei Fang wrote:
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: 2024=E5=B9=B48=E6=9C=8822=E6=97=A5 16:47
> > > > To: Wei Fang <wei.fang@nxp.com>
> > > > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > > > conor+dt@kernel.org; andrew@lunn.ch; f.fainelli@gmail.com;
> > > > hkallweit1@gmail.com; linux@armlinux.org.uk; Andrei Botila (OSS)
> > > > <andrei.botila@oss.nxp.com>; netdev@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
> > > > "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
> > > >
> > > > On Thu, Aug 22, 2024 at 09:37:20AM +0800, Wei Fang wrote:
> > > > > As the new property "nxp,phy-output-refclk" is added to instead of
> > > > > the "nxp,rmii-refclk-in" property, so replace the "nxp,rmii-refcl=
k-in"
> > > > > property used in the driver with the "nxp,reverse-mode" property
> > > > > and make slight modifications.
> > > >
> > > > Can you explain what makes this backwards compatible please?
> > > >
> > > It does not backward compatible, the related PHY nodes in DTS also
> > > need to be updated. I have not seen "nxp,rmii-refclk-in" used in the
> > > upstream.
> >=20
> > Since you have switched the polarity, devicestrees that contain
> > "nxp,rmii-refclk-in" would actually not need an update to preserve
> > functionality. However...
> >=20
> > > For nodes that do not use " nxp,rmii-refclk-in", they need to be
> > > updated, but unfortunately I cannot confirm which DTS use TJA11XX PHY,
> > > and there may be no relevant nodes in upstream DTS.
> >=20
> > ...as you say here, all tja11xx phy nodes that do not have the property=
 would
> > need to be updated to retain functionality. Given you can't even determ=
ine
> > which devicetrees would need to be updated, I'm going to have to NAK th=
is
> > change as an unnecessary ABI break.
> >=20
>=20
> Okay, that make sense, "nxp,rmii-refclk-in" was added only for TJA1100 and
> TJA1101, although it does not seem to be a suitable property now, it cann=
ot
> be changed at present. :(
> Since TJA1103/TJA1104/TJA1120/TJA1121 use different driver than TJA1100
> and TJA1101, which is nxp-c4-tja11xx. I think it's fine to add " nxp,phy-=
output-refclk "
> for these PHYs, so I will remove this patch from the patch set.

If they use a different binding, then yeah, you can add use the new
name/polarity for those devices.

--ANYxDycCsQyo/fXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsixHAAKCRB4tDGHoIJi
0nW9AP4vV2xl618F6KsrE008fW2eV6kz0eQzNzhu8RDFinWI3AD/ZypQb+ffi0tz
aNX9IUGBoNG3hT1ntEDsKLnvSfZIKgw=
=iFaS
-----END PGP SIGNATURE-----

--ANYxDycCsQyo/fXE--

