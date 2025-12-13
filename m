Return-Path: <netdev+bounces-244600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03944CBB3E8
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 21:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96702300983E
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893862356D9;
	Sat, 13 Dec 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO7TfeI4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA69200113
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765659262; cv=none; b=B7Bk8lKUAoHfTVl40tP7zTiHSDaJyQF3lyDPsttgHVShDtMWTPtvFs4IcMFfTLMCDY3/NUe26PJmFjrPodV5BcJ3ww/alEHXMLLt0L+Vmaa6k+iM0IJ4SQClfdO+sSXCVx4cQt3DdRiOAdUhQJ/kVjO3d3Nat/bATWEoyOZXn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765659262; c=relaxed/simple;
	bh=SfQ8LesA73Tx1I4xsHm8ZQr67RyBp0R8mjYFZImh47k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wo+R9S+JlTMu2q9wA9/L7SiCtbqPXgT1/VjngR3uF0Si99fVkVbL+9vw2cJkKeof/nPPw5kVipMfmZlEOeJjqe8SgYdRE+68vPO+2UcxBJzK2foxBkXN4/sou3aiQFt1k6D0nnsl2LM6mrfKYRJNclMb8gtmGqGu1gfDxFQLIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO7TfeI4; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64475c16a11so2647979d50.1
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765659260; x=1766264060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3GFqAXYKafeeWFNsOzHOcmOjExidcF9fiOodCSId3Q=;
        b=fO7TfeI4OWS+DUJtVfXfwYrFMqtx2sykvNgga9dkiD0VmazXj0dSAb9tUwkVq9MBL/
         vN0d82l47/5slBNNJNsBBP4NSPAIRobtgB4BRg3rMQmS+rqCCKDP28EUJDUwyWILEXcJ
         3NINflpd+h4gHdmJi7nsJ2qP2hTqVXybqWgKdRvHUgRwz+HVPHkaYIyL2hCZUzLWTd/k
         h+JO4lsmsMoCGVdeatKEsJ1C6TiEn/0575aa60D1q3waOuKXC91zDwhx5UdV4ybEKSap
         sU0wr8bgq74sYeWpVyYRAbkjDjZ+eV9tN1dYg/Nmv6hwZ674BDLJ7q+O4Qp4RB9hp0hG
         SVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765659260; x=1766264060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3GFqAXYKafeeWFNsOzHOcmOjExidcF9fiOodCSId3Q=;
        b=ATAGCJO1RMO4XPSePhrykqqPoaR2h9ExgRmBifI8Le7jzaOc5t9u6y33DWRE7kMyij
         Dirw5Qx23At4h+dwIXk4UkYlXdHzJGXfsT2h0j9YTtnd1C1+cCdo885m0KWMV5KdntjI
         z4jkiVnT3cnM7/OllxAcLui+TfaB+5+wt5wkpMVIYlr7/iO1kdIa+RrCIwnXiKJTDf1d
         /FyDb5bgefsypvGoToihXuK+S1n5HbE7vp4xAsKT0CZqR4UAlRaaQfWpriCpDG74NngS
         FllXhU0a9jEu6L9hsGjvmp2AkaUChmGOx3FDl3N7NwR9exOqXbxu+rcsyNAHnEtNzX8w
         c2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZXg1hgp6lQJqkwsGNyYPzXqOvMXsqQLxrNkh+SJbS6EcretGG+Mj5vQYCpVlqYU8WkzbKKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KzpDa++LX9Z/0QECMlDE2oA7gln/7F+j6xyNsJs33EF8z3lR
	/9m3m3TvkAoMveOjd4cPIZ3iCJqqk7eYeLHXGRRkPFIa7uyyvpgAXBM6
X-Gm-Gg: AY/fxX5TGSVkUyNagTFBgO23aEF6rM0ZzlVcHffW9cX+7Qvxy9qtBll/EpdhGx0I3ZE
	QMhGXhyvOZoopuyb3u4oHcTj9m+zuxxU6sOmq23EZXlpoiPFtXhODoj+Cxvch89A0Q3zhQwRtg1
	h5Os3z+KpIikdshuVI7Ou2aDxSDH92aVORmWDrh/TTwPV7VBy3Ny+tGhf22AGeFtnx1HV96hSlS
	7qjhV3UhvDodtLkKYgJWUKw46M8SQErOYrjFHShD0dH9ayE069SDRar9o+8tD3ZAJVMUym3m5J6
	yasIH72va6F3Sjbz9hqsfFnCxTlnyfuaBZvUDuaKRHD+4ZQ2MkDoDIiDP5Knuqt7GSuP93qIalK
	4+te3jBa+BpD3HM26DP9JkW8cgUHTwmFGUqIGxul8IXFPNZHTbswWoLCcRb1viebVPOs2Tgx0qc
	72/ooWDITg6WPtfJL9gi9mpInrvpd4F+EIYyaLrPdLR6xN21NRR6StSs2kjKdP2A8BwSc=
X-Google-Smtp-Source: AGHT+IG/LPxtVij+gctWsz0wmoX8u3NB6LBLTbBqpg5JpniOu5xI57rn11FRDlWxSrgA9HhiI9cRiA==
X-Received: by 2002:a05:690e:bc6:b0:63e:b62:5826 with SMTP id 956f58d0204a3-64555667855mr4192120d50.67.1765659259751;
        Sat, 13 Dec 2025 12:54:19 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64477d39b01sm4259890d50.1.2025.12.13.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 12:54:18 -0800 (PST)
Date: Sat, 13 Dec 2025 15:54:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.ord>
Cc: Shuah Khan <shuah@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <willemdebruijn.kernel.5c4c191262c5@gmail.com>
In-Reply-To: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net 1/2] net: fib: restore ECMP balance from loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> Preference of nexthop with source address broke ECMP for packets with
> source address from loopback interface. Original behaviour was to
> balance over nexthops while now it uses the latest nexthop from the
> group.

How does the loopback device specifically come into this?

> 
> For the case with 198.51.100.1/32 assigned to lo:
> 
> before:
>    done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>     255 veth3
> 
> after:
>    done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>     122 veth1
>     133 veth3
> 
> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  net/ipv4/fib_semantics.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index a5f3c8459758..c54b4ad9c280 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2165,9 +2165,9 @@ static bool fib_good_nh(const struct fib_nh *nh)
>  void fib_select_multipath(struct fib_result *res, int hash,
>  			  const struct flowi4 *fl4)
>  {
> +	bool first = false, found = false;
>  	struct fib_info *fi = res->fi;
>  	struct net *net = fi->fib_net;
> -	bool found = false;
>  	bool use_neigh;
>  	__be32 saddr;
>  
> @@ -2190,23 +2190,24 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  		    (use_neigh && !fib_good_nh(nexthop_nh)))
>  			continue;
>  
> -		if (!found) {
> +		if (saddr && nexthop_nh->nh_saddr == saddr) {
>  			res->nh_sel = nhsel;
>  			res->nhc = &nexthop_nh->nh_common;
> -			found = !saddr || nexthop_nh->nh_saddr == saddr;
> +			return;

This can return a match that exceeds the upper bound, while better
matches may exist.

Perhaps what we want is the following:

1. if there are matches that match saddr, prefer those above others
   - take the first match, as with hash input that results in load
     balancing across flows
      
2. else, take any match
   - again, first fit

If no match below fib_nh_upper_bound is found, fall back to the first
fit above that exceeds nh_upper_bound. Again, prefer first fit of 1 if
it exists, else first fit of 2.

If so then we need up to two concurrent stored options,
first_match_saddr and first.

Or alternatively use a score similar to inet listener lookup.

Since a new variable is added, I would rename found with
first_match_saddr or similar to document the intent.

>  		}
>  
> -		if (hash > nh_upper_bound)
> -			continue;
> -
> -		if (!saddr || nexthop_nh->nh_saddr == saddr) {
> +		if (!first) {
>  			res->nh_sel = nhsel;
>  			res->nhc = &nexthop_nh->nh_common;
> -			return;
> +			first = true;
>  		}
>  
> -		if (found)
> -			return;
> +		if (found || hash > nh_upper_bound)
> +			continue;
> +
> +		res->nh_sel = nhsel;
> +		res->nhc = &nexthop_nh->nh_common;
> +		found = true;
>  
>  	} endfor_nexthops(fi);
>  }
> -- 
> 2.47.3
> 



