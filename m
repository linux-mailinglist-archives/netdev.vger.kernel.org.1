Return-Path: <netdev+bounces-116805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499594BC46
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A61AB20B88
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880818B469;
	Thu,  8 Aug 2024 11:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD813D265
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116522; cv=none; b=kFFISXDiHg8USOomBYjvGb61q94AWCB+lOlmCBCob77DKxyjLeZrzYVvDIHRl4pxh/jsy7BhIlqqwTQQC/dBk5ehkv0uJaZ98pujrW26Eh4vCDY+7kM8zDcgzBerxVxts9p7vnAl5t2wx/73m8vDNyUr5+ZaBcesxrWE/Yg59Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116522; c=relaxed/simple;
	bh=Vvv9tdDeNnYnJT7/+PxzO7/Ny6jqVyjro2on756wRX8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=dzck91VQnzM+IXuQBuA7ViblQ3XDP04daBJZZMCnpv+mkYYy/Mr9yP4wNU4ziyfzSRo9rpw23tpAzqR/vMG6vvQPaTS8S/JZyYz8reNvyCLfsQIp607ZljmW3gHEG5tyQxHG/VyJnzqC3Lr4gShu51IOA2z6pt4NB3OsKr3EI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 27C197D064;
	Thu,  8 Aug 2024 11:28:39 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <ZrIJ0d6x3pTslQKn@gauss3.secunet.de>
 <m2jzgsnm3l.fsf@ja-home.int.chopps.org> <ZrSPXqJlck_DCnTi@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Thu, 08 Aug 2024 07:23:34 -0400
In-reply-to: <ZrSPXqJlck_DCnTi@hog>
Message-ID: <m2ed6znti1.fsf@ja-home.int.chopps.org>
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


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2024-08-07, 15:40:14 -0400, Christian Hopps wrote:
>>
>> Steffen Klassert <steffen.klassert@secunet.com> writes:
>>
>> > On Mon, Aug 05, 2024 at 12:25:57AM +0200, Sabrina Dubroca wrote:
>> > >
>> > > > +/**
>> > > > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buffer
>> > > > + * @st: source skb_seq_state
>> > > > + * @offset: offset in source
>> > > > + * @to: destination buffer
>> > > > + * @len: number of bytes to copy
>> > > > + *
>> > > > + * Copy @len bytes from @offset bytes into the source @st to the destination
>> > > > + * buffer @to. `offset` should increase (or be unchanged) with each subsequent
>> > > > + * call to this function. If offset needs to decrease from the previous use `st`
>> > > > + * should be reset first.
>> > > > + *
>> > > > + * Return: 0 on success or a negative error code on failure
>> > > > + */
>> > > > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
>> > > > +			     int len)
>> > >
>> > > Probably belongs in net/core/skbuff.c, although I'm really not
>> > > convinced copying data around is the right way to implement the type
>> > > of packet splitting IPTFS does (which sounds a bit like a kind of
>> > > GSO).
>> >
>> > I tried to come up with a 'GSO like' variant of this when I did the
>> > initial review last year at the IPsec workshop. But it turned out
>> > that things will get even more complicated as they are now.
>> > We did some performance tests and it was quite compareable to
>> > tunnel mode, so for a first implementation I'd be ok with the
>> > copy variant.
>
> Ok.
>
>> > > And there are helpers in net/core/skbuff.c (such as
>> > > pskb_carve/pskb_extract) that seem to do similar things to what you
>> > > need here, without as much data copying.
>> >
>> > In case we have helpers that will fit here, we should use them of
>> > course.
>>
>> FWIW, The reason I didn't use pskb_extract() rather than the simple
>> iptfs_copy_create_frag() is because pskb_extract uses skb_clone on
>> the original skb then pskb_carve() to narrow the (copied) data
>> pointers to a subset of the original. The new skb data is read-only
>> which does not work for us.
>>
>> Each of these new skbs are IP-TFS tunnel packets and as such we need
>> to push and write IPTFS+ESP+IP+Ethernet headers on them. In order to
>> make pskb_extract()s skbs writable we would have to allocate new
>> buffer space and copy the data turning them into a writeable skb
>> buffer, and now we're doing something more complex and more cpu
>> intensive to arrive back to what iptfs_copy_create_frag() did simply
>> and straight-forwardly to begin with.
>
> That only requires the header to be writeable, not the full packet,
> right? I doubt it would actually be more cpu/memory intensive.

pskb_extract() function leaves `skb->head = skb->data` there is no room left to push headers that we need to push.

FWIW, pskb_extract() is used in one place for TCP; it's not suited for IPTFS.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAma0q+YSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlXQQQAIBiBRm8uaMezVlEoN9L6CdypgMNfH/V
xSj4WneUwaEBK/Mmwp5lljPO+jCSJU/+iPHEnYXQ5KCTVOMYzuGTZZhr/I3usl/f
wEXrj0maBiuk+uQMf7dvtcpqpyXyRCd08ZiV5R00MVDCqhWst2yYdnDGiTeBU6ff
yiJbYQXBA/WrtfWPpvyXDdn/4qyYpdM+WGO/jtvO15POJrILnwID9csnm7ImeZfX
kIXPCmvYH9XnQGdc+jqWBKF/1E5sPpm8NX/vYQaUAGIS79CZ/KsZ49lf+LUAPW8+
9WFhsm46N8oVtQ1ELRNqbLssTDf4uyZKCM/b4dx7DZRWz6+poAkJuDvn/YTSVYDL
OPzXY6gfzabiLs1rlNxEUOZe6ZdrqcReB0dUzHHOrCiFfLj2GoaVcSCmqG02RQqI
kVA8AhLkI4NhkvqKlqCChPT8K0LsrQyr9mgw3HEj4ADIQJ8qmSqfjgHMTFF7X4fu
yF5ZBPv9m6fZjxcfJ5TlpH9tk6RvZxf+xhew/XlJi7yHk9ZiQ08s/NWaiPGXMqVU
/NmUQTXJJ6AnKlyZkd41qruUPJoQMAGGbDOCbRwF77PckdyCXwHWBy429TeaG8Cu
Bhrp+pnT77RFVDzmR5pfcBR4rzvM/GdQV5ZMxaMlSIGBrg2V6Z0pvBeY6H4IHYhy
zxVuAhtgVLfx
=2TXs
-----END PGP SIGNATURE-----
--=-=-=--

