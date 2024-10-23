Return-Path: <netdev+bounces-138077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A19ABC92
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 06:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8FBB2360B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E013211A;
	Wed, 23 Oct 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NYoPERAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F36CDAF
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656210; cv=none; b=IeqWNiGHXYEvf+45rWkX2tpI11z5pcgWMNNettwefPe+Ie8J5u/2UuEOUWMOboCnN4y4VgoUlk+8o1tQAC3dPfD3SCfQiHG6IfTexITyQRTb0s/7rSaoi7J3byR7NEMqqArGdl1XoqpNETd7MvIawtSMDI4AGamZSWqGdDtorkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656210; c=relaxed/simple;
	bh=FsAgIz1q4+m1exqFalinjNDyQEbXEPLLao3BYn9KDDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhrdqxMIsnbGyw3JNyQUTzTFhyt6K0im/IuaANR8KdQ5+g1JUWXzEksj5dGNmNFdFHB5MbtCTz/Prtt6wT/ADQPYMl0v1PJlXx/fHluEKj1tyCiKB5PxQcLAU0aWl8mvMv8ESnxaMOfjW/wYs6BIDp682K+MRHxOBv19weMdMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NYoPERAd; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729656209; x=1761192209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mw3ZqMysubAbjC4FJMx1+qNRLLExh53ffl3qbSYbsew=;
  b=NYoPERAdsOSNtgsR8WRUCY/AWYKdebaYOU4Wp23g7Rk4lDgsTmcNLIpW
   Q8cscopqJ0xCuKLBYvIPjkvG3/m2dLlnYsoqiuDrbJIhVyRADJbu2AhCR
   KZC8isAr50bQPL2qeemuwJasxtYteE7w8E8VZG4qV7yLkR2gIJSY4doI8
   E=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="241622060"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 04:03:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:4759]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.75:2525] with esmtp (Farcaster)
 id 25cbd051-7921-4c99-ad77-21b292ada71e; Wed, 23 Oct 2024 04:03:22 +0000 (UTC)
X-Farcaster-Flow-ID: 25cbd051-7921-4c99-ad77-21b292ada71e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 23 Oct 2024 04:03:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 23 Oct 2024 04:03:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<idosch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/5] rtnetlink: Add netns_atomic flag in rtnl_link_ops
Date: Tue, 22 Oct 2024 21:03:16 -0700
Message-ID: <20241023040316.28273-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241023023146.372653-3-shaw.leon@gmail.com>
References: <20241023023146.372653-3-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 23 Oct 2024 10:31:43 +0800
> Currently these two steps are needed to create a net device with
> IFLA_LINK_NETNSID attr:
> 
>  1. create and setup the netdev in the link netns with
>     rtnl_create_link()
>  2. move it to the target netns with dev_change_net_namespace()

IIRC, this is to send the notification in the link netns.


> 
> This has some side effects, including extra ifindex allocation, ifname
> validation and link notifications in link netns.
> 
> Add a netns_atomic flag, that if set to true, devices will be created in
> the target netns directly.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  include/net/rtnetlink.h | 3 +++
>  net/core/rtnetlink.c    | 7 ++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index e0d9a8eae6b6..59594cef2272 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -74,6 +74,8 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>   *	@srcu: Used internally
>   *	@kind: Identifier
>   *	@netns_refund: Physical device, move to init_net on netns exit
> + *	@netns_atomic: Device can be created in target netns even when
> + *		       link-netns is different, avoiding netns change.
>   *	@maxtype: Highest device specific netlink attribute number
>   *	@policy: Netlink policy for device specific attribute validation
>   *	@validate: Optional validation function for netlink/changelink parameters
> @@ -115,6 +117,7 @@ struct rtnl_link_ops {
>  	void			(*setup)(struct net_device *dev);
>  
>  	bool			netns_refund;
> +	bool			netns_atomic;
>  	unsigned int		maxtype;
>  	const struct nla_policy	*policy;
>  	int			(*validate)(struct nlattr *tb[],
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ff8d25acfc00..99250779d8ba 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3679,8 +3679,9 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
>  		name_assign_type = NET_NAME_ENUM;
>  	}
>  
> -	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
> -			       name_assign_type, ops, tb, extack);
> +	dev = rtnl_create_link(!link_net || ops->netns_atomic ?
> +			       tgt_net : link_net, ifname, name_assign_type,
> +			       ops, tb, extack);
>  	if (IS_ERR(dev)) {
>  		err = PTR_ERR(dev);
>  		goto out;
> @@ -3700,7 +3701,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
>  	err = rtnl_configure_link(dev, ifm, portid, nlh);
>  	if (err < 0)
>  		goto out_unregister;
> -	if (link_net) {
> +	if (link_net && !ops->netns_atomic) {
>  		err = dev_change_net_namespace(dev, tgt_net, ifname);
>  		if (err < 0)
>  			goto out_unregister;
> -- 
> 2.47.0
> 

