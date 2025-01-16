Return-Path: <netdev+bounces-158851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1652A1388A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1685116708C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565451A0BF3;
	Thu, 16 Jan 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGd+oeIi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4F24A7C2
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025618; cv=none; b=UrQduJ8DhA1BwWl+5c7ODmRTB3kG2p5D5Ud4y1fflsEdOcniXNCGGM4ZBdjDu/Nhcmh29kGdm/lTNzLdFg3dXnHr3D1Tn/cax85oNT09jjhDK3BJNl5p9Iw85MQoLsvCscTu7oAVqvUP1b0iLWWGeqjTcGmDFwTBKGOXt+E9riA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025618; c=relaxed/simple;
	bh=qKp3z4JMpyxDHEXYbnRXOikDAhQI5tqr+HNr1d1Knmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaAaDooYDAVf8w6ouaSWKi3lQDreXJ1ffZzCTfbjcTN1anl+oyfsM7MNNtHlz++odgPbPajd8C16nbIvEnmaB0awQDjP2vyurIPy+MM/6lwcIkSWCPjq+RZna21h7cgFLtSdWQtzzzFRbbufTWnycJJGWXZ1l4wknQRbcZ8OENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGd+oeIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737025614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv7HOWzACKVg2N6gWvqQyDjzpd3I4hP/eBlBaHF3gw0=;
	b=HGd+oeIiHkh1TsCv8YEScLwcYmqo+9Rg+z8e+MtD4Tbudz2J2eMw6Bjl3ShQCWfE1wXjwE
	xZY9nrE64tm6dm9j0U/Khu7HcLvJm/y9RSGCrDRlU+e9vfe4vSxQXNYlKohaGCZg+yWoyr
	bHSkh8NB/Q2kzY0kvBiVYFWicF0Mn7s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-TjYBRzFuPv69lvlARtIykg-1; Thu, 16 Jan 2025 06:06:53 -0500
X-MC-Unique: TjYBRzFuPv69lvlARtIykg-1
X-Mimecast-MFC-AGG-ID: TjYBRzFuPv69lvlARtIykg
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5da0ce0ee51so764023a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 03:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737025612; x=1737630412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv7HOWzACKVg2N6gWvqQyDjzpd3I4hP/eBlBaHF3gw0=;
        b=vAvSltKMDYTu/fpb9VN92ab6WYUhLcPj95fXUh1C0XbFGwKrVc4uaCqBMKAq0PG+7l
         ZZPm6U9/9u1Nm5UYTnKzzu43w0hHipdOMZ5upidz7kLlQW9iwGRXnJo7PTpEIcXzDaxs
         L/arjkWEclWhlLYiiCWdqL1LDuS6FNRKgA1jj49GwIgWlYTzxa4k5WXCuuqxCK3mvmlE
         1MnejkNOTyzyS4OjYPvX5WDqmAypWAuazN+EgoavPXa3w4tNIDzk4DQQQTdpPsvARcv/
         5tDb4nsvpBchKboMLsXYRXNor38wbSPEO12IAFEli9dXyKX5U5OZ7+PVm74punXr/1fS
         KRAA==
X-Forwarded-Encrypted: i=1; AJvYcCW2uva0jaZzxwDNOjAm910hQHnDYY+tyPsNT2JwvPxxktzHrmLmU2g6Wk+LB1b9lziWJXIkxAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUnqBke6nWZmcAqKAH3sy4/rEJjDNFyDeLrniKclXmJbxf8X4
	gdEPuEN/5C5k4aYEhdXYN/nvvRnVBvhjjYtf5vSdgcFnMCvNZl6Xny9DSk44MWgNb2EYNcE0k5N
	kZMFpvT7fNCf4YW4bC1a4TyFTdDkPrSK+Te0Wb3ELcy+kL9DX5SwAgA==
X-Gm-Gg: ASbGncvV678OWPLhglwiowzA8Peg9UMHtug1yyqB/yQoGY6GHO6JFNzzdfzWi5HYutL
	vSqPZ1IfsGbqqDFHMrF08H1OEMTkFn59nu2YN3QJWXre5a1zBny+UQRhK0QZrdQtogAzjUAH2W5
	w91AGEIMOy43Kh6/VRaggGDv1eed1Y5KwOx9VBTafGjojoU5PMqb7wraIBqhDxi30z6tZCIb8HR
	CROqPjs2r2zaj/QxwEb3PyVUJLaK0hMGE78wDMf11wbWydSyienZuBpwTeRlSMgBazXJ4xAIpX5
	CazfZ6IfrAg=
X-Received: by 2002:a05:6402:5006:b0:5d0:e877:7664 with SMTP id 4fb4d7f45d1cf-5d972e178f7mr30235232a12.19.1737025611945;
        Thu, 16 Jan 2025 03:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7+1RB3gyXIWLD3nNejq2NNpqGy7IPwbFJtkBypkOw2c2WJ5RjMN+wDjebJUHhRLb+a4Bx7A==
X-Received: by 2002:a05:6402:5006:b0:5d0:e877:7664 with SMTP id 4fb4d7f45d1cf-5d972e178f7mr30235204a12.19.1737025611530;
        Thu, 16 Jan 2025 03:06:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm8627534a12.21.2025.01.16.03.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:06:51 -0800 (PST)
Message-ID: <b7305f0a-fe4d-4dd4-aaaf-77a08fd919ac@redhat.com>
Date: Thu, 16 Jan 2025 12:06:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v5] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250114023740.3753350-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250114023740.3753350-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 3:37 AM, Yuyang Huang wrote:
> Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> addresses, in addition to the existing IPv6 functionality. This allows
> userspace applications to retrieve both IPv4 and IPv6 multicast
> addresses through similar netlink command and then monitor future
> changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
> 
> This change includes a new ynl based selftest case. To run the test,
> execute the following command:
> 
> $ vng -v --user root --cpus 16 -- \
>     make -C tools/testing/selftests TARGETS=net \
>     TEST_PROGS=rtnetlink.py TEST_GEN_PROGS="" run_tests

Thanks for including the test!

> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 0d492500c7e5..7dcd5fddac9d 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -92,6 +92,41 @@ definitions:
>        -
>          name: ifi-change
>          type: u32
> +  -
> +    name: ifaddrmsg
> +    type: struct
> +    members:
> +      -
> +        name: ifa-family
> +        type: u8
> +      -
> +        name: ifa-prefixlen
> +        type: u8
> +      -
> +        name: ifa-flags
> +        type: u8
> +      -
> +        name: ifa-scope
> +        type: u8
> +      -
> +        name: ifa-index
> +        type: u32
> +  -
> +    name: ifacacheinfo
> +    type: struct
> +    members:
> +      -
> +        name: ifa-prefered
> +        type: u32
> +      -
> +        name: ifa-valid
> +        type: u32
> +      -
> +        name: cstamp
> +        type: u32
> +      -
> +        name: tstamp
> +        type: u32
>    -
>      name: ifla-bridge-id
>      type: struct
> @@ -2253,6 +2288,18 @@ attribute-sets:
>        -
>          name: tailroom
>          type: u16
> +  -
> +    name: ifmcaddr-attrs
> +    attributes:
> +      -
> +        name: addr
> +        type: binary
> +        value: 7
> +      -
> +        name: cacheinfo
> +        type: binary
> +        struct: ifacacheinfo
> +        value: 6
>  
>  sub-messages:
>    -
> @@ -2493,6 +2540,29 @@ operations:
>          reply:
>            value: 92
>            attributes: *link-stats-attrs
> +    -
> +      name: getmaddrs
> +      doc: Get / dump IPv4/IPv6 multicast addresses.
> +      attribute-set: ifmcaddr-attrs
> +      fixed-header: ifaddrmsg
> +      do:
> +        request:
> +          value: 58
> +          attributes:
> +            - ifa-family
> +            - ifa-index
> +        reply:
> +          value: 58
> +          attributes: &mcaddr-attrs
> +            - addr
> +            - cacheinfo
> +      dump:
> +        request:
> +          value: 58
> +            - ifa-family
> +        reply:
> +          value: 58
> +          attributes: *mcaddr-attrs
>  
>  mcast-groups:
>    list:

IMHO the test case itself should land to a separate patch.

> diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> index 073b30a9b850..a460e1ef0524 100644
> --- a/include/linux/igmp.h
> +++ b/include/linux/igmp.h
> @@ -16,6 +16,7 @@
>  #include <linux/ip.h>
>  #include <linux/refcount.h>
>  #include <linux/sockptr.h>
> +#include <net/addrconf.h>
>  #include <uapi/linux/igmp.h>
>  
>  static inline struct igmphdr *igmp_hdr(const struct sk_buff *skb)
> @@ -92,6 +93,16 @@ struct ip_mc_list {
>  	struct rcu_head		rcu;
>  };
>  
> +struct inet_fill_args {
> +	u32 portid;
> +	u32 seq;
> +	int event;
> +	unsigned int flags;
> +	int netnsid;
> +	int ifindex;
> +	enum addr_type_t type;
> +};

Why moving the struct definition here? IMHO addrconf.h is better suited
and will avoid additional headers dep.

> @@ -1874,6 +1894,23 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
>  	return err;
>  }
>  
> +static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
> +			    struct netlink_callback *cb, int *s_ip_idx,
> +			    struct inet_fill_args *fillargs)
> +{
> +	switch (fillargs->type) {
> +	case UNICAST_ADDR:
> +		fillargs->event = RTM_NEWADDR;

I think that adding an additional argument for 'event' to
inet_dump_addr() would simplify the code a bit.

> +		return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fillargs);
> +	case MULTICAST_ADDR:
> +		fillargs->event = RTM_GETMULTICAST;
> +		return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
> +					    fillargs);
> +	default:
> +		return 0;

Why not erroring out on unknown types? should never happen, right?

> @@ -1949,6 +1987,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
>  	return err;
>  }
>  
> +static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	enum addr_type_t type = UNICAST_ADDR;
> +
> +	return inet_dump_addr(skb, cb, type);

You can avoid the local variable usage.

> +}
> +
> +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	enum addr_type_t type = MULTICAST_ADDR;
> +
> +	return inet_dump_addr(skb, cb, type);

Same here.

Thanks!

Paolo


