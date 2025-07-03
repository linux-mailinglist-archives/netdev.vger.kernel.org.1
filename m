Return-Path: <netdev+bounces-203904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42913AF7F5C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1F580216
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027C25524C;
	Thu,  3 Jul 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ow1HnyfZ"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8930100;
	Thu,  3 Jul 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564824; cv=pass; b=Qtt9jMzTM9m9tKXtiXwv2yeS9yQ4Q+vkkdd5RWo16s86/fMPD2npYeTF9fyBdofGRi3H9eAYqEYHi62KVATTNlmEY+YAZu0N4XfcnVK1dtSNWWUKzonhuUtTIkYZsol0NOFrKVnv3qIyY2CJzRHX+nhcltQNzzzeY1FV15lHED0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564824; c=relaxed/simple;
	bh=SX+7UDr7VwrSDVkJUvaW+K7Sb35R4upgoi6dqiFv73k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NsxuwIfHFo9kRGTJm2o0iNjsYPSPEvYoGjq8sMQXuvwUZKTQpSbGdpdGl/wALxvZZMTp8zASdFpMMVl9LhocUL/9uTZW6dPMDoKLxPa6dpnCPI/u2J0ZsiRfxPt54lYectFrvOchwaFl+nh2fd3WDqFD4AeESu7YaexwtwjIHpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ow1HnyfZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [127.0.0.1] (unknown [185.77.218.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bY42c3gQ1z49PwQ;
	Thu,  3 Jul 2025 20:46:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1751564809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Shshi6BbrusRLvYtxB7knhOL9Rkdmgkau6HUjw1JNd8=;
	b=ow1HnyfZXUyTlwjRWYnn8wtuuKXGfuNhpZ0ohXawbL+CqP4D+9DppvS2PrEhmZ5Vq13Gna
	N77sd5U24ziv+Ikm5g90817ONYezGEljPrTLea+8a6KeLhVk6qLJSBSg1kK5f8BgywTvpE
	0yprP73FVtZBvZpdY/BSrXLRldaBYvkg+zHSotXpdoYGkahw4o4AQps5SRoeEBcibylcxQ
	YQ4kcri6TpUfrxPhlWP5vxIuRZ3Z7YzOMkjexpJna73bZ7v//Wr5Srm0wAqT6vFwoau/34
	VZ+VnNHGjPzjZABgqdTthwz636d+zLuuhl/Cja4qWozSy/fZLp7snBx6GJBvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1751564809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Shshi6BbrusRLvYtxB7knhOL9Rkdmgkau6HUjw1JNd8=;
	b=gmCa4ib98meqBkvQcs3FBPMGEAQaUc9EciAP0+a0l7x0+dgDXdzlwkiXTNN6Hm/OznluDY
	P/unLfJiiXmipkm9jYOZVz2nzet7G+deViUHGwc0JMn+YNcM2og2iRnDJgRMoY+lvUdf9z
	yxZJ+TblrhWi0kp7ZR82DG+GlrARvODcCoYTQOgq9fPa7v3hMcNP7LGsg7BTudwKLSxgcQ
	ghkTcHWte/xdB3r5d4rehRJkExCgrnoTDKEyRyAivFObzIIfWYkKN8I7jncO6KYUyMB0j8
	4IogwmKBGTEWdDpY4c/vxPHsdsYvd0EQgMEljVhvsQEucagkJrXdCTivYOprIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1751564809; a=rsa-sha256;
	cv=none;
	b=UYMAJvZFRmeRgtwUaKe+Z0eBTSBz3dWkQkx9/MNLXaUrhT/hVoTktD/UublG/EOvb4cANJ
	gyEvMQPgiCkW08poZA2pKRIMIBryUs//Ch2pHoLB/muvl7ytZ/rFRAXf3LpbC8g1vPdj1S
	69kYlH9nXD8Y+1BLjf7vufso62fatvhDCGxhDLqWYHBuZgFAaEtAJhN0vN4ptCXpiLVW5u
	/L8zOZgcmnRYByOWQmKm92sA231aQzF+sfLZZ6n9EXA+T978hHPrHd6NusGG+Zvct50zwG
	P2AYCnwAX6BGfm1am0G7iMJ4tjMlgAQaLgeEvH85B9r4xMjUjSd3YUxhv9PdFA==
Date: Thu, 03 Jul 2025 17:46:46 +0000
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Yang Li <yang.li@amlogic.com>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
CC: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_Bluetooth=3A_ISO=3A_Support_?=
 =?US-ASCII?Q?SOCK=5FRCVTSTAMP_via_CMSG_for_ISO_sockets?=
In-Reply-To: <7ea17a93-284d-4e9b-8130-cc46b16a9524@amlogic.com>
References: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com> <d6906cfb7fae090b9fe0c1c5b8708182eb939b42.camel@iki.fi> <7ea17a93-284d-4e9b-8130-cc46b16a9524@amlogic.com>
Message-ID: <0CE441B2-0CB2-467D-A2AE-0BD37EDACEEA@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

3=2E hein=C3=A4kuuta 2025 10=2E34=2E46 UTC Yang Li <yang=2Eli@amlogic=2Eco=
m> kirjoitti:
>Hi,
>> [ EXTERNAL EMAIL ]
>>=20
>> Hi,
>>=20
>> ke, 2025-07-02 kello 19:35 +0800, Yang Li via B4 Relay kirjoitti:
>>> From: Yang Li <yang=2Eli@amlogic=2Ecom>
>>>=20
>>> User-space applications (e=2Eg=2E, PipeWire) depend on
>>> ISO-formatted timestamps for precise audio sync=2E
>>>=20
>>> Signed-off-by: Yang Li <yang=2Eli@amlogic=2Ecom>
>>> ---
>>> Changes in v2:
>>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>>> - Link to v1: https://lore=2Ekernel=2Eorg/r/20250429-iso_ts-v1-1-e586f=
30de6cb@amlogic=2Ecom
>>> ---
>>>   net/bluetooth/iso=2Ec | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/net/bluetooth/iso=2Ec b/net/bluetooth/iso=2Ec
>>> index fc22782cbeeb=2E=2E6927c593a1d6 100644
>>> --- a/net/bluetooth/iso=2Ec
>>> +++ b/net/bluetooth/iso=2Ec
>>> @@ -2308,6 +2308,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_b=
uff *skb, u16 flags)
>>>                                goto drop;
>>>                        }
>>>=20
>>> +                     /* Record the timestamp to skb*/
>>> +                     skb->skb_mstamp_ns =3D le32_to_cpu(hdr->ts);
>> Hardware timestamps are supposed to go in
>>=20
>>          skb_hwtstamps(skb)->hwtstamp
>>=20
>> See Documentation/networking/timestamping=2Erst
>> "3=2E1 Hardware Timestamping Implementation: Device Drivers" and how it
>> is done in drivers/net/
>>=20
>> This documentation also explains how user applications can obtain the
>> hardware timestamps=2E
>>=20
>> AFAIK, skb->tstamp (skb->skb_mstamp_ns is union for it) must be in
>> system clock=2E The hdr->ts is in some unsynchronized controller clock,
>> so they should go to HW timestamps=2E
>
>
>Following your suggestion, I switched to hwtstamp but kept SO_TIMESTAMPNS=
 on the PipeWire side=2E
>
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct skb_sha=
red_hwtstamps *hwts =3D skb_hwtstamps(skb);
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwts)
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwts->hwtstamp =3D us_to_ktime(le32_to_cp=
u(hdr->ts));
>+
>
>The value I get is unexpectedly large and not the same as the timestamp i=
n the ISO data=2E

The value given by SO_TIMESTAMPNS is the system clock time when kernel rec=
eived the packet=2E

It's not the same as the ISO timestamp, as the ISO TS is in controller clo=
ck=2E This is normal=2E Applications generally need timestamps in system cl=
ock=2E

The two clocks are not synchronized=2E There is an unknown offset between =
system clock and ISO TS times=2E AFAIK there is no specified way to find wh=
at it is precisely (=3D synchronize clocks) using HCI=2E This appears imple=
mentation-defined=2E So I think kernel should report both timestamps, and l=
eave it to applications to try to correlate them=2E

Note that master branch of Pipewire already uses the kernel-provided RX ti=
mestamps=2E It can use also the HW timestamps after they are added=2E They =
likely improve CIS synchronization, as it's then unambiguous which packets =
belong together and we can correlate all CIS using same clock matching=2E

>
>read_data: received timestamp: 880608=2E479272966
>read_data: received timestamp: 880608=2E479438633
>read_data: received timestamp: 880608=2E489259466
>read_data: received timestamp: 880608=2E489434550
>read_data: received timestamp: 880608=2E499289258
>read_data: received timestamp: 880608=2E499464550
>read_data: received timestamp: 880608=2E509278008
>read_data: received timestamp: 880608=2E509451425
>read_data: received timestamp: 880608=2E519261175
>read_data: received timestamp: 880608=2E519438633
>read_data: received timestamp: 880608=2E529385008
>read_data: received timestamp: 880608=2E529462133
>read_data: received timestamp: 880608=2E539273758
>read_data: received timestamp: 880608=2E539452758
>read_data: received timestamp: 880608=2E549271258
>read_data: received timestamp: 880608=2E549450008
>read_data: received timestamp: 880608=2E559263466
>read_data: received timestamp: 880608=2E559443216
>read_data: received timestamp: 880608=2E569257466
>
>
>Is there any special processing in the application code?
>
>>=20
>>> +
>>>                        len =3D __le16_to_cpu(hdr->slen);
>>>                } else {
>>>                        struct hci_iso_data_hdr *hdr;
>>>=20
>>> ---
>>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>>> change-id: 20250421-iso_ts-c82a300ae784
>>>=20
>>> Best regards,
>> --
>> Pauli Virtanen

