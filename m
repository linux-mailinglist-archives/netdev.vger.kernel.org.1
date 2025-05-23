Return-Path: <netdev+bounces-193074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA443AC268A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7163AE100
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192523C51B;
	Fri, 23 May 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4ErdVDm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882317583;
	Fri, 23 May 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014483; cv=none; b=uQ7spRwSbtDmgGDlLzN+BxJikPMvnRCMvAA1gxjUE1vzHdquOh9/XulDx2DxZ+vWd2me2y+G4CrB0r61SCkOD6mITG4e9NmRF38k19L+Dj3qlQrr6tw0Ilw0CxBBwCljF+idJIJcdFMertrclMsUUdf/m6AqznRWPuu9xKxQ1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014483; c=relaxed/simple;
	bh=F6Qt9T9axDWKZdW0V8mxJy404waRLPFG48iRbR59dpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkP21164nOEQTJVdjSIM1YN/Z71fdrhaniuJESKIwbn5Qu/8qiNS6hcsFfG9Geb72wJCQqbIgG2ASLR3JWJYWgisA5+Jcc7JHc+ALxIFbQzR6RR1uLRNqHUqz43G27d5w8rD/lYyFaC9tBQEXcVP6AdBvNL5pAnW0wFy8C98yYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4ErdVDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE6DC4CEE9;
	Fri, 23 May 2025 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748014482;
	bh=F6Qt9T9axDWKZdW0V8mxJy404waRLPFG48iRbR59dpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4ErdVDmid5x5FjBT7zdcDcwqvS6y2Zg1cGoX/3VCvsofX4TZd//EdBMLzQDfoEwX
	 qhe2Gar4rUBt/791S01+eWFT/jBP0/uupI6DLb9sO9R+NgCIWcqATQmf/gXWhcvpKd
	 ZobWmHRfj0Xl/JTccDihsbnCotdlWkgf1RAQ5Wqoz3FYBA/sH73Xp4nJ7aHjAg1ey1
	 yASJAJ7xxKpRu0veigdDSC4RMYzVE3q0w2gcul7xQsjqSdFir9Z0yc5QNaV/WJp1/o
	 x9Ujb4xNuqDZtkN0lG/dP1+x7a2jhFK09WU50SCjyIA+s9NP24yr03zyMsvy4R1En1
	 zp8nGJZZwyd8Q==
Date: Fri, 23 May 2025 16:34:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH 1/3] dt-bindings: net: dsa: mediatek,mt7530: Add
 airoha,an7583-switch
Message-ID: <20250523-poster-suffix-8a15978bc704@spud>
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
 <20250522165313.6411-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aKTWQfuzzRjxJz4t"
Content-Disposition: inline
In-Reply-To: <20250522165313.6411-2-ansuelsmth@gmail.com>


--aKTWQfuzzRjxJz4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 06:53:09PM +0200, Christian Marangi wrote:
> Add airoha,an7583-switch additional compatible to the mt7530 DSA Switch
> Family. This is an exact match of the airoha,en7581-switch (based on
> mt7988-switch) with the additional requirement of tweak on the
> GEPHY_CONN_CFG registers to make the internal PHY actually work.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--aKTWQfuzzRjxJz4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDCViwAKCRB4tDGHoIJi
0kQPAP9frHNQgSGAHPA5uunYjumQhgnmnzyhTpQjs9+iFOrwaQD/dJcW9+a4KFNn
9Mou2j6ietaV+/YWiSjzhzjlzbUPAwM=
=dZL2
-----END PGP SIGNATURE-----

--aKTWQfuzzRjxJz4t--

