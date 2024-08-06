Return-Path: <netdev+bounces-115995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3EF948B93
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B3B22A11
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0085B13A884;
	Tue,  6 Aug 2024 08:47:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9F16BE17
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934045; cv=none; b=tM+xUqmOSzVDuWxlymWVmS4dUBK92ZNrnvX7SYNKTZOloR1Ik4u9qEhKZlNBr2lqJIA+ZnM+p9YE4SF0IofaYqb2s1hlVDugZ275hI8A6bgKR6sSLNmimnoITe69IbFQF6bN1G6rag+YIRMQwghdTY1y4lncOjw7Rwov89UWS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934045; c=relaxed/simple;
	bh=LvXH+RYQzwHVWVapWXzQbE2zx8NoIlFfxaXKZ8trYdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nQFVA7DQ4sIno0Ufq7JgmSf++U3u5Hn570A2grR/dmpIM6cr0TzIRGLSbX7iXKVrCSILEKdusEujxqdRONNR9O6l/6uMyg0mTdPhdzFa+EHK54T5RoQblL9ftsp4gkJuS1UUVeNaXoZ1PjV4qPrBwNW/LUd9+vl300PJCSg16Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-Uw3DicH2M96HPcT4tFP1ag-1; Tue,
 06 Aug 2024 04:47:14 -0400
X-MC-Unique: Uw3DicH2M96HPcT4tFP1ag-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C8151956064;
	Tue,  6 Aug 2024 08:47:12 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D9841955D42;
	Tue,  6 Aug 2024 08:47:05 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:47:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZrHjByjZnnDgjvfo@hog>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
 <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <m2a5hr7iek.fsf@ja-home.int.chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
> > > +/* 1) skb->head should be cache aligned.
> > > + * 2) when resv is for L2 headers (i.e., ethernet) we want the cache=
line to
> > > + * start -16 from data.
> > > + * 3) when resv is for L3+L2 headers IOW skb->data points at the IPT=
FS payload
> > > + * we want data to be cache line aligned so all the pushed headers w=
ill be in
> > > + * another cacheline.
> > > + */
> > > +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> > > +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
> >=20
> > How did you pick those values?
>=20
> That's what the comment is talking to. When reserving space for L2 header=
s we pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the cacheline sh=
ould start -16 from where skb->data will point at.

Hard-coding the x86 cacheline size is not a good idea. And what's the
16B for? You don't know that it's enough for the actual L2 headers.

> For L3 we reserve double the power of 2 space we reserved for L2 only.

But that's the core of my question. Why is that correct/enough?

>=20
> We have to reserve some amount of space for pushed headers, so the above =
made sense to me for good performance/cache locality.
>=20
> > > +static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32 len,
> > > +=09=09=09=09       bool l3resv)
> > > +{
> > > +=09struct sk_buff *skb;
> > > +=09u32 resv;
> > > +
> > > +=09if (!l3resv) {
> > > +=09=09resv =3D XFRM_IPTFS_MIN_L2HEADROOM;
> > > +=09} else {
> > > +=09=09resv =3D skb_headroom(tpl);
> > > +=09=09if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
> > > +=09=09=09resv =3D XFRM_IPTFS_MIN_L3HEADROOM;
> > > +=09}
> > > +
> > > +=09skb =3D alloc_skb(len + resv, GFP_ATOMIC);
> > > +=09if (!skb) {
> > > +=09=09XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMNOSKBERROR);
> >=20
> > Hmpf, so we've gone from incrementing the wrong counter to
> > incrementing a new counter that doesn't have a precise meaning.
>=20
> The new "No SKB" counter is supposed to mean "couldn't get an SKB",
> given plenty of other errors are logged under "OutErr" or "InErr"
> i'm not sure what level of precision you're looking for here. :)

OutErr and InErr would be better than that new counter IMO.


> > > +=09=09return NULL;
> > > +=09}
> > > +
> > > +=09skb_reserve(skb, resv);
> > > +
> > > +=09/* We do not want any of the tpl->headers copied over, so we do
> > > +=09 * not use `skb_copy_header()`.
> > > +=09 */
> >=20
> > This is a bit of a bad sign for the implementation. It also worries
> > me, as this may not be updated when changes are made to
> > __copy_skb_header().
> > (c/p'd from v1 review since this was still not answered)
>=20
> I don't agree that this is a bad design at all, I'm curious what you thin=
k a good design to be.

Strange skb manipulations hiding in a protocol module is not good
design.

c/p bits of core code into a module (where they will never get fixed
up when the core code gets updated) is always a bad idea.


> I did specifically state why we are not re-using
> skb_copy_header(). The functionality is different. We are not trying
> to make a copy of an skb we are using an skb as a template for new
> skbs.

I saw that. That doesn't mean it's a good thing to do.

> > > +/**
> > > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buff=
er
> > > + * @st: source skb_seq_state
> > > + * @offset: offset in source
> > > + * @to: destination buffer
> > > + * @len: number of bytes to copy
> > > + *
> > > + * Copy @len bytes from @offset bytes into the source @st to the des=
tination
> > > + * buffer @to. `offset` should increase (or be unchanged) with each =
subsequent
> > > + * call to this function. If offset needs to decrease from the previ=
ous use `st`
> > > + * should be reset first.
> > > + *
> > > + * Return: 0 on success or a negative error code on failure
> > > + */
> > > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, v=
oid *to,
> > > +=09=09=09     int len)
> >=20
> > Probably belongs in net/core/skbuff.c, although I'm really not
> > convinced copying data around is the right way to implement the type
> > of packet splitting IPTFS does (which sounds a bit like a kind of
> > GSO). And there are helpers in net/core/skbuff.c (such as
> > pskb_carve/pskb_extract) that seem to do similar things to what you
> > need here, without as much data copying.
>=20
> I don't have an issue with moving more general skb functionality
> into skbuff.c; however, I do not want to gate IP-TFS on this change
> to the general net infra, it is appropriate for a patchset of it's
> own.

If you need helpers that don't exist, it's part of your job to make
the core changes that are required to implement the functionality.

> Re copying: Let's be clear here, we are not always copying data,
> there are sharing code paths as well; however, there are times when
> it is the best (and even fastest) way to accomplish things (e.g.,
> b/c the packet is small or the data is arranged in skbs in a way to
> make sharing ridiculously complex and thus slow).

I'm not finding the sharing code. You mean iptfs_first_should_copy
returning false?

--=20
Sabrina


