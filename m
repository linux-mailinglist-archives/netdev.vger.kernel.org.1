Return-Path: <netdev+bounces-216192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF89B32772
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10C87B153C
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0E1F583D;
	Sat, 23 Aug 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVaSyYhq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TnBhnDF3"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7673393DE8
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935100; cv=none; b=R4Y6UsMCBjnF45z4BTujHmsJTmvQDPGwMfgBHKGxsPoJJ9dvFjfrFWXaKnMRbB4gj6KDjeoEt0lbspnefNkRr2L916JWyCJGhVzWJLR6RrK05JumNKUDCRiUARv3dSNdwH2utzBcTUvybUMONJFKq1yBMPHwgiIC7JqQ+DF5zoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935100; c=relaxed/simple;
	bh=2uG8ZkY9dqoSxv2ieZpH293AGkVqRIWTpG/YhmdF+oA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LllmHKevmsXK/mY7eTDaFt9khlbBrrCGGCB8J7TutnvSXS9CljlxVHNkacwwWS0mcUSWT+3OV72PaYegClnyjZyeaHjE8A4/U9KISzn6bYanP5iuijwxy+wDibm6m1f27h9rFe2XqXDaXvtvjLnGfXQQhgBuS2qwS+btiencEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVaSyYhq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TnBhnDF3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755935097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3rB3rJwe2Pb51r2EOu5NN5S81zF2bec1Nip+IX0Oxw=;
	b=vVaSyYhqYN4CxrKMy6Aa34MKfMNJo+Az64ingfhQZ3C68BINxAwL4qK5VCiouXbsZTlSWA
	NqKbWumgI1Tamahhxa/thFCCbadvlvhsBaSW0ANSnPCWySNUmQO2vegy6HMSvHZuivlTIz
	03D8dTWyv777qRc/W/oaHhYHGIo252x/VsvEe4WStHYrLWtE4KbgPaLEAsgsre/yUbTuJL
	AIPd9XZ5tVeHUeybz7no9TO0ybl9hpJ92T2L6OKigyqox4O0LT54MCzOXB44HK9+JGHVhw
	ZRLlmd60mCAMokcTRc39oENYX7BEa/NzL/2kX19uNzGvrFKNo9cMB996Y44Y8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755935097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3rB3rJwe2Pb51r2EOu5NN5S81zF2bec1Nip+IX0Oxw=;
	b=TnBhnDF3pI49UsGUOeaz5Irsc2pofGhWCuK9LyFEbs57rfsrdYxpFpqT47j3fFSJcbnKuP
	otxHF/I2m+j6hnBw==
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Paul Menzel <pmenzel@molgen.mpg.de>, Miroslav
 Lichvar <mlichvar@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux worker
In-Reply-To: <27e8fb9f-0e9c-4a0b-b961-64ff9d2f5228@linux.dev>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <27e8fb9f-0e9c-4a0b-b961-64ff9d2f5228@linux.dev>
Date: Sat, 23 Aug 2025 09:44:55 +0200
Message-ID: <87ikie7a88.fsf@jax.kurt.home>
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

On Fri Aug 22 2025, Vadim Fedorenko wrote:
> On 22/08/2025 08:28, Kurt Kanzenbach wrote:
>> The current implementation uses schedule_work() which is executed by the
>> system work queue to retrieve Tx timestamps. This increases latency and =
can
>> lead to timeouts in case of heavy system load.
>>=20
>> Therefore, switch to the PTP aux worker which can be prioritized and pin=
ned
>> according to use case. Tested on Intel i210.
>>=20
>>    * igb_ptp_tx_work
>> - * @work: pointer to work struct
>> + * @ptp: pointer to ptp clock information
>>    *
>>    * This work function polls the TSYNCTXCTL valid bit to determine when=
 a
>>    * timestamp has been taken for the current stored skb.
>>    **/
>> -static void igb_ptp_tx_work(struct work_struct *work)
>> +static long igb_ptp_tx_work(struct ptp_clock_info *ptp)
>>   {
>> -	struct igb_adapter *adapter =3D container_of(work, struct igb_adapter,
>> -						   ptp_tx_work);
>> +	struct igb_adapter *adapter =3D container_of(ptp, struct igb_adapter,
>> +						   ptp_caps);
>>   	struct e1000_hw *hw =3D &adapter->hw;
>>   	u32 tsynctxctl;
>>=20=20=20
>>   	if (!adapter->ptp_tx_skb)
>> -		return;
>> +		return -1;
>>=20=20=20
>>   	if (time_is_before_jiffies(adapter->ptp_tx_start +
>>   				   IGB_PTP_TX_TIMEOUT)) {
>> @@ -824,15 +824,17 @@ static void igb_ptp_tx_work(struct work_struct *wo=
rk)
>>   		 */
>>   		rd32(E1000_TXSTMPH);
>>   		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
>> -		return;
>> +		return -1;
>>   	}
>>=20=20=20
>>   	tsynctxctl =3D rd32(E1000_TSYNCTXCTL);
>> -	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
>> +	if (tsynctxctl & E1000_TSYNCTXCTL_VALID) {
>>   		igb_ptp_tx_hwtstamp(adapter);
>> -	else
>> -		/* reschedule to check later */
>> -		schedule_work(&adapter->ptp_tx_work);
>> +		return -1;
>> +	}
>> +
>> +	/* reschedule to check later */
>> +	return 1;
>
> do_aux_work is expected to return delay in jiffies to re-schedule the
> work. it would be cleaner to use msec_to_jiffies macros to tell how much
> time the driver has to wait before the next try of retrieving the
> timestamp. AFAIU, the timestamp may come ASAP in this case, so it's
> actually reasonable to request immediate re-schedule of the worker by
> returning 0.

I don't think so. The 'return 1' is only executed for 82576. For all
other NICs the TS is already available. For 82576 the packet is queued
to Tx ring and the worker is scheduled immediately. For example, in case
of other Tx traffic there's a chance that the TS is not available
yet. So we comeback one jiffy later, which is 10ms at worst. That looked
reasonable to me.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmipcXcTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggc+EACHd40K218J53oKo5EvWFy73nUbAWLM
LqYycVXFdxg8fFbA21HS5NTovT7yV0dhI/XNwEuz891lR+ar6XwfJ9dpg6//IL4i
/+gBlbucvlf/NI6rVI1G7Oi5kMojFBF7ez6Fzf9A4baBWqsDCQfXFvWAdkXII/3F
qWXrydLA/fr9LskzF0vBZ0Tw+nARW4Q9YQdM9Dme0CVvbEP/r+Zfr4YhDWbUcnLB
gh1u6datYfrerTnUv4S3hJ4+4SOGiiZJHO5kWT6bSg3ynEiakpEE2QSFHWKFJHyc
+WTHHqdqb0+OaQVyUeBRcMNSSQrUmriqZYiiAYJoFZKHFA9rLch1Js2FjkN4fZ67
9SGPqMS8HZAFgJVIhKe/Y7Ncji8aEVN+jWy+g5q4JCwZ1n45Csd1oAEK54OTfgLb
zVbV1XymivQepDZPySQahr8tIgW2WskkpxV3PnJE0wdATt21rukfA5Qs8thsvaxq
luigodQ8O4RGy5+DdQXERJt7VLemOjTV6bEtah5OtN84/Q9dVwWi9FEu8SRV9+Yy
rSYkEzTVHT4Kn1im+hW75XdNe0LnDQBIP7Y9Y4MEFKnwFXn6y9jO+5rz4U5+oGgh
xL2lf7gOpA2alXyJYepCN4yhupnXcKmenqZqhKj+Y6keIh2fd89U4FepqWOAsG3v
/dUH+gTuM+UEtQ==
=H8MU
-----END PGP SIGNATURE-----
--=-=-=--

