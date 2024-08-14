Return-Path: <netdev+bounces-118598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1058952317
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFAB1C2108E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB71BF30A;
	Wed, 14 Aug 2024 20:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2720B0F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666291; cv=none; b=MyDa3e26m0Zv/KNVBG+YM52AShvIixyOBtcygDdXlbUOj9QVo3ixTYZw7crP86N1/qdkuOHaSAiXD+eAsC5tvr0thdmecI7+NwUqFsLD+KKtCpEWWZQA5Zv9uw5bJEyeXf8NeKjYowUnyPiao1ch3p1OirraJqG34TVkbX3QsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666291; c=relaxed/simple;
	bh=b+Xa/trQXNaoC5dIpmhJvrlFoZ37Kjl3rp6PX8X2dE4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Wv3MjkzKOTCuRbg3nh5s0w65I7DOHkfIaBtW8Wlkwz2FpPHWX6RPGUe9GX9jQz2X1DnlU+et1BnG+agn3uuYFRgHlg/PN+BSKDg9oywBel+2FdGGTAlLTgiWkPl3fyfjPi1aHK1bURAZWhv5NnAaN8KI/ZPrEOzo1aXHfqtLoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id C03817D052;
	Wed, 14 Aug 2024 20:04:49 +0000 (UTC)
References: <20240809083500.2822656-1-chopps@chopps.org>
 <20240809083500.2822656-2-chopps@chopps.org>
 <567fc2d7-63bf-4953-a4c0-e4aedfe6e917@redhat.com>
 <ZryJK8W1Acz0L/tU@gauss3.secunet.de>
 <4d226a9e-8231-4794-a5ac-d426fac03361@redhat.com>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Christian Hopps
 <chopps@chopps.org>, devel@linux-ipsec.org, netdev@vger.kernel.org, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Florian Westphal <fw@strlen.de>, Sabrina
 Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony
 Antony <antony@phenome.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v2 1/2] net: refactor common skb header copy
 code for re-use
Date: Wed, 14 Aug 2024 11:34:31 -0400
In-reply-to: <4d226a9e-8231-4794-a5ac-d426fac03361@redhat.com>
Message-ID: <m2bk1uq3a7.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Paolo Abeni <pabeni@redhat.com> writes:

> On 8/14/24 12:38, Steffen Klassert wrote:
>> On Wed, Aug 14, 2024 at 11:46:56AM +0200, Paolo Abeni wrote:
>>> On 8/9/24 10:34, Christian Hopps wrote:
>>>> From: Christian Hopps <chopps@labn.net>
>>>> --- a/net/core/skbuff.c
>>>> +++ b/net/core/skbuff.c
>>>> @@ -1515,7 +1515,7 @@ EXPORT_SYMBOL(napi_consume_skb);
>>>>    	BUILD_BUG_ON(offsetof(struct sk_buff, field) !=		\
>>>>    		     offsetof(struct sk_buff, headers.field));	\
>>>> -static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>>> +void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>>>    {
>>>>    	new->tstamp		= old->tstamp;
>>>>    	/* We do not copy old->sk */
>>>> @@ -1524,6 +1524,12 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>>>    	skb_dst_copy(new, old);
>>>>    	__skb_ext_copy(new, old);
>>>>    	__nf_copy(new, old, false);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(___copy_skb_header);
>>>> +
>>>> +static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>>> +{
>>>> +	___copy_skb_header(new, old); >
>>>>    	/* Note : this field could be in the headers group.
>>>>    	 * It is not yet because we do not want to have a 16 bit hole
>>>
>>> Could you please point where/how are you going to use this helper? factoring
>>> out this very core bits of skbuff copy looks quite bug prone - and exporting
>>> the helper could introduce additional unneeded function calls in the core
>>> code.
>> It is supposed to be used in the IPTFS pachset:
>> https://lore.kernel.org/netdev/20240807211331.1081038-12-chopps@chopps.org/
>> It was open coded before, but there were some concerns that
>> IPTFS won't get updated if __copy_skb_header changes.
>
> The code is copying a subset of the skb header from a 'template' skb to a newly
> allocated skbuff.
> It's unclear to me why would be useful to copy only a subset of the skb header,
> excluding queue_mapping, priority, etc..
> I think we need a good justification for that, otherwise we could end-up with a
> large amount of "almost copy" skb header slicing the skb in many different ways.

IP-TFS sometimes needs to allocate new skb[s] to fragment a too-large tunnel ingress user packet. IP-TFS may also need to extract multiple aggregated user packets for tunnel egress from inside a single IPTFS tunnel packet. For these 1 to N cases (which are different from regular IPsec which is always 1-1 and thus re-using the existing skb) we need to create multiple skbs from a single source skb and we need to replicate the work done to the existing skb so far in the netdev/xfrm infrastructure (e.g. the _refdst and _nfct are expected to be there and refcounted as they are dropped later in the stack). This work is captured in those first few values that we are copying. The `headers` and other field values; however, are not appropriate to be copied (or clobbered e.g., alloc_cpu) into the new allocated skb.

I originally had this code local to the IP-TFS implementation, but I was persuaded to move it in skbuff.c to track any possible changes to these fields in the future.

Thanks,
Chris.

> Cheers,
>
> Paolo

