Return-Path: <netdev+bounces-112409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D2938E08
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0462D1F21D1D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE716CD11;
	Mon, 22 Jul 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X6fYLEjP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301416C69D;
	Mon, 22 Jul 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721647651; cv=none; b=mX+5eO0ZGnWlSUmmwySUHHdHjriLsMSZRZ7K7T1mDgSQGDT5XGKl3rMDU5+XINo9L0l2GPFqgCT+yXGP31JtRdo7l4rUqrVBubLF433bO3pFjdGNvlSu1sfaIkf7Usn4R0qBM0UNvIlu9Yn50BDUYnvNsKD8RJpuNtcM90dS2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721647651; c=relaxed/simple;
	bh=oSFS6BKeTNkRmRISdy2XuP1ZlR2B9rYB5jttdbfekFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDX9cU19/sHTDqNHhZPWsLOXY3Mj9bvx8EstONm6K/EVtB3tFBpmGFk2EmRemElE3RDnygS1HiGMIR5hFVniohFq0XfLn3N7GQ1BVHMC8YYIEtqqJEV11U9mc2MpfpPJ6+3xAhh991ICMTFvNrsZ4cdN7riidL2leH4WwKXCRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X6fYLEjP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721647649; x=1753183649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oSFS6BKeTNkRmRISdy2XuP1ZlR2B9rYB5jttdbfekFU=;
  b=X6fYLEjPi7HFq8ioKRIjgIu275Uv5j/l5iTW9icJqrebRlxihGpk5QZc
   IPVIbjKCB8W+DWRFdi19q6DXEz22B1PyXab13f4mJDZ++aw9+c/NqJ8yo
   /XmNGNGGcM/p1la+KfMCPsJsgjlUqCveT3bjImgR6b3VCNmQT8q3NgchQ
   MMUDPQ4sXrd/HIZKny315k5wz8N5BRVXpXAkYgyxlyjFheENBC+DW4O+F
   FucGMfGJrTDb/Vo4Ec/ar0D3IRQMLYnuNphvy/ousvb8bHbr/LtzjZqoj
   iPP62I/gwVNVDV9fheJk+ThgZ+0iZEO56fWjCAfbobNOpmZXJiMUAAGTt
   g==;
X-CSE-ConnectionGUID: RvxkDqJwSEWy6LC+mcvpxQ==
X-CSE-MsgGUID: Y8qXXYTXTpeNozkUlNItGg==
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="asc'?scan'208";a="32268731"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2024 04:27:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jul 2024 04:27:22 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Jul 2024 04:27:19 -0700
Date: Mon, 22 Jul 2024 12:26:55 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Ayush Singh <ayush@beagleboard.org>
CC: Conor Dooley <conor@kernel.org>, <jkridner@beagleboard.org>,
	<robertcnelson@beagleboard.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder
	<elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<greybus-dev@lists.linaro.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: ti,cc1352p7: Add boot-gpio
Message-ID: <20240722-system-judge-bf59954dd79d@wendy>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>
 <20240719-scuttle-strongbox-e573441c45e6@spud>
 <5a865811-a6c0-47ad-b8a0-265bb31d4124@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRMCmbeuxHenOfMm"
Content-Disposition: inline
In-Reply-To: <5a865811-a6c0-47ad-b8a0-265bb31d4124@beagleboard.org>

--nRMCmbeuxHenOfMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 04:15:41PM +0530, Ayush Singh wrote:
>=20
> On 7/19/24 20:25, Conor Dooley wrote:
> > On Fri, Jul 19, 2024 at 03:15:10PM +0530, Ayush Singh wrote:
> > > boot-gpio (along with reset-gpio) is used to enable bootloader backdo=
or
> > > for flashing new firmware.
> > >=20
> > > The pin and pin level to enabel bootloader backdoor is configed using
> > > the following CCFG variables in cc1352p7:
> > > - SET_CCFG_BL_CONFIG_BL_PIN_NO
> > > - SET_CCFG_BL_CONFIG_BL_LEVEL
> > >=20
> > > Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> > > ---
> > >   Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b=
/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > index 3dde10de4630..a3511bb59b05 100644
> > > --- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> > > @@ -29,6 +29,9 @@ properties:
> > >     reset-gpios:
> > >       maxItems: 1
> > > +  boot-gpios:
> > > +    maxItems: 1
> > I think this needs a description that explains what this is actually
> > for, and "boot-gpios" is not really an accurate name for what it is used
> > for IMO.
>=20
> I was using the name `boot-gpios` since cc1352-flasher uses the name
> boot-line. Anyway, would `bsl-gpios` be better?

I dunno, I think that "bsl" is worse.

> Or for more descriptive
> names, I guess it can be `bootloader-config-gpios` or

> `bootloader-backdoor-gpios`.

This is the most descriptive and therefore, IMO, best.

--nRMCmbeuxHenOfMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp5B/wAKCRB4tDGHoIJi
0oboAP4k9VbBxBuzy2qiVbT0/yJkAqBPbUXsQ7j6d1Y+IT5B8wEA+Bku/MTCCpAd
L0DDz0l+Vc3aeJsXDqqAnKbeSXHiWgY=
=N3aj
-----END PGP SIGNATURE-----

--nRMCmbeuxHenOfMm--

