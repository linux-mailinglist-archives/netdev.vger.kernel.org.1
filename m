Return-Path: <netdev+bounces-86939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BE8A10BA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD31F2CC85
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A29149C61;
	Thu, 11 Apr 2024 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="Pu84yJMQ"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857313D258
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831802; cv=none; b=sbRgajicpA3vQJBCczY5g6ZmNTAVpoIqk1K/lA0AUhoBC7053z0LSd88YdX/84G/Lhy0QPXPAIOwKCiaJjF88hCFRqzIb+kOhwZoAjIKLFRHsR4geUeb70nSrlQg/dpscmkgqZN8EbK/SzRvF1iCkaKE3+t+9s8uJv59inHKPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831802; c=relaxed/simple;
	bh=reHmEwElj4tvZol91A+rJsafa4ep732TOWew7uulUW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpDFAgYNRUx4C6eJA6ByoeoXgAWtLoCfUklSN9e6AOAsXRSlIQ0O7jEzjoK0WDc5kFDZn3JBhxguscgKXRkDyoRhqbduhNaD6lO7s5s7nWU9QEvS+fr2QfexUlyWIHV8HAnwDMfCVoHVEp3PZ2tqWaDBCKu1q0cgZql6iDzuXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=Pu84yJMQ; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 3e1be364-f7ef-11ee-bbc8-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3e1be364-f7ef-11ee-bbc8-005056abad63;
	Thu, 11 Apr 2024 12:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=y/sGibiyC5Cu2JjV7T+h2eZcqZoexvNCioKaD4hSCMo=;
	b=Pu84yJMQZVzyZTSShC3FT9nMhXCJ52TA5FDjgj7N0CSe/gNzHHsfQJ+K6cLHNBAYKALOj9YDmScN5
	 YNHcnZ1YFzIZNJLfkSA5DHOzzKrtxXiQ8gpovzzZ7RcagfEaU19MHoTGenpULFVdFht3bfAXFJ0Lk+
	 KHAKH6aAP3v1XtqY=
X-KPN-MID: 33|DVvwAIfaAxYemf5ReAsdXLMlJnpb2/yz+fCXtOQwz5LBRnbkRvcBmLCZIawgFbO
 broaq2mCJIF4rtF/+iq3r6MzZ9q7ZqXyPCmv0/mEtbyw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|/o5T6EF3yX/WzKrMqjNVi1HqGgzMqC3Fpyip+9L6nM5AnSgVUTabr2QJVT0MyUb
 7nMnoVksIoNW24VLE1bShfA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 5aa162d3-f7ef-11ee-a211-005056ab1411;
	Thu, 11 Apr 2024 12:36:29 +0200 (CEST)
Date: Thu, 11 Apr 2024 12:36:28 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <Zhe9LB97ik37hM3q@Antony2201.local>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
 <ZhesNtc8tdTfuvRd@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhesNtc8tdTfuvRd@hog>

On Thu, Apr 11, 2024 at 11:24:06AM +0200, Sabrina Dubroca wrote:
> 2024-04-10, 18:59:00 +0200, Antony Antony wrote:
> > On Wed, Apr 10, 2024 at 10:56:34AM +0200, Sabrina Dubroca wrote:
> > > 2024-04-09, 19:23:04 +0200, Antony Antony wrote:
> > > > Good point. I will add  {seq,seq_hi} validation. I don't think we add a for 
> > > > {oseq,oseq_hi} as it might be used by strongSwan with: ESN  replay-window 1, 
> > > > and migrating an SA.
> > > 
> > > I'm not at all familiar with that. Can you explain the problem?
> > 
> > strongSwan sets ESN and replay-window 1 on "out" SA. Then to migrgate, when 
> > IKEv2  mobike exchange succeds, it use GETSA read {oseq,oseq_hi} and the 
> > attributes, delete this SA.  Then create a new SA, with a different end 
> > point, and with old SA's {oseq,oseq_hi} and other parameters(curlft..).  
> > While Libreswan and Android use XFRM_MSG_MIGRATE.
> 
> Ok, thanks. But that's still an output SA. Setting {oseq,oseq_hi} on
> an input SA is bogus I would think?

Corrrect, It is not allowed in v10.

> 
> > > > > xfrma_policy is convenient but not all attributes are valid for all
> > > > > requests. Old attributes can't be changed, but we should try to be
> > > > > more strict when we introduce new attributes.
> > > > 
> > > > To clarify your feedback, are you suggesting the API should not permit 
> > > > XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it for 
> > > > XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it's used 
> > > > equivalently to XFRM_MSG_NEWSA by *swan.
> > > 
> > > Not just DELSA, also all the *POLICY, ALLOCSPI, FLUSHSA, etc. NEWSA
> > > and UPDSA should accept it, but I'm thinking none of the other
> > > operations should. It's a property of SAs, not of other xfrm objects.
> > 
> > For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS in 
> > DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set in 
> > DELSA, it would also be disregarded. Attempting to introduce validations for 
> > DELSA and other methods seems like an extensive cleanup task. Do we consider 
> > this level of validation within the scope of our current patch? It feels 
> > like we are going too far.
> 
> No, I wouldn't introduce validation of other attributes. It doesn't
> belong in this patch(set), and I'm not sure we can add it now as it
> might break userspace (I don't see why userspace would pass
> XFRMA_ALG_AEAD etc on a DELSA request, but if we never rejected it,
> they could). 
> 
> But rejecting this new attribute from messages that don't handle it
> would be good, and should be done in this patch/series.

Definitely see the value in such feature in general, but it seems ambitious 
for this patch set. Currently, only NEWSA, UPDSA, and ALLOCSPI need 
XFRMA_SA_DIR. I am wondering how to reject this atrribute in remaining 20-22 
messages.  Is there a precedent or example in xfrm_user.c for this kind of 
validation, or maybe a Netlink feature that lets us restrict NL attributes 
for a specific messages like DELSA.

If not, it feels like a  seperate patch set for general API cleanup.

