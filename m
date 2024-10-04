Return-Path: <netdev+bounces-132172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15655990A3F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16E9281AA0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8581D9A5E;
	Fri,  4 Oct 2024 17:38:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8050A63;
	Fri,  4 Oct 2024 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063481; cv=none; b=L5LZHOYs4lDHu16xpy/ooDuV4M15g4s00qfww7X+IQz5B2HZuGnwkbWQnJv+haHT0LPLvfgMgJXlYklT4Uw4omfPFth0xHKqAvKmEVgVobu9PRX8A4GwWdQz1bMtox+vXKUYbhm21CxpINSc7jXXUH0RupQowWlZt+yQ29hrry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063481; c=relaxed/simple;
	bh=r6h6ivAteGGBHkj5NscHtHXFd57HJ1AIrm66cRntSVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma9LFmaKDm9hAWcjJIf8BwGJWlfz+0e7Re81bkrGlzb6cmDBHpNxknnoXw7eoL2PYksFGrD4kWIjwEXYEYGqFU4uHszroX575OfzF7H17jeLj4t2JKl6UPi5Dbfq3wvjzWy5BcRj5f12ISTIwKOR/9AnaQ9qyYH4EdIVfFhtZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93b2070e0cso267946866b.3;
        Fri, 04 Oct 2024 10:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063478; x=1728668278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhtiUJLGqKylZjIhkXCBoyOQK1CEukwM7WvnraRscHc=;
        b=E/phjZqdTpcBvq0tmY+bOXaYaI6TCn0E/v4mH1KFfT+3HR6fs8ifqbB7LDxGAjK2g6
         4UOFwV9JKcQEWiVHhighgSMLT7u/0+2LBF7KHNub7zizsdN3cceGSPpGRtO7FIERwTT0
         fXn87PfCqok48YrDvFhQioSJZzUeoMcJI7yUFTyMel+YoWRzGOFIEgqdcxk8KaCM4fUi
         YPOSJXsE+40uyNFYhH+F4xiDLXqe9bIK1N6iCrgPsRiBaztkHioA7hreAHgVrDbbafbw
         Mc+8KjiVp6gDIvP9V+ydVoRzxwrfdDnqGHqhxf6vaGUxJejagU0oGK5V+nHbKKiDqEEo
         YReQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9BY+n4ursCIr957ijtU+81RkQJjD5fPf66ExzBpmhu4tcGeFA7rbu/BTuOU0prVMrAGiWof4fLaFRlFs=@vger.kernel.org, AJvYcCWPfYMdEroKrsi3EfPplzYUH6h9Sv9tiPpDA3rveUSy+saOV4PzLqVljDewm2wy+sHrK/771KQV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50WBFlYK08xuiCLbhTI+/LfMcTvkMdkHgf9k+didUSQlgyL5s
	v9lA/BGPdYNAoA42gPJN2wzAzIeQnzNsjE5lqDqW/5EF1zJRgr9t
X-Google-Smtp-Source: AGHT+IGM43/t6Op9V+aFOXXOJkw2sD8OmTLFOZsdFt6lqMnE9b04AjNAFM955nCwxHjG8NNKw1ttfw==
X-Received: by 2002:a17:907:9304:b0:a8d:7b7d:8c39 with SMTP id a640c23a62f3a-a991c03145bmr375006066b.43.1728063478123;
        Fri, 04 Oct 2024 10:37:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7c46e3sm20031066b.180.2024.10.04.10.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:37:57 -0700 (PDT)
Date: Fri, 4 Oct 2024 10:37:52 -0700
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rmikey@meta.com, kernel-team@meta.com, horms@kernel.org,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
Message-ID: <20241004-straight-prompt-auk-ada09a@leitao>
References: <20241004162720.66649-1-leitao@debian.org>
 <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>

Hello David,

On Fri, Oct 04, 2024 at 11:01:29AM -0600, David Ahern wrote:
> On 10/4/24 10:27 AM, Breno Leitao wrote:
> > Branch annotation traces from approximately 200 IPv6-enabled hosts
> > revealed that the 'likely' branch in ip_neigh_for_gw() was consistently
> > mispredicted. Given the increasing prevalence of IPv6 in modern networks,
> > this commit adjusts the function to favor the IPv6 path.
> > 
> > Swap the order of the conditional statements and move the 'likely'
> > annotation to the IPv6 case. This change aims to improve performance in
> > IPv6-dominant environments by reducing branch mispredictions.
> > 
> > This optimization aligns with the trend of IPv6 becoming the default IP
> > version in many deployments, and should benefit modern network
> > configurations.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  include/net/route.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/net/route.h b/include/net/route.h
> > index 1789f1e6640b..b90b7b1effb8 100644
> > --- a/include/net/route.h
> > +++ b/include/net/route.h
> > @@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_for_gw(struct rtable *rt,
> >  	struct net_device *dev = rt->dst.dev;
> >  	struct neighbour *neigh;
> >  
> > -	if (likely(rt->rt_gw_family == AF_INET)) {
> > -		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> > -	} else if (rt->rt_gw_family == AF_INET6) {
> > +	if (likely(rt->rt_gw_family == AF_INET6)) {
> >  		neigh = ip_neigh_gw6(dev, &rt->rt_gw6);
> >  		*is_v6gw = true;
> > +	} else if (rt->rt_gw_family == AF_INET) {
> > +		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> >  	} else {
> >  		neigh = ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
> >  	}
> 
> This is an IPv4 function allowing support for IPv6 addresses as a
> nexthop. It is appropriate for IPv4 family checks to be first.

Right. In which case is this called on IPv6 only systems?

On my IPv6-only 200 systems, the annotated branch predictor is showing
it is mispredicted 100% of the time.

Thanks for the review
--breno


