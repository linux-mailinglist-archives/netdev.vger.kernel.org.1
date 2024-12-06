Return-Path: <netdev+bounces-149759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23489E74E3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41D528480D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20562066F0;
	Fri,  6 Dec 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="f+Jz1+MR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA8202F7C
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500201; cv=none; b=Z1CGM4022bD8bzED1F4WOWh3cE3B5KVU9TAvQwKwwXamjMGbNWo7KQKDAdG8Y6CsbSoHboBeIDx8G8ZTwXUZ+dF8RfNRqDDumXUp/1XryrqJRShpgtCUnFBJnVc0QeiAo58c/sCuDIu8Xpxe88EpViWK6XIOlg/H1Bi8KgoDToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500201; c=relaxed/simple;
	bh=r0/qQjdnucK9CezrhODA91FUbW1cBJCAraA50PCrGmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfhifTzHhlUvNQmzHL6j2ofRFzcl74Vg9cGXeRc3QPYv+6CTnYGtxuO+4nXP5xh7VW9k6ovV7WSLCLy9B+dC2HLIv6UNOYO58+rjf7NYDaqsipaLMdoB8afGh/A6dsWtJVEgvTjKHBxsew42U+eBKb4fXLVqrF6moAXbtjWcXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=f+Jz1+MR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a12d106dso2386625e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1733500198; x=1734104998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hd1puHkFlumxB6eWwZzpU3coqhJLDU0Mw07iYqjq2AU=;
        b=f+Jz1+MRUaBB7PvLVxdo/lKEUx+b/aNuwP3/YT12YPXIYqTCYhwOOt3tmadGxY+fq6
         mlpTphbyiu2/LagxVlEbL1/fKD3l0kGqgzQSnogTJsYTaB1WVDjzSEzqIcFODtCSOMYh
         Dn7AcHNqV9zYIGSXSWurldJrq7AKeC692n50lHVfni1K4roX8UjcwPi8pJc0NDV9PpBn
         DbfyyVR6QgJRZXZQPSCJL7ysh7TEcpwg1D1Ak3WVVla+aaQC/eaTZRNolARjX7kBwSlI
         bb1aw6QUTGEJQLTKkRmMGLPjNJ7l8FQ6UnLHzWxScyNE1OXQsO+8iDiOLDhKFxwmE41w
         Sw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500198; x=1734104998;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hd1puHkFlumxB6eWwZzpU3coqhJLDU0Mw07iYqjq2AU=;
        b=YGXpHloBILZBvFC9myfcDLpba0vAWJ/RUfdoIFvAQyKtqQMfuw2OaIH+6B3dlO1Jws
         VN4ts6TcMF7dKzOpw8NU7Apex8t7BRElfGY8y9h9qIgOmiKli8ebi7f3auWKBpXcD8Cs
         C7afdd/QvIsj3EjAQZDRPYy7cJ2nO8ADrAS/wSAQtWgyC4g/Yb5Hmj470IDvAbR7kdVM
         PEqYZLBq2/l6UmVaRWmIRhPBYIuTaJlOxkmoIYIUfAptGdu8jNH7dKELGcAQ6FpWxiTc
         oEJ+1NJhUShNimgSHhDKketyYaXoiuq2nj9ytTuuQAXGjryWjr5n7XXClHbsX39HpSL7
         AAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3K8iRJOSmHnLfU97DIvbEcsYpaCgOn5v/OaWHxUHONyJRDQT5GEacSnMSZeDtzkiQmD3Qj5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexKVGLlgpDW8rQ4jkI2bUzNsg3XzuhNGauEtnMW/y2ho933xq
	HQmxBq5egdWjaOTCNIiqs06BhJ76+UiiIIl0Sd10UFyW4uYK4gQSv7ga3dxNEHI=
X-Gm-Gg: ASbGnctIRCCQGNG7zBca3QPwGXIYWM48yXoIWwCk0+Yksn0QWu6m/JUnC3CdeA16rPx
	4fO0h20jP+Uv6/pHyCes1e86EWT5fySsESoPoo9EnctIrx3XV8M/U/eqBab1iTmITMl3VNXHe4K
	vV1ustC9x9/FZeQG2ACb0h0LnRsz2XUwQ8L5MO5HBAiPdD53/vylOyHnQAXRx2bo/wWA9jVtkrK
	6ErRGzju8Rws7KKva5LN66tJkjdZWe95Wbv39UxpsMDFLms0Sy24ees+lAC1ec4gvsBXhEAvfZA
	9a25XIgQZJA6wIXBXVo9DiRBOS8=
X-Google-Smtp-Source: AGHT+IG3jlpzQqG//gosi/sjmEDE0DdQIvaTS1jhoIqfLKRXmrixQizspDc9aix+Xts25FNF2aGthg==
X-Received: by 2002:a05:600c:a44:b0:42c:aeee:e604 with SMTP id 5b1f17b1804b1-434ddeddb11mr13018695e9.8.1733500198236;
        Fri, 06 Dec 2024 07:49:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:234f:9b13:6d13:5195? ([2a01:e0a:b41:c160:234f:9b13:6d13:5195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cad51sm95829035e9.36.2024.12.06.07.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:49:57 -0800 (PST)
Message-ID: <dfbea06a-16ee-4d53-8d45-7a7c7d0a32ef@6wind.com>
Date: Fri, 6 Dec 2024 16:49:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next, v4 2/2] iproute2: add 'ip monitor maddr'
 support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20241206124554.355503-1-yuyanghuang@google.com>
 <20241206124554.355503-2-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241206124554.355503-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 06/12/2024 à 13:45, Yuyang Huang a écrit :
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
> root@uml-x86-64:/# ip monitor maddr
> 8: nettest123    inet6 mcast ff01::1 scope global
> 8: nettest123    inet6 mcast ff02::1 scope global
> 8: nettest123    inet mcast 224.0.0.1 scope global
> 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> Deleted 8: nettest123    inet mcast 224.0.0.1 scope global
> Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> Deleted 8: nettest123    inet6 mcast ff02::1 scope global
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
> 
> Changelog since v3:
> - Update man/man8/ip-monitor.8 page.
> - Use 'ip monitor maddr' for naming consistency with 'ip maddr' command.
> 
> Changelog since v1:
> - Move the UAPI constants to a separate patch.
> - Update the commit message.
> - Fix the indentation format.
> 
>  ip/ipaddress.c        | 17 +++++++++++++++--
>  ip/ipmonitor.c        | 25 ++++++++++++++++++++++++-
>  man/man8/ip-monitor.8 |  2 +-
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/ip/ipaddress.c b/ip/ipaddress.c
> index d90ba94d..373f613f 100644
> --- a/ip/ipaddress.c
> +++ b/ip/ipaddress.c
> @@ -1504,7 +1504,10 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
>  
>  	SPRINT_BUF(b1);
>  
> -	if (n->nlmsg_type != RTM_NEWADDR && n->nlmsg_type != RTM_DELADDR)
> +	if (n->nlmsg_type != RTM_NEWADDR
> +	    && n->nlmsg_type != RTM_DELADDR
> +	    && n->nlmsg_type != RTM_NEWMULTICAST
> +	    && n->nlmsg_type != RTM_DELMULTICAST)
We usually put the boolean operator at the end of the line.

>  		return 0;
>  	len -= NLMSG_LENGTH(sizeof(*ifa));
>  	if (len < 0) {
> @@ -1564,7 +1567,7 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
>  
>  	print_headers(fp, "[ADDR]");
>  
> -	if (n->nlmsg_type == RTM_DELADDR)
> +	if (n->nlmsg_type == RTM_DELADDR || n->nlmsg_type == RTM_DELMULTICAST)
>  		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
>  
>  	if (!brief) {
> @@ -1639,6 +1642,16 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
>  						   rta_tb[IFA_ANYCAST]));
>  	}
>  
> +	if (rta_tb[IFA_MULTICAST]) {
> +		print_string(PRINT_FP, NULL, "%s ", "mcast");
> +		print_color_string(PRINT_ANY,
> +				   ifa_family_color(ifa->ifa_family),
> +				   "multicast",
> +				   "%s ",
> +				   format_host_rta(ifa->ifa_family,
> +						   rta_tb[IFA_MULTICAST]));
> +	}
> +
>  	print_string(PRINT_ANY,
>  		     "scope",
>  		     "scope %s ",
> diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
> index de67f2c9..beefba4a 100644
> --- a/ip/ipmonitor.c
> +++ b/ip/ipmonitor.c
> @@ -30,7 +30,7 @@ static void usage(void)
>  	fprintf(stderr,
>  		"Usage: ip monitor [ all | OBJECTS ] [ FILE ] [ label ] [ all-nsid ]\n"
>  		"                  [ dev DEVICE ]\n"
> -		"OBJECTS :=  address | link | mroute | neigh | netconf |\n"
> +		"OBJECTS :=  address | link | mroute | maddr | neigh | netconf |\n"
I was probably not clear. Please use 'maddress', like the existing one.

>  		"            nexthop | nsid | prefix | route | rule | stats\n"
>  		"FILE := file FILENAME\n");
>  	exit(-1);
> @@ -152,6 +152,11 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
>  		ipstats_print(n, arg);
>  		return 0;
>  
> +	case RTM_DELMULTICAST:
> +	case RTM_NEWMULTICAST:
> +		print_addrinfo(n, arg);
> +		return 0;
> +
>  	case NLMSG_ERROR:
>  	case NLMSG_NOOP:
>  	case NLMSG_DONE:
> @@ -178,6 +183,7 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
>  #define IPMON_LRULE		BIT(8)
>  #define IPMON_LNSID		BIT(9)
>  #define IPMON_LNEXTHOP		BIT(10)
> +#define IPMON_LMADDR		BIT(11)
>  
>  #define IPMON_L_ALL		(~0)
>  
> @@ -220,6 +226,8 @@ int do_ipmonitor(int argc, char **argv)
>  			lmask |= IPMON_LNEXTHOP;
>  		} else if (strcmp(*argv, "stats") == 0) {
>  			lmask |= IPMON_LSTATS;
> +		} else if (strcmp(*argv, "maddr") == 0) {
> +			lmask |= IPMON_LMADDR;
And here, youc an use 'matches(*argv, "maddress")' so that it will be consistent
with
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/ip/ip.c?h=v6.12.0#n92

Note that it should be put after the '} else if (matches(*argv, "address") == 0)
{' block also.


Regards,
Nicolas

