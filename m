Return-Path: <netdev+bounces-118687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C473395276A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F85BB230F5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D910FF;
	Thu, 15 Aug 2024 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G6NBdMSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2E53AC;
	Thu, 15 Aug 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684273; cv=none; b=AWEdvn7OStwiwIbZ3K2E2RLCpoc5vKAwrzY1S7b76P6rJ4SxRrMnpnkiQUcDsEqgNAF5u98pRUiyIgMBGR5kAaKCj4lZ0PhV0U316xzk6ku1majbruUU+lsWMo1HKeCk1TBj3qzQ//eo/udf76CqaHsf67dWKipKD2WNbK4lhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684273; c=relaxed/simple;
	bh=dcecRVPjLIngGI1RLxMq5/GH4z1JjDZM6eoc+0xvyc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIl8MfceaasKMDaG5M/5uGfXwMCEsu3CNfXc6WQHUuKIHuZu6ozg4rW14210e+hiAy6zv9uaAtip9GrsKdXFMJ4xsFs+HKn6FPgOPKljHT9wpmAcfJ4ikl26JSznjwhd29RiR/ukIbPo2xQ9eyQdQqZ6Q7G85ryeIeEN/QiaBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=G6NBdMSE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723684270;
	bh=dqMqyY5BdvgE4KGngVIuwXBI5jdKPLu5bwHVc7uCeV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G6NBdMSEWv7wZh13H6FyFH6cv7wpTfSuvXCPo4Q/s8zrZKxA17GL8kvPT7nYTerE/
	 JOWpkg3b/vGBQbKwKHZInFWr107imDQa+8hxZyNL4f+LjrkeoKwSKx0SBoH9AGfR7U
	 mPoK14C9czlUN5uQBFcOVEebmM/wDTOxk21jo7uSacPNBemyGtScWuwK9bs/3Jchi5
	 khOEFycDvu/2k0YIvPCroYl8rKlMY/ZJE9AQm0Tp8FApkJb+MO6l0BysC17Gx5BtKz
	 7dAigZZMEDqCs7G+HX7GoZPNK/xYD9tGrInx9APyS/kB+1IMDj9ezg9AG4b+3CIejp
	 XbZcX6blvYXXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WknBP4Swvz4wp0;
	Thu, 15 Aug 2024 11:11:08 +1000 (AEST)
Date: Thu, 15 Aug 2024 11:11:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 imx@lists.linux.dev, Eric Dumazet <edumazet@google.com>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using
 unevaluatedProperties: manual merge
Message-ID: <20240815111107.15bfbf93@canb.auug.org.au>
In-Reply-To: <6b5897e7-1bed-4eb3-8574-093db5dea159@kernel.org>
References: <20240811184049.3759195-1-Frank.Li@nxp.com>
	<6b5897e7-1bed-4eb3-8574-093db5dea159@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aPD.HFt93=D=+W9o/EKyCJQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/aPD.HFt93=D=+W9o/EKyCJQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Wed, 14 Aug 2024 11:06:10 +0200 Matthieu Baerts <matttbe@kernel.org> wro=
te:
>
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':
>=20
>   c25504a0ba36 ("dt-bindings: net: fsl,qoriq-mc-dpmac: add missed
> property phys")
>=20
> and this one from 'net-next':
>=20
>   be034ee6c33d ("dt-bindings: net: fsl,qoriq-mc-dpmac: using
> unevaluatedProperties")
>
> Regarding this conflict, a merge of the two modifications has been
> taken: adding 'phys', and removing 'managed'

Thanks for the heads up.

--=20
Cheers,
Stephen Rothwell

--Sig_/aPD.HFt93=D=+W9o/EKyCJQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma9VasACgkQAVBC80lX
0Gwvkgf9HtOzYV8LuzEXP88ithcFW7/+sTYyD80bPKv6k5CXgAjVPTV2N+/SZSwr
ABrsyj6W0YBb8EAZm3C3NxBJbPNkxQ6o/d6DfK0Y3WeEd9dGaJNU3NrQ5o92vhCp
Jx819A0fCBeIwi6SmI8hbSIXZ0aHuN+2QzjqIZtlKVdWl/87osqwHVuPlVkRTy79
CIlfrpYQ7Ecpwt1fUUJTjqqOdTzXPRG2OuZzHU+pZoVxI3M1SjdfSXn/BUjL+wJ6
OGI+lML6E+0T3q/R4QT+VDxyTw+CkYShLSTQ2jfPsjBLFOAcH5RyHnDYlOs7pfGe
y/4R8xUKD/S6ZeNNP7Ttb6Y7zNM25Q==
=zKyj
-----END PGP SIGNATURE-----

--Sig_/aPD.HFt93=D=+W9o/EKyCJQ--

