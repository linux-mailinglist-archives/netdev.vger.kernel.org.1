Return-Path: <netdev+bounces-238254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603FEC565B4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1951B3A37AD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B7330316;
	Thu, 13 Nov 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMMQmJQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eN8MHjZk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7A22578D
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023850; cv=none; b=bH4cc3/ROi1tYPmajWegOcW9m/b4jUA7kJb+6h+IUIL6P4nbIgPzzCGdHODWFBsRTO7zMKPY/OytRqGoQXOqDBoF27CQF7Iu04e6Ta3sBz7/0dT4qG928Sm7i+Mh8R/TrDXxZSmBq6chbzPc02dPhlrJPKOvjqbcEK9knglljfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023850; c=relaxed/simple;
	bh=wRWmJzQfRZlbBYAFjeZwhhb7wYbWmM38Ct2Qg7q8OmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvYsLJ7jvvdsYtMgk6rdMaidNa9A4Su3sRHfnRK0Tnu+csnQhn07RlMjAw5s3DHrlQnYeplIe1qyFfK6uEK/Xo2iX7xHK3PUU01P6I5vW3OCdwOaNAFvnRYFJM7cm6kXCuhtw9JzXmoXWsQVVH07vOut/UCvQLPk+vfbAizD2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMMQmJQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eN8MHjZk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763023839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1IFQ2dg0dPJUWdefma4qi4mC63g7swvV+DrRqzNNKw=;
	b=MMMQmJQ8o4QbY9TBBZghK0g8PhH+oeiSTaOehHoRx6d/Icw2555qjAI7pY8rtv4ha32oon
	C8Tr0ARP7MaL9T8Jc19TNlTtVVbK+YfoVFid+7KdD1jMTgqaxdaDmd+/rxI4v0ySn8CJWo
	lT0Vn80sdSDcbVNGDdpwWZUGmyW0oTz8ERzLeLcqAB4Cgbjz1E7utfnVjKIvRoNQzJlMbz
	Awg5luUUC51P4Atm8iRKsasDA1IffVbx8ytvPVF08if4LdbQ+7qJD6lW8Pd2DcaJXr7smk
	Z4zidAiU2gSuzMt4r+Q7R/l92a23He++pVaWJHj2emCeqgVHxP6Ksqms0wUe1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763023839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1IFQ2dg0dPJUWdefma4qi4mC63g7swvV+DrRqzNNKw=;
	b=eN8MHjZkrux92Wbtj4FBA6km95T+17b8daMb10DwgZlP85Cn+ffmnPtfHtrHxcQInxj8yQ
	KEra8+HcIkpPMaAA==
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Restore default Qbv schedule when
 changing channels
In-Reply-To: <87ldkblyhd.fsf@intel.com>
References: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
 <87ldkblyhd.fsf@intel.com>
Date: Thu, 13 Nov 2025 09:50:38 +0100
Message-ID: <87bjl6l3j5.fsf@jax.kurt.home>
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

On Wed Nov 12 2025, Vinicius Costa Gomes wrote:
> Hi,
>
> Kurt Kanzenbach <kurt@linutronix.de> writes:
>
>> The MQPRIO (and ETF) offload utilizes the TSN Tx mode. This mode is always
>> coupled to Qbv. Therefore, the driver sets a default Qbv schedule of all gates
>> opened and a cycle time of 1s. This schedule is set during probe.
>>
>> However, the following sequence of events lead to Tx issues:
>>
>>  - Boot a dual core system
>>    probe():
>>      igc_tsn_clear_schedule():
>>        -> Default Schedule is set
>>        Note: At this point the driver has allocated two Tx/Rx queues, because
>>        there are only two CPU(s).
>>
>>  - ethtool -L enp3s0 combined 4
>>    igc_ethtool_set_channels():
>>      igc_reinit_queues()
>>        -> Default schedule is gone, per Tx ring start and end time are zero
>>
>>   - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
>>       num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
>>       queues 1@0 1@1 1@2 1@3 hw 1
>>     igc_tsn_offload_apply():
>>       igc_tsn_enable_offload():
>>         -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i) -> Boom
>>
>> Therefore, restore the default Qbv schedule after changing the amount of
>> channels.
>>
>
> Couple of questions:
>  - Would it make sense to mark this patch as a fix?

This only happens if a user uses ETF or MQPRIO and a dual/single core
system. So I didn't see the need to mark it as a fix.

>
>  - What would happen if the user added a Qbv schedule (not the default
>    one) and then changed the number of queues? My concern is that 'tc
>    qdisc' would show the custom user schedule and the hardware would be
>    "running" the default schedule, this inconsistency is not ideal. In
>    any case, it would be a separate patch.

Excellent point. Honestly I'm not sure what to expect when changing the
number of queues after a user Qbv schedule is added. For MQPRIO we added
a restriction [1] especially for that case. I'm leaning towards the same
solution here. What do you think?

Thanks,
Kurt

[1] - https://elixir.bootlin.com/linux/v6.18-rc5/source/drivers/net/ethernet/intel/igc/igc_ethtool.c#L1564

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmkVm94THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgjIuEAChqQ+nRVq5ukbl7W1RZuG8ZU/XzOgm
X95Ynd2cAdxMEhTPx3CEVG2/t9nhH4eUv6OI6V2XuDKnm3/FQ8UA7F6VK7R3mfSr
Crt4RVtODUtET0s6TeHFLAN/ldplPMk3WehEpQJuC5QhJLkhTTzwLcts84tiDjWX
5erY0MVEnAD0vjOiI6v/k6YrZX1X0IhU7k70V0bHFCUlsRgnvmj2fco8Cy8TJTiP
Snj5M8syMPnE0pLnEBLklyTt3doUX0bOFUnR45MbTs2Jg6GMQj9QzmSYRKA56qcL
d2ampDOMECmd0qJUDQz9g/8/d2/6yk2jcqrg27sQsEeOkN0A/wykIkHf0B9hTjrX
1/AkKsKuvbtqCQSSSvvec4TnT8Tb+aF413UmSTtNQHweTx3FgEm606Neo/N4Boqw
aPt0qPeqozLH6Mg+X3ODm6D/kIipeWTpwN+/3xIO40ppU3oU89sNQKJUj4ucARfM
LOrQy3OUyXj+3wn/mvK4OfHnmXXpgB0ga+DLmSOpc50f1kayvXQNlg5bvykr9J/S
VXVrwUJPwCNtfify7ZL81LN/KuVwlItkMbPg3fjQwf2fphmPL4al+iDOXW4wWfTn
JytB5bvEHPXFrM78vKDy8PL0ecvdxKrdxWIV9ZibpCN9oZTRAvij9++ivjyj5foe
BVu7g3dH+PlmfA==
=PsfW
-----END PGP SIGNATURE-----
--=-=-=--

