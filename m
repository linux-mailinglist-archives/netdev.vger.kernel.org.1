Return-Path: <netdev+bounces-116555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381494AE37
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A575F1F2320B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AD12F5B1;
	Wed,  7 Aug 2024 16:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0579DC7
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048457; cv=none; b=SF0K0vFu4RBfPfpDXCZzh/LeMdRemdDhHaPZnaNy5E3ov/G3N+S0Cnj5J5RIPIt77Qny6QMqg9Qeb3Omsnv7G+TIrYqxBvo/1NvdSl/W+kejf67s6U+kGoIgmalFQ2x3wdaPk3K2MHWBXJQic4YKDA1WOrONcooXfmFF4inUQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048457; c=relaxed/simple;
	bh=NfZw7qE2h+do1P0bLVSFivpIycgq830XOnlky8yuaZI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ooWdJ0RcOPW3g3urPRUfXHEHLXi0g6Z1SMFNcj2+072lbPX5VZDLW44x6JGd+iL742d2yQijPT8GSIwM+NkNR8QHyhy+Sitmv4gTA7SsA6OjMLy0C8Sh7P7Sv7WWS91LvqHJDmbTMAS/uZ5v13zNPdkBIsFTQirWSCcRYJLxPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B9FBC7D0C1;
	Wed,  7 Aug 2024 16:34:07 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org> <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
 <ZrIEC3HWJpKfIz6Y@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, Sabrina Dubroca
 <sd@queasysnail.net>, devel@linux-ipsec.org, netdev@vger.kernel.org,
 Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Wed, 07 Aug 2024 12:23:39 -0400
In-reply-to: <ZrIEC3HWJpKfIz6Y@gauss3.secunet.de>
Message-ID: <m2o764nvgh.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Steffen Klassert <steffen.klassert@secunet.com> writes:

> On Tue, Aug 06, 2024 at 04:54:53AM -0400, Christian Hopps wrote:
>>
>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>
>> > 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
>> > > > > +/* 1) skb->head should be cache aligned.
>> > > > > + * 2) when resv is for L2 headers (i.e., ethernet) we want the cacheline to
>> > > > > + * start -16 from data.
>> > > > > + * 3) when resv is for L3+L2 headers IOW skb->data points at the IPTFS payload
>> > > > > + * we want data to be cache line aligned so all the pushed headers will be in
>> > > > > + * another cacheline.
>> > > > > + */
>> > > > > +#define XFRM_IPTFS_MIN_L3HEADROOM 128
>> > > > > +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
>> > > >
>> > > > How did you pick those values?
>> > >
>> > > That's what the comment is talking to. When reserving space for L2 headers we
>> > > pick 64 + 16 (a 2^(<=6) cacheline + 16 bytes so the the cacheline should start
>> > > -16 from where skb->data will point at.
>> >
>> > Hard-coding the x86 cacheline size is not a good idea. And what's the
>> > 16B for? You don't know that it's enough for the actual L2 headers.
>>
>> I am not hard coding the x86 cacheline. I am picking 64 as the largest cacheline that this is optimized for, it also works for smaller cachelines.
>
> Maybe use L1_CACHE_BYTES instead of 64? This will give you
> the actual size of the cacheline.

Yes, although a bit more than just a swap:

#define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)

Here's the new comment text which explains this:

/*
 * L2 Header resv: Arrange for cacheline to start at skb->data - 16 to keep the
 * to-be-pushed L2 header in the same cacheline as resulting `skb->data` (i.e.,
 * the L3 header). If cacheline size is > 64 then skb->data + pushed L2 will all
 * be in a single cacheline if we simply reserve 64 bytes.
 */

I'm simply protecting against some new arch that decides to have 256 byte cacheline since we do not need to reserve 256 bytes for L2 headers.

>> > > > > +	skb_reserve(skb, resv);
>> > > > > +
>> > > > > +	/* We do not want any of the tpl->headers copied over, so we do
>> > > > > +	 * not use `skb_copy_header()`.
>> > > > > +	 */
>> > > >
>> > > > This is a bit of a bad sign for the implementation. It also worries
>> > > > me, as this may not be updated when changes are made to
>> > > > __copy_skb_header().
>> > > > (c/p'd from v1 review since this was still not answered)
>> > >
>> > > I don't agree that this is a bad design at all, I'm curious what you think a good design to be.
>> >
>> > Strange skb manipulations hiding in a protocol module is not good
>> > design.
>>
>> It's a fragmentation and aggregation protocol, it's needs work with skbs by design. It's literally the function of the protocol to manipulate packet content.
>>
>> I would appreciate it if you could provide technical reasons to justify referring to things as "bad" or "strange" -- it's not helpful otherwise.
>>
>> > c/p bits of core code into a module (where they will never get fixed
>> > up when the core code gets updated) is always a bad idea.
>>
>> I need some values from the SKB, so I copy them -- it's that simple.
>>
>> > > I did specifically state why we are not re-using
>> > > skb_copy_header(). The functionality is different. We are not trying
>> > > to make a copy of an skb we are using an skb as a template for new
>> > > skbs.
>> >
>> > I saw that. That doesn't mean it's a good thing to do.
>>
>> Please suggest an alternative.
>
> Maybe create a helper like this:
>
> void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> {
>         new->tstamp             = old->tstamp;
>         /* We do not copy old->sk */
>         new->dev                = old->dev;
>         memcpy(new->cb, old->cb, sizeof(old->cb));
>         skb_dst_copy(new, old);
>         __skb_ext_copy(new, old);
>         __nf_copy(new, old, false);
> }
>
> and change __copy_skb_header() to use this too. That way it gets
> updated whenever something changes here.

Ok.

Thanks,
Chris.

> It also might make sense to split out the generic infrastructure changes
> into a separate pachset wih netdev maintainers Cced on. That would make
> the changes more visible.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmazof4SHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlILgP/Ai/gtKac29en/xeoLwTgAauZkBQ2zq0
uE+ssbtUMg4IriTheFoNBRa/YqRY6SYSK2ikQKmK629uMriNJf1rLKHJTvUnvNoY
UsviJ4VVCnozN+r3wEGCUeeITYNTIm4Xx2dGQ6yHjyfPRkx3pBtm9QlEEHeaTxF2
N4KncKyrKtlai1nyR8Mr1/xRQ0dPeKPHn3fkYsHxZTgCEV068WL+0QN+K7jwYTq6
GxRNSf1yBh6mK2jjx8nDfjAZ3gl3HAfxjkW3qTzqgu7o7J8tb1ZsXVW8K0Dhz5GY
x2k03rEu6O5Qd5oXy/5aj8BN1gR+D8//EIsc6ygZPqeyuPKqghkRdsB+vC93yRyA
92mEulUg0nF0OC1is7QzcRzO67K+I5UzxTuAApmKuaDi8+TRtS2AsX0ikSJZINk/
HR/fjTTNpFEYc5grGCJ2Y1CakvPF769CzOuQap/V6t3A/Hr5KcYO6XQMyRg63GhI
hjlMis57o77B3V4LivaJ5wAQEytuJeyWfa6wNIe6JiJY4CjnAsarUQcYoZW9aVMx
PYlWr+Nl3a0TWrtfqjQgj1lBR8liKR9PK61LVYt/Urg77UBgi1uHxu83wj9+NsMu
0wW119GgAsQ2UClL3Ww1G01in/7g0p8hLoX7dNaP4htCq4ZRbOkJI8zSXk8cHWqx
+Kdx60wxJiqT
=ZVRY
-----END PGP SIGNATURE-----
--=-=-=--

