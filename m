Return-Path: <netdev+bounces-245643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F5CD427B
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07063007FCF
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDF27F4F5;
	Sun, 21 Dec 2025 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLfcU/tG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454981E0DE8
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332519; cv=none; b=M/u6Gwg5fl8lZeMoihn6GoayzKtLnkT045DSGHFFk3ku6TAE6+SkAoDYfErfM5xiPF8W2LwXhXFCF2xewUu805gv/EUdEmWA1rwEs0hzhjGi1b2nMuQaP2KzrtpGkMzXrXunbg0oB1v9mEF5XMj8IpZ7OxA5uVjD5S2zPrwpQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332519; c=relaxed/simple;
	bh=xAVqKYQqH5p1m2EUPU2jKA353ieyMlaSPI9JB3XVtLA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hkf6/fVF0CYIK2H7iFF/6Q+b29oINDmyng+gYtQLN7+ciis3oS49elTvX3lpzamKPpWQNM+cmY69E68mI32sjLrtUIv4pfwavtOojob3a8Vn6nMi7pERhZSGxKJfU257pTOQ5WBQkWMND6GC3Q/mk4vxL8984tGiYBz8tRWx6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLfcU/tG; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640d4f2f13dso2959912d50.1
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332517; x=1766937317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxyOoQXu4bPScAbfzbTe73o8NfnxBUXH8BThcQExm/s=;
        b=ZLfcU/tG+Rv6lr+xKQ+orHD5QsmJP3q09rNDNKAaYDMbnWoiVInA5yDj33nwGIFzKr
         mYIGbgeIIUWGJAPj4kW0HnhXxZFGkg5qLMnMeaQTtYfL+wL9S3n/Uz1aobIE22G90tzL
         4hj1RuEJXIN1FSzEWSegfJ+/HMMEHWqU5BxYNAifW6+Np3C9uotkDpZBjejG6mx54K2U
         ZkmiTkaqSRmwxQ8N91GFkaPDFyKYDBaZ2br+N8lYvWP1e/yPpxEDiLCJ9FyRkCJaICmJ
         4rIo5pnDEKtTMB0GrYRQNkMNejrrazwfbSbSEYLtewFzTZwiaNEGUn4QfMXhPQtxV014
         lXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332517; x=1766937317;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxyOoQXu4bPScAbfzbTe73o8NfnxBUXH8BThcQExm/s=;
        b=qyGYxqoGfri0s8LCIddWU8yROgEfyuvolWAX4ew0ZbbyRr22cR2MXYx+O1/lE+Zxhn
         opQc57FN/UIITBv6uHMH0BYVcbGwQtKf1hvGuajVvo81JJ+zjVNt56B+IJo9fIQp52fe
         rBOIlWaZ6z59Gv26h8ILZoGdj1H0nar8Ij6E/oZsC7n+ItYzhwzVAxFcc/XO754Ts3nG
         dv5vwGVAc0caBxIEvzQ2KFVyjnX9sfal4WRSbbJG/eODmWmDc4ilb7UhGU6Nw7vm6DlX
         0KB25fVcEjAB2c00RIfYQuNvCR/sEOM44UV9FUWYADCOubp0UOzSa1hy914bYEHtRmNe
         FdBw==
X-Forwarded-Encrypted: i=1; AJvYcCURVWqMNgYFDCZ1zBIhehQ56oVEgZISPulAgLYHoFHz2qR4/hDN6j2L2X9pQODA3t7h14MSVtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hzCMrljfp/hw1hj0WVPFlmw83SarN0HSB+urUOqdf6YRjDHq
	ONurbSoUXu+4alKYi2RK51JJeb+HDhErBBsC0hFNFMm98QhnDcrKpzGj
X-Gm-Gg: AY/fxX6Mz9m1xu8mSgV3mdwDZ/SfmuIbxqJYlBeUNfzXmZlDCZxF8goZD0T5zZkuGLS
	m+Bz/JGJwIawYcK4lQq1sTEq7J6J6xd2aJQio3/2eRLBgTI85LY35mMcoJt/tWBAu7ZLBFzFSFd
	PVh4CdiDEapDQBAIWEoFj7CU33K+6Ey13meVtkYlCxD4w+8A1hUgejpGfhZ6kiK1fBqGZ6Zisu+
	d7jS4UnQHAAIxWpRcf2p1AVpVkJliAiHIpgDcDBoyMD/73sLOs8gbdh4qo2/wrGoUjYTSLRb9jF
	FTMzNol2/0sPyxKkbKac0gmU/X8/j5NByfLdIm7NBcLIa+jfpCyOpGdvK+uW69FhnNwRgokdn6J
	0VNlwrP8M7HefgWb/nAO2D+9DSc5LlSCZQneBS1GEkjKdowYgr+IqVJg3ADs7WZxzQb21n+gsi7
	V0BK5PVXlK32fIVSnw1+8t1mBtdKQdG84y4XQ98hG5M1FVISmM1jGfy4pfwSlFPGksf48=
X-Google-Smtp-Source: AGHT+IEj2J9elYoopXA4R1zbYfW1Tl0fVj72prczCf/KLUiss5IoJl46J0dbWt1JpN00Cx2VMnytcg==
X-Received: by 2002:a53:d68e:0:b0:645:443d:10df with SMTP id 956f58d0204a3-6466a837720mr5920527d50.10.1766332517216;
        Sun, 21 Dec 2025 07:55:17 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb416b32csm34099707b3.0.2025.12.21.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:55:16 -0800 (PST)
Date: Sun, 21 Dec 2025 10:55:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <willemdebruijn.kernel.25af879fdb851@gmail.com>
In-Reply-To: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
References: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v2 1/2] net: fib: restore ECMP balance from loopback
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
> source addresses which are not in the broadcast domain, but rather added
> to loopback/dummy interfaces. Original behaviour was to balance over
> nexthops while now it uses the latest nexthop from the group.
> 
> For the case with 198.51.100.1/32 assigned to dummy0 and routed using
> 192.0.2.0/24 and 203.0.113.0/24 networks:
> 
> 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/ether d6:54:8a:ff:78:f5 brd ff:ff:ff:ff:ff:ff
>     inet 198.51.100.1/32 scope global dummy0
>        valid_lft forever preferred_lft forever
> 7: veth1@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 06:ed:98:87:6d:8a brd ff:ff:ff:ff:ff:ff link-netnsid 0
>     inet 192.0.2.2/24 scope global veth1
>        valid_lft forever preferred_lft forever
>     inet6 fe80::4ed:98ff:fe87:6d8a/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
> 9: veth3@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether ae:75:23:38:a0:d2 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>     inet 203.0.113.2/24 scope global veth3
>        valid_lft forever preferred_lft forever
>     inet6 fe80::ac75:23ff:fe38:a0d2/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
> 
> ~ ip ro list:
> default
> 	nexthop via 192.0.2.1 dev veth1 weight 1
> 	nexthop via 203.0.113.1 dev veth3 weight 1
> 192.0.2.0/24 dev veth1 proto kernel scope link src 192.0.2.2
> 203.0.113.0/24 dev veth3 proto kernel scope link src 203.0.113.2
> 
> before:
>    for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>     255 veth3
> 
> after:
>    for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>     122 veth1
>     133 veth3
> 
> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v1 -> v2:
> 
> - add score calculation for nexthop to keep original logic
> - adjust commit message to explain the config
> - use dummy device instead of loopback
> ---
> 
>  net/ipv4/fib_semantics.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index a5f3c8459758..4d3650d20ff2 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2167,8 +2167,8 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  {
>  	struct fib_info *fi = res->fi;
>  	struct net *net = fi->fib_net;
> -	bool found = false;
>  	bool use_neigh;
> +	int score = -1;
>  	__be32 saddr;
>  
>  	if (unlikely(res->fi->nh)) {
> @@ -2180,7 +2180,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  	saddr = fl4 ? fl4->saddr : 0;
>  
>  	change_nexthops(fi) {
> -		int nh_upper_bound;
> +		int nh_upper_bound, nh_score = 0;
>  
>  		/* Nexthops without a carrier are assigned an upper bound of
>  		 * minus one when "ignore_routes_with_linkdown" is set.
> @@ -2190,24 +2190,16 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  		    (use_neigh && !fib_good_nh(nexthop_nh)))
>  			continue;
>  
> -		if (!found) {
> +		if (saddr && nexthop_nh->nh_saddr == saddr)
> +			nh_score += 2;
> +		if (hash <= nh_upper_bound)
> +			nh_score++;
> +		if (score < nh_score) {
>  			res->nh_sel = nhsel;
>  			res->nhc = &nexthop_nh->nh_common;
> -			found = !saddr || nexthop_nh->nh_saddr == saddr;

if score == 3 return immediately?

> +			score = nh_score;
>  		}
>  
> -		if (hash > nh_upper_bound)
> -			continue;
> -
> -		if (!saddr || nexthop_nh->nh_saddr == saddr) {
> -			res->nh_sel = nhsel;
> -			res->nhc = &nexthop_nh->nh_common;
> -			return;
> -		}
> -
> -		if (found)
> -			return;
> -
>  	} endfor_nexthops(fi);
>  }
>  #endif
> -- 
> 2.47.3
> 



