Return-Path: <netdev+bounces-148990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307C29E3BDE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594F4B2B156
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0851F7099;
	Wed,  4 Dec 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="U+81DrCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA31F6684
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320444; cv=none; b=Tit90uodlEsgu7r7GgvhagUCMKhrNeEOhNQ3FWKd/isjLMXrZf6zS/XDrlsPJKkWJ1pPe6ZyqfqQMm1PAHpgulhFHVTJmycwUJfBqtHgTuFvq9K7m0eXsvqtDGIkPV3yVnp5R9lg6z+09s+Of0XuLc8sh2DXcOqhHIKmPq1f5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320444; c=relaxed/simple;
	bh=uAjKjZ4aC6hicfnsk0dKxa1p2AiozqgzntLPVNq4eds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQaKQEfYndghSkaQ/NCPTmJ6j6l9ojZE2/tPR672m5VprCKkeP4PDkZbCNbmrDwg0P8ti0WiZQox9sP7FIf4hYtP4bCmNWXwgpK4S5EjfJyuSMJTXBYpJVKeSbi1xFCgaobBmco2lzuauryIbZ+/QFI7kB12k20JiBk/4Ro45B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=U+81DrCK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a12d106dso6926955e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 05:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1733320440; x=1733925240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+hm6D15gw4OTiZ1EhthOjCIyfPVkJABD8NDDpIYFOps=;
        b=U+81DrCKiimZ0qPRVl5ZfqJNWWbyWnhT9ejzJVN6S37x2+Eg1TMUpHK1PQUyO4TTN0
         a5ePzWW3jzd8QVHW+PzccIbPh5kc/GUKJ05FxsNw2/PNk42fWzCCQPrwqKh9N6iJPr3F
         nIx1/zjnp0BBhI4fZ+LW/p08OPfk6f8A4kQpPTtuo4xmBA75zR4iaAnysq1BzzFy/nlh
         ERE2ribPGYUQQ3vtaczsPRg6fMWZC3D2BGyOxqD/Uflybdm6CRQH4t1mQVi1fW53XbUM
         LvsRVfVM5c5MllbRJcu0sqFZM2aBt8B0+EsD0Zy/v66SfWcgfMi2B9LGxWEDCglu9QcI
         aHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320440; x=1733925240;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hm6D15gw4OTiZ1EhthOjCIyfPVkJABD8NDDpIYFOps=;
        b=X3Vv0519mRKek1V2hPn8lv5+4+0+gag/i+Sv5TGQuGt5DbdLvZUXlv5EXjRCt/k/jg
         OfjI2sxHjwT9ssVwNGuGNa7CPDwU36/TQEXLlsjzHY8Uk4QONmKZwsDLb5+FZPQX/SgR
         qjAKvMlzLo0xXp17fUaWak3zwLmomCXhu9bsDp8UJcQ0sjehaN8w39PSxpDN/865dEMk
         lmfA73Am/Or2PBG23rZXNr2aibXakhn/i1J4vBuDqkbPZD5bmiq4fyVfFNnKDvOPsauY
         6eKBFOFhD53pSqsneMx0kC2FOY1mkmJw4dIgjcMD0bBWZ11eUL793ZK1b2DMgG3YQBLa
         3W+A==
X-Forwarded-Encrypted: i=1; AJvYcCVbUdX+9gzugsraxjWiaUTZPnLNrxgbpOGWlCGb3yclHsMUT9ZRAfy3D54SsuVCbcbJxBgv4ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4nBNwYqDJhl3V2fnj7BDXw7SFH9r459ngodd/Oi+djfrh1LK
	mlBPOiEuBl+rg+Me/yL7Skbg3AaByqJfjKSA0IKnNdicdFaPwFCtsqVW/DHV/Wc=
X-Gm-Gg: ASbGncvPeAyBDfIPOnEK1FHo9P4WBD9/ROZRmu+Gm5Dxcxl9Vg+9DP/SFZDXLZyI/5A
	TkKdyru4rZSJsUqIOc9pHUEp/rxuM/pD9SndujsQrsMfcizUHAvqmwnAWePddeUlV/P/TZU40IV
	ikryrIikHlqrZNQt3m7rl2ea5tcvb5151rVN9PNhLzFhLpQzu0t9d+wt8nhv1WTMVBbFz98dxdW
	suu9LM8u8XDYGL7Nz9c3xlxP05Ndc8LSYYVNH1OyShdL/gS/17ZC5XYnc9OZT9eTRrs2dk+jol2
	ACZSKnp99dQOuay5ZiZJwEG1/oA=
X-Google-Smtp-Source: AGHT+IFnQYyNFVGGRPUUc1Vm8iqJ0VENXrdiLyrwgG0E0N1oHUVSngwfTKdOCbK54VS/NBtPZ3TPGw==
X-Received: by 2002:a05:600c:350a:b0:434:9dcb:2f85 with SMTP id 5b1f17b1804b1-434d16dcadfmr20196095e9.0.1733320440614;
        Wed, 04 Dec 2024 05:54:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:f6c0:3ce8:653e:656c? ([2a01:e0a:b41:c160:f6c0:3ce8:653e:656c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d528ab4esm24814775e9.26.2024.12.04.05.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:54:00 -0800 (PST)
Message-ID: <6cb2b3e2-d3ce-427e-9809-5b81474b80e4@6wind.com>
Date: Wed, 4 Dec 2024 14:53:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next, v4] netlink: add IGMP/MLD join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>,
 Patrick Ruddy <pruddy@vyatta.att-mail.com>
References: <20241204134752.2691102-1-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241204134752.2691102-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/12/2024 à 14:47, Yuyang Huang a écrit :
> This change introduces netlink notifications for multicast address
> changes. The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
>   AF_INET6.
> * Two new notification groups: RTNLGRP_IPV4_MCADDR and
>   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> 
> This change allows user space applications (e.g., ip monitor) to
> efficiently track multicast group memberships by listening for netlink
> events. Previously, applications relied on inefficient polling of
> procfs, introducing delays. With netlink notifications, applications
> receive realtime updates on multicast group membership changes,
> enabling more precise metrics collection and system monitoring. 
> 
> This change also unlocks the potential for implementing a wide range
> of sophisticated multicast related features in user space by allowing
> applications to combine kernel provided multicast address information
> with user space data and communicate decisions back to the kernel for
> more fine grained control. This mechanism can be used for various
> purposes, including multicast filtering, IGMP/MLD offload, and
> IGMP/MLD snooping.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-mail.com
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

A minor comment below and then:
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

> ---
> 
> Changelog since v3:
> - Remove unused variable 'scope' declaration.
> - Align RTM_NEWMULTICAST and RTM_GETMULTICAST enum definitions with
>   existing code style.
> 
> Changelog since v2:
> - Use RT_SCOPE_UNIVERSE for both IGMP and MLD notification messages for
>   consistency.
> 
> Changelog since v1:
> - Implement MLD join/leave notifications.
> - Revise the comment message to make it generic.
> - Fix netdev/source_inline error.
> - Reorder local variables according to "reverse xmas tree” style.
> 
>  include/uapi/linux/rtnetlink.h | 10 +++++-
>  net/ipv4/igmp.c                | 53 +++++++++++++++++++++++++++++++
>  net/ipv6/mcast.c               | 57 ++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index db7254d52d93..eccc0e7dcb7d 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -93,7 +93,11 @@ enum {
>  	RTM_NEWPREFIX	= 52,
>  #define RTM_NEWPREFIX	RTM_NEWPREFIX
>  
> -	RTM_GETMULTICAST = 58,
> +	RTM_NEWMULTICAST = 56,
> +#define RTM_NEWMULTICAST RTM_NEWMULTICAST
> +	RTM_DELMULTICAST,
> +#define RTM_DELMULTICAST RTM_DELMULTICAST
> +	RTM_GETMULTICAST,
>  #define RTM_GETMULTICAST RTM_GETMULTICAST
>  
>  	RTM_GETANYCAST	= 62,
> @@ -774,6 +778,10 @@ enum rtnetlink_groups {
>  #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
>  	RTNLGRP_STATS,
>  #define RTNLGRP_STATS		RTNLGRP_STATS
> +	RTNLGRP_IPV4_MCADDR,
> +#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
> +	RTNLGRP_IPV6_MCADDR,
> +#define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
>  	__RTNLGRP_MAX
>  };
>  #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 6a238398acc9..8d6ee19864c6 100644
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
> @@ -1430,6 +1431,55 @@ static void ip_mc_hash_remove(struct in_device *in_dev,
>  	*mc_hash = im->next_hash;
>  }
>  
> +static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
> +			      __be32 addr, int event)
> +{
> +	struct ifaddrmsg *ifm;
> +	struct nlmsghdr *nlh;
> +
> +	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ifm = nlmsg_data(nlh);
> +	ifm->ifa_family = AF_INET;
> +	ifm->ifa_prefixlen = 32;
> +	ifm->ifa_flags = IFA_F_PERMANENT;
> +	ifm->ifa_scope = RT_SCOPE_UNIVERSE;
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
> +static void inet_ifmcaddr_notify(struct net_device *dev, __be32 addr, int event)
> +{
> +	struct net *net = dev_net(dev);
> +	struct sk_buff *skb;
> +	int err = -ENOBUFS;
> +
> +	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
> +			+ nla_total_size(sizeof(__be32)), GFP_ATOMIC);
> +	if (!skb)
> +		goto error;
> +
> +	err = inet_fill_ifmcaddr(skb, dev, addr, event);
> +	if (err < 0) {
> +		WARN_ON(err == -EMSGSIZE);
Maybe WARN_ON_ONCE() is enough?


Regards,
Nicolas

