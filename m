Return-Path: <netdev+bounces-21730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD376483D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A7D281E4E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CCBE79;
	Thu, 27 Jul 2023 07:16:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C303C16
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:16:13 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06649272E;
	Thu, 27 Jul 2023 00:15:46 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1690442143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8m3mzI1aA9mXZdzH6s+hpaz9dxHNXMPqBJ1rzdpS2jo=;
	b=SF/iTuLcGPGtPtCRUUxAfd7TRft7VufsFPz8Dn9tTB+d/DYg5t4SDusksaNaoaouk1XFtd
	YSg62oPI/yr0Jtu1kMlgeyKYK/QSRkE4hWP/fGJRh+zB5e/W7Qzg+vzMDnsu7XDR43MAQ+
	H+a7ZLtqUCYDwPFD6lvR4IaXmb/XYdyj6TQxZXxRapk6fmw2wFmy+hdMOTkNA4qHvzDdKZ
	dO6tZ2LI1qJ/QBsJQwdw4hQZRdohZVGvT0rytHwN+DWdP1fH12BOZ9ovBl7M77TPnzDkxC
	SnNClZItl4/H0L2BP/MzKD7rhpOIjzAJ4zzCefcClDS4m8v17glRy9eGvSM7mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1690442143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8m3mzI1aA9mXZdzH6s+hpaz9dxHNXMPqBJ1rzdpS2jo=;
	b=C2TYWFLd+lhEgNYUYAw7Am9SDW+imtlZadp4yG+KgNTlxzAJVbDMe/EicMrkuBDg4fdjXx
	/nIOSvFayC0i8mBQ==
To: Johannes Zink <j.zink@pengutronix.de>, Richard Cochran
 <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Russell King
 <linux@armlinux.org.uk>, kernel test robot <lkp@intel.com>, Eric Dumazet
 <edumazet@google.com>, Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 patchwork-jzi@pengutronix.de
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
In-Reply-To: <8742d597-e8b1-705f-6616-dca4ead529f4@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
 <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
 <8742d597-e8b1-705f-6616-dca4ead529f4@pengutronix.de>
Date: Thu, 27 Jul 2023 09:15:40 +0200
Message-ID: <873519u8o3.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Johannes, Richard,

On Thu Jul 27 2023, Johannes Zink wrote:
>> BTW this driver is actually for an IP core used in many, many SoCs.
>>=20
>> How many _other_ SoCs did you test your patch on?
>>=20
> I don't have many available, thus as stated in the description: on the i.=
MX8MP=20
> only. That's why I am implementing my stuff in the imx glue code, you're=
=20
> welcome to help testing on other hardware if you have any at hand.

I can assist with testing on Intel real time platforms, stm32mp1 and
Cyclone V (and imx8mp). Just Cc me on the next the version of this
patch.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmTCGZwTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpkDD/0XLGgz0IfBLidKI4LeAHxLFHmXdMLs
r/y2GNDHujOGXMKWcNMlZPAkNGQ4Vg7FbTNuke6amJZGsF7UzePbqaxjLYwAa8cE
lqq/BnuJ4Q8amgFisK5w9evKSlKIvLhO5keflLpf/tfCrKRiGM3eA4b0JTLN/IJi
FLYbbK/y1TreFttirsnl8HIaEZJg1y8b5b4YcSM/EGpae76QNtsig6MZLTnAyaPv
bwLN+S1qDSVFfZ8oNo/+Mu0v8nce4N38MWsumSho4a9vqGs1R8r7mFBPxZOZnCFx
XaXxJrkciNU4NydVBKRAG70EgDR10/8+Bm2DHqOAUhmX2PP/TGDROAzZaIRbVDOt
gRSaYdlB6+T8zc0JY8+ASkf3I1himqgr8ZOtgEBtqPlOoU/8EislrHH6lfN57lY3
/ymnkrscBIOQy/PDMT20aON8ERnsr/WS3zE7HtD5XE71HoMCspNtBSotxBAo/eyt
knqNN5Z+RWh7W/+hmXA8LUiNNvk2JKEuylei5XPWD0WbIrr0kkb+TdUKnwum0bbT
4tDTOsluKkImHl1GxsCVPPKlHX81SqBs6QOlt+vW3Fbx8gH06VTSC4guUW0y6kf2
VfsxsC23638zsie0jUAr2otpRj6mxAr32iwDekWt/manauTzBAEOFQYMFz2XYVR/
sHGpI9yCoIVfXw==
=7Odq
-----END PGP SIGNATURE-----
--=-=-=--

