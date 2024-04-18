Return-Path: <netdev+bounces-89085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7718A96A6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559431F224EE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFB7158DDB;
	Thu, 18 Apr 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ujWsQRVh"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC215AAD7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433827; cv=none; b=JsKULQmDZk0fa5sNzlyEFVa8Hg8HdeQj0vkocwepPm0T6n233owfzIfaZRIkLMxg0CWGqxZkFOzhi4NMUXRNE+N1dyFnnMIQjtthXR+hYy2fjVkVm1Go8Yqdfx2/mWsVoOcoubD/nnqbQJzyOfzrrd64M7mlRRoBwkq+H625Ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433827; c=relaxed/simple;
	bh=DykE6FXSV4TIYBwZ3MAyprHcq1LDjyp+mjoiZLISzJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE0wWjFCWzHa1KfYHJrQWM1GyDnop4x2WtLHwFNoyq08BotkZWNfeSE7Hk5iXiSiA/7LTrXGLFdXCxSXGhgm/nNDrXNec7lEnc87GDYFPJR8pyU/+ss8pkdyokLk1YtLlu5zBuu30vVnxOdGVe68ySbg+aU0RJ2pp/qh8SrkA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ujWsQRVh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2C2AE208F1;
	Thu, 18 Apr 2024 11:50:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PucOE0WtV66Y; Thu, 18 Apr 2024 11:50:23 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9148820882;
	Thu, 18 Apr 2024 11:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9148820882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713433823;
	bh=NRMSGfnDdzLIHojwt4b9SHmU+VpEt9GG+DqIPhc18Jk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ujWsQRVh72n1sMl85fL4xYp/KDzjTU1wu2ss27jqgLz3ymObIy6QMHKOQu7nb474J
	 c5atbxbViXVpX4WMRihZ6Ts8Hn/t6+V9L5H4kQiGF1wsxfm4PS1vb0pucvOIvV4+Dt
	 S3iKusv854Vt/vR4/7lnqujyj/2j6SuccLroB7rHxdfhk8OxmhbI5fxRDv667ARPVW
	 3+o/tg0L0mNHkFerpLUx9AQzNWQY472lzq3J5Q+SGYOF05GoFEpYyUQ1LUohctnS+W
	 KfiF8y7ft3Oj4UDPSHRZkbdH1CA/E9EUGoylN1lH7lyiew8Xoq0Bi6mnuw7rYb6LL0
	 QRamJtniatymw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 82A5980004A;
	Thu, 18 Apr 2024 11:50:23 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 11:50:23 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 18 Apr
 2024 11:50:23 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D89E23180479; Thu, 18 Apr 2024 11:50:22 +0200 (CEST)
Date: Thu, 18 Apr 2024 11:50:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Tobias Brunner
	<tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 1/3] xfrm: Add support for per cpu xfrm state
 handling.
Message-ID: <ZiDs3n3yTLMnLzaK@gauss3.secunet.de>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-2-steffen.klassert@secunet.com>
 <Zh01zlwo0H1BmMug@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zh01zlwo0H1BmMug@hog>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, Apr 15, 2024 at 04:12:30PM +0200, Sabrina Dubroca wrote:
> 2024-04-12, 08:05:51 +0200, Steffen Klassert wrote:
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 0c306473a79d..b41b5dd72d8e 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> [...]
> > @@ -1096,6 +1098,9 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
> >  			       struct xfrm_state **best, int *acq_in_progress,
> >  			       int *error)
> >  {
> > +	unsigned int pcpu_id = get_cpu();
> > +	put_cpu();
> 
> That looks really strange to me. Is it safe? If it is, I guess you
> could just use smp_processor_id(), since you don't get anything out of
> the extra preempt_disable/enable pair.

We can use use smp_processor_id() as we just need the ID as a lookup
key.

> 
> (same in xfrm_state_find)
> 
> 
> [...]
> > @@ -2458,6 +2478,8 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
> >  	err = xfrm_if_id_put(skb, x->if_id);
> >  	if (err)
> >  		goto out_cancel;
> > +	if (x->pcpu_num != UINT_MAX)
> > +		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> 
> Missing the corresponding change to xfrm_aevent_msgsize?

Right, fixed.

> [...]
> > @@ -3049,6 +3078,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
> >  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
> >  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
> >  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
> > +	[XFRMA_SA_PCPU]		= { .type = NLA_U32 },
> 
> What about xfrm_compat? Don't we need to add XFRMA_SA_PCPU to
> compat_policy, and then some changes to the translators?

Yeah, I forgot this. The compat layer did not yet exist when
I wrote the initial pachset. The IETF standardization process
held this pachset off for about 5 years :-/

> [...]
> > @@ -3216,6 +3246,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
> >  	err = xfrm_if_id_put(skb, x->if_id);
> >  	if (err)
> >  		return err;
> > +	if (x->pcpu_num != UINT_MAX) {
> > +		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> 
> Missing the corresponding change to xfrm_expire_msgsize?

Fixed.

> [...]
> > @@ -3453,6 +3490,8 @@ static int build_acquire(struct sk_buff *skb, struct xfrm_state *x,
> >  		err = xfrm_if_id_put(skb, xp->if_id);
> >  	if (!err && xp->xdo.dev)
> >  		err = copy_user_offload(&xp->xdo, skb);
> > +	if (!err && x->pcpu_num != UINT_MAX)
> > +		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> 
> Missing the corresponding change to xfrm_acquire_msgsize?

Fixed.

Thanks for the review Sabrina!

