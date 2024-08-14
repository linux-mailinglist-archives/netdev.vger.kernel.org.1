Return-Path: <netdev+bounces-118429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A07951916
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ABC280DDE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADBE1AE05F;
	Wed, 14 Aug 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wYdlf0u3"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519A1AE846
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631928; cv=none; b=myx92Jsx4BzgVQzjHrNcoqBxbf5sA2dFjYFHG57XUC5lz4KEkKqVgZfwAmVfjBBIrMskGBjsq51Zq07sTKmOclG36cj2cHkoCKqAT8fT2zbi3ZR4zfNtlbS8Ug40WFb30mOD4hIJFhQn8R6+vWfi5rluhwEIEpx30gqqVYHLHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631928; c=relaxed/simple;
	bh=gl8j4o7Uh7r7Lsj4M2joYb38IIVntAuwj7dSLnGxV7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCA089TW2bA5qSVRZHDyf4sOSjwEWYmIcAVirSqZmmitnpK1WGT45HWMu6+hUavhO6IfSkOcqJkhQaer9AagRAWNDnvLpTF00WrEQF6F8cdbSin+8lXw1plk7/u6Qq0CvkIWuiw6I8VbpLndv2/jh8XM8aIi832wbWC1u0s7rnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wYdlf0u3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5634F2082B;
	Wed, 14 Aug 2024 12:38:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yioXiE5HLmcc; Wed, 14 Aug 2024 12:38:36 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 764892058E;
	Wed, 14 Aug 2024 12:38:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 764892058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1723631916;
	bh=H39C4c2odq7KyJ9Ta48l0A3WPAGo9oZKtUSM+ba3WbU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wYdlf0u3wQxITPIjzh37M7HQPiN0v9btRs//5cnad68VqTh39N2JWo3MJJQhjUrWX
	 cR7ydQH8AsdUt+0ByQQUeI2fxgkzb2/h3Ni9+9nf/3mM8CtGoNpnx0g3TH42kb12Lc
	 BYk+PdElyPkc64fgSmCtAWhdUUS/S9c1RQF/QQzrxuNiKAyw91L7hBo6aZXU2sn5Si
	 FQ7MH4+LWmcO+ivhPkdGh0HV2lcIHtZBQhfMd8NsEAftGt8q6AoUEzKQAjtRHSi3/O
	 5X3SVZbiKaUdcunnp3yfKEfq8h6kbcJr6nE751PzY0fZPW9tWtc4h3EvxHMvg625k7
	 IBCFP8h0QAb6A==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 12:38:36 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 12:38:35 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9996A318199B; Wed, 14 Aug 2024 12:38:35 +0200 (CEST)
Date: Wed, 14 Aug 2024 12:38:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Christian Hopps <chopps@chopps.org>, <devel@linux-ipsec.org>,
	<netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Florian
 Westphal" <fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v2 1/2] net: refactor common skb header copy
 code for re-use
Message-ID: <ZryJK8W1Acz0L/tU@gauss3.secunet.de>
References: <20240809083500.2822656-1-chopps@chopps.org>
 <20240809083500.2822656-2-chopps@chopps.org>
 <567fc2d7-63bf-4953-a4c0-e4aedfe6e917@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <567fc2d7-63bf-4953-a4c0-e4aedfe6e917@redhat.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Aug 14, 2024 at 11:46:56AM +0200, Paolo Abeni wrote:
> On 8/9/24 10:34, Christian Hopps wrote:
> > From: Christian Hopps <chopps@labn.net>
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1515,7 +1515,7 @@ EXPORT_SYMBOL(napi_consume_skb);
> >   	BUILD_BUG_ON(offsetof(struct sk_buff, field) !=		\
> >   		     offsetof(struct sk_buff, headers.field));	\
> > -static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> > +void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> >   {
> >   	new->tstamp		= old->tstamp;
> >   	/* We do not copy old->sk */
> > @@ -1524,6 +1524,12 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> >   	skb_dst_copy(new, old);
> >   	__skb_ext_copy(new, old);
> >   	__nf_copy(new, old, false);
> > +}
> > +EXPORT_SYMBOL_GPL(___copy_skb_header);
> > +
> > +static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> > +{
> > +	___copy_skb_header(new, old); >
> >   	/* Note : this field could be in the headers group.
> >   	 * It is not yet because we do not want to have a 16 bit hole
> 
> Could you please point where/how are you going to use this helper? factoring
> out this very core bits of skbuff copy looks quite bug prone - and exporting
> the helper could introduce additional unneeded function calls in the core
> code.

It is supposed to be used in the IPTFS pachset:

https://lore.kernel.org/netdev/20240807211331.1081038-12-chopps@chopps.org/

It was open coded before, but there were some concerns that
IPTFS won't get updated if __copy_skb_header changes.

