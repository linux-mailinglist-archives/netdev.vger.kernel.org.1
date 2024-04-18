Return-Path: <netdev+bounces-89082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F178A9692
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1849D281CBB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B715B0F5;
	Thu, 18 Apr 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UMHQxJcI"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6B125D6
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433556; cv=none; b=Z7YrrJ5JOVxmONOAORik00k5pTvZeJgJIfkBv4fdX+T7nM7031hEdih5ZLo4p9x2Wf70+HGcaD01yIu0tGE7b4W2Qz6IFfT1xyIjd3NifnUYRkwfcLruXQZH5h9Yw9S4UbNNz2fMgBOsSZ/cOKDpBxvzLJC1ZOuWLeLkcs9HGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433556; c=relaxed/simple;
	bh=bTu1cC9HK9N7QafAOYUhG1slpZYvMP0fll0oNB8O1rk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu4CGhOjPaHemJmEitDXNEyOUOXqnP4lFPiZOYt2LtUTkh3RM1rpfWuYG+12x2dqw6XILOIRCemCMJfxFJXFX9qoQSSuuNEfZ8+eXB9dEjCEzaiBxUgFyvx/EpSHxR2Z8oLNeCFFoCmTNPDqmbU0/Dwl8S55W6AtE03AmR5XGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UMHQxJcI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E4A1C208BD;
	Thu, 18 Apr 2024 11:45:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlS9rTDcHZYo; Thu, 18 Apr 2024 11:45:44 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 50BF7206D2;
	Thu, 18 Apr 2024 11:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 50BF7206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713433544;
	bh=sN1gmLYXMxWb+10DwLNBUduYIsJMUI4GRXRpEfT87O8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=UMHQxJcIBzrfOD/DCHoegMmnM4xW89pBsObAA99Xi4dhE6aN1aqTHyaUexMV2vIsE
	 E3fa4dtvXlunYtWOlpiSvZ7uAVpmpPj/YZmbxwFsiuMvlMxGZkIZlDJ/ZAPg8JPSpR
	 kMSCEcwY+gn7nS+LGoJkYZ0LMOo5Ul2e7nNKOveRdeg2bhsJkvwlpj7ZV5ytt16gHt
	 7qj7ZGpq439E4Mhv1tV/Ji8joidM7is+B8TUP7IKSjpjnUVH7/Uwja+n9Jvbdnv7ir
	 VICN0L0SAPXH3/C82+JXRcZ5SdqVJPV67/xIB8iMMpp95BVB1YdXCbOfce2GBY63p/
	 Z9cR0+e8Wx1mw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 4497580004A;
	Thu, 18 Apr 2024 11:45:44 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 11:45:44 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 18 Apr
 2024 11:45:43 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6D2093180479; Thu, 18 Apr 2024 11:45:43 +0200 (CEST)
Date: Thu, 18 Apr 2024 11:45:43 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Daniel Xu
	<dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 1/3] xfrm: Add support for per cpu xfrm state
 handling.
Message-ID: <ZiDrx7wMV/DQryV+@gauss3.secunet.de>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-2-steffen.klassert@secunet.com>
 <3b63e04b-d883-4ef4-8450-c0ec91ecc709@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b63e04b-d883-4ef4-8450-c0ec91ecc709@strongswan.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Fri, Apr 12, 2024 at 12:37:24PM +0200, Tobias Brunner wrote:
> On 12.04.24 08:05, Steffen Klassert wrote:
> >  
> > diff --git a/net/key/af_key.c b/net/key/af_key.c
> > index f79fb99271ed..b9a1eb3ff461 100644
> > --- a/net/key/af_key.c
> > +++ b/net/key/af_key.c
> > @@ -1354,7 +1354,7 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
> >  	}
> >  
> >  	if (hdr->sadb_msg_seq) {
> > -		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
> > +		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, 0);
> 
> Shouldn't this be UINT_MAX instead of 0?  (Not sure if it makes a
> difference in practice, but it would be consistent with XFRM.)

Yes, right fixed

> 
> >  		if (x && !xfrm_addr_equal(&x->id.daddr, xdaddr, family)) {
> >  			xfrm_state_put(x);
> >  			x = NULL;
> > @@ -1362,7 +1362,8 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
> >  	}
> >  
> >  	if (!x)
> > -		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, proto, xdaddr, xsaddr, 1, family);
> > +		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, 0, proto,
> > +				  xdaddr, xsaddr, 1, family);
> 
> Same as above.

Fixed.

> 
> >  
> >  	if (x == NULL)
> >  		return -ENOENT;
> > @@ -1417,7 +1418,7 @@ static int pfkey_acquire(struct sock *sk, struct sk_buff *skb, const struct sadb
> >  	if (hdr->sadb_msg_seq == 0 || hdr->sadb_msg_errno == 0)
> >  		return 0;
> >  
> > -	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
> > +	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, 0);
> 
> Same as above.

Fixed too.

> >  	return x;
> > @@ -972,6 +973,7 @@ xfrm_init_tempstate(struct xfrm_state *x, const struct flowi *fl,
> >  	x->props.mode = tmpl->mode;
> >  	x->props.reqid = tmpl->reqid;
> >  	x->props.family = tmpl->encap_family;
> > +	x->type_offload = NULL;
> 
> This seems unrelated.  And is it actually necessary?  xfrm_state_alloc()
> uses kmem_cache_zalloc(), so this should be NULL anyway.

Removed.

> > @@ -1333,6 +1350,9 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
> >  			x = NULL;
> >  			error = -ESRCH;
> >  		}
> > +
> > +		if (best)
> > +			x = best;
> 
> Since `x` could be assigned to a (more specific in terms of CPU ID)
> state in state XFRM_STATE_ACQ at this point, it might warrant a comment
> that clarifies why it is unconditionally overridden with `best`.  That
> is, so this other matching "fallback" SA is used for this packet while
> the CPU-specific acquire is handled, which might not be immedialy
> obvious when reading the code.

Good point. I've added a comment.

Thanks for the review!

