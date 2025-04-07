Return-Path: <netdev+bounces-179691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C06A7E24C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E273517E08C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628F1F7902;
	Mon,  7 Apr 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROnqe2g5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C431F63D6
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036305; cv=none; b=CTBh8r1rD0IXkIC6aGjfcKxW+XsbSA1//0IVJD1TrDzuqMLp3KRZIQTfFIKN3DzpOOseJUmQKQnLH4DjqOxIJfLucuknBljE4BLDH9jUSNjlWBGwKs+VVS1Gip/1RXOVkc97OLTWaKPpbiNLds+Y22OMgofMUBS+19wIYcn1FeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036305; c=relaxed/simple;
	bh=9ywF6Dm1SAB2jK6uFXvL1W1al4TRr8CmwBz2C6smRjY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f5b1QlLvGhvmYrPlLJwI6/gujN5gVxf7dDe+e401K9NZxxCFjimQTSSxlh9rmYK+nyDSqqqL+nPzGLjzaySyl8KFvppGJ3Io2E7JkRm5561q9fU+VSaa995nsMOp7aAXhLnSOMi05Ip0a3tnifuQYJHlfywLkGO2kniTHp/91+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROnqe2g5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8ec399427so37307946d6.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744036303; x=1744641103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkyNQlmKxRVaLWZGMx5AJLvS3Rif50GQKIVBJXpxBnI=;
        b=ROnqe2g5gKQsi6rLdDXF4ZeJBQDFLdV1mf+IsRCJHMrg8rCFoyRrcYrddNPyMvtJAs
         Z+KAkE70PjbKcUthpw4r1lvwndgQM56MEPLAbwgh6Za88pOiq67WqfLJApcqrVjAlXT8
         B8yxgPCa+QwiEJjLS1CLV4BcHdvcDwG8CkSb7iPzqK9k7TafbwIMV64T/tRqDn5LMxF7
         eYZ09yu4rftgjfAYkGfcuPdsNKN4lqIOj34bI4IWGG+Z8IohpT743NJvfqXuuECvMKAl
         hW0mE9w7bRKaqD+JOkF/RfSD12qnJNRuRbI4lP0o1bdVICTee1m6HG5whWqwBhAAE1pX
         VAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036303; x=1744641103;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkyNQlmKxRVaLWZGMx5AJLvS3Rif50GQKIVBJXpxBnI=;
        b=fuMadMl3gO83z7zCs55tAKlbTkgVnYPRHTmYeRPx36yv3KIbxfFsnfaL8x2iOFo503
         B/iwjjTn6tKZeQuBj0lrN7CwYMFXUAE99q8WfndJBbayjvaX1k/kD8kvcVwjfeszzcQ1
         ZddJK8pFRT+7EWBsb8I//SCLl06vWrI33vCE8UdC5OA4iZiQavIgZrj3gewRCO2oVn1V
         /GZ/i+1FLh8Jtx/zo83O0By9a0F1OPBKzGqUFY4WMLiYn7QKHCQt8bIGzcTJYKKZBRSV
         b2vK3tEbDhKVzPxGlAbgSfrjdaU1w0goqZPdn5/DrB4mGlNJ6vTRyYjjPN2mcHbrPQAd
         +3Sw==
X-Gm-Message-State: AOJu0YzIMPrQ0LYNcmAKgU5CcI5qquoEM1RWOXum1qO0bW5zpF7RPSnF
	GymiZSUX/hSUnz/Odlcz95S2JTBzC5C1JIZphCRWegKdrM7APipE
X-Gm-Gg: ASbGncvGhMAFni12pkwi7cyEK6OMKVXhFAyqZF1N8qWZSjvmfKZgdPR0mSLVCbWwhg3
	b7fLyHnMC6m8afanOCFE2H8Jvz1QtC+WUGpB6k12Jgy2a73SkKZn+tDj6Czy89XR2yEyViUt3yb
	e2xw2wwjkCSLVqD5MWVZxXk/mcjg6v4/cUJB8Nas1SoVUFbrRm6PzNirtlaNeuPP2SSqtuQlauk
	Bwcpa+uP/5jBcNyxdmF9aI1jID31N+X0HiXREK9C1/esZAiIAFf/gb1oAZx4VG/B1YYozL+ggxX
	BwIdVFvuZ/nXqMrdCJMsS/S8nYKlvBpYaL1DpHggyv5DRAcbtuwMtBR3o578L3AAu6krQeDe1wD
	a1snR+bTfS+vwitSSFVLJ6xrD6MeCGtME
X-Google-Smtp-Source: AGHT+IE5T8tOl65z1FrDaDAPIuSFq8/049zyMmd3PbaP+Mvcn2jQIxmGmKwq1rFGL1Yu0Riq6migHQ==
X-Received: by 2002:a05:6214:242a:b0:6e6:698f:cafd with SMTP id 6a1803df08f44-6f0b751a2c8mr147807436d6.37.1744036302524;
        Mon, 07 Apr 2025 07:31:42 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f137937sm58774086d6.80.2025.04.07.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:31:41 -0700 (PDT)
Date: Mon, 07 Apr 2025 10:31:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 gnault@redhat.com, 
 stfomichev@gmail.com
Message-ID: <67f3e1cd271f1_38ecd3294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z_NzAqmXB4rvKn-G@shredder>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-2-idosch@nvidia.com>
 <67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch>
 <Z_KFZ5cm7tOaBvw0@shredder>
 <67f2c83b70eb3_30e359294d4@willemb.c.googlers.com.notmuch>
 <Z_NzAqmXB4rvKn-G@shredder>
Subject: Re: [PATCH net 1/2] ipv6: Start path selection from the first nexthop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Sun, Apr 06, 2025 at 02:30:19PM -0400, Willem de Bruijn wrote:
> > Ido Schimmel wrote:
> > > Hi Willem,
> > > 
> > > Thanks for taking a look
> > > 
> > > On Fri, Apr 04, 2025 at 10:40:32AM -0400, Willem de Bruijn wrote:
> > > > Ido Schimmel wrote:
> > > > > Cited commit transitioned IPv6 path selection to use hash-threshold
> > > > > instead of modulo-N. With hash-threshold, each nexthop is assigned a
> > > > > region boundary in the multipath hash function's output space and a
> > > > > nexthop is chosen if the calculated hash is smaller than the nexthop's
> > > > > region boundary.
> > > > > 
> > > > > Hash-threshold does not work correctly if path selection does not start
> > > > > with the first nexthop. For example, if fib6_select_path() is always
> > > > > passed the last nexthop in the group, then it will always be chosen
> > > > > because its region boundary covers the entire hash function's output
> > > > > space.
> > > > > 
> > > > > Fix this by starting the selection process from the first nexthop and do
> > > > > not consider nexthops for which rt6_score_route() provided a negative
> > > > > score.
> > > > > 
> > > > > Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> > > > > Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > > > Closes: https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/
> > > > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > > > ---
> > > > >  net/ipv6/route.c | 38 +++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 35 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > > > index c3406a0d45bd..864f0002034b 100644
> > > > > --- a/net/ipv6/route.c
> > > > > +++ b/net/ipv6/route.c
> > > > > @@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
> > > > >  	return false;
> > > > >  }
> > > > >  
> > > > > +static struct fib6_info *
> > > > > +rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
> > > > > +{
> > > > > +	struct fib6_info *iter;
> > > > > +	struct fib6_node *fn;
> > > > > +
> > > > > +	fn = rcu_dereference(rt->fib6_node);
> > > > > +	if (!fn)
> > > > > +		goto out;
> > > > > +	iter = rcu_dereference(fn->leaf);
> > > > > +	if (!iter)
> > > > > +		goto out;
> > > > > +
> > > > > +	while (iter) {
> > > > > +		if (iter->fib6_metric == rt->fib6_metric &&
> > > > > +		    rt6_qualify_for_ecmp(iter))
> > > > > +			return iter;
> > > > > +		iter = rcu_dereference(iter->fib6_next);
> > > > > +	}
> > > > > +
> > > > > +out:
> > > > > +	return NULL;
> > > > > +}
> > > > 
> > > > The rcu counterpart to rt6_multipath_first_sibling, which is used when
> > > > computing the ranges in rt6_multipath_rebalance.
> > > 
> > > Right
> > > 
> > > > 
> > > > > +
> > > > >  void fib6_select_path(const struct net *net, struct fib6_result *res,
> > > > >  		      struct flowi6 *fl6, int oif, bool have_oif_match,
> > > > >  		      const struct sk_buff *skb, int strict)
> > > > >  {
> > > > > -	struct fib6_info *match = res->f6i;
> > > > > +	struct fib6_info *first, *match = res->f6i;
> > > > >  	struct fib6_info *sibling;
> > > > >  
> > > > >  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> > > > > @@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> > > > >  		return;
> > > > >  	}
> > > > >  
> > > > > -	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
> > > > > +	first = rt6_multipath_first_sibling_rcu(match);
> > > > > +	if (!first)
> > > > >  		goto out;
> > > > >  
> > > > > -	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> > > > > +	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > > > > +	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> > > > > +			    strict) >= 0) {
> > > > 
> > > > Does this fix address two issues in one patch: start from the first
> > > > sibling, and check validity of the sibling?
> > > 
> > > The loop below will only choose a nexthop ('match = sibling') if its
> > > score is not negative. The purpose of the check here is to do the same
> > > for the first nexthop. That is, only choose a nexthop when calculated
> > > hash is smaller than the nexthop's region boundary and the nexthop has a
> > > non negative score.
> > > 
> > > This was not done before for 'match' because the caller already chose
> > > 'match' based on its score.
> > > 
> > > > The behavior on negative score for the first_sibling appears
> > > > different from that on subsequent siblings in the for_each below:
> > > > in that case the loop breaks, while for the first it skips?
> > > > 
> > > >                 if (fl6->mp_hash > nh_upper_bound)
> > > >                         continue;
> > > >                 if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
> > > >                         break;
> > > >                 match = sibling;
> > > >                 break;
> > > > 
> > > > Am I reading that correct and is that intentional?
> > > 
> > > Hmm, I see. I think it makes sense to have the same behavior for all
> > > nexthops. That is, if nexthop fits in terms of hash but has a negative
> > > score, then fallback to 'match'. How about the following diff?
> > 
> > That unifies the behavior.
> > 
> > Is match guaranteed to be an acceptable path, i.e., having a positive
> > score?
> 
> It can be negative (-1) if there isn't a neighbour associated with the
> nexthop which isn't necessarily a bad sign. Even if this is the case,
> it's the nexthop the kernel chose after evaluating the others.
> 
> > Else just the first valid sibling after the matching, but invalid,
> > sibling, may be the most robust solution.
> 
> AFAICT, the kernel has been falling back to 'match' upon a negative
> sibling score since 2013, so my preference would be to keep this
> behavior.

Good point.

