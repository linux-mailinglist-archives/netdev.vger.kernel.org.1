Return-Path: <netdev+bounces-179306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A392A7BEB7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4557D3AE745
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531801EDA26;
	Fri,  4 Apr 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0TySnaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7728E8
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775678; cv=none; b=RW5vYIWsMVwm6lKMQY5ystXEShxRxMbmsEL0ptlVQg/68M18oS1+mkOoO8tfkrLBwlPeFEtEAEDBMje2WIly00NJ7W6wkdMD6o5bVXPptO8E0tjWdo8Xxz2pJlwplHVkw+OH5MpO9kG2ffJ3f7p4yMmIXfEbbTE7PBc+Qafulk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775678; c=relaxed/simple;
	bh=qu1KXBG9pjnCDug1MY4RC8IpB5wOc65jJ3/9oAz6a7g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pPa0cGpLSPvVj6yAi/GJiuYAfCA0a3x3ardwY7nSLEUlIRXf7Gsctxc8uO4tkXOFvWTK+ktVF7TybVK2AqiZDmvKouc+B7Rx0e5HkOiVYFRa5iJ6T85XsyaC7l1ZsqdwKcrbfxCydUUm9K7FY7D4Ehml9qawg7mDR2+s10jgZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0TySnaW; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-477296dce8dso20805851cf.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743775675; x=1744380475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jds2BKgqYuMwFgnFfs0zjVmEc7MZJMNO6iuyv0+iXes=;
        b=S0TySnaWh9q13LxqHJh9pHvLGvIOyOdElsj12bAia5ZBXm/+tuz9RTn3ppmzDAHBar
         XYiEDKgorGH692XQEkNUH4POidzFemQh+p5Rt+CJt52qY7/vROu1+0mWd5C2EI0dWnPL
         wwXWL6aAz29r5kVrp5A79Sym6P1n7SY9694UNS6npsqfQdEL1bOdhAsbt/JSH10eIJgc
         EKejLjQkc/3chXbJctt7QsotyNlXhOCZLL49ogda3ZQHLWRB6VFn/+HFVhJx41Gds0ct
         GUr+4b/qjuvzugTIfWfI2/ivtHAFtjl5HbyWiXrJrzdApefOYD63k8eU33KM7FzwmsNK
         c6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775675; x=1744380475;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jds2BKgqYuMwFgnFfs0zjVmEc7MZJMNO6iuyv0+iXes=;
        b=taG2++ZRXY7fA04OgJw6XddEpDgNm3rlQcZXJeQ+ZH57aG6lyow9q1SYNPhkQUkeZk
         cGRjJBD1pFwOgz3+QLZFQ8/B88pm4cN6cJpmCDPAT0L/TRCn0vXsSExgTmqxjIZq9Cga
         vlSo3P625NZ293uTvZCMlmlX8nZS6zZz11y3XeWNuYaA6TVj33NoxkPVcvWCw6SprwvH
         /Vot10f+BxtFTZfgfNmgVGQur/uBWk5Ithb3iR7JitSUflQlU+OuOMeK1knAXlRxDum9
         5BzWLuHRLIle1MoXVnVM2l5nIUo7PU1opzeydhKWyrDBdxzWgWL0n6o8KTIb0fcbzQI9
         ysJg==
X-Forwarded-Encrypted: i=1; AJvYcCVEDvN6zbeMel8+tZ+WjlZJvdtUVPbgJb/6pGGCtGIQIlxWScdVS4KdfqITUA+J/vLFdryBcFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lWmIjYPved1XajgLtoLIaaGl5JxgH4tAgcpdt/a2iMo0pfDh
	O+k102SnOCqRnoKtX0QbsN9djQ0xH/TM0GOKuaRHJ9denleNYiuy
X-Gm-Gg: ASbGncsgoai+AtjMsBEul3UGv1VrpecEezGnKPKbRmp1Q4sHc7jWaR+0/41Y+W8pcVR
	uUvzwByYak3Zsw7QpHGjaeZ8bxeUA0KPDGSt1MBbBmTls+CPnlO9Qirb+hSn1+5jhdwAg9ddYn8
	5stH7V5tE9wBp6KwbIZdsNuBdBLwoke6vwapsLYqsUodMOgSY2z0q0ehTITRLABs9cA3/pD6fpz
	jc8MQP0NetOCP2yi/j1iKLryz0FAJmP78oAh0ypuOKTVwIq/5fjI2tmBDkMzSanqEGS3dioMiOY
	eEwIX9mOhABZPla906Mq/S3rr1+MS3525wT8rZCp8o3fPTM32jafHCSCeOFSH8WyFXAd0M2cC5a
	gckona2wE9XuqTeFHuS1QUw==
X-Google-Smtp-Source: AGHT+IEi3XpaN7TFpIiw5W7IYd1fAohZeT8W64o3W/iBERDHYmgp7sJCgPnLaLgvEq5N/uX0vTsnMA==
X-Received: by 2002:ac8:7d11:0:b0:476:8ee8:d8a1 with SMTP id d75a77b69052e-479249d584fmr46672251cf.45.1743775675536;
        Fri, 04 Apr 2025 07:07:55 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b1446ecsm22008731cf.77.2025.04.04.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 07:07:55 -0700 (PDT)
Date: Fri, 04 Apr 2025 10:07:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <67efe7bab0b19_1dbb5d2944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <67efe6a48e8d0_1d96d729444@willemb.c.googlers.com.notmuch>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-3-idosch@nvidia.com>
 <67efdd2596e33_1d5ffb294b9@willemb.c.googlers.com.notmuch>
 <67efe6a48e8d0_1d96d729444@willemb.c.googlers.com.notmuch>
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
> Willem de Bruijn wrote:
> > Ido Schimmel wrote:
> > > Nexthops whose link is down are not supposed to be considered during
> > > path selection when the "ignore_routes_with_linkdown" sysctl is set.
> > > This is done by assigning them a negative region boundary.
> > > 
> > > However, when comparing the computed hash (unsigned) with the region
> > > boundary (signed), the negative region boundary is treated as unsigned,
> > > resulting in incorrect nexthop selection.
> > > 
> > > Fix by treating the computed hash as signed. Note that the computed hash
> > > is always in range of [0, 2^31 - 1].
> > > 
> > > Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> > > ---
> > >  net/ipv6/route.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index 864f0002034b..ab12b816ab94 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -442,6 +442,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> > >  {
> > >  	struct fib6_info *first, *match = res->f6i;
> > >  	struct fib6_info *sibling;
> > > +	int hash;
> > >  
> > >  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> > >  		goto out;
> > > @@ -468,7 +469,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> > >  	if (!first)
> > >  		goto out;
> > >  
> > > -	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > > +	hash = fl6->mp_hash;
> > > +	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > 
> > The combined upper bounds add up to the total weights of the paths.
> > 
> > Should hash be scaled (using reciprocal_scale) to that bound to have
> > a uniform random distribution across all weights?
> > 
> > Else a hash in the range [0, 2^31 - 1] is unlikely to fall within the
> > total weights range.
> 
> Never mind, the scaling is handled in rt6_upper_bound_set. Where
> weights are scaled to cover the [0, INT_MAX - 1] range.
> 
> I confused fib_nh_weight with fib_nh_upper_bound.
> 
> But should U32 hash then be truncated to the lower 31 bits, to
> drop the sign and negative half of the space when used as int?

And you document this in the commit message: "Note that the computed
hash is always in range of [0, 2^31 - 1]".

That is the `mhash >> 1` at the bottom of rt6_multipath_hash.

Sorry, I'm a bit slow in internalizing this code. And perhaps a bit
too fast at responding ;) But got it now!

 
> > >  	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> > >  			    strict) >= 0) {
> > >  		match = first;
> > > @@ -481,7 +483,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> > >  		int nh_upper_bound;
> > >  
> > >  		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
> > > -		if (fl6->mp_hash > nh_upper_bound)
> > > +		if (hash > nh_upper_bound)
> > >  			continue;
> > >  		if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
> > >  			break;
> > > -- 
> > > 2.49.0
> > > 
> > 
> > 
> 
> 



