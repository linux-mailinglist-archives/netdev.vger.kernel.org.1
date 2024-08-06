Return-Path: <netdev+bounces-116058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70742948DD6
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A181F22F90
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110E1C379D;
	Tue,  6 Aug 2024 11:40:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C31C379B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944459; cv=none; b=J8uGgR+kOzJRAiyaoK40thE9MhL3efm3TXjjHbdf0avYNs+7QXcfnFrw2cpTG0/SnFhC4oxPsPfYY0JS+GJIAX0LhqV4pdI45WkEExQA4cxuP/IOVNmDaqMo1MvmbNNyZPWSToM2m7O/1Iohl+jMtw4Bb23Alp/7CiGItLJZisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944459; c=relaxed/simple;
	bh=KwD+J5DTxuIDdu/lvvWCZtUer0sO238p89HhCoVhfuo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Tv+Im7rSXDe1YhX5JUSakbAZDt3O532h//q8i21sjoXP8T3xAEqtE9v50Cz9z2kTUt6VfdE81EgXeyVG+G29Kox6Nfszn0+MUPA+qMZoqI0QV8T5SKSiTiItqC8SJ1vHtAZkx+05lzSVC9fDNWOAwfAXOxahaB6w72Le5rkxQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 1DD5D7D08A;
	Tue,  6 Aug 2024 11:40:56 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org> <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org> <ZrIDfN2uFpktGJYD@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Tue, 06 Aug 2024 07:07:32 -0400
In-reply-to: <ZrIDfN2uFpktGJYD@hog>
Message-ID: <m234nhq3p4.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2024-08-06, 04:54:53 -0400, Christian Hopps wrote:
>>
>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>
>> > 2024-08-04, 22:33:05 -0400, Christian Hopps wrote:
>> > > > > +/* 1) skb->head should be cache aligned.
>> > > > > + * 2) when resv is for L2 headers (i.e., ethernet) we want the =
cacheline to
>> > > > > + * start -16 from data.
>> > > > > + * 3) when resv is for L3+L2 headers IOW skb->data points at th=
e IPTFS payload
>> > > > > + * we want data to be cache line aligned so all the pushed head=
ers will be in
>> > > > > + * another cacheline.
>> > > > > + */
>> > > > > +#define XFRM_IPTFS_MIN_L3HEADROOM 128
>> > > > > +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
>> > > >
>> > > > How did you pick those values?
>> > >
>> > > That's what the comment is talking to. When reserving space for L2 h=
eaders we
>> > > pick 64 + 16 (a 2^(<=3D6) cacheline + 16 bytes so the the cacheline =
should start
>> > > -16 from where skb->data will point at.
>> >
>> > Hard-coding the x86 cacheline size is not a good idea. And what's the
>> > 16B for? You don't know that it's enough for the actual L2 headers.
>>
>> I am not hard coding the x86 cacheline. I am picking 64 as the largest c=
acheline that this is optimized for, it also works for smaller cachelines.
>
> At least use SMP_CACHE_BYTES then?

Ok.

>> 16B is to allow for the incredibly common 14B L2 header to fit.
>
> Why not use skb->dev->needed_headroom, like a bunch of tunnels are
> already doing? No guessing required. ethernet is the most common, but
> there's no reason to penalize other protocols when the information is
> available.

>> > > For L3 we reserve double the power of 2 space we reserved for L2 onl=
y.
>> >
>> > But that's the core of my question. Why is that correct/enough?
>>
>> I have to pick a value. There is no magically perfect number that I can =
pick.
>> I've given you technical reasons and justifications for the numbers I ha=
ve
>> chosen -- not sure what else I can say. Do you have better suggestions f=
or the
>> sizes which would be more optimal on more architectures? If not then let=
's use
>> the numbers that I have given technical reasons for choosing.
>
> Yes, now you've spelled it out, and we can evaluate your choices.
>
>> Put this another way. I could just pick 128 b/c it's 2 cachelines
>> and fits lots of different headers and would be "good
>> enough". That's plenty justification too. I think you looking for
>> too much here -- this isn't a precision thing, it's a "Good Enough"
>> thing.
>
> I'm asking questions. That's kind of the reviewer's job, understanding
> how the thing they're reviewing works. =C2=AF\_(=E3=83=84)_/=C2=AF
>
>> > > We have to reserve some amount of space for pushed headers, so the a=
bove made sense to me for good performance/cache locality.
>> > >
>> > > > > +static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32=
 len,
>> > > > > +				       bool l3resv)
>> > > > > +{
>> > > > > +	struct sk_buff *skb;
>> > > > > +	u32 resv;
>> > > > > +
>> > > > > +	if (!l3resv) {
>> > > > > +		resv =3D XFRM_IPTFS_MIN_L2HEADROOM;
>> > > > > +	} else {
>> > > > > +		resv =3D skb_headroom(tpl);
>> > > > > +		if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
>> > > > > +			resv =3D XFRM_IPTFS_MIN_L3HEADROOM;
>> > > > > +	}
>> > > > > +
>> > > > > +	skb =3D alloc_skb(len + resv, GFP_ATOMIC);
>> > > > > +	if (!skb) {
>> > > > > +		XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMNOSKBERROR);
>> > > >
>> > > > Hmpf, so we've gone from incrementing the wrong counter to
>> > > > incrementing a new counter that doesn't have a precise meaning.
>> > >
>> > > The new "No SKB" counter is supposed to mean "couldn't get an SKB",
>> > > given plenty of other errors are logged under "OutErr" or "InErr"
>> > > i'm not sure what level of precision you're looking for here. :)
>> >
>> > OutErr and InErr would be better than that new counter IMO.
>>
>> Why?
>>
>> My counter tracks the SKB depletion failure that is actually happening. =
Would
>> you have me now pass in the direction argument just so I can tick the co=
rrect
>> overly general MIB counter that provides less value to the user in ident=
ifying
>> the actual problem? How is that good design?
>>
>> I'm inclined to just delete the thing altogether rather than block on th=
is thing that will almost never happen.
>
> Fine.
>
>> > > > > +		return NULL;
>> > > > > +	}
>> > > > > +
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
>> > > I don't agree that this is a bad design at all, I'm curious what you=
 think a good design to be.
>> >
>> > Strange skb manipulations hiding in a protocol module is not good
>> > design.
>>
>> It's a fragmentation and aggregation protocol, it's needs work with skbs=
 by design. It's literally the function of the protocol to manipulate packe=
t content.
>
> packet content !=3D cherry-picked parts of sk_buff
>
>> I would appreciate it if you could provide technical reasons to justify =
referring to things as "bad" or "strange" -- it's not helpful otherwise.
>
> I did say it's a bad sign, not a blocking issue on its own. But that
> bad sign, combined with the unusual use of skb_seq and a lot of
> copying data around, indicates that this is not the right way to
> implement this part of the protocol.

The seq walk is not a bad design, I am literally using an existing walk API=
 to walk the possibly complex nested chain of skbs.

All I've added is a useful utility function using that API to copy chunks o=
f data from the chain. Its doing this using a single seq walk through the c=
hain. It's the most obvious clean solution I can imagine to extract the fra=
gments -- hardly bad design, the opposite really.

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
> A common helper in a location where people are going to know that they
> need to fix it up when they modify things about sk_buff would be a
> good start.

What I am copying is specific to IP-TFS use case, that's what I am trying t=
o convey here. I am copying some data from the SKB, it is not a generalized=
 cloning operation that should be shared by anyone.

Is the advice that I should move this IPTFS functionality into skbuff.c?

>> > > > > +/**
>> > > > > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel=
 buffer
>> > > > > + * @st: source skb_seq_state
>> > > > > + * @offset: offset in source
>> > > > > + * @to: destination buffer
>> > > > > + * @len: number of bytes to copy
>> > > > > + *
>> > > > > + * Copy @len bytes from @offset bytes into the source @st to th=
e destination
>> > > > > + * buffer @to. `offset` should increase (or be unchanged) with =
each subsequent
>> > > > > + * call to this function. If offset needs to decrease from the =
previous use `st`
>> > > > > + * should be reset first.
>> > > > > + *
>> > > > > + * Return: 0 on success or a negative error code on failure
>> > > > > + */
>> > > > > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offs=
et, void *to,
>> > > > > +			     int len)
>> > > >
>> > > > Probably belongs in net/core/skbuff.c, although I'm really not
>> > > > convinced copying data around is the right way to implement the ty=
pe
>> > > > of packet splitting IPTFS does (which sounds a bit like a kind of
>> > > > GSO). And there are helpers in net/core/skbuff.c (such as
>> > > > pskb_carve/pskb_extract) that seem to do similar things to what you
>> > > > need here, without as much data copying.
>> > >
>> > > I don't have an issue with moving more general skb functionality
>> > > into skbuff.c; however, I do not want to gate IP-TFS on this change
>> > > to the general net infra, it is appropriate for a patchset of it's
>> > > own.
>> >
>> > If you need helpers that don't exist, it's part of your job to make
>> > the core changes that are required to implement the functionality.
>>
>> This is part of a new code protocol and feature addition and it's a sing=
le use.
>
> Of course the helper would be single use when it's introduced. You
> don't know if it will remain single use. And pskb_extract is single
> use, it's fine.

That is what a nice targeted patch and review process on netdev would revea=
l.

>> Another patchset can present this code to the general network
>> community to see if they think it *also* has value outside of
>> IPTFS. There is *no* reason to delay IPTFS on general network
>> infrastructure improvements. Please don't do this.
>
> Sorry, I don't think that's how it works.

I guess I disagree. Trying to boil the ocean here is what this feels like. =
Let's introduce this major new feature IPTFS. That's enough to handle for t=
his patchset and review.

>> > > Re copying: Let's be clear here, we are not always copying data,
>> > > there are sharing code paths as well; however, there are times when
>> > > it is the best (and even fastest) way to accomplish things (e.g.,
>> > > b/c the packet is small or the data is arranged in skbs in a way to
>> > > make sharing ridiculously complex and thus slow).
>> >
>> > I'm not finding the sharing code. You mean iptfs_first_should_copy
>> > returning false?
>>
>>
>>        /* Try share then copy. */
>>        if (fragwalk && skb_can_add_frags(newskb, fragwalk, data, copylen=
)) {
>>        ...
>>                leftover =3D skb_add_frags(newskb, fragwalk, data, copyle=
n);
>>        } else {
>>                /* copy fragment data into newskb */
>>                if (skb_copy_bits_seq(st, data, skb_put(newskb, copylen),
>>                ...
>>        }
>
> You're talking about reassembly now. This patch is fragmentation/TX.

Correct.

This code has been tested and performs quite good, especially for an initia=
l implementation. It keeps up with existing ESP in the general IPmix case, =
and even outperforms the existing IPsec/ESP for small packets flows when ag=
gregation kicks in. We also gain all the other benefits from IPTFS framing.

Adding to the code path you're referring to is possible enhancement task, i=
t will be complex, and as it is not required to achieve on-par and even bet=
ter performance than the existing code, it should not block or be required =
for the initial IPTFS implementation.

Thanks,
Chris.


