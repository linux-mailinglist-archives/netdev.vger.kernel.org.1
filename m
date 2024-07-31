Return-Path: <netdev+bounces-114660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78A9435D2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FD028168B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CA322F19;
	Wed, 31 Jul 2024 18:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426011EB3E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451719; cv=none; b=oHgI6Ty6aPCFmIjixdm8g4nUg3zVK+hvr5HJcgik/6V3LruxP+KRbnx5c70utxZUAINmkScZ0c3EQY1Qsq0FPoCBpjVUJNZAhaX538urpKulTbnqZg8wLrLQmx0DF8BXE92OYwS25i97unsagwldQJcNl0Qu7mNmzQutvGw6NIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451719; c=relaxed/simple;
	bh=7g+rKfgRos776pCaq1m/SGwp9dN5+9LxmSBXOrKoTCg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=bXgF1yux+5PClHzlNUE6TeZuDvowbyyoAQqdnyj6uRLf0Zm491RjJ0jT2JBuAGusiV++OtlU27nWys9Ee6Sfc9i/oD1AGmsqhXwvWz0ClNnCk9bERQYEV6zC5VB3ehOpXQxbcSTyoyBRv4cQXxOmHcbU3yHHpWNj+FMz2Z00X6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 254657D052;
	Wed, 31 Jul 2024 18:48:37 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-7-chopps@chopps.org> <ZqJT4llwpzag1TUr@hog>
 <m28qxhapkr.fsf@ja.int.chopps.org> <ZqpwB-kDLXt9N8vT@hog>
 <m2mslx8kwx.fsf@ja.int.chopps.org>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
  Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 Christian  Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 06/17] xfrm: add mode_cbs module
 functionality
Date: Wed, 31 Jul 2024 14:41:46 -0400
In-reply-to: <m2mslx8kwx.fsf@ja.int.chopps.org>
Message-ID: <m2ikwl8kjf.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Christian Hopps <chopps@chopps.org> writes:

> Sabrina Dubroca <sd@queasysnail.net> writes:
>
>> 2024-07-30, 17:29:06 -0400, Christian Hopps wrote:
>>>
>>> Sabrina Dubroca <sd@queasysnail.net> writes:
>>>
>>> > 2024-07-14, 16:22:34 -0400, Christian Hopps wrote:
>>> > > +struct xfrm_mode_cbs {
>>> >
>>> > It would be nice to add kdoc for the whole thing.
>>>
>>> Ok, I'll move the inline comments to a kdoc. FWIW, all the other structs in
>>> this header, including the main `xfrm_state` struct use the same inline
>>> comment documentation style I copied.
>>
>> Sure, but I don't think we should model new code on old habits.
>>
>>> > > diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>>> > > index 7cee9c0a2cdc..6ff05604f973 100644
>>> > > --- a/net/xfrm/xfrm_input.c
>>> > > +++ b/net/xfrm/xfrm_input.c
>>> > > @@ -494,6 +497,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>> > >
>>> > >  		family = x->props.family;
>>> > >
>>> > > +		/* An encap_type of -3 indicates reconstructed inner packet */
>>> >
>>> > And I think it's time to document all the encap_types above the
>>> > function (and in particular, how xfrm_inner_mode_input/encap_type=-3
>>> > pair together), and/or define some constants. Also, is -2 used
>>> > anywhere (I only see -1 and -3)? If not, then why -3?
>>>
>>> At the time this was added ISTR that there was some belief that -2
>>> was used perhaps in an upcoming patch, so I picked -3. I can't find
>>> a -2 use case though so I will switch to -2 instead.
>>>
>>> Re documentation: I think the inline comments where encap_type is
>>> used is sufficient documentation for the 2 negative values.
>>
>> I don't think it is. Inline comments are good to explain the internal
>> behavior, but that's more external behavior.
>
>>> There's
>>> a lot going on in this function and someone wishing to change (or
>>> understand) something is going to have to walk the code and use
>>> cases regardless of a bit of extra verbiage on the encap_value
>>> beyond what's already there. Fully documenting how xfrm_input works
>>> (in all it's use cases) seems beyond the scope of this patch to me.
>>
>> Sure, and that's really not what I'm asking for here. Something like
>> "encap_type=-3 makes xfrm_input jump right back to where it stopped
>> when xfrm_inner_mode_input returned -EINPROGRESS" is useful without
>> having to dive into the mess that is xfrm_input.
>
> If I'm not adding your suggested text into an inline comment where am I doing this?
>
> Bear in mind that encap_type can also have non-negative values, am I documenting
> all these cases too? It just seems like going down this path is asking for the
> entire function to be documented, perhaps I'm missing something though.
>
> Are other people going to be OK with a top of function comment that only documents the single (now) `-2` value for encap_type?

Actually, I will document the "Resume" negative value special cases in a top of function comment. If we want more generalized documentation for this function I think it should be in a different patch/project.

Thanks,
Chris.

> Thanks,
> Chris.


