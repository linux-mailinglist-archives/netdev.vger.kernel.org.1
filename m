Return-Path: <netdev+bounces-112722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998DE93AD26
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518D028289A
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1B6D1B9;
	Wed, 24 Jul 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C0YSs3yT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwUkgqQK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92584C84
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806000; cv=none; b=HXakgBDM+iN1XY8sbFZr0xleFGgyPaqtZpgLHrP1QjHJcalOPIfhnuYxHwTsUbWCivpTubTZTIKi41hM4TVUFANy0kqi0vSaiTIS0RvHpO1LJkTaA2fHXG00N4kdadsZ9BjcBWUaj3EaJ3dzlV4e9TUfIoL6tYU5rfjSC08ZnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806000; c=relaxed/simple;
	bh=AMPPFNsrMco96xV8UYl2Q3boUK/ANs3y4zpOMKkIye4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jyqi18U4oo65VbY5Tt93lg3FuvEFj4M2J9KsFrMlo/zn79QFc9Tr35Iq7KxL/dCho1z6+2oEy18uOvaxKVHRvgK+Rug03AtY/EeNxiHmuKLOw0u79B2uakabXTDxuSuPvuRF1561i0/Rz4HUxw6NYedA7e6r6aobsMFLPlb/rLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C0YSs3yT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwUkgqQK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721805997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwPcpHBB8UQw4eHBQ9hxHNDfTRztoG00yWXTlWR3DtM=;
	b=C0YSs3yTMp85z8smw547mEX4fJxzlvm9DVyXBatY5UpiYSNJz5E423bHxOQfCVPH/8AOsC
	lrXARGtga7iYG8qa+Jz9S+qwAN0VYlO0E972AlDhR4V3f/zBuCYdtG67/+tYJGIOmPUv2Y
	rzVkOoyRsPFVhxopOVxAjNk+CY7cqF9dU1dLVB1PWtBD30DXORMZJFFzDFSeHRHfQg1wNF
	jjK112gocu8Go+vpjkqMIQt8Uptmc1/SbJe83SLygRjsCM8aMcxzymTGHz5RfvnQClpA/Q
	MySsJPzYvq2mPOkkmMC8ukTt4QvyWS0ugTQyORNogAU7roFoboEo18aqiST3Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721805997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwPcpHBB8UQw4eHBQ9hxHNDfTRztoG00yWXTlWR3DtM=;
	b=hwUkgqQKeNZAhfOKnkPaWr8313ZfX6HRxpOCJrrOl2QlRJMxcip7+tnhwpuD0TBELzNXkF
	q4Gu+5C1tu53tBAg==
To: Brett Creeley <bcreeley@amd.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igc: Get rid of spurious interrupts
In-Reply-To: <3f8aef95-e7f8-4c47-9b19-a2ba90c4a532@amd.com>
References: <20240611-igc_irq-v2-1-c63e413c45c4@linutronix.de>
 <3f8aef95-e7f8-4c47-9b19-a2ba90c4a532@amd.com>
Date: Wed, 24 Jul 2024 09:26:35 +0200
Message-ID: <87cyn3jln8.fsf@kurt.kurt.home>
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

On Tue Jul 23 2024, Brett Creeley wrote:
>> @@ -5811,11 +5815,29 @@ static void igc_watchdog_task(struct work_struct=
 *work)
>>          if (adapter->flags & IGC_FLAG_HAS_MSIX) {
>>                  u32 eics =3D 0;
>>=20
>> -               for (i =3D 0; i < adapter->num_q_vectors; i++)
>> -                       eics |=3D adapter->q_vector[i]->eims_value;
>> -               wr32(IGC_EICS, eics);
>> +               for (i =3D 0; i < adapter->num_q_vectors; i++) {
>> +                       struct igc_q_vector *q_vector =3D adapter->q_vec=
tor[i];
>> +                       struct igc_ring *rx_ring;
>> +
>> +                       if (!q_vector->rx.ring)
>> +                               continue;
>> +
>> +                       rx_ring =3D adapter->rx_ring[q_vector->rx.ring->=
queue_index];
>> +
>> +                       if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_=
ring->flags)) {
>> +                               eics |=3D q_vector->eims_value;
>> +                               clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED,=
 &rx_ring->flags);
>> +                       }
>
> Tiny nit, but is there a reason to not use test_and_clear_bit() here?

I believe that question was answered by Sebastian on v1:

 https://lore.kernel.org/all/20240613062426.Om5bQpR3@linutronix.de/

Other than that no particular reason.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmagrKsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtqlD/9840bSvad5sfDPGwDqHEMRVD28DlrR
riWOVpqpBnhm4bdneFbVaMHZCCAQuErE1e1SB0J3wowtSj7Du/+JjXgtvKeK/T1L
Zp4+oNlaYk/JzujT+ldKGBoRMXkilWa+OoFZJl9T0YApVjvFllgtg3ow66YsSc7m
PDznjOub+nRHyDipug12pnQehFCXsrqnB5fO6vl9B9FwokANM7Dz8jqsbELlX+Ds
OHCL1qPapGS618sno+UbGCGr7XYHnGvPA4uf4EKVmM3bkKDPSS83vQKHXc9BwLUH
P8OblHFlJfLrKwgztMYz43RpjReUELTWTbzNYb0gX6/zxdVNr/F6t61VvadOFcri
kqwR3L4avowLrncGPIDyzOtSYhjgIaSXu0c5v6QURZ6tDQWJ4TUKj55wVGdRq/py
fs+Wc0YGBUx1elcbRPLJxJ2NNshGmPd3ckne+oma5TEONuLSK/XpO5aZ2oxpD6X9
fnK29RKxnbFI8ElLZvashq+C3/IerxcFW5zA0jz+Zpd8l7c/kMvnV/j2LrbnVK5a
Yu79PSsRhSTCg3unge3aiXFK+ID1VZohLqYwwDdXXvJ9TyqYrdqOWJOCQKqgK1E2
VVWe2aBmgZAu1CxtoxIOHs1oydtjt3k/kxJT7Wo3vZmCVjMIUyUS/hi2RlhEiImz
dRQXFNXzhsqjpQ==
=6Gdp
-----END PGP SIGNATURE-----
--=-=-=--

