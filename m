Return-Path: <netdev+bounces-149884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED19E7E6D
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 06:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B918878DF
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 05:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A971B17557;
	Sat,  7 Dec 2024 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D5GE1uWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BD10E0
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733550351; cv=none; b=Lwg2qNuvH1Wqgt/UnBp9UVVnLfkkikrnHKCjA9WvGDWXjzV1ej4g5KAIaJqIKJDbysiG1lEAM8qk6f4tEwXni4T1sjpMqmRW9G+cycoSHAfjGi4LKNmDJrgnTfe1Gy5o9kjCccdxCfQ9dE41l+9fuZleRxmn46wkIwFC4SChP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733550351; c=relaxed/simple;
	bh=TTO3rs+Tq2BdYYFvl+FK6djEajA2C/MCawILVI9rRT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSMj6rNMwh1T/L6NyTdKCYZUEqsg8c1hcDVdtL1xshQ9QnCDxdMVXqHKLp7toWXjjybFDJFBeeNqX7IQvQ923ZJ0Z0WLRGjRkPblpwZjYXvCZFq26qArG6k1dl4J4BXOUDFbnFGmszRZ37xnkLhLsSFWtpGgKU6z55PJ9t/LW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D5GE1uWa; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733550350; x=1765086350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gkHPudAL6tdapHDOk7w29KmEYjpR0mtUpI4DOppjUo=;
  b=D5GE1uWaz3xjkSLJezjn74+XkE7uB/qAHaV4MrLcRGQP0q1+FgNHPWEP
   aeG0T/WsuKjJlq5Kz/y5C7IPbRYAZHgdTY8MtCwnw3w7tDqMxQCPkCrKV
   tU49Dccq+r9RHgFTYexNX8uWhJ6xY62p+QF7m3bDnhdD/3wLPXTFyRvTx
   s=;
X-IronPort-AV: E=Sophos;i="6.12,215,1728950400"; 
   d="scan'208";a="47378789"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 05:45:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:15423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.76:2525] with esmtp (Farcaster)
 id 3d868f4f-740a-4035-bfb6-3a36c0da71e2; Sat, 7 Dec 2024 05:45:46 +0000 (UTC)
X-Farcaster-Flow-ID: 3d868f4f-740a-4035-bfb6-3a36c0da71e2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 7 Dec 2024 05:45:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.240.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 7 Dec 2024 05:45:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<jk@codeconstruct.com.au>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<matt@codeconstruct.com.au>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] mctp: no longer rely on net->dev_index_head[]
Date: Sat, 7 Dec 2024 14:45:35 +0900
Message-ID: <20241207054535.68849-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206223811.1343076-1-edumazet@google.com>
References: <20241206223811.1343076-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  6 Dec 2024 22:38:11 +0000
> mctp_dump_addrinfo() is one of the last users of
> net->dev_index_head[] in the control path.
> 
> Switch to for_each_netdev_dump() for better scalability.
> 
> Use C99 for mctp_device_rtnl_msg_handlers[] to prepare
> future RTNL removal from mctp_dump_addrinfo()
> 
> (mdev->addrs is not yet RCU protected)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Matt Johnston <matt@codeconstruct.com.au>
> ---
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/mctp/device.c | 50 ++++++++++++++++++-----------------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 26ce34b7e88e174cdb6fa65c0d8e5bf6b5a580d7..8e0724c56723de328592bfe5c6fc8085cd3102fe 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -20,8 +20,7 @@
>  #include <net/sock.h>
>  
>  struct mctp_dump_cb {
> -	int h;
> -	int idx;
> +	unsigned long ifindex;
>  	size_t a_idx;
>  };
>  
> @@ -115,43 +114,29 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
>  {
>  	struct mctp_dump_cb *mcb = (void *)cb->ctx;
>  	struct net *net = sock_net(skb->sk);
> -	struct hlist_head *head;
>  	struct net_device *dev;
>  	struct ifaddrmsg *hdr;
>  	struct mctp_dev *mdev;
> -	int ifindex;
> -	int idx = 0, rc;
> +	int ifindex, rc;
>  
>  	hdr = nlmsg_data(cb->nlh);
>  	// filter by ifindex if requested
>  	ifindex = hdr->ifa_index;
>  
>  	rcu_read_lock();
> -	for (; mcb->h < NETDEV_HASHENTRIES; mcb->h++, mcb->idx = 0) {
> -		idx = 0;
> -		head = &net->dev_index_head[mcb->h];
> -		hlist_for_each_entry_rcu(dev, head, index_hlist) {
> -			if (idx >= mcb->idx &&
> -			    (ifindex == 0 || ifindex == dev->ifindex)) {
> -				mdev = __mctp_dev_get(dev);
> -				if (mdev) {
> -					rc = mctp_dump_dev_addrinfo(mdev,
> -								    skb, cb);
> -					mctp_dev_put(mdev);
> -					// Error indicates full buffer, this
> -					// callback will get retried.
> -					if (rc < 0)
> -						goto out;
> -				}
> -			}
> -			idx++;
> -			// reset for next iteration
> -			mcb->a_idx = 0;
> -		}
> +	for_each_netdev_dump(net, dev, mcb->ifindex) {
> +		if (ifindex && ifindex != dev->ifindex)
> +			continue;
> +		mdev = __mctp_dev_get(dev);
> +		if (!mdev)
> +			continue;
> +		rc = mctp_dump_dev_addrinfo(mdev, skb, cb);
> +		mctp_dev_put(mdev);
> +		if (rc < 0)
> +			break;
> +		mcb->a_idx = 0;
>  	}
> -out:
>  	rcu_read_unlock();
> -	mcb->idx = idx;
>  
>  	return skb->len;
>  }
> @@ -531,9 +516,12 @@ static struct notifier_block mctp_dev_nb = {
>  };
>  
>  static const struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
> -	{THIS_MODULE, PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
> -	{THIS_MODULE, PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
> -	{THIS_MODULE, PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
> +	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_NEWADDR,
> +	 .doit = mctp_rtm_newaddr},
> +	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_DELADDR,
> +	 .doit = mctp_rtm_deladdr},
> +	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_GETADDR,
> +	 .dumpit = mctp_dump_addrinfo},
>  };
>  
>  int __init mctp_device_init(void)
> -- 
> 2.47.0.338.g60cca15819-goog

