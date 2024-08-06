Return-Path: <netdev+bounces-116013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A795948C92
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADEDBB22C42
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAF1BD51B;
	Tue,  6 Aug 2024 10:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32E1BDA82
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938770; cv=none; b=MDdD6Vf0OJyLMHAa+721OQz0AMAQCAuwwVYHY1NAg5I/CcdjBeYkjziTITBH06KgVOHsEiqTpfvfthbVeZ6xl3e7vU7uAnkuhJtNJ6zyJVTXFME+MDqC065sPv9/y+nJw+BBv6djT42bcmCH6Hl6W/c5IvHPOf+4cCTsQ+Gyt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938770; c=relaxed/simple;
	bh=W+0cEmi6u+jgE9REwXZpRnOoPVh0YFqr6s7Dui+JgPo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=LsQHjFsbkaGXQzvD9jBnS2kZ+0rPS3pQV2waOno7qvliSIaMNPFbOFeWF5me0MBN4ljYo3q48k+wfgyMl6On4iA0lJtyqsJEMO0cwCrHkVofi7rRbL3WSslzpRN23d715+XBp1S6FEC3F5KabbeBYV4c4moy+MUmTWrz/ugZERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 331FB7D08A;
	Tue,  6 Aug 2024 10:06:08 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org> <ZrHjByjZnnDgjvfo@hog>
 <m2le1aouzf.fsf@ja-home.int.chopps.org>
 <20240806100304.GA32447@breakpoint.cc>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Florian Westphal <fw@strlen.de>
Cc: Christian Hopps <chopps@chopps.org>, Sabrina Dubroca
 <sd@queasysnail.net>, devel@linux-ipsec.org, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Tue, 06 Aug 2024 06:05:46 -0400
In-reply-to: <20240806100304.GA32447@breakpoint.cc>
Message-ID: <m2ed72otio.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Florian Westphal <fw@strlen.de> writes:

> Christian Hopps <chopps@chopps.org> wrote:
>> > > > > +	if (!l3resv) {
>> > > > > +		resv = XFRM_IPTFS_MIN_L2HEADROOM;
>> > > > > +	} else {
>> > > > > +		resv = skb_headroom(tpl);
>> > > > > +		if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
>> > > > > +			resv = XFRM_IPTFS_MIN_L3HEADROOM;
>> > > > > +	}
>> > > > > +
>> > > > > +	skb = alloc_skb(len + resv, GFP_ATOMIC);
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
>> My counter tracks the SKB depletion failure that is actually happening. Would
>> you have me now pass in the direction argument just so I can tick the correct
>> overly general MIB counter that provides less value to the user in identifying
>> the actual problem? How is that good design?
>>
>> I'm inclined to just delete the thing altogether rather than block on this thing that will almost never happen.
>
> Makes sense to me, skb allocation failure is transient anyway, there is
> no action that could be taken if this error counter is incrementing.
>
> You might want to pass GFP_ATOMIC | __GFP_NOWARN to alloc_skb() to avoid
> any splats given this is a high-volume allocation.

Will do.

Thanks,
Chris.


