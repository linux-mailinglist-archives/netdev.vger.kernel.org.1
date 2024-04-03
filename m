Return-Path: <netdev+bounces-84558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93AD8974F1
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26ABB1C27312
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6214B09E;
	Wed,  3 Apr 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJO+bmLs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90293D96B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160798; cv=none; b=qNGbOe6IRbrRHU9rWO/BnCe/Fy/DG9sggzDUcN4QTS8J/PKscQ0tyDF5VVnHGMec/1n1kb1G1B/Nn3hRXgs/X0Je0uG5n+AJZX+PSO7h3cmQun9+2abGHtUJYVegi9FNogVBZaVn6nA87iUucNEJSerm5KflNrsUFroGCOCLmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160798; c=relaxed/simple;
	bh=j6Y2UzrkAo47mJSvwmbI2W9UECLqwDmrOQBflMG9/+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXmpE0OJvTbdWMovdmuYYtNeMvVrH2mjwDu7YD5WJSWqvnIUByhytGptkaobk/kWfWSO2P/zkgTYbACH8o5v2qlB0PEnjljnUivsNh9JDXKvEh28DHb8QFr1knUAkKoWoP4dxTaWFvAygD6s0DUHgPfLbt32wZhTqYi6bAYDito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJO+bmLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45BC433C7;
	Wed,  3 Apr 2024 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712160798;
	bh=j6Y2UzrkAo47mJSvwmbI2W9UECLqwDmrOQBflMG9/+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vJO+bmLs0xAAFQBS5Bd/V5DMi+eauckbzyHTUae3TEWgcmoL3/5jD1QXYwnfAS2Uj
	 CgWJDyLrV2PGj/tEb4yfC/knyAyHUtvb6YBo7YZAKPKW0q2UqZH4n8g1S+W/5w/bVG
	 dm+tKF2yoRryrSyGvTpqov8CcdSsxEhnTK86Jp5p7E/zk2uLewx4PIIBrqZC3yQ1Bu
	 L/s/D4J0i2YzsnCkLhYrFdIRIFC8xyeqgUsjVtel22qSOfipGct6OpWzQSVmAtWX/P
	 IXzr/GNG3vE+LnBlrbil2J26yUZd7yNRGYeHnENDW1qsAncPEjAtWeP0+zLnSE5k5A
	 XDsdPRir2Ve6A==
Message-ID: <67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org>
Date: Wed, 3 Apr 2024 10:13:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: remove RTNL protection from
 ip6addrlbl_dump()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240403123913.4173904-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240403123913.4173904-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 6:39 AM, Eric Dumazet wrote:
> diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
> index 17ac45aa7194ce9c148ed95e14dd575d17feeb98..961e853543b64cd2060ef693ae3ad32a44780aa1 100644
> --- a/net/ipv6/addrlabel.c
> +++ b/net/ipv6/addrlabel.c
> @@ -234,7 +234,8 @@ static int __ip6addrlbl_add(struct net *net, struct ip6addrlbl_entry *newp,
>  		hlist_add_head_rcu(&newp->list, &net->ipv6.ip6addrlbl_table.head);
>  out:
>  	if (!ret)
> -		net->ipv6.ip6addrlbl_table.seq++;
> +		WRITE_ONCE(net->ipv6.ip6addrlbl_table.seq,
> +			   net->ipv6.ip6addrlbl_table.seq + 1);
>  	return ret;
>  }
>  
> @@ -445,7 +446,7 @@ static void ip6addrlbl_putmsg(struct nlmsghdr *nlh,
>  };
>  
>  static int ip6addrlbl_fill(struct sk_buff *skb,
> -			   struct ip6addrlbl_entry *p,
> +			   const struct ip6addrlbl_entry *p,
>  			   u32 lseq,
>  			   u32 portid, u32 seq, int event,
>  			   unsigned int flags)
> @@ -498,7 +499,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  	struct net *net = sock_net(skb->sk);
>  	struct ip6addrlbl_entry *p;
>  	int idx = 0, s_idx = cb->args[0];
> -	int err;
> +	int err = 0;
>  
>  	if (cb->strict_check) {
>  		err = ip6addrlbl_valid_dump_req(nlh, cb->extack);
> @@ -510,7 +511,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  	hlist_for_each_entry_rcu(p, &net->ipv6.ip6addrlbl_table.head, list) {
>  		if (idx >= s_idx) {
>  			err = ip6addrlbl_fill(skb, p,
> -					      net->ipv6.ip6addrlbl_table.seq,
> +					      READ_ONCE(net->ipv6.ip6addrlbl_table.seq),

seems like this should be read once on entry, and the same value used
for all iterations.

>  					      NETLINK_CB(cb->skb).portid,
>  					      nlh->nlmsg_seq,
>  					      RTM_NEWADDRLABEL,
> @@ -522,7 +523,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  	}
>  	rcu_read_unlock();
>  	cb->args[0] = idx;
> -	return skb->len;
> +	return err;
>  }
>  
>  static inline int ip6addrlbl_msgsize(void)
> @@ -614,7 +615,7 @@ static int ip6addrlbl_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  
>  	rcu_read_lock();
>  	p = __ipv6_addr_label(net, addr, ipv6_addr_type(addr), ifal->ifal_index);
> -	lseq = net->ipv6.ip6addrlbl_table.seq;
> +	lseq = READ_ONCE(net->ipv6.ip6addrlbl_table.seq);
>  	if (p)
>  		err = ip6addrlbl_fill(skb, p, lseq,
>  				      NETLINK_CB(in_skb).portid,
> @@ -647,6 +648,7 @@ int __init ipv6_addr_label_rtnl_register(void)
>  		return ret;
>  	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDRLABEL,
>  				   ip6addrlbl_get,
> -				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED);
> +				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED |
> +						    RTNL_FLAG_DUMP_UNLOCKED);
>  	return ret;
>  }


