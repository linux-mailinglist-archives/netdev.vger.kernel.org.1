Return-Path: <netdev+bounces-179474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B941EA7CF94
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51229188D1CC
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB31474CC;
	Sun,  6 Apr 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWMJqwFi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E028371
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964223; cv=none; b=GP4eLcXhCmxiJzV9+8A+zDeg0kwhK4zj3B2WiX64adPZzb2G5amajV0PaEKHaH2uHY5wi/r1qy58+9BhDnliomvZF9vIMZ/tGOMZnmnxa1IfQRO+8gJuUuw0+t1VWxjLSq5E21noGolSxUUfs35gCWdQMPsPgnUkmh+HK5m8i1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964223; c=relaxed/simple;
	bh=D0aA5xPMYt/e6JLot8iL1JvXe9CDltyEEhfmWe6oiiQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eJKzLUGYQRViYB0/b7awxdqjWygCwiRAjQLfkdKg6aP29mWD1Bro0RnDko/8Maq0dKn6bcMFvSajh2vNZr8a/hQcC1natw4o8NkYaH6yxqOe6v6RvW+q30SS18HmKALvd7x9rCzyvpmGq5CDwt0eOLb5JFtC3YZf7IDFMqBDdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWMJqwFi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c59e7039eeso539644785a.2
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743964221; x=1744569021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55ULUkL1kEUERLow9Rym21pLdYyj5mMawcK5P159e/4=;
        b=QWMJqwFiLrzhhzsgNfzohrq68F9RCS8PfclhF8AGVjpA5E/FRsLrZytODEccibuh7Y
         2eJk7lZeVeSjkqMNxhZeiWM+krYOcI4LiyztIqy0DQZkma2ZfSyEaE1yIbj11twH1xXC
         Ri7ElBpxPi6sPYCQzAfebEOyxJtrAOGZz8iojTr7N/b8onB4z9PZlY2OFufwbOq1GY5G
         z+EMjNKyu724isoYqgIecu0fg4kz1pAJdL8pp0eLVwH1amtMB0Qb/jdr7GxlpuHpfxOW
         wdBbX1rpIITOXC0FRk0BRtrcsoEkQbxmRmx1/8Lql4PXzro0V9CbYpcZk/gsTlkDET6u
         bbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743964221; x=1744569021;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=55ULUkL1kEUERLow9Rym21pLdYyj5mMawcK5P159e/4=;
        b=wwMv+rL6dWw4adVTW+F4sGOzbUA+jTU04/CRNbhFzffs82CABY3iH7/fyyOMpUouD3
         3gNfCYNshm5CJamJLBEL4QzZ8cpOvVgOFtQcOCQJnimkIZV2yng+mvnTQXGvT62i8oW4
         RbV7Sr/LCHlFeCVjEQhI622Obo576bIPfYARkS8hxccGrF3CFacj6RuR/P1P5WF9PCtL
         cBBsJYgpCS/OSOHEnQa0KmYap/ef+sOODBGPIAWzS8hqDJrBAmKa2JsH6eC+RIxIF9pY
         ichBYib5vvXM380ahRocGXAnZYNV9A65/G1L5iLT3XP74t7HalRDnxPAGXjj96y5gbXq
         hchQ==
X-Gm-Message-State: AOJu0Yw2QzTJIB4xbaIe3lhEm5HiPG4fvZHh6acNOWWY2TJ1JH3y1GYv
	xHPFHEYLG/1aZ1Bpcrbu3A/HYtu31GfvOQSqdvJIFXUbPdNpMP0o
X-Gm-Gg: ASbGncsGQS+If5O9XVm03/oeHPwsGO+EF3icovLN1NtvgjyV9Zak6rjbVy1ndP6+PbI
	/qjrmr3ZuMdd7YG8y+CfLvk/NGSKEJ5J81ycfgnQgTGneI9MEiRfWGqE3uVaaAO8vUCN+kHz/7D
	kfZ1tMOD26UcodOv9uDTHNTQRL2AmOJu7JHbkgUQpQPh5NOxdWGJlr89fnFQajZQCKgLpvmXYaw
	CUOlMAJddoroihcn8QhOBzy3/a7pdU36TjsADBb0qT1UlbD0bI93khYYSYSNRQshJqqMsXqEVw/
	5CzkOOZolp5AUek0iMyCbVXlg4oFyP8KtzVy7h88y5BLkaRGsOGc58SkEt5rr0Ggi2PDgcOCcSE
	WZ5zNM1l2i8nJFIAdZW53zg==
X-Google-Smtp-Source: AGHT+IGi9zcvvQ/t9WwJJ6EM4GguA2OmpBvvtXzTG5+jZD2uWNGfpCUP5LEesDSN1IMp5i07KdoMmQ==
X-Received: by 2002:a05:620a:24d0:b0:7c5:9a10:7824 with SMTP id af79cd13be357-7c774d5efa9mr1337157185a.24.1743964220806;
        Sun, 06 Apr 2025 11:30:20 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b088433sm51220281cf.43.2025.04.06.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 11:30:19 -0700 (PDT)
Date: Sun, 06 Apr 2025 14:30:19 -0400
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
Message-ID: <67f2c83b70eb3_30e359294d4@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z_KFZ5cm7tOaBvw0@shredder>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-2-idosch@nvidia.com>
 <67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch>
 <Z_KFZ5cm7tOaBvw0@shredder>
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
> Hi Willem,
> 
> Thanks for taking a look
> 
> On Fri, Apr 04, 2025 at 10:40:32AM -0400, Willem de Bruijn wrote:
> > Ido Schimmel wrote:
> > > Cited commit transitioned IPv6 path selection to use hash-threshold
> > > instead of modulo-N. With hash-threshold, each nexthop is assigned a
> > > region boundary in the multipath hash function's output space and a
> > > nexthop is chosen if the calculated hash is smaller than the nexthop's
> > > region boundary.
> > > 
> > > Hash-threshold does not work correctly if path selection does not start
> > > with the first nexthop. For example, if fib6_select_path() is always
> > > passed the last nexthop in the group, then it will always be chosen
> > > because its region boundary covers the entire hash function's output
> > > space.
> > > 
> > > Fix this by starting the selection process from the first nexthop and do
> > > not consider nexthops for which rt6_score_route() provided a negative
> > > score.
> > > 
> > > Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> > > Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > Closes: https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > ---
> > >  net/ipv6/route.c | 38 +++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 35 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index c3406a0d45bd..864f0002034b 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
> > >  	return false;
> > >  }
> > >  
> > > +static struct fib6_info *
> > > +rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
> > > +{
> > > +	struct fib6_info *iter;
> > > +	struct fib6_node *fn;
> > > +
> > > +	fn = rcu_dereference(rt->fib6_node);
> > > +	if (!fn)
> > > +		goto out;
> > > +	iter = rcu_dereference(fn->leaf);
> > > +	if (!iter)
> > > +		goto out;
> > > +
> > > +	while (iter) {
> > > +		if (iter->fib6_metric == rt->fib6_metric &&
> > > +		    rt6_qualify_for_ecmp(iter))
> > > +			return iter;
> > > +		iter = rcu_dereference(iter->fib6_next);
> > > +	}
> > > +
> > > +out:
> > > +	return NULL;
> > > +}
> > 
> > The rcu counterpart to rt6_multipath_first_sibling, which is used when
> > computing the ranges in rt6_multipath_rebalance.
> 
> Right
> 
> > 
> > > +
> > >  void fib6_select_path(const struct net *net, struct fib6_result *res,
> > >  		      struct flowi6 *fl6, int oif, bool have_oif_match,
> > >  		      const struct sk_buff *skb, int strict)
> > >  {
> > > -	struct fib6_info *match = res->f6i;
> > > +	struct fib6_info *first, *match = res->f6i;
> > >  	struct fib6_info *sibling;
> > >  
> > >  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> > > @@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> > >  		return;
> > >  	}
> > >  
> > > -	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
> > > +	first = rt6_multipath_first_sibling_rcu(match);
> > > +	if (!first)
> > >  		goto out;
> > >  
> > > -	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> > > +	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > > +	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> > > +			    strict) >= 0) {
> > 
> > Does this fix address two issues in one patch: start from the first
> > sibling, and check validity of the sibling?
> 
> The loop below will only choose a nexthop ('match = sibling') if its
> score is not negative. The purpose of the check here is to do the same
> for the first nexthop. That is, only choose a nexthop when calculated
> hash is smaller than the nexthop's region boundary and the nexthop has a
> non negative score.
> 
> This was not done before for 'match' because the caller already chose
> 'match' based on its score.
> 
> > The behavior on negative score for the first_sibling appears
> > different from that on subsequent siblings in the for_each below:
> > in that case the loop breaks, while for the first it skips?
> > 
> >                 if (fl6->mp_hash > nh_upper_bound)
> >                         continue;
> >                 if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
> >                         break;
> >                 match = sibling;
> >                 break;
> > 
> > Am I reading that correct and is that intentional?
> 
> Hmm, I see. I think it makes sense to have the same behavior for all
> nexthops. That is, if nexthop fits in terms of hash but has a negative
> score, then fallback to 'match'. How about the following diff?

That unifies the behavior.

Is match guaranteed to be an acceptable path, i.e., having a positive
score?

Else just the first valid sibling after the matching, but invalid,
sibling, may be the most robust solution.

> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index ab12b816ab94..210b84cecc24 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -470,10 +470,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>                 goto out;
>  
>         hash = fl6->mp_hash;
> -       if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> -           rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> -                           strict) >= 0) {
> -               match = first;
> +       if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound)) {
> +               if (rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> +                                   strict) >= 0)
> +                       match = first;
>                 goto out;
>         }



