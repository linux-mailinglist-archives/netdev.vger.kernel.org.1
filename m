Return-Path: <netdev+bounces-213416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3F8B24E68
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463B417F2C5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094CD289350;
	Wed, 13 Aug 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdu+RhgH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5FF286898;
	Wed, 13 Aug 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100018; cv=none; b=Tf86VFHq+Q7SzdtWho880VEGkb+/PH2YfXZZr4QzmH7rM3FT/VckysJA5WMpus83RHmW6LKT35IQIQ+GQf2zgw2rnau8sPZNzt4Cnh/rJFocarJJ4RqvJQDpcjrJ73BcubwCHdJpmfF9sF7tN1xjPDWSkinwa1VhNTJW7PhY9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100018; c=relaxed/simple;
	bh=6v1ojEw/jNsIshlRh8AFAXmDi+4TnVDbN3zXk+OPfAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvx0Wji5rFk5p+Sz0LPXfeqvJngPSYwUaOuYteTSttle+v0fDSpo6AHZieJK8FnTbN7qKMtVXGrK4JV5Egi9pZ+q8fIVBmY3c1cb+iZRebPRwsmEnphZyr7KD/R0qVF7RXwL7aw1zQgIVPNE3d/zSEn9QVO6qoLzfipCVOgIqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdu+RhgH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9141866dcso1186133f8f.2;
        Wed, 13 Aug 2025 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100015; x=1755704815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5gdfUq+mJxhLWblW/OQp9aWlOU7WHgn/nqVMvHooh4=;
        b=Gdu+RhgHKBUGDqegMrA1yehcOqoiv7o9VPsi9BqZ8amUBigGlsGDKtMHSnqOFQ189n
         KhaswDH4oUWHIJ+EpxqS6mJP92iEmQU/3FzqCIH6NOSKwAuPPYwaZBfIPfVrig3D8cD5
         D6kA9bCbkYGz22CvH/NORcqpLDKth3qdOscZ4YToVRqie1X1x9Xm+bZxtyIgygK5blh8
         35sNh5+AdOIscRMn39Uh4+4/lRmXztM9jQWVoXyOMmh361l7zcgL5S61KquLkg5h6P+Q
         ayJX5FgbWns5p3rG4SK+oA/zeQFB5BdSYuA+LwdzlaR0fh0i3FIkj8jLqceY7+MOuiAG
         1jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100015; x=1755704815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5gdfUq+mJxhLWblW/OQp9aWlOU7WHgn/nqVMvHooh4=;
        b=dSwsNmVBybXtetSq+TY0AowjU5PAJlv76lyt5rqRRZ0MZNkbYEIEwuvkoK5KG92Sfd
         33Bk+zSEt3bgH3Xom/AOtL6qrAk7OrnLVcAEF3+jMb17nIDbQXaFlKfLjSodMbCFQneG
         um0ZxU0rucuJF23cCzev3wMiyocEBpEDcse5iBN96n8p9w92mYXj2msoQhuzLpyLKLGd
         f9CUsVh3AGUpbw6qWWr1hRf9C4W7mf654H8a99x6gcGp5Hnvl+yvUIZ2ThHwXMxNfhb8
         Ln/yV+pQXcEdMA/IBhL6hJxKZ9cFQtT+eeDS8gR8O6A0s4U5aZ2wAk+9aGu8nOaDzTjG
         Rrrw==
X-Forwarded-Encrypted: i=1; AJvYcCVMLWFMoM6LUQvYcfkcOt+MlSeXBkjYwx1ITpI7VtTF6zFIZqJmpphr+Ha2mp0KMGgul3KsfIGyZEUEwWo=@vger.kernel.org, AJvYcCWqO7IF92NnOSAfdqCi3mMvtpUCMDb7GQhzKz3ANICuTtetxlel/mJ36XiAsh/HddKunO/2Gk5v@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpyuHhKaXlKb8/1DfFJT/C9WpXuTJo05RT9t3BbvgMM5YY/sU
	UkUHbfj4dNudkfZ5c189kUwL2xTMIxUkiIE7lQZOMuguURqZtVQhAlOT
X-Gm-Gg: ASbGnctfh2kdFsYcK4Rchk74VUdfz+tZymvvQ21d1pL64Cn0+RyWnXbh21t5PybcJGj
	561q/oUqqubdUpPrG41a9tWbdBLOQbPapvM2cbxwSviJvwF5G040igQ/FEewmCHlFPQUKyTsBMm
	8Te/vHGxlbJ2kn1ccBJ+IcK6bM2oNHnJ1VnL+wmgvdMAqm83VqzxVDhn9fCmzXsQAhjXfMvK3Mc
	6vDxPE2uwhH2KG4f+uTsPEKowVonHcFUbLjZj32+DB4UPTmmt6subVB5XfC3yrD7TfKVWvlpD9/
	GDcgDTDWcwrcXR7a/09H6Gsg5x7T8OwGGUqZ9ZM/Sc2Y/0GY6ba3hP+iGPEJzSSZGhZQVSc82GD
	aIdF9f9uEW47nvMmaCz3qoOPMpaRMCGwZpzKhiDM2A37/
X-Google-Smtp-Source: AGHT+IEQq5IThXEnL5slQftZOSWtXUgt33Lqk9J8t2I7aMMw7CGMx1om7TdukpaPj0t08jqb5tBh7A==
X-Received: by 2002:a05:6000:40df:b0:3b7:8a28:3e35 with SMTP id ffacd0b85a97d-3b917d2aa13mr2950255f8f.2.1755100015119;
        Wed, 13 Aug 2025 08:46:55 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a594e45sm6383155e9.26.2025.08.13.08.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:46:54 -0700 (PDT)
Message-ID: <799c2171-7b41-4202-9ea4-e28952f81a65@gmail.com>
Date: Wed, 13 Aug 2025 17:46:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, daniel@iogearbox.net, davem@davemloft.net,
 donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
References: <20250812125155.3808-3-richardbgobert@gmail.com>
 <20250813062904.109300-1-kuniyu@google.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250813062904.109300-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Richard Gobert <richardbgobert@gmail.com>
> Date: Tue, 12 Aug 2025 14:51:52 +0200
>> Currently, VXLAN sockets always bind to 0.0.0.0, even when a local
>> address is defined. This commit adds a netlink option to change
>> this behavior.
>>
>> If two VXLAN endpoints are connected through two separate subnets,
>> they are each able to receive traffic through both subnets, regardless
>> of the local address. The new option will break this behavior.
>>
>> Disable the option by default.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  drivers/net/vxlan/vxlan_core.c     | 43 +++++++++++++++++++++++++++---
>>  include/net/vxlan.h                |  1 +
>>  include/uapi/linux/if_link.h       |  1 +
>>  tools/include/uapi/linux/if_link.h |  1 +
>>  4 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index f32be2e301f2..15fe9d83c724 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -3406,6 +3406,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
>>  	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
>>  	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
>>  	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
>> +	[IFLA_VXLAN_LOCALBIND]	= NLA_POLICY_MAX(NLA_U8, 1),
> 
> Flagging FREEBIND sounds rather NONLOCAL to me.
> 
> More specific name would be better.  NON_WILDCARD_BIND ? idk..
> 
> $ cat include/net/inet_sock.h
> ...
> static inline bool inet_can_nonlocal_bind(struct net *net,
> 					  struct inet_sock *inet)
> {
> 	return READ_ONCE(net->ipv4.sysctl_ip_nonlocal_bind) ||
> 		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
> 		test_bit(INET_FLAGS_TRANSPARENT, &inet->inet_flags);
> }
> 
> 
>>  };
>>  
>>  static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
>> @@ -4044,15 +4045,37 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>>  		conf->vni = vni;
>>  	}
>>  
>> +	if (data[IFLA_VXLAN_LOCALBIND]) {
>> +		if (changelink) {
>> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCALBIND], "Cannot rebind locally");
>> +			return -EOPNOTSUPP;
>> +		}
> 
> Are these two "if" necessary ?

Creating a vxlan interface without localbind then adding localbind won't
result in the socket being rebound. I might implement this in the future,
but for simplicity, I didn't implement this yet.

> 
> 
>> +
>> +		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
>> +				    VXLAN_F_LOCALBIND, changelink,
>> +				    false, extack);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	if (data[IFLA_VXLAN_GROUP]) {
>> +		__be32 addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
>> +
>>  		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
>>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
>>  			return -EOPNOTSUPP;
>>  		}
>>  
>> -		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
>> +		if ((conf->flags & VXLAN_F_LOCALBIND) && ipv4_is_multicast(addr)) {
>> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "Cannot add multicast group when bound locally");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		conf->remote_ip.sin.sin_addr.s_addr = addr;
>>  		conf->remote_ip.sa.sa_family = AF_INET;
>>  	} else if (data[IFLA_VXLAN_GROUP6]) {
>> +		struct in6_addr addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
>> +
>>  		if (!IS_ENABLED(CONFIG_IPV6)) {
>>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
>>  			return -EPFNOSUPPORT;
>> @@ -4063,7 +4086,12 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>>  			return -EOPNOTSUPP;
>>  		}
>>  
>> -		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
>> +		if ((conf->flags & VXLAN_F_LOCALBIND) && ipv6_addr_is_multicast(&addr)) {
>> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "Cannot add multicast group when bound locally");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		conf->remote_ip.sin6.sin6_addr = addr;
>>  		conf->remote_ip.sa.sa_family = AF_INET6;
>>  	}
>>  
>> @@ -4071,6 +4099,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>>  		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
>>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
>>  			return -EOPNOTSUPP;
>> +		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
>> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "Cannot change local address when bound locally");
>> +			return -EOPNOTSUPP;
>>  		}
>>  
>>  		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
>> @@ -4084,6 +4115,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>>  		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
>>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
>>  			return -EOPNOTSUPP;
>> +		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
>> +			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "Cannot change local address when bound locally");
>> +			return -EOPNOTSUPP;
>>  		}
>>  
>>  		/* TODO: respect scope id */
>> @@ -4517,6 +4551,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
>>  		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
>>  		/* IFLA_VXLAN_RESERVED_BITS */
>>  		nla_total_size(sizeof(struct vxlanhdr)) +
>> +		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBIND */
>>  		0;
>>  }
>>  
>> @@ -4596,7 +4631,9 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>>  	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
>>  		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
>>  	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
>> -		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
>> +		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)) ||
>> +	    nla_put_u8(skb, IFLA_VXLAN_LOCALBIND,
>> +		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBIND)))
>>  		goto nla_put_failure;
>>  
>>  	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
>> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
>> index 0ee50785f4f1..e356b5294535 100644
>> --- a/include/net/vxlan.h
>> +++ b/include/net/vxlan.h
>> @@ -333,6 +333,7 @@ struct vxlan_dev {
>>  #define VXLAN_F_MDB			0x40000
>>  #define VXLAN_F_LOCALBYPASS		0x80000
>>  #define VXLAN_F_MC_ROUTE		0x100000
>> +#define VXLAN_F_LOCALBIND		0x200000
>>  
>>  /* Flags that are used in the receive path. These flags must match in
>>   * order for a socket to be shareable
>> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>> index 784ace3a519c..7350129b1444 100644
>> --- a/include/uapi/linux/if_link.h
>> +++ b/include/uapi/linux/if_link.h
>> @@ -1399,6 +1399,7 @@ enum {
>>  	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
>>  	IFLA_VXLAN_RESERVED_BITS,
>>  	IFLA_VXLAN_MC_ROUTE,
>> +	IFLA_VXLAN_LOCALBIND,
>>  	__IFLA_VXLAN_MAX
>>  };
>>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
>> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
>> index 7e46ca4cd31b..eee934cc2cf4 100644
>> --- a/tools/include/uapi/linux/if_link.h
>> +++ b/tools/include/uapi/linux/if_link.h
>> @@ -1396,6 +1396,7 @@ enum {
>>  	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
>>  	IFLA_VXLAN_LOCALBYPASS,
>>  	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
>> +	IFLA_VXLAN_LOCALBIND,
>>  	__IFLA_VXLAN_MAX
>>  };
>>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
>> -- 
>> 2.36.1


