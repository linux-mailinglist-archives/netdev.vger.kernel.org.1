Return-Path: <netdev+bounces-167636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D3A3B2AE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C63116C903
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2A31BEF71;
	Wed, 19 Feb 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHu7y0LH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVhfX6yk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6919DF42
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950866; cv=none; b=Sx+rjY40jRiLQDKNKA2sB6MyaiiV3XT7ceLbvmEO1pDofQFOF8VfbNKeN9RJytxbrvJJmp9uzeTcBiKpcJAYpu5VMQR+ZVPApXKUvfOaEm2vrnjv+HVnsyyvX7vZBsrI3Oli5v9+CssMhszpqfOLVICFMi6YWA9s9AtusOuO3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950866; c=relaxed/simple;
	bh=Vaf3ESipfj8oiaiG3tdDYynYRAwolqolb2pXE/BLSnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihBk8F/C+QlSG3P4TmlnwF5eNLtemirGsSt79cKF+df3m1imGvDadSIO15hQcaoAHrpJQIIrKSx69D9s11Vk1Syx2MtJJL3uODCX4NKG+TmmpAMOB9TtCpT3t9+eXF2A12LA8qi7NwkQceRqqZSnYfdL4509AQ2AXT/RWbBDXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHu7y0LH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVhfX6yk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739950862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MXOl5x0hytxt1TgAj3QbAK7ZAvG/bSYGzXlYGKLQzM=;
	b=AHu7y0LHsQL0ITATUVvgu1cu0PzpWV8PYSH3C3EgxthQTDmBctUthNS8rWS8alcdmM8tUE
	+GhQeiPrp1fQkvCVWEofUZELHaIeEENIpCL/gLVJRMqyt2Ws/foFHo6fH/iP8YJtdYZfGk
	G28M3zptSbrTUfLCmMjsJqtlXX3tuOVFnBTa/vP9kZbegtKXwKE5TroKs0A7qmEcBx5mXu
	U2NVzmNau+x5kji048R6zC3S5gCaPsTuAqrCk7XfwpheXmrw+U1POaXqHojOSIq1mIIwDy
	PQvRh8wZcS4p/enwUw+8m0d9uAyRVsxX9mQajCzDyRbPIYfACMyF0+ufrIDAaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739950862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MXOl5x0hytxt1TgAj3QbAK7ZAvG/bSYGzXlYGKLQzM=;
	b=XVhfX6yk6F4yD4/jp/sR5bsekA1xMB8C9xcerBjqdrlO3wFtNL8nFEw0MExtOxAt+noB+V
	Plrqrvxa/Oza0bCA==
To: Joe Damato <jdamato@fastly.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Gerhard Engleder <gerhard@engleder-embedded.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/4] igb: Link queues to NAPI instances
In-Reply-To: <Z7T4Cpv80pWF45tc@LQ3V64L9R2>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
 <Z7T4Cpv80pWF45tc@LQ3V64L9R2>
Date: Wed, 19 Feb 2025 08:41:01 +0100
Message-ID: <875xl62xgy.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue Feb 18 2025, Joe Damato wrote:
> On Mon, Feb 17, 2025 at 12:31:22PM +0100, Kurt Kanzenbach wrote:
>> Link queues to NAPI instances via netdev-genl API. This is required to u=
se
>> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy poll=
ing
>> support") for details.
>>=20
>> This also allows users to query the info with netlink:
>>=20
>> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netde=
v.yaml \
>> |                               --dump queue-get --json=3D'{"ifindex": 2=
}'
>> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
>> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
>> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
>> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
>> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
>> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
>> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
>> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
>>=20
>> Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
>> requires the lock held.
>>=20
>> While at __igb_open() use RCT coding style.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>>  drivers/net/ethernet/intel/igb/igb_main.c | 43 ++++++++++++++++++++++++=
+++----
>>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  2 ++
>>  3 files changed, 42 insertions(+), 5 deletions(-)
>
> [...]
>
>> @@ -9737,16 +9765,21 @@ static void igb_io_resume(struct pci_dev *pdev)
>>  	struct net_device *netdev =3D pci_get_drvdata(pdev);
>>  	struct igb_adapter *adapter =3D netdev_priv(netdev);
>>=20=20
>> +	rtnl_lock();
>>  	if (netif_running(netdev)) {
>>  		if (!test_bit(__IGB_DOWN, &adapter->state)) {
>>  			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
>> +			rtnl_unlock();
>>  			return;
>>  		}
>> +
>>  		if (igb_up(adapter)) {
>>  			dev_err(&pdev->dev, "igb_up failed after reset\n");
>> +			rtnl_unlock();
>>  			return;
>>  		}
>>  	}
>> +	rtnl_unlock();
>
> Does RTNL need to be held when calling netif_running()? If not, you
> could probably reduce the size of the section under the lock a bit?

All the other instances in the driver guard the netif_running(), too.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme1iw0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgh6lD/9WWV/wxz4UD7aPbEoGlB9Kdg2kdxlc
0cQhUG/k2MS7Qft0rFt/lZKLUwOrHgu0tvDl4CqOm3SdcLSnOMWAZTKtgXh6m4MH
r7eYW38Ol7HQlzH1XnExUdKwttMY5U3SIuua8d/3L9NkKI46yPXEY6YnkFi450i9
lB1NYCM6SUdCXAS5g3syKb9KhlFTjfq+o4sBdk/okU7fv0hHIGHFmlS8a8PtDIEI
DxROpHcuzJ86evCiXbv4Q7AHRWEvLG6LoTpM0SAxe03usOYVaLw/4g9NYfzfJDj2
Acg4H2iXmcuH5AQ6dNq2C6U1yOY6ILjYSHWDwB9pYzygcRsJwbF3RUP0jx98GMpv
Thw0MwoZfd2jAlfGJmin9FOLOAwu046f0m5+qKuz48obail2GAbn9C0p7rHdBuO9
o+YeqyN0oaPHXi7H8FcFWmefUba/Gs6SR0Cvj9AJ5wotTV2HOf2gbDMcudVeI3Ij
gMh9K1jbhVlt5vc5E5auBKydCplni1HD1ftrClzj+O9bMsBFMuacAwAWTKMk6MiD
VWl9+iGf2B1iXR0tona5Q/211YifOMdeYlXdCn9Olro3tsRqMZfVRo10WU/OBTiE
MPbMIUnsgOOkPvlvBmkg+T37FMT37R3twWPuLef4PsUOge/pdFcFGd0JcE7ES/J/
icZzSdCfxdKvDw==
=alsw
-----END PGP SIGNATURE-----
--=-=-=--

