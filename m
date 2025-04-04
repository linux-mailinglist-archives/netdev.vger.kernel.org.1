Return-Path: <netdev+bounces-179302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F289A7BDA9
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20281770A8
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6B1E5B74;
	Fri,  4 Apr 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6lMvwrO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8821C84BB
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772969; cv=none; b=ZJYEOnPnGnJLuaiUimUhwukx1FfiSaBH7appnNwuf8cgf2tQFnjfHrPyJwUOgKrq1XL5h1C6A5PKamiESdDIxz2rfiyhF3L6di/QK2Mea19uU37S3FC5cOscDs5tnVrSEnIJE+32haE24zkG0fIYOgvbPwV6ZjFB8GI+tuOD/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772969; c=relaxed/simple;
	bh=4ww7CWRUYkAw/bAHvqiRW3dgqVu/YJdHwER/2OKkFiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gX5qbJaTBA/lHrniMEVGY1t3SbK8ZI4EWIqFLmHmFYdALKJsZ7t/2waSSUvBNv8cDKVdAxmJOoGTcDhvppGJWhnXpVVexUIR+Rn0TZ9db17cSjqn0mZzShY50hS5qXFP4PhMXsfTBcijTFk0Ah6T5kLV//nL2hL5dutD2CaDkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6lMvwrO; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c559b3eb0bso117210285a.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743772966; x=1744377766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1oazODMsW+SwwvhTFupNaOfieyfNwpMuICbTHrwlJw=;
        b=W6lMvwrOsE3yusDBREUnTHNHPziddxcS6zlzfGSorhf91DEXQkfp5cHkiJJ8xbX8W6
         L5Q1ttV+b3v03VsflDVOvLxnxkCr554N4c4C5KAteE4kj2n3QLCjE6v2ItSZN8T45UL6
         B1ZX8QYDnsk3Yqw/hqwLpmpR7+QEEb4ZDrIvin6d4Oqu+W481IJ1K2nfwJOEEpNW9S0/
         W4TSPDMeQScIli92DN5gUAmc/dJMWBSuR6t7kfkBAtl3CRmGfQisLRr2viJhZYYdc1wD
         FeNYEv72yNHeXBAbQibuS5DwPbzzMTqfnUsULj6EQ6xP7/t5ghwhfS0y3H3qgGR8lPpi
         yETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743772966; x=1744377766;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r1oazODMsW+SwwvhTFupNaOfieyfNwpMuICbTHrwlJw=;
        b=NK6QYoALEl5lvUuVQvZeuebqMD8CQ9JuQY7SAnO1b/Yof7w0zGaKHFyEexKIUnbjQH
         Fql7E8CGVkCj8jrfoS8tVcs0wZBL5OT7u4JLWEcrEJ9xREsv0SU9UmwBPJgQ8bJe2Efb
         9yj8Arsdj3K5Qfz3YHlttB79bTudFChijp4pE41ODrIUujRPiBDV6ADwDuwoB/AcDo1S
         fGU6pp5D+ZB5CGHSZjjLKH4pU8C/vdJczXclpKXr/OMOLy8/Z3o19dUFogUQhUtQiT1i
         K0/9e3ayXiKxP6gAySQeJQriEssW07nXZLhLe2nZsox2zz5ilbT/x77riclBuMpXNgZM
         qcwA==
X-Forwarded-Encrypted: i=1; AJvYcCWHkTcfVVNRbkZir4W3aT8OBx6QsGoroBLyYxF+JTUQ3tf7fCdGKKigwscpZ5ZD52A5fpjN1yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAX9XEJDGyDKIM6ZWq3+KXE73N5TAQuikI9JJ8WOtih70JKq/m
	BOCDsZkSnF0+RScSOjFwQTFGAL+AG7G8gIaV1LGasIC6VQPpLGCU
X-Gm-Gg: ASbGnct/cq0AL5ClXOsd1UiBjHx/eHhbsORohiFaC0N9tnk+8mdym+2WxLbynBuMFNv
	pEu+Efj/Ec+Oa/BtOq/UU/lEbjrnmKz/Rp7SbWqEwQru2yzPOjSwe0MCQ+T82bmLhJvR5Sblg47
	Akap+mGeu5Ul3Mc37X4Kyx0QIWVwVCf4K7YYeD13YNu8Gn7bPtJqmABoJlFC5t7+AI65izMjYo8
	QC2HIAcyZ5TkqqUxkmlvCvFCpFLKR7bi17zn4CbRNLiy93D5067DZCuSLYeH3aKHKkzS5+YbeO2
	XHTDYWvt8oV5kyYlJ9u0lXGUUJa0wRBCmJRd1k2pcjk+NfQEMSf2z9nJLzLE4SdmijFvDlE3PTy
	uRtZl9vCgAcIliDHblQtGjw==
X-Google-Smtp-Source: AGHT+IER+24jYDWpoOX9NtvaaG+f+BWT417nY6BahV43oIyounme/Swqr+0UWow4YqhFfoDQfk9LqA==
X-Received: by 2002:a05:620a:244e:b0:7c5:5e5b:2fdb with SMTP id af79cd13be357-7c775abfcaemr324734185a.41.1743772966474;
        Fri, 04 Apr 2025 06:22:46 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea8581csm213984685a.107.2025.04.04.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 06:22:45 -0700 (PDT)
Date: Fri, 04 Apr 2025 09:22:45 -0400
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
Message-ID: <67efdd2596e33_1d5ffb294b9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250402114224.293392-3-idosch@nvidia.com>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-3-idosch@nvidia.com>
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

Ido Schimmel wrote:
> Nexthops whose link is down are not supposed to be considered during
> path selection when the "ignore_routes_with_linkdown" sysctl is set.
> This is done by assigning them a negative region boundary.
> 
> However, when comparing the computed hash (unsigned) with the region
> boundary (signed), the negative region boundary is treated as unsigned,
> resulting in incorrect nexthop selection.
> 
> Fix by treating the computed hash as signed. Note that the computed hash
> is always in range of [0, 2^31 - 1].
> 
> Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 864f0002034b..ab12b816ab94 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -442,6 +442,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  {
>  	struct fib6_info *first, *match = res->f6i;
>  	struct fib6_info *sibling;
> +	int hash;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
>  		goto out;
> @@ -468,7 +469,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  	if (!first)
>  		goto out;
>  
> -	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> +	hash = fl6->mp_hash;
> +	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&

The combined upper bounds add up to the total weights of the paths.

Should hash be scaled (using reciprocal_scale) to that bound to have
a uniform random distribution across all weights?

Else a hash in the range [0, 2^31 - 1] is unlikely to fall within the
total weights range.

>  	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
>  			    strict) >= 0) {
>  		match = first;
> @@ -481,7 +483,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		int nh_upper_bound;
>  
>  		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
> -		if (fl6->mp_hash > nh_upper_bound)
> +		if (hash > nh_upper_bound)
>  			continue;
>  		if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
>  			break;
> -- 
> 2.49.0
> 



