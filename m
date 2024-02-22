Return-Path: <netdev+bounces-74086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1B85FE2D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210541C24BF8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32E14901A;
	Thu, 22 Feb 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VOvVeI5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD515350A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619813; cv=none; b=tFI1EU1tB9snQmQxp/VyKZR7NZ1U8P0j54ea5BAsgvYbl3dK7QIc7YKVSBQyihgDU5+wb0xnlmE/9zzySmWycsYyf/G2nnSVL3I62fotbgCcV37TXTd+Oq12mhmarFjUlmTJ3rFFfvcQonBpeizUlZDoa34X/Ahp2qK+rMIlXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619813; c=relaxed/simple;
	bh=45cyQcjmhRy3gC09gdt3uxkq/gg+VPxDAJ5EXPJn4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRRRqSMkbZYr+nm2G6Bn2EBCsupCdQLPnWpBD3YLJmlcXCU/JCnKd87w/SwSsMm5hZXuspvP/Jha8Yk65dlkb76ET1w19Zgu2QkGf4uZhFFFrsdZd5Q9BwM6NEN5/p+5Dx0eeD4oGGKKqGUvJ1CU/goGajKssFysoM/nGtq7Fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VOvVeI5N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d61e39912so2246480f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708619809; x=1709224609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p43g6abAYVqOtWZcL/rV9r/twd2JxFtpdL9xqR4azUU=;
        b=VOvVeI5NTbt7htNPwDwfiP0ni0/wGRMl4QoenR1+8jiRAfY6A3jb/Nsgn3GwM3ofKN
         d7P5J94upbZMXxdXRLR35mAzs17M2yVEWmToisC7W0EqB2fiRN4uYZZL7lZnUW7CKD7L
         x6/TUdutqZhpEXfhmrkarJphjB/b5h88qF4GFmv8/EAmkLSMMioPDhb2wBTf8h33pJgZ
         ePoOT2vDMwh9Enu2IRGJyLGO56PtqtBwV22sjlSaK+Yn7LJS2TyyzTMa5kw69T1JSUDt
         A/yWVJIgAnNJh6teXyx3Gwom9TyGS8HK9UMlv4fCdDUaTjwHwAFtJw68Qw/fiv00dmH3
         jrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619809; x=1709224609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p43g6abAYVqOtWZcL/rV9r/twd2JxFtpdL9xqR4azUU=;
        b=YoCRJGLWWwfvvpHQ1rNOx/6LWWq8FunLRl+2UYFJNQfEoIP22UXg86ZRSJoRx9aF7Z
         o0FeQHyXvCFQy0X0I9Glr0kbWihQjxAH4m7X0DU8ejRh/WZnpm87/v/xnwJ9706pdcTj
         Q49t049ZQMpIbgENCBDgFtUgQpmusugWjv8TN6Xr7feQc3o93fj6X2biAAla8j7WR1Yw
         qlVsQ7A7wnHwVpkEkjB/cNfCfE9GiV5YQUBTKBIaFDuMAa2SrwmJa3UeNMb4uxim9Yqn
         qIgRUjeD9XB246DLc1dLKw4V7MliUECLjpBeXHQ6iAakUpr3Fss1FqLRlGNlJjk4Ro0T
         SaPA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/TR3xqx1qaqBI+O7p/f00J1Jq9wJxl+U1CrFWdefvywuMvMuLfVfhap9+wCcRh1/2LLA79bAYk5xgI+XbbV32DcT4/oU
X-Gm-Message-State: AOJu0YxvPTcClJLXO9N7SYXx2zT8t501oiZSywSwwdK6huvW4nzdYSnW
	4TgRknvdgmmx1QpQ/Ebb1rf1F/0+UOMvwe5rspktUNEtGnVCVh8IjOOVFNb5ydA=
X-Google-Smtp-Source: AGHT+IEhAz/xlFPoqotRr50PhWp/ZwJoIVBgI9Bjm1NOrMoP6YYdYz5sVkNguk370E+yp5i9j01wdw==
X-Received: by 2002:adf:ffc3:0:b0:33d:3ff4:230e with SMTP id x3-20020adfffc3000000b0033d3ff4230emr9540854wrs.32.1708619809156;
        Thu, 22 Feb 2024 08:36:49 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0033d202abf01sm6237826wrb.28.2024.02.22.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:36:48 -0800 (PST)
Date: Thu, 22 Feb 2024 17:36:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 03/14] ipv6: prepare inet6_fill_ifinfo() for
 RCU protection
Message-ID: <Zdd4HbfO2Bn9dfuz@nanopsycho>
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222105021.1943116-4-edumazet@google.com>

Thu, Feb 22, 2024 at 11:50:10AM CET, edumazet@google.com wrote:
>We want to use RCU protection instead of RTNL

Is this a royal "We"? :)


>for inet6_fill_ifinfo().

This is a motivation for this patch, not what the patch does.

Would it be possible to maintain some sort of culture for the patch
descriptions, even of the patches which are small and simple?

https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes

Your patch descriptions are usually hard to follow for me to understand
what the patch does :( Yes, I know you do it "to displease me" as you
wrote couple of months ago but maybe think about the others too, also
the ones looking in a git log/show and guessing.

Don't beat me.


>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> include/linux/netdevice.h |  6 ++++--
> net/core/dev.c            |  4 ++--
> net/ipv6/addrconf.c       | 11 +++++++----
> 3 files changed, 13 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index f07c8374f29cb936fe11236fc63e06e741b1c965..09023e44db4e2c3a2133afc52ba5a335d6030646 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -4354,8 +4354,10 @@ static inline bool netif_testing(const struct net_device *dev)
>  */
> static inline bool netif_oper_up(const struct net_device *dev)
> {
>-	return (dev->operstate == IF_OPER_UP ||
>-		dev->operstate == IF_OPER_UNKNOWN /* backward compat */);
>+	unsigned int operstate = READ_ONCE(dev->operstate);
>+
>+	return	operstate == IF_OPER_UP ||

double space  ^^


>+		operstate == IF_OPER_UNKNOWN /* backward compat */;
> }
> 
> /**
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 0628d8ff1ed932efdd45ab7b79599dcfcca6c4eb..275fd5259a4a92d0bd2e145d66a716248b6c2804 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -8632,12 +8632,12 @@ unsigned int dev_get_flags(const struct net_device *dev)
> {
> 	unsigned int flags;
> 
>-	flags = (dev->flags & ~(IFF_PROMISC |
>+	flags = (READ_ONCE(dev->flags) & ~(IFF_PROMISC |
> 				IFF_ALLMULTI |
> 				IFF_RUNNING |
> 				IFF_LOWER_UP |
> 				IFF_DORMANT)) |
>-		(dev->gflags & (IFF_PROMISC |
>+		(READ_ONCE(dev->gflags) & (IFF_PROMISC |
> 				IFF_ALLMULTI));
> 
> 	if (netif_running(dev)) {
>diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>index 3c8bdad0105dc9542489b612890ba86de9c44bdc..df3c6feea74e2d95144140eceb6df5cef2dce1f4 100644
>--- a/net/ipv6/addrconf.c
>+++ b/net/ipv6/addrconf.c
>@@ -6047,6 +6047,7 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
> 	struct net_device *dev = idev->dev;
> 	struct ifinfomsg *hdr;
> 	struct nlmsghdr *nlh;
>+	int ifindex, iflink;
> 	void *protoinfo;
> 
> 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*hdr), flags);
>@@ -6057,16 +6058,18 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
> 	hdr->ifi_family = AF_INET6;
> 	hdr->__ifi_pad = 0;
> 	hdr->ifi_type = dev->type;
>-	hdr->ifi_index = dev->ifindex;
>+	ifindex = READ_ONCE(dev->ifindex);
>+	hdr->ifi_index = ifindex;
> 	hdr->ifi_flags = dev_get_flags(dev);
> 	hdr->ifi_change = 0;
> 
>+	iflink = dev_get_iflink(dev);
> 	if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
> 	    (dev->addr_len &&
> 	     nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr)) ||
>-	    nla_put_u32(skb, IFLA_MTU, dev->mtu) ||
>-	    (dev->ifindex != dev_get_iflink(dev) &&
>-	     nla_put_u32(skb, IFLA_LINK, dev_get_iflink(dev))) ||
>+	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
>+	    (ifindex != iflink &&
>+	     nla_put_u32(skb, IFLA_LINK, iflink)) ||
> 	    nla_put_u8(skb, IFLA_OPERSTATE,
> 		       netif_running(dev) ? READ_ONCE(dev->operstate) : IF_OPER_DOWN))
> 		goto nla_put_failure;
>-- 
>2.44.0.rc1.240.g4c46232300-goog
>
>

