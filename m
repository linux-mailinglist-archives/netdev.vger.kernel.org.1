Return-Path: <netdev+bounces-213193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783FB2418B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00A01AA0894
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA92D3A6B;
	Wed, 13 Aug 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZ9GwJy8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439152C08CC
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066547; cv=none; b=T+7hYmKJnzeD2JaLXwEP40BifMBLdP9+kPm4Ddu83lXFE7SrLeGKS/1YU7REkXcc3qFolElLNMzInrQk8z7sUmTMBtJDvLsX0jWIdURGJAKxY9tWG4YSCjBQQw4wfDZ0aewtq5csBaPOTiDR8McXaoft9e5UTbUltox0iQUH1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066547; c=relaxed/simple;
	bh=Ndpd4fViX63OuSONgDNLi8/ENOZtDl+A3WRQ5RxsccA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ayHhrJDULwKFrpfx2QAwtFIERQ/ZXNyEovJAE+bEh8MKtBgxFc1w7PJdZ0rcPHGwu0KK61pfWLuVDCYB26E2ZoRU6dOAdoa5r/6HpJplJhDtomxhviNfaU4Q41/MyAeXt7yIItx8E+flXSv5KZTfL166YuxwW9mKmVJkZTi9q+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZ9GwJy8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32187814ef6so4240223a91.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755066545; x=1755671345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/wtnRfrsaVbGH4q6bRkhzfYhXmUWudmJN2OG+zvJHY=;
        b=FZ9GwJy8nRKzv3d18TPZ+WTxVW/l5jmqLnkjF8axneoVckv8fkS92WgU5QJzOTVPGw
         YoTrYDyk4w7KuFBqESRszjT66dma84DY8Ip/gi9Uu8g+/GUtac+m5UGNBXD4nln1wWOG
         gLKlbJZcQUhR20IK/8pUWnWO+U6lMdY8lKklJ6PAY524Wr/Ky3Ar6M1OdAyQbP3Obq3x
         AHa4c/vVwIKHIzZUKI8G1TbebvyDGJLJLVMMjQetnhdQ7VqNoo1/EH6qoiGuVmSNdtkm
         VAWAvE3wui9x7k2ctqE0+7zajBBVBzQshwQ6xBx2Tk+mttlP5la+I/CRQRFd2CwvBgpx
         ON5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066545; x=1755671345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/wtnRfrsaVbGH4q6bRkhzfYhXmUWudmJN2OG+zvJHY=;
        b=i5uPhWzQbsHac+6J99aiPY1FwCbsh1bRvz4YDq8uldHrMo1grtXVTBIpTxAhNnZPRS
         3ZW1ovz+MVY13H2W7j9E7rTjTaW6svEhnCPIAYk1GwUNTRfVKh1LxmE8Bt5ArC5BtFQ5
         DNXdYn6f7PuPKVxIUSiWLTNd3EisEdvSEtGgVbt0ROYfWeTR++1c6NZN+ZgqSrQQXSxd
         DjXx1eh3mqTu8FmsIE6fWPTN6BvA6hFCEtW6rKbHvw9LFApR8Kk6IaZ8ckr8M83oqBtN
         9QPVvmRL5Ldui7UbaRNDc0PGtdibtbDlbk+wOs0MKkYMFG4uS1FSmLnl1TIUrya6CN0p
         eZvg==
X-Forwarded-Encrypted: i=1; AJvYcCWLg7j5otEz7U178qWLxUP0dTAA94CIldKOVHeoAuFMiPfPs8DiX2WnRtyb0+LmOtwTBQKc+Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcj0P+tJlJgcHEMoNpwk5NMmD9VruHagvJw2EU/ueBSSgbnI5q
	EpuNeAHWuPoj8I3dXochBUBdxq/TP4wYe2Q0bocirGKbWJnJawThvV9U2o+dLdYS0n9+1bfNFQY
	NYk1dYQ==
X-Google-Smtp-Source: AGHT+IE6CZ7Gl3oN1uT1uHwO8rdoLdzBO9tbII/gyYx3TLqItGm6+NetTYhvyVK5xzr8V/PFCd8SDp26a3U=
X-Received: from pjbmf13.prod.google.com ([2002:a17:90b:184d:b0:320:e3e2:6877])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5830:b0:313:352f:6620
 with SMTP id 98e67ed59e1d1-321d0d7dbacmr2741237a91.4.1755066545496; Tue, 12
 Aug 2025 23:29:05 -0700 (PDT)
Date: Wed, 13 Aug 2025 06:28:35 +0000
In-Reply-To: <20250812125155.3808-3-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812125155.3808-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813062904.109300-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
From: Kuniyuki Iwashima <kuniyu@google.com>
To: richardbgobert@gmail.com
Cc: andrew+netdev@lunn.ch, daniel@iogearbox.net, davem@davemloft.net, 
	donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Richard Gobert <richardbgobert@gmail.com>
Date: Tue, 12 Aug 2025 14:51:52 +0200
> Currently, VXLAN sockets always bind to 0.0.0.0, even when a local
> address is defined. This commit adds a netlink option to change
> this behavior.
> 
> If two VXLAN endpoints are connected through two separate subnets,
> they are each able to receive traffic through both subnets, regardless
> of the local address. The new option will break this behavior.
> 
> Disable the option by default.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c     | 43 +++++++++++++++++++++++++++---
>  include/net/vxlan.h                |  1 +
>  include/uapi/linux/if_link.h       |  1 +
>  tools/include/uapi/linux/if_link.h |  1 +
>  4 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index f32be2e301f2..15fe9d83c724 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -3406,6 +3406,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
>  	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
>  	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
>  	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
> +	[IFLA_VXLAN_LOCALBIND]	= NLA_POLICY_MAX(NLA_U8, 1),

Flagging FREEBIND sounds rather NONLOCAL to me.

More specific name would be better.  NON_WILDCARD_BIND ? idk..

$ cat include/net/inet_sock.h
...
static inline bool inet_can_nonlocal_bind(struct net *net,
					  struct inet_sock *inet)
{
	return READ_ONCE(net->ipv4.sysctl_ip_nonlocal_bind) ||
		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
		test_bit(INET_FLAGS_TRANSPARENT, &inet->inet_flags);
}


>  };
>  
>  static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -4044,15 +4045,37 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  		conf->vni = vni;
>  	}
>  
> +	if (data[IFLA_VXLAN_LOCALBIND]) {
> +		if (changelink) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCALBIND], "Cannot rebind locally");
> +			return -EOPNOTSUPP;
> +		}

Are these two "if" necessary ?


> +
> +		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
> +				    VXLAN_F_LOCALBIND, changelink,
> +				    false, extack);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (data[IFLA_VXLAN_GROUP]) {
> +		__be32 addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
> +
>  		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
>  			return -EOPNOTSUPP;
>  		}
>  
> -		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
> +		if ((conf->flags & VXLAN_F_LOCALBIND) && ipv4_is_multicast(addr)) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "Cannot add multicast group when bound locally");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		conf->remote_ip.sin.sin_addr.s_addr = addr;
>  		conf->remote_ip.sa.sa_family = AF_INET;
>  	} else if (data[IFLA_VXLAN_GROUP6]) {
> +		struct in6_addr addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
> +
>  		if (!IS_ENABLED(CONFIG_IPV6)) {
>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
>  			return -EPFNOSUPPORT;
> @@ -4063,7 +4086,12 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  			return -EOPNOTSUPP;
>  		}
>  
> -		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
> +		if ((conf->flags & VXLAN_F_LOCALBIND) && ipv6_addr_is_multicast(&addr)) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "Cannot add multicast group when bound locally");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		conf->remote_ip.sin6.sin6_addr = addr;
>  		conf->remote_ip.sa.sa_family = AF_INET6;
>  	}
>  
> @@ -4071,6 +4099,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
>  			return -EOPNOTSUPP;
> +		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "Cannot change local address when bound locally");
> +			return -EOPNOTSUPP;
>  		}
>  
>  		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
> @@ -4084,6 +4115,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
>  			return -EOPNOTSUPP;
> +		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "Cannot change local address when bound locally");
> +			return -EOPNOTSUPP;
>  		}
>  
>  		/* TODO: respect scope id */
> @@ -4517,6 +4551,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
>  		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
>  		/* IFLA_VXLAN_RESERVED_BITS */
>  		nla_total_size(sizeof(struct vxlanhdr)) +
> +		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBIND */
>  		0;
>  }
>  
> @@ -4596,7 +4631,9 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
>  		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
> -		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
> +		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)) ||
> +	    nla_put_u8(skb, IFLA_VXLAN_LOCALBIND,
> +		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBIND)))
>  		goto nla_put_failure;
>  
>  	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 0ee50785f4f1..e356b5294535 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -333,6 +333,7 @@ struct vxlan_dev {
>  #define VXLAN_F_MDB			0x40000
>  #define VXLAN_F_LOCALBYPASS		0x80000
>  #define VXLAN_F_MC_ROUTE		0x100000
> +#define VXLAN_F_LOCALBIND		0x200000
>  
>  /* Flags that are used in the receive path. These flags must match in
>   * order for a socket to be shareable
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 784ace3a519c..7350129b1444 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1399,6 +1399,7 @@ enum {
>  	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
>  	IFLA_VXLAN_RESERVED_BITS,
>  	IFLA_VXLAN_MC_ROUTE,
> +	IFLA_VXLAN_LOCALBIND,
>  	__IFLA_VXLAN_MAX
>  };
>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> index 7e46ca4cd31b..eee934cc2cf4 100644
> --- a/tools/include/uapi/linux/if_link.h
> +++ b/tools/include/uapi/linux/if_link.h
> @@ -1396,6 +1396,7 @@ enum {
>  	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
>  	IFLA_VXLAN_LOCALBYPASS,
>  	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
> +	IFLA_VXLAN_LOCALBIND,
>  	__IFLA_VXLAN_MAX
>  };
>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
> -- 
> 2.36.1

