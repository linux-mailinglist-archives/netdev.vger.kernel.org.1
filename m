Return-Path: <netdev+bounces-168419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30DA3EF5C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C5919C3718
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8562036E8;
	Fri, 21 Feb 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u07y66J+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5R1m988"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25944200110
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128498; cv=none; b=ihJOvViEfcOjkEzGBcKwnkgirwqU97DEnhqivHB5hu230H7Y+cWV2rp1fkmvvW5f0CGqzXNDPC14G4SR2Snd+08OPtTiayVhLpBkscS4+kfG2k9FM6J5AEk26PjfHoUEVbQ3I+O1PDpZJPMMOq9S1rHGtPnEjrKHIImve7j5DIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128498; c=relaxed/simple;
	bh=r9rBCmeQKzxhIzCh4QeTAQRwIUZN3cU/99UjTTkhDFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVy+8IDGKJaDT31ljhc3rbB6XyINv73RRke0plYw7cTv/iDusQVdTVBmcmC0MzkyIORTdOarypB1x2YhwDwM0nRcCAVStN7GQAuxeOSho1sybvFMSVBWlXcxceIsiemYWi6lSShzibkuoRf/KuJlP1/0AQs//UfMjJ7TqKTCqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u07y66J+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5R1m988; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwYnNoDhPmLp2LRB/MupwvXiwDscd4G1TWpjxtDLSkM=;
	b=u07y66J+eauJ37KDcFDyBnapa1Jzo2dpj2akzcrFdrpmxTWAop5tvZn5wS68lklRXDW/Sh
	2fNE/20efuCVZifp0fFYTjA26aIzKnj7e/VGJsROL0djKl9dbsSCq/A9PuT/NyXHGiyz7x
	6RcMZ082C8CBN+kY+rMSd9WEdDS3PQScM/3xEN/WS0OtvjmJ7lfkhkAD/oEf0ZXff1AQ+K
	f4uxsxpYPLuYVzRwNObaaGiI5m50epQvGcHEsyt78sM7Pr4JCfUXkE2x38WK+wjo5bOG88
	c9egF4bo1Fq1MGBF8EuoQz1Yzmav6KQYNG8IOKkCxilh4niPwUh5lz7VsY5iMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwYnNoDhPmLp2LRB/MupwvXiwDscd4G1TWpjxtDLSkM=;
	b=q5R1m9888X+oKhVUlab1XBjhnqVOiAkSzWy35UGyQ5gqKzCYM10r74Q20FAL1jw1TQ3NW5
	47IgEgERocOomADQ==
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Change Tx mode for MQPRIO offloading
In-Reply-To: <6ff37238-ff0e-43c9-a88d-1258fd4ce7ef@linux.intel.com>
References: <20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de>
 <6ff37238-ff0e-43c9-a88d-1258fd4ce7ef@linux.intel.com>
Date: Fri, 21 Feb 2025 10:01:33 +0100
Message-ID: <87wmdj8ydu.fsf@kurt.kurt.home>
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

On Fri Feb 21 2025, Abdul Rahim, Faizal wrote:
> On 17/2/2025 7:45 pm, Kurt Kanzenbach wrote:
>> The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
>> this mode the hardware uses four packet buffers and considers queue
>> priorities.
>>=20
>> In order to harmonize the TAPRIO implementation with MQPRIO switch to the
> Missed "," ?
> In order to harmonize the TAPRIO implementation with MQPRIO, switch to the

Ok.

>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethe=
rnet/intel/igc/igc_tsn.c
>> index 1e44374ca1ffbb86e9893266c590f318984ef574..6e4582de9602db2c6667f173=
6cc2acaa4d4b5201 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -47,7 +47,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapt=
er *adapter)
>>   		new_flags |=3D IGC_FLAG_TSN_QAV_ENABLED;
>>=20=20=20
>>   	if (adapter->strict_priority_enable)
>> -		new_flags |=3D IGC_FLAG_TSN_LEGACY_ENABLED;
>> +		new_flags |=3D IGC_FLAG_TSN_QBV_ENABLED;
>>=20=20=20
>>   	return new_flags;
>>   }
>
> IGC_FLAG_TSN_QBV_ENABLED is set multiple times in different lines:
>
> 	if (adapter->taprio_offload_enable)
> 		new_flags |=3D IGC_FLAG_TSN_QBV_ENABLED;
>
> 	if (is_any_launchtime(adapter))
> 		new_flags |=3D IGC_FLAG_TSN_QBV_ENABLED;
>
> 	if (is_cbs_enabled(adapter))
> 		new_flags |=3D IGC_FLAG_TSN_QAV_ENABLED;
>
> 	if (adapter->strict_priority_enable)
> 		new_flags |=3D IGC_FLAG_TSN_QBV_ENABLED;
>
> 	return new_flags;
> }
>
> We can combine the conditions to simplify:
> 	if (adapter->taprio_offload_enable ||
>              is_any_launchtime(adapter) ||
>              adapter->strict_priority_enable)
> 		new_flags |=3D IGC_FLAG_TSN_QBV_ENABLED;

Sure.

Should I send a v2 or do you want to carry this patch in your next fpe
series?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme4QO0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgh0qD/9XL1gTqU5iRLiQwEpYlubwGg2K/UQY
/8aVDtneU77knwNaef98gMahwyId3kUhVVxOER9iiWYVmmj/MnAJOHdjBnkbB2Gb
Uz9G2imrxmMQotLqPfApvcs+sweMBNc+tLS7xHYQuaPf5A8cwzrncdEHOKxxKVBj
EvGH4gN3CS6rR7vf8PgsJTlNOkvNlFyn4O8Rv7BrpxhTn8frSXoqzPUW/r3bW1by
otFkXHALqdiL+BvjNtaSeQ6BxANW5zoFMVJXg7erIpVYfT+WKWACD6kDp/ht5Isr
D1GeFO3V+VxuCqSLHIwPVO5MHG0E6Qy4+T1tbNZInU0RXToFqjXj2cb3ea34I9/E
pPb7DIJ8VRSBfWPXakwUdpuWKIhiRSCxS1kIlBU07+mouTRjsmDsd1/Mv6riNfaJ
3aN5HMskynCsgAkyT2t2E76EjUqcYpyvlL9AWCcvu2PqR6BNsjan/d/KUW1gLtdN
pAdnibQ2j8ZvqnZrulcoEc79Lz0I/5zmerjd7h0yg/HfxVkDI5i/YPcJ88n/I4PI
V1IBOeGmR8KGRijf7UJGdWfZdUbZWbxHyts+TLHhQdHx3xs14kphgCfl0TDnssbM
RoOp1FuR1jA74Q88xBlU/hmb6UCrSLmk7Q0Ep6yxPJlk/OWBnOEyPRtJwNGVV6qx
SRG02XOCIL8mjw==
=ZeO1
-----END PGP SIGNATURE-----
--=-=-=--

