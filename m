Return-Path: <netdev+bounces-216448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16447B33AB1
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DD9168B15
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3095283FE2;
	Mon, 25 Aug 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGt0pugQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="46EqGMpo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A3280CF1
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113781; cv=none; b=uLQCsHHTB3HUeEzH1Tb7Cq/Gbccknb9Lz9BnMcBrnk742xkdPRliGFxW4Sxm/FvcsLPuKjhyJmioGE3nUbnzqnyWk6y09NPkXOl45OzC54Pun4zRN5coOMjmh6Q2sl4IeMyeI1pu5QDoYKOcujty5qHA2DOTT28ApRjeJbtnogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113781; c=relaxed/simple;
	bh=OldsM0mTe0gUZlhTr/mMd3s5ex5qEiHcv6VNhYROMGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXDEqtgPG4raLy8S7zLGhXH3gWdeHop1Js6sDzMMeqsY+FIU/jW8ukVr871O8eOBpTzhSiq1Xpa3Sc+Et6vWrIPhjVH5Q9ZS6MW1OMHckiLWbAyTBA1zUY6U5NAaEQl60B4uhtnWYwpiVorVKUJabVVEtF+R3GWgTWfl9C86uLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGt0pugQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=46EqGMpo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756113776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OldsM0mTe0gUZlhTr/mMd3s5ex5qEiHcv6VNhYROMGQ=;
	b=XGt0pugQksHOTwpSgow0iV5dMvEriijJXSVyT5cmhLpalpOYBZ4L18xluXdzNq8rpxIRzH
	VVcuu2BBdpNxVpKT8uqfo733AyiGVK7YsOdLQdJCIllLhMm3BB43tvqpa93Itrgv7ThtBE
	YNRxRCPAQcCnbcGIXynbljUxqcVfVu3s7zNrc7h9coYGIF2gMREODnxwDjJgg28UbkQWnY
	P0h6N/DLd8IcTkGi0k5YUG5Tpo6S/7aRE20bOjzGsTEzg71vjWfp4G5pvqdLRqgg7c+gl2
	MtwLRLEa8mQvG+kp7pA8DYd30XOUh87MqbBxBV1J4Iwy7KPHaTutx4hwBD98iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756113776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OldsM0mTe0gUZlhTr/mMd3s5ex5qEiHcv6VNhYROMGQ=;
	b=46EqGMpoRP9YtsfP5Z5aq8RqQVNc2MIqjGwToDZkSZeJZNVAr/hdm0j6UIsYDvwi0Awaqp
	qWoMpRS+xf+7ihCw==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux worker
In-Reply-To: <aKwWiGkbDyEOS9-z@localhost>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de> <87ldna7axr.fsf@jax.kurt.home>
 <aKwWiGkbDyEOS9-z@localhost>
Date: Mon, 25 Aug 2025 11:22:55 +0200
Message-ID: <87o6s3oivk.fsf@jax.kurt.home>
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

On Mon Aug 25 2025, Miroslav Lichvar wrote:
> On Sat, Aug 23, 2025 at 09:29:36AM +0200, Kurt Kanzenbach wrote:
>> Also I couldn't really see a performance degradation with ntpperf.
>
> I was testing with an I350, not I210. Could that make a difference?

Jup, it could make a difference.

>
>> In my
>> tests the IRQ variant reached an equal or higher rate. But sometimes I
>> get 'Could not send requests at rate X'. No idea what that means.
>
> That's ntpperf giving up as the HW is too slow to send requests at
> that rate (with a single process calling sendmmsg() in a loop). You
> can add the -l option to force ntpperf to continue, but the printed
> rate values will no longer be accurate, you would need to measure it
> by some other way, e.g. by monitoring the interface packet counters.

I see.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmisK28THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgu1rD/9qUKqoJzxPjCwmyM7a0nf/OU96P6av
LtDv0y6jPOr/Mf62KBqI228u8HfdTxSyXV6gfuKG+xcklnwdkH5SeHHTYVIYzmIb
tIuoswVSL7CXj6+/GtUxGq3kK4MQIFiR6Qc/Gtz/v7r4HpPSW5NT0e5nmypL4APj
ic185xMi63zaoWBrSpLviaMh2piTyYHI5mOW0EwVPDAQ3Zu6kKXjJUHvxH++Y99y
jXv2QJGooEEboDMweJaL1vLlx9q/f7xFBABLXHnBXhdy1kFMGHr5c0eNmuAoHqU8
zdGus1oVrdUby/7n1Dp64tgQ3ZSG/meCF+aKTlpdTdHs7ikhFH6t0JJYvEg53QH5
QkIKEAgH6j4Dz5BkqUb7C1gXB+OFJ1xuTJ35Wpf0/OqM2xxm2SQVFnvitDdvarW2
lqI/CciQaSuL+nEwjGF7Hh9jC6ElLhffXrK9EyyvsTee4qhuv5xH+czHISPk8/3o
YfelX4qlAhQ6fqlzgGvn+ka+XS3Zl6KpZfvMoUCL8granrq++8YjAfsKkkjkBVCE
z9TGkAViao0ktKkYgFk19htzNx2xXx192V3kD/K3/CQ5T4bwasAqbimkovG2YwYe
nxtwgkf7AfbpLty6aosF4q8ZAu4rHEOW+Z/2iDn0OfP7pIeSWmlI6ReJ4/zUREH4
rcSt3nhUPrrpQg==
=rszz
-----END PGP SIGNATURE-----
--=-=-=--

