Return-Path: <netdev+bounces-116046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE6948D6C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E42B25601
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3561C0DED;
	Tue,  6 Aug 2024 11:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E1143C4B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942359; cv=none; b=gjlaVM5hGCVi+iXPonn+b6u8heZhUCY4Jlqdosqa13ubG4rhFAPbpBDDU0+R1wuz4Y1oxqaUly6Xt2zWeQv4fRKj6zmwWaeLdlTMaP5M5czkbk2KbSWFogADj2sU4zDG8FhQ/kG3JNzsdN2BE+VuYqaTRbKmuB6Ks7JY0V/wMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942359; c=relaxed/simple;
	bh=rZwmuj7Cm32RNobSHUJ69JNy933Q6jvlmTbthAX4vrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mbyObqO6MSTxgMeGzZEn9H8YW1ilvGmYXL/o14ktW2b2xMw+FNOYWUpvpA5xgGNtM0+C+AlD94BW8/LJTpW3Ebku983T83evlgrLNZrW8OyWfRj0tjFPI+tDwGiUSkx2Qythxzo56XqauUXoeewnkdQPU8L+Yat6bknMAg6xke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-rzu9rK7SMDWSV0Dq9pH-Pw-1; Tue,
 06 Aug 2024 07:05:43 -0400
X-MC-Unique: rzu9rK7SMDWSV0Dq9pH-Pw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16E571955D42;
	Tue,  6 Aug 2024 11:05:42 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95E91956046;
	Tue,  6 Aug 2024 11:05:38 +0000 (UTC)
Date: Tue, 6 Aug 2024 13:05:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrIDfN2uFpktGJYD@hog>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
 <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m2le1aouzf.fsf@ja-home.int.chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-06, 04:54:53 -0400, Christian Hopps wrote:
>=20
> Sabrina Dubroca <sd@queasysnail.net> writes:
>=20
> > 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
> > > > > +/* 1) skb->head should be cache aligned.
> > > > > + * 2) when resv is for L2 headers (i.e., ethernet) we want the c=
acheline to
> > > > > + * start -16 from data.
> > > > > + * 3) when resv is for L3+L2 headers IOW skb->data points at the=
 IPTFS payload
> > > > > + * we want data to be cache line aligned so all the pushed heade=
rs will be in
> > > > > + * another cacheline.
> > > > > + */
> > > > > +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> > > > > +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
> > > >
> > > > How did you pick those values?
> > >=20
> > > That's what the comment is talking to. When reserving space for L2 he=
aders we
> > > pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the cacheline s=
hould start
> > > -16 from where skb->data will point at.
> >=20
> > Hard-coding the x86 cacheline size is not a good idea. And what's the
> > 16B for? You don't know that it's enough for the actual L2 headers.
>=20
> I am not hard coding the x86 cacheline. I am picking 64 as the largest ca=
cheline that this is optimized for, it also works for smaller cachelines.

At least use SMP_CACHE_BYTES then?

> 16B is to allow for the incredibly common 14B L2 header to fit.

Why not use skb->dev->needed_headroom, like a bunch of tunnels are
already doing? No guessing required. ethernet is the most common, but
there's no reason to penalize other protocols when the information is
available.

> > > For L3 we reserve double the power of 2 space we reserved for L2 only=
.
> >=20
> > But that's the core of my question. Why is that correct/enough?
>=20
> I have to pick a value. There is no magically perfect number that I can p=
ick. I've given you technical reasons and justifications for the numbers I =
have chosen -- not sure what else I can say. Do you have better suggestions=
 for the sizes which would be more optimal on more architectures? If not th=
en let's use the numbers that I have given technical reasons for choosing.

Yes, now you've spelled it out, and we can evaluate your choices.

> Put this another way. I could just pick 128 b/c it's 2 cachelines
> and fits lots of different headers and would be "good
> enough". That's plenty justification too. I think you looking for
> too much here -- this isn't a precision thing, it's a "Good Enough"
> thing.

I'm asking questions. That's kind of the reviewer's job, understanding
how the thing they're reviewing works. =C2=AF\_(=E3=83=84)_/=C2=AF

> > > We have to reserve some amount of space for pushed headers, so the ab=
ove made sense to me for good performance/cache locality.
> > >=20
> > > > > +static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32 =
len,
> > > > > +=09=09=09=09       bool l3resv)
> > > > > +{
> > > > > +=09struct sk_buff *skb;
> > > > > +=09u32 resv;
> > > > > +
> > > > > +=09if (!l3resv) {
> > > > > +=09=09resv =3D XFRM_IPTFS_MIN_L2HEADROOM;
> > > > > +=09} else {
> > > > > +=09=09resv =3D skb_headroom(tpl);
> > > > > +=09=09if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
> > > > > +=09=09=09resv =3D XFRM_IPTFS_MIN_L3HEADROOM;
> > > > > +=09}
> > > > > +
> > > > > +=09skb =3D alloc_skb(len + resv, GFP_ATOMIC);
> > > > > +=09if (!skb) {
> > > > > +=09=09XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMNOSKBERROR=
);
> > > >
> > > > Hmpf, so we've gone from incrementing the wrong counter to
> > > > incrementing a new counter that doesn't have a precise meaning.
> > >=20
> > > The new "No SKB" counter is supposed to mean "couldn't get an SKB",
> > > given plenty of other errors are logged under "OutErr" or "InErr"
> > > i'm not sure what level of precision you're looking for here. :)
> >=20
> > OutErr and InErr would be better than that new counter IMO.
>=20
> Why?
>=20
> My counter tracks the SKB depletion failure that is actually happening. W=
ould you have me now pass in the direction argument just so I can tick the =
correct overly general MIB counter that provides less value to the user in =
identifying the actual problem? How is that good design?
>=20
> I'm inclined to just delete the thing altogether rather than block on thi=
s thing that will almost never happen.

Fine.

> > > > > +=09=09return NULL;
> > > > > +=09}
> > > > > +
> > > > > +=09skb_reserve(skb, resv);
> > > > > +
> > > > > +=09/* We do not want any of the tpl->headers copied over, so we =
do
> > > > > +=09 * not use `skb_copy_header()`.
> > > > > +=09 */
> > > >
> > > > This is a bit of a bad sign for the implementation. It also worries
> > > > me, as this may not be updated when changes are made to
> > > > __copy_skb_header().
> > > > (c/p'd from v1 review since this was still not answered)
> > >=20
> > > I don't agree that this is a bad design at all, I'm curious what you =
think a good design to be.
> >=20
> > Strange skb manipulations hiding in a protocol module is not good
> > design.
>=20
> It's a fragmentation and aggregation protocol, it's needs work with skbs =
by design. It's literally the function of the protocol to manipulate packet=
 content.

packet content !=3D cherry-picked parts of sk_buff

> I would appreciate it if you could provide technical reasons to justify r=
eferring to things as "bad" or "strange" -- it's not helpful otherwise.

I did say it's a bad sign, not a blocking issue on its own. But that
bad sign, combined with the unusual use of skb_seq and a lot of
copying data around, indicates that this is not the right way to
implement this part of the protocol.

> > c/p bits of core code into a module (where they will never get fixed
> > up when the core code gets updated) is always a bad idea.
>=20
> I need some values from the SKB, so I copy them -- it's that simple.
>=20
> > > I did specifically state why we are not re-using
> > > skb_copy_header(). The functionality is different. We are not trying
> > > to make a copy of an skb we are using an skb as a template for new
> > > skbs.
> >=20
> > I saw that. That doesn't mean it's a good thing to do.
>=20
> Please suggest an alternative.

A common helper in a location where people are going to know that they
need to fix it up when they modify things about sk_buff would be a
good start.

> > > > > +/**
> > > > > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel =
buffer
> > > > > + * @st: source skb_seq_state
> > > > > + * @offset: offset in source
> > > > > + * @to: destination buffer
> > > > > + * @len: number of bytes to copy
> > > > > + *
> > > > > + * Copy @len bytes from @offset bytes into the source @st to the=
 destination
> > > > > + * buffer @to. `offset` should increase (or be unchanged) with e=
ach subsequent
> > > > > + * call to this function. If offset needs to decrease from the p=
revious use `st`
> > > > > + * should be reset first.
> > > > > + *
> > > > > + * Return: 0 on success or a negative error code on failure
> > > > > + */
> > > > > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offse=
t, void *to,
> > > > > +=09=09=09     int len)
> > > >
> > > > Probably belongs in net/core/skbuff.c, although I'm really not
> > > > convinced copying data around is the right way to implement the typ=
e
> > > > of packet splitting IPTFS does (which sounds a bit like a kind of
> > > > GSO). And there are helpers in net/core/skbuff.c (such as
> > > > pskb_carve/pskb_extract) that seem to do similar things to what you
> > > > need here, without as much data copying.
> > >=20
> > > I don't have an issue with moving more general skb functionality
> > > into skbuff.c; however, I do not want to gate IP-TFS on this change
> > > to the general net infra, it is appropriate for a patchset of it's
> > > own.
> >=20
> > If you need helpers that don't exist, it's part of your job to make
> > the core changes that are required to implement the functionality.
>=20
> This is part of a new code protocol and feature addition and it's a singl=
e use.

Of course the helper would be single use when it's introduced. You
don't know if it will remain single use. And pskb_extract is single
use, it's fine.

> Another patchset can present this code to the general network
> community to see if they think it *also* has value outside of
> IPTFS. There is *no* reason to delay IPTFS on general network
> infrastructure improvements. Please don't do this.

Sorry, I don't think that's how it works.

> > > Re copying: Let's be clear here, we are not always copying data,
> > > there are sharing code paths as well; however, there are times when
> > > it is the best (and even fastest) way to accomplish things (e.g.,
> > > b/c the packet is small or the data is arranged in skbs in a way to
> > > make sharing ridiculously complex and thus slow).
> >=20
> > I'm not finding the sharing code. You mean iptfs_first_should_copy
> > returning false?
>=20
>=20
>        /* Try share then copy. */
>        if (fragwalk && skb_can_add_frags(newskb, fragwalk, data, copylen)=
) {
>        ...
>                leftover =3D skb_add_frags(newskb, fragwalk, data, copylen=
);
>        } else {
>                /* copy fragment data into newskb */
>                if (skb_copy_bits_seq(st, data, skb_put(newskb, copylen),
>                ...
>        }

You're talking about reassembly now. This patch is fragmentation/TX.

--=20
Sabrina


