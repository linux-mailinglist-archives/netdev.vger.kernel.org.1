Return-Path: <netdev+bounces-142022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5E9BCF94
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A13B1C25577
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDE1D968A;
	Tue,  5 Nov 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ceTtK023"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569F1D90B1
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817459; cv=none; b=Dfs9QHPL+NmtcJkH9OBu2kDjG6MJbWR75lIhBGcwS0bSeJKDfTeq6IWPpQ0aei2xT02sITlabWlqrNZL6OeYTcUhyz1yvs0WBfT5JHje2/rguwSprRmx80EgvrfvKhUBtnZ6YwUkMiDUOaAqmOv8evLrDcyGy88t6kzE/5Uayio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817459; c=relaxed/simple;
	bh=UI80saSNGQyeENZwHXQ20TbdoevVCEFmRy69WMBcnh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5VbOBjHQapSTvwiTXvHW6v9pLk9vCtS8N3hVaMJ+Ke4i2Ny3ySHG2QqZzbVFwgX0z4FNgnSZt9XSqeLOHxqSnAdYVqbpp8xyM+h/8JAYh1tnRX5E0GjgrfDGXBhJ41/kQNbn3tNY+XBLdj7fMD5hNWE7b/Ql6/xlPHOb7vGF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ceTtK023; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a68480e3eso98058766b.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 06:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1730817455; x=1731422255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QPuUXaKIVWgxMoZDzRHV+Ij4osZDivWBSJCKiW/uKdM=;
        b=ceTtK0234IYVNp/EIGkh++V05nPwxZ2IpTDcEx37waKxh6Wrz9KH1czC8g/KyJQueT
         fAh3eLysjhKwQtZhCArJW0Mxcx903RqK6LyTDFKrIg+1weiVJxzyZLIqT8gcMjtyzcWz
         IS9lDdBNcVZJzTo1BrrkXT0B4RjTlGEbQnLYIr32imjY1mV+QzjgA7miu4srhHTVWAGt
         Q67uMOqnpGJfLXYV/Y47A0ni99CVEfqiuiuZDi4OW74zf6TsY52AbRzUNap+I6GJEeaF
         5vgToOhS9ku0VjNcK4eTDx/9wBiWYcV7X1LPgps39BqQfhecFt1Fa/qTaXlVVOenfZ5e
         Kytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817455; x=1731422255;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPuUXaKIVWgxMoZDzRHV+Ij4osZDivWBSJCKiW/uKdM=;
        b=tbj1fH6LHesMYkjwWNQVzHo/jIHT2p4/PpsRVRj0wKgDrBoP5qS5RcHXo+oeTTWVoY
         54IVoycv3xiFyQ0lBW7nPauBkF8aa6L9pjQ34nzWZ8iyVTCMldi4QShGVSoQj4G7Nkp8
         qo9qSURbK28YdGbN+ZZ9Xb3NyULEjEgohadjMxFKdCSNP/D0mtsScBcEQvGpyQbgamVm
         OTulA59H3NNbG9dfl59CHh0/cocXAvZCl0riXjzKhbGzCf6FGZwnxZzFRJ6BvFOJEkMA
         NToTNOT3ZcECv3wX0ijGcItBvTDVFudHPOEn/Zxx1eVdOTv22tTePR9oh9BLfMB4aE/N
         LDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXttqGGJpMvpVgSDrzM2kJomVjHFLdrJJXIZ3l5+sKSWD5vrAl8D8qf3Juy6vlu/RyKWguVTeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoAg49a9cz0XhgnmGinZoNdTXZcV5hY6H/LtJP8zC8IRRewrR
	Fd9WsT7BbF49WZEWvgL4lMpK6DrphwKzoyRVpLTvdPD/X6rI1JzBkvAbSj+gEIM=
X-Google-Smtp-Source: AGHT+IG+eEaOxwwxnqnBi7IH4m8CimowCnFKODJk37Vb46MQue71WVSIC0ndfLwQiCJS/6/D5SZ7ig==
X-Received: by 2002:a17:906:dc8f:b0:a99:f388:6f49 with SMTP id a640c23a62f3a-a9de61a0fc0mr1328330766b.9.1730817454689;
        Tue, 05 Nov 2024 06:37:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:5127:810a:3f6b:b00f? ([2a01:e0a:b41:c160:5127:810a:3f6b:b00f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cf842sm142063366b.121.2024.11.05.06.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:37:34 -0800 (PST)
Message-ID: <0a8d6565-fdc0-452f-b132-5d237a1b7dec@6wind.com>
Date: Tue, 5 Nov 2024 15:37:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/1] net/ipv6: Netlink flag for new IPv6 Default
 Routes
To: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, linux-api@vger.kernel.org, stable@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241105031841.10730-1-Matt.Muggeridge@hpe.com>
 <20241105031841.10730-2-Matt.Muggeridge@hpe.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241105031841.10730-2-Matt.Muggeridge@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/11/2024 à 04:18, Matt Muggeridge a écrit :
> Add a Netlink rtm_flag, RTM_F_RA_ROUTER for the RTM_NEWROUTE message.
> This allows an IPv6 Netlink client to indicate the default route came
> from an RA. This results in the kernel creating individual default
> routes, rather than coalescing multiple default routes into a single
> ECMP route.
> 
> Details:
> 
> For IPv6, a Netlink client is unable to create default routes in the
> same manner as the kernel. This leads to failures when there are
> multiple default routers, as they were being coalesced into a single
> ECMP route. When one of the ECMP default routers becomes UNREACHABLE, it
> was still being selected as the nexthop.
> 
> Meanwhile, when the kernel processes RAs from multiple default routers,
> it sets the fib6_flags: RTF_ADDRCONF | RTF_DEFAULT. The RTF_ADDRCONF
> flag is checked by rt6_qualify_for_ecmp(), which returns false when
> ADDRCONF is set. As such, the kernel creates separate default routes.
> 
> E.g. compare the routing tables when RAs are processed by the kernel
> versus a Netlink client (systemd-networkd, in my case).
> 
> 1) RA Processed by kernel (accept_ra = 2)
> $ ip -6 route
> 2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 expires ...
> fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra ...
> default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra ...
> 
> 2) RA Processed by Netlink client (accept_ra = 0)
> $ ip -6 route
> 2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires ...
> fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
> fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
> default proto ra metric 1024 expires 595sec pref medium
> 	nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
> 	nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
> 
> IPv6 Netlink clients need a mechanism to identify a route as coming from
> an RA. i.e. a Netlink client needs a method to set the kernel flags:
> 
>     RTF_ADDRCONF | RTF_DEFAULT
> 
> This is needed when there are multiple default routers that each send
> an RA. Setting the RTF_ADDRCONF flag ensures their fib entries do not
> qualify for ECMP routes, see rt6_qualify_for_ecmp().
> 
> To achieve this, introduce a user-level flag RTM_F_RA_ROUTER that a
> Netlink client can pass to the kernel.
> 
> A Netlink user-level network manager, such as systemd-networkd, may set
> the RTM_F_RA_ROUTER flag in the Netlink RTM_NEWROUTE rtmsg. When set,
> the kernel sets RTF_RA_ROUTER in the fib6_config fc_flags. This causes a
> default route to be created in the same way as if the kernel processed
> the RA, via rt6add_dflt_router().
> 
> This is needed by user-level network managers, like systemd-networkd,
> that prefer to do the RA processing themselves. ie. they disable the
> kernel's RA processing by setting net.ipv6.conf.<intf>.accept_ra=0.
> 
> Without this flag, when there are mutliple default routers, the kernel
> coalesces multiple default routes into an ECMP route. The ECMP route
> ignores per-route REACHABILITY information. If one of the default
> routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
> it can still be selected as the nexthop for outgoing packets. This
> results in an inability to communicate with remote hosts, even though
> one of the default routers remains REACHABLE. This violates RFC4861
> section 6.3.6, bullet 1.
> 
> Extract from RFC4861 6.3.6 bullet 1:
>      1) Routers that are reachable or probably reachable (i.e., in any
>         state other than INCOMPLETE) SHOULD be preferred over routers
>         whose reachability is unknown or suspect (i.e., in the
>         INCOMPLETE state, or for which no Neighbor Cache entry exists).
> 
> This fixes the IPv6 Logo conformance test v6LC_2_2_11, and others that
> test with multiple default routers. Also see systemd issue #33470:
> https://github.com/systemd/systemd/issues/33470.
> 
> Signed-off-by: Matt Muggeridge <Matt.Muggeridge@hpe.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-api@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  include/uapi/linux/rtnetlink.h | 9 +++++----
>  net/ipv6/route.c               | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 3b687d20c9ed..9f0259f6e4ed 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -202,7 +202,7 @@ enum {
>  #define RTM_NR_FAMILIES	(RTM_NR_MSGTYPES >> 2)
>  #define RTM_FAM(cmd)	(((cmd) - RTM_BASE) >> 2)
>  
> -/* 
> +/*
>     Generic structure for encapsulation of optional route information.
>     It is reminiscent of sockaddr, but with sa_family replaced
>     with attribute type.
> @@ -242,7 +242,7 @@ struct rtmsg {
>  
>  	unsigned char		rtm_table;	/* Routing table id */
>  	unsigned char		rtm_protocol;	/* Routing protocol; see below	*/
> -	unsigned char		rtm_scope;	/* See below */	
> +	unsigned char		rtm_scope;	/* See below */
>  	unsigned char		rtm_type;	/* See below	*/
>  
>  	unsigned		rtm_flags;
> @@ -336,6 +336,7 @@ enum rt_scope_t {
>  #define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
>  #define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
>  #define RTM_F_TRAP		0x8000	/* route is trapping packets */
> +#define RTM_F_RA_ROUTER		0x10000	/* route is a default route from RA */
Please, don't mix whitespace changes with the changes related to the new flag.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n166


Regards,
Nicolas

