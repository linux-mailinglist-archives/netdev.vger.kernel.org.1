Return-Path: <netdev+bounces-179319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E43A7BFC0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465D33B00A0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A41F30DE;
	Fri,  4 Apr 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu2VHb1R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48628E3F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777636; cv=none; b=e1779eHe129VET0X3Sn08X0hzuDakyVQarawN5PzDX6lwC490FXtCL/89jaxf+1MB4od5wPxwNn3MzfCWrgWGczHpPc7NCbV1QQwVMz5XmnLs0mpOq/VbGcXr3uSkR1VZcPa6NFPV/wSCfFfh3zcm7Wo+GGTNcs1nmU8SeGFwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777636; c=relaxed/simple;
	bh=stnd6o+2AvOBAu7HQXgEMBXtbfZ6rBxBc8cLkK/oApc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ms2VKYS+DsRpyliPczwy+MpIfIukT94v5kr7fME18HhsfC0p3AhrO27dGsv7zpW5WCUtb8bq+sXZR2N4qG+UUJr8Ok2L692X21NVEONKrFjJM5x4RSj/Vl158D4CTdmtvghGvn5dDIbkDxDnclVQPeaUFLNwD5aACbabV/AClzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu2VHb1R; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476805acddaso23468101cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743777633; x=1744382433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTwv+NvIv12iz2xRTuUQl78g8x0HeiF4zDUv6VqO33w=;
        b=Lu2VHb1Rkz4SMPmBTyzJbf1URTDFcOeSmYX2Js56l4kD1tr3zKFBRxdSXEb0HPEyYo
         74G81cvd6hug2MR7ht0c5/fQ0RXLEPmneVBSKXMdNBPL2JjpExsYqz6yUkWOUmJ9AYSl
         rUce4JYdZ6hrGKamgc+PYaU1NPL9FJIp54OplRPT3HALKL1G+Rv3G5ZgKWUtFj1siwH/
         bWtuuzcmrT/E/8an0315RLJByxIjY5z6GiKZqudu2jzzJuJU1mw31K6fJTZJJR58T3fL
         hyreLpOgHFj239p86a/DSBKZfstHXNMB6cfY0WyYiyXzUt95sAkkllkSXkJb1sQ4eB0C
         MrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777633; x=1744382433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTwv+NvIv12iz2xRTuUQl78g8x0HeiF4zDUv6VqO33w=;
        b=Q+0BNuZjETyOVFw6uW/kvJvTCuMCkDAKrLajFkYJLDTvD7Tj8vKnHCJqzn5DMGhLWI
         wy1ItHQykXFXaVIVnM3cbKHdtxju6FtyraEVy18DfONMpbh3oGYE3KhDhIvfNRfv9RUR
         2Ol7i8hD8H/Zyx5y7GmVXveo1u/dcZu5syHt+d6VL68F+FF04vjXhbNuBN9BM3WhBOHr
         HPBs0bEFaA9jDiUzTjqdwUTj2hrMl6Dp9k6m3BMIEF/MsZdMC2tQZZkNX02fNst29tfP
         c+hisrUJ/egqqFY1Qi+s5y3iP51NXWO2wpyND8WZr0iw4dtoo1OQIo+S7cwhBMWUZNwn
         hWag==
X-Forwarded-Encrypted: i=1; AJvYcCXuCjMHoi10btTN1pSU/+/zx8sI8ibcB1oPDvR4LadRoyV0DH++d33NCV4iDbqIro8hHcrK2hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8xLbI1UR0/B4A3dgtLo+qMPPOH80c8hfU7NldmRIS9AMFlm+
	5yGlCS2NjCasY34sNlgY6KBRvssF4Vdqo4zRxzddy/6u/8BqBLXx
X-Gm-Gg: ASbGncuyCJM5miZePkjuYTJOhmNEAjZZy0fP3zH13EPtYHICC68I4fEYBrFFq32t5pC
	jMjy1D0Jwb6/JT8zgfnx89cwJnjPD5O7FTyNA3VpILb4jHXHHm9zy4l3ZBWWdVA+2Q3k4VUzrrL
	wZDzunAILfsV/EabT9yb5nIVFy7XP+cUkQ7eRHwwdzQ9JsGZYVHS7Mie8BCTaLjA8m6McMXyAnp
	TvBS0tk/gpecfigU4XOy+nz50fj4KB2lX4tF0mRE0lLdTDmnd8EsGHMo5vq4w4Er5Kj29C1U1dF
	d17/r0t1JctB+SWBXZIiu2kLoBrbkEx73THIzMg1Gf8JqXrDa8Rc5KDAR2k5Pye3emHoQZ2dN/Y
	kq5KNVwJEVYFOSP49P8FlfQ==
X-Google-Smtp-Source: AGHT+IFA23JVEvYRuXkWQQwUHiJkRu5z3zSXhg8k4En0oFmi6bPIo4/H5D4B/XuEK+PQCoMsbSAaEg==
X-Received: by 2002:ac8:7f84:0:b0:476:8f75:b885 with SMTP id d75a77b69052e-47925a791c6mr47916791cf.44.1743777633497;
        Fri, 04 Apr 2025 07:40:33 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b088544sm23340891cf.45.2025.04.04.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 07:40:33 -0700 (PDT)
Date: Fri, 04 Apr 2025 10:40:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 gnault@redhat.com, 
 stfomichev@gmail.com, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250402114224.293392-2-idosch@nvidia.com>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-2-idosch@nvidia.com>
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
> Cited commit transitioned IPv6 path selection to use hash-threshold
> instead of modulo-N. With hash-threshold, each nexthop is assigned a
> region boundary in the multipath hash function's output space and a
> nexthop is chosen if the calculated hash is smaller than the nexthop's
> region boundary.
> 
> Hash-threshold does not work correctly if path selection does not start
> with the first nexthop. For example, if fib6_select_path() is always
> passed the last nexthop in the group, then it will always be chosen
> because its region boundary covers the entire hash function's output
> space.
> 
> Fix this by starting the selection process from the first nexthop and do
> not consider nexthops for which rt6_score_route() provided a negative
> score.
> 
> Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> Closes: https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index c3406a0d45bd..864f0002034b 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
>  	return false;
>  }
>  
> +static struct fib6_info *
> +rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
> +{
> +	struct fib6_info *iter;
> +	struct fib6_node *fn;
> +
> +	fn = rcu_dereference(rt->fib6_node);
> +	if (!fn)
> +		goto out;
> +	iter = rcu_dereference(fn->leaf);
> +	if (!iter)
> +		goto out;
> +
> +	while (iter) {
> +		if (iter->fib6_metric == rt->fib6_metric &&
> +		    rt6_qualify_for_ecmp(iter))
> +			return iter;
> +		iter = rcu_dereference(iter->fib6_next);
> +	}
> +
> +out:
> +	return NULL;
> +}

The rcu counterpart to rt6_multipath_first_sibling, which is used when
computing the ranges in rt6_multipath_rebalance.

> +
>  void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		      struct flowi6 *fl6, int oif, bool have_oif_match,
>  		      const struct sk_buff *skb, int strict)
>  {
> -	struct fib6_info *match = res->f6i;
> +	struct fib6_info *first, *match = res->f6i;
>  	struct fib6_info *sibling;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> @@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		return;
>  	}
>  
> -	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
> +	first = rt6_multipath_first_sibling_rcu(match);
> +	if (!first)
>  		goto out;
>  
> -	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> +	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> +	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> +			    strict) >= 0) {

Does this fix address two issues in one patch: start from the first
sibling, and check validity of the sibling?

The behavior on negative score for the first_sibling appears
different from that on subsequent siblings in the for_each below:
in that case the loop breaks, while for the first it skips?

                if (fl6->mp_hash > nh_upper_bound)
                        continue;
                if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
                        break;
                match = sibling;
                break;

Am I reading that correct and is that intentional?

> +		match = first;
> +		goto out;
> +	}
> +
> +	list_for_each_entry_rcu(sibling, &first->fib6_siblings,
>  				fib6_siblings) {
>  		const struct fib6_nh *nh = sibling->fib6_nh;
>  		int nh_upper_bound;
> -- 
> 2.49.0
> 



