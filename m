Return-Path: <netdev+bounces-144027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A8F9C527B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD681F223C3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A957620CCE9;
	Tue, 12 Nov 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Z2LESI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3720DD4A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405254; cv=none; b=NifFF1CPgoIGBlvGejvF0mSL1rspSOfhleWKHgK3CQ/xofHZ/McnQLT2Ekuf+pUqGhUaLDmZzJiCNBKXwW+RFKwZrKm2HdR60PiHDqacnSgPD9bxKGXcAkAW9wPUolpGHqj+DG4r7XV2iOwgWwMq9RmxlwC6WsZLFinanwzHhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405254; c=relaxed/simple;
	bh=3HNWfHUwArYFDXtUPr76dmIQmxacz0BRfIkjJnkltec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7nu0Vqv1mtfrbSRxjKv2ITqgybKuEAy0QDysxuYrn/JQc0heLJJg/6GozNH646txpq1OPqpdFjTcFlgRmrHAcQS+cQa9A1Uy1rPCkOtQge4+UDEN7NSuVkxBxYNBrO03ua7zgytlE7DrNs734QDjPxi8kqpCFYT6Km1LRYxPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8Z2LESI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f3f1849849so3724859a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731405252; x=1732010052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGIaBGh/yP1sQaweFYGyz2QSAZYptrOZsvs2Ztr/KZQ=;
        b=U8Z2LESIX1vBgeD29akCu5DfYRKIvsr7qeJSSI3xkesweQN6ibeiguH/vK+gMQ4MBE
         daNEmeQddUDzgBF/JCA3kT8MUHfuHWirnn/aEuswI3FZPQMvXyeB9DmnlTW+GL7oJfk6
         onaSqRoQvUKUR3+K3jmbRN/wY5pbbzkzaGp0JVODxTKiQNlTdOlYTzTbzXfyGiBOMfb6
         pVYjP6sbFVchsKjKm3XAVTfl9TqCWiMVq6klmESVPxbszDkFIKbTsQWKlBvom9jIz+AX
         DWrM/Q8ooICyhuhPviV4gbrpL3A0xICQhlEwx0cQGPWRJ04BRY5YN4CkxP5gRyIEJo+j
         uIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405252; x=1732010052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGIaBGh/yP1sQaweFYGyz2QSAZYptrOZsvs2Ztr/KZQ=;
        b=wQpl+RFqGFxwKkdHCAD+hB+ItrzKz/v5B+D+KWZDIlaWMnJPbd6JFcqPQUJk181/OV
         cKUh8poxXWsmjsQ+GES3JoZO6IVKDBjKHHPtjQufGc3Y4ZVjwZzghyq+KxZZlSNy78vE
         IS5X5zitC6avXLKTQQKBSd/cqHj5Nj5rIXsTY1v0V5vJHNcgDfkEhJDYPSpHqwcawdM3
         8nATFJO3hPZf8A6Ke5L8ytrXzPjwjYzPzn636bqkD6i9yAb3bgHCMNgZCgyANklnglCg
         JG6R9Q9/gA53dJRMbzkkfTvReurWy7WkCaDRreIpwmklK+qi/cMK17JBWer9FwqgcwBu
         ERDw==
X-Forwarded-Encrypted: i=1; AJvYcCX5vl86jfl7vMlhXqdVPxHIheG0B1eLQtPAaZGWwuz/oFos7Sy4jWQ90XbQO5za1pAaPxRZW70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLKV5jm7cQuN0OaGLJjSNccZ3y/lUdzUADw7EMr6XH1eUUeaC
	XdhGVOUKKi/1/bkWBgZv6YIf1+uqqYB6+78wvs1MOAtnJt0V9FlU
X-Google-Smtp-Source: AGHT+IG5Wrqxv4bHLw27zLZS1M8Al35rTdwdsLWNia07jOV8lVvj7UvKbixX09Uyir8VPy61LzzLyA==
X-Received: by 2002:a05:6a21:3290:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1dc5f982d7emr2438855637.36.1731405252184;
        Tue, 12 Nov 2024 01:54:12 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a57185sm10615980b3a.190.2024.11.12.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:54:11 -0800 (PST)
Date: Tue, 12 Nov 2024 09:54:04 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
Message-ID: <ZzMlvCA4e3YhYTPn@fedora>
References: <20241110081953.121682-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241110081953.121682-1-yuyanghuang@google.com>


Hi Yuyang,

Would you mind also update iproute2 for testing?
On Sun, Nov 10, 2024 at 05:19:53PM +0900, Yuyang Huang wrote:
> This change introduces netlink notifications for multicast address
> changes, enabling components like the Android Packet Filter to implement
> IGMP offload solutions.
> 
> The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET.
> * A new notification group, RTNLGRP_IPV4_MCADDR, is introduced for
>   receiving these events.
> 
> This enhancement allows user-space components to efficiently track
> multicast group memberships and program hardware offload filters
> accordingly.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-mail.com
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>  include/uapi/linux/rtnetlink.h |  6 ++++
>  net/ipv4/igmp.c                | 58 ++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 3b687d20c9ed..354a923f129d 100644
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
> @@ -774,6 +778,8 @@ enum rtnetlink_groups {
>  #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
>  	RTNLGRP_STATS,
>  #define RTNLGRP_STATS		RTNLGRP_STATS
> +	RTNLGRP_IPV4_MCADDR,
> +#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
>  	__RTNLGRP_MAX
>  };
>  #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 9bf09de6a2e7..34575f5392a8 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -88,6 +88,7 @@
>  #include <linux/byteorder/generic.h>
>  
>  #include <net/net_namespace.h>
> +#include <net/netlink.h>
>  #include <net/arp.h>
>  #include <net/ip.h>
>  #include <net/protocol.h>
> @@ -1430,6 +1431,60 @@ static void ip_mc_hash_remove(struct in_device *in_dev,
>  	*mc_hash = im->next_hash;
>  }
>  
> +static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
> +			      __be32 addr, int event)
> +{
> +	struct nlmsghdr *nlh;
> +	struct ifaddrmsg *ifm;
> +
> +	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ifm = nlmsg_data(nlh);
> +	ifm->ifa_family = AF_INET;
> +	ifm->ifa_prefixlen = 32;
> +	ifm->ifa_flags = IFA_F_PERMANENT;
> +	ifm->ifa_scope = RT_SCOPE_LINK;
> +	ifm->ifa_index = dev->ifindex;
> +
> +	if (nla_put_in_addr(skb, IFA_MULTICAST, addr) < 0) {
> +		nlmsg_cancel(skb, nlh);
> +		return -EMSGSIZE;
> +	}
> +
> +	nlmsg_end(skb, nlh);
> +	return 0;
> +}
> +
> +static inline int inet_ifmcaddr_msgsize(void)
> +{
> +	return NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> +			+ nla_total_size(sizeof(__be32));
> +}
> +
> +static void inet_ifmcaddr_notify(struct net_device *dev, __be32 addr, int event)
> +{
> +	struct net *net = dev_net(dev);
> +	struct sk_buff *skb;
> +	int err = -ENOBUFS;
> +
> +	skb = nlmsg_new(inet_ifmcaddr_msgsize(), GFP_ATOMIC);
> +	if (!skb)
> +		goto error;
> +
> +	err = inet_fill_ifmcaddr(skb, dev, addr, event);
> +	if (err < 0) {
> +		WARN_ON(err == -EMSGSIZE);
> +		kfree_skb(skb);
> +		goto error;
> +	}
> +
> +	rtnl_notify(skb, net, 0, RTNLGRP_IPV4_MCADDR, NULL, GFP_ATOMIC);
> +	return;
> +error:
> +	rtnl_set_sk_err(net, RTNLGRP_IPV4_MCADDR, err);
> +}
>  
>  /*
>   *	A socket has joined a multicast group on device dev.
> @@ -1476,6 +1531,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>  	igmpv3_del_delrec(in_dev, im);
>  #endif
>  	igmp_group_added(im);
> +	inet_ifmcaddr_notify(in_dev->dev, addr, RTM_NEWMULTICAST);
>  	if (!in_dev->dead)
>  		ip_rt_multicast_event(in_dev);
>  out:
> @@ -1689,6 +1745,8 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
>  				*ip = i->next_rcu;
>  				in_dev->mc_count--;
>  				__igmp_group_dropped(i, gfp);
> +				inet_ifmcaddr_notify(in_dev->dev, addr,
> +						     RTM_DELMULTICAST);
>  				ip_mc_clear_src(i);
>  
>  				if (!in_dev->dead)
> -- 
> 2.47.0.277.g8800431eea-goog
> 

