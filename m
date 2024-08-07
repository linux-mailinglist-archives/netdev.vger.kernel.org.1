Return-Path: <netdev+bounces-116580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB194B0CA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FE9283F78
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E51448C7;
	Wed,  7 Aug 2024 19:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47E4653A
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060578; cv=none; b=YohpAAoa6C00kORI6qb1qapSmoCxsnxfYaaesZ86jJv5rcqgkRqGFUJec/sejj5kIO9+s0wbvLSTNWYO5JG3agP2mJ/6LxDuAkdff2ftyp6tkj2qy2zUE7pkPwIj6l+FSbxqf12/zUltwd8tFntBQIDnvB9saILoTMOTRY+eQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060578; c=relaxed/simple;
	bh=If9wF05b76ZddojDo1fl4RVjjNKRx+prRlgapJ85VmU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=C2BFHGXLeENQ1tyFDlkq624y+sDgzZEqrSbTL8B8FZ6kSGnQXfya/c71DxZCFrqvOosD2+XkSoJZW2yl6CyMmrlfyBdBTsJStOhHPRe4o8cmEVqekMbAD1s1T/ZtOupdX0aEEii5KgoZKQEgHNR5L0Lr0N13YJePcrh8vGy/4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B4BA87D0C1;
	Wed,  7 Aug 2024 19:56:15 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <ZrIJ0d6x3pTslQKn@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Christian Hopps
 <chopps@chopps.org>, devel@linux-ipsec.org, netdev@vger.kernel.org,
 Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Wed, 07 Aug 2024 15:40:14 -0400
In-reply-to: <ZrIJ0d6x3pTslQKn@gauss3.secunet.de>
Message-ID: <m2jzgsnm3l.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Steffen Klassert <steffen.klassert@secunet.com> writes:

> On Mon, Aug 05, 2024 at 12:25:57AM +0200, Sabrina Dubroca wrote:
>>
>> > +/**
>> > + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buffer
>> > + * @st: source skb_seq_state
>> > + * @offset: offset in source
>> > + * @to: destination buffer
>> > + * @len: number of bytes to copy
>> > + *
>> > + * Copy @len bytes from @offset bytes into the source @st to the destination
>> > + * buffer @to. `offset` should increase (or be unchanged) with each subsequent
>> > + * call to this function. If offset needs to decrease from the previous use `st`
>> > + * should be reset first.
>> > + *
>> > + * Return: 0 on success or a negative error code on failure
>> > + */
>> > +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
>> > +			     int len)
>>
>> Probably belongs in net/core/skbuff.c, although I'm really not
>> convinced copying data around is the right way to implement the type
>> of packet splitting IPTFS does (which sounds a bit like a kind of
>> GSO).
>
> I tried to come up with a 'GSO like' variant of this when I did the
> initial review last year at the IPsec workshop. But it turned out
> that things will get even more complicated as they are now.
> We did some performance tests and it was quite compareable to
> tunnel mode, so for a first implementation I'd be ok with the
> copy variant.
>
>
>> And there are helpers in net/core/skbuff.c (such as
>> pskb_carve/pskb_extract) that seem to do similar things to what you
>> need here, without as much data copying.
>
> In case we have helpers that will fit here, we should use them of
> course.

FWIW, The reason I didn't use pskb_extract() rather than the simple iptfs_copy_create_frag() is because pskb_extract uses skb_clone on the original skb then pskb_carve() to narrow the (copied) data pointers to a subset of the original. The new skb data is read-only which does not work for us.

Each of these new skbs are IP-TFS tunnel packets and as such we need to push and write IPTFS+ESP+IP+Ethernet headers on them. In order to make pskb_extract()s skbs writable we would have to allocate new buffer space and copy the data turning them into a writeable skb buffer, and now we're doing something more complex and more cpu intensive to arrive back to what iptfs_copy_create_frag() did simply and straight-forwardly to begin with.

Thanks,
Chris.

