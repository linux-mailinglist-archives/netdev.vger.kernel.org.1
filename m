Return-Path: <netdev+bounces-84299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF48966EA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D61281994
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72345B1E2;
	Wed,  3 Apr 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWzmiTxn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GYhReMF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428659B61
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130300; cv=none; b=O8xmWHpkYcM1ZjnGOKvTa+7J9VFo/26AZFI9oWe4gDGwuTrob+SdhJnWoTQABjnR5rFLVeSZaLfd//jNdg26dlZSXBz+/gnP2QX9Y132EuhLIBKa0+2RlqdEQFMr04auedufn/9hRC9yFwDIslxfbQ9g04oZcOdZ+RlrLqOzKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130300; c=relaxed/simple;
	bh=IyW86gPpQIQETG+wkmUQZoDiuULYwbB6Vyjkzm2Zc0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGBUKxAV77zZyfgi32QPUjV4NThObQFyvhRU5ffCz8CXKY5Gll8BORepuMVgMlJE90jo9COQmu3+2KSjHvm0PBSrRJlgOvuaWbIgNHf0aQgFQniq0Qal2eHMj8qsjizalz++5LjZGA9ViThzEtJZeHgYEFD8HCeEnF5I5zg58Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWzmiTxn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2GYhReMF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712130297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONtAaHGTcn6BZJJfwlKtYss4wDqYiooZmD8ycswc5Zg=;
	b=NWzmiTxnqFcyAvtmPhZb+48E/+0EKKdLJbXOLknewhQlz3eJ67rLOpoJyZtIJ2MiPWlYcx
	EHkOquOkkKIomjWGq4ZHrRnwWSz2IQQPfaxL5Qr6LVilzZo5dvfjqQI1lGcArjaCGXLxDs
	M7+ezjLfSiwceXQZTGpSllUhI08XQPIfpmKpYZNK+ATGQVqbIBfNfZp9SLnLnYtXOG47eU
	ETXyHh//aKbyYWEz8MASDBbfB7jERP0VDvwuR1ffORhYrZHSTGsveI/kjhfghLueomfWvO
	ITESDuyCStmQ7G9Zliah68XDlJUYN7NQKHqhLDcwvUNN1e4FXwT6ZkzkyxTeUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712130297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ONtAaHGTcn6BZJJfwlKtYss4wDqYiooZmD8ycswc5Zg=;
	b=2GYhReMFWqD2cXtsRpymLKowU9cQIzBwnRZEkUiZ92cKnwCmmeZEs4Bgv5LfU0FhfBTvLe
	tRYRDt5hm+uEt7CQ==
To: Simon Horman <horms@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igc: Add MQPRIO offload support
In-Reply-To: <20240328114633.GI403975@kernel.org>
References: <20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de>
 <20240328114633.GI403975@kernel.org>
Date: Wed, 03 Apr 2024 09:44:55 +0200
Message-ID: <87a5malwjs.fsf@kurt.kurt.home>
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

On Thu Mar 28 2024, Simon Horman wrote:
> On Tue, Mar 26, 2024 at 02:34:54PM +0100, Kurt Kanzenbach wrote:
>> Add support for offloading MQPRIO. The hardware has four priorities as w=
ell
>> as four queues. Each queue must be a assigned with a unique priority.
>>=20
>> However, the priorities are only considered in TSN Tx mode. There are two
>> TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
>> Therefore, use the legacy TSN Tx mode, which performs strict priority
>> arbitration.
>>=20
>> Example for mqprio with hardware offload:
>>=20
>> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc =
4 \
>> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
>> |   queues 1@0 1@1 1@2 1@3 \
>> |   hw 1
>>=20
>> The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
>> frame preemption is not supported yet.
>>=20
>> Tested on Intel i225 and implemented by following data sheet section 7.5=
.2,
>> Transmit Scheduling.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> ...
>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/=
ethernet/intel/igc/igc_defines.h
>> index 5f92b3c7c3d4..73502a0b4df7 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>> @@ -547,6 +547,15 @@
>>=20=20
>>  #define IGC_MAX_SR_QUEUES		2
>>=20=20
>> +#define IGC_TXARB_TXQ_PRIO_0_SHIFT	0
>> +#define IGC_TXARB_TXQ_PRIO_1_SHIFT	2
>> +#define IGC_TXARB_TXQ_PRIO_2_SHIFT	4
>> +#define IGC_TXARB_TXQ_PRIO_3_SHIFT	6
>> +#define IGC_TXARB_TXQ_PRIO_0_MASK	GENMASK(1, 0)
>> +#define IGC_TXARB_TXQ_PRIO_1_MASK	GENMASK(3, 2)
>> +#define IGC_TXARB_TXQ_PRIO_2_MASK	GENMASK(5, 4)
>> +#define IGC_TXARB_TXQ_PRIO_3_MASK	GENMASK(7, 6)
>> +
>>  /* Receive Checksum Control */
>>  #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
>>  #define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/eth=
ernet/intel/igc/igc_main.c
>
> ...
>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethe=
rnet/intel/igc/igc_tsn.c
>
> ...
>
>> @@ -106,7 +109,26 @@ static int igc_tsn_disable_offload(struct igc_adapt=
er *adapter)
>>  	wr32(IGC_QBVCYCLET_S, 0);
>>  	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
>>=20=20
>> +	/* Reset mqprio TC configuration. */
>> +	netdev_reset_tc(adapter->netdev);
>> +
>> +	/* Restore the default Tx arbitration: Priority 0 has the highest
>> +	 * priority and is assigned to queue 0 and so on and so forth.
>> +	 */
>> +	txarb =3D rd32(IGC_TXARB);
>> +	txarb &=3D ~(IGC_TXARB_TXQ_PRIO_0_MASK |
>> +		   IGC_TXARB_TXQ_PRIO_1_MASK |
>> +		   IGC_TXARB_TXQ_PRIO_2_MASK |
>> +		   IGC_TXARB_TXQ_PRIO_3_MASK);
>> +
>> +	txarb |=3D 0x00 << IGC_TXARB_TXQ_PRIO_0_SHIFT;
>> +	txarb |=3D 0x01 << IGC_TXARB_TXQ_PRIO_1_SHIFT;
>> +	txarb |=3D 0x02 << IGC_TXARB_TXQ_PRIO_2_SHIFT;
>> +	txarb |=3D 0x03 << IGC_TXARB_TXQ_PRIO_3_SHIFT;
>> +	wr32(IGC_TXARB, txarb);
>
> Hi Kurt,
>
> It looks like the above would be a good candidate for using FIELD_PREP,
> in which case the _SHIFT #defines can likely be removed.

OK.

>
> Also, the logic above seems to be replicated in igc_tsn_enable_offload.
> Perhaps a helper is appropriate.

Makes sense.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYNCPgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgoAvD/0TsxVB/pfQbR/D7CGQ8gWHZm344s0h
ynZRvRWRUglmEG0rCZWv6Bhe7t1618j/hvA9vh8pzBo10G4lwekgCmH1Iln4CoYJ
VMbJ7iypnvCtBdyfoSia7VXLfRuyGux8VQ2eYfl8t5lpYbdn8ZE77rCm5ZYUJ3cW
asLQg/neobrTOETEbgzTKHmJcsd5Rl5pt9NNuUJ7MrSthwS6ck27d1RhqNnC5buR
c+34+djZNfxLhS44f7wr3EM7nfOjbdZnx+QYqi9NUI+BrizynDQTuWnqb6xSgIJh
vQWhOCGciOr3p7aUp9N8Mpq4JJsTlUj1bkhl1fCBp2YQ6c1f8LJt/DHExEmfYn71
03G0j8XFg5nRMQgNk5w//BANF3ptTrVOooFk9tyaUXYjJ+BLKZ2UHpXlk4+HiXP5
DqzUi896rdrpX3xcEq0BHYpCqpAZwqkcLjdBVkgayoUn19wSUM25U9NpSNZN2g1z
T4+GnEdjVcCe2zhUdxsOAfsBFJuK72DAUjGAkRRTpD/8StYDGwBPB7cwMxJ8aPA7
fi0QejZ1TSNPVTQCsBqepgSbzOIhIy22CcXafwOxGhlDZxufzauhX5hR6znvHCc3
5oioNykWFvdorxiCiyw/piuDZEvG7+70RkTI7X8mlF5vFcN00O5dAUcM7YB/L7PM
LPOy9vROZKM6Xw==
=xNbN
-----END PGP SIGNATURE-----
--=-=-=--

