Return-Path: <netdev+bounces-179304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93037A7BE9E
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EF916C2C5
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A219DF49;
	Fri,  4 Apr 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePjJFisn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21F1DF98F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775401; cv=none; b=iV2cThp5lxT+0cKGa1A+dweO+X3CMkwqMlW5h2tMk1eIScB3J3QTczwSZIxA3VA5r3joxdhT5+5ckbBoMFgTiGYz4gtaDjiOhyJhWf91CXjSqOa3Bxs+ri61Cqp1d+cbnXJEM9PDUSChSoSopu6Gh5I2sloAaJqiJV1WFJsC7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775401; c=relaxed/simple;
	bh=4Zn9FUufbHgt9NkwQTg0tcSqbYXVPq64oE+nb0WQmBw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LJUuR7GE4qinyoE3SQIIa/O+nfgLHdAxSPNnSDiwhZVZSQ5XTEoUDpbW8d2QtAN5khsPOhFni1pLOyQySgBXstM141gtVTFZMI0wTvLe2DQ83bDTr1Lq4PrK5QZVYzCB7F2VeUsSycUSsjLr9LI6GVdLv1lp3Mtu7uRCygSuHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePjJFisn; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6eb16dfa988so20698936d6.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743775398; x=1744380198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=286fISrkykvUqZAHvfvdZQmP4F5lDUV35rwGVEP2NjE=;
        b=ePjJFisn7TMRzcuHoYoEmnAxTKv1XYgVzp9OYfjt35hopIBWpYcJia9Df2vfPkmh52
         vNgHory8XWIinb1WDAm9kThZadTAB1mKw0HSW4Vl7vRqBP7Dwzgq6aDLnpXn6ewbwX9T
         6k59+wm9nHnGk9Lal4e5ascdpU18h7uecit9IkOnJ2ni9eCiJ+xwZL1r61yoQ5XQU4aa
         zdg0Eh7roEMDh4xgkGTxwNvVo3uoisE+yhKT+vMQjqLqXhL8ajWnPzpEKZBn549uAXZr
         xa2sSltALmQaTjLA4y+HfHerDHx6lDn/z6xbZ1M+oS0brqI0i5OtdMx9qj3n2Bt8c8c9
         z+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775398; x=1744380198;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=286fISrkykvUqZAHvfvdZQmP4F5lDUV35rwGVEP2NjE=;
        b=XMLTK+7kfRpoWzQmvcL1lVVUxVdLOXpncZoJo1U3Rr2U9KUgcDD7qKotTdHxYJWrdR
         SjN5U7dTXgMHTuYCuSG5Rj0Y2wnDRvqIfkVfc3+iBuzFYXodidwlHww457NSEo5lnGgR
         iK1VXyzJsMkE/2Ti2RP1qObu1X8wtevpfk/5a0sn+FeZ9gRJ2BELnDmX/MmC3BnObMQ1
         Vi+Iakdbj4j5fZjBePhBOGoMLxp/NlHhS+VFFaQugVC8ThLTVvjnrHRuzN8w7mv6a1bK
         6ruN5TDtffwEIkpU3VSnOCkvwhl23OBu6AzYVKI9ZTKdNf04w3kTc7rnprfWw9tcmn9M
         PCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXolvP3vcY5aEI7l2ccUK+bFUDhWvuaXLCwLz5x77m/MmM5zNxUkp59g5eT5GywY5MiKVASSNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAdn4eiwsfqdoszNZfoEBB6Qmheus6D6MnvFw5FIG2ve9wp2s
	sKOnE85f8uW8hQHptjo/DsQsEgg1tKA5kUnD5BiyD2PMUuZVIdTg
X-Gm-Gg: ASbGncsezpd1oGnl5H1vYrDh5sOvu1It2tccwEnIcofS1f8OkmS1/VFYfRtPIptCEDY
	/FhwJNvKkOWBkK6cAjEajVTTmNND/8S2YQmK3q9YllKpkk1LgRJcooFav0fpqgNd+TvXwmqHKW2
	N8qFaO42yqjHoYfwdr8JyiaUb7mTFvELuDhNi0sCIiQvOuY1cVaKqFmhOtOfxplY9J0709rQPWr
	lq1YN8kkpInqKiwRxyqm38Xr8RewaKu3WjonZ18djDfVDKGjCWX1ExuIrw/6zSWiyaxNKvLUCZp
	GzRY1gfvJStqDSrSYgIwYPUxvU2Z6jnYtIrbjV4jiRjKCj17kdtNW7oOpRVoPgQW/AjZxLdhVE4
	dKs7SzDvXDLKd2sPgvZxnaQ==
X-Google-Smtp-Source: AGHT+IGYmE8d/1f1kaF9QZI3rrATPyzNbihewBUqvtXCYw4hyU/KppOCmd7qruXsQjuZPMK8lpgJcg==
X-Received: by 2002:a05:6214:1c89:b0:6e6:683c:1e32 with SMTP id 6a1803df08f44-6f05830485dmr42183016d6.8.1743775397567;
        Fri, 04 Apr 2025 07:03:17 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc0a6csm21802096d6.14.2025.04.04.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 07:03:16 -0700 (PDT)
Date: Fri, 04 Apr 2025 10:03:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 gnault@redhat.com, 
 stfomichev@gmail.com, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <67efe6a48e8d0_1d96d729444@willemb.c.googlers.com.notmuch>
In-Reply-To: <67efdd2596e33_1d5ffb294b9@willemb.c.googlers.com.notmuch>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-3-idosch@nvidia.com>
 <67efdd2596e33_1d5ffb294b9@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net 2/2] ipv6: Do not consider link down nexthops in path
 selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > Nexthops whose link is down are not supposed to be considered during
> > path selection when the "ignore_routes_with_linkdown" sysctl is set.
> > This is done by assigning them a negative region boundary.
> > 
> > However, when comparing the computed hash (unsigned) with the region
> > boundary (signed), the negative region boundary is treated as unsigned,
> > resulting in incorrect nexthop selection.
> > 
> > Fix by treating the computed hash as signed. Note that the computed hash
> > is always in range of [0, 2^31 - 1].
> > 
> > Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  net/ipv6/route.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 864f0002034b..ab12b816ab94 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -442,6 +442,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> >  {
> >  	struct fib6_info *first, *match = res->f6i;
> >  	struct fib6_info *sibling;
> > +	int hash;
> >  
> >  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> >  		goto out;
> > @@ -468,7 +469,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> >  	if (!first)
> >  		goto out;
> >  
> > -	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > +	hash = fl6->mp_hash;
> > +	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> 
> The combined upper bounds add up to the total weights of the paths.
> 
> Should hash be scaled (using reciprocal_scale) to that bound to have
> a uniform random distribution across all weights?
> 
> Else a hash in the range [0, 2^31 - 1] is unlikely to fall within the
> total weights range.

Never mind, the scaling is handled in rt6_upper_bound_set. Where
weights are scaled to cover the [0, INT_MAX - 1] range.

I confused fib_nh_weight with fib_nh_upper_bound.

But should U32 hash then be truncated to the lower 31 bits, to
drop the sign and negative half of the space when used as int?

> >  	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> >  			    strict) >= 0) {
> >  		match = first;
> > @@ -481,7 +483,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> >  		int nh_upper_bound;
> >  
> >  		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
> > -		if (fl6->mp_hash > nh_upper_bound)
> > +		if (hash > nh_upper_bound)
> >  			continue;
> >  		if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
> >  			break;
> > -- 
> > 2.49.0
> > 
> 
> 



