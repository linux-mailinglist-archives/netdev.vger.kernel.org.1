Return-Path: <netdev+bounces-187050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4372AA4B2D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E4189F5A7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E61DE881;
	Wed, 30 Apr 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgMELxDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4E33086
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016294; cv=none; b=Uh2EXobdc88o7zT8Cffc0sh8J80P9KkqrQEZEXB/eUsPPBcx/udNanj3hi4ionBTlmxxP4QlI7VUJd0I1D9OkEIVgVqZxHrMmrYec/P1d+OsP8Isif7z/krRe/LoNyL/9yrqNA9IFOXpzl27kc2GOvQL/Q30YiT+C+y4Ic9GxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016294; c=relaxed/simple;
	bh=8EvBB2O0mP95XbcL0HUQFV2BmHuQCSw4Nzv0VX+4r58=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VjR3kcwtN281/z/nYvdlPNti4diy7tUxD6CGVD5R7l78R2tcZ+2dMP9zuTuPwWQTFZAC81sVIDRGW6qKpZnFL5WoSu777Sf6tn7EaSQ8djeXb1Lg+8xeCXDEwxIJrhw+d/+EoCWoNrzH0s82Gd+YHEoyrU09BD9UH003M4PcZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgMELxDO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c560c55bc1so862480185a.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016291; x=1746621091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En0WM2Ei4FU3YU+QD2Q6x49MBG0M2eFBylvcvM2zlvc=;
        b=cgMELxDOjnKRbuNWIFQQngoH5HSTrFZ1olu/a3UIHMXa7Qwh0gC/8uXxy1pmNlRh1j
         UmgK5KQ7Ni0409470WOUzP8fSbXZ52NdOeC4eG9RRk/dRIhCLnZfHBtowOJyeJkKQ7VY
         YqnM/J6CmjhuOFLzfs6hP2Y2+q1tXu+v61nrTHMi1MAx07Ykm/OiS8YTnJ680wBut2nu
         EXhVtdbUtZAXGIO4vLfcFOk6XP2e6gupXdlzZXvQdu5m33er6a+Q/x+MJh9ntwcbxzw7
         UFM19OEtHFAWB1TGf+4LIjyInJ6XUySZO53MCSBkNl6avqkGdYWc9IazgHJNC56WywlO
         QOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016291; x=1746621091;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=En0WM2Ei4FU3YU+QD2Q6x49MBG0M2eFBylvcvM2zlvc=;
        b=XVvK1aZ0FQ9wsqgt6vvI9GXC8/peYYQHH+Sq7yDJszyyd24XS83YPxa4vQP3HyV8He
         RiM2RKpmD9FbTu8X9lJ600hKv7BfhxFyagWoD4pbRD5yDQU86ObS7pBmboxNet0rkNWS
         gs2XM6S3yYaOoOzKxWPdrJoOVi6wfdSfvNVhQwhUpMoKgGVQXb2idkmhesRa9W4fe50w
         hSueg9R5OhMnq+h54Y69hf6Ofx5yv1QMw1F6CSrYyvI2tBT31JLtAa4iOZoZeJhMxJfI
         SyljfjWUWCOO9dXQ5JMvjIEqKryjT5ShJIHDEuZFER2u2zZP9nAvzR1GqgO6c6XjhCCL
         PR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKiA++K8F73VAT3moaYV/IsUdXEmj0bVQjZwg72ufG1SQkgtpkhRkezuDkeDLfNw8dX6GE39Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vp7GCKjeR/cbE+Qytxgx1V6Sxhv8St6S6NlBtETmfIz71U2g
	alnN6vg+EIx1PCv7u2c2C8eQUY/LEvgcszXQaY5j1c/FbpdOoBuv
X-Gm-Gg: ASbGncuZk37r7/LNO1hI8vXe+Q7RtUAU+xJHVdOm5GHA2mtbNeb5X4cIYI9RLKH7GNn
	dt0oifhglXs+Y+feIALEnzMP64cMN6jReKgAsxMENtTFVQ5g5ymhGA9MojK3AnZCp3pliFeuGcV
	1R66OcH0LP6mUj6nSzRf97UsQ9U5S0LCEqsg3amuCMkSY0uj2iLlJ3nSv4EkhaVTITUGrkclGle
	o9AUtTWJ+lweQPn0UlStwXgYpSRFrgTmBWJdgDYnwQYAiJHt5UnkJxA7pfQAmUtDCzNB1zoFUgh
	gucnwitz4UtId7FpPGb+JelZLLDMSrhpPq+7g2K3HxXK7of3JvysB+ImNOsByBvdYVUexgOToY3
	glSnLcepnEnwpSnTORyLn
X-Google-Smtp-Source: AGHT+IFi64lYAIb8/nE0fyQx/f8I1dIWwqu2DouVtvqeN0SJhl3/rvTYGwH/tGvAzVRZMh1iK2A5zQ==
X-Received: by 2002:a05:620a:400c:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7cac7608323mr408336885a.13.1746016290673;
        Wed, 30 Apr 2025 05:31:30 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958d86f1asm846630585a.69.2025.04.30.05.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:31:29 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:31:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 willemb@google.com, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <681218214b684_2edfe5294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250430100240.484636-1-idosch@nvidia.com>
References: <20250430100240.484636-1-idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv4: Honor "ignore_routes_with_linkdown" sysctl
 in nexthop selection
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
> Commit 32607a332cfe ("ipv4: prefer multipath nexthop that matches source
> address") changed IPv4 nexthop selection to prefer a nexthop whose
> nexthop device is assigned the specified source address for locally
> generated traffic.
> 
> While the selection honors the "fib_multipath_use_neigh" sysctl and will
> not choose a nexthop with an invalid neighbour, it does not honor the
> "ignore_routes_with_linkdown" sysctl and can choose a nexthop without a
> carrier:
> 
>  $ sysctl net.ipv4.conf.all.ignore_routes_with_linkdown
>  net.ipv4.conf.all.ignore_routes_with_linkdown = 1
>  $ ip route show 198.51.100.0/24
>  198.51.100.0/24
>          nexthop via 192.0.2.2 dev dummy1 weight 1
>          nexthop via 192.0.2.18 dev dummy2 weight 1 dead linkdown
>  $ ip route get 198.51.100.1 from 192.0.2.17
>  198.51.100.1 from 192.0.2.17 via 192.0.2.18 dev dummy2 uid 0
> 
> Solve this by skipping over nexthops whose assigned hash upper bound is
> minus one, which is the value assigned to nexthops that do not have a
> carrier when the "ignore_routes_with_linkdown" sysctl is set.
> 
> In practice, this probably does not matter a lot as the initial route
> lookup for the source address would not choose a nexthop that does not
> have a carrier in the first place, but the change does make the code
> clearer.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/ipv4/fib_semantics.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 03959c60d128..dabe2b7044ab 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2188,7 +2188,14 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  	saddr = fl4 ? fl4->saddr : 0;
>  
>  	change_nexthops(fi) {
> -		if (use_neigh && !fib_good_nh(nexthop_nh))
> +		int nh_upper_bound;
> +
> +		/* Nexthops without a carrier are assigned an upper bound of
> +		 * minus one when "ignore_routes_with_linkdown" is set.
> +		 */
> +		nh_upper_bound = atomic_read(&nexthop_nh->fib_nh_upper_bound);
> +		if (nh_upper_bound == -1 ||

Instead of a comment, perhaps a helper function

	static bool fib_link_is_down(int nh_upper_bound)
	{
		return nh_upper_bound == -1;
	}

or define a negative constant const int NH_HASH_LINKDOWN (-2) and
assign that in fib_rebalance and test that here?

But perhaps that's more complexity than it's worth. No strong opinion.

> +		    (use_neigh && !fib_good_nh(nexthop_nh)))
>  			continue;
>  
>  		if (!found) {
> @@ -2197,7 +2204,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  			found = !saddr || nexthop_nh->nh_saddr == saddr;
>  		}
>  
> -		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
> +		if (hash > nh_upper_bound)
>  			continue;
>  
>  		if (!saddr || nexthop_nh->nh_saddr == saddr) {
> -- 
> 2.49.0
> 



