Return-Path: <netdev+bounces-117028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5294C663
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA307B2244B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC71465BA;
	Thu,  8 Aug 2024 21:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A915B0FC
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153371; cv=none; b=ILu89XRzGPMhJ9zcEaS1CjhyrElHHdMOngW2mymEmMiMvw++E4oB6lbg2xhhrl9V6hV9Dr+Z2mwsLu+SQ92H9lzQLz9J2uN0EI7V0/OzYNQ1nqs95KbjL23Tn56grZgygSNPoibBPdFQi4hWUiYO+e5Ihs7DQ8z9O0REzBfPjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153371; c=relaxed/simple;
	bh=tuT0u0AMfYCSTSh/I1baAP9AXjthsIPnqMsk9MVGhtM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nNJrQjLpZvdtNXTc04Yzh7Pm4QjAhGrWmB4TL/WRKcvKQP9QaJcVNuZd3dTW84qZ2OGG9bDcagVbfofZDOUvauR4wNkRWRQRd4jTAzk/hJW02N9W0iBoJ4Q+T2/H1Zhk86G4UtI73v1oVGF1frtrcgOOjBVJDR7TUP8RTBzOxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 6BC177D064;
	Thu,  8 Aug 2024 21:42:48 +0000 (UTC)
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
In-Reply-To: <ZrTPyM3V7JKca6SZ@hog>
Date: Thu, 8 Aug 2024 17:42:37 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <75B597AE-43D8-4A41-AF3E-7169C696FEC6@chopps.org>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org> <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org> <ZrIDfN2uFpktGJYD@hog>
 <m2a5hnnsw8.fsf@ja-home.int.chopps.org> <ZrTH665G9b3P054t@hog>
 <3BAC517C-C896-489F-A7E8-DE5046E38073@chopps.org> <ZrTPyM3V7JKca6SZ@hog>
To: Sabrina Dubroca <sd@queasysnail.net>
X-Mailer: Apple Mail (2.3774.600.62)



> On Aug 8, 2024, at 10:01, Sabrina Dubroca <sd@queasysnail.net> wrote:
>=20
> 2024-08-08, 09:35:04 -0400, Christian Hopps wrote:
>>=20
>>=20
>>> On Aug 8, 2024, at 09:28, Sabrina Dubroca <sd@queasysnail.net> =
wrote:
>>>=20
>>> 2024-08-08, 07:30:13 -0400, Christian Hopps wrote:
>>>>=20
>>>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>>>=20
>>>>> 2024-08-06, 04:54:53 -0400, Christian Hopps wrote:
>>>>>>=20
>>>>>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>>>>>=20
>>>>>>> 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
>>>>>>>>>> +/* 1) skb->head should be cache aligned.
>>>>>>>>>> + * 2) when resv is for L2 headers (i.e., ethernet) we want =
the cacheline to
>>>>>>>>>> + * start -16 from data.
>>>>>>>>>> + * 3) when resv is for L3+L2 headers IOW skb->data points at =
the IPTFS payload
>>>>>>>>>> + * we want data to be cache line aligned so all the pushed =
headers will be in
>>>>>>>>>> + * another cacheline.
>>>>>>>>>> + */
>>>>>>>>>> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
>>>>>>>>>> +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
>>>>>>>>>=20
>>>>>>>>> How did you pick those values?
>>>>>>>>=20
>>>>>>>> That's what the comment is talking to. When reserving space for =
L2 headers we
>>>>>>>> pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the =
cacheline should start
>>>>>>>> -16 from where skb->data will point at.
>>>>>>>=20
>>>>>>> Hard-coding the x86 cacheline size is not a good idea. And =
what's the
>>>>>>> 16B for? You don't know that it's enough for the actual L2 =
headers.
>>>>>>=20
>>>>>> I am not hard coding the x86 cacheline. I am picking 64 as the =
largest cacheline that this is optimized for, it also works for smaller =
cachelines.
>>>>>=20
>>>>> At least use SMP_CACHE_BYTES then?
>>>>=20
>>>> Right, I have changed this work with L1_CACHE_BYTES value.
>>>>=20
>>>>>> 16B is to allow for the incredibly common 14B L2 header to fit.
>>>>>=20
>>>>> Why not use skb->dev->needed_headroom, like a bunch of tunnels are
>>>>> already doing? No guessing required. ethernet is the most common, =
but
>>>>> there's no reason to penalize other protocols when the information =
is
>>>>> available.
>>>>=20
>>>> We can't use `skb->dev->needed_headroom`, b/c `skb->dev` is not
>>>> correct for the new packets. `skb->dev` is from the received IPTFS
>>>> tunnel packet. The skb being created here are the inner user =
packets
>>>> leaving the tunnel, so they have an L3 header (thus why we are only
>>>> making room for L2 header). They are being handed to gro receive =
and
>>>> still have to be routed to their correct destination interface/dev.
>>>=20
>>> You're talking about RX now. You're assuming the main use-case is an
>>> IPsec GW that's going to send the decapped packets out on another
>>> ethernet interface? (or at least, that's that's a use-case worth
>>> optimizing for)
>>>=20
>>> What about TX? Is skb->dev->needed_headroom also incorrect there?
>>>=20
>>> Is iptfs_alloc_skb's l3resv argument equivalent to a RX/TX switch?
>>=20
>> Exactly right. When we are generating IPTFS tunnel packets we need
>> to add all the L3+l2 headers, and in that case we pass l3resv =3D
>> true.
>=20
> Could you add a little comment alongside iptfs_alloc_skb? It would
> help make sense of the sizes you're choosing and how they fit the use
> of those skbs (something like "l3resv=3Dtrue is used on TX, because we
> need to reserve L2+L3 headers. On RX, we only need L2 headers because
> [reason why we need L2 headers].").

Sure.

> And if skb->dev->needed_headroom is correct in the TX case, I'd still
> prefer (skb->dev->needed_headroom + <some space for l3>) to a fixed =
128.

So dev->needed_headroom is defined as possible extra needed headroom.For =
ethernet it is 12. It's not what we want.

The actual MAC size value in this case is: dev->hard_header_len which is =
14..

(gdb) p st->root_skb
$2 =3D (struct sk_buff *) 0xffff888012969a00
(gdb) p (struct dst_entry *)$2->_skb_refdst
$3 =3D (struct dst_entry *) 0xffff888012ef7180
(gdb) p $3->deb
$5 =3D (struct net_device *) 0xffff88800dca8000
(gdb) p $5->needed_headroom
$6 =3D 12
(gdb) p $5->hard_header_len
$7 =3D 14
(gdb) p $5->min_header_len
$8 =3D 14 '\016'

We also have access to the IPTFS required header space by looking in the =
tpl->dst...

# L3 header space requirement for xfrm
(gdb) p $3->header_len
$4 =3D 40

which in this case is 40 =3D=3D IP (20) + ESP (8) + GCM-IV (8) + IPTFS =
(4)

So what I think you're looking for is this:

struct dst_entry *dst =3D skb_dst(tpl);

resv =3D LL_RESERVED_SPACE(dst->dev) + dst->header_len;
resv =3D L1_CACHE_ALIGN(resv);

FWIW (not that much) this is 128 in the ethernet dev case :)

# LL_RESERVED_SPACE()
(gdb) p (14 + 12 + 16) & ~15
$9 =3D 32

# above + dst->header_len
(gdb) p 40 + 32
$10 =3D 72

# aligned to L1_CACHE_BYTES
(gdb) p (72 + 64) & ~63
$12 =3D 128

Thanks,
Chris.

>=20
> --=20
> Sabrina



