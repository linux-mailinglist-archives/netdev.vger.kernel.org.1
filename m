Return-Path: <netdev+bounces-116874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9F94BE97
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6241F211EF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05318DF7A;
	Thu,  8 Aug 2024 13:35:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059218B482
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124118; cv=none; b=J7OOjc4bcn5SoMlpgYpngtnESyIY74mV9eVKWeO9UFdj+Tsh9Iu5wfaMgt023BE5nxsVtp67wuN7XoTqPGxohz3sO8coqrv6rClc0FObo6hbAStN31PHU0y5qVzF2vzPQ9HuE5+NKtLyKHriRo5FrSPI0ti13/4X7OoOucNKqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124118; c=relaxed/simple;
	bh=q2C7Al+j5nn7Vv2yuSeoiu2IIjOA5vZNI0ZJyCBeuEI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NbTpbkkTdx/Pk4YK7EDFWlOExCLtNsV2si4wFrNoyKohYqPD90i7WOl73VR31JzCVOZtm6wU2vtYs4ZOr9oiX5K9PC6u56F5pKHIKv3KlaeqkPcz1w31g+p1lT9r92h52hZqKuE6DeA294kAVtmA04tNG7hpOt0iwOjWcYs+68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B39C47D064;
	Thu,  8 Aug 2024 13:35:15 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <ZrTH665G9b3P054t@hog>
Date: Thu, 8 Aug 2024 09:35:04 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BAC517C-C896-489F-A7E8-DE5046E38073@chopps.org>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org> <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org> <ZrIDfN2uFpktGJYD@hog>
 <m2a5hnnsw8.fsf@ja-home.int.chopps.org> <ZrTH665G9b3P054t@hog>
To: Sabrina Dubroca <sd@queasysnail.net>
X-Mailer: Apple Mail (2.3774.600.62)



> On Aug 8, 2024, at 09:28, Sabrina Dubroca <sd@queasysnail.net> wrote:
>=20
> 2024-08-08, 07:30:13 -0400, Christian Hopps wrote:
>>=20
>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>=20
>>> 2024-08-06, 04:54:53 -0400, Christian Hopps wrote:
>>>>=20
>>>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>>>=20
>>>>> 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
>>>>>>>> +/* 1) skb->head should be cache aligned.
>>>>>>>> + * 2) when resv is for L2 headers (i.e., ethernet) we want the =
cacheline to
>>>>>>>> + * start -16 from data.
>>>>>>>> + * 3) when resv is for L3+L2 headers IOW skb->data points at =
the IPTFS payload
>>>>>>>> + * we want data to be cache line aligned so all the pushed =
headers will be in
>>>>>>>> + * another cacheline.
>>>>>>>> + */
>>>>>>>> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
>>>>>>>> +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
>>>>>>>=20
>>>>>>> How did you pick those values?
>>>>>>=20
>>>>>> That's what the comment is talking to. When reserving space for =
L2 headers we
>>>>>> pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the =
cacheline should start
>>>>>> -16 from where skb->data will point at.
>>>>>=20
>>>>> Hard-coding the x86 cacheline size is not a good idea. And what's =
the
>>>>> 16B for? You don't know that it's enough for the actual L2 =
headers.
>>>>=20
>>>> I am not hard coding the x86 cacheline. I am picking 64 as the =
largest cacheline that this is optimized for, it also works for smaller =
cachelines.
>>>=20
>>> At least use SMP_CACHE_BYTES then?
>>=20
>> Right, I have changed this work with L1_CACHE_BYTES value.
>>=20
>>>> 16B is to allow for the incredibly common 14B L2 header to fit.
>>>=20
>>> Why not use skb->dev->needed_headroom, like a bunch of tunnels are
>>> already doing? No guessing required. ethernet is the most common, =
but
>>> there's no reason to penalize other protocols when the information =
is
>>> available.
>>=20
>> We can't use `skb->dev->needed_headroom`, b/c `skb->dev` is not
>> correct for the new packets. `skb->dev` is from the received IPTFS
>> tunnel packet. The skb being created here are the inner user packets
>> leaving the tunnel, so they have an L3 header (thus why we are only
>> making room for L2 header). They are being handed to gro receive and
>> still have to be routed to their correct destination interface/dev.
>=20
> You're talking about RX now. You're assuming the main use-case is an
> IPsec GW that's going to send the decapped packets out on another
> ethernet interface? (or at least, that's that's a use-case worth
> optimizing for)
>=20
> What about TX? Is skb->dev->needed_headroom also incorrect there?
>=20
> Is iptfs_alloc_skb's l3resv argument equivalent to a RX/TX switch?

Exactly right. When we are generating IPTFS tunnel packets we need to =
add all the L3+l2 headers, and in that case we pass l3resv =3D true.

Thanks,
Chris.

>=20
>> 16 handles the general common case an ethernet device being the
>> destination, if it's not correct after routing, nothing is broken,
>> it just means that we may or may not achieve this maximal cache
>> locality (but we still might e.g., if its destined to a GRE tunnel
>> then we are looking at a bunch more headers so they and the existing
>> L3 header will occupy 2 cachelines anyway). Again, this is a best
>> effort thing.
>=20
> Ok.
>=20
> --=20
> Sabrina



