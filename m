Return-Path: <netdev+bounces-145819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10139D109F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AA31F232F1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA819AA68;
	Mon, 18 Nov 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHCHKx4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDD19A288
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933391; cv=none; b=qsWgd7hZ7Gee5oZDhGdzKsBY9efNN0kvnsusigtDFpxeQndyxMNosQLYWuSt1omm3yqiBY0E+QDp/DXcFtcIPRWWV9mini9q0gNZosCRViuvKXtBVaEILo4TFzLL32OYayGYSbO0Pxr3Tb9JTVHYJE5Ld/ZwVvsasXxtmPKT3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933391; c=relaxed/simple;
	bh=au7Wcy3zIXPA3cFUczTfmlpykExc9P15BO1mTJXuI7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Xqu34sgz1CuWBo5qGCkn0buKBMjxQ6whLYkdYr1hOUcD3N8bIvSBTvI47edleWEaQ9sGld7wmgucHDd8wT9go1kOXuWfGWQyCU8mcQYBkiqjxhShmnCGtWfUlNWDoTmt8r698dlfxfqkkYtC1JR69Qr76L4kxuHrFMYpMqIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHCHKx4z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1639288a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731933389; x=1732538189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KJ5UNj9SfGuydcrxRB331ERZl4+gXJ85bx84sJ/8k8=;
        b=PHCHKx4zQpVcxKLx/fxkw+6d3R8HGmSVyG7g0oDlYwseFx2BUyyq2x+/wnNWnwFrN5
         O+/jjd4+wKxR/RaIi9RYE6ZQh5ivs2Qnj3Dgmn5hExHyjcP2x4cEYMi/8zDhccRNCb2j
         WFtJN+wvUMh90SloiDNOMB2NtJfwoqOOaNCHpVgncUtF8ksmTwOPm34IdHRP8JbO6Baz
         AHCh0++DaI3lQynHeyP2tE18waX8nXRfRmtg4wBQH+8me/Y4Sr47ftKufK9qYMDuVsG6
         l0ytgsCcXh/v5hmehAdvbBRnKBwtYSaOMnAa093ekMZ411bUyXzBHqLFm3xEJbrODmrm
         R1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731933389; x=1732538189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KJ5UNj9SfGuydcrxRB331ERZl4+gXJ85bx84sJ/8k8=;
        b=vKbS/+aejirhKjBCNXu13XomnPYADKLxfejyrlaVRwxLWHymRzENWyFe4tGjohvcWR
         +dW7kzciuSY5Jvoa85gpwX3vFIdsaaV1Tzm8101JizI+6xbBTUI288nExtDVBSm9OjOf
         vqVwr2bQZh3phtYE+HkRCC989B/FEMAizHci26AJ13AdOMGWw4namh8AdwkHc1TX5YF2
         N3P88mdAg9hw23EueL58Irzqus4MhxqeC2fsK/SDBAsMM9BIKdDUXPC8V5ysZj9wwxjs
         ithX7lFnEomtHesDbytD9Fs6FK7I5RiYPhF/0fCHa46v0JJHIeqQ8WkFVBLYoGVhbLEc
         cBKg==
X-Forwarded-Encrypted: i=1; AJvYcCWqECAD/VICEyV9piSJfxGoB23tvwOz0R8MjOqlr+n8nWezXzylMP5LlPoDqPWy+cETe1X7QIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYumvX/tnIGAnI0Mk1+TAi5+hfgDCKqIcWMvKVXDIuWGI93PS1
	Ka/5T56FAMR/7X5+ivzNdRfyY2FB4oIA+aheZZKGY3iEgu4eIdIG
X-Google-Smtp-Source: AGHT+IEnct71WolKRfBHKW6axNOm/sCfEZKazpHBYZOPbw5fSe3JV7G5kjMP5QCQYfcOnyo/pFGO2A==
X-Received: by 2002:a05:6a20:12d0:b0:1db:fff7:25d5 with SMTP id adf61e73a8af0-1dc90b47573mr17650530637.19.1731933388603;
        Mon, 18 Nov 2024 04:36:28 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eef34sm6133220b3a.8.2024.11.18.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 04:36:27 -0800 (PST)
Date: Mon, 18 Nov 2024 12:36:20 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com,
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH iproute2-next] iproute2: add 'ip monitor mcaddr' support
Message-ID: <Zzs0xDi-3jdQSuk0@fedora>
References: <20241117141655.2078777-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241117141655.2078777-1-yuyanghuang@google.com>

On Sun, Nov 17, 2024 at 11:16:55PM +0900, Yuyang Huang wrote:
> Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
> multicast addresses. This update allows the command to listen for
> events related to multicast address additions and deletions by
> registering to the newly introduced RTNLGRP_IPV4_MCADDR and
> RTNLGRP_IPV6_MCADDR netlink groups.
> 
> This patch depends on the kernel patch that adds RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR being merged first.
> 
> Here is an example usage:
> 
> root@uml-x86-64:/# ip monitor mcaddr
> 8: nettest123    inet6 mcast ff01::1 scope global
> 8: nettest123    inet6 mcast ff02::1 scope global
> 8: nettest123    inet mcast 224.0.0.1 scope link
> 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> Deleted 8: nettest123    inet mcast 224.0.0.1 scope link
> Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> Deleted 8: nettest123    inet6 mcast ff02::1 scope global
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>  include/uapi/linux/rtnetlink.h |  8 ++++++++
>  ip/ipaddress.c                 | 17 +++++++++++++++--
>  ip/ipmonitor.c                 | 25 ++++++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 4e6c8e14..ccf26bf1 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -93,6 +93,10 @@ enum {
>  	RTM_NEWPREFIX	= 52,
>  #define RTM_NEWPREFIX	RTM_NEWPREFIX
>  
> +	RTM_NEWMULTICAST,
> +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> +	RTM_DELMULTICAST,
> +#define RTM_DELMULTICAST RTM_DELMULTICAST
>  	RTM_GETMULTICAST = 58,
>  #define RTM_GETMULTICAST RTM_GETMULTICAST
>  
> @@ -772,6 +776,10 @@ enum rtnetlink_groups {
>  #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
>  	RTNLGRP_STATS,
>  #define RTNLGRP_STATS		RTNLGRP_STATS
> +	RTNLGRP_IPV4_MCADDR,
> +#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
> +	RTNLGRP_IPV6_MCADDR,
> +#define RTNLGRP_IPV6_MCADDR    RTNLGRP_IPV6_MCADDR
>  	__RTNLGRP_MAX
>  };
>  #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)

No need changes for headers. Stephen will sync the headers.

> @@ -220,6 +226,8 @@ int do_ipmonitor(int argc, char **argv)
>  			lmask |= IPMON_LNEXTHOP;
>  		} else if (strcmp(*argv, "stats") == 0) {
>  			lmask |= IPMON_LSTATS;
> +		} else if (strcmp(*argv, "mcaddr") == 0) {
> +			lmask |= IPMON_LMCADDR;
>  		} else if (strcmp(*argv, "all") == 0) {
>  			prefix_banner = 1;
>  		} else if (matches(*argv, "all-nsid") == 0) {
> @@ -326,6 +334,21 @@ int do_ipmonitor(int argc, char **argv)
>  		exit(1);
>  	}
>  
> +	if (lmask & IPMON_LMCADDR) {
> +		if ((!preferred_family || preferred_family == AF_INET) &&
> +			rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {

The rtnl_add_nl_group() should be aligned with the upper bracket. e.g.

		if ((!preferred_family || preferred_family == AF_INET) &&
		    rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {

> +			fprintf(stderr,
> +				"Failed to add ipv4 mcaddr group to list\n");
> +			exit(1);
> +		}
> +		if ((!preferred_family || preferred_family == AF_INET6) &&
> +			rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {

Same with this one.

Thanks
Hangbin

