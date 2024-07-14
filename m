Return-Path: <netdev+bounces-111373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F1930B61
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112641F212FB
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E3F13C672;
	Sun, 14 Jul 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="pBxxOFya"
X-Original-To: netdev@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0513B294;
	Sun, 14 Jul 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720986236; cv=none; b=LJW5Myqpyu/ntUNqYZXgwI1u9CGmrA5AaGmxvzGOQiiHdTgsXcGRfH1eXw10wD+cZM0g8L+wF1cuv1pu7+gNa7ci91S7hLSX8yu4n+6wPa0lKei6xmDJrh/vALZP5EaFoCMpkZtFx8XUWbGBFUlnG2RAuFKX1ChhPxrdgyc5RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720986236; c=relaxed/simple;
	bh=nlze4mihTBi3QvTZv100Ldq03xpcQu7wO1aJwJ6arpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVvAIihNltecbzA15+eU9C/2uJ6iDXdEREnW1768VdJcC3GdemxQ6ZPyArOUmleOcZrhY+dEqsAAbqL6Ky1BMs3eaNKwF8KjTTcjyF6fxT8QOgmdhbsP2CMbIqy3V/VxlWlbpjibjW/9jKuOlgXbEyVft9qcbUiySU79dwJOxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=pBxxOFya; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id EA6AB6356CC1;
	Sun, 14 Jul 2024 21:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1720985827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMK9o7IrpO4MqbMGDLfUl1DTeKpqT2I9IzRC/2uuvo4=;
	b=pBxxOFyaXABu6FFPGNLIf2eONRdauwxAQ3e4zfIvAB8mrsXShi34TWCRe61XoFSWqCJcpN
	ZnSkg1tm/OrnLavs0KkLkLK8U0BDbL3RriWE2WNiknT4S0bXCXqGItsV9hGshgOmIB5vFp
	xKBh5bSjG3IGknhBV632vwHuxWQAU5c=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: intel-wired-lan@lists.osuosl.org, Chen Yu <yu.c.chen@intel.com>
Cc: "Neftin, Sasha" <sasha.neftin@intel.com>, Len Brown <len.brown@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Brandt, Todd E" <todd.e.brandt@intel.com>, Zhang Rui <rui.zhang@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Chen Yu <yu.c.chen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject:
 Re: [PATCH 0/4][RFC] Disable e1000e power management if hardware error is
 detected
Date: Sun, 14 Jul 2024 21:36:49 +0200
Message-ID: <8412242.T7Z3S40VBb@natalenko.name>
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10511005.nUPlyArG6x";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart10511005.nUPlyArG6x
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: intel-wired-lan@lists.osuosl.org, Chen Yu <yu.c.chen@intel.com>
Date: Sun, 14 Jul 2024 21:36:49 +0200
Message-ID: <8412242.T7Z3S40VBb@natalenko.name>
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
MIME-Version: 1.0

Hello Yu.

On st=C5=99eda 11. listopadu 2020 6:50:35, SEL=C4=8C Chen Yu wrote:
> This is a trial patchset that aims to cope with an intermittently
> triggered hardware error during system resume.
>=20
> On some platforms the NIC's hardware error was detected during
> resume from S3, causing the NIC to not fully initialize
> and remain in unstable state afterwards. As a consequence
> the system fails to suspend due to incorrect NIC status.
>=20
> In theory if the NIC could not be initialized after resumed,
> it should not do system/runtime suspend/resume afterwards.
> There are two proposals to deal with this situation:
>=20
> Either:
> 1. Each time before the NIC going to suspend, check the status
>    of NIC by querying corresponding registers, bypass the suspend
>    callback on this NIC if it's unstable.
>=20
> Or:
> 2. During NIC resume, if the hardware error was detected, removes
>    the NIC from power management list entirely.
>=20
> Proposal 2 was chosen in this patch set because:
> 1. Proposal 1 requires that the driver queries the status
>    of the NIC in e1000e driver. However there seems to be
>    no specific registers for the e1000e to query the result
>    of NIC initialization.
> 2. Proposal 1 just bypass the suspend process but the power management
>    framework is still aware of this NIC, which might bring potential issue
>    in race condition.
> 3. Approach 2 is a clean solution and it is platform independent
>    that, not only e1000e, but also other drivers could leverage
>    this generic mechanism in the future.
>=20
> Comments appreciated.
>=20
> Chen Yu (4):
>   e1000e: save the return value of e1000e_reset()
>   PM: sleep: export device_pm_remove() for driver use
>   e1000e: Introduce workqueue to disable the power management
>   e1000e: Disable the power management if hardware error detected during
>     resume
>=20
>  drivers/base/power/main.c                  |  1 +
>  drivers/base/power/power.h                 |  8 -------
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c | 27 ++++++++++++++++++----
>  include/linux/pm.h                         | 12 ++++++++++
>  5 files changed, 37 insertions(+), 12 deletions(-)
>=20
>=20

It seems this submission was stuck at the RFC stage, and I'm not sure you g=
ot any feedback on it. Sorry for necrobumping this thread, but what is the =
current state of it?

I can confirm v6.8 is still affected (I've discovered this on T490s), and a=
s a workaround I just unload e1000e module before doing S3, and load it bac=
k after resume.

=46or LKML reference, the linked kernel BZ is: https://bugzilla.kernel.org/=
show_bug.cgi?id=3D205015

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart10511005.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmaUKNEACgkQil/iNcg8
M0sBig/9GY5XmbywcNYRllfR85OnhiIBkhfL9RW63QuVA/N1+BvHHJDMHZdh+Gs6
jhF2q29KtliUa+M+r4X1/+CbFeSuEUYsfD2u9qV6oYO5mktVCmkNQoCyx5i9PTw4
0VLYn26//BVxxGlQhhyrpfcpJ+IelvEwFxXRmiItJRgXFMaN3djOc8pUm0iEL9oc
zRXAxZx+MyJ9uV84tsO26usfgh8pXcMXusxgRkhVeNx+pwM4UhfEuIxCc//EZ2Z/
Ol4dEIfYf/3L0f+S21B1V2mGwK7pXdogH7fVaa8JWEgfxpDnZC+FsaJf7Zd8iNJC
QMDm8EPNfYupInQwq1HYt0voG6USt0d/vDgcj86iAnvvXUmOyyl55zob/GQaVLB9
juGuiQ0tDSVsnlNupNRwZTh1sLG1xPvKTOFSlahqNW5ZWLWFVr2j3LEbtXICk8/2
PBWjL3krI8z2epL0Or1qKVPsgtpWdH3Blh6Frqr1VyH88tQ6vOId3foRq+mwtOWq
kjGOzdF5EFYvoqQn/0puOWPLTosetCFYP/4hDofMRQ9gKlkVxH6d79Misx+HlpTq
zCwt09FI73nc8p7mWJUILlIUMpZzRSMPIi/JQJcqhN4/En2GZGBS4XDo6JT6/QNW
R+dc2VBNvIYhpeEb2p3En+ErpUcZbCwHqmdFV6KKtwtK0WnmZpk=
=W14v
-----END PGP SIGNATURE-----

--nextPart10511005.nUPlyArG6x--




