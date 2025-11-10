Return-Path: <netdev+bounces-237111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22767C453E4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC6174E8774
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A82EC083;
	Mon, 10 Nov 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srKgYrTI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkocBaG7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF912EBDF4
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760609; cv=none; b=MdJcuZbVpR4BEpaYyLfljriWxaCsxpmWk2jGbefF1za/RYReUO+Xxd5ecJ+D6zTGYn/gftS98UAqjfb7pQuVLONVN6ZS+aIvFDHmqvsPmx8oW4X6lqbP9v7hgXj1IelOSwSViaxgozX5fc3G1sMFPkoOaHxbuX8wORL9A7mTZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760609; c=relaxed/simple;
	bh=n2WoAPYoGVCYomZuVybonbfOGBNE03H0QYv9SgwEh7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGpXg5dhi1lIYiloz4pZAH9pOYVS1swLnm3mWUDHXqYPJDNLtJ0rfnY6Uqaa4bsnVbu8tJIQS+tyyYXAx1FbK5vjmg2JqQhz9e7EwE344L0aSJw1AeJfaJxA8vmcZC3burUhjj6njpsc2PMuxRK0tyq10BroHoifBLYRCqq6l8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srKgYrTI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkocBaG7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762760604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxRjKw1L3Vo4BvxG6c7a664xp8x6jBrMENa5cYkCAPg=;
	b=srKgYrTI0WLWHg7muM/rvb2ilR0lKwIMa3Qt/uRJAfU5x9NbqS8uhIAlLxrDhB5TwWCLdK
	YTaKns825WFKAFIdR6pitlOvqFdgBY1bfQvC6Md5GWrwNrDWxlqW90TO7a98+t4p+zJRaY
	LbDLzPqkf6ZVMeUHsvbABteJi0BjmOmSuTg71+yTgcpnwx+4PJktDmKkrMWEsSNeNQ6fL2
	ICjBl9eyW6QzPofyL+dGt3vnKGtyzh9SviNFNM3Rh0fryYYuLCnQ0m4xwmEMxnUUQqqtVg
	y0JxAOWiJXbxxM3MOIfULs/pq2mJR7TDoaroX9RUsyRYRvp/K/LhL8D+noSdOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762760604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxRjKw1L3Vo4BvxG6c7a664xp8x6jBrMENa5cYkCAPg=;
	b=VkocBaG7rxb6oK4jdhPIfWEEsH/M6KQml/HczRbLUIAoD9ArEtyFJoPEbeiPWBOOnehQ1G
	ZuJ7TzIfQpitpOBQ==
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, "Gomes, Vinicius"
 <vinicius.gomes@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] igc: Restore default Qbv
 schedule when changing channels
In-Reply-To: <IA3PR11MB898676AC586AC4FF179A408EE5C3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
 <IA3PR11MB898676AC586AC4FF179A408EE5C3A@IA3PR11MB8986.namprd11.prod.outlook.com>
Date: Mon, 10 Nov 2025 08:43:22 +0100
Message-ID: <874ir272p1.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 07 2025, Loktionov, Aleksandr wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Kurt Kanzenbach
>> Sent: Friday, November 7, 2025 2:32 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Sebastian
>> Andrzej Siewior <bigeasy@linutronix.de>; Gomes, Vinicius
>> <vinicius.gomes@intel.com>; intel-wired-lan@lists.osuosl.org;
>> netdev@vger.kernel.org; Kurt Kanzenbach <kurt@linutronix.de>
>> Subject: [Intel-wired-lan] [PATCH iwl-next] igc: Restore default Qbv
>> schedule when changing channels
>>=20
>> The MQPRIO (and ETF) offload utilizes the TSN Tx mode. This mode is
>> always coupled to Qbv. Therefore, the driver sets a default Qbv
>> schedule of all gates opened and a cycle time of 1s. This schedule is
>> set during probe.
>>=20
> I'd recommend to explain abbreviations in the commit message:
>   =E2=80=9CMulti=E2=80=91Queue Priority (MQPRIO)=E2=80=9D
>   =E2=80=9CEarliest TxTime First (ETF)=E2=80=9D
>   =E2=80=9CTime=E2=80=91Sensitive Networking (TSN)=E2=80=9D
>   =E2=80=9CQbv=E2=80=9D =E2=86=92 =E2=80=9CIEEE 802.1Qbv time=E2=80=91awa=
re shaper (Qbv)=E2=80=9D
>
>> However, the following sequence of events lead to Tx issues:
>>=20
>>  - Boot a dual core system
>>    probe():
>>      igc_tsn_clear_schedule():
>>        -> Default Schedule is set
>>        Note: At this point the driver has allocated two Tx/Rx queues,
>> because
>>        there are only two CPU(s).
>>=20
>>  - ethtool -L enp3s0 combined 4
>>    igc_ethtool_set_channels():
>>      igc_reinit_queues()
>>        -> Default schedule is gone, per Tx ring start and end time are
>> zero
>>=20
>>   - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
>>       num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
>>       queues 1@0 1@1 1@2 1@3 hw 1
>>     igc_tsn_offload_apply():
>>       igc_tsn_enable_offload():
>>         -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i) -> Boom
>>=20
>> Therefore, restore the default Qbv schedule after changing the amount
>> of channels.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index
>> 728d7ca5338bf27c3ce50a2a497b238c38cfa338..e4200fcb2682ccd5b57abb0d2b8e
>> 4eb30df117df 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -7761,6 +7761,8 @@ int igc_reinit_queues(struct igc_adapter
>> *adapter)
>>  	if (netif_running(netdev))
>>  		err =3D igc_open(netdev);
>>=20
>> +	igc_tsn_clear_schedule(adapter);
>> +
> I'm afraid you need to guard the helper call on success (or when open was=
n=E2=80=99t attempted)
> Because call made even when igc_open() fails.
> As written, igc_tsn_clear_schedule(adapter); executes unconditionally, ev=
en if igc_open()
> returned an error (e.g., rings not fully set up, device not ready).
> That could program TSN/Qbv registers while the device is in a failed/part=
ially initialized state.
> Isn't it?

igc_tsn_clear_schedule() does not write any registers. It just sets the
default parameters. The actual programming is done later by
igc_tsn_enable_offload().

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmkRl5oTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtMLD/sH6Q+jF7eSEIA/7hyXfiM/nzniOtDq
ipfG0zzRT8RPjBiuAU1hxA32MDRdFBEU0RwdotySPFidC1SuA2OrHXr88VV48GtB
/eOYatnFv1MorYxfNRLVP8HLlER+mhuM+KEMpojGQ2KL8yUF2U4hEO70idL1zF+z
K4AkmyZejYqB0GA5RWFwNYhrXKk7B2Oxyu65X+RHP81Y+JLpqbPXJVyqXwRk58j1
WQ2t28ibql1AgG3x2wQV6IGyon/9e/IG2twERfZUOkV4xLjcpYZVjC5K0WS6favQ
Unu8DYbf6Txr113bFzxgqdy9IgVig8Ilq/rJ6BW877KY0kqvWSTIRv3g5LPV300k
o5WBSeYiF1ak1JbxjPjJx/7q/yNZJmJDJD/eFRkISAixGmJp8oJ4//JZcILm8s69
i+tcWRsTdJGZvmzuLN6uWhXbM9M8fu/VBmRLg7hie1TDJq2Qfm4kQcGyxLB/2FVW
sleIvFZ+sef7HPG4hFUNi/XZcEKCmu1xq2kqJT5UWjpRCDsAruCl++SFUoiWQ+Bm
fmZfZG3JcG/x9E+2XHxlGB3GJapZTyzPEKQBoRcDeCF0IGFhxWZAgK0AkXMIXH3/
9omPXzVBCvPiYF9BhKzXlDHUmP5KTG2eW/wUiuCJcjYCxTZnxsH/hk/0r6qdKTV8
6uH+6B1nBoIwiA==
=zShc
-----END PGP SIGNATURE-----
--=-=-=--

